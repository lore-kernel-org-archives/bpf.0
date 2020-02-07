Return-Path: <SRS0=Ojkz=33=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB718C2BA83
	for <bpf@archiver.kernel.org>; Fri,  7 Feb 2020 19:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB33220726
	for <bpf@archiver.kernel.org>; Fri,  7 Feb 2020 19:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581104387;
	bh=d5IOAHrv/ajUUWImOxdw4oYPEvD7HIHVnLy7QNVislk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Fau1wICrMVJHG7lOToOIcVL/WZxT0sK56ABqMQhPSiMekkb45x2MgCLdNWln0OfKZ
	 xiX0MCCo86HK7v8jug2fPtlv+EaevMeMH8geZZYlhYtsams5ga/+dSyFFNpQlIvwYn
	 5woIytWKgZlwH/MLcFgYaLkhU58OWfHr6Crdrg+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgBGTjr (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 7 Feb 2020 14:39:47 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34045 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbgBGTjq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Feb 2020 14:39:46 -0500
Received: by mail-lj1-f195.google.com with SMTP id x7so558513ljc.1
        for <bpf@vger.kernel.org>; Fri, 07 Feb 2020 11:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HIvc4xuHKc+POzMOKNgXq3OMyec9mjR3k3fUdELymW8=;
        b=WuHJJZkXMsh43TIeJV7vGA9qAnewgEO/vweVAm9U/IwYfD1BjD7Wh2J0adotOTCPJG
         bx2fByYeZKAWFgipAeqolffyKlrrtODjC87tqPBIw6UNNh4LSj0Qs9QYnFg7I8+SGPUR
         0gV+/r57KHSZ05tK78jw8ASN3ILsBwGBL9hJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HIvc4xuHKc+POzMOKNgXq3OMyec9mjR3k3fUdELymW8=;
        b=cTrJP8KJMZV+hln+hVCOAK12evq394pi7oVsD1WqKclkA2wK040XJXh4xNEjjNNqZr
         cGDLOx646lKlGF7uyP1mzk0xddwdYj69p76uAk8l13dC3ifLx/yUwBKncC2VfhxZvY3P
         J7Uh0y3XCJpoc828ugJ7qgzGsu5gM3RrgVm2SYRCbuyWRKo7vrfONB7bd62t1qJUslpa
         iJdhDmvX6dRjMKtbilhSQsVH5io353s/FHB/H3Vnpx1Lq/YBIEd6WWtbLVmtbF1kdLHt
         1z/CSTTvjMSKtrRnxD3AguZSt1abjheyfssCpQtRXIRcp+LK2XKmpNUhu3sXSdMlUvzV
         p4Lw==
X-Gm-Message-State: APjAAAW/muQl2S7Es1EhSo7iAb1rvGsx921LA0dgcszh4VgWR5A0rDLb
        rz1SsUyRHWvsotqdHwrvmE76XSDXtdVNvA==
X-Google-Smtp-Source: APXvYqxoUVITtlLuCXfynT0Pr5a+y5Oz4CB6hZW2gv5AzSStouTDanVRdTEHXoU4RgyXZGpjrTVIVQ==
X-Received: by 2002:a2e:9942:: with SMTP id r2mr464359ljj.182.1581104381797;
        Fri, 07 Feb 2020 11:39:41 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id m24sm2092269ljb.81.2020.02.07.11.39.40
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 11:39:40 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id t23so130259lfk.6
        for <bpf@vger.kernel.org>; Fri, 07 Feb 2020 11:39:40 -0800 (PST)
X-Received: by 2002:a19:c82:: with SMTP id 124mr231742lfm.152.1581104379964;
 Fri, 07 Feb 2020 11:39:39 -0800 (PST)
MIME-Version: 1.0
References: <20200207081810.3918919-1-kafai@fb.com> <CAHk-=wieADOQcYkehVN7meevnd3jZrq06NkmyH9GGR==2rEpuQ@mail.gmail.com>
In-Reply-To: <CAHk-=wieADOQcYkehVN7meevnd3jZrq06NkmyH9GGR==2rEpuQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Feb 2020 11:39:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjbhawNieeiEig4LnPVRTRPgY8xag7NuAKuM9NKXCTLeQ@mail.gmail.com>
Message-ID: <CAHk-=wjbhawNieeiEig4LnPVRTRPgY8xag7NuAKuM9NKXCTLeQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Improve bucket_log calculation logic
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>, kernel-team@fb.com,
        Linux-Sparse <linux-sparse@vger.kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Netdev <netdev@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 7, 2020 at 10:07 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I do think this is a good test-case for sparse. Luc, have you looked
> at what it is that then makes sparse use *so* much memory for this one
> line?

Looking at the profile, it's doing a lot of "copy_expression()".

Which comes from inlining.

I think the problem may be that with that macro expansion from hell we
end up with 28968 copies of cpumask_weight(), and sparse will inline
every one of them into the parse tree - even though basically none of
them are _used_.

In fact, it's worse than that: we end up having a few rounds of
inlining thanks to

static inline unsigned int cpumask_weight(const struct cpumask *srcp)
{
        return bitmap_weight(cpumask_bits(srcp), nr_cpumask_bits);
}

static __always_inline int bitmap_weight(const unsigned long *src,
unsigned int nbits)
{
        if (small_const_nbits(nbits))
                return hweight_long(*src & BITMAP_LAST_WORD_MASK(nbits));
        return __bitmap_weight(src, nbits);
}

static __always_inline unsigned long hweight_long(unsigned long w)
{
        return sizeof(w) == 4 ? hweight32(w) : hweight64(w);
}

where those hweight*() things aren't simple either, they end up doing

  #define hweight32(w) (__builtin_constant_p(w) ? __const_hweight32(w)
: __arch_hweight32(w))
  #define hweight64(w) (__builtin_constant_p(w) ? __const_hweight64(w)
: __arch_hweight64(w))

where the __const_hweight*() in turn are more expansions of a macro
with several levels in order to turn it all into a constant value.

So we may have "only" 28968 calls to cpumask_weight(), but it results
in millions of expressions being expanded.

If we did some basic simplification of constant ops before inlining,
that would likely help a lot.

But currently sparse does inline function expansion at type evaluation
time - so long before it does any simplification of the tree at all.

So that explains why sparse happens to react _so_ badly to this thing.
A real compiler would do inlining much later.

Inlining that early is partly because originally one of the design
ideas in sparse was to make inline functions act basically as
templates, so they'd react to the types of the context. But it really
bites us in the ass here.

Luc, any ideas? Yes, this is solvable in the kernel, but it does show
that sparse simply does a _lot_ of unnecessary work.

               Linus
