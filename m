Return-Path: <SRS0=P9GS=RC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F64C43381
	for <bpf@archiver.kernel.org>; Wed, 27 Feb 2019 23:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D32B021850
	for <bpf@archiver.kernel.org>; Wed, 27 Feb 2019 23:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="x1Yx1dTd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730263AbfB0X5K (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Feb 2019 18:57:10 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33029 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729918AbfB0X5K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Feb 2019 18:57:10 -0500
Received: by mail-qt1-f193.google.com with SMTP id z39so21544754qtz.0
        for <bpf@vger.kernel.org>; Wed, 27 Feb 2019 15:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=cdxaU4C7raO3RRoOSP6gIE6VtrVur/Cd4Xv3nkSvkpU=;
        b=x1Yx1dTduWJcg6JWgwP1I+G+DrKZISFeO4vzEf6fkN5IOTN45G7R3kaWMBFwJ4N/Y1
         YRxXM2QmUdXmCACVK3uOEAqzXoXJt9d6a0hRw8QOL/4fex++7JwWH0uBi8T3KWXuHzsJ
         I+nj/GUjRYu+P9GxdFt1CsRbKjBaQbfW9uxDe8of7dSALMh+TH6/aTtD2A9OWvHNGPg8
         Ddz2IcnjUUFhAQGnvxsfSn05Yhs5ZjTDjvmqaMAi40uImnlsomStN6usLoRiy9E57hYf
         sN0hHB7Uft/GSPnzVUju+S8Vse9yYgvZheOEWwMTmMKZN0WhLZE4iN8dKj7o0lZW6D3L
         0x6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=cdxaU4C7raO3RRoOSP6gIE6VtrVur/Cd4Xv3nkSvkpU=;
        b=ry4ALAog1ollnOIt5f7ogVXCKBYHfjm2Z/XnuTUS8VzmKLCDHME3kgfWs0rmugbaHE
         5Ij52F7TkhcGkBvn/dq3KCAAf1KQpQPQO82KVOfWw2K6fD/lqblXt3iK5p6Ss/Eu/5j1
         PwiDs/soi2o9urOp2h9q1z02ZGsU68Hkmm0QvGcRa6r5xykaXn472Jvz5xCjo9JpWxDU
         u3hOGxT1Ici2vA9y9PzJeJiV+S611ITKBRWsKd0atnPnBsQ3ADbjNNvr7rsR5iWMnIrC
         s345Bysufr7jAec+p1LCKC+g8UkOmXRAHuXQUklPuhol0Ng2/uW2JiM//9bPk5sKg70M
         Pfxw==
X-Gm-Message-State: AHQUAuZJrhGaLH1PW6UccS/owG0Y2oYpIG3NlG9FbGTf8d8LQ8tGimUH
        lbVfwWBJker0eCzbNRNelPCPrQ==
X-Google-Smtp-Source: APXvYqyqqFXyyM/UsUAhaxALL/OhnwR+Um05SWiq+yyKVwyr33raX2pddA6pW9jVRtFDKOw8UIcdGg==
X-Received: by 2002:ac8:16ec:: with SMTP id y41mr3959197qtk.333.1551311829059;
        Wed, 27 Feb 2019 15:57:09 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id h8sm8207049qtc.29.2019.02.27.15.57.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 15:57:08 -0800 (PST)
Date:   Wed, 27 Feb 2019 15:57:03 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, oss-drivers@netronome.com
Subject: Re: [PATCH bpf-next 3/5] tools: libbpf: add a correctly named
 define for map iteration
Message-ID: <20190227155703.121514a2@cakuba.netronome.com>
In-Reply-To: <CAEf4BzZR+7R9TjXSMHiYzbHCvuwL+Z_LBD=Pk+rRW+X+pgdg4w@mail.gmail.com>
References: <20190227233046.11718-1-jakub.kicinski@netronome.com>
        <20190227233046.11718-4-jakub.kicinski@netronome.com>
        <CAEf4BzZR+7R9TjXSMHiYzbHCvuwL+Z_LBD=Pk+rRW+X+pgdg4w@mail.gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 27 Feb 2019 15:47:56 -0800, Andrii Nakryiko wrote:
> On Wed, Feb 27, 2019 at 3:31 PM Jakub Kicinski
> <jakub.kicinski@netronome.com> wrote:
> >
> > For historical reasons the helper to loop over maps in an object
> > is called bpf_map__for_each while it really should be called
> > bpf_object__for_each_map.  Rename and add a correctly named
> > define for backward compatibility.  
> 
> Seems like there are at least 3 more functions that are not named correctly:
> - __bpf_map__iter (__bpf_object__iter_map?)
> - bpf_map__next (=> bpf_object__next_map?)
> - bpf_map__prev (=> bpf_object__prev_map?)
> 
> Let's rename them as well?

At least those are consistently named between programs and maps.
I'm happy to do the rename if we don't need backward compat, seems 
a little much to add aliases?

> > Switch all in-tree users to the correct name (Quentin).
> >
> > Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> > Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>

> > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > index 6c0168f8bba5..b4652aa1a58a 100644
> > --- a/tools/lib/bpf/libbpf.h
> > +++ b/tools/lib/bpf/libbpf.h
> > @@ -278,10 +278,11 @@ bpf_object__find_map_by_offset(struct bpf_object *obj, size_t offset);
> >
> >  LIBBPF_API struct bpf_map *
> >  bpf_map__next(struct bpf_map *map, struct bpf_object *obj);
> > -#define bpf_map__for_each(pos, obj)            \
> > +#define bpf_object__for_each_map(pos, obj)             \
> >         for ((pos) = bpf_map__next(NULL, (obj));        \
> >              (pos) != NULL;                             \
> >              (pos) = bpf_map__next((pos), (obj)))
> > +#define bpf_map__for_each bpf_object__for_each_map  
> 
> Should we get rid of this as well, instead of accumulating cruft?

Well, we did some gymnastics in the past to maintain backward compat, 
I thought we do need it..?
