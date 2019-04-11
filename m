Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7A5C10F13
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 17:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51962082E
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 17:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITt2cSt7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfDKRnT (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:43:19 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37951 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfDKRnT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Apr 2019 13:43:19 -0400
Received: by mail-qk1-f196.google.com with SMTP id g1so3991667qki.5;
        Thu, 11 Apr 2019 10:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bxWSMIL07wLbvRx00CJmVxV74AYCSOnzD68tL84tndA=;
        b=ITt2cSt7jrrW8CNqu9m6d3yT6jUh15yW88+EOIm4b+avU2hiiQ0tHHyrn/SVoNpDQU
         OXg723WfuqGOZQgWqmWUfmujitcAxkrfkcrpWjfT+T8gJ2tz95bTb71cyqRkSkApmqbS
         tW3b1BR62c3y4Tzf+U4wQBoZGlue3Pm2brT4dCjNScFQ+9DdvjZhv9WRTlPUFpozbrp9
         nlwsVHuWzpGQfwoZTMaMzB18D+kiYAqiAdNUPv/oylYFxWX+j5G5kis5YtTdROV7DETZ
         CsmEQtxm/33FQZZyY4DdXNOBPiNqswccY9k04Hwb4s5BMlxepNG3oTtiWa0aVdKItOED
         AXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bxWSMIL07wLbvRx00CJmVxV74AYCSOnzD68tL84tndA=;
        b=KUs+8XJK6ZMsJPVipb1hCgPl6K97p2G5ZZWAwlFZb85SCzp6Ew0LQ+8ZxseQqmrSsv
         EBRLPCRY1YvrGIF8AxiTWNG3niA8Xp5stI4sB26CgtVjbHsQf3TzNKGXgG36y/y5cJ4K
         n6ukJDF0V5CKpfsLXT8MesjP2wdalBPShw8UApVxiUlKXwatrKM1GEaleebbt60oY1Wq
         G7pmVVOX1hvb7Q3qCL+X642SAgqINYjwlhnFuCNWNLirSDgEtFu6egA06zlumqKoc8v8
         R5qUP4QBp2y3hgqjDP3fRB7kwEuG6yzfoMP97oSM9xQiaC2+30H7KSJVchq+Xyv4GnQP
         0AGA==
X-Gm-Message-State: APjAAAXpJZufQx8JocijM6sZ+C7oOPxiOtfCfEdampz3AMJA/FHfECB7
        oSa/bnLyq+iMUc4Dr276QIhAa0RvQPGd1SOrKfkPRoHF
X-Google-Smtp-Source: APXvYqxjFNjSpSnpAop6A0b7E4rtk+kHYoCQjzH7hbw3MvinIcTk0mDDvaS6rTveM9/IzR/OMdayR3Ikxcnqy6usRvU=
X-Received: by 2002:a05:620a:1597:: with SMTP id d23mr38837882qkk.226.1555004598237;
 Thu, 11 Apr 2019 10:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <155489659290.20826.1108770347511292618.stgit@firesoul>
 <155489662793.20826.5533583763088193882.stgit@firesoul> <CAPhsuW6K+TVaAuD3e6g7oE9zhpBAVx5u3V4NZJgH9E0qM2_ZDg@mail.gmail.com>
 <20190411173930.51fec773@carbon>
In-Reply-To: <20190411173930.51fec773@carbon>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 11 Apr 2019 10:43:07 -0700
Message-ID: <CAPhsuW5=Zqx332aDPNfnC4A2SYNfgdS=_yVLzL5=ov7AQRjbAQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/5] net: core: introduce build_skb_around
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Networking <netdev@vger.kernel.org>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        bpf <bpf@vger.kernel.org>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 11, 2019 at 8:39 AM Jesper Dangaard Brouer
<brouer@redhat.com> wrote:
>
> On Wed, 10 Apr 2019 16:34:29 -0700
> Song Liu <liu.song.a23@gmail.com> wrote:
>
> > > +struct sk_buff *build_skb_around(struct sk_buff *skb,
> > > +                                void *data, unsigned int frag_size)
> > > +{
> > > +       if (unlikely(!skb))
> > > +               return NULL;
> > > +
> > > +       skb = __build_skb_around(skb, data, frag_size);
> >
> >
> > > +
> > > +       if (skb && frag_size) {
> > > +               skb->head_frag = 1;
> > > +               if (page_is_pfmemalloc(virt_to_head_page(data)))
> > > +                       skb->pfmemalloc = 1;
> > > +       }
> >
> > I didn't find any explanation of this part (head_frag, pfmemalloc).
> > Shall we split it out to a separate patch?
>
> No, it belongs here.  This is like/based on the __build_skb() and
> build_skb() split, and needed such that __build_skb() can reuse the
> code in __build_skb_around().

I see. Thanks for the explanation.

Acked-by: Song Liu <songliubraving@fb.com>


>
> --
> Best regards,
>   Jesper Dangaard Brouer
>   MSc.CS, Principal Kernel Engineer at Red Hat
>   LinkedIn: http://www.linkedin.com/in/brouer
