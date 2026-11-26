// Todas as chamadas à API passam por aqui. As telas nunca usam fetch diretamente.
const CHAVE_TOKEN = "instituto_smaniotto_token";
const CHAVE_NOME = "instituto_smaniotto_usuario";

export function lerToken() {
  return localStorage.getItem(CHAVE_TOKEN);
}

export function lerNomeUsuario() {
  return localStorage.getItem(CHAVE_NOME);
}

export function sair() {
  localStorage.removeItem(CHAVE_TOKEN);
  localStorage.removeItem(CHAVE_NOME);
}

async function requisicao(metodo, caminho, corpo) {
  const opcoes = { method: metodo, headers: {} };
  if (corpo) {
    opcoes.headers["Content-Type"] = "application/json";
    opcoes.body = JSON.stringify(corpo);
  }
  const token = lerToken();
  if (token) {
    opcoes.headers.Authorization = `Bearer ${token}`;
  }

  let resposta;
  try {
    resposta = await fetch(`/api${caminho}`, opcoes);
  } catch {
    throw new Error("Sem conexão com o servidor. Verifique se o frontend está rodando.");
  }

  if (resposta.status === 204) return null;

  const dados = await resposta.json().catch(() => null);
  if (!resposta.ok) {
    throw new Error(
      dados?.erro ?? `A API não respondeu (erro ${resposta.status}). Ela está rodando?`,
    );
  }
  return dados;
}

export async function entrar(email, senha) {
  const dados = await requisicao("POST", "/auth/login", { email, senha });
  localStorage.setItem(CHAVE_TOKEN, dados.token);
  localStorage.setItem(CHAVE_NOME, dados.usuario.nome);
  return dados.usuario;
}

// Doadores
export const listarDoadores = () => requisicao("GET", "/doadores");
export const criarDoador = (doador) => requisicao("POST", "/doadores", doador);
export const atualizarDoador = (id, doador) => requisicao("PUT", `/doadores/${id}`, doador);
export const excluirDoador = (id) => requisicao("DELETE", `/doadores/${id}`);

// Itens e doações
export const listarItens = () => requisicao("GET", "/itens");
export const listarDoacoes = () => requisicao("GET", "/doacoes");
export const registrarDoacao = (doacao) => requisicao("POST", "/doacoes", doacao);

// Saúde da API e do banco
export const verificarSaude = () => requisicao("GET", "/health");
