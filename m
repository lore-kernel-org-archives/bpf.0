Return-Path: <SRS0=a4pm=AO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E75C433E0
	for <bpf@archiver.kernel.org>; Fri,  3 Jul 2020 01:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CBA6207D4
	for <bpf@archiver.kernel.org>; Fri,  3 Jul 2020 01:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593738350;
	bh=RJJe+f9Dmu91CtbeZWRbvBdTdvdKvzDGeh2G9pSso7A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WJ9sZV1xa5wAd8/FIuacafRtR+cfiXtT4k5ZblSvz3rAT1XJ5gI3vX8gTN/H5ydSV
	 FCQ227fMuQUQ80O+sCktUN1asVzFJWFdkgQC2NEJoCVgvk5HPP4SrWwU5NyaeSJJ/T
	 1/zbVaofKSpv4o36XhPZaJeASrXAl4nQzSVL9PWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgGCBFt (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 2 Jul 2020 21:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgGCBFt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Jul 2020 21:05:49 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EE3C08C5C1
        for <bpf@vger.kernel.org>; Thu,  2 Jul 2020 18:05:49 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id b25so31063242ljp.6
        for <bpf@vger.kernel.org>; Thu, 02 Jul 2020 18:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/xVy0EZL3NGAs5QTxCmkjzf1k1V1ihgTkrtrhEV3LNY=;
        b=H99GEZS5MO7QIILQwwNHlIbzBxV0CLQNGWcZ9HmeKhq1zofWEHlDiUPRy9D0/b7TL/
         hEKqZztq0ddNVL8oPgWQqq7Zt+R4ocmmJVgEE25FY16sEOVbCVVE6hQaQHBljpnBdiix
         koQcoOMiIdbUdvuHOMOEuap/Nq7zErOpE3cCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/xVy0EZL3NGAs5QTxCmkjzf1k1V1ihgTkrtrhEV3LNY=;
        b=CHOOr8+lIToh7bB4PVzGskofgD8h3nFtj0Ba/f+lFmj13aFQbX/kOli8ncKj5b+9Kk
         t2c0KpJMqARezVBvOXO6T/pGMhHQfMhQ3r0p0HjeRWhbxo0zHkbKshg0uFJ8OWRgRc5I
         o4gHMzR2PR85La47apx1eFZnwc+q9kKe3I3t/mcWoyGyf81K4VUeORSBw1GNosQm6yxf
         WTGiy6ohifiemM/JITfHrB4rD/8nPgvTBi72+lkKZtAipJsexjRpcnbtyR/9khgiD41e
         kcIGO0OCHGjDZd6el7w7dLOo7RnGP8W64wpWthGewvXxfuaAW+enycI/9lpsOt9cm2t+
         Ofdg==
X-Gm-Message-State: AOAM532YeMlgjH7q9m2eB53GlMVP14fiuOBb2OgvovXHRL+724QV7Dkm
        kgE/JGbtA5q2A6jhbYt0TXewhENRLbg=
X-Google-Smtp-Source: ABdhPJzU8JZ+xXVH4gcYaGumgXQ2+wB4QD6jQy2M0E71kHMHD50f4TncI6uyK8keb4IQiFVhUIjJpg==
X-Received: by 2002:a2e:a54f:: with SMTP id e15mr19428160ljn.263.1593738347147;
        Thu, 02 Jul 2020 18:05:47 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id u19sm3951411ljk.0.2020.07.02.18.05.46
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 18:05:46 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id s16so11904884lfp.12
        for <bpf@vger.kernel.org>; Thu, 02 Jul 2020 18:05:46 -0700 (PDT)
X-Received: by 2002:ac2:5a5e:: with SMTP id r30mr20239856lfn.30.1593738345743;
 Thu, 02 Jul 2020 18:05:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200702200329.83224-1-alexei.starovoitov@gmail.com> <20200702200329.83224-4-alexei.starovoitov@gmail.com>
In-Reply-To: <20200702200329.83224-4-alexei.starovoitov@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Jul 2020 18:05:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgP8g-9RdVh_AHHi9=Jpw2Qn=sSL8j9DqhqGyTtG+MWBA@mail.gmail.com>
Message-ID: <CAHk-=wgP8g-9RdVh_AHHi9=Jpw2Qn=sSL8j9DqhqGyTtG+MWBA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] bpf: Add kernel module with user mode driver
 that populates bpffs.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 2, 2020 at 1:03 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> The BPF program dump_bpf_prog() in iterators.bpf.c is printing this data about
> all BPF programs currently loaded in the system. This information is unstable
> and will change from kernel to kernel.

If so, it should probably be in debugfs, not in /sys/fs/

                Linus
