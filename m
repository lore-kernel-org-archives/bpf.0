Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A9A3D3013
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 17:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775582062; cv=pass; b=eZ8+iSSagdNrsUUNigZE4DJkzBiYUjhc+xpLmohFoGKPLZB5ECiCYhVaOKquhENULjZNliq5890R1vLJLSbH8K6mX6q9oIpIqxqJUfhu4qc+4Msxc4dDSkJodNFIDnKDV+6A2R4SHr7H2SEgguELJyLWf0bCYHwJhqufhwpesvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775582062; c=relaxed/simple;
	bh=dy1dAkAi7atI05h3RqQYlEy6l3E9my8owU933If9zoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VaYP2FTMrywGvKLrzlN1F63Fig8ykcSDFXT5tk8Q17FvaFJdwokTrK7uUBmp3QuEnkqPPLokO8FBhslDrGiHTd09KDZ+B1UzMmZ6opsgU/DyHG7skFT2sSUMrvGqemeAw+FNxqusKvFQ6KSGBM5tYjBk5asrQVSD3YSYs0SJm9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMnJuIjo; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMnJuIjo"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4887ca8e529so949775e9.0
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 10:14:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775582059; cv=none;
        d=google.com; s=arc-20240605;
        b=V931RMuHAZIyoDuLx2pk/zYTaEfWwXqACCxyb3Suz6jt2OdvadXkbTch8xkYw41gFU
         KZ+dG1MYYLilOi2VhYPTW+jjCJX90c7gT672OJLBrsF8M40wmn/iikFpGLnmrSXcLteU
         di72320fm/FXo8U0WqLaODwmT1X3MbfHF2PBoBK8wJHqSPaCwNdOkVv1D3q2s7uzcALI
         MpKnMgJgnb1zal9P5Yj4gnG4pE9hVVdioOmDHs5FIn1nCjvoV1QFSINCVKtxOj/LOP9z
         Yfnyi0MR/mG0Dv+nZ6tkNLq+Fyag7SWxHYcTI754K3l2n0P4QRpB00WNAVYjW9eDcgTh
         /dzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OEH72aAWp8XCqlratPIiBXNG34ysAfQLD/u47iRlaEU=;
        fh=hfRje2veXRgnK/5UbF368BTRuTdPC/oA5JvW+CkXkIA=;
        b=ZQDTrKuVGXCH/UnnlwtkawPwkl/oFmmyvVZnVzQ/Jh47jo0sqyb4NVqo7jBFJ3hUs8
         5LUiKCwYG5UHBulDhjPtBfaAs57fTJBuw7dlrjfQbUwN4C3hHDuJtCkVcAlwyTVnqxUv
         LwzS9F3PbfEaSv9sNyMfLikWrZ/xMWT4dvCxLU5hZWVvB+HnRpR/cLzLhSeR5CmMCG7B
         NuV2F24F1URehuys7dHpFLhd7ReeTHbT3bj3YPJFZfetGGCpFF+Bk67o9/hSRsER7g8e
         IC8XZIDU4mvi2y5a+Xs4x8p8Q0sGk5nHW+lZUnqDWWYDwV8BooKQ7I2xDwhvGu8KGaGw
         E95Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775582059; x=1776186859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEH72aAWp8XCqlratPIiBXNG34ysAfQLD/u47iRlaEU=;
        b=MMnJuIjorXhUJoWDqpSUJeyKT2jSU64ljkcd5/rSCISOrQyI9FT8cQeo2DZ9/rpTq4
         WKjoLc6bypD9SyWhR/+4MXyjDvazzqMUd4Xc5WJhee2R4BKddbWIUpj7KC6V7eOYxNh8
         tIETtQEq8q8uWMRJ7GE9tHPhiyM+KAp99h7VhlAXiCHfrEAwD3JIangcHBI1NABR4RgW
         9R4cKpoz3ryAPxJ9JW8ipUhm8SethZyJLkPquWzUGBC8Wnkvglg0ssF5lVKrcfhhUdL7
         ewiAnKye3+/6QDe1ymGNxQoAw9iDZ9Z/4/HuZiUN6Okfej6eUY3pVO6IZYoL4HcPLTSQ
         zsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775582059; x=1776186859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OEH72aAWp8XCqlratPIiBXNG34ysAfQLD/u47iRlaEU=;
        b=dePQNuFCaw3xVsHE4ffCLQF99nmjvzBGIP1t6zmu8fA4ht4MBJRFvHMaLp0vpVA4wt
         JhEyHq9GaaPC1WBNr1kEqJLksh4ZtsF5NqYhOH2J/cLwKYXJ6xb0pieZPBQJS7AUFch9
         1Ev6mbpB4be+iqo8Qm5g7nPtJztMWXlyWXj/dJvaLQ7OxvH15opUnqQgsJDTLyXTgnB+
         7pXTAX9Di6XH8v+9q9oi/0hlgSnHibv+eY5xezCfxkdQrPCvwSqHSxRYq4MaObCBL6a9
         G7cq792SlnsIxEr6uHjuCrusnARLm3o7gLqFZbHOUWdJDY1Y4rLJnB3Klgrw37/DYy6I
         Z+rw==
X-Gm-Message-State: AOJu0YwsBP6R8U452HCidZUFEd4LQ2SpLe4ujzjTqcvBCsI6OOYngn+m
	gFTtTG3wsSapShjucT1CEOowaKCElUBR6JpFeGyZ6YnCamlVriPm9GPAA5j3uKp0XWsvvRwSej+
	4gsis4IvxDNFxsve7ENcrIttpCYbS44E=
X-Gm-Gg: AeBDieuHwlVc38P9zwy/kTrnMjqc6/yzCWJmVDtTZWTBuPyXWrMOI0v/l4Akvfb4YF8
	Q+wZP3tKUTrfpKwm/fCqa9O95asYeKrFYiOXiK+chbR13l5aWz3kKMBman8h5ZOj1qwu7dd+uCu
	EzV1vuC7RozR2jzVaohH0K//27ZoNMeZo1sRCF7wynFuiEhCbKn22WMeq5CjuphR7+JWDjRUkxO
	vdLvg/m0GgRal8Kc6KKSMU4Gy2wPzkfNb4Rucjqkz8QW7u7wnv4eP+DR+ncQrZY3SVLkKjrucCW
	cArTnhkS2YgLvJJuFuMgxS9icdTSAvHu2OUkBu0cg7z13fd9pyrJFRD8MSXwYWJT6ENyE74xQGd
	gfHbmIhwP6DH56hVWO5FuQIa8QA==
X-Received: by 2002:a05:600c:5c3:b0:488:aac9:7a31 with SMTP id
 5b1f17b1804b1-488aac97a8fmr86825545e9.0.1775582059235; Tue, 07 Apr 2026
 10:14:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407045730.13359-1-emil@etsalapatis.com> <20260407045730.13359-10-emil@etsalapatis.com>
In-Reply-To: <20260407045730.13359-10-emil@etsalapatis.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 7 Apr 2026 10:14:07 -0700
X-Gm-Features: AQROBzAj2LBfPpL-1fyAQT4t6hfr0Tuq9MeRbvUjGLwIwm0dO6ynxb2T4-xBNEw
Message-ID: <CAADnVQJwUdTTfG-KR9SYxjQyh21-6RmAC6JTSe9HDmHYpiNT6Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 9/9] selftests/bpf: Add selftests for libarena
 buddy allocator
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 9:57=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.co=
m> wrote:
>
> Introduce selftests for the buddy allocator without ASAN.
> Add the libarena selftests both to the libarena test
> runner and to test_progs, so that they are a) available when
> libarena is pulled as a standalone library, and b) exercised
> along with all other test programs in this directory.
>
> Currently ASAN for libarena requires LLVM 22, which is not
> available in the CI. Delay testing the ASAN case directly
> through test_progs until that is the case. The ASAN version
> is available for testing on demand through the library's own
> harness.
>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  .../bpf/libarena/selftests/selftest.c         |  12 +
>  .../libarena/selftests/st_asan_buddy.bpf.c    | 251 ++++++++++++++++++
>  .../bpf/libarena/selftests/st_buddy.bpf.c     | 230 ++++++++++++++++
>  .../selftests/bpf/prog_tests/libarena.c       |  44 +++
>  4 files changed, 537 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_asa=
n_buddy.bpf.c
>  create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_bud=
dy.bpf.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/libarena.c
>
> diff --git a/tools/testing/selftests/bpf/libarena/selftests/selftest.c b/=
tools/testing/selftests/bpf/libarena/selftests/selftest.c
> index 2bd8363ea614..ad7e00c2de0f 100644
> --- a/tools/testing/selftests/bpf/libarena/selftests/selftest.c
> +++ b/tools/testing/selftests/bpf/libarena/selftests/selftest.c
> @@ -137,6 +137,12 @@ error_no_destroy:                                  \
>         return ret;                                     \
>  }
>
> +TEST(test_buddy);
> +
> +#ifdef BPF_ARENA_ASAN
> +TEST(asan_test_buddy);
> +#endif
> +
>  static void
>  banner(const char *progpath)
>  {
> @@ -174,5 +180,11 @@ int main(int argc, char *argv[])
>
>         libbpf_set_print(libbpf_print_fn);
>
> +       run_test_buddy();
> +
> +#ifdef BPF_ARENA_ASAN
> +       run_asan_test_buddy();
> +#endif
> +
>         return 0;
>  }
> diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy=
.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c
> new file mode 100644
> index 000000000000..61b551639f6a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c
> @@ -0,0 +1,251 @@
> +// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +
> +#include <common.h>
> +
> +#include <asan.h>
> +#include <buddy.h>
> +
> +#include "selftest.h"
> +
> +
> +#ifdef BPF_ARENA_ASAN
> +
> +#include "st_asan_common.h"
> +
> +private(ST_BUDDY) struct buddy st_buddy_asan;
> +
> +u64 __arena st_asan_buddy_lock;
> +
> +static __always_inline int asan_test_buddy_oob_single(size_t alloc_size)
> +{
> +       u8 __arena *mem;
> +       int i;
> +
> +       ASAN_VALIDATE();
> +
> +       mem =3D buddy_alloc(&st_buddy_asan, alloc_size);
> +       if (!mem) {
> +               arena_stdout("buddy_alloc failed for size %lu", alloc_siz=
e);
> +               return -ENOMEM;
> +       }
> +
> +       ASAN_VALIDATE();
> +
> +       for (i =3D zero; i < alloc_size && can_loop; i++) {
> +               mem[i] =3D 0xba;
> +               ASAN_VALIDATE_ADDR(false, &mem[i]);
> +       }
> +
> +       mem[alloc_size] =3D 0xba;
> +       ASAN_VALIDATE_ADDR(true, &mem[alloc_size]);
> +
> +       buddy_free(&st_buddy_asan, mem);
> +
> +       return 0;
> +}
> +
> +/*
> + * Factored out because ASAN_VALIDATE_ADDR is complex enough to cause
> + * verification failures if verified with the rest of asan_test_buddy_ua=
f_single.
> + */
> +__weak int asan_test_buddy_byte(u8 __arena __arg_arena *mem, int i, bool=
 freed)
> +{
> +       /* The header in freed blocks doesn't get poisoned. */
> +       if (freed && BUDDY_HEADER_OFF <=3D i &&
> +               i < BUDDY_HEADER_OFF + sizeof(struct buddy_header))
> +               return 0;
> +
> +       mem[i] =3D 0xba;
> +       ASAN_VALIDATE_ADDR(freed, &mem[i]);

correcting my earlier comment...
ASAN_VALIDATE_ADDR() can be static inline function too.
So all 3 don't need to be macroses.
