Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F88C2F84F
	for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 17:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776618391; cv=none; b=jpXCltZl/+7KK0AfhTHpRPPvs4k7K6dHbuNuyCz0UtmMXWKxUeQp5nSmrb0DIUAWxowjwyNBBaevwaNTnfZk6XLYiUwxYsYo3c0WK3HHvc+p27oItH0M4azGjA3ukIOE+iNim1n3CoMKN6UFEQoS0L85KHermDPivIVKwV1pECM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776618391; c=relaxed/simple;
	bh=wZPxKtS7cqqB01G1q1NAgrzOHLFd+yHB4g+rdYLg4e8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ebmWe9NRKEwyUbnwvfh0lJrzvLu2h9q77wxlGJQ78nS0dZJTDiJ7HcFWskeyiajsrRYMszZlA3ED/qjAS8F6s0Ai7KfLC5qisHBFNwC/aMWlMzQU9AztQUONiLy6bj/6ol1PUqKO5rSCtjb+K27GgQcxY9WkmSPQ0rk2Wck+xTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mp+D1vtM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mp+D1vtM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D877EC2BCAF;
	Sun, 19 Apr 2026 17:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776618391;
	bh=wZPxKtS7cqqB01G1q1NAgrzOHLFd+yHB4g+rdYLg4e8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=mp+D1vtM8vK2NV3h4LEz0bw7d+0rY7o7ZzRhz+op7Oakmm6Vt9CRVsL9EgZCOILYZ
	 YZqiyxYRi4bld6eoxRRuewmxvY/T1auJGBlbunZ/4Xtn9/sxoBkSLGTTUHze9AZ3VC
	 NmXJo13/GEHOk1woZdcG/3CTaFk/a9mDsgyb6ORq+hkJn3xEqPfmRB9DeSgIbUpokt
	 qgPWRE+/PWGUCGJ62zpXY5Mx2eUl6fqevqiPXaurRyr10GQOrH4uelVQPPOYwWy0mv
	 nCxT5BDd28SugpenGsQiRiRnVbgRccPdH9FLf/4oAkBTZ4YL2rOGhVsQWBiDifOnqs
	 9mjgrcpWnji9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 05/17] bpf: Introduce bpf register
 BPF_REG_PARAMS
Reply-To: sashiko@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260419163342.733840-1-yonghong.song@linux.dev>
References: <20260419163342.733840-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Apr 2026 17:06:30 +0000
Message-Id: <20260419170630.D877EC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Critical] Unvalidated BPF_REG_PARAMS instructions cause silent register =
aliasing and arbitrary kernel memory corruption on architectures lacking st=
ack argument support.
--

commit 9b78142c31c81cff58a84123ee2833f9b935c211
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Introduce bpf register BPF_REG_PARAMS

This commit introduces BPF_REG_PARAMS as a dedicated BPF register for stack
argument accesses, occupying BPF register number 11 (R11). It shifts the
kernel-internal hidden register BPF_REG_AX to slot 12.

> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 1ec6d5ba64cc4..b77d0b06db6eb 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -58,8 +58,9 @@ struct ctl_table_header;
>  #define BPF_REG_H	BPF_REG_9	/* hlen, callee-saved */
> =20
>  /* Kernel hidden auxiliary/helper register. */
> -#define BPF_REG_AX		MAX_BPF_REG
> -#define MAX_BPF_EXT_REG		(MAX_BPF_REG + 1)
> +#define BPF_REG_PARAMS		MAX_BPF_REG

Does the introduction of BPF_REG_PARAMS without JIT-support validation allow
architectures lacking stack argument support (like ARM64, RISC-V, s390x) to
inadvertently use uninitialized JIT register mappings?

If the verifier doesn't gate BPF_REG_PARAMS usage behind a check like
bpf_jit_supports_stack_args(), could a crafted program trigger silent
register aliasing?

For example, if a program sets BPF_REG_1 to an arbitrary kernel address and
executes BPF_STX_MEM(BPF_DW, BPF_REG_PARAMS, BPF_REG_2, -8), the verifier m=
ay
allow it as a safe outgoing stack argument write. When the ARM64 JIT compil=
es
the instruction, it looks up index 11. If that index is uninitialized and
defaults to 0, it would emit a store using x0 (which is BPF_REG_1) as the
base pointer (e.g., STR x1, [x0, #-8]).

Could this write an arbitrary value into a controlled kernel address and
bypass verifier memory safety guarantees?

> +#define BPF_REG_AX		(MAX_BPF_REG + 1)
> +#define MAX_BPF_EXT_REG		(MAX_BPF_REG + 2)
>  #define MAX_BPF_JIT_REG		MAX_BPF_EXT_REG

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419163316.7310=
19-1-yonghong.song@linux.dev?part=3D5
