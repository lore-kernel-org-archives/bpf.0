Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793874803;
	b=EEnIq50MabPOCghH+j/g3fHksRLSPdGUT6a8I1zLJZvQahMIqYtVBDvqefrAGdUtV7GW
	 83soW/jFRiQM4cMtVnsXE/vkwT4eLAeljQQhn7ywvZHZq48pC2oIwe72a9OsbSt6b+bUM
	 w5fl/4bBqOKJWfetQ6WFg2Sg7gX/Q8ejIoaOe/xbZim5XPdLqtJ2oQcKIiC++U2BaHrsM
	 tlp2Zk+HXTlwhnmIWLaTwZD5lMJxpjQC8invwV2v477v6Vy6NgmyKxNMH7Xv2irDwrbaC
	 KgiDXfxpZoyoKZ8E76Zdnh7XFxOgzOUoKvP2roWqHkoPcmTZeNdzJoNm/VonI2flPKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793874803;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3VKtMFUcvKjJEe9s8szWWukUuDsVUDxIJTJiZTdgl9o=;
	b=f3rXHjs8vC1FINjMwiKRouahvGWEmUlWdKf5Yl3ZyX7eT0heICLxikYpZJ2uZ/lJQ9XO
	 YLCUfQ/v5S35jjkMzq8csZAzvu4imhMgA+e3sqMDNKB+v+2dcsri6QhoeEi1WdyZhIDJo
	 tBobjJnbbEIOAFYHKLJSFFVsawGNdnFGOM92RIEcwPi5PXrtafJ1fZ8qyEiMvftrTVz2X
	 2YyiAZBD00tHxiUWAiq6OgNz/o7LLUx0lvgdKh6FS/rtmaSZrGDbMRcTQ/BKCJed25pn0
	 wz3sAFxFJmfFr4Frrc4fc//8PgYgZPGNjAwF1llJ7seB00htOCjIUkee5nz5emK0Lqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lL+rueNl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38110606A329
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 10:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lL+rueNl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6F01F000C1;
	Thu,  5 Nov 2026 10:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793874802;
	bh=3VKtMFUcvKjJEe9s8szWWukUuDsVUDxIJTJiZTdgl9o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lL+rueNlOuxwK6jMOoLgjD/3XR9iJOsgyqXAYHVNDlMY36sku3+yybFGvu68+2lKp
	 m9bVwHfTDNPJgUSUvfgKgJPX92CsxzcztSDkf5i5yOdo2g89q/Rp2j0bLId8MLWGI/
	 m4LmLhmR7KRj58uoaKOJP4ib8Hn6INUOxuYJE+64dw2EdysFARAiwa6XxuVunCG5sx
	 CGPx0b1DK82ARoqHebswt9PL1+/CU5EIc8xrt08YHYCoNxiNw2z0fVNx+fem/6ghgF
	 qkOUBRpESfJPEztHylmqVmmwfASlWjxd3r923XlyjcYhrC7YvmsQCkb3TvmkkVrvgb
	 W+ZhWUnpSXymA==
Message-ID: <sashiko-outbox-198860@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv3 bpf-next 5/8] selftests/bpf: Test user memory mmap
 kfuncs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>, "Federico
 Di Pierro" <nierro92@gmail.com>
In-Reply-To: <20261105102343.311331-6-jolsa@kernel.org>
References: <20261105102343.311331-1-jolsa@kernel.org>
 <20261105102343.311331-6-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 10:33:21 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] selftests/bpf: call to undefined get_procmap_info() breaks build
- [Medium] selftests/bpf: user_mem_test() calls non-existent user mmap kfun=
cs
--

commit 602c938f4e2233efed73c162a7e2295814283b95
Author: Jiri Olsa <jolsa@kernel.org>

selftests/bpf: Test user memory mmap kfuncs

This commit adds BPF selftests for bpf_user_anon_mmap() and bpf_user_munmap=
()
invoked from a sleepable uprobe, checking that created mappings have the
expected permissions and that unmapped addresses are removed.

> diff --git a/tools/testing/selftests/bpf/prog_tests/user_mem.c b/tools/te=
sting/selftests/bpf/prog_tests/user_mem.c
> new file mode 100644
> index 0000000000000..eadf668f7056b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/user_mem.c
> @@ -0,0 +1,111 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +#include <sys/mman.h>
> +#include <unistd.h>
> +
> +#include "user_mem.skel.h"
> +#include "trace_helpers.h"

[ ... ]

> +static bool check_user_mem_vma(void *addr, unsigned long size, const cha=
r *perms)
> +{
> +	size_t start, end;
> +	char vma_perms[5];
> +	int err;
> +
> +	err =3D get_procmap_info(addr, &start, &end, vma_perms);
> +	if (!ASSERT_OK(err, "user_mem_vma"))
> +		return false;
> +
> +	/* VMA can be merged, so ensure it covers at least the requested range.=
 */
> +	if (!ASSERT_GE(end - (size_t)addr, size, "vma_size"))
> +		return false;
> +
> +	return ASSERT_STREQ(vma_perms, perms, "vma_perms");
> +}
> +
> +static bool check_user_mem_unmapped(void *addr)
> +{
> +	size_t start, end;
> +	int err;
> +
> +	err =3D get_procmap_info(addr, &start, &end, NULL);
> +	return ASSERT_EQ(err, -ESRCH, "user_mem_unmapped");
> +}

[Severity: Medium]
Was a prerequisite patch adding get_procmap_info() omitted from this series?

Both check_user_mem_vma() and check_user_mem_unmapped() call
get_procmap_info(), and tools/testing/selftests/bpf/prog_tests/user_mem.c
includes trace_helpers.h, but neither tools/testing/selftests/bpf/trace_hel=
pers.h
nor tools/testing/selftests/bpf/trace_helpers.c declares or defines
get_procmap_info().

Because the BPF selftests are compiled with -Werror, does this cause buildi=
ng
test_progs to fail with an implicit function declaration error and an
undefined reference at link time?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/user_mem.c b/tools/testing=
/selftests/bpf/progs/user_mem.c
> new file mode 100644
> index 0000000000000..e3b0689f5f2a5
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/user_mem.c
> @@ -0,0 +1,43 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +#include "bpf_misc.h"
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +extern unsigned long bpf_user_anon_mmap(unsigned long len, unsigned long=
 prot) __ksym;
> +extern int bpf_user_munmap(unsigned long addr, unsigned long len) __ksym;

[ ... ]

> +SEC("uprobe.s//proc/self/exe:user_mem_trigger")
> +int user_mem_test(struct pt_regs *ctx)
> +{
> +	if ((bpf_get_current_pid_tgid() >> 32) !=3D monitored_pid)
> +		return 0;
> +
> +	switch (action) {
> +	case USER_MEM_MMAP:
> +		user_addr =3D bpf_user_anon_mmap(map_len, map_prot);
> +		break;
> +	case USER_MEM_UNMAP:
> +		ret =3D bpf_user_munmap(user_addr, map_len);
> +		break;
> +	}

[Severity: Medium]
Are the kernel definitions for bpf_user_anon_mmap() and bpf_user_munmap()
missing from the tree?

In tools/testing/selftests/bpf/progs/user_mem.c, user_mem_test() invokes
bpf_user_anon_mmap() and bpf_user_munmap() declared as strong __ksym extern=
s,
and test_user_mem() in tools/testing/selftests/bpf/prog_tests/user_mem.c
loads the program via user_mem__open_and_load():

    skel =3D user_mem__open_and_load();
    if (!ASSERT_OK_PTR(skel, "open_and_load"))
        return;

Since neither bpf_user_anon_mmap nor bpf_user_munmap is defined or register=
ed
in any BTF kfunc set in the kernel or selftest kernel modules, won't
user_mem__open_and_load() fail unconditionally when libbpf tries to resolve
their BTF IDs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105102343.3113=
31-6-jolsa@kernel.org?part=3D1
