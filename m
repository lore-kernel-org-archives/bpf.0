Return-Path: <SRS0=zGgN=4G=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13685C34031
	for <bpf@archiver.kernel.org>; Tue, 18 Feb 2020 21:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D919B2173E
	for <bpf@archiver.kernel.org>; Tue, 18 Feb 2020 21:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dp2yWu0t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgBRV3j (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 18 Feb 2020 16:29:39 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33819 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgBRV3j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Feb 2020 16:29:39 -0500
Received: by mail-qk1-f193.google.com with SMTP id c20so21072734qkm.1;
        Tue, 18 Feb 2020 13:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OrdDkIMDWhhABSmakNixMXmfGtr8QsZxJzVPjLWIkfU=;
        b=Dp2yWu0tAN3p4J5E7bAGj7wKakRGPfsizzsbUpzlHOXm84hbrFYHox7r65h9FLA+Ba
         Z+OYEzg6eNSfiwtPTSSjbY/wWmU/LryxaxwcH4WLJGqEM00jQnJ37XpE8zm4PP/Tp3BR
         IJzOjWn5cebjb9xGzuLzVh0kChRyVxgWy1jTwO0TL2VaaVqbXYmYB5QQ6/UNqbh428y6
         YlZyhpBp5VXUgkiS0YQ3I4c+hFPS+7BFh2WN2h4hGAh5zbzzxU6CC6xzyXw6brhH1/0t
         jX8ngNsuHt5S9linCyWzJjUwIK+MMc3ZCLuqI4JzkIp36zl4rp//4Q4U6l17HFH29nQq
         geDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OrdDkIMDWhhABSmakNixMXmfGtr8QsZxJzVPjLWIkfU=;
        b=tVcYkR7dHdykUqZrI/8ndTb/tKhnafhMZ8zsUKFS45yIx96ooSclf1XC2o06HtqRUc
         fMKCibFSYeycct9bz+m6Mbq3IQ0WeR30thJseocJcpwWAkn0Ch23jhejmuQDQs1ADxmV
         1TLhDUG86auKrgv2KGKAPmAoQN7OjeraXHet4Ijvztrmat1mTgxKb7jIEyy1tJe+4SFi
         mtrJkFEmO6QnQ27aTzZJuwFt8AMEHji90pttD9Aus8x48VJAKwFzaXfYG2+iVbkK+9ez
         GFWahj1gVlisVBFSDxvammoo05fm0WSbTSiPu7U6Pbj1ZA2YsiZYn+46RmmIPsjsOZef
         H60w==
X-Gm-Message-State: APjAAAUCQy3CBXQhH9X7jRBUWm9r7AhPPEDHu/IIlcK6VmzB2gb0iMc8
        l7+otu+iYEb4xQknojAZs7Tlaqv5XD34Iqxs0jA=
X-Google-Smtp-Source: APXvYqxjkxAsqWVLPzMbXkR3lkgZU0ccbUxFBgO1vVsNjZO397cAYGAzXmyQEdA+DhxQMr1nNx77gFF9y1Wy7t6cZFI=
X-Received: by 2002:a37:9d03:: with SMTP id g3mr20820108qke.39.1582061378329;
 Tue, 18 Feb 2020 13:29:38 -0800 (PST)
MIME-Version: 1.0
References: <20200218030432.4600-1-dxu@dxuuu.xyz> <20200218030432.4600-3-dxu@dxuuu.xyz>
In-Reply-To: <20200218030432.4600-3-dxu@dxuuu.xyz>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 18 Feb 2020 13:29:27 -0800
Message-ID: <CAEf4Bza-JRpWhfFr54R-th5EwqB7EmyCV8irZd56YkZ8rOjEDQ@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 2/2] selftests/bpf: add bpf_read_branch_records()
 selftest
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        open list <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Peter Ziljstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 17, 2020 at 7:06 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Add a selftest to test:
>
> * default bpf_read_branch_records() behavior
> * BPF_F_GET_BRANCH_RECORDS_SIZE flag behavior
> * error path on non branch record perf events
> * using helper to write to stack
> * using helper to write to global
>
> On host with hardware counter support:
>
>     # ./test_progs -t perf_branches
>     #27/1 perf_branches_hw:OK
>     #27/2 perf_branches_no_hw:OK
>     #27 perf_branches:OK
>     Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
>
> On host without hardware counter support (VM):
>
>     # ./test_progs -t perf_branches
>     #27/1 perf_branches_hw:OK
>     #27/2 perf_branches_no_hw:OK
>     #27 perf_branches:OK
>     Summary: 1/2 PASSED, 1 SKIPPED, 0 FAILED
>
> Also sync tools/include/uapi/linux/bpf.h.
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  tools/include/uapi/linux/bpf.h                |  25 ++-
>  .../selftests/bpf/prog_tests/perf_branches.c  | 169 ++++++++++++++++++
>  .../selftests/bpf/progs/test_perf_branches.c  |  50 ++++++
>  3 files changed, 243 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_branches.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_perf_branches.c
>

[...]
