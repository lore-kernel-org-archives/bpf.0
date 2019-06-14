Return-Path: <SRS0=1nN+=UN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59798C31E4B
	for <bpf@archiver.kernel.org>; Fri, 14 Jun 2019 16:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20D4C2183E
	for <bpf@archiver.kernel.org>; Fri, 14 Jun 2019 16:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ek7WPW1l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbfFNQtk (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 14 Jun 2019 12:49:40 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37140 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfFNQtk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Jun 2019 12:49:40 -0400
Received: by mail-qk1-f196.google.com with SMTP id d15so2098644qkl.4;
        Fri, 14 Jun 2019 09:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xGLh1XrgnhZOUucQhhPrW1F8VtojcwkzIIfnOkB9Xtw=;
        b=Ek7WPW1lT82gNISGED4ZrdfbnFVakB7iseeZxOgr0dowwInMcWw/TnzCBehnEKslBb
         /SeMG18Ue5q0DTxvZmBjej9s6ot+rwWzyr/4qHv51awGA3qLTOX9rMQUtkDG3sN4L2vH
         HCQ60CUjzB316QyW9nHePPFMm+5wqbOmdsmY7JtcsFW2EKYsLASfqq95LbvtNROldl5j
         2rR6Ul3N842yGj/p0LWNGygLsFU3sMXYEslkIw4a9upMN98qz7TWKfG3FETKUddvJ+ut
         ji2pKTVt65J9ETl9/AFnjnU2lF9r6bTTz0WkJ8ePad4AHmT2yz7BuFesXYwxQx3figMM
         S+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xGLh1XrgnhZOUucQhhPrW1F8VtojcwkzIIfnOkB9Xtw=;
        b=ieOtbkALDTomutPK6wR4En5/O7Dpn5oMmGhidsMVtoQOKJ3PBVBW9CLldfLWVqi3sS
         NqnGVvjYsEPK7gsshVVSiIlyZt/08sa1eJlS+OS5t62Q4JAAnrGpb6KLfcWBQGXzjUrw
         fKiXISAXIu1fgqNBUq3L0oWEsXYDVycocmB9/bgOSfp50UqshosbcwjSaM02x6fRagVH
         B37AbMAAq0pTsy8GCtJv4GNpm2+cxGkhenuqT4Z8VEGcPhUOz+KxlVmmDzIfCdirQMad
         N2UIRys+LByictYMr4ST7+KDREFxMDlOZnMYza7gWjuOuXE50FTAr2uHedE9bFKojiwU
         IaAA==
X-Gm-Message-State: APjAAAVwRrLMTtVUkQAsIqY7stla1Au0lggJp8Va5v2jtCzl4Z0Aq03/
        V9GvCVDz+yg3WVu0mlG5dXxvKnswN46XEng2Hn8=
X-Google-Smtp-Source: APXvYqydzFvWyNBnYDV2jM4O9wSxkHYjk1FoOkqXaLGXQLEqVZoBCNXpTw/0HXUyXPzRoOmFtB08NHkgsEkKzg7gQqs=
X-Received: by 2002:a05:620a:14a8:: with SMTP id x8mr21466070qkj.35.1560530979737;
 Fri, 14 Jun 2019 09:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190614072557.196239-1-ast@kernel.org> <20190614072557.196239-9-ast@kernel.org>
In-Reply-To: <20190614072557.196239-9-ast@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 14 Jun 2019 09:49:28 -0700
Message-ID: <CAEf4Bzb0fjGFK5-KNM9dzdJ0y6oGR5OVTCC5OJ46kRXkWZvy1A@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 8/9] selftests/bpf: add realistic loop tests
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 14, 2019 at 12:26 AM Alexei Starovoitov <ast@kernel.org> wrote:
>
> Add a bunch of loop tests. Most of them are created by replacing
> '#pragma unroll' with '#pragma clang loop unroll(disable)'
>
> Several tests are artificially large:
>   /* partial unroll. llvm will unroll loop ~150 times.
>    * C loop count -> 600.
>    * Asm loop count -> 4.
>    * 16k insns in loop body.
>    * Total of 5 such loops. Total program size ~82k insns.
>    */
>   "./pyperf600.o",
>
>   /* no unroll at all.
>    * C loop count -> 600.
>    * ASM loop count -> 600.
>    * ~110 insns in loop body.
>    * Total of 5 such loops. Total program size ~1500 insns.
>    */
>   "./pyperf600_nounroll.o",
>
>   /* partial unroll. 19k insn in a loop.
>    * Total program size 20.8k insn.
>    * ~350k processed_insns
>    */
>   "./strobemeta.o",
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> Acked-by: Andrii Nakryiko <andriin@fb.com>
> ---

<snip>

> diff --git a/tools/testing/selftests/bpf/progs/strobemeta.c b/tools/testing/selftests/bpf/progs/strobemeta.c
> new file mode 100644
> index 000000000000..d3df3d86f092
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/strobemeta.c
> @@ -0,0 +1,10 @@
> +// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)

given strobemeta.h is GPL-2, this should probably be same

> +// Copyright (c) 2019 Facebook
> +
> +#define STROBE_MAX_INTS 2
> +#define STROBE_MAX_STRS 25
> +#define STROBE_MAX_MAPS 100
> +#define STROBE_MAX_MAP_ENTRIES 20
> +/* full unroll by llvm #undef NO_UNROLL */
> +#include "strobemeta.h"
> +
> diff --git a/tools/testing/selftests/bpf/progs/strobemeta.h b/tools/testing/selftests/bpf/progs/strobemeta.h
> new file mode 100644
> index 000000000000..1ff73f60a3e4
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/strobemeta.h
> @@ -0,0 +1,528 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2019 Facebook
> +

<snip>

> +char _license[] SEC("license") = "GPL";
> diff --git a/tools/testing/selftests/bpf/progs/strobemeta_nounroll1.c b/tools/testing/selftests/bpf/progs/strobemeta_nounroll1.c
> new file mode 100644
> index 000000000000..f0a1669e11d6
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/strobemeta_nounroll1.c
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)

... and here

> +// Copyright (c) 2019 Facebook
> +
> +#define STROBE_MAX_INTS 2
> +#define STROBE_MAX_STRS 25
> +#define STROBE_MAX_MAPS 13
> +#define STROBE_MAX_MAP_ENTRIES 20
> +#define NO_UNROLL
> +#include "strobemeta.h"
> diff --git a/tools/testing/selftests/bpf/progs/strobemeta_nounroll2.c b/tools/testing/selftests/bpf/progs/strobemeta_nounroll2.c
> new file mode 100644
> index 000000000000..4291a7d642e7
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/strobemeta_nounroll2.c
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)

... and here

> +// Copyright (c) 2019 Facebook
> +
> +#define STROBE_MAX_INTS 2
> +#define STROBE_MAX_STRS 25
> +#define STROBE_MAX_MAPS 30
> +#define STROBE_MAX_MAP_ENTRIES 20
> +#define NO_UNROLL
> +#include "strobemeta.h"

<snip>
