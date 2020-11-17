Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D4FC5519F
	for <bpf@archiver.kernel.org>; Tue, 17 Nov 2020 07:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3B122463C
	for <bpf@archiver.kernel.org>; Tue, 17 Nov 2020 07:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sd/GlGJt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgKQHhy (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 17 Nov 2020 02:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgKQHhx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Nov 2020 02:37:53 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97679C0613CF;
        Mon, 16 Nov 2020 23:37:53 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id 62so15566651pgg.12;
        Mon, 16 Nov 2020 23:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0XlitvxJRL4KwmbFX34ChheWdBor1caHiWArAv6m3Pc=;
        b=sd/GlGJt4W7e4wmb/3ie/BugebX2gYYhaySYKzzemzxcutzEGBxgDZJkDcYHcXNhUR
         2bNdEEEWN4b1HrzfIFmAE5kGtyo1JjBjwnoboHSFe7eYllP12xW+nnHJZ9APVT0F8Oxf
         KUwGKlQQWuPw134CArL+6hCBfuxsy0JjMPByzjcXJBnye+IneMt60SPeahv3NgU/wzEm
         VUHEFS1AXVZV2SFrt+oe7w2rnWjt1t7bXnZrOybnVReduL6RsZ+pg9g19I+coHUe2aDh
         IP7DGgHpdZf2rLbEdvfzep8/5FefABvqCBy35ZZu+YoygnCq1zcU9COLrPcx4i/QDvyk
         kwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0XlitvxJRL4KwmbFX34ChheWdBor1caHiWArAv6m3Pc=;
        b=SX2Pl4WEE1fangOhXR49ixhtRKOsnTks/kxLfqvl/I5D6sBcHmXoU863g2n4KPnQko
         7aZ8F0ndOWqfrwZ9F9q1Sk/9ceYerqYg+KBLkJG2mJ3XuGA/icS7gBrck6VQGZZ9WUs8
         qhcWebdP3OmbLZV5wzHoOROvflGZWvGfzCxuFAEqcsBcnixC36aG88qBHGkyPvDwWZdb
         jO+EJYkUSDK6skPLQkHk0Mtel1HeRb09+u/UABKAD7MHddoTbw9Y1q0bhnJ1KDVUiLPZ
         /LxtVebVtxN4ACFik4X4vbyXYY2urcNWZoTXN+Xgu2qOh6DsP4UXKRJA/4Ox2PFYg4xU
         c6wA==
X-Gm-Message-State: AOAM5307Vnok2ReOXYFSD6IaYHkFMlfiQPyWBdMVXDMn0SBonHViHXOk
        RczcMMSXawJOcN4g2+hEwgiCVj+QKLYAPqZ0l4E=
X-Google-Smtp-Source: ABdhPJyovQnPud3JvuEBqj7wYAR9YZ1Eghdt1KS9G6XNfPGeFIfeeh1lVEqgrAdcjkc4S8A9IYXxkvfDmPSSjOPLQeQ=
X-Received: by 2002:a62:445:0:b029:196:61fc:2756 with SMTP id
 66-20020a6204450000b029019661fc2756mr373809pfe.12.1605598672596; Mon, 16 Nov
 2020 23:37:52 -0800 (PST)
MIME-Version: 1.0
References: <20201116093452.7541-1-marekx.majtyka@intel.com> <875z655t80.fsf@toke.dk>
In-Reply-To: <875z655t80.fsf@toke.dk>
From:   Magnus Karlsson <magnus.karlsson@gmail.com>
Date:   Tue, 17 Nov 2020 08:37:41 +0100
Message-ID: <CAJ8uoz1C7-a7A0WJqThomSxYwmdkfLpDyC5YnB8g_J+p486RXQ@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH 0/8] New netdev feature flags for XDP
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Marek Majtyka <alardam@gmail.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Network Development <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        John Fastabend <john.fastabend@gmail.com>, hawk@kernel.org,
        Maciej Fijalkowski <maciejromanfijalkowski@gmail.com>,
        Marek Majtyka <marekx.majtyka@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 16, 2020 at 2:25 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> alardam@gmail.com writes:
>
> > From: Marek Majtyka <marekx.majtyka@intel.com>
> >
> > Implement support for checking if a netdev has native XDP and AF_XDP ze=
ro
> > copy support. Previously, there was no way to do this other than to try
> > to create an AF_XDP socket on the interface or load an XDP program and
> > see if it worked. This commit changes this by extending existing
> > netdev_features in the following way:
> >  * xdp        - full XDP support (XDP_{TX, PASS, DROP, ABORT, REDIRECT}=
)
> >  * af-xdp-zc  - AF_XDP zero copy support
> > NICs supporting these features are updated by turning the corresponding
> > netdev feature flags on.
>
> Thank you for working on this! The lack of a way to discover whether an
> interface supports XDP is really annoying.
>
> However, I don't think just having two separate netdev feature flags for
> XDP and AF_XDP is going to cut it. Whatever mechanism we end up will
> need to be able to express at least the following, in addition to your
> two flags:
>
> - Which return codes does it support (with DROP/PASS, TX and REDIRECT as
>   separate options)?
> - Does this interface be used as a target for XDP_REDIRECT
>   (supported/supported but not enabled)?
> - Does the interface support offloaded XDP?

If we want feature discovery on this level, which seems to be a good
idea and goal to have, then it is a dead end to bunch all XDP features
into one. But fortunately, this can easily be addressed.

> That's already five or six more flags, and we can't rule out that we'll
> need more; so I'm not sure if just defining feature bits for all of them
> is a good idea.

I think this is an important question. Is extending the netdev
features flags the right way to go? If not, is there some other
interface in the kernel that could be used/extended for this? If none
of these are possible, then we (unfortunately) need a new interface
and in that case, what should it look like?

Thanks for taking a look at this Toke.

> In addition, we should be able to check this in a way so we can reject
> XDP programs that use features that are not supported. E.g., program
> uses REDIRECT return code (or helper), but the interface doesn't support
> it? Reject at attach/load time! Or the user attempts to insert an
> interface into a redirect map, but that interface doesn't implement
> ndo_xdp_xmit()? Reject the insert! Etc.
>
> That last bit can be added later, of course, but we need to make sure we
> design the support in a way that it is possible to do so...
>
> -Toke
>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan@osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
