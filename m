Return-Path: <SRS0=YLVI=R6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E36C43381
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 17:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 701D7206C0
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 17:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evFSpgYA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbfC0RRW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Mar 2019 13:17:22 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45318 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbfC0RRW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Mar 2019 13:17:22 -0400
Received: by mail-pf1-f195.google.com with SMTP id e24so9152171pfi.12;
        Wed, 27 Mar 2019 10:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FN155HAHAr35dPIlwmSfcNrCjbpYcmutgBiUF7hOhiY=;
        b=evFSpgYAcA20NwgPFy1BlDYsx9qnRKN3ZYIiqXKN+gJjQbs5ye0m3qmKikUhFkxJW6
         5IRjRoLZM6kRjraBGzy8dGrNXCWmluQRjUC94iLkHCMmk+k2lNeb2X2mK4AUeQFA/ZC4
         kssW7VsheI2VQEu/HOGw6BaLSgh9Sfg21aGGv80lonieefEUpQEgBHlGCaI7foUJSpRu
         I6eXZBxRrfvW1tVfmGThJF/i9UuW8YQk3AO0ZygwZ8HbrxZN4iE3vWL+HbIWnyTwWLTe
         jumxFPXgQ/J1KHCwSZX4negZ0PRDX/iUOgK6FX7LN5+TGIBBNfjC/NRmqbRWWFM5e3Ek
         gc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FN155HAHAr35dPIlwmSfcNrCjbpYcmutgBiUF7hOhiY=;
        b=CBh5H62uQLxXG4Unkh2oNso+SSYRsHKY4DnIBTQqC9a07blUCu5D0+2rRaBvdveT4y
         oyakq3FOGp1+wRmIAd9MtBzTndnDT1AslyxqtLQL3BOUwwcvy8I8fIsS0WogWp2LDXim
         ZxtrVhvDJvEQIkGfJjQomuls12OIqKI7gy4P0AkF6pfaM7bS/QaV1dCk55ny4+fNImHn
         wdfeILTY2Yl/KHVynrSm1w3gvgkQclUbWMFb6KUwjC99qpMDQp3Gki7kfs47nSXXcbGp
         q8AYXm232R03YRxJ4Ks76SODqAOxWCKbhQUBARdIrp1KlEYBaV1llEABuJolfomAL7z8
         p0Pg==
X-Gm-Message-State: APjAAAXO/Pj1TNf88nfCsakvmDecGeFHkFsfcTa3OXT/e+myjjUztrn0
        t/mPWTp6f6cxA/UAuQ1hz1WAkvWb
X-Google-Smtp-Source: APXvYqy0xdDQLq32JLU1JRHCyC2HFal8E254LYpK5LjlS0yOI7eXnFggwqL2o+30xBVQCT6LdqHIDw==
X-Received: by 2002:a65:63d7:: with SMTP id n23mr6777998pgv.26.1553707041261;
        Wed, 27 Mar 2019 10:17:21 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:180::ca40])
        by smtp.gmail.com with ESMTPSA id v6sm12634579pgv.92.2019.03.27.10.17.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 10:17:20 -0700 (PDT)
Date:   Wed, 27 Mar 2019 10:17:18 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Jiong Wang <jiong.wang@netronome.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, oss-drivers@netronome.com
Subject: Re: [PATCH/RFC bpf-next 06/16] bpf: new sysctl "bpf_jit_32bit_opt"
Message-ID: <20190327171717.hnq2ay4ajdl6ztli@ast-mbp>
References: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
 <1553623539-15474-7-git-send-email-jiong.wang@netronome.com>
 <20190327170035.qbyli5r5a3cctfca@ast-mbp>
 <352EED46-6368-4A25-B0DC-23D1E736C7A1@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <352EED46-6368-4A25-B0DC-23D1E736C7A1@netronome.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 27, 2019 at 05:06:01PM +0000, Jiong Wang wrote:
> 
> > On 27 Mar 2019, at 17:00, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > 
> > On Tue, Mar 26, 2019 at 06:05:29PM +0000, Jiong Wang wrote:
> >> After previous patches, verifier has marked those instructions that really
> >> need zero extension on dst_reg.
> >> 
> >> It is then for all back-ends to decide how to use such information to
> >> eliminate unnecessary zero extension codegen during JIT compilation.
> >> 
> >> One approach is:
> >>  1. Verifier insert explicit zero extension for those instructions that
> >>     need zero extension.
> >>  2. All JIT back-ends do NOT generate zero extension for sub-register
> >>     write any more.
> >> 
> >> The good thing for this approach is no major change on JIT back-end
> >> interface, all back-ends could get this optimization.
> >> 
> >> However, only those back-ends that do not have hardware zero extension
> >> want this optimization. For back-ends like x86_64 and AArch64, there is
> >> hardware support, so this optimization should be disabled.
> >> 
> >> This patch introduces new sysctl "bpf_jit_32bit_opt" which is the control
> >> variable for whether the optimization should be enabled.
> >> 
> >> It is initialized using target hook bpf_jit_hardware_zext which is default
> >> true, meaning the underlying hardware will do zero extension automatically,
> >> therefore the optimization will be disabled.
> >> 
> >> Offload targets do not use this native target hook, instead, they could
> >> get the optimization results using bpf_prog_offload_ops.finalize.
> >> 
> >> The user could always enable or disable the optimization by using:
> >> 
> >>   sysctl net/core/bpf_jit_32bit_opt=[0 | 1]
> > 
> > I don't think there should be a sysctl for this.
> 
> The sysctl introduced mostly because I think it could be useful for testing.
> For example on x86_64, with this sysctl, we can enable the optimisation and
> can run selftest.
> 
> Does this make sense?
> 
> Or when one insn is marked, we print verbose info, so the tester could catch
> it from log?

sysctl in this patch only triggers insertion of shifts.
what kind of testing does it enable on x64?
The writing insn is already 32-bit and hw does zero extend.
These two shifts is always a nop?
a sysctl to test that the verifier inserted shifts in the right place?

