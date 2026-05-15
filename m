Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6BC1F1534
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 00:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778805033; cv=none; b=kK7jYMypCGSwEYdrohUEnKOP8MltEn2HQQw4nvEHCGczhHqINLQdMELTPj2erbSG47pUUWuitpsM8W6Dw2QVEYTjwtB8sh2b6U+csybERVfQRIGZj/MQX/D93nVFrpOel2TWoToYOjSdvR3cdW+uJ2hNH+x7yZY+U3UaNTLapk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778805033; c=relaxed/simple;
	bh=JwOSOjoxsiyziC2dARpVDJR/bAfrxryGHae+mH5Ql2I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=obZhOVewn07pZGv660PFwglK73VCEPcAImi79P4S8YEUB4TC0rGAGr/Q6q3uLg7NmP9whDZx8hOoAlXlGgtniG0hmDTF0x5BEkkKpQo0t3PhSOtKBTvL/tajKvb51Lb+aGOGNqsOXdlFw+WTHdoyYdvFT+MMovJ/BmhngdAWotA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdOy2HIg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdOy2HIg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57358C2BCB3;
	Fri, 15 May 2026 00:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778805033;
	bh=JwOSOjoxsiyziC2dARpVDJR/bAfrxryGHae+mH5Ql2I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=QdOy2HIgo05yZCYiP9sz1DtqQ0aTBE/rJBCPnd+iBnaxeXNT/ZN3+HnN83oWkJbnV
	 9/2q0ZaO87tti7dbn9bhMBD2B8ZgceYm5dLsxf1YBg5m/pagn//xJuTdnMNvULKEDe
	 bBsvjp7EdjnU0FJcmnv487hgXeJzGCBsI7urx1bTrSKuYCbCY183BqP4IYnatwSAxb
	 uKlfhxRVUTytkcjjSqXOVpcOnoGTU7sDV5POdLA4B4dLqWRxp8uKOd3zfrZeMSnteL
	 FC3YgLUs4Ear/ochisBc/Kyq0WyQjXzQSaZ8nWPGbGtNKVQQBs0RMb2iZB+rp31kfy
	 o3fg0K6FeTf1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 12/25] bpf: Prepare architecture JIT support
 for stack arguments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260513045054.2390945-1-yonghong.song@linux.dev>
References: <20260513045054.2390945-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 00:30:32 +0000
Message-Id: <20260515003033.57358C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Returning `-EFAULT` for an unsupported JIT feature causes a misl=
eading syscall error.
--

commit 468549a72b25192a0a4df32e6475b6634931dde6
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Prepare architecture JIT support for stack arguments

This commit adds bpf_jit_supports_stack_args() to allow architectures to
indicate support for stack arguments. It rejects BPF functions with more
than 5 parameters at verification time if the architecture lacks this
support.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index ec3fb8c8f4eef..3d8080eba5445 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
[ ... ]
> @@ -7886,8 +7886,14 @@ int btf_prepare_func_args(struct bpf_verifier_env =
*env, int subprog)
>  			MAX_BPF_FUNC_ARGS, tname, nargs);
>  		return -EFAULT;
>  	}
> -	if (nargs > MAX_BPF_FUNC_REG_ARGS)
> +	if (nargs > MAX_BPF_FUNC_REG_ARGS) {
> +		if (!bpf_jit_supports_stack_args()) {
> +			bpf_log(log, "JIT does not support function %s() with %d args\n",
> +				tname, nargs);
> +			return -EFAULT;

Does returning -EFAULT here cause a misleading error for userspace?

The function documentation states that -EFAULT is reserved for internal
verifier bugs to abort verification, while unsupported features or invalid
arguments typically return -EINVAL or -EOPNOTSUPP (which is used elsewhere
in this function for unsupported type tags).

Since returning -EFAULT propagates to the bpf() system call and typically
indicates a bad address, it might confuse userspace loaders like libbpf.
Would -EINVAL or -EOPNOTSUPP be more appropriate here?

> +		}
>  		sub->stack_arg_cnt =3D nargs - MAX_BPF_FUNC_REG_ARGS;
> +	}
> =20
>  	if (is_global && nargs > MAX_BPF_FUNC_REG_ARGS) {
>  		bpf_log(log, "global function %s has %d > %d args, stack args not supp=
orted\n",

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513044949.2382=
019-1-yonghong.song@linux.dev?part=3D12
