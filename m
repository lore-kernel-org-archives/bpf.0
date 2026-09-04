Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAE93D6664
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 05:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788499507; cv=none; b=H3CEG/48Wg82rlaryZCPX44RIhVCMsGIrmvsHXuRkAXpZm12BWCFuabee/9foGY5tacGCjr471U2bmky/piuORGiBVjwSjyiFk9BUw6S2Ed/1kExvFtOSjExl2n/40bgm/h2awAjG2FUy+LLkD0Euukl/vMMRhw2gWhQ8lRvFc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788499507; c=relaxed/simple;
	bh=4a5NXA9NK17mGf1y16akhZP3Ylj3QqEbkx6vmWjlhQM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TcRfhLlyJgfERzRHaJpw4vcUCSkN/nW07zYgasQw8cOR8bha9zz0Xc5SqtUUHbd5Et3ZSirrmpdQpmiEvPZfjjbDgZuya9uwhgJwo+NQ5J/o3rUEBwp0hjEXRI42TdW3drf+Bk75v4cy5R2dNZs2y+2CxvzSvbXRfxBIIWoomn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VB/MyiHl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VB/MyiHl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF05D1F00AC4;
	Fri,  4 Sep 2026 05:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788499506;
	bh=Yv+kOvQhId8MAL4e6R1BjkMMWwaW9CFFT5/xGky016w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VB/MyiHlTR4KQEQB4PwW0vQUu9IYaIybitMWIwCufMg8YRKs06URBAOCc6yquse9X
	 dJXUtJBDQbIJDhFQR7EbC2Wesdy1clBkGLXrR0dUWEfn3Xfhdivi9tfD6JfjVsGVpU
	 GNMLcmAAcgRA8WByqUNUZ0nejdTaCoSlto1kAMULIZkPT70wiJEA4QRmyC4skcNYJt
	 eEEHVr+kYTeHtqqhXYuhWUyv14nXmozwzxrscPLhLVq+DT2ccruMam7gMjbfeykh8c
	 G2JfOIsNInXqONVsA/nJBA3+YLIzc2ES61UoX1769pyA30FgjfgTLyH8135xWGI0KS
	 aXY57cG4Q0N3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 06/12] bpf: Add a JIT helper for the outgoing
 stack of kfunc calls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260904051028.3979694-1-yonghong.song@linux.dev>
References: <20260904050957.3976119-1-yonghong.song@linux.dev>
 <20260904051028.3979694-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 05:25:05 +0000
Message-Id: <20260904052505.DF05D1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] An out-of-bounds write occurs in `btf_prepare_func_args` when proc=
essing a BPF subprogram with arguments that consume 11 slots followed by a =
final 16-byte struct argument.
--

commit d1c6556d5925344f81e73a6b534000285b7cee65
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Support by-value struct arguments up to 16 bytes

This commit adds support for global functions taking a struct or union by
value up to 16 bytes. It handles structs passed in consecutive registers
or split across registers and the stack, computing the necessary argument
slots. The stack argument count is then recomputed based on the slots
consumed to ensure proper JIT support checks.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 22828b489b778..dbd64cee1b27a 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -8103,6 +8103,14 @@ int btf_prepare_func_args(struct bpf_verifier_env =
*env, int subprog)
>  	for (i =3D 0, slots_used =3D 0; i < nargs; i++) {
>  		u32 tags =3D 0;
> =20
> +		if (slots_used >=3D MAX_BPF_FUNC_ARGS) {
> +			if (!is_global)
> +				return -EINVAL;
> +			bpf_log(log, "Arguments of %s() need more than %d argument slots\n",
> +				tname, MAX_BPF_FUNC_ARGS);
> +			return -EINVAL;
> +		}
> +
>  		err =3D btf_scan_decl_tags(env, btf, fn_t, i, is_global, &tags);
>  		if (err)
>  			return err;

[ ... ]

> @@ -8231,6 +8239,31 @@ int btf_prepare_func_args(struct bpf_verifier_env =
*env, int subprog)
>  			sub->args[slots_used++].arg_type =3D ARG_ANYTHING;
>  			continue;
>  		}
> +		if (btf_type_is_struct(t)) {
> +			u32 nslots;
> +
> +			if (!t->size || t->size > 2 * BPF_REG_SIZE) {
> +				if (!is_global)
> +					return -EINVAL;
> +				bpf_log(log,
> +					"Arg#%d type %s in %s() has size %u, only 1 to %d bytes "
> +					"can be passed by value\n",
> +					i, btf_type_str(t), tname, t->size, 2 * BPF_REG_SIZE);
> +				return -EINVAL;
> +			}
> +			if (!btf_struct_is_composed_of(env, btf, t, BTF_MEMBER_SCALAR)) {
> +				if (!is_global)
> +					return -EINVAL;
> +				bpf_log(log, "Arg#%d type %s in %s() is not composed of scalars\n",
> +					i, btf_type_str(t), tname);
> +				return -EINVAL;
> +			}
> +
> +			nslots =3D (t->size + BPF_REG_SIZE - 1) / BPF_REG_SIZE;
> +			while (nslots--)
> +				sub->args[slots_used++].arg_type =3D ARG_ANYTHING;

[Severity: High]
Does this loop write beyond the end of the sub->args[] array?

If a non-global BPF subprogram has arguments consuming exactly 11 slots,
slots_used >=3D MAX_BPF_FUNC_ARGS evaluates to false (11 >=3D 12) at the st=
art
of the loop, allowing it to proceed.

When a final 16-byte struct argument follows, nslots is set to 2. This
while loop then writes to sub->args[11] and subsequently out-of-bounds to
sub->args[12].

Could this memory corruption overwrite the adjacent stack_arg_cnt and
max_out_stack_arg_cnt fields in struct bpf_subprog_info?

On big-endian architectures, this might artificially inflate
max_out_stack_arg_cnt to 9 (the value of ARG_ANYTHING), causing the
verifier to subsequently reject valid BPF programs in
check_outgoing_stack_args(). On little-endian architectures it would
silently zero the field.

> +			continue;
> +		}
>  		if (!is_global)
>  			return -EINVAL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904050957.3976=
119-1-yonghong.song@linux.dev?part=3D6
