Return-Path: <SRS0=YLVI=R6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01831C10F00
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 17:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD04206B7
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 17:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hmi8k5hr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfC0Rpg (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Mar 2019 13:45:36 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38587 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728209AbfC0Rpf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Mar 2019 13:45:35 -0400
Received: by mail-pl1-f193.google.com with SMTP id g37so3652560plb.5;
        Wed, 27 Mar 2019 10:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+yo1Jj63QvuaiWIGvvgKSIl+AvyqQhTzUQsM4Q+XJuc=;
        b=Hmi8k5hrLv/tJGA/mQPT32TzjsuP3SHU+HJMBj1s6J9mpT427tzamhTDxwp/4GTdLK
         o/zZkpj41KQrqeRjQOhzFyW/5sDVjj5FoE5nc/tmoAwQRQxbqN2MNPkD0ZsVF/1YlNrQ
         iW7shtntBXxx+W/5NYEk7hFeAqldwGsY5zSxAcDg1aLPaNhwjhKUaHYn44kSL6PeqyGC
         zI7UOXHrO1K/UzJuQIw8G9xfZ+B184E2x5LlaL5kJXVUIWbCnMfnposaDrBR2L1YH+cb
         3gdsy8EJO0MXsDvRHRC2pvqZo/P7VUpJbVCwKY6IkoOPzUfYWxmgn6EOt1PBKUVJEDNK
         KXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+yo1Jj63QvuaiWIGvvgKSIl+AvyqQhTzUQsM4Q+XJuc=;
        b=mdKhn2RQgizqxf4xCP5M+xCSIwghD84+4Tgg5PsfCxqO8jCKfyP0bLmc19LBvi9Dgm
         6ORtfVQeifk4jsEz331woYEzQw4KU4xBlOw4EGte5NgayNtkLYm62Vfus95g3djrA+VN
         5aI/fJAquEtgc2DW/ZIaHswddWRmYBUclINP3qmhz845vAf98WdvbWlEYoYyzFQACVAo
         GKQ+nUh75QLi4wmGXcJXMzydDNBHUClEx9IVuVcFO2HiCVQGRpjYn98Pm16WUYEk0Vwb
         NzgUWouzRmXlsM5vFgqIW7owME8jp/eY8ZLsUGmbP/eY62Rx28RYMgQ9cgZTpRa53b6k
         vb3Q==
X-Gm-Message-State: APjAAAXEqQcKP+MHzjB9KZYnjIq5Ksxh9lQ5xZK4xh8WnQ5Q4MGujlWB
        cyFYadx2JE7kxtZT3DWcIE4=
X-Google-Smtp-Source: APXvYqx7X4XI26qANqtd8Op6mix77U0K5wUgnboCCWHHSQIvvmk5y3DS58Zoy39jqud53SJjgR+C+A==
X-Received: by 2002:a17:902:8e82:: with SMTP id bg2mr38669217plb.217.1553708734681;
        Wed, 27 Mar 2019 10:45:34 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:180::ca40])
        by smtp.gmail.com with ESMTPSA id u15sm33218514pfm.163.2019.03.27.10.45.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 10:45:33 -0700 (PDT)
Date:   Wed, 27 Mar 2019 10:45:32 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Jiong Wang <jiong.wang@netronome.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, oss-drivers@netronome.com
Subject: Re: [PATCH/RFC bpf-next 06/16] bpf: new sysctl "bpf_jit_32bit_opt"
Message-ID: <20190327174530.tyrz335ikudvybi7@ast-mbp>
References: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
 <1553623539-15474-7-git-send-email-jiong.wang@netronome.com>
 <20190327170035.qbyli5r5a3cctfca@ast-mbp>
 <352EED46-6368-4A25-B0DC-23D1E736C7A1@netronome.com>
 <20190327171717.hnq2ay4ajdl6ztli@ast-mbp>
 <15A1CE1E-E86F-4F8D-B43F-DF8A6000640A@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15A1CE1E-E86F-4F8D-B43F-DF8A6000640A@netronome.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 27, 2019 at 05:18:35PM +0000, Jiong Wang wrote:
> 
> > On 27 Mar 2019, at 17:17, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > 
> > On Wed, Mar 27, 2019 at 05:06:01PM +0000, Jiong Wang wrote:
> >> 
> >>> On 27 Mar 2019, at 17:00, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> >>> 
> >>> On Tue, Mar 26, 2019 at 06:05:29PM +0000, Jiong Wang wrote:
> >>>> After previous patches, verifier has marked those instructions that really
> >>>> need zero extension on dst_reg.
> >>>> 
> >>>> It is then for all back-ends to decide how to use such information to
> >>>> eliminate unnecessary zero extension codegen during JIT compilation.
> >>>> 
> >>>> One approach is:
> >>>> 1. Verifier insert explicit zero extension for those instructions that
> >>>>    need zero extension.
> >>>> 2. All JIT back-ends do NOT generate zero extension for sub-register
> >>>>    write any more.
> >>>> 
> >>>> The good thing for this approach is no major change on JIT back-end
> >>>> interface, all back-ends could get this optimization.
> >>>> 
> >>>> However, only those back-ends that do not have hardware zero extension
> >>>> want this optimization. For back-ends like x86_64 and AArch64, there is
> >>>> hardware support, so this optimization should be disabled.
> >>>> 
> >>>> This patch introduces new sysctl "bpf_jit_32bit_opt" which is the control
> >>>> variable for whether the optimization should be enabled.
> >>>> 
> >>>> It is initialized using target hook bpf_jit_hardware_zext which is default
> >>>> true, meaning the underlying hardware will do zero extension automatically,
> >>>> therefore the optimization will be disabled.
> >>>> 
> >>>> Offload targets do not use this native target hook, instead, they could
> >>>> get the optimization results using bpf_prog_offload_ops.finalize.
> >>>> 
> >>>> The user could always enable or disable the optimization by using:
> >>>> 
> >>>>  sysctl net/core/bpf_jit_32bit_opt=[0 | 1]
> >>> 
> >>> I don't think there should be a sysctl for this.
> >> 
> >> The sysctl introduced mostly because I think it could be useful for testing.
> >> For example on x86_64, with this sysctl, we can enable the optimisation and
> >> can run selftest.
> >> 
> >> Does this make sense?
> >> 
> >> Or when one insn is marked, we print verbose info, so the tester could catch
> >> it from log?
> > 
> > sysctl in this patch only triggers insertion of shifts.
> > what kind of testing does it enable on x64?
> > The writing insn is already 32-bit and hw does zero extend.
> > These two shifts is always a nop?
> > a sysctl to test that the verifier inserted shifts in the right place?
> 
> Yes, that’s the test methodology I am using. Match the instruction sequence after
> shifts insertion.

I see. I don't think such extra shifts right after hw zero extend will catch much.
imo it would be better to populate upper 32-bit with random values on x64
where verifier analysis showed that it's ok to do so.
Such extra insns can be inserted by the verifier. Since such debugging
has run-time cost we'd need a flag to turn it on.
May be a new flag during prog load instead of sysctl?
It can be a global switch inside libbpf, so test_verifier and test_progs
wouldn't need to pass it everywhere explictly. It would double the test time,
but it's worth doing always on all archs. Especially on x64.

other thoughts...
I guess it's ok to stick with shifts for now.
Introducing new insn would be nice, but we can do it later.
Changing all jits for this new insn as pre-patch to this set is too much.

peephole to convert shifts is probably useful regardless.
bpf backend emits a bunch of useless shifts when alu32 is not used.
Would be great if x86 jit can optimize it for such lazy users
(and users who don't upgrade llvm fast enough or don't know about alu32)

