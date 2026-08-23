Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF51F233929;
	Sun, 23 Aug 2026 20:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787517611; cv=none; b=PjWszsvqjenHjvYzSFIhH7jlpe7KjVitQAwox5LlrRSglgq8URtyh9beq1F3bDwrONr9/A9FzGRrEHPDmArLvPls7FP5GvzZoLS1aAmOdzZfeUoZLyk79IPwv4DEztWeP6EtJLFmpw5hn61j5smEOUe4y+A22EAAXO5G7lk3p7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787517611; c=relaxed/simple;
	bh=inLkKLRyZxghm81mcOWQIbHaxEJw3JSxF7zuxmX0+hI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lY6/Am60BG+dM5xZHWAvTNxmYbkE8sVLbdRDzXkv6exfTT06U4XqLdS+Og/3VUnTv8IRT1N8j7o8DJB/TJZ57rvXZu1+FRaYeKxnlh1ydFF2AbN0e8whc8I+MRCTkHxlWP4LOLRcghs0TUlNTKGGXIjILn4K7uI/sOJKGiu0hD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=SB2ivEmU; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="SB2ivEmU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KFStYUHlDF3EUq36GFJXNcRflZtsW7zKhFe264ncgjA=; b=SB2ivEmUQ0mf/3oSZ551ofjnGs
	oq8SJbE4rwKjsMQxIF5RoFRApNuyNlCPAoYxk1RySi942Md3IUrGPkkRJCOX9JWGwXMpDrM3QETUo
	C1O7FJBHfrQMbbPq88g9xOQehkjOapRm1oDmQe/FlnJLba3G+gEy6zbJLnq8JlfTYc41DnNsjhrfN
	9UJ3/sFmg23hi1ztSOvLN/x9W/ICFnoWEACE+j3v7Rmvei3+FIzb3uQ1kigQHd+XtqD+L0uTnT6X8
	19SY64dqu7yWquXq3jpulaP4IYJifx9venM+cdQQcTkB1H8j01VY9XGaXpztAXVgJrJ5lCrmwp7Y+
	1vWNEC7w==;
Received: from [151.115.150.205] (port=39244 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1wyEz9-00000006zla-49BU;
	Sun, 23 Aug 2026 22:40:08 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Subject: [PATCH] bpf, x86: Sign-extend narrow signed kfunc returns
Date: Sun, 23 Aug 2026 20:39:45 +0000
Message-ID: <20260823203944.2084994-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

bpf_res_spin_lock() returns a 32-bit int. On failure, the verifier
models R0 as a signed 64-bit value in [-MAX_ERRNO, -1].

On x86-64, returning -EDEADLK writes 0xffffffdd to EAX and clears the
upper half of RAX. Since the JIT leaves the native return value as-is,
BPF sees 0x00000000ffffffdd instead of the sign-extended
0xffffffffffffffdd. A 64-bit signed comparison therefore treats the
value as positive, while the verifier treats it as -35.

As a result, a signed comparison against zero can take one path during
verification and another at run time. With rqspinlock aliases, this can
lead to unmatched bpf_res_spin_unlock() calls, corrupting the per-CPU
rqspinlock state and unbalancing the preemption count.

Use the kfunc's BTF model to sign-extend signed 8-, 16-, and 32-bit
returns into R0 after the native call.

Fixes: 0de2046137f9 ("bpf: Implement verifier support for rqspinlock")
Assisted-by: Codex:gpt-5
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 arch/x86/net/bpf_jit_comp.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 1a9fb530adc3..713ac70613ff 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1726,6 +1726,23 @@ static int emit_kfunc_arena_args(struct bpf_prog *bpf_prog,
 	return prog - start;
 }
 
+static int emit_kfunc_return(const struct bpf_prog *bpf_prog,
+			     const struct bpf_insn *insn, u8 **pprog)
+{
+	const struct btf_func_model *fm;
+
+	fm = bpf_jit_find_kfunc_model(bpf_prog, insn);
+	if (!fm)
+		return -EINVAL;
+	if (!(fm->ret_flags & BTF_FMODEL_SIGNED_ARG) || fm->ret_size == 8)
+		return 0;
+	if (fm->ret_size != 1 && fm->ret_size != 2 && fm->ret_size != 4)
+		return -EINVAL;
+
+	emit_movsx_reg(pprog, fm->ret_size * 8, true, BPF_REG_0, BPF_REG_0);
+	return 0;
+}
+
 static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 		  u8 *rw_image, int oldproglen, struct jit_context *ctx, bool jmp_padding)
 {
@@ -2664,6 +2681,11 @@ st:			insn_off = insn->off;
 			ip += x86_call_depth_emit_accounting(&prog, func, ip);
 			if (emit_call(&prog, func, ip))
 				return -EINVAL;
+			if (src_reg == BPF_PSEUDO_KFUNC_CALL) {
+				err = emit_kfunc_return(bpf_prog, insn, &prog);
+				if (err)
+					return err;
+			}
 			if (priv_frame_ptr)
 				pop_r9(&prog);
 			break;
-- 
2.47.3

