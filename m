Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793693137;
	b=SQgCSJfEpoHm6tvnUvIxSQEAGwYO7Ao8H849ZY7ZJAzaepF0U6zwQI1qY5yJ60HmRwpi
	 yH92i1sJFKDQ3SNLEqHlyXz8fhQ3TkeO6an8kaNbMFc6djk8W5FgnPD9SN4Xlx82Yl5PT
	 oKzZVPp5s8RHl7nMsyRm89++pUUvmuuiS6Z4nMsc8xvzWHwrKg2kw3cTi2Ok6R+r8c5Qs
	 OxkiutlJrNgbp+kSf8Hdrz1yYMXwJCgjVq8IembnmMdNGaxapkkjB+sp4DFR5bd4TYsEy
	 Zwu970VFGdLM3x7lLzs9kIR8DYNXTgK8t8z8K/Dn17f55doFmXTxdbtLOwZNcD9JZSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793693137;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=umnbAdtT+FfOvb0pvOhjXpEkWgCQHgGLRUKTgDc4pQ8=;
	b=I8cy4LvsRhgGqp3NHvCnRLa/mX3iEft/DO9ig2Gws4WLJkcFLvnB97juEKUmwxt/Af5R
	 MLDNckAW1kcuYuqUuLo1vz752RMqvdUDtRESTTDpKTMC09Gz6qfGTWaH762z+FevS78kM
	 y/2gWUt6tO5ofAOLF/u9N74ZX2k+Fpy2ljwpAPm8aQ6v2X8JUMI0yGxE68ZdNZ8gTUiEd
	 MqX7WtnZLNkizcqzdcQA3KGsEEYRlRpyUVSRGB4GAPdyp8u0/hBGrhEPIudKRTqb2wbFE
	 V+RrYJhecC+bDXKuTvzpLFCwIRwDpikcUtrNGfQEH2vGgeFXfB73gMiPXZ5u8mql0vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="VJi1is//";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F09606A324
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 08:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VJi1is//
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258971F000C1;
	Tue,  3 Nov 2026 08:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793693136;
	bh=umnbAdtT+FfOvb0pvOhjXpEkWgCQHgGLRUKTgDc4pQ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VJi1is//p2sWAyWTwjaVVIExKc5I6lZlBxcdxKoFrLj9H91l+ReJkCJ8L8aM92RAm
	 yQCWRfFKaTDxG1nHrezU2Dhgznt3AlWVvx/T1jJNdivtrOYJNk2bdJc4kNhrEeW6Za
	 BWAiyzMGj/Gr6oJjv+fAdVVh+F6RNr37eACPRlUAlVsmFrcwA5lMkbFX8UZ9WpdyRg
	 d+zvoaX7tILD9qv+aMT4rcqPPNxUeHqHz6d1c45/XR9FXCgaCAzJkJeRDJfmHbpAUm
	 X1j9iO0TwfHSQKsMLweEgS7DJ4Szxy3ltDM9LCY16q1n4OGGGXaniv9KBH99dw75F+
	 72M8AnNaTGy5w==
Message-ID: <sashiko-outbox-194794@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2 bpf-next 5/8] selftests/bpf: Test user memory mmap
 kfuncs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>, "Federico
 Di Pierro" <nierro92@gmail.com>
In-Reply-To: <20261103075916.100050-6-jolsa@kernel.org>
References: <20261103075916.100050-1-jolsa@kernel.org>
 <20261103075916.100050-6-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 08:05:35 +0000
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
- [Medium] selftests/bpf: call to undefined get_procmap_info() in user_mem.c
- [Medium] selftests/bpf: unresolved kfunc externs in progs/user_mem.c
--

commit c7cc5f98b3a4b4d8d168ef0934e6c41fe197849d
Author: Jiri Olsa <jolsa@kernel.org>

selftests/bpf: Test user memory mmap kfuncs

This commit adds BPF selftests for bpf_user_anon_mmap and bpf_user_munmap
invoked from a sleepable uprobe, verifying mapping permissions and
unmapping behavior.

> diff --git a/tools/testing/selftests/bpf/prog_tests/user_mem.c b/tools/te=
sting/selftests/bpf/prog_tests/user_mem.c
> new file mode 100644
> index 0000000000000..f301a18437062
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/user_mem.c
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +#include <sys/mman.h>
> +#include <sys/personality.h>
> +#include <unistd.h>
> +
> +#include "user_mem.skel.h"
> +#include "trace_helpers.h"
> +
> +enum {
> +	USER_MEM_MMAP =3D 1,
> +	USER_MEM_UNMAP,
> +};
> +
> +static noinline void user_mem_trigger(void)
> +{
> +	asm volatile ("" ::: "memory");
> +}
> +
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
> +	return !perms || ASSERT_STREQ(vma_perms, perms, "vma_perms");
> +}
> +
> +static bool check_user_mem_unmapped(void *addr)
> +{
> +	size_t start, end;
> +	int err;
> +
> +	err =3D get_procmap_info(addr, &start, &end, NULL);

[Severity: Medium]
Where is get_procmap_info() defined? Both check_user_mem_vma() and
check_user_mem_unmapped() call get_procmap_info(), and this file includes
trace_helpers.h, but neither tools/testing/selftests/bpf/trace_helpers.h nor
tools/testing/selftests/bpf/trace_helpers.c declares or defines
get_procmap_info().

Because test_progs objects are compiled with -Wall -Werror, won't calling an
undeclared and undefined get_procmap_info() cause compiling and linking
tools/testing/selftests/bpf to fail?

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
Can user_mem__open_and_load() in test_user_mem() succeed when loading this
program?

user_mem_test() calls bpf_user_anon_mmap() and bpf_user_munmap(), which are
declared as required __ksym externs, but neither symbol is defined or
registered as a BPF kfunc in the kernel or bpf_testmod. Won't libbpf fail to
resolve these kfunc BTF IDs during user_mem__open_and_load(), causing
test_user_mem() to fail unconditionally?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103075916.1000=
50-6-jolsa@kernel.org?part=3D1
