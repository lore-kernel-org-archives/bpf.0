Return-Path: <SRS0=wUMJ=RW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF52C43381
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 17:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD7B20835
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 17:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WD+rF8GR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfCSRBW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:01:22 -0400
Received: from mail-yw1-f48.google.com ([209.85.161.48]:39267 "EHLO
        mail-yw1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfCSRBV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Mar 2019 13:01:21 -0400
Received: by mail-yw1-f48.google.com with SMTP id z191so16465586ywa.6;
        Tue, 19 Mar 2019 10:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ID5AbeJvh/Lgg6KKqPzgcLJZWD1/L2J0tklFazK3j4M=;
        b=WD+rF8GRhgDEXvROLqWuqHsJjwr9BGg18nJFv6/CcF/PKjm18//6ImBdz7nQspfOf9
         irjy51b0ZWrJ8N0rV3hVP18dQ3q7w5NsLvLbWBQCG/wczxF1q6eUriVrgTStO8GAIKZI
         X0fDmtPEHLkm5m0A2g6MMErSD1acKrQnhyvVCJkAAe7Vr7OQIbn2d2B5OtpTT9/hrqhZ
         /m7VUUGooBhLzAxnnNim59bZilS7ugXZFx6A6liUZL9up7zAx2Yyeq12cWgS7m/odWwN
         hZeiyA0udkiRyNmLO+wcepR1147PyAP3dqV7GB+oza0SE0Pu+rp1jfC4RRyt1vlZAnxH
         19PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ID5AbeJvh/Lgg6KKqPzgcLJZWD1/L2J0tklFazK3j4M=;
        b=HT35euf0Wa93yOVaFR1hMyEBnuZinYL5UKZ1s9DdzG0TycVHahGGWKX08WTwvtWxTQ
         5aNr0yH9iKdFdAPrqWTbD9U4NRAWTkCT4wjXHkARLQVYJEdbREA7QaBtNPe9lxMes1Cb
         GmBCgt+iCvBS4KZq7hUBI9Aat6i7HKSRneAkSkR0cvPqx2Q4lQLyNOL8yxRBkTWjNmUq
         F58wGwlTzxNsvMFYw3sBo4TXwFsh/Dnrp8JD0v/kP9ZXSlzgr4G23+C8UqpyXqC4Mqk6
         gatrbysBk8VRWHDENJ2CBbv3dfk9K1MSi1mDgF+RNunEjW55gD6AUK5J4s4J9I3HpVsx
         gTAg==
X-Gm-Message-State: APjAAAWpCMLjQoVBl822Nf1398RtD6lOmxrT/wAL5sOXX3f7vakXVa6u
        ds3rVbsHs2XhVBhUFP5aCn7YA3hzR4bfI8sfum5kqJf6
X-Google-Smtp-Source: APXvYqzqey3zb9yprcnhSDKxdzsFakkK+miAilQVcxwcfLeI8miRutuPpzy3StJv++h4UJJFc2cZMplmjEzt9U+2NeA=
X-Received: by 2002:a81:8101:: with SMTP id r1mr3463430ywf.107.1553014880907;
 Tue, 19 Mar 2019 10:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <31947a71-0ff8-df60-ce80-2e6a3fcbffcb@iogearbox.net>
In-Reply-To: <31947a71-0ff8-df60-ce80-2e6a3fcbffcb@iogearbox.net>
From:   Alban Crequy <alban.crequy@gmail.com>
Date:   Tue, 19 Mar 2019 18:01:09 +0100
Message-ID: <CAMXgnP7oy2vQSrzgzSgNmikgVZYN7CL=1-q8qN62oystngdDEg@mail.gmail.com>
Subject: Re: bpf-next is OPEN
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        alexei.starovoitov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 19 Mar 2019 at 09:56, Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> Merge window is closed, so new round begins.
>
> Thanks everyone,
> Daniel

Thanks! I see that the bpf tree is more recent than the bpf-next tree:
https://git.kernel.org/?q=BPF+Group

Does it need to be updated, or do I miss something?

Cheers,
Alban
