Return-Path: <SRS0=bsNo=X2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5509C352AA
	for <bpf@archiver.kernel.org>; Tue,  1 Oct 2019 09:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9E1215EA
	for <bpf@archiver.kernel.org>; Tue,  1 Oct 2019 09:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0ehl5UO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfJAJip (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 1 Oct 2019 05:38:45 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33206 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfJAJip (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Oct 2019 05:38:45 -0400
Received: by mail-qk1-f194.google.com with SMTP id x134so10582938qkb.0;
        Tue, 01 Oct 2019 02:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pBeudYclpSa7jQtOjPJ0woizZckkqRyvtq13HI10Oao=;
        b=J0ehl5UO1mQdlDo4jfKXlypf/HfmwlWy/1jNISkWoCi2u/dU8LRxPXcZd2FGVuT6Mg
         G03Eat0wiOaNaS+XTYhnxdVFqLYbkZW2XzGbsggMllQ+qi+9nvS333zhukACoYHNN/+w
         eRinmNkkSWIN172BjLyb0wZLwrs6luB6wLO/Z/8qJZsXulD3AWz9B9WTW/taguqY39gC
         Kt/GgvapijIo45nHobjmlC7Cp7JGLK4h4ZmVDRole3wOZ0BlKksyse864LhwxJ1x6EGs
         TbuVpYvBvm5ynwQqNrqchh5cN6Syqcjsqd0F/yG3MCMVhrR+9hR55ZVf8gxruAuHVqoh
         kGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pBeudYclpSa7jQtOjPJ0woizZckkqRyvtq13HI10Oao=;
        b=H+t6fY96OqmsBKzYZSycViIukgU2uixR6wwDOQVVcN3hXzxrDcurdUuih9cBZyMK38
         3F7KYlRiGyf24UpE1uosRxJoWlY/QBxvMbCeBbSMb1xyIbvLnwAkQX2T/IB8jtgOpL8I
         oxOAJ7A7bMzDM24i8yJ6qgvM2ro3GTbaQ99p9Ot/9W4iY1bv4/NjcDq18FwRUPoQ6a4l
         7BLTJGARpoY2KrX32FDingNOnV8yhe7WvaYFV39moPvszRIpx64efKtQoCqJe5DNB9kk
         Nnq115GhktzICLK1EUI6eOmow9yCmpPsZCvsMSr1kdCT6CBEtPgWPAv4YEyD6qhunLuL
         jLUA==
X-Gm-Message-State: APjAAAU3CUypxmpPsITwbO6NgEetECkxk4C5HETbOyRabv1rz7BkYe5o
        o2HdENXk7hFux7G5rnHyWER57+RbBvEt7pL/BcLZEl4v9mVP/A==
X-Google-Smtp-Source: APXvYqyDA50+jqLM90mPb+w4g7I/bzlS4IH9fDJwqhV6Jle97hkFyed0t95/mxCaF0MI25hesDGsMDQynGWa9oFJYdk=
X-Received: by 2002:a37:8382:: with SMTP id f124mr4876618qkd.218.1569922723877;
 Tue, 01 Oct 2019 02:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+HfNgZGzOM70oTV35YfMdn6PRcGCjsybypGYqsDQRe-NZdyQ@mail.gmail.com>
In-Reply-To: <CAJ+HfNgZGzOM70oTV35YfMdn6PRcGCjsybypGYqsDQRe-NZdyQ@mail.gmail.com>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date:   Tue, 1 Oct 2019 11:38:32 +0200
Message-ID: <CAJ+HfNhM2ifCOUrmiaO=ERw1Wuv+ZK5LWehMsqryT8uc5YcJKQ@mail.gmail.com>
Subject: Re: Broken samples/bpf build? (bisected)
To:     bpf <bpf@vger.kernel.org>, Netdev <netdev@vger.kernel.org>
Cc:     yamada.masahiro@socionext.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 1 Oct 2019 at 11:13, Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com> =
wrote:
>
> The samples/bpf/ build seems to be broken for bpf/master. I've
> bisected it to commit 394053f4a4b3 ("kbuild: make single targets work
> more correctly").
>
> I'll take a look, but if someone with better kbuild-fu already had a
> look, please let me know.
>

Setting CONFIG_SAMPLES=3Dy and

diff --git a/samples/Makefile b/samples/Makefile
index 7d6e4ca28d69..7074d6c9da12 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -20,3 +20,4 @@ obj-$(CONFIG_SAMPLE_TRACE_PRINTK)     +=3D trace_printk/
 obj-$(CONFIG_VIDEO_PCI_SKELETON)       +=3D v4l/
 obj-y                                  +=3D vfio-mdev/
 subdir-$(CONFIG_SAMPLE_VFS)            +=3D vfs
+subdir-y                               +=3D bpf

did the trick.
