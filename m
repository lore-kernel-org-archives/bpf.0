Return-Path: <SRS0=8uh4=SB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E210DC43381
	for <bpf@archiver.kernel.org>; Sat, 30 Mar 2019 03:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A88152183F
	for <bpf@archiver.kernel.org>; Sat, 30 Mar 2019 03:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HaGnOyn4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730187AbfC3DfU (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 29 Mar 2019 23:35:20 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39585 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730184AbfC3DfU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Mar 2019 23:35:20 -0400
Received: by mail-pf1-f195.google.com with SMTP id i17so1927976pfo.6;
        Fri, 29 Mar 2019 20:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LtSiYY5vcyHyV04xFtkW2v4uEm9V06yvlZL2RfT80WY=;
        b=HaGnOyn4n/Kp07lm+sUpJBiDmua6a/uep1WeHerFC3Nyaqlf69o4iFkvNHLWKf01Yh
         uM2TdZShz5+vWDpFLROPykEPijAFY231r6mwpPxnkXJigL4Y4XeBw7CmuCWz1s0tkdPQ
         rvQQcLonwMt2BCjwWZBWNedCj+IM2cSfhoHWvnSJU1gkDAZJrpGBUb+2V/+XlXzkuAmd
         JN97sB5hcjiQhMzd7piQbTmrCTCfV9XuJpieGUvoWjg2WuWQCUoP+4w+MWABx0S2y/cg
         gXXhxaO3H/JgOYdeAealPz4GH9GvVhirPbq42F6kiZhJE5e559d9psGnJjzVtEj/705c
         OlZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LtSiYY5vcyHyV04xFtkW2v4uEm9V06yvlZL2RfT80WY=;
        b=ZOSpQKe3UqS5fxM5vJmCsYu2R8Tb0ABDpHUzueWS5aqn3kvjALlzXCrsPR02k8nG9J
         n7bLKil5u66T6EtYeerzVKJ1DtPlpbZrpUnSLueRdq1JosPxgQjDUihybbC+Wu6KAGBg
         HjWi0+NrD1iuecLlhR03BbdyS56+0lgPsDXvHTNn5Q0sxOWNSNJTMcYvrA6s/xBLxdxR
         JH82wkXZhJfit24pqGRhyskWvyArw7vnBnZw28X9gGnQua9+W8ZjGaNjD4+xWihvPqPn
         J5nUrkkxErD5LSnq4nI6pMQoXRHO2M09DZtKGdGfSlXpT+v6vZtX/1W373O1EJ5ZKbVd
         vJ6w==
X-Gm-Message-State: APjAAAUl38d20No4dwDkHAd+Wczu9AGboGk3Sdlnq0juHRtGuXeAiO24
        8mt31Nz0Mv1kohIiZcphULjWksc/
X-Google-Smtp-Source: APXvYqxbV2O3VcrXNTnURs8LsQ4d/LEIyDJjP448o8mK7kpMU9YhOWWr1G8bjVJtD/Tfy0+lte2mfQ==
X-Received: by 2002:a62:293:: with SMTP id 141mr49788340pfc.245.1553916919146;
        Fri, 29 Mar 2019 20:35:19 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::a875])
        by smtp.gmail.com with ESMTPSA id k75sm10410834pfj.46.2019.03.29.20.35.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 20:35:18 -0700 (PDT)
Date:   Fri, 29 Mar 2019 20:35:16 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, davem@davemloft.net,
        daniel@iogearbox.net, jannh@google.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 0/7] bpf: improve verifier scalability
Message-ID: <20190330033515.ttdu5pwfhkzdrdel@ast-mbp.dhcp.thefacebook.com>
References: <20190330001612.2354959-1-ast@kernel.org>
 <20190329201828.00c5c662@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329201828.00c5c662@cakuba.netronome.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 29, 2019 at 08:18:28PM -0700, Jakub Kicinski wrote:
> On Fri, 29 Mar 2019 17:16:05 -0700, Alexei Starovoitov wrote:
> > Realize two key ideas to speed up verification speed by ~20 times
> > 1. every 'branching' instructions records all verifier states.
> >    not all of them are useful for search pruning.
> >    add a simple heuristic to keep states that were successful in search pruning
> >    and remove those that were not
> > 2. mark_reg_read walks parentage chain of registers to mark parents as LIVE_READ.
> >    Once the register is marked there is no need to remark it again in the future.
> >    Hence stop walking the chain once first LIVE_READ is seen.
> > 
> > 1st optimization gives 10x speed up on large programs
> > and 2nd optimization reduces the cost of mark_reg_read from ~40% of cpu to <1%.
> > Combined the deliver ~20x speedup on large programs.
> > 
> > Faster and bounded verification time allows to increase insn_processed
> > limit to 1 million from 130k.
> > 
> > Worst case it takes 1/10 of a second to process that many instructions
> > and peak memory consumption is peak_states * sizeof(struct bpf_verifier_state)
> > which is around ~5Mbyte.
> > 
> > Increase insn_per_program limit for root to insn_processed limit.
> > 
> > Add verification stats and stress tests for verifier scalability.
> > 
> > This patch set is the first step to be able to accept large programs.
> > The verifier still suffers from its brute force algorithm and
> > large programs can easily hit 1M insn_processed limit.
> > A lot more work is necessary to be able to verify large programs.
> 
> Very nice!
> 
> Hopefully this doesn't discourage people from working on loops ;)

Definitely not :) we desperately need loops.
llvm performs 'pragma unroll' only for relatively small loop counts.
Walking stack traces still not possible.
In the test from patch 7 doing jhash() over 64-bytes will not work,
because llvm will generate a loop ignoring pragma unroll.

