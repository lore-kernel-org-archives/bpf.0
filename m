Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F6B38F624
	for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 19:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777232051; cv=none; b=Gv+vS8ec+1nMWHqFsY7T+s/thPYs0A0BU8H4qmG+ikvhNEKUUIAtDxDUWaE6W/0lVPClMEOURtTJBk52c/g6qtCvRyzqR3n/9tXdN2o03SRzEtSqimfd7H/poUsH5Rpq2C/viErW+FZaWE1HmlW9HUWRsmCOYwDep3Etl9J7GCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777232051; c=relaxed/simple;
	bh=uFoCSe3fFgvlqJGaVJQL5H7WXyEzeklQ/1CDlRMdaZE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ev9wjcVaqKQnZZyuibjErFllhCSPx5MB5vV+F6QG307i1s5kbqlPCN2OOl251qrrJsC6bFuDFWcEb2XZTkkI5FEvd5CHFQOZHKr5Hb5KhXHkOkPCzxWktYPDzmx5bV0KT0n/XlW/uOm3UX4xufPnabfnyd67GKe793PrIJ+BDI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0qGNN9c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0qGNN9c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD73C2BCAF;
	Sun, 26 Apr 2026 19:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777232051;
	bh=uFoCSe3fFgvlqJGaVJQL5H7WXyEzeklQ/1CDlRMdaZE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=F0qGNN9czW6ij81GXqwenHKEbVwG3anrD3emAwHNkeGa2Za8wlJuASqkyFRvnWFnQ
	 O7xE4anIxR2YVg9lOjpNpEYc0K7dCwGiLIZFL+ACivISGCEN6Zxyw173NlJxh1jzLJ
	 h9pOg1G1SMmlJuDKClSGHG/UrxlaLqcSsxAlEQvoCPT+/6CMe2s1546cujsWtjHeTP
	 v3biFxN9JPdssaCz6hqfpYlKKH6g+AOO3B9qmGF2b63fLnPoIUCt/h8UQlPd3YsHAA
	 VNxBJi/hv2glXa8POg3H8qB53pHiZ77nSwI+LF0BAjc3fGB+jBseOBlZEevzqvMvH4
	 2CBiudEtbly8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v9 2/8] selftests/bpf: Add basic libarena
 scaffolding
Reply-To: sashiko@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260426190338.4615-3-emil@etsalapatis.com>
References: <20260426190338.4615-3-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Apr 2026 19:34:10 +0000
Message-Id: <20260426193411.7FD73C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [Medium] Silent argument truncation in `arena_alloc_reserve` causing fewe=
r pages to be reserved than requested.
- [Medium] Buffer overflow in userspace `mincore()` array sizing if `syscon=
f(_SC_PAGESIZE)` differs from kernel `PAGE_SIZE`.
- [Low] Build Dependency Tracking Failure for libarena headers.
- [Low] Makefile logic flaw leading to silent test omission on name collisi=
on (vpath anti-pattern).
--

commit 7876e5868c676854bd421cbb98140a84f94fa226
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: Add basic libarena scaffolding

Add initial code and a Makefile for an arena-based BPF library. Modules
can be added just by including the source file in the library's src/
subdirectory.

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 6ef6872adbc3..5855064e7f9c 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile

[ ... ]

> @@ -525,6 +526,7 @@ LINKED_BPF_OBJS :=3D $(foreach skel,$(LINKED_SKELS),$=
($(skel)-deps))
>  LINKED_BPF_SRCS :=3D $(patsubst %.bpf.o,%.c,$(LINKED_BPF_OBJS))
> =20
>  HEADERS_FOR_BPF_OBJS :=3D $(wildcard $(BPFDIR)/*.bpf.h)		\
> +			$(wildcard $(CURDIR)/libarena/include/*.[ch])	\
>  			$(addprefix $(BPFDIR)/,	bpf_core_read.h	\
>  			                        bpf_endian.h	\
>  						bpf_helpers.h	\

Does this code miss changes to the newly introduced headers?

The headers common.h and userspace.h are located in the nested
libarena/include/libarena/ subdirectory. Since GNU Make's wildcard function
does not perform recursive searches, this evaluates to empty.=20

Modifications to the headers might silently fail to trigger a rebuild.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/libarena/Makefile b/tools/testin=
g/selftests/bpf/libarena/Makefile
> new file mode 100644
> index 000000000000..e85b3ad96890
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/Makefile

[ ... ]

> +# Scan src/ and selftests/ to generate the final binaries
> +LIBARENA_SOURCES =3D $(wildcard $(LIBARENA)/src/*.bpf.c) $(wildcard $(LI=
BARENA)/selftests/*.bpf.c)
> +LIBARENA_OBJECTS =3D $(notdir $(LIBARENA_SOURCES:.bpf.c=3D.bpf.o))

Could this cause test modules to be silently omitted on name collisions?

If a test module is added as selftests/foo.bpf.c when src/foo.bpf.c already
exists, notdir creates duplicate object names. Because of the vpath directi=
ve
used later in the Makefile, make will find the source file in src/ first and
compile it.=20

The bpftool utility will link the identical object twice, completely ignori=
ng
the test file in selftests/.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/common=
.h b/tools/testing/selftests/bpf/libarena/include/libarena/common.h
> new file mode 100644
> index 000000000000..92b67b20ed15
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/include/libarena/common.h

[ ... ]

> +struct arena_alloc_reserve_args {
> +	u64 nr_pages;
> +};

Will this silently truncate the number of requested pages?

The userspace API structure exposes a 64-bit nr_pages argument, which is
passed directly to the bpf_arena_reserve_pages BPF kfunc. However, the
internal BPF kfunc signature strictly takes a 32-bit integer.

If userspace requests a reservation exceeding 32 bits, the value will be
truncated by the BPF calling convention.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/usersp=
ace.h b/tools/testing/selftests/bpf/libarena/include/libarena/userspace.h
> new file mode 100644
> index 000000000000..0438a751d5fd
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/include/libarena/userspace.h

[ ... ]

> +static inline int libarena_get_globals_pages(int arena_get_globals_fd,
> +					     size_t arena_all_pages,
> +					     u64 *globals_pages)
> +{
> +	size_t pgsize =3D sysconf(_SC_PAGESIZE);
> +	void *arena_base;
> +	ssize_t i;
> +	u8 *vec;
> +	int ret;
> +
> +	ret =3D libarena_get_arena_base(arena_get_globals_fd, &arena_base);
> +	if (ret)
> +		return ret;
> +
> +	if (!arena_base)
> +		return -EINVAL;
> +
> +	vec =3D calloc(arena_all_pages, sizeof(*vec));
> +	if (!vec)
> +		return -ENOMEM;
> +
> +	if (mincore(arena_base, arena_all_pages * pgsize, vec) < 0) {

Can this cause a buffer overflow in the vec array?

The vec buffer is allocated to hold arena_all_pages bytes. The length passed
to the mincore syscall is calculated as arena_all_pages *
sysconf(_SC_PAGESIZE).

However, the kernel's mincore implementation determines the number of output
bytes by dividing the requested length by the kernel's internal page size. =
If
the userspace environment reports a page size larger than the kernel's, the
kernel could calculate a page count greater than arena_all_pages and write
past the end of the vec buffer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260426190338.4615=
-1-emil@etsalapatis.com?part=3D2
