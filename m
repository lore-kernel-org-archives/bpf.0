Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8258E3CC7F8
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 06:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787120267; cv=none; b=Ri8NgIFopxHyxG/TqgW22rBxeeew78GDfwsZ21LkVUG2Xv9XfqNWRg5kHOXiSjw0DPBH6YUwVEOdBjv75tj83Sg6ui1FyTb8BzCuKRQsmRfthwW4b00lATCMDcObkmty9o8CGjKbIBB/WNxRfaYOkVVTzXNwY+g9+Pvw18oQRvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787120267; c=relaxed/simple;
	bh=7rEgQT4KnvArVBLmDSqTnM6xJbGO90jc3R+drbYDQPs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Lm67ma5WD33YMLPw3P8t4sj89y4L7u6nC/izbERlsORQFxUjsD7sSLn91ZxkfLyV77E1VgfQewqJo+2fjeNx52uUo4mMvX9vNgHncafpM+4OjFsL1N0dxjj8hoOzQATM1flyMsc6XSUyVpS0EaAGV3bSduJwjP2y0gAWIGCj6fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJajv2Qu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJajv2Qu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFE71F00A3A;
	Wed, 19 Aug 2026 06:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787120266;
	bh=hl1JkkdCXGKPB/lBhqax/Vi6VitSuZieAqNf/JMenfo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CJajv2QuanY/t9f+GjkPKiymsoZVhEb4WWm4JtvM32i3f7//tAZuk73ZOgfYsOg9S
	 q7ytubQcr72ArvWY4RcLXHPjgJGzRGoLYhdQalb/sT/AtgoPJWLlUW5IQD64c+w77W
	 ZYL1Lpjg7g9nuJ5DnFZyZrKffROg6+QYOTeBRmFPBKOg0qKh+hCzBl0yfLK97F9dm9
	 SJJoH3K9tXQ4Aj2TEWR+uU337AXDEgbZ93WZykVUB2XYgyDiWqbAuJ3HlkY48QtJYe
	 lBqWQTpCSPzAXxcfzmssGec5q+zSX+zKRhsA0sNOgj+vJcB1IPkN2NSM12vIdzXNN3
	 7Nagw4IxzaYLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v7 02/10] bpf: Add helpers to describe the
 R0:R2 return register pair
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260819055249.3295283-1-yonghong.song@linux.dev>
References: <20260819055239.3293449-1-yonghong.song@linux.dev>
 <20260819055249.3295283-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 06:17:45 +0000
Message-Id: <20260819061746.0DFE71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Extension programs (BPF_PROG_TYPE_EXT) are mishandled because `bpf=
_compute_subprog_ret_regs` skips subprog 0, failing to set up `ret_reg_pair=
`.
--

--- Patch [2]: [PATCH bpf-next v7 02/10] bpf: Add helpers to describe the R=
0:R2 return register pair ---
commit f6c1f4f14c6e8bda9545fe1b82f42648b4f3c475
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Add helpers to describe the R0:R2 return register pair

This commit adds bpf_ret_reg_pair() to determine if a BPF subprogram returns
a value in the R0:R2 register pair. It implements
bpf_compute_subprog_ret_regs() to compute this flag based on the BTF
prototype of each subprogram, intentionally skipping the main program.

Link: https://github.com/llvm/llvm-project/pull/190894
Link: https://github.com/llvm/llvm-project/pull/206876

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d8bf897460eae..2b5e88fdda07e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> +static int bpf_compute_subprog_ret_regs(struct bpf_verifier_env *env)
> +{
> +	const struct btf *btf =3D env->prog->aux->btf;
> +	const struct btf_type *type;
> +	int subprog;
> +	u32 size;
> +
> +	if (!env->prog->jit_requested || bpf_prog_is_offloaded(env->prog->aux))
> +		return 0;
> +
> +	/*
> +	 * Skip the main program: its return value is the program's exit code,
> +	 * read out of R0, so it never uses the register pair. An extension does
> +	 * have a real prototype for subprog 0, but bpf_check_attach_target()
> +	 * refuses to replace a function returning more than 8 bytes.
> +	 */
> +	for (subprog =3D 1; subprog < env->subprog_cnt; subprog++) {

[Severity: High]
Does this code mishandle extension programs (BPF_PROG_TYPE_EXT)?

The comment mentions that bpf_check_attach_target() refuses to replace a
function returning more than 8 bytes. However, for extension programs,
prog->expected_attach_type is 0, so attach_uses_trampoline_retval(0) evalua=
tes
to false, bypassing the size check.

If an extension program successfully attaches and replaces a subprogram
returning an __int128 (16 bytes), skipping subprog 0 here means ret_reg_pair
won't be set. Could this result in the verifier failing to enforce the
initialization of R2, potentially leaking uninitialized register contents to
the caller?

> +		type =3D subprog_ret_type(env, subprog);
> +		if (!type || btf_type_is_void(type))
> +			continue;
> +		if (verifier_bug_if(IS_ERR(btf_resolve_size(btf, type, &size)), env,
> +				    "cannot size return type of subprog %d", subprog))
> +			return -EFAULT;
> +		if (ret_regs_cnt(size) > 1) {
> +			subprog_info(env, subprog)->ret_reg_pair =3D true;
> +			env->prog->jit_required =3D 1;
> +		}
> +	}
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819055239.3293=
449-1-yonghong.song@linux.dev?part=3D2
