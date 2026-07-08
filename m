Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C4F3ADB9B
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 20:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783542517; cv=none; b=WFPV/VJnuW5M4uUEJMUMGyXNy03c6F/pT1YZxpHflQ8hX/Ng+6Hz6kRfI/6pLH8eDvBLKTxgzsixTpmZ7coGi/dhnAnFWeMODBdsrNfr4mFL97AjtsgVFqUZvbWX5qRd22uVoxeYirzhW03JiTbxzlmk47bG/SlA2sj24oeAWtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783542517; c=relaxed/simple;
	bh=kVeJGY8Xe/cToqlhK9p9Fpk7aqq4/EuWoTM43hRZEdA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y43bEDZ6U6EGknsgWhPjJmJQRJt5qkL5tBNjmprQOFfJokGJm6VUx++aTRbsvAP1AwQsr17h+17Emt7RDNqpG9P6/nAYDPqmT+SywCZonJl6cEgJQmYz/nAwgdYR82AIH+x0OXSBAaIKTs5D+EysDX0796a3vkGBe+A4SCBpBsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojvfKP9f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojvfKP9f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0308F1F000E9;
	Wed,  8 Jul 2026 20:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783542516;
	bh=BQt50OyZ/xENe2H/CeK/FGecxRddgSS7F5zUl+XliR0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ojvfKP9fiCkgnLeQJl/oJg9fOrJobF0t7C7h2lF70CqZO1Kov9fFMgJwgiSvC4BYC
	 1yuxymtMTbvHPbHrUNRxw25bZSLs2BAXfOfJmHlOXcHerjQHCqCpQnmCKu3bO8XZ12
	 /TfgaHDmrthfobNP9m+oJeVXDKGjWsSfKuJhgruYMS9qx4p5NgWXq7+T79TpFn/noq
	 VSUhjGoAzW9N9/AogqQeQFVFlcki788+cZry8fRyggBy574BNT6VQTsn9YRzo0Hhb7
	 muLlAYy1B/2LWUureJMFqLhp/gae55bkyPYwmNYm0yY2QF5FVWdtkeg/P8DoRmnnp3
	 JvDdSUaoaYBkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 08/12] bpf: Enable 16-byte aggregate return
 types
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260708201020.2160131-1-yonghong.song@linux.dev>
References: <20260708200939.2153664-1-yonghong.song@linux.dev>
 <20260708201020.2160131-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 20:28:35 +0000
Message-Id: <20260708202836.0308F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Leaking uninitialized kernel memory via kfunc R2 return register f=
or structs of 9-15 bytes.
--

--- Patch [8]: [PATCH bpf-next 08/12] bpf: Enable 16-byte aggregate return =
types ---
commit 5b4b6cb320ef1b1f82ac557b6f90945992d8a0c5
Author: Yonghong Song <yonghong.song@linux.dev>
Subject: bpf: Enable 16-byte aggregate return types

This patch relaxes btf_distill_func_proto() and btf_validate_return_type()
to allow kfuncs to return by-value structs or unions up to 16 bytes.
This enables the <=3D16 byte aggregate return values end to end.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index dff5c0d916412..bab82d1c8cb98 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7572,7 +7572,12 @@ int btf_distill_func_proto(struct bpf_verifier_log=
 *log,
>  		return -EINVAL;
>  	}
>  	ret =3D __get_type_size(btf, func->type, &t);
> -	if (ret < 0 || btf_type_is_struct(t)) {
> +	/*
> +	 * __get_type_size() already restricts a non-negative ret to void, a
> +	 * pointer, an int, an enum or a struct/union, so only the size is chec=
ked
> +	 * here.
> +	 */
> +	if (ret < 0 || ret > 16) {

[Severity: High]
Can this leak uninitialized kernel memory for structs between 9 and 15 byte=
s?

The x86_64 ABI leaves the unused upper bytes of the %rdx register undefined
when returning a struct that is not a multiple of 8 bytes.

Looking at mark_kfunc_ret_reg_size() in kernel/bpf/verifier.c, if the struct
size is greater than 8:

	if (size > 8) {
		mark_btf_func_reg_size(env, BPF_REG_0, 8);
		mark_reg_unknown(env, regs, BPF_REG_2);
		regs[BPF_REG_2].subreg_def =3D DEF_NOT_SUBREG;
	}

The verifier explicitly marks BPF_REG_2 as fully initialized, bypassing sub=
reg
zero-extension.

And in the x86 JIT do_jit() in arch/x86/net/bpf_jit_comp.c, it moves the fu=
ll
64-bit register:

				fm =3D bpf_jit_find_kfunc_model(bpf_prog, insn);
				if (fm && fm->ret_size > 8)
					emit_mov_reg(&prog, true, BPF_REG_2, BPF_REG_3);

Could a BPF program read the undefined bytes from R2, resulting in an
information leak?

>  		bpf_log(log,
>  			"The function %s return type %s is unsupported.\n",
>  			tname, btf_type_str(t));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708200939.2153=
664-1-yonghong.song@linux.dev?part=3D8
