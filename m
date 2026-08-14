Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8B91EEA31
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 22:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786746414; cv=none; b=YzMKdGc95GHo+E3hfVUcbwHBkIWvSeJJIp3RLB6Z6WJ3018RvNuV0yJSpkBUsRK6SMO6F8yhf+cFlYa/eJF670uK1h5edfyxPdSZA/MoV2/H5YDCVVxBVI05YElEyfH8+QQ/YCBML2yuVst2pCMpJPdKVwKJQygdYyoDkXzLRpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786746414; c=relaxed/simple;
	bh=tV5sinmeVGIYrQkFyyWHIUOZLVljpHf2aQ4IdGYSeug=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B74Xeo5AdKNbv9U2WO6wo7DVHWVtfg/KIAH3dU3Izw4JN88WxVoIDrMmohSUZpUHPecQNoqFwhp7lGRK2fvw6aYcAPaYzQpo4EaV068oDEI1N4SK7uS2jwdS9i6FGVuDotVDPkwWE9EBWxwg74mh6r8kQxJpVM9q0RnnZxJGMLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNWccU7w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNWccU7w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7600C1F000E9;
	Fri, 14 Aug 2026 22:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786746412;
	bh=/PbbCJZGCD4eYYWjFPdkK7um0C0qoc5Iz93ZdYP4k14=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cNWccU7w2Kt+HaiNC5ZcgjoG9/1MWMs6/dOa0vSrtjJSsEYTen4bJjm7F3xPfLZr0
	 tI/r0WZxrsN9PdOnu9Zcy0Sox/zjWtSOMyZ5DvRAsjogU0Ayjcuicn6F044DELvxdQ
	 +IsFve6Wf1Pc8dFlqNZVNWqeOMnel4EwDKHyKB4XkXpkKOjMkv1QQuagiblTNHaBab
	 QSKNFQbYnM1PHhD5+U9KDaDFvbFr0+9ngYFlO7VZ2jKrzoZr+bnQXLqwxFeJI1CxPV
	 UUquMDLGhYcUDHEeY/FfAvQ/Yk+bnLTuFVuXt/yTriz7SJ6MyX2/6r/880YjcfAkae
	 dlXORnZQitnOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Check per-CPU address
 resolution per register
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vineet Gupta" <vineet.gupta@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260814220254.3797467-3-vineet.gupta@linux.dev>
References: <20260814220254.3797467-1-vineet.gupta@linux.dev>
 <20260814220254.3797467-3-vineet.gupta@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 22:26:51 +0000
Message-Id: <20260814222652.7600C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The test uses an unrecognized section name `SEC(".percpu")` for it=
s global variable, preventing libbpf from loading the test.
- [High] The test's inline assembly is missing the `mov_percpu_addr` instru=
ction, causing the `__jited` assertions to always fail.
--

--- Patch [2]: [PATCH bpf v3 2/2] selftests/bpf: Check per-CPU address reso=
lution per register ---
commit 94ba39b00c54962b463da6e18c62f89978f29a3f
Author: Vineet Gupta <vineet.gupta@linux.dev>

selftests/bpf: Check per-CPU address resolution per register

This commit adds a BPF selftest to verify that the x86 JIT correctly encodes
the per-CPU address resolution. It loads a .percpu variable into all regist=
ers
and matches the JITed add instruction against the expected register.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_percpu_addr.c b/t=
ools/testing/selftests/bpf/progs/verifier_percpu_addr.c
> new file mode 100644
> index 0000000000000..967f4e6e3a490
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_percpu_addr.c
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +#if defined(__TARGET_ARCH_x86)
> +
> +int percpu_data SEC(".percpu");

[Severity: High]
Does libbpf support the SEC(".percpu") section name?

When bpf_object__elf_collect runs, it skips the .percpu section as it doesn=
't
match known data section prefixes like .data. Later, when
bpf_object__relocate_data processes the R_BPF_64_64 relocation for the
percpu_data load, bpf_object__section_to_libbpf_map_type returns
LIBBPF_MAP_UNSPEC.

Since the section is not the BTF maps section, this results in a bad map re=
lo
warning and returns -LIBBPF_ERRNO__RELOC, causing the test to fail to load.

[ ... ]

> +__naked void percpu_addr(void)
> +{
> +	asm volatile ("					\
> +	r0 =3D %[percpu_data] ll;				\
> +	r1 =3D %[percpu_data] ll;				\

[Severity: High]
Are the mov_percpu_addr instructions missing from this inline assembly?

The commit message notes that an ld_imm64 of a per-CPU map value is followed
by a mov_percpu_addr, but the assembly here only emits a BPF_LD_IMM64
instruction.

The verifier processes this as BPF_PSEUDO_MAP_VALUE and converts it to a
standard 64-bit immediate load. Without the BPF_MOV64_PERCPU_REG
(mov_percpu_addr) instruction, the x86 JIT emits movabsq but never emits the
addq %gs:..., %reg instruction. This causes the __jited assertions to fail.

> +	r2 =3D %[percpu_data] ll;				\
> +	r3 =3D %[percpu_data] ll;				\
> +	r4 =3D %[percpu_data] ll;				\

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814220254.3797=
467-1-vineet.gupta@linux.dev?part=3D2
