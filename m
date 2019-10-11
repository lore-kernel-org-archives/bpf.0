Return-Path: <SRS0=XZ9j=YE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B332ECE58E
	for <bpf@archiver.kernel.org>; Fri, 11 Oct 2019 19:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3031214E0
	for <bpf@archiver.kernel.org>; Fri, 11 Oct 2019 19:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/WAORc1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbfJKTFq (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 11 Oct 2019 15:05:46 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34767 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbfJKTFq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Oct 2019 15:05:46 -0400
Received: by mail-qk1-f193.google.com with SMTP id q203so9891631qke.1;
        Fri, 11 Oct 2019 12:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z8abiypIqXEyKvwUzdpOHIek/RcCjFaTvZmzrf90OJQ=;
        b=R/WAORc1FWUt8kCvTwZUU8P4Hh0W1Ecrj7nk7TekP8GvBaFJk83l63fdEMHhGks5UK
         r62Xwa/JbNk9CVp8VWxZb4QIxuoShzYcMXgAgRCsj0srGoIEKbOV2qZH4wGkRkhuSabz
         w96z3ppY7nGZpT/mdPDHzK/ep4snWKff/fTT1GsUCgBsLqaGpsCsc/JJ6PsXLFYa0kMK
         3MMXGbepSyXTUWxmgdpcmTd+g3bRMPlcg7sZs1yulIvCslS2KjczSVAEh6i9dp1pK0A+
         5P/0DOgYvXvy9K+FiwkGEaqqPPX8yOwAvrv1g+ti9EAEta6S2ef3ztq+2cEDX0bZPO4y
         vdtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z8abiypIqXEyKvwUzdpOHIek/RcCjFaTvZmzrf90OJQ=;
        b=gNuKVk/Grqn4o/WQpbQOzO/dC9HDdmW+hAbNYuSRfXzVdwHSVHZTp0AlFQ4MbP4mLi
         KJyHg/VANOd5tZMJHvf61oVzRvk6tC6Vs8K8Gc5q/Fsh2fY4ZFlrWbOouwCsnvy0p2dw
         pFLVFCoDtkPLYG7QEdvbreYBBVdTfwNU+hzmL/tU8P12OXftuGbdx+WyNzOL/dJFzLhp
         MwVVawC1mFCM7XJmITfI5nnaaEajewE/7n27HBF/GLSC67shDKJhdzZxvyM2xVcPaOhf
         ZGDHFDI0JOWwHjBz6zx4P/Z3dsq6ab8TfiSyc2eyXaRQ4qBE4NRz6BzFD7C3r7ZausBZ
         YOMw==
X-Gm-Message-State: APjAAAV0VhJYOYYvZZz2hbVRxRTdwGXpWg6omuvwB454opDpws95NnAw
        tiw3llAVMpGn16NEQ246fHOdVYqGnr0/ZgG3mXg=
X-Google-Smtp-Source: APXvYqx/YqTHKd/nba+4J5fo86Lm3KhMiC5nlrZJlX7lqBc4a+JqM9gXQfk7ynNULADg4Hj1/HxWezVQFg5AgkRu4Xs=
X-Received: by 2002:a37:a8c8:: with SMTP id r191mr17132936qke.92.1570820743810;
 Fri, 11 Oct 2019 12:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <20191010041503.2526303-1-ast@kernel.org> <20191010041503.2526303-13-ast@kernel.org>
In-Reply-To: <20191010041503.2526303-13-ast@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 11 Oct 2019 12:05:32 -0700
Message-ID: <CAEf4BzbDQH6AaSJdA5YUTQiAH8co_nBbZZ30W=8k+JB_xPWEMA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 12/12] selftests/bpf: add kfree_skb raw_tp test
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>, x86@kernel.org,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 9, 2019 at 9:15 PM Alexei Starovoitov <ast@kernel.org> wrote:
>
> Load basic cls_bpf program.
> Load raw_tracepoint program and attach to kfree_skb raw tracepoint.
> Trigger cls_bpf via prog_test_run.
> At the end of test_run kernel will call kfree_skb
> which will trigger trace_kfree_skb tracepoint.
> Which will call our raw_tracepoint program.
> Which will take that skb and will dump it into perf ring buffer.
> Check that user space received correct packet.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> Acked-by: Andrii Nakryiko <andriin@fb.com>
> ---
>  .../selftests/bpf/prog_tests/kfree_skb.c      | 90 +++++++++++++++++++
>  tools/testing/selftests/bpf/progs/kfree_skb.c | 74 +++++++++++++++
>  2 files changed, 164 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/kfree_skb.c
>  create mode 100644 tools/testing/selftests/bpf/progs/kfree_skb.c
>

[...]

> +
> +void test_kfree_skb(void)
> +{
> +       struct bpf_prog_load_attr attr = {
> +               .file = "./kfree_skb.o",
> +               .log_level = 2,

This is rather verbose and memory-consuming. Do you really want to
leave it at 2?


> +       };
> +
> +       struct bpf_object *obj, *obj2 = NULL;
> +       struct perf_buffer_opts pb_opts = {};
> +       struct perf_buffer *pb = NULL;
> +       struct bpf_link *link = NULL;
> +       struct bpf_map *perf_buf_map;
> +       struct bpf_program *prog;
> +       __u32 duration, retval;
> +       int err, pkt_fd, kfree_skb_fd;
> +       bool passed = false;
> +

[...]
