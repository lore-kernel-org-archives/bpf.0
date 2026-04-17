Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDFB2AD2C
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 04:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776401355; cv=none; b=b+ckMUV+Jmoks8dW6zof+c3uOJSdPh0p9ajiwgyZH+eO//iMGAXFBXM+H4m8zvbK51/2d2Zh1pxsuTT1bPsFEtvt/ta1GMCY3X95nca8Sx7KwEJ9be37xz3DrEMlbweZI7nhnsK1bJiPC/dGFRlf17ejbkofxvUnGDNZgVmp4+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776401355; c=relaxed/simple;
	bh=f86sC17FpZpvWadzkKNkbPL0MPWNsFd+8L+/b+81lSc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hS5Eb2vi7W4g06swpboVN92EF/VT0Np6u1iXxltzpQ+6JqjIAQkKYxqYPNAg16yZd3btAK2bT8lFRY1RDUszppSAZI4RDkuOc6DH1REYsfl3tS1Te8+ut7xcfGVoJly8V2qVpPYLiOVXxfd9jSx1BXoP7uW/56Lv6c6Mub6AQYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjmPS2wG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjmPS2wG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84018C19425;
	Fri, 17 Apr 2026 04:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776401354;
	bh=f86sC17FpZpvWadzkKNkbPL0MPWNsFd+8L+/b+81lSc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=kjmPS2wGy5g7tQIiL/xobC1GSEQHXU62jOvdda6EPTb4AO/u1yoGHE3fU2hrXM4vB
	 dlcrZoU4iNq0xY5I5UJ6uK8LDDHXPUtEUksE1frtfMDDkOpS2BR3qCU9+g5ue0pqwX
	 tFj9Kow9MweeqFKXxwIG17a8f7Vk/waYC8E3UUBtiNKfV0ctATLFtSevflEXUC6jpY
	 gOSNYSRzdgxx/pjbXHM93TL1xYsAQqMt+Z8RumnYxRNdKYlxSlENcBEv51WaQ/xRTt
	 cifilP6BFAzbc63gwNb7wd5KFpzo/2C8ssQZyaQJU0TThZk3oChlhe1Y7E2GvPA9Yu
	 cfESFVessGy3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 03/16] bpf: Refactor to handle memory and
 size together
Reply-To: sashiko@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260417034713.2627100-1-yonghong.song@linux.dev>
References: <20260417034713.2627100-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Apr 2026 04:49:13 +0000
Message-Id: <20260417044914.84018C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] Incomplete refactoring for stack arguments breaks verifier precisi=
on tracking, marking incorrect registers.
--

commit 7bebb6c179745d67fba0c807428d095b66738135
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Refactor to handle memory and size together

This commit refactors memory and size register handling in BPF helper
verification, passing bpf_reg_state directly to prepare for stack arguments.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2bedaa193d54d..7a7024d94cf00 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -7020,15 +7020,17 @@ static int check_helper_mem_access(struct bpf_ver=
ifier_env *env, int regno,
>  /* verify arguments to helpers or kfuncs consisting of a pointer and an =
access
>   * size.
>   *
> - * @regno is the register containing the access size. regno-1 is the reg=
ister
> - * containing the pointer.
> + * @mem_regno is the register containing the pointer, mem_regno+1 is the=
 register
> + * containing the access size.
>   */
>  static int check_mem_size_reg(struct bpf_verifier_env *env,
> -			      struct bpf_reg_state *reg, u32 regno,
> +			      struct bpf_reg_state *mem_reg,
> +			      struct bpf_reg_state *size_reg, u32 mem_regno,
>  			      enum bpf_access_type access_type,
>  			      bool zero_size_allowed,
>  			      struct bpf_call_arg_meta *meta)
>  {
> +	int size_regno =3D mem_regno + 1;
>  	int err;

Since this refactoring is intended to support stack arguments, does this
hardcoded size_regno =3D mem_regno + 1 break verifier precision tracking?

If the memory pointer is passed in R5, mem_regno is 5, making size_regno 6.

This would cause mark_chain_precision() to incorrectly backtrack the
callee-saved register BPF_REG_6 instead of the stack slot containing the si=
ze
argument.

Furthermore, if mem_regno is later modified to represent a 0-based argument
index, size_regno will evaluate to the wrong register entirely.

[ ... ]
> -	err =3D check_helper_mem_access(env, regno - 1, reg->umax_value,
> +	err =3D check_helper_mem_access(env, mem_reg, mem_regno, size_reg->umax=
_value,
>  				      access_type, zero_size_allowed, meta);
>  	if (!err)
> -		err =3D mark_chain_precision(env, regno);
> +		err =3D mark_chain_precision(env, size_regno);

Does marking the wrong register leave the actual size argument imprecise,
potentially corrupting verifier state pruning and allowing out-of-bounds
memory accesses to bypass verification?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260417034658.2625=
353-1-yonghong.song@linux.dev?part=3D3
