Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2521D3CF207;
	Fri,  5 Jun 2026 19:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780687652; cv=none; b=CyQEOstMoiCv17LkjpTtd5jTkx1C93eEK+22ODB9WqIuqQ/SrS45OdwFAKjrXo0weIvmWKzmR+YjVfx3QetgoVcQKNNdd3GLVAE1yNZr/KHvH97S64LOtRT383eSTejTBgVD2hR+Y7gwtpJ3K4BUVpj6E9a93NsrS7mxNpKcU7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780687652; c=relaxed/simple;
	bh=/58yWT5J97vGCBOROIiEPT33N2oSbxwwiDpxkByq3Kw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=VKgfIj7yC3YG31DdHMyJRytpn6zlT9rCMtFCyX4dpKlAlJeblJ80wBPAq7jxgxC7Ahs5cPsv2EWjtbgXyY9O1iozriyvbzCt8qP9q9Ncr5HFSOWKvEoZ3w9s9mXWlnQoG7bz8hc+ylG1FA8W7CCr6vSxmFlm/pYajqJULDfVF98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBJKmDzC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBJKmDzC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA941F00893;
	Fri,  5 Jun 2026 19:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780687650;
	bh=/n2O4gi2qxDdpTIqdEdvqNru6VXz8pJk0fqv2op1MIw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=DBJKmDzCEKcg3DBHPWyP8Fvc2QZNmftTA8S5sARUbSeMQlHvYuypUesVggGstWm9F
	 l1zkfOyz0Qi2H6vz2V0BT9p5oAMqfT/9EcoDWdLkc3Ie96xWE8I5U+YMxUH9hDPX9R
	 rhErnvC6Ij4Wfx4Yvw+43paEmBVh3ZiDgk7ClYzzWU8n+MsatBASxaCdWskNKxe9Tq
	 pOYfcXhpZVGz4qys4dr5V3LlxgJz2FtVTEsBX62qAaNuBIhF5lFwI/SSdoLqGTb87T
	 nE+xDzbuwD5V9JbhqPmPfebb1BToOViEdtLmV9sABD7Wf/aLMZUhzNOWcsJONpcToT
	 CM2me94iGLwww==
Content-Type: multipart/mixed; boundary="===============0862994116170074596=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <80529e40f2a7d1124be6c9d4c914629fe4bfb64ed2e111a1a23700fe268347b1@mail.kernel.org>
In-Reply-To: <20260605183551.969144-2-ameryhung@gmail.com>
References: <20260605183551.969144-2-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/5] bpf: Fix dead error check on acquire_reference() in check_kfunc_call
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,martin.lau@kernel.org,mykyta.yatsenko5@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  5 Jun 2026 19:27:30 +0000 (UTC)

--===============0862994116170074596==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7d27ba396d32..a741bf447931 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12817,9 +12817,10 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  	struct bpf_kfunc_call_arg_meta meta;
>  	struct bpf_insn_aux_data *insn_aux;
>  	int err, insn_idx = *insn_idx_p;
> -	u32 i, nargs, ptr_type_id, id;
>  	const struct btf_param *args;
> +	u32 i, nargs, ptr_type_id;
>  	struct btf *desc_btf;
> +	int id;
>
>  	/* skip for now, but return error when we find this in fixup_kfunc_call */
>  	if (!insn->imm)

This patch fixes the missing error check in check_kfunc_call(), but
could a similar issue exist in do_check_common() when initializing
struct_ops program arguments?

Looking at do_check_common(), there's a similar pattern where
acquire_reference() is called:

kernel/bpf/verifier.c:do_check_common() {
    ...
    for (i = 0; i < aux->ctx_arg_info_size; i++)
        aux->ctx_arg_info[i].ref_id = aux->ctx_arg_info[i].refcounted ?
                                      acquire_reference(env, 0, 0) : 0;
    ...
}

Since acquire_reference() can return a negative error like -ENOMEM,
assigning it directly to aux->ctx_arg_info[i].ref_id (which is a u32)
without checking for errors would swallow the error code.

Does this allow the verifier to successfully accept a BPF program without
tracking the reference, potentially leading to a kernel resource leak when
the reference isn't released at runtime?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27034008594
--===============0862994116170074596==--
