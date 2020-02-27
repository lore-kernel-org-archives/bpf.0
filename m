Return-Path: <SRS0=DkpX=4P=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375D8C4BA24
	for <bpf@archiver.kernel.org>; Thu, 27 Feb 2020 05:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31B624679
	for <bpf@archiver.kernel.org>; Thu, 27 Feb 2020 05:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582782645;
	bh=7+AymGkpgCvTVed8pXjGExj3prYwnBhgL/+sRv0lwx0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YlwkdRqBdqXEdPyjwqyO6n0Qpj2hVbFUp9lL8lwL2t8Twh8i29kctPR5F+Sj7NJfc
	 eZATGh08bZPhht9Jr6QQUIGtSRuUcEUouThDIEkk4vxq01F4NBw2Z5BSwnlHn+0GJa
	 5wxzmo56wLt2qfksdV0nfvJ5Nb1Lmau1aaaQ/+SE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgB0Fuo (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 27 Feb 2020 00:50:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:53606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbgB0Fuo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Feb 2020 00:50:44 -0500
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A805024680;
        Thu, 27 Feb 2020 05:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582782644;
        bh=7+AymGkpgCvTVed8pXjGExj3prYwnBhgL/+sRv0lwx0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k4Hl+bujJWPDMuKBnwFaE2Mf2Y25igI/gcmPm53ZzJxkiirmX6TZpVx0zjhYEyVWG
         hzbeln/3tpbqdGSZ08dABwL/hOtx+jKHfc/M1e7GMqreas5D3XiAEwd8ZzXhSWckGF
         dd+tFmfJ5pqgjz/ENKHInp5km8isJ2vIAsF73AkU=
Received: by mail-lf1-f45.google.com with SMTP id y17so1105593lfe.8;
        Wed, 26 Feb 2020 21:50:43 -0800 (PST)
X-Gm-Message-State: ANhLgQ3rO5KwRTvN4AVPaRVjo+MztKH4qsLmK4RRxzlVZ6R8A75wuZrL
        tQFzRGkZ61yxcn0tadPZ/b9npt50ZUX7l/E2vbQ=
X-Google-Smtp-Source: ADFU+vuw0MYnlKbnUhFFuXrFa1ekwqxq5TT8UqPXLURZOWtSogZrGUuOOMpXZ0iE4LoeYjbCwoFTJbH7rZhrBhQm56A=
X-Received: by 2002:ac2:52a2:: with SMTP id r2mr1136598lfm.33.1582782641730;
 Wed, 26 Feb 2020 21:50:41 -0800 (PST)
MIME-Version: 1.0
References: <20200226130345.209469-1-jolsa@kernel.org> <20200226130345.209469-17-jolsa@kernel.org>
In-Reply-To: <20200226130345.209469-17-jolsa@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Wed, 26 Feb 2020 21:50:30 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4cupgimwMHYzHXuTynxgs6oWuw46Z6DW2oyyAuszExmQ@mail.gmail.com>
Message-ID: <CAPhsuW4cupgimwMHYzHXuTynxgs6oWuw46Z6DW2oyyAuszExmQ@mail.gmail.com>
Subject: Re: [PATCH 16/18] perf tools: Synthesize bpf_trampoline/dispatcher
 ksymbol event
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

On Wed, Feb 26, 2020 at 5:06 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Synthesize bpf images (trampolines/dispatchers) on start,
> as ksymbol events from /proc/kallsyms. Having this perf
> can recognize samples from those images and perf report
> and top shows them correctly.
>
> The rest of the ksymbol handling is already in place from
> for the bpf programs monitoring, so only the initial state
> was needed.
>
> perf report output:
>
>   # Overhead  Command     Shared Object                  Symbol
>
>     12.37%  test_progs  [kernel.vmlinux]                 [k] entry_SYSCALL_64
>     11.80%  test_progs  [kernel.vmlinux]                 [k] syscall_return_via_sysret
>      9.63%  test_progs  bpf_prog_bcf7977d3b93787c_prog2  [k] bpf_prog_bcf7977d3b93787c_prog2
>      6.90%  test_progs  bpf_trampoline_24456             [k] bpf_trampoline_24456
>      6.36%  test_progs  [kernel.vmlinux]                 [k] memcpy_erms
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Song Liu <songliubraving@fb.com>
