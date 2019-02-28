Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB9EC43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 08:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23EC72171F
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 08:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="12KYqegj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731191AbfB1ICu (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:02:50 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44517 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731184AbfB1ICu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Feb 2019 03:02:50 -0500
Received: by mail-wr1-f67.google.com with SMTP id w2so20787511wrt.11
        for <bpf@vger.kernel.org>; Thu, 28 Feb 2019 00:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HBIwBtntfn2D+oQheWU3vvuRjp4pz9YAeR/LLYZaYQ8=;
        b=12KYqegjapXpLnR0odp+Ri5KP4XrriZ5aKo1HFEQuYut9ccjI/UCtz6R7N3GUnIJwZ
         jegZw8fq8OPOsTRQPCPOPpUiDAHxwIOr9zk0qujoQMkcuPyyb7f+GKRKuRZhz0oLIB37
         HUq2gdrgsp6Zs2Smf4qrJYQwGMu4/Qa+huTDmBtphbeSKVK+jH1j5s68oFS3S9AI6bSV
         mJ1DUCyBHO0/Gy3rvFl3xSJt7pJy3DbeH/HmMVYsiYF1joWF15pZib5PtHj4nUfYz2Me
         BSbuEHcwpfBj2QmMXdoQJKZsyyK2GpV+svht56Rj1GFaBqtWonDv4iDCzpgXvFJt4tDO
         dxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HBIwBtntfn2D+oQheWU3vvuRjp4pz9YAeR/LLYZaYQ8=;
        b=q4fQYv/q/zVlzOZv/N7t7nFG084o9EAou9qBGJ3cjDjtDGBcB1c+cEp+tu47Jj6U9a
         AKXod+mTS8NjOte7HTjkWD2nArjxXM1J8SOaiXPmOGErPE2IwdTAe/mKxOoKwMq60x/D
         LfI6P3tZTRWyV32tixr3l70lhaJVXdi8cQfNYMnU9+g9T2SgcxNb843vOWb7SmDILc2n
         j98h0dyVua89HNW9bo06NivpJiln0aBs3jvxsbuBhLmMq7/vKs9sWsJM4PHQVdidKFQn
         xaVwdxLTuA9lnKxRefXqu3hHL6Nd4Lhb2/w+ktp90qrl8Aj+YWAQOaKGSaZqARWQAkMn
         Lq3A==
X-Gm-Message-State: APjAAAVT2qAyEB8sWXU7Ht59H9wyZG3hhP1uFpin80kNywepOF6BtfKg
        6ifJXKwqQSYc28D4gUh8xBbmATgZd3NXfuaeX/zYKiknw2A=
X-Google-Smtp-Source: APXvYqy1LaMyKawwuNR3INaEGYL9ORNB79/t8vmp+IkUa1L5viv25WAkF/w1wDPGrvNJIuSlvC4HLOP1Mz5/fWgmMi4=
X-Received: by 2002:adf:e5c5:: with SMTP id a5mr5256760wrn.13.1551340969184;
 Thu, 28 Feb 2019 00:02:49 -0800 (PST)
MIME-Version: 1.0
References: <1551300641-1727-1-git-send-email-jiong.wang@netronome.com>
 <1551300641-1727-4-git-send-email-jiong.wang@netronome.com> <8c5b9cd1-514e-493e-3ada-756e0e0a686e@fb.com>
In-Reply-To: <8c5b9cd1-514e-493e-3ada-756e0e0a686e@fb.com>
From:   Jiong Wang <jiong.wang@netronome.com>
Date:   Thu, 28 Feb 2019 08:02:36 +0000
Message-ID: <CAMsOgNAckt9J3S_k4BeaB2YVavC272_Y3hZecyt9Cmu4pmBhng@mail.gmail.com>
Subject: Re: [PATCH LLVM 3/3] bpf: disassembler support for XADD under
 sub-register mode
To:     Yonghong Song <yhs@fb.com>
Cc:     "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "oss-drivers@netronome.com" <oss-drivers@netronome.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 28, 2019 at 6:54 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 2/27/19 12:50 PM, Jiong Wang wrote:
> > Like the other load/store instructions, "w" register is prefered when
> > disassembling BPF_STX | BPF_W | BPF_XADD under sub-register mode.
> >
> > Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
> > ---
> >   lib/Target/BPF/Disassembler/BPFDisassembler.cpp | 3 ++-
> >   test/MC/BPF/load-store-32.s                     | 3 +++
> >   2 files changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/Target/BPF/Disassembler/BPFDisassembler.cpp b/lib/Target/BPF/Disassembler/BPFDisassembler.cpp
> > index ed09e44..c5be7cb 100644
> > --- a/lib/Target/BPF/Disassembler/BPFDisassembler.cpp
> > +++ b/lib/Target/BPF/Disassembler/BPFDisassembler.cpp
> > @@ -171,9 +171,10 @@ DecodeStatus BPFDisassembler::getInstruction(MCInst &Instr, uint64_t &Size,
> >     if (Result == MCDisassembler::Fail) return MCDisassembler::Fail;
> >
> >     uint8_t InstClass = getInstClass(Insn);
> > +  uint8_t InstMode = getInstMode(Insn);
> >     if ((InstClass == BPF_LDX || InstClass == BPF_STX) &&
> >         getInstSize(Insn) != BPF_DW &&
> > -      getInstMode(Insn) == BPF_MEM &&
> > +      (InstMode == BPF_MEM || InstMode == BPF_XADD) &&
> >         STI.getFeatureBits()[BPF::ALU32])
> >       Result = decodeInstruction(DecoderTableBPFALU3264, Instr, Insn, Address,
>
> This change triggered the unit test MC/BPF/insn-unit.s failure.
>
> Exit Code: 1
>
> Command Output (stderr):
> --
> /data/users/yhs/work/llvm/test/MC/BPF/insn-unit.s:60:11: error: CHECK:
> expected string not found in input
> // CHECK: c3 92 10 00 00 00 00 00 lock *(u32 *)(r2 + 16) += r9
>            ^
> <stdin>:25:2: note: scanning from here
>   22: c3 92 10 00 00 00 00 00 lock *(u32 *)(r2 + 16) += w9
>   ^
> <stdin>:25:6: note: possible intended match here
>   22: c3 92 10 00 00 00 00 00 lock *(u32 *)(r2 + 16) += w9
>       ^
> probably objdump -mattr=+alu32 decoding issue.

Ah, apology. The disassembler change was added at last minute and I was
too confident with the trival change that forgetting to run full regression.

Yes, the issue is the BPF_W insn will show in "w" register format.
So, need the following minior change on the testcase:

diff --git a/test/MC/BPF/insn-unit.s b/test/MC/BPF/insn-unit.s
index c61c002..ff56cfa 100644
--- a/test/MC/BPF/insn-unit.s
+++ b/test/MC/BPF/insn-unit.s
@@ -57,7 +57,8 @@

   lock *(u32 *)(r2 + 16) += r9  // BPF_STX | BPF_W | BPF_XADD
   lock *(u64 *)(r3 - 30) += r10 // BPF_STX | BPF_DW | BPF_XADD
-// CHECK: c3 92 10 00 00 00 00 00      lock *(u32 *)(r2 + 16) += r9
+// CHECK-64: c3 92 10 00 00 00 00 00   lock *(u32 *)(r2 + 16) += r9
+// CHECK-32: c3 92 10 00 00 00 00 00   lock *(u32 *)(r2 + 16) += w9
 // CHECK: db a3 e2 ff 00 00 00 00      lock *(u64 *)(r3 - 30) += r10

 // ======== BPF_JMP Class ========

Regards,
Jiong
