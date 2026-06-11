Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2575526ACC;
	Thu, 11 Jun 2026 10:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781175280; cv=none; b=NkFetr046VatS+YWkwyX9a14j/JH9kJKRUu5sSY9PW2WtSsLMrr1vMshXbMlObzKRDKFxqktN1JQKKIQnRopF6AwXhWsstAabZtMZUjQ2UCrjuePVURtNBSqFkG8w0MVB0QMALoX9V0QtdddggW8brdez8qPV0wTMoZ0yLpTKWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781175280; c=relaxed/simple;
	bh=m9C5zkzEn1+HIhV0z4c8TPXvSYgZCoWfpWUvDwLpi/8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=sDNJYkt+popVOG+MGL7yJqyl6e61rrsreY9KZdBR3xaaEbT4EmQ0Zf2Sufyxt2YpQIIfHCdaHjCXHhn5HPcV0Tn0Yf/EYY+eFGXvJkR232WVI1b75hUNkw+KkaIyq0qgVaamyWsPP9MU9p0ceuMKevn7Fk2dAt9dEVyFuhqrH10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJt6Zknp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJt6Zknp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E63E1F00893;
	Thu, 11 Jun 2026 10:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781175278;
	bh=6FEewYXxSYpIOqUrGMNhQJoQtGWtK+rarKOnIKygYs0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=RJt6ZknpHCJHbGa4j9SLDjW+PGsPlrfS2Tn3lbXnqG73HjV1fy9BUYyb3QXAsxrQf
	 etB6SXb0xWyF6KuH1YtHhaexD73xA9ZdXw3z/RwLvwI2da85HxrsdXrBQgJ1WK1udw
	 9RQJXQ+P3zPBNODQO9XJSkEoupzinZ2dGU7HK43gsxgsyp/82kX0Y9ORS88dJBpqG+
	 ay5NUYoSJow80hSwuRr0G3oiFdB2Ia3cfaimYN7K3+pIQA6TUyhhBc5PjcQbGmK6ks
	 l56T3iuM9aNJb5nrhRaN0KkODK09S/iu1de/BcQ78Ll3vLfaWQvlDPGe/+jgGJZlA1
	 CQ5pPWyjgLebA==
Content-Type: multipart/mixed; boundary="===============0996543240632847732=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cc40d131145e6dee4d8b34b51a5612afa7286af59c44fa7710a512445a6078d6@mail.kernel.org>
In-Reply-To: <20260611101216.30153-1-yangtiezhu@loongson.cn>
References: <20260611101216.30153-1-yangtiezhu@loongson.cn>
Subject: Re: [PATCH bpf-next v2] bpf: Fix unaligned interpreter panic on JIT fallback path
From: bot+bpf-ci@kernel.org
To: yangtiezhu@loongson.cn,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: puranjay@kernel.org,loongarch@lists.linux.dev,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 11 Jun 2026 10:54:38 +0000 (UTC)

--===============0996543240632847732==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 649cce41e13f..5785c8cb4dbe 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2608,6 +2608,31 @@ static struct bpf_prog *bpf_prog_jit_compile(struct bpf_verifier_env *env, struc
>  	return prog;
>  }
>
> +/* Fix up helper call offsets for inlined helpers on JIT fallback path. */
> +static void bpf_fixup_fallback_inline_helpers(struct bpf_verifier_env *env, struct bpf_prog *fp)
> +{
> +	struct bpf_insn *insn = fp->insnsi;
> +	const struct bpf_func_proto *fn;
> +	int i;
> +
> +	if (!env || !env->ops->get_func_proto)
> +		return;
> +
> +	for (i = 0; i < fp->len; i++, insn++) {
> +		if (insn->code == (BPF_JMP | BPF_CALL) && insn->src_reg == 0) {

Would it be cleaner to use bpf_helper_call(insn) here instead of the
manual condition check?

The bpf_helper_call() helper from include/linux/bpf_verifier.h performs
the same check and is used throughout the codebase for consistency. It
improves readability and makes the intent more explicit.

> +			/* Filter out already-patched address offsets. */
> +			if (insn->imm >= __BPF_FUNC_MAX_ID)
> +				continue;
> +
> +			if (bpf_jit_inlines_helper_call(insn->imm)) {
> +				fn = env->ops->get_func_proto(insn->imm, env->prog);
> +				if (fn && fn->func)
> +					insn->imm = fn->func - __bpf_call_base;
> +			}
> +		}
> +	}
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27340034854
--===============0996543240632847732==--
