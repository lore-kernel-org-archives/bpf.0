Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEAC303CAE
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 18:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782500386; cv=none; b=GTK6WtzeRH4+NDgqpU5QkdwoL/aLOVxqzrel6+18G2ZIyHxvwUbtfblC3MusPfVpQhWzE+Z7+HbFIfYyp2u7qb0CavHHrN1Q+ZIjiqs2o3PdpAXKuwQl5kjXKWiE0w7LCrtH+MN0t9GXfapewtXTO5nD+5zKbBkQ4fXMPCpBwLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782500386; c=relaxed/simple;
	bh=ha71gnuVzMy0RyA5NIoagyFttlt3hReVGi4jNt1BgEY=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q23aUittdhbiuxaRt+qfNu9jGblxP7XCKaACBAK4SSvTlLLAmNCHHBghMxJcdQVwrn0Tcx6LymmMWYmvGjEK84COaepjyBFyp+uIEAbDFfG7QABB64PkzYluuVHBPg6mjCogYu5eW8uJPWY16iDClTfbS2MSjZTS8Zm5kl1fOco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZU44IL9/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZU44IL9/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7BB1F000E9
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 18:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782500385;
	bh=MFHSb3AZilXVsZwMIiVM98ebFRfIuN87/wuYOfXAZA8=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ZU44IL9/ChmVdmFm0EnNPukvQqBZXCno3sB0ZZv5xYLxxtkwOPPx1NcC6oZxIv+yO
	 S5XOS6Reiayt1a3EX431SSFmhFzm9PEC3YnWkjPviVljBRO6c+n0SV/GdozQZW1Ebb
	 wrpSB30FtDNx9M1N2wM8I7cZbka2dinUG2UummCmC2zKFwH8WVOkSXjd3GjNwsYGr1
	 7gd9eLLYLWXYtZyHwHcEuIxL/x7HCR4MdYn67VG5rAXfH/yKMMfN3nXoQZMBOMZ91I
	 kCfLlPY8c7butDMLeFy8ecy7gXK1RXgT321vzb5Kuuxk40zxL4jbpzks8fmldkvn6T
	 Xz85meaNpmOuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 5/5] x86/bpf: enable EXECMEM_ROX_CACHE for BPF
 allocations
Reply-To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
In-Reply-To: <20260626-execmem-x86-rox-bpf-v0-v1-5-45a0b0ed4fe9@kernel.org>
References: <20260626-execmem-x86-rox-bpf-v0-v1-0-45a0b0ed4fe9@kernel.org>
 <20260626-execmem-x86-rox-bpf-v0-v1-5-45a0b0ed4fe9@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 18:59:44 +0000
Message-Id: <20260626185945.2F7BB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Pages freed from the ROX cache via vfree() are returned to the=
 page allocator with Read-Only permissions, causing kernel panics on subseq=
uent allocations.
- [High] The return value of execmem_restore_rox() is ignored in __execmem_=
cache_free(), potentially leaving cached memory as Non-Executable (NX) and =
crashing the kernel when BPF programs are executed.
--

commit d59aa3f12b249d60a053835fa723486bb4d4f203
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>

x86/bpf: enable EXECMEM_ROX_CACHE for BPF allocations
   =20
BPF core and x86 JIT use text poking and temporary writable buffers and
thus can handle ROX memory. Enable ROX cache for EXECMEM_BPF when
configuration and CPU features allow that.

> diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> index fb67217fddcd3..079f8c7e9e3cd 100644
> --- a/arch/x86/mm/init.c
> +++ b/arch/x86/mm/init.c
> @@ -1107,10 +1107,10 @@ struct execmem_info __init *execmem_arch_setup(vo=
id)
>  				.alignment =3D MODULE_ALIGN,
>  			},
>  			[EXECMEM_BPF] =3D {
> -				.flags	=3D EXECMEM_KASAN_SHADOW,
> +				.flags	=3D flags,
>  				.start	=3D start,
>  				.end	=3D MODULES_END,
> -				.pgprot	=3D PAGE_KERNEL,
> +				.pgprot	=3D pgprot,

[Severity: Critical]
This is a pre-existing issue, but enabling the ROX cache for BPF
significantly increases the likelihood of triggering it. When memory is fre=
ed
back to the page allocator via vfree() from the ROX cache, it appears to
retain Read-Only permissions.

In mm/execmem.c:execmem_cache_populate_alloc(), memory is allocated without
the VM_FLUSH_RESET_PERMS flag:

    unsigned long vm_flags =3D VM_ALLOW_HUGE_VMAP;
    ...
    p =3D execmem_vmalloc(range, alloc_size, PAGE_KERNEL, vm_flags);

When the block is later cleaned up in mm/execmem.c:execmem_cache_clean(), it
is freed using vfree():

    execmem_set_direct_map_valid(vm, true);
    mas_store_gfp(&mas, NULL, GFP_KERNEL);
    vfree(area);

Since VM_FLUSH_RESET_PERMS was omitted, vfree() skips resetting the direct =
map
permissions. If a subsequent kernel subsystem allocates these same pages fr=
om
the buddy allocator and attempts to write to them, will this result in a Wr=
ite
Protection fault and kernel panic?

[Severity: High]
This is also a pre-existing issue exposed by enabling the ROX cache. In the
error handling path, the return value of execmem_restore_rox() is ignored.

Looking at mm/execmem.c:__execmem_cache_free():

    execmem_fill_trapping_insns(ptr, size);
    execmem_restore_rox(ptr, size);
   =20
    err =3D execmem_cache_add_locked(ptr, size, gfp_mask);

If execmem_restore_rox() fails (for example, if set_memory_rox() returns
ENOMEM when allocating page tables for direct map splitting), the memory is
left as Non-Executable (NX).

Since this error is ignored and the memory is still added to the free list,
could BPF subsequently allocate this NX memory from the cache, assuming it =
is
executable, and crash the system when attempting to execute JIT code?

>  				.alignment =3D MODULE_ALIGN,
>  			},
>  			[EXECMEM_MODULE_DATA] =3D {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-execmem-x8=
6-rox-bpf-v0-v1-0-45a0b0ed4fe9@kernel.org?part=3D5
