Return-Path: <SRS0=xnNa=S5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E8DC43218
	for <bpf@archiver.kernel.org>; Sat, 27 Apr 2019 03:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C24462084F
	for <bpf@archiver.kernel.org>; Sat, 27 Apr 2019 03:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOL7vB/3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfD0DFR (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 26 Apr 2019 23:05:17 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34838 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfD0DFR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Apr 2019 23:05:17 -0400
Received: by mail-pg1-f193.google.com with SMTP id h1so2471655pgs.2;
        Fri, 26 Apr 2019 20:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nNi5DymUFzLaM12HUgcf9/3eV9Du5HXE8+2WnpWbfiY=;
        b=eOL7vB/3zGwHZ5sVZIb5qBZxIyEK97fdlY6/P19g6l7Y0aAM1GwdCHdqSVURpIwoBV
         mICko4ktb3oAp5j+UasYlDRCaKNGbFAkIXi0JUz5XEWnmmCjZWf4Xe2yYSUWdgPhjwQR
         bA8O1xVe1MnWzJSybVl9G+GoI8AotwEaP73/QWvUsmVa0yCKg2Fg84YJCyCthkFFYN3y
         8zaf7lcupPqtJEPF0DirczGor+VMilpfTxp0a+wxE2k7pni74raGGJL4wAY0+CiJe/7v
         EBwBPMEFrNFOw0+Ce2lkDrb9nPcj8uvpfUcQGsQjU2KCY/zqxtXkuvp8nSzJN7oqyNdq
         w9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nNi5DymUFzLaM12HUgcf9/3eV9Du5HXE8+2WnpWbfiY=;
        b=gvy6ve0kMFmihPGSiwO0OGW9G8G00pVINmYa+KdPANEUeo9Br4ZWrAhfUB5eFpkbfg
         piwTnJo1Ft6yp0itLmopKOft0674vekgRAJr9vw1UAoA3RRpOmWJe9w6kYJhZVw2htL0
         TZXJJRuZBwVw6FIYTYQLRnNoOkl9p1OjNq/YkbPI/Tl5Bly8EGRfY4som4MxmlCp+C8v
         abZj9fXk8VsLJdMfEGebQtAzdrY9J61E3zQdoUJy2n3UKZ4C9YqkYqhe+g5Fj7WzEj+I
         5AdAR7WRS6821EV48oddC1tU/sFI8TxD5LfJF2Vy8QR4jLyYYWMNhCvVpqdnWmbaswlb
         6YQA==
X-Gm-Message-State: APjAAAWuZwfvpIxddmQvmIxx0UUwCn0Iol6JQDCs37XjkgHrqgBFWqzT
        A6IPahGeaRoeUNHa4fgeLFs=
X-Google-Smtp-Source: APXvYqyr2ZU6Z31uItvCBa03joLNcerSUNpHk1ZdjjjPZVwkKGvpEgvAq8D8hhKfzcHQ269+tQMdiA==
X-Received: by 2002:a63:d10b:: with SMTP id k11mr23544286pgg.59.1556334316030;
        Fri, 26 Apr 2019 20:05:16 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:180::3b7e])
        by smtp.gmail.com with ESMTPSA id m131sm57284745pga.3.2019.04.26.20.05.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 20:05:15 -0700 (PDT)
Date:   Fri, 26 Apr 2019 20:05:13 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Jiong Wang <jiong.wang@netronome.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, daniel@iogearbox.net,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "oss-drivers@netronome.com" <oss-drivers@netronome.com>
Subject: Re: 32-bit zext time complexity (Was Re: [PATCH bpf-next]
 selftests/bpf: two scale tests)
Message-ID: <20190427030512.zs3tfdudjbfpyawh@ast-mbp>
References: <20190412214132.2726285-1-ast@kernel.org>
 <lyimv3hujp.fsf@netronome.com>
 <20190425043347.pxrz5ln4m7khebt6@ast-mbp.dhcp.thefacebook.com>
 <lylfzyeebr.fsf@netronome.com>
 <20190425221021.ov2jj4piann7wmid@ast-mbp.dhcp.thefacebook.com>
 <lyk1fgrk4m.fsf@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lyk1fgrk4m.fsf@netronome.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 26, 2019 at 02:06:33PM +0100, Jiong Wang wrote:
> 
> Alexei Starovoitov writes:
> 
> > On Thu, Apr 25, 2019 at 08:25:44AM +0100, Jiong Wang wrote:
> >> 
> >> Alexei Starovoitov writes:
> >> 
> >> > On Thu, Apr 25, 2019 at 12:07:06AM +0100, Jiong Wang wrote:
> >> >> 
> >> >> Alexei Starovoitov writes:
> >> >> 
> >> >> > Add two tests to check that sequence of 1024 jumps is verifiable.
> >> >> >
> >> >> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> >> >> > ---
> >> >> >  tools/testing/selftests/bpf/test_verifier.c  | 70 ++++++++++++++++++++
> >> >> >  tools/testing/selftests/bpf/verifier/scale.c | 18 +++++
> >> >> 
> >> >> I am rebasing 32-bit opt pass on top of latest bpf-next and found these new
> >> >> tests take more than 20 minutes to run and had not finished after that.
> >> >> 
> >> >> The reason the following insn filling insde bpf_fill_scale1 is generating
> >> >> nearly 1M insn whose results are recognized as safe to be poisoned.
> >> >> 
> >> >>   bpf_fill_scale1:
> >> >>     while (i < MAX_TEST_INSNS - 1025)
> >> >>       insn[i++] = BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 42);
> >> >> 
> >> >> For each hi32 poisoning, there will be one call to "bpf_patch_insn_data"
> >> >> which actually is not cheap (adjust jump insns, insn aux info etc). Now,
> >> >> 1M call to it has exhausted server resources as described, 20minutes running
> >> >> still not finished.
> >> >> 
> >> >> For real world applications, we don't do hi32 poisoning, and there isn't much
> >> >> lo32 zext. Benchmarking those bpf programs inside Cilium shows the final
> >> >> zext pass adds about 8% ~ 15% verification time.
> >> >> 
> >> >> The zext pass based on top of "bpf_patch_insn_data" looks more and more is
> >> >> not the best approach to utilize the read32 analysis results.
> >> >> 
> >> >> Previously, in v1 cover letter, I listed some of my other thoughts on how to
> >> >> utilize the liveness analysis results:
> >> >> 
> >> >>    1 Minor change on back-end JIT hook, also pass aux_insn information to
> >> >>      back-ends so they could have per insn information and they could do
> >> >>      zero extension for the marked insn themselves using the most
> >> >>      efficient native insn.
> >> >> 
> >> >>    2 Introduce zero extension insn for eBPF. Then verifier could insert
> >> >>      the new zext insn instead of lshift + rshift. zext could be JITed
> >> >>      more efficiently.
> >> >> 
> >> >>    3 Otherwise JIT back-ends need to do peephole to catch lshift + rshift
> >> >>      and turn them into native zext.
> >> >
> >> > all options sounds like hacks to workaround inefficient bpf_patch_insn_data().
> >> > Especially option 2 will work only because single insn is replaced
> >> > with another insn ?
> >> 
> >> Option 1 should be a generic solution. It is passing verifier analysis
> >> results generated by insn walk down to JIT back-ends. The information
> >> passed down could be any analysis result useful for JIT code-gen.
> >> 
> >> > Let's fix the algo of bpf_patch_insn_data() instead, so that 1 insn -> 2+ insn
> >> > is also fast.
> >> 
> >> The issue with 1 insn -> 2+ insn should be calling of bpf_adj_branches
> >> which is doing another for_each_insn_in_prog traversal, so the zext
> >> insertion becomes something like:
> >> 
> >>   for_each_insn_in_prog
> >>   ...
> >>      if (zext)
> >>      ...
> >>        for_each_insn_in_prog
> >> 
> >> which is quadratic. One solution is we chain all branch insns during
> >> previous insn traversal in for example cfg check, and keep the information
> >> somewhere info bpf_prog (env->insn_aux_data is a good place to keep such
> >> information, but insn patch helpers are supposed to work with bpf_prog)
> >> then bpf_adj_branches could traversal this chain instead of iterating
> >> through all insns.
> 
> Thanks very much for the feedbacks.
> 
> > I don't think it will make it much faster. There could be just as many
> > jumps as there are instructions.
> 
> Benchmarked a basic implemention on a couple of bpf programs in Cilium repo
> (the impl is a relocation list kept in a array built as by-product of
> check_subprogs. during patch, walk this relocation list instead of all
> insns. Then calculate time by 10 times run and take average)
> 
>  - The time spent on zero-extension pass is ~30% less
>  - The time spent on convert_ctx_accesses + fixup_bpf_call +
>    fixup_call_args is ~15% less
>  - The time spent on dead code elim pass is not changed which makes sense
>    as dead code is rare so patch infra is not triggered much.
> 
> So, looks like could help a little bit on daily program, but agree no
> fundamental improvements, it is still N(insn_needs_patch) * N(branch), and
> both N could go very big.
> 
> > Note that bpf_patch_insn_single() is calling bpf_adj_branches() twice too.
> > And dead_code + convert_ctx + fixup_bpf_calls are calling
> > bpf_patch_insn_single() a lot.
> > How about before dead_code pass we convert the program into basic-block
> > format, patch it all, and then convert from bb back to offsets.
> > Patching will become very cheap, since no loop over program will be
> > necessary. A jump from bb-N to bb-M will stay as-is regardless
> > of amount of patching was done inside each bb.
> > The loops inside these patching passes will be converted from:
> > for (i = 0; i < insn_cnt; i++, insn++)
> > into:
> > for each bb
> >   for each insn in bb
> 
> Interesting. If I am understanding correctly, BB then needs to support
> dynamic insn buffer resize. And after all insn patching finished, all BBs
> are finalized, we then linearized BBs (in a best order) to generate the
> final bpf image.

dynamic BB resize could be done similar to existing prog resize.
It grows in page increments.

> > As far as option 1 "also pass aux_insn information to JITs"...
> > in theory it's fine, but looks like big refactoring to existing code.
> 
> Will do quick explore, might turn out to be small change.
> 
> > So if you want to make this bb conversion as step 2 and unblock the
> > current patch set faster I suggest to go with option 2 "Introduce zero
> > extension insn".
> 
> A second think, even zero extension insn introduced, it is inserted after
> the sub-register write insn, so we are still doing insert *not*
> replacement, insn_delta inside bpf_patch_insn_single will be 1, so the slow
> path will always be taken (memmove + bpf_prog_realloc + 2 x
> bpf_adj_branches).

ahh. right.

> For the 1M-scale test, bpf_patch_insn_single is triggered because of hi32
> poisoning, not lo32 zext. So we just need to change MOV32 to MOV64 in the
> testcase which doesn't break the initial testing purpose of this testcase
> from my understanding. This then could avoid 1M call to
> bpf_patch_insn_single and pass the test after 32-bit opt patch set applied.
> 
> Without this change and with hi32 randomization enabled, scale tests will
> still hang before insn patch infra improved.
> 
> @@ -228,7 +228,7 @@ static void bpf_fill_scale1(struct bpf_test *self)           
> -             insn[i++] = BPF_ALU32_IMM(BPF_MOV, BPF_REG_0, 42);
> +             insn[i++] = BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 42);
> 
> This is change is not to paperover the underlying issue. We now know the
> existing insn patch infra doesn't scale to million level, so could work on
> improving it in the next step.

I'm hesitant to step back.
Do you see a program that can hit this patch_insn issue already?
(I mean without your hi32/lo32 zext changes).

> At the same time the issue exposed from hi32 poisoning does raise alarm
> that there could be the same issue for lo32 zext, therefore this patch set
> doesn't scale if there are lots of insns to be zero extended, even though
> this may not happen in real world bpf prog.
> 
> IMHO, avoid using insn patching when possible might always be better. So,
> if option 1 turns out to also generate clean patch set and introduce small
> changes, I am going to follow it in the update version.
> 
> Please let me know if you have different opinion.

if you can craft a test that shows patch_insn issue before your set,
then it's ok to hack bpf_fill_scale1 to use alu64.
I would also prefer to go with option 2 (new zext insn) for JITs.
I still don't have good feeling about option 1.
Exposing all of aux_data to JITs may become a headache
in the verifier development. It needs to be done carefully.

