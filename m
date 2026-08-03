Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2303AEF57
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 08:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785744713; cv=none; b=lu4fxtx3hecVi9Vr8wXYAPvRT89BspmO6/uY+LJP2RWWpNk7R1JrH7hsYhQcCnNAayU3wy5oqhAsyjyf1yTONuI1kwbX/3imJixgHHMFdhFSnT/KZdJKDmHMCdlwlx0DPKFqXNH2GUuAlcfjjs23tOJNpGcV2C+w46bCplFA1Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785744713; c=relaxed/simple;
	bh=N7FygS29/3VstB/A7XrbBQlSrnxV9DK7YyqPPHtKOy4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XEFdJZNL1k4n9ChwTyQT96Z47PAf22Y+dgWcujxkur78eXEXGxohLMFc9nUpQAFXuPgEU0Gu0+hZRvqPwqsCthOqWI3dUqYsq+DeZt2LSCbhBA9IsPyuoaLbVmzoc9KBJhndX2FJc44qkgyFljTx/1BdHfCQ5eXCHKmzjP17gu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3jksBZ+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3jksBZ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1281F000E9;
	Mon,  3 Aug 2026 08:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785744711;
	bh=bOS3oRiHXqi2uWLqTbOYcIgCnGdxmuXpkAwigujwKgg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E3jksBZ+ewB9jr31zguNWU0iUMEPZeRhe1sGwoykoehN3Ff3XT0f8g4pvcbbAPwOu
	 Vy39NbgpONtKfc/ZQcQgLPmK9+VCH4yelRdfdfWKI4ueti3GieDAsDPBQKdV+79SM4
	 MrLkHi/rWn2Zn2RZF/5tOR1X1RF2Gl9yMwWZR+9QahkQ/6uh9QIaay2bcxKQZLnrjz
	 WF9ksc8OKTM4sgJT5S8W+CV6x3kjnPROQBaiMsY9e/ihqEzscMy5ywMKzVn91kQ6Cz
	 d3olkEhYPUP2TeaBCd4IiLNHn8B7zf/g56qBSbHvYMIJ1xL1Beog+rLinEHXP9X0Y5
	 WmFrbP13bEoMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] btf: Remove the dependency on BPF_SYSCALL
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260803-btf-dep-bpf-syscall-v1-1-a03291e27888@linutronix.de>
References: <20260803-btf-dep-bpf-syscall-v1-1-a03291e27888@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 08:11:50 +0000
Message-Id: <20260803081151.0D1281F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Enabling CONFIG_DEBUG_INFO_BTF without CONFIG_BPF causes a build f=
ailure because resolve_btfids is not built.
- [High] Removing `depends on BPF_SYSCALL` from `CONFIG_DEBUG_INFO_BTF` cau=
ses a build failure (undefined reference to bpf_log) when `CONFIG_BPF_SYSCA=
LL=3Dn`.
- [Medium] The BTF sysfs interface (/sys/kernel/btf/vmlinux) is silently om=
itted if CONFIG_BPF is disabled, breaking runtime introspection tools.
- [Low] Unintended dead code compilation in BPF network/netfilter helpers w=
hen `CONFIG_BPF_SYSCALL=3Dn`.
--

--- Patch [1]: [PATCH bpf-next] btf: Remove the dependency on BPF_SYSCALL -=
--
commit 03ceb2b61ee22ba44c522bd10633e606cb023951
Author: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

btf: Remove the dependency on BPF_SYSCALL
   =20
BTF has become useful without the BPF syscall being present.
It is used by debuggers and introspection tools like pahole.
The dependency prevents the usage of BTF without pulling in the
rest of the BPF subsystem.
   =20
Remove the dependency.

> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 1244dcac2294a..f9dc5b60d8345 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -399,7 +399,6 @@ config DEBUG_INFO_BTF
>  	bool "Generate BTF type information"
>  	depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED
>  	depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
> -	depends on BPF_SYSCALL

[Severity: High]
Does removing this dependency break the build when CONFIG_BPF is disabled?

In the top-level Makefile, the target to prepare tools/bpf/resolve_btfids
is guarded by ifdef CONFIG_BPF. However, scripts/Makefile.vmlinux
unconditionally depends on $(RESOLVE_BTFIDS) when CONFIG_DEBUG_INFO_BTF
is set.

When compiled with CONFIG_DEBUG_INFO_BTF=3Dy and CONFIG_BPF=3Dn, Kbuild fal=
ls
back to the tools/% rule, trying to run:
make -C tools/ bpf/resolve_btfids/resolve_btfids

This causes mkdir to create a directory in its place, and make subsequently
fails due to the missing Makefile.

[Severity: Medium]
If CONFIG_BPF is disabled, does this prevent the BTF sysfs interface
from being created?

The commit message mentions that BTF is useful for introspection tools
without the BPF syscall. However, kernel/bpf/sysfs_btf.c provides the
/sys/kernel/btf/vmlinux interface used by these tools.

In kernel/Makefile:
    obj-$(CONFIG_BPF) +=3D bpf/

Since Kbuild only descends into kernel/bpf/ if CONFIG_BPF is enabled,
sysfs_btf.c is silently skipped when CONFIG_BPF=3Dn, hiding the BTF data
from userspace tools.

[Severity: High]
Can this cause a link-time error for bpf_log()?

In net/netfilter/Makefile:
    nf_conntrack-$(CONFIG_DEBUG_INFO_BTF) +=3D nf_conntrack_bpf.o

If CONFIG_DEBUG_INFO_BTF=3Dy and CONFIG_BPF_SYSCALL=3Dn, nf_conntrack_bpf.c
is still compiled. It calls bpf_log() in _nf_conntrack_btf_struct_access().

However, bpf_log() is defined in kernel/bpf/log.c, which is only built if
CONFIG_BPF_SYSCALL=3Dy. Since there is no inline stub for bpf_log() when the
syscall is disabled, this results in an undefined reference to bpf_log
linker error.

[Severity: Low]
Does this result in dead code being compiled in network/netfilter helpers?

Similar to the issue above, files like nf_nat_bpf.c and nf_flow_table_bpf.c
are built conditionally on CONFIG_DEBUG_INFO_BTF in net/netfilter/Makefile.

Without the BPF syscall, register_btf_kfunc_id_set() falls back to an
empty stub, meaning these files compile successfully but provide no
functional value, only increasing kernel size and compilation time.

>  	depends on PAHOLE_VERSION >=3D 122
>  	# pahole uses elfutils, which does not have support for Hexagon relocat=
ions
>  	depends on !HEXAGON

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803-btf-dep-bp=
f-syscall-v1-1-a03291e27888@linutronix.de?part=3D1
