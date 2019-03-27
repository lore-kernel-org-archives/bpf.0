Return-Path: <SRS0=YLVI=R6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9591FC4360F
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 19:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BE6D2064A
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 19:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="qfk2EihJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbfC0TNd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:13:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42319 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388560AbfC0TNd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Mar 2019 15:13:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id g3so16433945wrx.9
        for <bpf@vger.kernel.org>; Wed, 27 Mar 2019 12:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=mWSeryXoRj7FlCpRsyh+cq7d2KQs1bSYUPER+c/Yazk=;
        b=qfk2EihJAANHOCcfCX+N1GlyRX12TbkUOPmokZUEu/sE6xEJVAOgEPDHbQiWU4ERCj
         +tNIR6/KU7c7VEa9blznOtXigJ+eJm6Z7XbHmLtAvcTDmhFrQADXP2OcZ3iu3Ru8kMMv
         95EZ0dSAkSwOTgvj/VN2oL9pjq2M6z5oFGMdy1Yna5ZBuKPCbQoWg5+zCn7Ha1ruDR0s
         x0Vp3RYZyAe26GujHsLSh2QbfYaQ+S71NEikkChJMnr+9CAJQjyreZmb/waVlpmjGCk0
         OEigGEItOLY891eFRUXvV4Lt9Y1Q11fwoX70VyN3hDCbHAANuwYeDATgexY1dkSyib+Q
         2EpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=mWSeryXoRj7FlCpRsyh+cq7d2KQs1bSYUPER+c/Yazk=;
        b=uNDpsfs7VAa4cQqLaZsWP/cp3wULo1SdUW4I7GqBCW+qkt7m6St87NdFnB4phd9Z3A
         XaYihecl5xx7gBxJwVQX204oO1kKG9esqEz3yAoaJVCETpSav45oMSB/95uD+D29PfLc
         rw+OyfWfCop7k6tZ2J2LUX2iCTyut2m29jnsUjJaYmoon5ItJnw5+NCmsrYs1iXxxPsN
         GltBayAqOS7AjGqzL+xnA8n64AzQ7JKz7tWUTM3y2Ae57VxwXIzM3BkZEwhpHUEcPduA
         1SFKL6EnTP4bhyZ/4CJwBAS5IZ0AJ+Soe8qMTMyK+01hz0h+jmRWcdjH1GLtDZD1RM63
         ZCGg==
X-Gm-Message-State: APjAAAV+X/gcihS2Fw9l9uO0TLLyGBUe+844R/7v9QxzfRcSzKPJZ8gS
        J0dfmQVi9KOwR8MHANZ+pdjA+g==
X-Google-Smtp-Source: APXvYqzMLpTWCCn2KO4mRP/5b6Q5KAinCbe3fUe9e3ef7k5UltFyAgiKkUITJZGLgEwEJVE50DhtZA==
X-Received: by 2002:adf:ea82:: with SMTP id s2mr25795861wrm.302.1553714011228;
        Wed, 27 Mar 2019 12:13:31 -0700 (PDT)
Received: from LAPTOP-V3S7NLPL (cpc1-cmbg19-2-0-cust104.5-4.cable.virginm.net. [82.27.180.105])
        by smtp.gmail.com with ESMTPSA id e1sm33322986wrw.66.2019.03.27.12.13.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 12:13:30 -0700 (PDT)
References: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com> <1553623539-15474-7-git-send-email-jiong.wang@netronome.com> <20190327170035.qbyli5r5a3cctfca@ast-mbp> <352EED46-6368-4A25-B0DC-23D1E736C7A1@netronome.com> <20190327171717.hnq2ay4ajdl6ztli@ast-mbp> <15A1CE1E-E86F-4F8D-B43F-DF8A6000640A@netronome.com> <20190327174530.tyrz335ikudvybi7@ast-mbp>
User-agent: mu4e 0.9.18; emacs 25.2.2
From:   Jiong Wang <jiong.wang@netronome.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiong Wang <jiong.wang@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, oss-drivers@netronome.com
Subject: Re: [PATCH/RFC bpf-next 06/16] bpf: new sysctl "bpf_jit_32bit_opt"
In-reply-to: <20190327174530.tyrz335ikudvybi7@ast-mbp>
Date:   Wed, 27 Mar 2019 19:13:25 +0000
Message-ID: <874l7oruzu.fsf@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Alexei Starovoitov writes:

> On Wed, Mar 27, 2019 at 05:18:35PM +0000, Jiong Wang wrote:
>> 
>> > On 27 Mar 2019, at 17:17, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>> > 
>> > On Wed, Mar 27, 2019 at 05:06:01PM +0000, Jiong Wang wrote:
>> >> 
>> >>> On 27 Mar 2019, at 17:00, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>> >>> 
>> >>> On Tue, Mar 26, 2019 at 06:05:29PM +0000, Jiong Wang wrote:
>> >>>> After previous patches, verifier has marked those instructions that really
>> >>>> need zero extension on dst_reg.
>> >>>> 
>> >>>> It is then for all back-ends to decide how to use such information to
>> >>>> eliminate unnecessary zero extension codegen during JIT compilation.
>> >>>> 
>> >>>> One approach is:
>> >>>> 1. Verifier insert explicit zero extension for those instructions that
>> >>>>    need zero extension.
>> >>>> 2. All JIT back-ends do NOT generate zero extension for sub-register
>> >>>>    write any more.
>> >>>> 
>> >>>> The good thing for this approach is no major change on JIT back-end
>> >>>> interface, all back-ends could get this optimization.
>> >>>> 
>> >>>> However, only those back-ends that do not have hardware zero extension
>> >>>> want this optimization. For back-ends like x86_64 and AArch64, there is
>> >>>> hardware support, so this optimization should be disabled.
>> >>>> 
>> >>>> This patch introduces new sysctl "bpf_jit_32bit_opt" which is the control
>> >>>> variable for whether the optimization should be enabled.
>> >>>> 
>> >>>> It is initialized using target hook bpf_jit_hardware_zext which is default
>> >>>> true, meaning the underlying hardware will do zero extension automatically,
>> >>>> therefore the optimization will be disabled.
>> >>>> 
>> >>>> Offload targets do not use this native target hook, instead, they could
>> >>>> get the optimization results using bpf_prog_offload_ops.finalize.
>> >>>> 
>> >>>> The user could always enable or disable the optimization by using:
>> >>>> 
>> >>>>  sysctl net/core/bpf_jit_32bit_opt=[0 | 1]
>> >>> 
>> >>> I don't think there should be a sysctl for this.
>> >> 
>> >> The sysctl introduced mostly because I think it could be useful for testing.
>> >> For example on x86_64, with this sysctl, we can enable the optimisation and
>> >> can run selftest.
>> >> 
>> >> Does this make sense?
>> >> 
>> >> Or when one insn is marked, we print verbose info, so the tester could catch
>> >> it from log?
>> > 
>> > sysctl in this patch only triggers insertion of shifts.
>> > what kind of testing does it enable on x64?
>> > The writing insn is already 32-bit and hw does zero extend.
>> > These two shifts is always a nop?
>> > a sysctl to test that the verifier inserted shifts in the right place?
>> 
>> Yes, that’s the test methodology I am using. Match the instruction sequence after
>> shifts insertion.
>
> I see. I don't think such extra shifts right after hw zero extend will catch much.
> imo it would be better to populate upper 32-bit with random values on x64
> where verifier analysis showed that it's ok to do so.

Sound like a good idea, indeed gives much more stressful test on x64, and
if all tests passed under test_progs + -mattr=+alu32, then could be very
good assurance on the correctness.

> Such extra insns can be inserted by the verifier. Since such debugging
> has run-time cost we'd need a flag to turn it on.
> May be a new flag during prog load instead of sysctl?

OK, I will explore on this line, see if could have a clean solution.

> It can be a global switch inside libbpf, so test_verifier and test_progs
> wouldn't need to pass it everywhere explictly. It would double the test time,
> but it's worth doing always on all archs. Especially on x64.
>
> other thoughts...
> I guess it's ok to stick with shifts for now.
> Introducing new insn would be nice, but we can do it later.
> Changing all jits for this new insn as pre-patch to this set is too much.

+1

> peephole to convert shifts is probably useful regardless.
> bpf backend emits a bunch of useless shifts when alu32 is not used.
> Would be great if x86 jit can optimize it for such lazy users
> (and users who don't upgrade llvm fast enough or don't know about alu32)

Will do some checks on generic eBPF code-gen later to see how much peephole
opportunities there are.

Regards,
Jiong
