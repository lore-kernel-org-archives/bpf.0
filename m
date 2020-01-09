Return-Path: <SRS0=lXkO=26=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACDBC33CA3
	for <bpf@archiver.kernel.org>; Thu,  9 Jan 2020 01:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851D12067D
	for <bpf@archiver.kernel.org>; Thu,  9 Jan 2020 01:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578531912;
	bh=FNlmc+/eAgBXxoCL8FGWCsvNNUglyxf7b3ZtgzFhf18=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VG4YFRNPsM4DTImJfhVNE3zq96IeXmehzMw5EXFu/JNoKniexch7ksfNCGzLErrNl
	 7skI/xUF9CXfHS9RKddBPvNOj6vVDAyCa4t6lkD+rPxNQ0I0Z7ASnxkvlrs8OS73HL
	 LMUBrZls4BLli+5dMCF0+ZMCYUR2tfzBZvI/edg0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgAIBFK (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 8 Jan 2020 20:05:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:58976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbgAIBFK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Jan 2020 20:05:10 -0500
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCBC02072A;
        Thu,  9 Jan 2020 01:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578531909;
        bh=FNlmc+/eAgBXxoCL8FGWCsvNNUglyxf7b3ZtgzFhf18=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WeaTpxeV9OAgLar52QwUtI3qK7yFzKuYCCJIGy+UVVyku76D09Otq/YfzEIuNKR9S
         tqNL/T3KyG9thrh8orphIlmOoQprjpC2NLl9SsiQlmytZ0vMWXeUKxWQMQmzjLCo5U
         lZt4ZwGfBiokTAmrDUdA9XoeICVpbHJ+DuL511Ps=
Received: by mail-qv1-f50.google.com with SMTP id n8so2273520qvg.11;
        Wed, 08 Jan 2020 17:05:09 -0800 (PST)
X-Gm-Message-State: APjAAAUUN00Xf3MqbEy29YkGZVLRYhSCXiNClhFFFyPrT9Xx6iwvKJ8q
        gaeSxHk2+Et04QZIcCN9OzfQIsdqfPWFIe7n904=
X-Google-Smtp-Source: APXvYqxmjiW+C9Z/rsYFmn2j5Y0xCdedwR5S6HI5cRWGgaN9Qz3VysE8C8EzQwxHlIihyiw/OfzIvfijh61/lmIy0oU=
X-Received: by 2002:a05:6214:923:: with SMTP id dk3mr6437811qvb.96.1578531908825;
 Wed, 08 Jan 2020 17:05:08 -0800 (PST)
MIME-Version: 1.0
References: <20200108192132.189221-1-sdf@google.com> <CAGdtWsS7hBF0d8F_Nidar-c+NRsDSwbk6K=cXbAOu-0kW74F8g@mail.gmail.com>
In-Reply-To: <CAGdtWsS7hBF0d8F_Nidar-c+NRsDSwbk6K=cXbAOu-0kW74F8g@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 8 Jan 2020 17:04:56 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6_Xwo3x59B==NhnboQFY_xFqO8vn+OXeXzhnKGjyJiGg@mail.gmail.com>
Message-ID: <CAPhsuW6_Xwo3x59B==NhnboQFY_xFqO8vn+OXeXzhnKGjyJiGg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: restore original comm in test_overhead
To:     Petar Penkov <ppenkov.kernel@gmail.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 8, 2020 at 3:19 PM Petar Penkov <ppenkov.kernel@gmail.com> wrote:
>
> On Wed, Jan 8, 2020 at 11:49 AM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > test_overhead changes task comm in order to estimate BPF trampoline
> > overhead but never sets the comm back to the original one.
> > We have the tests (like core_reloc.c) that have 'test_progs'
> > as hard-coded expected comm, so let's try to preserve the
> > original comm.
> >
> > Currently, everything works because the order of execution is:
> > first core_recloc, then test_overhead; but let's make it a bit
> > future-proof.
> >
> > Other related changes: use 'test_overhead' as new comm instead of
> > 'test' to make it easy to debug and drop '\n' at the end.
> >
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
>
> Acked-by: Petar Penkov <ppenkov@google.com>

Acked-by: Song Liu <songliubraving@fb.com>
