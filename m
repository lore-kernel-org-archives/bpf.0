Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2237126296
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 04:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786941475; cv=none; b=M5YFN4ptA3Nvq7MvW4sulpEKK2KMljeJHCWd1gspsSU6FMB4Z2il0BIuj8lromzWJrrZokI/T57H9s6JRRYSO3NQLykKyK7vLaQfkpFyPdFWNySTdHFIQNKgzsO7H8jFoDdGKtlE6BRweomwvTCgYQFEH76Vq+m321wxyuHftcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786941475; c=relaxed/simple;
	bh=AYRPWZScc9xbLn24XMNYLfZcvIv7NyuJlqvmsgAPwwI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QO+2T/AD+GkrizOvY55DPLZLWCWtZ15s61SFvSul+CPk9tFn9vX6Dh40lZddBBYt15VyJl6BUKvMVmuRg339d/WQwd1HSnITl3RWiXf85I+YrVGVkWRmP/5e19PARS6jDPeSbCJytpf4TYelLAH74sajfnbY22U85pkPg3vGvws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cH5fzffR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cH5fzffR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D311F000E9;
	Mon, 17 Aug 2026 04:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786941473;
	bh=8aRwbNsz0yuxwv03T0VmljfAyQQSXabU3pz4nMoSVqA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cH5fzffRrNrGc1JQoJY+/R8OTeS4fdSBhlypNKIJpDA2PRGLU4nGRK9uhNA6SxMlY
	 TbCOt+4IJMKQdmDUfp/vPCoxw4D0kH/tnncJLfow6scHdO/W3hs0kRcuITO++N+icB
	 4kLSR8iDOlpXMFk5geHR8WMp/cZ+ByhX46QAlTQvIRkKU2jNdAj2WEVn6GpXbR5d3X
	 n1bIaXibSeYKRxH91g3qau4lIwn2OxoGAG9bLG3ZY3tIVlUk8mtqoGznxiKiHQp1uH
	 mHpKPlNw6Fsb8Q6YFvvdEoaTy0Srdq2tz4FsLppFquVbu3xeqjvr4yyom8VEh74JJl
	 zQpcEloOI7oWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 03/10] bpf: Wire up JIT support for 16-byte
 kfunc returns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260817042156.2287455-1-yonghong.song@linux.dev>
References: <20260817042141.2286086-1-yonghong.song@linux.dev>
 <20260817042156.2287455-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 04:37:53 +0000
Message-Id: <20260817043753.89D311F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The BPF verifier fails to initialize BPF_REG_2 for 16-byte scala=
r kfunc returns, breaking the feature.
--

--- Patch [3]: [PATCH bpf-next v6 03/10] bpf: Wire up JIT support for 16-by=
te kfunc returns ---
commit 70077e00d2d0c46ef0daa85eb2612ed7fbf545ef
Author: Yonghong Song <yonghong.song@linux.dev>
bpf: Wire up JIT support for 16-byte kfunc returns

This commit wires up JIT support for 16-byte kfunc returns in BPF, such as
large structs or 128-bit integers. It adds support to the x86-64, arm64, and
riscv64 JITs to return the second half of the value in BPF_REG_2, and adds
verifier checks to reject larger returns on unsupported architectures.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f1f1268d29c66..54aca6c305061 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -2920,6 +2920,18 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *en=
v, u32 func_id, u16 offset)
>  	err =3D btf_distill_func_proto(&env->log, kfunc.btf, kfunc.proto, kfunc=
.name, &func_model);
>  	if (err)
>  		return err;
> +	if (func_model.ret_size > 8) {
> +		if (kfunc.flags && (*kfunc.flags & KF_FASTCALL)) {
> +			verbose(env, "kfunc %s with >8-byte return is not supported with KF_F=
ASTCALL\n",
> +				kfunc.name);
> +			return -EOPNOTSUPP;
> +		}
> +		if (!bpf_jit_supports_kfunc_ret_reg_pair()) {
> +			verbose(env, "kfunc %s with >8-byte return is not supported by JIT\n",
> +				kfunc.name);
> +			return -EOPNOTSUPP;
> +		}
> +	}

[Severity: Medium]
While this patch adds JIT support and basic verifier checks for >8-byte
returns, does the verifier correctly initialize BPF_REG_2 for 16-byte scalar
returns?

Looking at check_kfunc_call() in kernel/bpf/verifier.c, it seems only
BPF_REG_0 is marked as initialized for scalar returns:

    if (btf_type_is_scalar(t)) {
        mark_reg_unknown(env, regs, BPF_REG_0);
        if (meta.btf =3D=3D btf_vmlinux &&
            (meta.func_id =3D=3D special_kfunc_list[KF_bpf_res_spin_lock] |=
| ...

Since BPF caller-saved registers (including BPF_REG_2) are marked as NOT_IN=
IT
earlier in check_kfunc_call(), a BPF program attempting to access the upper
64 bits of a 16-byte scalar (like an __int128) in BPF_REG_2 would be reject=
ed
with a verifier read error.

Should check_kfunc_call() also initialize BPF_REG_2 when the return size is
greater than 8 bytes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817042141.2286=
086-1-yonghong.song@linux.dev?part=3D3
