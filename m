Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9765222565
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 23:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790466156; cv=none; b=TpjqkXVZ0z4Ww9yeVIe0BTz0uQmuMmg287SQARh5BHYcgaP3mIm/UiwVlnlea9S3vImz9TYPMiidIA3AAPLSj7IUyWezBdwzaqQZura0uVovK6OAM1XPUfefoRmxSr4SkV3q2ZYb2JMqM+I9aB5+xC6WwhoUKoc5FwjR3IE4tXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790466156; c=relaxed/simple;
	bh=sckjTSNf9DrvVEYf8EORANBOFYYx5luoZGQrRgwfwy4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K9dH9r8KHyFDakMwWtP8ytzR6+Rc0Ixq7+vREF8lVK6kH3JrjfQyaXDfD2TdRslX617Iqow2lgrHmOhzs0b8dI5NT/6Sl6MpYZ7qosP3C98DIbLg+E8jUls/kmkV808llVjIMncf4FdUIEmoVPgZ7NJwB7itBbhx9lg8wzfKU18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuuJO7zi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuuJO7zi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 651F81F000FF;
	Sat, 26 Sep 2026 23:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790466154;
	bh=6yI+XRv5PgNxoQS6x00T48YBu+1dkj9R7vdT5b8WCI4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IuuJO7ziv6hTDGj7VizloXy8NTmUykUkNxAZAnG7aoDL1ywWJCrXIRq3201uX00Nb
	 KRZ1kFfWgaqu4/otFfefJ9PLdsNsSGPiU8UnP46617D2BdLjqNPwmItLXQ3RP5/CXp
	 Dl0cOvMsFSPlFOjz7aQNhKP/K9m5lhgrj0vv985t7yeBz5xR9BJmNlgOL5MVov7zI2
	 DPuUWukqUJFWA34gGPZRTPGxEJdHAf/XfDZOs5xQbd6BaRYDhIdaP7J3O4LEdSdLsn
	 bx7M7tEDtE/hw0J2Jg4BN8X7F0auXGrn7BWNLak23JG9yeKUxG4cy1DXJ2qn/aV+pW
	 Ls5E7GjuiHCdA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next v1 01/16] mm/vmalloc: Add
 get_vm_area_align()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260926233503.3114147-2-memxor@gmail.com>
References: <20260926233503.3114147-1-memxor@gmail.com>
 <20260926233503.3114147-2-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 23:42:34 +0000
Message-Id: <20260926234234.651F81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mm: get_vm_area_align() silently ignores align if VM_IOREMAP is =
passed
--

commit 60a153047292d8f40c9a75614c11c4a932d74c1f
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

mm/vmalloc: Add get_vm_area_align()

This commit introduces get_vm_area_align(), a new variant of get_vm_area()
that allows callers to specify a custom alignment for the start of the
virtual memory area. This avoids wasting virtual address space when natural=
ly
aligned regions are required, such as for BPF arena maps.

> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index bea9f76ed7e74..b70e4e27ec362 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c

[ ... ]

> @@ -3301,6 +3301,25 @@ struct vm_struct *get_vm_area_caller(unsigned long=
 size, unsigned long flags,
>  				  NUMA_NO_NODE, GFP_KERNEL, caller);
>  }
> =20
> +/**
> + * get_vm_area_align - reserve a contiguous kernel virtual area at an al=
igned start
> + * @size:	 size of the area
> + * @align:	 alignment of the start of the area, a power of two
> + * @flags:	 %VM_IOREMAP for I/O mappings or VM_ALLOC

[Severity: Medium]
Does this API work as intended if a caller passes VM_IOREMAP?

The documentation explicitly invites the caller to pass VM_IOREMAP, but
__get_vm_area_node() unconditionally overwrites the requested alignment
when this flag is set:

mm/vmalloc.c:__get_vm_area_node() {
    ...
    if (flags & VM_IOREMAP)
        align =3D 1ul << clamp_t(int, get_count_order_long(size),
                               PAGE_SHIFT, IOREMAP_MAX_ORDER);
    ...
}

Will this establish a broken contract where the caller's explicitly
requested alignment is silently ignored and overridden based on the
size of the area?

> + *
> + * Like get_vm_area(), with the start of the area aligned to @align.
> + *
> + * Return: the area descriptor on success or %NULL on failure.
> + */
> +struct vm_struct *get_vm_area_align(unsigned long size, unsigned long al=
ign,
> +				    unsigned long flags)
> +{
> +	return __get_vm_area_node(size, align, PAGE_SHIFT, flags,
> +				  VMALLOC_START, VMALLOC_END,
> +				  NUMA_NO_NODE, GFP_KERNEL,
> +				  __builtin_return_address(0));
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926233503.3114=
147-1-memxor@gmail.com?part=3D1
