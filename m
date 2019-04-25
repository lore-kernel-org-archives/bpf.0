Return-Path: <SRS0=aERf=S3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BBDC10F03
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 04:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB526217D7
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 04:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhyZ1pH/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbfDYEdx (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Apr 2019 00:33:53 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40990 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfDYEdx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Apr 2019 00:33:53 -0400
Received: by mail-pf1-f193.google.com with SMTP id 188so10454070pfd.8;
        Wed, 24 Apr 2019 21:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=msrzkTQvGrUwEbzXG6dVUi5uLONnEqNqLeEY5YHKs/M=;
        b=dhyZ1pH/y/lkbUr01Yv0qzir76DuzRJBnWaM+AXyadxwlrmxPfOG+9sm/b3Mas6jbT
         8K+Fsw+lpz9Z4TukRt0hnMiHbDYKnv9DVjpojd9YK9JIOMCicwZiv6+Swvgqn6emcL7T
         DC3V6hesCPQr1tuDoLNPET2l2hh3qJfE0S+T9qCNqlNv45quRJB9nWA7EdNx0vyeAWAa
         GrrvvLwRCUrNy/tGZnfzwLQmJB47J2lPq9Ed/4sWSGm5z0HX40ywFxyZrOpekzvqXrI4
         jeP3iA7REikrmt5oSGEVq4rVNO0MnX+P0hE+DK1zwrhMAoBk67q4OpUi08CgfhsZjo62
         GTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=msrzkTQvGrUwEbzXG6dVUi5uLONnEqNqLeEY5YHKs/M=;
        b=YGxe2Z0+Mb9qrAT2OCaNJCJeA37crArFCu93KsHNpJ98zCgwt+mo2QLNw2OABBXsju
         zAZKsl8nBJTCFjZ2Sm0HPzrJiOBn48t9IBoVpGsQcodD4k+S0RWgG4E8DicK+vzRKZdi
         03rPlTBROKsZsjWC0vX/fPMTWiS0Z2TueFTTGICw3exv8dDbt2Zavc3LRjLRt2fLzalj
         g/3pdng0A3kUpwnIMWAGLfAMSPiEo4MXjWuPRjELFKPpVXLEj9l+02RnWFI6fNyL+XaB
         5BVdfs3XM4FTAgwLLHgNJuLzh5xnQXhGDpCDdQTkot+E26Tc7kxeHMntDfFnpjzGsGHJ
         N5Uw==
X-Gm-Message-State: APjAAAXjB358BKOPVyu8vqrya7fVvYR2J5xlG5Uke4g5VY7fy17j5Aks
        E/RtmWELrUkmuyGjU7w6OG4=
X-Google-Smtp-Source: APXvYqzuHXsgdXwizUJW6xlaeBvh80S4rDhLe2ad7WbJN2E3Pbye8qswPBxQfUHSB7eJEah/yrO43A==
X-Received: by 2002:a63:4f1c:: with SMTP id d28mr34236755pgb.144.1556166832315;
        Wed, 24 Apr 2019 21:33:52 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::e649])
        by smtp.gmail.com with ESMTPSA id t12sm40305749pfl.59.2019.04.24.21.33.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 21:33:51 -0700 (PDT)
Date:   Wed, 24 Apr 2019 21:33:49 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Jiong Wang <jiong.wang@netronome.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, daniel@iogearbox.net,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "oss-drivers@netronome.com" <oss-drivers@netronome.com>
Subject: Re: 32-bit zext time complexity (Was Re: [PATCH bpf-next]
 selftests/bpf: two scale tests)
Message-ID: <20190425043347.pxrz5ln4m7khebt6@ast-mbp.dhcp.thefacebook.com>
References: <20190412214132.2726285-1-ast@kernel.org>
 <lyimv3hujp.fsf@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lyimv3hujp.fsf@netronome.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 25, 2019 at 12:07:06AM +0100, Jiong Wang wrote:
> 
> Alexei Starovoitov writes:
> 
> > Add two tests to check that sequence of 1024 jumps is verifiable.
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/test_verifier.c  | 70 ++++++++++++++++++++
> >  tools/testing/selftests/bpf/verifier/scale.c | 18 +++++
> 
> I am rebasing 32-bit opt pass on top of latest bpf-next and found these new
> tests take more than 20 minutes to run and had not finished after that.
> 
> The reason the following insn filling insde bpf_fill_scale1 is generating
> nearly 1M insn whose results are recognized as safe to be poisoned.
> 
>   bpf_fill_scale1:
>     while (i < MAX_TEST_INSNS - 1025)
>       insn[i++] = BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 42);
> 
> For each hi32 poisoning, there will be one call to "bpf_patch_insn_data"
> which actually is not cheap (adjust jump insns, insn aux info etc). Now,
> 1M call to it has exhausted server resources as described, 20minutes running
> still not finished.
> 
> For real world applications, we don't do hi32 poisoning, and there isn't much
> lo32 zext. Benchmarking those bpf programs inside Cilium shows the final
> zext pass adds about 8% ~ 15% verification time.
> 
> The zext pass based on top of "bpf_patch_insn_data" looks more and more is
> not the best approach to utilize the read32 analysis results.
> 
> Previously, in v1 cover letter, I listed some of my other thoughts on how to
> utilize the liveness analysis results:
> 
>    1 Minor change on back-end JIT hook, also pass aux_insn information to
>      back-ends so they could have per insn information and they could do
>      zero extension for the marked insn themselves using the most
>      efficient native insn.
> 
>    2 Introduce zero extension insn for eBPF. Then verifier could insert
>      the new zext insn instead of lshift + rshift. zext could be JITed
>      more efficiently.
> 
>    3 Otherwise JIT back-ends need to do peephole to catch lshift + rshift
>      and turn them into native zext.

all options sounds like hacks to workaround inefficient bpf_patch_insn_data().
Especially option 2 will work only because single insn is replaced
with another insn ?
Let's fix the algo of bpf_patch_insn_data() instead, so that 1 insn -> 2+ insn
is also fast.
The main point of bumping the internal limits to 1M and these tests
was to expose such algorithmic inefficiencies.

