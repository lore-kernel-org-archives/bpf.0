Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D1DC04A68
	for <bpf@archiver.kernel.org>; Wed, 27 Jul 2022 21:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236093AbiG0VEV (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Jul 2022 17:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236054AbiG0VD6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Jul 2022 17:03:58 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0732760515
        for <bpf@vger.kernel.org>; Wed, 27 Jul 2022 14:03:49 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id z18so167076qki.2
        for <bpf@vger.kernel.org>; Wed, 27 Jul 2022 14:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DMRDfB46wui2YU3fysYgG67AKlLQfOXdqpk+kkaerqA=;
        b=s2EWyW2noc4yaXG+EiQRS1bRBwQMZITWgJ1yW7bh4+oQFju+Lny7f0r28V7jp9egT2
         +lpTpnC5zmyvJPjypBuMeo16r/FSebmi7F2XDuzWJDx60nXeg/VNuDL+XUGGgquhxntc
         GhhFsKXgiOiqmziu/OhsHSeH5WvxIcgXIxrtGdAIpH+iyr5F2tXlNvfPMh47c0vnKrMj
         ArVuY2jEBVup1n0JWktOr8nWD/9Mepr46gkr6dafrLZWd+Z70ic0rs64SW+ZrFcLkvPd
         f/xWGIAWaQLzsj2NDJesID/NrFLvgT0geAWF2CBRZrTshepVqjn6a0tdGF9qCIdO/srj
         YVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DMRDfB46wui2YU3fysYgG67AKlLQfOXdqpk+kkaerqA=;
        b=pqvM1HKXhjNK8+KHrEndDwbOcsc//01ohnEnfyjBDsPYqhXR03OIBJcS40n/Xlk9HT
         2qxwIlR/kuoOiE5Hw52fkjyPMRDVFvYAhuEzFm/pY6K4KpqYdNSfqAWhrBDVvfKrMeYv
         r4EMPQRZcsWDlQ7cAMe/4gFS8zRdSDuNZOEAqW5jbzgQ9KOSzAhimfUkW3Gn0LROiLUC
         uFWGNw8USVEkzTUR4wjctQTJc4lJoH/fakCCHc3VZTvFtMm50JlvGYXn4hag9sc3IGG8
         GH9beSGq5vMYaSdoWjDsT0nOAziBJ5L+zdh0I5MKpXPAq7Mrj6md1b+wOlY6OEbuJxWe
         yf+g==
X-Gm-Message-State: AJIora8aVmpjQXDkEVf2izM8ydJAro8b/mQAvK5+q9/7/FYEtM2hmXjz
        LKUV+1Lkca6Y+9V8SJuoLsyKhBZa9stL5mJhK+qG+A==
X-Google-Smtp-Source: AGRyM1sZjhnEzaTW0EHLPWu8uQ1MQjy6J3Xm33BHsIMfNcmCsOY8J9w+METW5ojltFnoWg51yMIFe8SoahDmd2ngsJU=
X-Received: by 2002:a05:620a:15b5:b0:6b5:e45f:f7f5 with SMTP id
 f21-20020a05620a15b500b006b5e45ff7f5mr18523143qkk.568.1658955828040; Wed, 27
 Jul 2022 14:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220726093045.3374026-1-clementwei90@163.com>
In-Reply-To: <20220726093045.3374026-1-clementwei90@163.com>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Wed, 27 Jul 2022 22:03:37 +0100
Message-ID: <CACdoK4J3-4n8_KETdETKV9Ry+e-Y88kwmoAK3KLbGV+8XuyfXQ@mail.gmail.com>
Subject: Re: [PATCH] bpftool: replace sizeof(arr)/sizeof(arr[0]) with
 ARRAY_SIZE macro
To:     Rongguang Wei <clementwei90@163.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Rongguang Wei <weirongguang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 26 Jul 2022 at 10:31, Rongguang Wei <clementwei90@163.com> wrote:
>
> From: Rongguang Wei <weirongguang@kylinos.cn>
>
> Use the ARRAY_SIZE macro and make the code more compact.
>
> Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

Thank you! For future patches, please specify the target tree in the
object of the message (=E2=80=9C[PATCH bpf-next]=E2=80=9D in this case).
