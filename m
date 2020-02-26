Return-Path: <SRS0=7UPC=4O=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52406C4BA24
	for <bpf@archiver.kernel.org>; Wed, 26 Feb 2020 23:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A0DC24670
	for <bpf@archiver.kernel.org>; Wed, 26 Feb 2020 23:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582758623;
	bh=KspIpxU2HtokbKj86svjFj5TLHdIJJWX3Q9t2yMeTgk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GXcPExzkzmOxzyjqXiefmLYMHD9hhRgE9DCm/i6fq+LQ+EXkJeUSqaUoVD9bQkhZN
	 93y7orcxUkrbimh7+vlCKFGwGa6veGNNavC2ZHjq0FnmqNjFzmX+PV64QGYrZoTpiL
	 xHH+Y2/1U0H4xgmiqpIfN0c2HrGxfVw625/4XIhM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgBZXKW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 26 Feb 2020 18:10:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:50448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbgBZXKW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Feb 2020 18:10:22 -0500
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D93424672;
        Wed, 26 Feb 2020 23:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582758621;
        bh=KspIpxU2HtokbKj86svjFj5TLHdIJJWX3Q9t2yMeTgk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E8nBEp45AboIvLGHvZR8GoCLYlbvJMHZXZalUpg13oBjV4eWPmU5icN9xgfWOFFUD
         k4yuLScfYAXAqfoUlEJeY74wbfucrSGNFFMc6X9H+V1PcjMKblRz4WthZ6aSkMcr9f
         m9pqKhZeq0qp+n336uK3cS5Yz3WlkcdkfICin3yg=
Received: by mail-lj1-f175.google.com with SMTP id 143so943765ljj.7;
        Wed, 26 Feb 2020 15:10:21 -0800 (PST)
X-Gm-Message-State: ANhLgQ2GdPjmPC5Q+66j7CM4DLQW7rxAJnoBugg6xePp/+wvCeaqKzVQ
        oGcbIibCbjQoKcrOeUR6lWsqucxEGWsIVQG/uRM=
X-Google-Smtp-Source: ADFU+vv0ZmmFo2/2vJ2clO/40f67XJutw73Y69Xvj72xloPaCNGT+S+AbQYRdi+cssYzSiL/qbgJtlFNBQE/W0kQAvg=
X-Received: by 2002:a2e:b017:: with SMTP id y23mr798375ljk.229.1582758619735;
 Wed, 26 Feb 2020 15:10:19 -0800 (PST)
MIME-Version: 1.0
References: <20200226130345.209469-1-jolsa@kernel.org> <20200226130345.209469-7-jolsa@kernel.org>
In-Reply-To: <20200226130345.209469-7-jolsa@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Wed, 26 Feb 2020 15:10:08 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5OUKMhCqh8qRq4dC5dgeb56b4LbbODVGwo6R0woV3fTg@mail.gmail.com>
Message-ID: <CAPhsuW5OUKMhCqh8qRq4dC5dgeb56b4LbbODVGwo6R0woV3fTg@mail.gmail.com>
Subject: Re: [PATCH 06/18] bpf: Add bpf_ksym_tree tree
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Jakub Kicinski <kuba@kernel.org>,
        David Miller <davem@redhat.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 26, 2020 at 5:04 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> The bpf_tree is used both for kallsyms iterations and searching
> for exception tables of bpf programs, which is needed only for
> bpf programs.
>
> Adding bpf_ksym_tree that will hold symbols for all bpf_prog
> bpf_trampoline and bpf_dispatcher objects and keeping bpf_tree
> only for bpf_prog objects to keep it fast.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Song Liu <songliubraving@fb.com>
