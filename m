Return-Path: <SRS0=pWkb=6S=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856C4C47257
	for <bpf@archiver.kernel.org>; Mon,  4 May 2020 18:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69F3E2073B
	for <bpf@archiver.kernel.org>; Mon,  4 May 2020 18:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3Ip++hv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgEDSnO (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 4 May 2020 14:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727778AbgEDSnO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 4 May 2020 14:43:14 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86EDC061A0E;
        Mon,  4 May 2020 11:43:13 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id q7so648874qkf.3;
        Mon, 04 May 2020 11:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4zN7In/0tXqzLRACXNIGxk1zoVVtl+xQ/xtL+ypLA0w=;
        b=Q3Ip++hvHGCT8Kra5a8B2Jw0WoeYG7u/DqDzU00al8w9bodZhZPpD2Y0DmU4+OAzH/
         w1qxi0md5Jprzss+YyD33S5WbD1chCM/02RtilA6WHWi/WvYlJXbLLt+dCGVp5Nko8om
         yhk7P/HzPafAW8d9Qv3NE/sAYEGfRNyFQqDwo7P6InpE5/oIkmJ3mCmITqtSXjEvakaP
         O5n3uPPJZY6igCgIqG0uH+EMiAszf0/S3sqsU27AufL4xV3A4ZbRAesmXsXHsvCpl5iv
         VnOnPVck3My/7pMqzKM0clG5NcX33HjtTq+9UfXxrX6NH8VezHy0XkvESIsvZ9X7Csrt
         XRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4zN7In/0tXqzLRACXNIGxk1zoVVtl+xQ/xtL+ypLA0w=;
        b=a/Cna3cax0oejMeeKmjRAIXv9ZaA5DRFzMIelE4I7kdPbPaNyyy1lseJ+U5ucze16B
         rL++NSgTmQACZAlCEj+BimfW+HiHNSu5MQCGHyiirsBPj5R0nLZxcV1UptgaSqNFY9+s
         D+Gw1KPSlAUXnoIXGmPE4khhi86/4QbjuyXjz1P5rSVzOGmRIouQiC4k415MBe0FMbjU
         QECyN5AufbUDY9sJPjvwjG1TVPpdklfxYfZ1XfM+FkID7S6vfDhnte1CAskEUymXEFaK
         tHb3kKmN2gpnIRT+E1e/77DQQGFvXmq0RrZ+qVnLKQE+e30lfw8Gc8czmvFBgsPOSG4c
         i8VA==
X-Gm-Message-State: AGi0PubqncFbEeOAhq3rs/iIQcHiQnrucloxxBVPZGBEEAy9lBpqlCwK
        pPpL+uxL2xTUa79ny06fGR5+PJloNdNybBgKPAE=
X-Google-Smtp-Source: APiQypKybxUikwZ79KhNbItKU8pFmL+FYOhzAqZ8/oYW9XNJmLRj18Y2ZNHafekOn6Qy+BLiF0S6QiGHn8EzoTuj97Q=
X-Received: by 2002:ae9:e713:: with SMTP id m19mr635100qka.39.1588617792930;
 Mon, 04 May 2020 11:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <158858309381.5053.12391080967642755711.stgit@ebuild>
In-Reply-To: <158858309381.5053.12391080967642755711.stgit@ebuild>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 4 May 2020 11:43:01 -0700
Message-ID: <CAEf4BzYHBisx0dLWn-Udp6saPqAA6ew_6W1BJ=zpcQOqWxPSPQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] libbpf: fix probe code to return EPERM if encountered
To:     Eelco Chaudron <echaudro@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 4, 2020 at 2:13 AM Eelco Chaudron <echaudro@redhat.com> wrote:
>
> When the probe code was failing for any reason ENOTSUP was returned, even
> if this was due to no having enough lock space. This patch fixes this by
> returning EPERM to the user application, so it can respond and increase
> the RLIMIT_MEMLOCK size.
>
> Signed-off-by: Eelco Chaudron <echaudro@redhat.com>
> ---
> v2: Split bpf_object__probe_name() in two functions as suggested by Andrii

Yeah, looks good, and this is good enough, so consider you have my
ack. But I think we can further improve the experience by:

1. Changing existing "Couldn't load basic 'r0 = 0' BPF program."
message to be something more meaningful and actionable for user. E.g.,

"Couldn't load trivial BPF program. Make sure your kernel supports BPF
(CONFIG_BPF_SYSCALL=y) and/or that RLIMIT_MEMLOCK is set to big enough
value."

Then even complete kernel newbies can search for CONFIG_BPF_SYSCALL or
RLIMIT_MEMLOCK and hopefully find useful discussions. We can/should
add RLIMIT_MEMLOCK examples to some FAQ, probably as well (if it's not
there already).

2. I'd do bpf_object__probe_loading() before obj->loaded is set, so
that user can have a loop of bpf_object__load() that bump
RLIMIT_MEMLOCK in steps. After setting obj->loaded = true, user won't
be able to attemp loading again and will get "object should not be
loaded twice\n".

[...]
