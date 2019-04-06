Return-Path: <SRS0=Rhtb=SI=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB09BC10F06
	for <bpf@archiver.kernel.org>; Sat,  6 Apr 2019 16:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF37A20989
	for <bpf@archiver.kernel.org>; Sat,  6 Apr 2019 16:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLt2Uuk8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfDFQy4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 6 Apr 2019 12:54:56 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34858 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfDFQy4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Apr 2019 12:54:56 -0400
Received: by mail-pl1-f194.google.com with SMTP id w24so4776410plp.2;
        Sat, 06 Apr 2019 09:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I36yhVxlrTwFVsLIPv3OhgPHWCFs2GbyhPCt+MyVTt8=;
        b=ZLt2Uuk8WU8hfEsSW1FN1c4ZTnaQNd4Rq3pCNKEfdjDQN5O0RF2ktnBG8Ul28kyBfY
         cFca2ODx8MIoADix1XKdAFEm3Qo/yxFk+p6gYR9NYb5kVhQ8HliiVopWlLo53N62aLP8
         lhzlkAykqGUDrGfkuGoxfLDbzMVMVDCDKmKi+HooVH+wP2GxnPVp177Hbfunm2AF90O3
         TLMg5KHWx+d7HNzVOXYmXU83H4oRgdzeCe+L1C6f0GVK5OEZBTEy6NH2aYjch5HAycmZ
         0ppiAyjLmV0VcSzwCoDwAMJ4P6WSvxFbHfb1WD78cnXaRumE35BDl4QhwXUewZH/Llkx
         aK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I36yhVxlrTwFVsLIPv3OhgPHWCFs2GbyhPCt+MyVTt8=;
        b=ae+3YzN1LCqZSqXPASjXY4IJcRVuez4R3QwVLRcgCAzXPCQAi0qDIcJsHsIS0Td1sg
         TsI1yXXmK8dWYpTj5dMQXpuWfmsXpshxEvnbzkEl9BvIvqZuiyCq0E9Jdr9ZkG3wpl9l
         CXu6HSKbe6h0Igh9vkAcUNnHlI7ric/DR7+/CoQuQCx/bKrm7fP9OdRWEscNaKZxdcZj
         NN2kadkWNdlBPIjtFR5Vcxl/f+MGudfYnWNaAgVcaigzS1EgZJReVdD2hPiKsL10mn3z
         bcnmvZRGO4UPU9bFTrMP8afOSV0tyUKdLK8W9K703FtdEX3iHt9F6Wo1qH05Aq3z47qZ
         2qPg==
X-Gm-Message-State: APjAAAW1yatbVRnA3HoJIf7TJjiwV5XxYLF7jujgIRPvt3zzqNkgCGhP
        EtKf/Ye89844edmomFVckCM=
X-Google-Smtp-Source: APXvYqxfTMArTLQZ+9UuaSbfarvFyLaNDKLIrE5AHuI2h9DVTvEc8/Jsq7j95Ft1Sb3Zdk/0uUGabg==
X-Received: by 2002:a17:902:b407:: with SMTP id x7mr20466359plr.288.1554569695028;
        Sat, 06 Apr 2019 09:54:55 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1950])
        by smtp.gmail.com with ESMTPSA id n3sm43797558pfa.99.2019.04.06.09.54.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 09:54:54 -0700 (PDT)
Date:   Sat, 6 Apr 2019 09:54:51 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
        joe@wand.net.nz, yhs@fb.com, andrii.nakryiko@gmail.com,
        kafai@fb.com
Subject: Re: [PATCH bpf-next v4 01/16] bpf: implement lookup-free direct
 value access for maps
Message-ID: <20190406165449.oziv6pr4ylpvmi3b@ast-mbp.dhcp.thefacebook.com>
References: <cover.1554497408.git.daniel@iogearbox.net>
 <777f5dda5ef99c1a1cb30dec46f64c1bc814552e.1554497408.git.daniel@iogearbox.net>
 <20190406015621.4yrcolqkweg3c2xy@ast-mbp.dhcp.thefacebook.com>
 <2389ce8e-55d4-226d-55f3-29190199bb8d@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2389ce8e-55d4-226d-55f3-29190199bb8d@iogearbox.net>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 06, 2019 at 12:58:23PM +0200, Daniel Borkmann wrote:
> On 04/06/2019 03:56 AM, Alexei Starovoitov wrote:
> > On Fri, Apr 05, 2019 at 10:59:27PM +0200, Daniel Borkmann wrote:
> >>  
> >> -/* when bpf_ldimm64->src_reg == BPF_PSEUDO_MAP_FD, bpf_ldimm64->imm == fd */
> >> +/* When BPF ldimm64's insn[0].src_reg != 0 then this can have
> >> + * two extensions:
> >> + *
> >> + * insn[0].src_reg:  BPF_PSEUDO_MAP_FD   BPF_PSEUDO_MAP_VALUE
> >> + * insn[0].imm:      map fd              map fd
> >> + * insn[1].imm:      0                   offset into value
> >> + * insn[0].off:      0                   lower 16 bit of map index
> >> + * insn[1].off:      0                   higher 16 bit of map index
> >> + * ldimm64 rewrite:  address of map      address of map[index]+offset
> >> + * verifier type:    CONST_PTR_TO_MAP    PTR_TO_MAP_VALUE
> > ...
> >> +	else if (insn->src_reg == BPF_PSEUDO_MAP_VALUE)
> >> +		snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
> >> +			 "map[id:%u][%u]+%u", insn->imm,
> >> +			 ((__u32)(__u16)insn[0].off) |
> >> +			 ((__u32)(__u16)insn[1].off) << 16,
> >> +			 (insn + 1)->imm);
> > 
> > Hopefully one last nit...
> > Do we really need to allow this odd split index support?
> > Later patches enforce array of 1 element and libbpf only uses that.
> > This index feature feels too quirky and not really useful at this moment.
> > Can we enforce that insn[0|1].off == 0 instead ?
> > Later we can extend it to mean index without breaking anything.
> 
> I originally didn't have it in v2 of the series, but I ended up
> implementing it after feedback from Andrii back then complaining
> that it's too specific and not generic enough. I agreed with him
> that the limitation of max_elems = 1 wasn't too nice, so I went
> to implement that full 32 bit index can be used thus that it has
> the potential of efficient map lookup replacement for array maps in
> general which is quite nice since within single insn it allows to
> select index and offset into value all as simple 64 bit imm load.

I missed this discussion.
It sort-of sounds nice from kernel side, but how one can use it
from bpf program written in C ?
If it's assembler only feature, I'd rather not do it.
statc int ar1[N];
and 
static struct S { ...} ar2[M];
will still be normal map of 1 element from llvm side.
Right now there is no support for variable length access
into static vars. When it's added in the future the ar[var] will be
some base offset into map of 1 element plus register addition.
So no opportunity to use 'index'.
bpf_map_lookup_elem(map, &key); from program side passes
a pointer and it's a function call. Even if key is constant
register spill/fill due to function call caused perf loss,
so extra 'index' optimization won't buy much.
We can introduce some special intrinsic/builtin to support
this 'index' from C, but it's not pretty.
So far I couldn't come up with C example that can use such 'index' feature.

