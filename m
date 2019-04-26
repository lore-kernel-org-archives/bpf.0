Return-Path: <SRS0=D5ks=S4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A701C43219
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 00:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DAD5206C1
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 00:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mg6XykZQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbfDZAcV (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Apr 2019 20:32:21 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40309 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbfDZAcV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Apr 2019 20:32:21 -0400
Received: by mail-lj1-f196.google.com with SMTP id t10so233259ljg.7;
        Thu, 25 Apr 2019 17:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=odbF+ib3Wwf/+adbhjmij/5/rXO6/3XmcDYe0ik657o=;
        b=mg6XykZQwFkDH83EOTJ30dQHF3GwtM0LkHlxPgUpua6WYCLJxAeTsmeBvZObDYy6QP
         amjLtHzTdaBshpypTriw69FD43Za59uizbf9XlXCoRViiCV9t8p2KskbqX76z9FJyPKr
         Dyc6IXgaz4F1Qo/9Y1ZMmN35NR4Dxj0QOAfKQYnmwXTRXCPp5xYdCU8sPJiTbATo9kTG
         7sfXYpGU0e5NLYK/KIIf/ruquNtWIYRJINrYl1902Wv0SF6jRkPINLz8WjkBiGkQKiy5
         CIViq56EezUrDMq8DuaD+l7jEwS0bv3+gccU9mSNuEeH0bmHdMMz/c3gh9Fo5/D/ebFH
         44nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=odbF+ib3Wwf/+adbhjmij/5/rXO6/3XmcDYe0ik657o=;
        b=fIyqZuaGWTiIDmo3Wnsj0excaKo2Y+oCMomXPRO9qlUelhSriq5VMLrUsJuUU+ru20
         D2Hd9P1G3l4cevw5Ua/b1ndJnH/CoO0COSwOSzrLv2HnRSaTVuzRVqsnZCEn2vZcvwim
         7bPsD+Cfx2AE21TZEUbzYxYM24oLMom4EzDkx2bmgU+AqkTUjkZZViLAuC39NXJrrrfj
         XT+EdHJJ3ma6iSm4dyWFmEfM6fh1rqFoFfjZ0gl8l6F+hSSpQhHOmbCLRPfhIoQPEG9i
         9S0KZPK1uoPBG3dyi8adVDOeEuihlKV5WBTAr6/yC0GtEXVCpgjuFoX9wWixY95Ps+uA
         QTwg==
X-Gm-Message-State: APjAAAVCdAFaxyFKUzPgo/TNTiQZ0Nxt5dfEumz+GQqT37rL9BIw19lT
        Pu02Ba4eoDLKs2ZetH3Uehn/KCx0W8jKI6wW6GPUgCRf
X-Google-Smtp-Source: APXvYqxogh0V4fnX9nrXP09GVdg9lTVQn7dCWuD9Y4MZX8B6T7EsPQGQLqJIdoO+MtNIoS1CkoHaweBowRYj960eudI=
X-Received: by 2002:a2e:96d9:: with SMTP id d25mr8752777ljj.78.1556238739256;
 Thu, 25 Apr 2019 17:32:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190411080332.24574-1-bpoirier@suse.com> <626302de-83fc-8c6f-4b55-de0bad746240@iogearbox.net>
In-Reply-To: <626302de-83fc-8c6f-4b55-de0bad746240@iogearbox.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 25 Apr 2019 17:32:07 -0700
Message-ID: <CAADnVQKnyJvURTHHxpgJ+WWpq5nsuHt-CpxSMc-LvC4sy16NiA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpftool: Fix errno variable usage
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Benjamin Poirier <bpoirier@suse.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, David Ahern <dsahern@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 11, 2019 at 12:56 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 04/11/2019 10:03 AM, Benjamin Poirier wrote:
> > The test meant to use the saved value of errno. Given the current code, it
> > makes no practical difference however.
> >
> > Fixes: bf598a8f0f77 ("bpftool: Improve handling of ENOENT on map dumps")
> > Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
>
> Applied, thanks!

I removed this commit from bpf tree and re-applied to bpf-next.
Benjamin, next time please target such cleanups consistently
to bpf-next tree only to avoid merge conflicts.

Thanks
