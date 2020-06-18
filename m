Return-Path: <SRS0=N9AH=77=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E0DC433DF
	for <bpf@archiver.kernel.org>; Thu, 18 Jun 2020 06:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7637E21924
	for <bpf@archiver.kernel.org>; Thu, 18 Jun 2020 06:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdZ58PoK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgFRGnf (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 18 Jun 2020 02:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbgFRGn0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Jun 2020 02:43:26 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AD2C06174E
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2020 23:43:25 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id mb16so5199329ejb.4
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2020 23:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=x03DwrossvE7Vg3TPOBUodrHl/bS6ehRlCJAeWVxxHA=;
        b=WdZ58PoKANdNbrvNa/eqzWlOfaX0jJNZShQUn94m1k0UD0anEwM0Cf0dKSFJEllRzc
         ZTrYnBeZvWirgZx4qd4MR0ZL9VO/dE/Op/RUFhtUFX2/KOlxvPkKRuHxFwMXVnaTa16C
         UEsopld6vhratsznynImTaG2nU6F1zsO2sC9icmVrC/T+8lwSKknfpYeJmaOmhOqxQGZ
         MFJy1wOpR3pQJ2v0DFq0j57wFUmLNHB2rBj1bNsL61qJQJ1p32Gn3dAElV151yu1vBJo
         U8AMZ/rba05FnYkqfSwRb+ZVfTs4fCgYevoyjOeDnX9f+375CWB0IoJAffwAexaQyyMQ
         cqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=x03DwrossvE7Vg3TPOBUodrHl/bS6ehRlCJAeWVxxHA=;
        b=R2JvWdLC22ahnQjOh4r8ntXuOqXRGN/mxaJzQmaiqXHG9adywB0JFD4kcnEysyeS5B
         Yrkxj0dSm1qSQ/nx6HDQ86YJqYCkWRELQLNdskyoY59f62rYVfmfncak/AmrzPL4Aop5
         nmvHBubjJ4ebjON7DOqxbuVwSx2Bi2GCnY0hCFdyic80Djp6Gx6Dmzowd7pRW6nG37bw
         ZbxcCqY6hf6uUj3FaepFM74/WzwF7ZDt60g9BHEDw0Xp9C1mJN2G+fXvPDvwAc8hDZ1R
         uVEt82fZ37cWe7KvyKvztxoXJn4SyxHRyILOPq4MtREHaupWsqEGy01S//qO2zC1eROb
         HRRQ==
X-Gm-Message-State: AOAM533lrYh0lF1GNiOj+MTE9t29b2VtKVj6+XngXiK84E8/iPMc0TR1
        yY0h6fICGofB1IMc1fkAh+mVbudBYzduEubLgK5VMtt5
X-Google-Smtp-Source: ABdhPJyYpSmoH+i2b0rzNQ3Nv5hDbM3MjIRi3nFAlExKjLhgddrH/9HsduZ0bevzU/+pV5mXuvMWxOc7ddq9Iu/ELP0=
X-Received: by 2002:a17:906:e05:: with SMTP id l5mr2859649eji.318.1592462602424;
 Wed, 17 Jun 2020 23:43:22 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Date:   Wed, 17 Jun 2020 23:43:10 -0700
Message-ID: <CAHo-OoxJ6XBrBDXUxhCr0J58eOGq3FZu5+Rg6GLeeCjThrA8rg@mail.gmail.com>
Subject: capable_bpf_net_admin()
To:     BPF Mailing List <bpf@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

is
(SYS_ADMIN || BPF) && NET_ADMIN

should this not be
SYS_ADMIN || (BPF && NET_ADMIN)

?

Won't this cause a just SYS_ADMIN process to fail to load network bpf progs?

(I haven't debugged this at all, but John is reporting 5.8-rc1 fails
to load bpf progs from Android's bpfloader with EPERM error)

Or are we okay with this user space visible behavioural change?
