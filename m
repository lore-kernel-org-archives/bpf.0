Return-Path: <SRS0=uc+s=DH=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31CBC4727C
	for <bpf@archiver.kernel.org>; Wed, 30 Sep 2020 18:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D04720848
	for <bpf@archiver.kernel.org>; Wed, 30 Sep 2020 18:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDKBPjhN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725372AbgI3SNN (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 30 Sep 2020 14:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3SNN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Sep 2020 14:13:13 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBC1C061755;
        Wed, 30 Sep 2020 11:13:13 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id b19so2395403lji.11;
        Wed, 30 Sep 2020 11:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=neVvJjs8c8bnzQTfnKBgO53z26IPreK1g9kdkYUUonU=;
        b=hDKBPjhNVCdON2TvhwIhpW/zP6mHde6niZ1Kj3AsnP6TQpdT1uBFTGrX/CTagSk1PQ
         x7LMhMvr/7bt9SN3VroDNeikyHNZcuznuV6vowNu4BWrr6kgf1jYswasF3Xd6NSYFNqF
         aCxbg82Za5Kb9QqeCbxgg+4lPaJM9CQ5RY9wP/ZlJz3l810He+6jev63s6NW4VynZwqk
         tJ6RVcdNWhh7KErMZj2lR8NolmdKbCZOAFFItTwI4p0Du0LpE7Jw9cJGCd6Q5FlgjeJq
         Sk4lU2jZETyOQsKBk2Ny7BtO/iyg9jFK/pkZOsd5Lc5qGOvQ6DfNOixGTMt0v0wdOiCm
         x9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=neVvJjs8c8bnzQTfnKBgO53z26IPreK1g9kdkYUUonU=;
        b=DFg6z9nPLV+BEmLXHXNq70+3UzXx+4ybt9CPQVjLBG8/4I8jr6amFj0ImTa4N9RpAr
         uJMvPX+8UvGA16letDDD+hYZRMb4kzCFsjPeKbavxNeooSDwNOYxOxmaKm3A7Z04XHYX
         kXKUsz9OkSMK+Ydu6KxFQM6dHYuezgFpdFd8rHQuufBm3/iGQW50JH/9agMwN+FLCli4
         HibZa+UJxmf44ZnMt72qO02qH2hxPU1MEOP/6JsnBS9Q/ldalfdJIIzOpB2lbwksy/ll
         jI6LH9NlgIihTRqvLaJAKkLvWIeLO/v7pcrYqhhtop01tlQh+80EurDlGPI8sA0bfwPY
         B6xg==
X-Gm-Message-State: AOAM5307+rH7E93+l4bCWKhYggOn9c2yfuzFDKEr++JjcGYF+cIqY8Vr
        VNKLaxiFlgZOLsyn8aMfKl7q4oby+ae+I4Tr0hqkcyX7i9c=
X-Google-Smtp-Source: ABdhPJwi4skFBmkml53yW11TCCKQjer605mrxcpW475RC9XSEEeDIlSwAYtZHbq7TgMxJbe+e45Jz82P7TtarTnavj8=
X-Received: by 2002:a05:651c:cb:: with SMTP id 11mr1282761ljr.2.1601489590202;
 Wed, 30 Sep 2020 11:13:10 -0700 (PDT)
MIME-Version: 1.0
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 30 Sep 2020 11:12:58 -0700
Message-ID: <CAADnVQLV86GcC5fE68Eiv0aM9g7o3a5ZDh0kmXv7Tba4x-jRbg@mail.gmail.com>
Subject: mb2q experience and couple issues
To:     Thomas Gleixner <tglx@linutronix.de>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Thomas,

For the last couple years we've been using mb2q tool to normalize patches
and it worked wonderfully.
Recently we've hit few bugs:
curl -s https://patchwork.kernel.org/patch/11807443/mbox/ >
/tmp/mbox.i; ~/bin/mb2q --mboxout mbox.o /tmp/mbox.i
Drop Message w/o Message-ID: No subject
No patches found in mbox

I've tried to debug it, but couldn't figure out what's going on.
The subject and message-id fields are parsed correctly,
but later something happens.
Could you please take a look?

Another issue we've hit was that some mailers split message-id
into few lines like this:
curl -s https://patchwork.kernel.org/patch/11809399/mbox/|grep -2 Message-Id:
Subject: [PATCH bpf-next v4 1/6] bpf: add classid helper only based on skb->sk
Date: Wed, 30 Sep 2020 17:18:15 +0200
Message-Id:
 <ed633cf27a1c620e901c5aa99ebdefb028dce600.1601477936.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0

That was an easy fix:
- mid = pmsg.msgid.lstrip('<').rstrip('>')
+ mid = pmsg.msgid.lstrip('\n').lstrip(' ').lstrip('<').rstrip('>')

The tglx/quilttools.git doesn't have this fix, so I'm guessing you
haven't seen it yet.

Thanks!
