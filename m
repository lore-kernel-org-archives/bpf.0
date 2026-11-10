Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318707;
	b=hVcmXCb9MnInx3oNd8L5UPR2BKfMaAeiMcgiEVWyM4wnmp45QlAvyYbSfvhdamEyJn6i
	 PO9RnaNcStGyCv0zAzU1VbqRjl/cSWf5N6YRhzVx4WxtnMmAw6SwroWEi7dr5GqbaMMv0
	 djALbNUlX23S2OFMeEeGb4aaZEWSOKBwZN3h5LDXY3gKu0/k8aseWniOfxOmWZ/5ETyrV
	 gCcOjVGuhLjshmfrQRjqhbV4MNcWbb233BPikUed/TP7b/iaZdoUn2xtawJpMZbBMm1Fw
	 U6XuiwftIYTW6cFYMOk9KScn+4UhIXVDkasfZ5vzQtQtRnZ9i2U4ORFGKDGkl8C+7fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318707;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DgMB87bjjOhJubk+hnBQVvUaHtmOByTmAGnQuDuOPkc=;
	b=uVfbG7lzFZTKwJ1oRQQWEx67TYtpN5NsADfg82sD9/bD8VB0G5wtrmw1mpltS/9aEg2u
	 gLRPqOT+pKfzCF+DlSxfEdqL3gpjp7HN3FifZHXpmXhhP/LkrVoryX+CGdKxu+WQGcbJH
	 wQ6qfLEgSK9iA8PXjUk6pE1FGygrvBys0YMtPdFIQL2nG4aIV4CLAZR5PXJWduRbw+8dM
	 W9brjOZ3SMefYvLvxnPTTI7NjRaBnfrDCjB1l38ODCoTVMTTOnPlSkeSDUUGKNHHGsV4s
	 VwnXqwVp1Ec9BbeGaBqPeR8Wws+jiGW1pf2RkqLAPt+54oJFIB4J8vs/YXIXYAcdKAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L35YLwyk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE29606A32E;
	Tue, 10 Nov 2026 13:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L35YLwyk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5968F1F0089F;
	Tue, 10 Nov 2026 13:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794318706;
	bh=DgMB87bjjOhJubk+hnBQVvUaHtmOByTmAGnQuDuOPkc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L35YLwykVOSrGxvbsrb1u3khnVzNXdXgakJy4Rkd8urakgak65Pxog7+j9n13CK34
	 oRXOCloZFEVBh8KHZtaASdAn7zOxHwlsMKpYDKZEjz+2xdMk3RHSg5SZjzrFO4cudu
	 KGKXJGspaknuLBzI44niWPugCnd0bp/kCSgeQ0Y6REwQGNV7kcCuJaV8weXy+EERYN
	 /PUHMwKxtwy7/Jkpju2j1tUoSPXz4Mr4CbbJJssA+A3UfX7gpcw4Jhb8xRTxOJCWCo
	 p1eSmUoVXOTAWGk6Gz5VbeeR8JwJZ0dkwfxiLhwru5TtiaQX6nyYqgcickCDQVOqRo
	 UvQfdeWId7beA==
Message-ID: <sashiko-outbox-207157@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/6] riscv: accept the atomic extensions this kernel
 was built with
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261110-lrsc-only-v6-3-bafc3cc0fcae@mobileye.com>
References: <20261110-lrsc-only-v6-0-bafc3cc0fcae@mobileye.com>
 <20261110-lrsc-only-v6-3-bafc3cc0fcae@mobileye.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 13:51:45 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] riscv: hwprobe_one_pair() falsely reports IMA base on
  zalrsc-only harts
--

commit 28e749f3a8a1535f66a4515b72ef2377c9c49282
Author: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

riscv: accept the atomic extensions this kernel was built with

This commit updates riscv_early_of_processor_hartid() to accept harts
whose riscv,isa-extensions property lists "zalrsc" (and "zaamo" when
CONFIG_RISCV_ISA_ZAAMO is enabled) instead of "a".

> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index 3dbc8cc557dd1..9ba0d49c87bc3 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -82,12 +82,29 @@ int __init riscv_early_of_processor_hartid(struct dev=
ice_node *node, unsigned lo
>  		return -ENODEV;
> =20
>  	if (of_property_match_string(node, "riscv,isa-extensions", "i") < 0 ||
> -	    of_property_match_string(node, "riscv,isa-extensions", "m") < 0 ||
> -	    of_property_match_string(node, "riscv,isa-extensions", "a") < 0) {
> -		pr_warn("CPU with hartid=3D%lu does not support ima", *hart);
> +	    of_property_match_string(node, "riscv,isa-extensions", "m") < 0) {
> +		pr_warn("CPU with hartid=3D%lu does not support im", *hart);
>  		return -ENODEV;
>  	}
> =20
> +	/*
> +	 * Require the atomic extensions this kernel was built with. "a"
> +	 * covers both; otherwise LR/SC is always needed and AMO is needed
> +	 * when the kernel uses it.
> +	 */
> +	if (of_property_match_string(node, "riscv,isa-extensions", "a") < 0) {
> +		if (of_property_match_string(node, "riscv,isa-extensions", "zalrsc") <=
 0) {
> +			pr_warn("CPU with hartid=3D%lu does not support zalrsc", *hart);
> +			return -ENODEV;
> +		}
> +
> +		if (IS_ENABLED(CONFIG_RISCV_ISA_ZAAMO) &&
> +		    of_property_match_string(node, "riscv,isa-extensions", "zaamo") < =
0) {
> +			pr_warn("CPU with hartid=3D%lu does not support zaamo", *hart);
> +			return -ENODEV;
> +		}
> +	}

[Severity: Medium]
As reported by Conor Dooley on v4 [1], when CONFIG_RISCV_ISA_ZAAMO is
disabled and a hart boots with only "zalrsc" (without "a" or "zaamo"),
does hwprobe_one_pair() still report RISCV_HWPROBE_BASE_BEHAVIOR_IMA for
RISCV_HWPROBE_KEY_BASE_BEHAVIOR?

arch/riscv/kernel/sys_hwprobe.c:hwprobe_one_pair() {
    ...
	case RISCV_HWPROBE_KEY_BASE_BEHAVIOR:
		pair->value =3D RISCV_HWPROBE_BASE_BEHAVIOR_IMA;
		break;
    ...
}

RISCV_HWPROBE_BASE_BEHAVIOR_IMA advertises full rv32ima or rv64ima
support, including Zaamo AMO instructions, so userspace querying hwprobe
on a zalrsc-only hart will be told that AMO instructions are supported and
can fault with SIGILL when executing them.

[1] https://lore.kernel.org/r/20261103-pushcart-very-04a34d0ffb0e@spud

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-lrsc-only-=
v6-0-bafc3cc0fcae@mobileye.com?part=3D3
