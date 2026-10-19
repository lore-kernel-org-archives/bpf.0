Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3FC48641C
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 05:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792388835; cv=none; b=NsrPlSdoSHWL5sdmR8eIcAsCsW83dFZet41qmcx08hjRbRzRnBpC5jM+zH8kFQRI6IvpalftA6ER9ajntErpe0Rkak36BzveId6JfgmIWPTR8EkJdDmJhPa5TMXUuibVHZ/CIZtZW8pwnMMZiK1l7sPi9skiT2+kjZLaLVj4Zfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792388835; c=relaxed/simple;
	bh=ioHdZ7C4M75DMoqngPeeznk3jddNgNhPUaTKhG0wlJM=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=iTwm0Uvv8pxZv7HpFzCIUtRd1HaExK0ICnEvZkQzGbUbwjIlI/086arIGA1N5IK/kOyjy2kjZsV5AB2yhGv2XzpNeg7DRClAPg35CuG2Cy/btW7e9D7NQ2RQ53N7dOHL+ORPGWxAI00XpNbOLYMrrxRcCXfzS9Dcds0Vcd8I9aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntnq/MZo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntnq/MZo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40361F000C4;
	Mon, 19 Oct 2026 05:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792388737;
	bh=Bzzh2ZniVkiyazldQzNY2Zs9i5irSobbe22VSkyM3x8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ntnq/MZom/5uNvQUF5cOECml9JM7PissM6mfZ/MJb0kO3jWLKGGIZL5/La0Y+nPUA
	 ttT+F3BbOsRTty6qmsfpp4EsEihKEIq/HAne2i/u32eIQZjAg1ieKQsv+sBC7IjNdP
	 YW/XEM6bCnxxLfoO8qGoV+WTJ+IysatLdO2C+BsfC0nbBB3nbxXXjBdUjm+JInW6HA
	 KJwt06j9FfKmkmkR3ETfu0WAVFZ2UfyB+gdaAZY9maU8hvjaaHSHqkg9LslN+hQdjN
	 XBms6ds4Xhh+yR/pNkFPpJmYVzjcJ7cDEJcv12GcGvV/tiZwaOYLztZZFPcUnyQ6o2
	 s+yMS0qBmH/ww==
Message-ID: <sashiko-outbox-176672@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf-next 1/5] bpf: Add unwind_goto and unwind_exit
 insns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261019051846.3012089-2-alexei.starovoitov@gmail.com>
References: <20261019051846.3012089-1-alexei.starovoitov@gmail.com>
 <20261019051846.3012089-2-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 05:45:36 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: build failure in bpf_unwind_target() on MIPS due to missing fi=
xup field
--

commit c2ccff0580e3d9f39dd46bc86407477749d28180
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Add unwind_goto and unwind_exit insns

This patch introduces unwind_goto and unwind_exit BPF instructions to
support frame unwinding for Rust Drop, C++ destructors, and C cleanup
attributes. The verifier validates landing pads and unwind paths, while
JITs use exception table entries and bpf_unwind_target() to redirect return
addresses on unwind_exit.

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 6e32db9777c2a..da3691b47cc72 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -804,6 +804,24 @@ const struct exception_table_entry *search_bpf_extab=
les(unsigned long addr)
>  	return e;
>  }
> =20
> +/*
> + * JITs don't emit a branch for unwind_goto. They add an extable entry
> + *   { .insn =3D ret_addr - 1, .fixup =3D pad - ret_addr }
> + * where ret_addr is the return address of the call in front of it. unwi=
nd_exit
> + * replaces the return address of its frame with what this function retu=
rns.
> + * ret_addr - 1, because what follows the call can have an entry of its =
own.
> + * No insn starts there, so a fault cannot hit the entry.
> + */
> +u64 bpf_unwind_target(u64 ret_addr)
> +{
> +	const struct exception_table_entry *e =3D search_bpf_extables(ret_addr =
- 1);
> +
> +	/* The verifier made sure that unwind_goto follows the call */
> +	if (WARN_ON_ONCE(!e))
> +		return ret_addr;
> +	return ret_addr + e->fixup;
> +}

[Severity: Low]
Does bpf_unwind_target() cause a build regression on MIPS when
CONFIG_BPF_JIT is enabled?

In kernel/bpf/core.c, bpf_unwind_target() is compiled whenever
CONFIG_BPF_JIT is enabled and accesses e->fixup directly.

MIPS selects HAVE_EBPF_JIT (when !CPU_MICROMIPS in arch/mips/Kconfig),
allowing CONFIG_BPF_JIT to be enabled, but arch/mips/include/asm/extable.h
defines struct exception_table_entry with nextinsn instead of fixup:

struct exception_table_entry
{
	unsigned long insn;
	unsigned long nextinsn;
};

None of the subsequent patches in the series guard bpf_unwind_target() or
provide an architecture-specific accessor for this field.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019051846.3012=
089-1-alexei.starovoitov@gmail.com?part=3D1
