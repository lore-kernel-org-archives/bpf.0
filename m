Return-Path: <SRS0=s2Gn=7Y=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC969C433E0
	for <bpf@archiver.kernel.org>; Thu, 11 Jun 2020 08:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2BDA2065C
	for <bpf@archiver.kernel.org>; Thu, 11 Jun 2020 08:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oc7pk2e5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgFKIS0 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Jun 2020 04:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgFKIS0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Jun 2020 04:18:26 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA557C08C5C1;
        Thu, 11 Jun 2020 01:18:25 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g10so4109067wmh.4;
        Thu, 11 Jun 2020 01:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xvhEEziaD0FfHCKlfv5cuf+YUqxMaHEXYkHLcgvyDmU=;
        b=oc7pk2e5KVuh8bNWXfOkQJrfJ0Z+VluieNKYM4GNBWazBfNe3xQfdeNvKyx7MQgsJ7
         d4apRBu8UOuyR+4pf0JVk5MqwHw7BjSqkaqlJkUq8BgBS2G/PW8jCb+gSNX0MFqpIn58
         kkmQ1ViZddVcTOK84olBE+tcqlFs/6RKWQnWn9Ti3x7qBpY8jGnze7CxG5nkpsUornGW
         xf4I15xHeCjOt9FSIjrCJzkbtoh+yCthRQKA+A9GajcnGLxvd5VnL3C7lL8vIsSbDg/6
         0mLpdjbCYFVgtolmtX3F0+2jSZZeC8g+mmCu7eZVdhCKeTrv5d+yR7QyZchMDsGGRKjE
         U1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xvhEEziaD0FfHCKlfv5cuf+YUqxMaHEXYkHLcgvyDmU=;
        b=t8A1luy/ZC8vDVLI7/eAW5UYjeTiWSIjwi2WKo3rzJjPv4LAjJCsiPes/KBFpZwXWO
         +mltD5klfGKH//eYTlstH6IbdXlMGZ5CJV2kaJX64Svr2zoaL43hx+YAjITj6W2MbJjU
         bLHIRVI+EZoiYQNAmcRkKgMx0lN8VBeHEJaNxsDdXxXYtSrfLxHjiUwKcLbAzEnJ7PHC
         oGsmx2Otwa7pWiUmPB/YnnaaNqVHlLyi8iPkumQdhLVVHLtMfrYtzffRrS6fsIO+Rqm7
         q8qNqMeJio3Iv0PKL9uG6NKSyAbYjUTSgtW8JjRcbdEtBSU0jvzAz3CJ+ZtJxEf5tr5d
         FV2Q==
X-Gm-Message-State: AOAM5312Ih3YnFOqKXszoyPtttOTLhkeP64jw3NLCXwKkbAWV/Jqy0Bu
        yBkmbENCYpFx1ushgPLaYbHzaEm1cbiqE+OexrQ=
X-Google-Smtp-Source: ABdhPJzQFvdpfnypf5OeSq/SJug3YqBMGOC+UrURTBQIJXabDmQFloLFYjk19SP3TOx24bD7Yu9yFS+nQ4nfWtOG64s=
X-Received: by 2002:a7b:cb93:: with SMTP id m19mr7160547wmi.165.1591863504444;
 Thu, 11 Jun 2020 01:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <1591852266-24017-1-git-send-email-lirongqing@baidu.com>
In-Reply-To: <1591852266-24017-1-git-send-email-lirongqing@baidu.com>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date:   Thu, 11 Jun 2020 10:18:12 +0200
Message-ID: <CAJ+HfNhq3yHOTH+v_UNTzarjCaftdw_v0WnebEphZ3niU8GEDQ@mail.gmail.com>
Subject: Re: [PATCH] xdp: fix xsk_generic_xmit errno
To:     Li RongQing <lirongqing@baidu.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 11 Jun 2020 at 07:11, Li RongQing <lirongqing@baidu.com> wrote:
>
> propagate sock_alloc_send_skb error code, not set it
> to EAGAIN unconditionally, when fail to allocate skb,
> which maybe causes that user space unnecessary loops
>
> Fixes: 35fcde7f8deb "(xsk: support for Tx)"
> Signed-off-by: Li RongQing <lirongqing@baidu.com>


Thanks!
Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>

Alexei/Daniel: This should go into "bpf".


Bj=C3=B6rn

> ---
>  net/xdp/xsk.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index b6c0f08bd80d..1ba3ea262c15 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -353,7 +353,6 @@ static int xsk_generic_xmit(struct sock *sk)
>                 len =3D desc.len;
>                 skb =3D sock_alloc_send_skb(sk, len, 1, &err);
>                 if (unlikely(!skb)) {
> -                       err =3D -EAGAIN;
>                         goto out;
>                 }
>
> --
> 2.16.2
>
