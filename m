Return-Path: <SRS0=aERf=S3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9ABDC43219
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 22:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C794420717
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 22:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFSzps5c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731437AbfDYWK2 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Apr 2019 18:10:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36725 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfDYWK1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Apr 2019 18:10:27 -0400
Received: by mail-pg1-f193.google.com with SMTP id 85so536717pgc.3;
        Thu, 25 Apr 2019 15:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lNzv5YnCAoOuP2miNVXhRvdpJ6Qguf1szGEvKzoeV5I=;
        b=WFSzps5c103wbX9GiOfvRRYuHk9XvQo4yQGcw/GoRGG4ZuQp8tvK6y4zXUh9Ji/GWa
         IIR8xmlAlmhc4BuHwzkAgEzZPAq8CXlc8+z9H4mrFsHyDCfV1TK12ghU050ZVsUj/inc
         pyRmsshYI2Cr2ZCaw9ePa4+dsX/5SEXUWtBCamlpeWZPR0f187afueVwQp2clWSeiTId
         Zr+AYa98SqI1gT58sRf/udR07Bh/gFDMxxxNbqs2PW9iHCmKso10wtedzNQ/xP4xzi40
         t/3+TpdE9nesY78WSWzkgiFmHp92A9yOq67U1NNCm0QBb251+pXFCSdeOQYFUO0Tw0qx
         DsKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lNzv5YnCAoOuP2miNVXhRvdpJ6Qguf1szGEvKzoeV5I=;
        b=Vbm6TLGBaZzen2ZJ3dK1aTfHfFf3Egh6T6a9+447oYrLLY0ZGX3tfkAbZJLdyCIfJi
         ed6r4ZBzjnyJht84lfwlPC5UNCgKgJXM1cZf3nfBIBJHM3Fj+afhnPF6FVbSgbtstQX2
         daoKssvaeAL2OcdsglqX/M/NcFipFZC8Fko2RQ0mbKweEguaYkS6jhIDU79NULdN0J4x
         DO40nbyYjyQtUev73dWa/3V0FZuvldkdCl+fbIZPeCHRRfeEPmqMcwZEaVjHbxahFfcE
         Nf51uyv/WoM6FgrWHFcyh2QkVXo/0n/6Oyooyjocq1pgzptXTMtXFNALSZXruVAtZZLA
         ulQw==
X-Gm-Message-State: APjAAAXNoOzAk9Ek03dudEVMdqgGBbJtEa1uMwf+gJR9f9cZYOlNU0cS
        vWqsuvAhWVA6f4Aw+DdgGwA=
X-Google-Smtp-Source: APXvYqz1z+gwJibBrLEDBPRJKo4B1JofpEgcGbivlcURE4ZWdrjF+BsQkYSVuFar3c3936XXJwnohA==
X-Received: by 2002:a63:6888:: with SMTP id d130mr39810974pgc.451.1556230226406;
        Thu, 25 Apr 2019 15:10:26 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::3cda])
        by smtp.gmail.com with ESMTPSA id b13sm32414163pfd.12.2019.04.25.15.10.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 15:10:25 -0700 (PDT)
Date:   Thu, 25 Apr 2019 15:10:24 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Jiong Wang <jiong.wang@netronome.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, daniel@iogearbox.net,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "oss-drivers@netronome.com" <oss-drivers@netronome.com>
Subject: Re: 32-bit zext time complexity (Was Re: [PATCH bpf-next]
 selftests/bpf: two scale tests)
Message-ID: <20190425221021.ov2jj4piann7wmid@ast-mbp.dhcp.thefacebook.com>
References: <20190412214132.2726285-1-ast@kernel.org>
 <lyimv3hujp.fsf@netronome.com>
 <20190425043347.pxrz5ln4m7khebt6@ast-mbp.dhcp.thefacebook.com>
 <lylfzyeebr.fsf@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lylfzyeebr.fsf@netronome.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 25, 2019 at 08:25:44AM +0100, Jiong Wang wrote:
> 
> Alexei Starovoitov writes:
> 
> > On Thu, Apr 25, 2019 at 12:07:06AM +0100, Jiong Wang wrote:
> >> 
> >> Alexei Starovoitov writes:
> >> 
> >> > Add two tests to check that sequence of 1024 jumps is verifiable.
> >> >
> >> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> >> > ---
> >> >  tools/testing/selftests/bpf/test_verifier.c  | 70 ++++++++++++++++++++
> >> >  tools/testing/selftests/bpf/verifier/scale.c | 18 +++++
> >> 
> >> I am rebasing 32-bit opt pass on top of latest bpf-next and found these new
> >> tests take more than 20 minutes to run and had not finished after that.
> >> 
> >> The reason the following insn filling insde bpf_fill_scale1 is generating
> >> nearly 1M insn whose results are recognized as safe to be poisoned.
> >> 
> >>   bpf_fill_scale1:
> >>     while (i < MAX_TEST_INSNS - 1025)
> >>       insn[i++] = BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 42);
> >> 
> >> For each hi32 poisoning, there will be one call to "bpf_patch_insn_data"
> >> which actually is not cheap (adjust jump insns, insn aux info etc). Now,
> >> 1M call to it has exhausted server resources as described, 20minutes running
> >> still not finished.
> >> 
> >> For real world applications, we don't do hi32 poisoning, and there isn't much
> >> lo32 zext. Benchmarking those bpf programs inside Cilium shows the final
> >> zext pass adds about 8% ~ 15% verification time.
> >> 
> >> The zext pass based on top of "bpf_patch_insn_data" looks more and more is
> >> not the best approach to utilize the read32 analysis results.
> >> 
> >> Previously, in v1 cover letter, I listed some of my other thoughts on how to
> >> utilize the liveness analysis results:
> >> 
> >>    1 Minor change on back-end JIT hook, also pass aux_insn information to
> >>      back-ends so they could have per insn information and they could do
> >>      zero extension for the marked insn themselves using the most
> >>      efficient native insn.
> >> 
> >>    2 Introduce zero extension insn for eBPF. Then verifier could insert
> >>      the new zext insn instead of lshift + rshift. zext could be JITed
> >>      more efficiently.
> >> 
> >>    3 Otherwise JIT back-ends need to do peephole to catch lshift + rshift
> >>      and turn them into native zext.
> >
> > all options sounds like hacks to workaround inefficient bpf_patch_insn_data().
> > Especially option 2 will work only because single insn is replaced
> > with another insn ?
> 
> Option 1 should be a generic solution. It is passing verifier analysis
> results generated by insn walk down to JIT back-ends. The information
> passed down could be any analysis result useful for JIT code-gen.
> 
> > Let's fix the algo of bpf_patch_insn_data() instead, so that 1 insn -> 2+ insn
> > is also fast.
> 
> The issue with 1 insn -> 2+ insn should be calling of bpf_adj_branches
> which is doing another for_each_insn_in_prog traversal, so the zext
> insertion becomes something like:
> 
>   for_each_insn_in_prog
>   ...
>      if (zext)
>      ...
>        for_each_insn_in_prog
> 
> which is quadratic. One solution is we chain all branch insns during
> previous insn traversal in for example cfg check, and keep the information
> somewhere info bpf_prog (env->insn_aux_data is a good place to keep such
> information, but insn patch helpers are supposed to work with bpf_prog)
> then bpf_adj_branches could traversal this chain instead of iterating
> through all insns.

I don't think it will make it much faster. There could be just as many
jumps as there are instructions.
Note that bpf_patch_insn_single() is calling bpf_adj_branches() twice too.
And dead_code + convert_ctx + fixup_bpf_calls are calling
bpf_patch_insn_single() a lot.
How about before dead_code pass we convert the program into basic-block
format, patch it all, and then convert from bb back to offsets.
Patching will become very cheap, since no loop over program will be
necessary. A jump from bb-N to bb-M will stay as-is regardless
of amount of patching was done inside each bb.
The loops inside these patching passes will be converted from:
for (i = 0; i < insn_cnt; i++, insn++)
into:
for each bb
  for each insn in bb

As far as option 1 "also pass aux_insn information to JITs"...
in theory it's fine, but looks like big refactoring to existing code.
So if you want to make this bb conversion as step 2 and unblock the
current patch set faster I suggest to go with option 2 "Introduce zero extension insn".

