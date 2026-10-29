Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793311172;
	b=Tcv04mRmCCDTuU3Grhl/TFcED8qYQBCsglSeZgQQHL/S3Q+1LB9Img/uUTziCMgN/Jat
	 wePDoO4V8ffm3o3FNmvEuvA0KnKHQZCx5jSZLpB7U8e/z7taUxbw1LeDUgpK3S4Eyr0In
	 i0uRdIxzuSmSfD64zhdRvDAPP5UJeu+HAwbA4PD5RcOvI5xMv2fW4/ikXhDUBD10vGdhU
	 Yoi3AAkucMClMtYKexSnE6jmVNfvjE+YD6o56qA2C9qDxWeY8RrhCf56d0H96QM0QO63x
	 /2rTO5OM8i11N7x6+UVjkX4IMZTKFiQD0x00UWgjV/p97oCsKcEdaZ5OXl0nErv/gEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793311172;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=MG/FCUNnGBB5FvtyeNl3BOQEOtBU2SsDmO/bRipgzyw=;
	b=wMogZ/lG/30MUlHbrfjX+1tbXqQQUVbFxY3XoFccweHlnuJoJEgnNqDCc7VQOJbkFBd0
	 /wQVPE8lIw1e/OZeKA/hfv5HTDrag0pDCF22DqU/Mh7toTitx8F6k7WvpAWk9BkaF+MKq
	 HFPBhavp2fZYFHMpDgcn8G5zUzWIrwEbtTfbHvireA13xT9y/2EO+W0PyGu3R//Uu6taC
	 O3K79uIPBTOwCagLnRAoU7IF3jqw99ealRn8JEju+P8XPSXBDmAyYRbeyqu4g7TpjA+4C
	 ItriA/R8ScgqdLH0gKymy/4iqEgObHsQeWhCn7ySHT9Y/Kbpjt3vaBLmZncL07GxJ+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jpu7isRf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2509A606A31C
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 21:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jpu7isRf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6167E1F01816;
	Thu, 29 Oct 2026 21:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793311171;
	bh=MG/FCUNnGBB5FvtyeNl3BOQEOtBU2SsDmO/bRipgzyw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=jpu7isRf7ZVVTs0ZfPyQHpXrh9H10Z+3vtHtyretE6Hwmj9AZp5jnVJ//vNZDDfDS
	 RXi7vjEncBqqtpmOaHLBRgWgm7DihlX8HM8TUqFczy1G18GBVh2Pdq5htjytbflZVr
	 iMhZ5ad6bYL51CtuJm+d89VyJ9dlVnWA8pAE0eJF/fwDkfBtW7mMAPbdolHEQ9DnpP
	 TIrN6ZjXG/sDOjRti9hL7NC6stcBeuen/jynUd5qXdodWyiJ5cwLt4rAKqUaiLhe07
	 EDM9BMSOZUBTurmH4ozrVm4HtsMCqrnwYfWVbXXFBAlXDZQLx9eh9Pw+wHx7H1Fz5Y
	 sDLIU9cIReEOQ==
Content-Type: multipart/mixed; boundary="===============4330953219371756825=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <18976b63cb396cdfaebc5c630c926d88544160ef2a4c034e8a290df2b428806e@mail.kernel.org>
In-Reply-To: <20261029212551.56964-6-jolsa@kernel.org>
References: <20261029212551.56964-6-jolsa@kernel.org>
Subject: Re: [PATCH bpf-next 5/8] selftests/bpf: Test user memory mmap kfuncs
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net
Cc: bpf@vger.kernel.org,linux-mm@kvack.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ljs@kernel.org,john.fastabend@gmail.com,nierro92@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 29 Oct 2026 21:59:31 +0000 (UTC)

--===============4330953219371756825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test user memory mmap kfuncs

TL;DR: Nits only: the changelog omits the kfuncs.rst documentation added by
the patch, which may belong in another patch; also an unneeded
<sys/personality.h> include and a never-used NULL perms path in
check_user_mem_vma().

>     selftests/bpf: Test user memory mmap kfuncs
>
>     Add BPF selftests for bpf_user_mmap and bpf_user_munmap from a
>     sleepable uprobe. Check that created mappings have the requested
>     permissions and that unmapped addresses are no longer mapped.
>
>     Assisted-by: Codex:GPT-6
>     Signed-off-by: Jiri Olsa <jolsa@kernel.org>

This isn't a bug, but the changelog only describes the new selftests, while
the patch also adds a "4.4 User memory kfuncs" section to
Documentation/bpf/kfuncs.rst.

That section documents bpf_copy_to_user() as well, which is not exercised by
the tests added here, and it states that seccomp filters do not mediate the
mappings made by these kfuncs.

Could the kfuncs.rst section go into "bpf: Add user memory kfuncs" or a
separate documentation patch, or at least be mentioned in this changelog?

> diff --git a/tools/testing/selftests/bpf/prog_tests/user_mem.c b/tools/testing/selftests/bpf/prog_tests/user_mem.c
> new file mode 100644
> index 000000000000..f301a1843706
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/user_mem.c
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +#include <sys/mman.h>
> +#include <sys/personality.h>
                  ^^^^^^^^^^^^^^^^

This isn't a bug, but is <sys/personality.h> needed here?  Nothing in this
file calls personality() or uses a PER_*, READ_IMPLIES_EXEC or ADDR_*
constant.

> +#include <unistd.h>

[ ... ]

> +static bool check_user_mem_vma(void *addr, unsigned long size, const char *perms)
> +{

[ ... ]

> +	return !perms || ASSERT_STREQ(vma_perms, perms, "vma_perms");
                  ^^^^^^^^

This isn't a bug, but does check_user_mem_vma() need to handle a NULL perms?
test_mapping() passes the literal "rw-p", and the later patches in the series
pass "rw-p" and "r-xp", so the "!perms ||" branch is never taken.

> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40959191771
--===============4330953219371756825==--
