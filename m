Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3C33C5827
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 06:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787120005; cv=none; b=BDocV81YJsnGj4Oip+6tJZHvmLQEZBNYNURU4ODkRFbmSQDAhlCFgZ3WdbprRn9O5VW1OARUY40gyfbhaaG3LXroLkyQG4A6TiXahnxWYGh+NOmBwVogl3SEEGq3CIiEEJnuUPcRYk9HBud+RAyIz44xv7Zgvn9htkqXdu6iOEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787120005; c=relaxed/simple;
	bh=/IfDVbh3uB7J8XDGBVF8bYinXbLw14Z7FS/cKAjN9Qk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YGM391NYSv1nflimf0xvAdDNFqC3G5AiKYzoSuNgsAUTCDno503fPb71DVGT+LZiYmekT8eF0FFVXZbWnuEQ/UnBeTzyKWmfLHpTXcdPCL9O6CkGZJeTH/kqW9F7/oRv4raLVVJ8rsrN3j+QnLZeCoggvQqZkUaXF/+F7LS0fT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlAGQOkT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlAGQOkT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C1A1F000E9;
	Wed, 19 Aug 2026 06:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787120003;
	bh=wn/PYo59DURGprzjd7xiAYkmDA5bMyLgbHIqfOU0ZMM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WlAGQOkTXAE9ejn51s/8EV4/FPO0Pd8HT8keKMNg4wMQtqMzE/yBOI/WT7U+MTHH5
	 cUBAVn1s4obPgaWfbzuW/eQ5RLWGUBYR4+KnbG+8+8gJlGpXxCxABz+2OLsFyfjkHn
	 qG3MXA9Nc0iUyswJ3EuNYl284QvI1jn4fK48INLzLR5Ju/zPQ3eJmgpFmFAnKsPR7N
	 oXOfN1+eu9Es8cxvS3hDxH77Z0SK5i0ATqS6Yoze/iitAq7Iuru2lma3Sk3T9m1tAg
	 mx8Pb6+Kde6avWEgFSWSO1MjHYIk/bHVZxxGMH8rCrg1YgdO2Z+lnV5w8+m51IvVZE
	 TcQ9pZt2TWcVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v7 07/10] bpf: Enable aggregate return types up
 to 16 bytes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260819055314.3298664-1-yonghong.song@linux.dev>
References: <20260819055239.3293449-1-yonghong.song@linux.dev>
 <20260819055314.3298664-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 06:13:23 +0000
Message-Id: <20260819061323.66C1A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] BPF extension programs (BPF_PROG_TYPE_EXT) bypass return value ver=
ification for BPF_REG_2 when replacing a function that returns a 16-byte st=
ruct, allowing uninitialized memory or kernel pointers to leak.
--

--- Patch [7]: [PATCH bpf-next v7 07/10] bpf: Enable aggregate return types=
 up to 16 bytes ---
commit 19d85b11c1fe37fb0f420056e54cf29ffa04a0bb
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Enable aggregate return types up to 16 bytes

Relax btf_distill_func_proto() to accept a by-value struct or union that
the R0:R2 convention added in earlier patches can carry.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 5e9f6a4875244..58b81c6f5288c 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
[ ... ]
> @@ -7993,6 +7993,19 @@ static int btf_validate_return_type(struct bpf_ver=
ifier_env *env, struct btf *bt
>  	if (btf_type_is_void(t) || btf_type_is_int(t) || btf_is_any_enum(t))
>  		return 0;
> =20
> +	if (btf_type_is_struct(t) && t->size <=3D 16) {
> +		/*
> +		 * A global function's caller models the return as an opaque
> +		 * scalar pair, so it may only return scalars by value. A local
> +		 * function is verified inline, so a pointer field stays tracked
> +		 * and needs no such restriction.
> +		 */
> +		bool local_func =3D subprog && !is_global;
> +
> +		if (local_func || btf_type_is_scalar_struct(env, btf, t, 0))
> +			return 0;
> +	}
> +
>  	return -EOPNOTSUPP;
>  }

[Severity: High]
Does this allow BPF_PROG_TYPE_EXT extension programs to bypass return value=
=20
verification for BPF_REG_2?

Since this patch enables global functions to return structs up to 16 bytes,=
 a
BPF_PROG_TYPE_EXT program can now replace such a function. This is allowed =
by
bpf_check_attach_target() because attach_uses_trampoline_retval() is false =
for
extension programs.

However, during verification of the extension program,
bpf_compute_subprog_ret_regs() explicitly skips subprog 0 (the extension
program itself), which leaves ret_reg_pair as false:

kernel/bpf/verifier.c:bpf_compute_subprog_ret_regs() {
	/*
	 * Skip the main program: its return value is the program's exit code,
	 * read out of R0, so it never uses the register pair. An extension does
	 * have a real prototype for subprog 0, but bpf_check_attach_target()
	 * refuses to replace a function returning more than 8 bytes.
	 */
	for (subprog =3D 1; subprog < env->subprog_cnt; subprog++) {
        ...
}

Because ret_reg_pair is false, process_bpf_exit_full() later invokes
check_return_code(..., BPF_REG_0) for subprog 0 instead of checking the full
register pair. Could this fail to validate R2 on exit, potentially allowing=
 an
uninitialized or sensitive kernel pointer to leak to the caller?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819055239.3293=
449-1-yonghong.song@linux.dev?part=3D7
