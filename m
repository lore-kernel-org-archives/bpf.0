Return-Path: <SRS0=QOwA=AE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E17C433E1
	for <bpf@archiver.kernel.org>; Tue, 23 Jun 2020 06:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C43AB20724
	for <bpf@archiver.kernel.org>; Tue, 23 Jun 2020 06:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2p7L2Qg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731115AbgFWG6N (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 23 Jun 2020 02:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730708AbgFWG6M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Jun 2020 02:58:12 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD381C061573;
        Mon, 22 Jun 2020 23:58:10 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id e11so8633514qkm.3;
        Mon, 22 Jun 2020 23:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nyo2r2LEvlsKPZhmSHxdeccpwBZZClSTN6GmMhFTyq4=;
        b=f2p7L2QgqxVDZmGgVDu165dxtrByfojCj3yzlGpNVqmvqBHyhhxA35oH9/362ZWdJ7
         QzQGICrXlzXgd04UETMYVOFpCDKOOgZjOhgLOTXS4RelhV/diC4stmsHr/i0cwg2bY7l
         CePMhtkH/ixOs1I1L6n7QTyZ6uLBeIe9IuxRiV0zFcLj5vd/XZPlsf2KYbkpmJ3W8kMQ
         2El+Kk8ErDdJyqQYEmMX/9VR2ilUvyRyDjwjwVXD/eokclE0OV9Q8s+hibS3/io+j3lz
         FGgmoAkIN4EVvU1jAx6NScvpBUYF5hviv/3Qus4K1STTFbNGAO0EgcYpjLg0x8863Ckd
         FbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nyo2r2LEvlsKPZhmSHxdeccpwBZZClSTN6GmMhFTyq4=;
        b=XxNGyN0JOcdEBFiTi7zxCbBP2CmNVEEf2VFQtdMxdt1PT2abJ7TYesAg8acohE6WNw
         5WYaG/jEIQCIBpmde5tsKsX6+zNZ9XFzB3094sxrcZCfQtSMw0zJ0QSQD2FiFaGQjjyW
         6ARCT0iOVMq/ZRVGvwI4l7d3k3JCTehipeYdi+Sz6mK72cZUV5rFwx7/WJp2ph0qBLbI
         AlwqcHAyIwrtViZoXFwtsbqQHs/WrtjOV9v1YqSm6JRYkIzGpKEP+DC/c4HHgKljaSsT
         d/EdY0GkwKWfPJoY1vKMzS2p9etLCzXa5ikaJneMBZhGM5ZkmepBYAoqy8ae/42h9t4G
         qy3A==
X-Gm-Message-State: AOAM5319o+dk465iJ8IgjOp5fMnJdbcoJ8ETiKoDYNGyR3/sm+3EFRY/
        FI/X0wYkGK4/+FJjsSJEih5VWBSs7jM26apqzI8=
X-Google-Smtp-Source: ABdhPJz2siEm/I32cHFdjGHY4wviP7MEgHSZ9P4gQUVKlScB0Y3s9PCfbhIw2tVYLO/qanPu4ImJvN1uQDVUon5tcuM=
X-Received: by 2002:a37:d0b:: with SMTP id 11mr20276847qkn.449.1592895489911;
 Mon, 22 Jun 2020 23:58:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200623003626.3072825-1-yhs@fb.com> <20200623003642.3075027-1-yhs@fb.com>
In-Reply-To: <20200623003642.3075027-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 22 Jun 2020 23:57:59 -0700
Message-ID: <CAEf4BzZB+dBR8be3FYjHNqn+artvu_Ca21uLuZeVrhDvL6FDQA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 14/15] tools/bpf: add udp4/udp6 bpf iterator
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 22, 2020 at 5:38 PM Yonghong Song <yhs@fb.com> wrote:
>
> On my VM, I got identical results between /proc/net/udp[6] and
> the udp{4,6} bpf iterator.
>
> For udp6:
>   $ cat /sys/fs/bpf/p1
>     sl  local_address                         remote_address                        st tx_queue rx_queue tr tm->when retrnsmt   uid  timeout inode ref pointer drops
>    1405: 000080FE00000000FF7CC4D0D9EFE4FE:0222 00000000000000000000000000000000:0000 07 00000000:00000000 00:00000000 00000000   193        0 19183 2 0000000029eab111 0
>   $ cat /proc/net/udp6
>     sl  local_address                         remote_address                        st tx_queue rx_queue tr tm->when retrnsmt   uid  timeout inode ref pointer drops
>    1405: 000080FE00000000FF7CC4D0D9EFE4FE:0222 00000000000000000000000000000000:0000 07 00000000:00000000 00:00000000 00000000   193        0 19183 2 0000000029eab111 0
>
> For udp4:
>   $ cat /sys/fs/bpf/p4
>     sl  local_address rem_address   st tx_queue rx_queue tr tm->when retrnsmt   uid  timeout inode ref pointer drops
>    2007: 00000000:1F90 00000000:0000 07 00000000:00000000 00:00000000 00000000     0        0 72540 2 000000004ede477a 0
>   $ cat /proc/net/udp
>     sl  local_address rem_address   st tx_queue rx_queue tr tm->when retrnsmt   uid  timeout inode ref pointer drops
>    2007: 00000000:1F90 00000000:0000 07 00000000:00000000 00:00000000 00000000     0        0 72540 2 000000004ede477a 0
> ---

patch subject prefix is misleading: tools/bpf -> selftests/bpf?

Otherwise:

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  tools/testing/selftests/bpf/progs/bpf_iter.h  | 16 ++++
>  .../selftests/bpf/progs/bpf_iter_udp4.c       | 71 +++++++++++++++++
>  .../selftests/bpf/progs/bpf_iter_udp6.c       | 79 +++++++++++++++++++
>  3 files changed, 166 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_udp4.c
>  create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_udp6.c
>

[...]
