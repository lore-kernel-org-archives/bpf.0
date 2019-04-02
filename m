Return-Path: <SRS0=V8Hm=SE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB8CC4360F
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 18:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCC212075E
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 18:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnkHsEe+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbfDBSMg (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 2 Apr 2019 14:12:36 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46377 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfDBSMg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Apr 2019 14:12:36 -0400
Received: by mail-pg1-f195.google.com with SMTP id q1so6943319pgv.13;
        Tue, 02 Apr 2019 11:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YVl4NDj+wdpKtWu6ryKOJv7QMoU2Kvj9TH1UNq+wNJ0=;
        b=dnkHsEe+ytXjJ7pzikQII8/ZkegQUgsOSh0EIusnFtWYk2NrNZ4SVQ5Aub3ByLb2w7
         m6A4j23ZUaEAAP43Tiw3kqdwWzgODFWNEThFoxpLsLPJ8Y61uJ/xNy/DJzcl+4fmKne+
         QOzARApSXq/J1aC8NynVCiy1iBnh5FC5RDaPQVDfBjmiROLXMo1N7guveCrigcQikgGQ
         H9dg9c8Q19wqjBue06+ScVEBGBwIdhbaa5FHyfJOSwyOG0KP2gZhUWq1RQ01d/kqP4AM
         2D0jB8p2CTSlljmp8HX/qxkc5zZHyqWTtkPdbxDtLE85xJfY1Fqtz0HuiUvzcjoHKua1
         07DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YVl4NDj+wdpKtWu6ryKOJv7QMoU2Kvj9TH1UNq+wNJ0=;
        b=fVZAYw+R1NSobeEDdwIuCiCMdUPCOMsNzJCJo7NSZIp9VOFEky/uYUt10OcMvrIFbx
         8yzAM3cw7hvcVwjO+8hRFD7PRX75hvqON1snUWoMybueWzPQQ68TuQzgfc6hqoRRNc7w
         280l21zFl5ETgdu3a9WqhVN0wNpbKoUVbn9lUQcuydSmvcu/WhFkXM45kJotwLEtecpo
         k9SkN2S2zJarugESLLroj8/RUzhMt50pVmT+Z8TvhscsY/L5XlNzw56/FYjrrNBjPuze
         mGMvmULUizFf5vnosSDAVKaYMIzYGsYFNg4tJ3dcHeHqrYcxQUZ/rNNd6LsJfNzOP2SI
         mRNQ==
X-Gm-Message-State: APjAAAUhq8GJWRyrjJwgKey12gSCcSsgtvQkrJOLJv6aBYoFh+Kjlfyf
        mGpf2RfwJJ0SH39DMxi8DJ4=
X-Google-Smtp-Source: APXvYqz/weIzlda87UJe3h/8RGgMRO3wubqP0xW065gaJd0LT4jB/ZvHgoI1npYy2wnlatQblvBU8w==
X-Received: by 2002:a62:2c91:: with SMTP id s139mr70411814pfs.196.1554228754729;
        Tue, 02 Apr 2019 11:12:34 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::1:1fef])
        by smtp.gmail.com with ESMTPSA id h184sm32900890pfc.78.2019.04.02.11.12.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 11:12:33 -0700 (PDT)
Date:   Tue, 2 Apr 2019 11:12:31 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>,
        "jannh@google.com" <jannh@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 7/7] selftests/bpf: add few verifier scale tests
Message-ID: <20190402181229.u74xkk7spgpco7bi@ast-mbp.dhcp.thefacebook.com>
References: <20190330001612.2354959-1-ast@kernel.org>
 <20190330001612.2354959-8-ast@kernel.org>
 <319e168a-6571-9a70-336a-6ecf8b61f040@iogearbox.net>
 <5753e047-163b-2a89-fb57-bdb1c01f1732@iogearbox.net>
 <b42e4d7f-a049-7487-98f7-4db901169ca3@fb.com>
 <35a0246d-006f-8e18-8da7-49f8ca440846@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35a0246d-006f-8e18-8da7-49f8ca440846@iogearbox.net>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 02, 2019 at 04:13:58PM +0200, Daniel Borkmann wrote:
> On 04/02/2019 04:08 AM, Alexei Starovoitov wrote:
> > On 4/1/19 9:35 AM, Daniel Borkmann wrote:
> >> On 04/01/2019 04:17 PM, Daniel Borkmann wrote:
> >>> On 03/30/2019 01:16 AM, Alexei Starovoitov wrote:
> >>>> Add 3 basic tests that stress verifier scalability.
> >>>>
> >>>> test_verif_scale1.c calls non-inlined jhash() function 90 times on
> >>>> different position in the packet.
> >>>> This test simulates network packet parsing.
> >>>> jhash function is ~140 instructions and main program is ~1200 insns.
> >>>>
> >>>> test_verif_scale2.c force inlines jhash() function 90 times.
> >>>> This program is ~15k instructions long.
> >>>>
> >>>> test_verif_scale3.c calls non-inlined jhash() function 90 times on
> >>>> But this time jhash has to process 32-bytes from the packet
> >>>> instead of 14-bytes in tests 1 and 2.
> >>>> jhash function is ~230 insns and main program is ~1200 insns.
> >>>>
> >>>> $ test_progs -s
> >>>> can be used to see verifier stats.
> >>>>
> >>>> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> >>>
> >>> Do you also have some test cases with actual 1M insns resp. such that hit
> >>> the new complexity limit to check timing / resources it consumes? I think
> >>> these would be good to have as well as part of selftests.
> >>
> >> (Another thought on why it would be good to have such tests would be to
> >> see if we would otherwise break long jumps again due to offset truncation
> >> which we had in the core as well as in JITs in the past.)
> > 
> > llvm truncates jump offsets for large programs.
> > Unfortunately we need to introduce JA instruction
> > with 32-bit offset on kernel side before we can fix llvm.
> > There are plenty of other scalability issues on the kernel side.
> > This patch set is the first step.
> 
> Right.
> 
> > Only non-jumpy program of 1m insn loads and works.
> > Realistically we're still far away from accepting large programs,
> > but to get there we need to bump the limit and experience these issues.
> 
> I think my main worry is that if we're realistically still far away from
> accepting 1M insns programs and have potential unknown blockers in the
> road wrt verifying safety, then why lifting the limit for root to 1M
> today already?
> 
> I think the complexity limit itself is fine, but why not being more
> conservative on the number of instructions to something we believe
> verifier can realistically handle /today/ wrt worst case consumptions in
> case of complexity attacks, and go further from there? Once it's on 1M in
> UAPI it's effectively frozen and then we'll be re-adding slightly similar
> upper limits again which caps the 1M to something much lower (though I
> doubt we'll see such large programs any time soon).

1m is not an uapi.
4k sort-of was an uapi limit, but in practice it wasn't.
Could we load all programs that fit into 4k? Obviously not.
There are plenty of internal verifier limits.
Like BPF_COMPLEXITY_LIMIT_STACK. They are discoverable by user space,
but they are not uapi. Meaning that we can change them whichever direction.
BPF_COMPLEXITY_LIMIT_STATES is 64, but I'm thinking to decrease it to 8.

Here is the commit log from patch 6:
"This patch removes the limit for root programs from uapi.
BPF_COMPLEXITY_LIMIT_INSNS is the kernel internal limit
and success to load the program no longer depends on program size,
but on 'smartness' of the verifier only.
The verifier will continue to get smarter with every kernel release.
"
Removing 4k limit for root doesn't change much from user's perspective.
Every program has a different limit depending on a kernel version.
I gave an example in patch 6 where folks compile the same program
with different #define because verifier smartness is different
between kernels.
4k was a stated limit, but irrelevant in practice.
Am I happy with this situation? Of coure not.
I've been talking about the requirement to support 1m instructions
for a year now, but most bpf developers didn't take it seriously and
I see a creep of features into the verifier that makes it harder and
harder to support large programs.
Most folks operate with an assumption that bpf programs are tiny,
so it's ok to use inefficent algorithms. This has to change.
We have to remove the limit and experience these issues otherwise
that day of verifier being 'ready' will never come.
With 4k limit syzbot found a way to make verifier spend 10 seconds
verifying a program of ~300 instructions long.
Will it find something again? No doubt. Whether the limit on program
size is there or not is not going to stop fuzzing tools.
The removal of instruction limit is changing bpf developer's mindset.
It's changing _us_. That's the key difference.
It is a requirement to support large programs and we need to make sure
internals of the verifier can scale.

