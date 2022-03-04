Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2421EC433F5
	for <bpf@archiver.kernel.org>; Fri,  4 Mar 2022 21:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiCDVR3 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 4 Mar 2022 16:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiCDVR3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Mar 2022 16:17:29 -0500
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F36328E02
        for <bpf@vger.kernel.org>; Fri,  4 Mar 2022 13:16:38 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id p20so12710388ljo.0
        for <bpf@vger.kernel.org>; Fri, 04 Mar 2022 13:16:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h6ZrhcNE25h247+i327fAk6wSg2p67qPZO8aUBxHoXc=;
        b=UXLJ+FC9BzAk7LhSJ+OsQW+29CXC4zHoLYeN9/LH8W6PYevto4/OqXpzMwujIslZvN
         Mkjcve1f4DEReDuDVnK4AUfiSMU9qD6zZ+LjcihCN2DiBoV1+qadAlkRYTgG40/jtqbR
         YJIHGiVcv0VRxxW6HMJWcgiW7JOVmEVJNcUMlpEyNMhsAy33RYWNwlKGobc6H2M69+4U
         hayOPrTMEgfbh/d3JlvLXTPynoHKbBsBax3cxHcm3PGurfcgvQEcJQDhnFArtNP5pWL4
         2ZjUPw3QnoVrYiTV6pX4taSK+Hp8BdOwww2vsgpH6TW3HIeY4iIrC/rScGIcSvIxNrrC
         taug==
X-Gm-Message-State: AOAM533BdcJlC2a6mQyZVZeqO0c/zlepOYr5mRZKaIoSMCWgBssT5VTO
        jCcbYPkNn65hcipfj6PTkd/0XFIPuiXmzguU7A0=
X-Google-Smtp-Source: ABdhPJywkzefWTqQnSwrlcyb+Pju2Z1y1lMuTDPtbkHefzXlGYGVMpLtIicJesNeiB007/aq1EDXdpeyvT+E8u6y2A8=
X-Received: by 2002:a2e:a54d:0:b0:247:b4c9:6e3a with SMTP id
 e13-20020a2ea54d000000b00247b4c96e3amr337223ljn.202.1646428596727; Fri, 04
 Mar 2022 13:16:36 -0800 (PST)
MIME-Version: 1.0
References: <30a7b5d5-6726-1cc2-eaee-8da2828a9a9c@oracle.com>
 <c65ac449-ec54-3dff-5447-8a318001285b@fb.com> <1b59751f-0bb1-a4ad-6548-2536e60a80ec@oracle.com>
 <4e2e5738-b103-d340-753e-7e37e06304c4@fb.com> <YiJ4jTB8siLwxAEN@google.com> <76a70706-2d42-b1d1-1be8-5126c442194e@oracle.com>
In-Reply-To: <76a70706-2d42-b1d1-1be8-5126c442194e@oracle.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 4 Mar 2022 13:16:25 -0800
Message-ID: <CAM9d7chz6LL78ZWtUuVH+3SmyPRgCqrBAxqNB-okYgb6ieUN+w@mail.gmail.com>
Subject: Re: using skip>0 with bpf_get_stack()
To:     Eugene Loh <eugene.loh@oracle.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 4, 2022 at 12:50 PM Eugene Loh <eugene.loh@oracle.com> wrote:
>
> No update from me.  A fix would be great.

Ok, I will think about the _pe variants more.

Thanks,
Namhyung
