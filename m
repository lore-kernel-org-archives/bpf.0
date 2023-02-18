Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EBEC636D7
	for <bpf@archiver.kernel.org>; Sat, 18 Feb 2023 09:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjBRJWX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 18 Feb 2023 04:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjBRJWW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 18 Feb 2023 04:22:22 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6421EFF
        for <bpf@vger.kernel.org>; Sat, 18 Feb 2023 01:22:21 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id h10-20020a17090aa88a00b002349a303ca5so284427pjq.4
        for <bpf@vger.kernel.org>; Sat, 18 Feb 2023 01:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p2KNwfztIpdxjLo+ik66q9FmAfltTqBI/A6YNDGpBFk=;
        b=O2pYFFwdOKX5ALavlOL/2xR2yIt/gM1Hg3If6AjUmXpRl4QVr46Qfu9vwGtTxJVqLE
         NhnGbZTyEXNoK7S7MpBTJlG+lJ8AUvmKcfdDVTrZNc/ISXJOJugZEgWXEwCCQp2JzDSk
         EOa18ZLtq3Je/q9CsEpztMwEP2pGtkUDdtzaV2Z+QH75yo+E4K7+BHITXDfzNKJ9zoQv
         K89c9kUpK9zFeNOPI1Yp73aGt9dNN3wHUbY2urqEUswFFENdsK2Iv32kQhLPejDMs5H9
         5bwBOF3JbT2qM2+YL71DAo4Q9p7PxcG+Bv4lMmm7iQpChrkb5/qmHEZSL/0/KXQp2CGY
         ttpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p2KNwfztIpdxjLo+ik66q9FmAfltTqBI/A6YNDGpBFk=;
        b=kQnGqYgZFA4tvR0bW1Z02b0eww13LP+qYQzQvQhCg2J0wrzT/TkA8Pvhah28UMi25l
         5WdBIrp+E67o01/w0mt6Ao9Y2V3Zpit5kfdk4vHvK/8Qy9wK1iMr/GlL4DAovfB5Q62o
         uM5QR00OrIQy73w9z7czFwo2kNCIXFhwpAAn3udh7LvE+J3jCSxKTFkJPU+X9Cq9/fIh
         mQYMuzCM5NXe2eaBSwK/8JHf2x7Wu2jSBUHGT6DlcbN4Ue9DA/4lFn4v2FU6BoJ+R0gb
         zvONyjWbT6uYRLcv/R/8ICIIi3bxEnTlw1tNR2ZDZ+SlSoYFXEKe7X9GqxcIY3YIvuaI
         GpaQ==
X-Gm-Message-State: AO0yUKVOOcSraYLDu3f9S5KNJMNSfliqRApBX+jzhKP1+O23TSInZq19
        xKGhUlsNftpf5TnRv5DsmdgN00iRxO7fPabhiGt+Puh405zBgBkyEPGd0g==
X-Google-Smtp-Source: AK7set/4xRIDgkNhqjZRXZSUssJAtpiJZf1CGBaFJzJmHEjwDDQMnemS/3IZgm0JvmhIxKaeu9zZkb4RLZDB1I+pUYA=
X-Received: by 2002:a17:90b:528a:b0:234:dfe9:25b5 with SMTP id
 si10-20020a17090b528a00b00234dfe925b5mr216786pjb.4.1676712140742; Sat, 18 Feb
 2023 01:22:20 -0800 (PST)
MIME-Version: 1.0
From:   Dropify Drop <d.dropify@gmail.com>
Date:   Sat, 18 Feb 2023 14:52:09 +0530
Message-ID: <CAJxriS2Up7DrF4r9LHX+L_6X0NhP5m4sUTqGGcE5SAna+HFWLA@mail.gmail.com>
Subject: Removing clsact while eBPF program is still attached
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,
I am playing around with eBPF + TC and wrote some eBPF code to
intercept egress and ingress traffic (clsact qdisc) .
All works great but while the eBPF program is still attached I can via
command line remove the associated clsact qdisc (tc qdisc del dev
<interface> clsact) and the eBPF program no longer receives the
traffic. It is kind of expected but any root user can silently disable
it.

Is there any better approach?

eBPF program only allows traffic to/from some preconfigured IP & Ports.

Thanks & regard,
Dominic
