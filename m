Return-Path: <SRS0=eni5=ST=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF782C282DA
	for <bpf@archiver.kernel.org>; Wed, 17 Apr 2019 16:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF07120835
	for <bpf@archiver.kernel.org>; Wed, 17 Apr 2019 16:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOmmk9FR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732751AbfDQQqb (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:46:31 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]:45010 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbfDQQqb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Apr 2019 12:46:31 -0400
Received: by mail-qt1-f182.google.com with SMTP id w5so28057225qtb.11;
        Wed, 17 Apr 2019 09:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LwNvppTg1bciF5G5ZqtHLiqkuhodGWXhO2SplTbEKyA=;
        b=ZOmmk9FRwx0E4nougs6jEXwpKd06xWe8CJInWEvX6uEf/Lct99e7Uf13uabZX1x030
         gD1ImyPIBLimdI6Heu9NXSclc8URMu1fyP3kUCiAqo5LF5K+pnSAzbbkXbkK6487mdbD
         Eyt4ki3AInnMy3U3aio0DEXXNvcdw0QcfkpgEEDbFfEeNSWSAdXKLLrbGFKEONRD7VFw
         XPQv5Pl8VWsORMPwAKT02jvyiRyrtmH4VgJQcY8A3LNfxE2VLJ81N2S9GEk3PF/n3gZA
         pRAjT/HMfejC/8ST18Icyq8j8pT7piCMsIrlTtsHuT/uB3GY03BVSOArEMtLzvoUpkH+
         Umww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LwNvppTg1bciF5G5ZqtHLiqkuhodGWXhO2SplTbEKyA=;
        b=jlYab1ymLmW0+gciyf77lAmnf7Atjz4hNuFXtdADHoO6fRK0W/tly5KgJXXHEWDTs3
         ijSduvzd4IxwngUnyypNlk0/P9evlKk8rtxAoV7jv11VMMzHKD0A/9oABvitpeul8BVM
         de9ZYBkqfnuHSyhOS63LP3eX4XPkApbt6L1JekaoLIA5iPmTyc7skV4wRTN2HpjxHvp4
         yQXGxbVXteGWHQxeGgJFL7jfHLZhq5hO0BAJt5uIiYBpkM35bYo5/mcb9O4aX3YGxb55
         JiK3OHDiHNFTMCz7VgNpsQ3EvMYVbqoakDJUiiwxG/p8ZLz+1Ljed1lUtzaY9HkojyAD
         y6bg==
X-Gm-Message-State: APjAAAWLjdtBSL0VKGwRH8QyjAVC6oArFU2peG3J/PWwADDr2slAUAJS
        Qeu+gv30DmeXuJsv9TprQv7Rx6MQaQrlBMU5b5U=
X-Google-Smtp-Source: APXvYqy3r8N5RTecRGoLY0AP1PEPUmvfcWMpMvU9+3bJWMq3jiLteZUXtUxvhTxUi2vxBxK1tuAXWC++OjxfziWEmg8=
X-Received: by 2002:a0c:9e0f:: with SMTP id p15mr72594453qve.178.1555519589806;
 Wed, 17 Apr 2019 09:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190405131745.24727-1-bjorn.topel@gmail.com> <20190405131745.24727-2-bjorn.topel@gmail.com>
 <64259723-f0d8-8ade-467e-ad865add4908@intel.com> <20190415183258.36dcee9a@carbon>
In-Reply-To: <20190415183258.36dcee9a@carbon>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date:   Wed, 17 Apr 2019 18:46:17 +0200
Message-ID: <CAJ+HfNisQRdsjqWoyODAkOq142NtXAV3=0wLuDQGkQpu3Sp+OQ@mail.gmail.com>
Subject: Re: Per-queue XDP programs, thoughts
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        maciej.fijalkowski@intel.com, Jason Wang <jasowang@redhat.com>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        John Fastabend <john.fastabend@gmail.com>,
        David Miller <davem@davemloft.net>,
        Andy Gospodarek <andy@greyhouse.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Thomas Graf <tgraf@suug.ch>,
        Thomas Monjalon <thomas@monjalon.net>,
        Jonathan Lemon <bsd@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 15 Apr 2019 at 18:33, Jesper Dangaard Brouer <brouer@redhat.com> wr=
ote:
>
[...]
> >
> > Ok, please convince me! :-D
>
> I tried to above...
>

I think you (and Jakub) did. :-) Looks like a "queue" is a good
(necessary) abstraction, but I need to think more about how to e.g.
access "dedicated/isolated" AF_XDP queues or XDP Tx queues in a
convenient way.

I'll still aiming for making it dead-easy (like Jonathan describes) to
use AF_XDP sockets...

Thanks a lot for all the input/help!


Bj=C3=B6rn
