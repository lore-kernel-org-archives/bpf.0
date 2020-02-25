Return-Path: <SRS0=/C52=4N=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B91DC35DEE
	for <bpf@archiver.kernel.org>; Tue, 25 Feb 2020 00:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635C12072D
	for <bpf@archiver.kernel.org>; Tue, 25 Feb 2020 00:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582591049;
	bh=lSqEwBt8JAuTSPB4Ufa8LgK5k1l9A6Ipvq2+Fp3Qcd0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OFkDdMe+Jjk7ZyR++5b0hbgs1Phvvhdra6KpjPDet2guCnqUZMe3MJVnN2fjL5wHU
	 qqrHvTYGqRmsYRssYlSomA6wmBJfIBmLIFwyjmJZGCYb23VHS64Zp4Jj0J5HiF/RHA
	 /l1YWCu2uGRATII56Z9CP1DLAzs3bk3bwIxyiz9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgBYAh3 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 24 Feb 2020 19:37:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:43320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727081AbgBYAh3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Feb 2020 19:37:29 -0500
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B186B2072D;
        Tue, 25 Feb 2020 00:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582591048;
        bh=lSqEwBt8JAuTSPB4Ufa8LgK5k1l9A6Ipvq2+Fp3Qcd0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tFranfzXwpE2/bt9OnzhXEP19V9AuY2zBXEuIQZl5EPPDWA8VdbWl6bwQ90RcxNN3
         TpLYutwSn/SqPMROXTYbDIpBa/GrkX19HYqz8mdiwwjmsZhOBARqOeizum5/K6lYk1
         DYP13/xnO6ADstRAHa8bDPojHiHke9+xuZwJ16HI=
Received: by mail-lf1-f53.google.com with SMTP id y17so5133967lfe.8;
        Mon, 24 Feb 2020 16:37:27 -0800 (PST)
X-Gm-Message-State: APjAAAUP14uRy3ezupFLb/qFPZobk50plzz5om7/d3LjxLEHSL1K+V5Z
        5MOYM2QBxBVlo8mdJefJa7naVdkAaVygkM8SoJk=
X-Google-Smtp-Source: APXvYqzui2YDbc9/NwiddbTVjui9mtdFUSIGuJGEUGnYJ3nQHP5LOzi7mjdZuj/8IaQCSVkhHJNdlmdb2p1Q9Pa/yQo=
X-Received: by 2002:ac2:47ec:: with SMTP id b12mr28919123lfp.162.1582591045905;
 Mon, 24 Feb 2020 16:37:25 -0800 (PST)
MIME-Version: 1.0
References: <20200221184650.21920-1-kafai@fb.com> <20200221184703.22967-1-kafai@fb.com>
In-Reply-To: <20200221184703.22967-1-kafai@fb.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 24 Feb 2020 16:37:14 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4SgovdeZGLgY+OkFtFLzGjmascLyV8Kf+ig7rJ3yNJdg@mail.gmail.com>
Message-ID: <CAPhsuW4SgovdeZGLgY+OkFtFLzGjmascLyV8Kf+ig7rJ3yNJdg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] inet_diag: Move the INET_DIAG_REQ_BYTECODE
 nlattr to cb->data
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Kernel Team <kernel-team@fb.com>,
        Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 21, 2020 at 10:47 AM Martin KaFai Lau <kafai@fb.com> wrote:
>
> The INET_DIAG_REQ_BYTECODE nlattr is currently re-found every time when
> the "dump()" is re-started.
>
> In a latter patch, it will also need to parse the new
> INET_DIAG_REQ_SK_BPF_STORAGES nlattr to learn the map_fds. Thus, this
> patch takes this chance to store the parsed nlattr in cb->data
> during the "start" time of a dump.
>
> By doing this, the "bc" argument also becomes unnecessary
> and is removed.  Also, the two copies of the INET_DIAG_REQ_BYTECODE
> parsing-audit logic between compat/current version can be
> consolidated to one.
>
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>

Acked-by: Song Liu <songliubraving@fb.com>
