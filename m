Return-Path: <SRS0=hr/i=SJ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B53BC282DA
	for <bpf@archiver.kernel.org>; Sun,  7 Apr 2019 02:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBDA2213A2
	for <bpf@archiver.kernel.org>; Sun,  7 Apr 2019 02:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="siGnfeGq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfDGC5t (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 6 Apr 2019 22:57:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35864 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfDGC5t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Apr 2019 22:57:49 -0400
Received: by mail-pg1-f196.google.com with SMTP id 85so5262626pgc.3;
        Sat, 06 Apr 2019 19:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pdLyYaQxs3p5bad1YFHvi1I9Og9Bh3buJgg17GpaqnE=;
        b=siGnfeGqWB7QnN6WBS3Mu8a8AOV/T7tfT+uKaFePVMJQNdKfQZlI/srMONHGLLgKeR
         MkZnMdy9rD/owQ8LU1bpJbRjyFb07Hh8GGkZmkRJZKjuba9KJMyOEwHH7RoMRVYGlnqA
         9J3wQPmsQNdxEs4m+erHdHqzu/X8Ftyta99vCohu8baN/yry2XIJmOfxtnWUFbSShzEY
         eAWP0yzhY8V12CkzEL9Hi2C0LvfdlAtcpDfkiJgPm5GX7INAO3rZigcZDadtrOQSQ8Dk
         z4t89KRYE0hHKLAAghGQ1YQgkUSSTLfCArzfZlTYda4BOdK58WvH4OqdzloTLypPZ3kT
         cztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pdLyYaQxs3p5bad1YFHvi1I9Og9Bh3buJgg17GpaqnE=;
        b=OadBYTP8H/7mUOPHFxSZ7pe7sH5PsSsOFn/uwMi+OWLLmXCgX9qsojUxJtOKdB+fG0
         lXPO9tlxkZOLZ+NgRpDHEqlA0zpPEygZNP8uhydRNVJimMUH1ay4Nn9WwhlzyL1M6OIl
         9T9w4hCfECu/GlgF7JmmN6GsJKtdEc44Fsd9J2R3/ItHTUdSa198dWUhzYs2Wxk4zvV8
         az2mV4OwYUJ16KxyQT+VZ9aQXCV636RKidjY83igIY9BNE5geqoCUHHlM6N93MdzuHnS
         tEmoRe/23ouzk3lTE0D+8xMTlrR98toTCPhh5Skk8xpBZgblMfHJHaOw21ieNWTZ2wHr
         DrPw==
X-Gm-Message-State: APjAAAW0NqrV1qsf+TrZ/52OBZSsO/CPtJZ3n0f45NPvwi2TN+l8VzgI
        3jRkxzos3/qnKiRBABSRSqU=
X-Google-Smtp-Source: APXvYqxmIN8LZFklB7h81mEyTNfCxBVfcD7wT0qShcQI2VgFC9xg0kwk9SxAncveKi3ZgDQQi8Kd5w==
X-Received: by 2002:a63:115c:: with SMTP id 28mr20919622pgr.270.1554605867815;
        Sat, 06 Apr 2019 19:57:47 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::ac9e])
        by smtp.gmail.com with ESMTPSA id b9sm22656939pfd.32.2019.04.06.19.57.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 19:57:47 -0700 (PDT)
Date:   Sat, 6 Apr 2019 19:57:45 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
        joe@wand.net.nz, yhs@fb.com, andrii.nakryiko@gmail.com,
        kafai@fb.com
Subject: Re: [PATCH bpf-next v4 01/16] bpf: implement lookup-free direct
 value access for maps
Message-ID: <20190407025744.ubfyynousc7rnyou@ast-mbp.dhcp.thefacebook.com>
References: <cover.1554497408.git.daniel@iogearbox.net>
 <777f5dda5ef99c1a1cb30dec46f64c1bc814552e.1554497408.git.daniel@iogearbox.net>
 <20190406015621.4yrcolqkweg3c2xy@ast-mbp.dhcp.thefacebook.com>
 <2389ce8e-55d4-226d-55f3-29190199bb8d@iogearbox.net>
 <20190406165449.oziv6pr4ylpvmi3b@ast-mbp.dhcp.thefacebook.com>
 <e576da84-4117-3988-25b8-65c32609c929@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e576da84-4117-3988-25b8-65c32609c929@iogearbox.net>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Apr 07, 2019 at 01:55:14AM +0200, Daniel Borkmann wrote:
> On 04/06/2019 06:54 PM, Alexei Starovoitov wrote:
> > On Sat, Apr 06, 2019 at 12:58:23PM +0200, Daniel Borkmann wrote:
> >> On 04/06/2019 03:56 AM, Alexei Starovoitov wrote:
> >>> On Fri, Apr 05, 2019 at 10:59:27PM +0200, Daniel Borkmann wrote:
> >>>>  
> >>>> -/* when bpf_ldimm64->src_reg == BPF_PSEUDO_MAP_FD, bpf_ldimm64->imm == fd */
> >>>> +/* When BPF ldimm64's insn[0].src_reg != 0 then this can have
> >>>> + * two extensions:
> >>>> + *
> >>>> + * insn[0].src_reg:  BPF_PSEUDO_MAP_FD   BPF_PSEUDO_MAP_VALUE
> >>>> + * insn[0].imm:      map fd              map fd
> >>>> + * insn[1].imm:      0                   offset into value
> >>>> + * insn[0].off:      0                   lower 16 bit of map index
> >>>> + * insn[1].off:      0                   higher 16 bit of map index
> >>>> + * ldimm64 rewrite:  address of map      address of map[index]+offset
> >>>> + * verifier type:    CONST_PTR_TO_MAP    PTR_TO_MAP_VALUE
> >>> ...
> >>>> +	else if (insn->src_reg == BPF_PSEUDO_MAP_VALUE)
> >>>> +		snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
> >>>> +			 "map[id:%u][%u]+%u", insn->imm,
> >>>> +			 ((__u32)(__u16)insn[0].off) |
> >>>> +			 ((__u32)(__u16)insn[1].off) << 16,
> >>>> +			 (insn + 1)->imm);
> >>>
> >>> Hopefully one last nit...
> >>> Do we really need to allow this odd split index support?
> >>> Later patches enforce array of 1 element and libbpf only uses that.
> >>> This index feature feels too quirky and not really useful at this moment.
> >>> Can we enforce that insn[0|1].off == 0 instead ?
> >>> Later we can extend it to mean index without breaking anything.
> >>
> >> I originally didn't have it in v2 of the series, but I ended up
> >> implementing it after feedback from Andrii back then complaining
> >> that it's too specific and not generic enough. I agreed with him
> >> that the limitation of max_elems = 1 wasn't too nice, so I went
> >> to implement that full 32 bit index can be used thus that it has
> >> the potential of efficient map lookup replacement for array maps in
> >> general which is quite nice since within single insn it allows to
> >> select index and offset into value all as simple 64 bit imm load.
> > 
> > I missed this discussion.
> > It sort-of sounds nice from kernel side, but how one can use it
> > from bpf program written in C ?
> > If it's assembler only feature, I'd rather not do it.
> > statc int ar1[N];
> > and 
> > static struct S { ...} ar2[M];
> > will still be normal map of 1 element from llvm side.
> > Right now there is no support for variable length access
> > into static vars. When it's added in the future the ar[var] will be
> > some base offset into map of 1 element plus register addition.
> > So no opportunity to use 'index'.
> > bpf_map_lookup_elem(map, &key); from program side passes
> > a pointer and it's a function call. Even if key is constant
> > register spill/fill due to function call caused perf loss,
> > so extra 'index' optimization won't buy much.
> > We can introduce some special intrinsic/builtin to support
> > this 'index' from C, but it's not pretty.
> > So far I couldn't come up with C example that can use such 'index' feature.
> 
> Wrt 'index' was mostly thinking into llvm-builtin direction for how
> it could be consumed from C aside from loaders. One example for complex
> networking programs that comes to mind right away would be mib-style error
> counters similarly we have in the stack where the counter acts as index for
> the direct lookup. 

how would such builtin look? I still don't see it fiting into C code.

> Another option [for loaders] could be (given the sections
> are for the whole object) to allow an option for some of the programs in
> a given object to have private .bss/.data/.rodata sections by allocating
> max_elems > 1 and selecting the target buffer via index given nothing
> changes in terms of size or vars. I still think it's a useful extension
> to carry and keeps the direct value access a generic implementation.

I don't get this shadow vs normal .data idea.
The more we talk the more I'm convinced that this is not a good api.
Say in the future we indeed have these shadow + normal .data
then just use the same insn->imm field to refer to shadow part.
Even if there are N such regions. The value_size is known.
So use 0<=imm<value_size to refer to 'index' 0 and
value_size<=imm<value_size*2 to refer to 'index' 1.
There is absolutely no need for offset and index to be separate.
Address of a byte inside bpf array can be expressed with single integer.

