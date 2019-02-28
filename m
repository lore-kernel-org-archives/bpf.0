Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4784EC10F00
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 09:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 125F2218AE
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 09:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="DLD4OUWJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731899AbfB1J70 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 04:59:26 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36123 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfB1J7Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Feb 2019 04:59:24 -0500
Received: by mail-wr1-f65.google.com with SMTP id o17so21235555wrw.3
        for <bpf@vger.kernel.org>; Thu, 28 Feb 2019 01:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=i3hQE2xRiJz/wUcV3t0Nq5B1bqqSU4WF51x4+Hy/TTI=;
        b=DLD4OUWJW/gMjx/01lPkYYuI+zLEQyi9+P/X1elKNDaYB4RUl/EtOywmIlG65NRkBZ
         ZMOPY3nHukgWO66VPlvvH4V2VAOg2iG1+WPMS22HrYdOQjk6F5xT5RExfY3Gocgy9E6o
         piZHRzBZeuxOUnn/f3QNitYToYWw7GobK98yYAv/YDM5HkwRsx/7CqL6m9Gu4pRnldul
         hSVeMaLJ8NKaO63Q1uQ57VIZKnkcABtECoTtjAgkY28e5wNJQTXoWMONOq+NRD+0MwZR
         CBao4ar62r0Dpbf6GFiR/tiYSvaIjY+ja+FPUyxXUVLhW7pcmx6VGXwzFzyg5RO10Eya
         ZW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=i3hQE2xRiJz/wUcV3t0Nq5B1bqqSU4WF51x4+Hy/TTI=;
        b=oVthSnR4FKTuwPZBR2E1qpvCuOZf++lqtTJ1YywJ/3JzojN33Kv0Ll60rbFzR9siiF
         hDCD2KJb/eq9NdVpPx4SZ22IMOQdms7lbZ1s1No8Jy2xPcpxu/da/sIkHTaZ7C50/PqN
         q7DzgcfolU/8oqgzLAtB15wb3o/dEh2Sb3pkAqYYWRHOru1gy7ItcZtHvBOS9uyA+V/a
         HJ9rwkrIhRkkGOL20LSoaN2PEm4QHBRoizeHP1L0enlQBL1SnXY9usMqkBu2ebMOIGOm
         Pl/rsIOcJ3tgbX0RUiJ5bDn/smYFh49Wqm6VuVxiJROdSGswuAA8ro2FyXS6paZr1h0C
         /dPw==
X-Gm-Message-State: APjAAAXu8a7j89swHUMTAfVA0+Q0F7Ubf2cePRtC2ogwsQLcXR7D+kgs
        DalNtmIrdmhceVzK+JlIBgDQfg==
X-Google-Smtp-Source: APXvYqzYNq1aZaTh9EVImjKlpap62TFc/NH3SdAyZBa+rT8EBiYZ4O9Cnyq5DpjDW0Rp7TUsT8dlCg==
X-Received: by 2002:adf:f34a:: with SMTP id e10mr5919543wrp.138.1551347962895;
        Thu, 28 Feb 2019 01:59:22 -0800 (PST)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id y5sm4965261wmg.31.2019.02.28.01.59.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Feb 2019 01:59:22 -0800 (PST)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, yhs@fb.com
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH LLVM v2 0/3] bpf: improvements on XADD semantics check and code-gen
Date:   Thu, 28 Feb 2019 09:59:14 +0000
Message-Id: <1551347957-4068-1-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

v1->v2:
 - Simplified code logic inside hasLiveDefs. (Yonghong)
 - Updated testcase insn-unit.s (Yonghong)

BPF XADD semantics require all Defs of XADD are dead, meaning any result of
XADD insn is not used.

However, BPF backend hasn't enabled sub-register liveness track, so when
the source and destination operands of XADD are GPR32, there is no
sub-register dead info. If we rely on the generic
MachineInstr::allDefsAreDead, then we will raise false alarm on GPR32 Def.

This was fine as there was no sub-register code-gen support for XADD, but
it will be added by the second patch. Without proper handling of GPR32 Def,
testcase like the one added in the second patch will fail on sub-register
code-gen mode.

To support GPR32 Def, ideally we could just enable sub-registr liveness
track on BPF backend, then allDefsAreDead could work on GPR32 Def. This
requires implementing TargetSubtargetInfo::enableSubRegLiveness on BPF.

However, sub-register liveness tracking module inside LLVM is actually
designed for the situation where one register could be split into more than
one sub-registers for which case each sub-register could have their own
liveness and kill one of them doesn't kill others. So, tracking liveness
for each make sense.

For BPF, each 64-bit register could only have one 32-bit sub-register. This
is exactly the case which LLVM think brings no benefits for doing
sub-register tracking, because the live range of sub-register must always
equal to its parent register, therefore liveness tracking is disabled even
the back-end has implemented enableSubRegLiveness. The detailed information
is at r232695:

  Author: Matthias Braun <matze@braunis.de>
  Date:   Thu Mar 19 00:21:58 2015 +0000
  Do not track subregister liveness when it brings no benefits

Hence, for BPF, we enhance MachineInstr::allDefsAreDead. Given the solo
sub-register always has the same liveness as its parent register, LLVM is
already attaching a implicit 64-bit register Def whenever the there is
a sub-register Def. The liveness of the implicit 64-bit Def is available.
For example, for "lock *(u32 *)(r0 + 4) += w9", the MachineOperand info
could be:

  $w9 = XADDW32 killed $r0, 4, $w9(tied-def 0),
                       implicit killed $r9, implicit-def dead $r9

Even though w9 is not marked as Dead, the parent register r9 is marked as
Dead correctly, and it is safe to use such information or our purpose.

After above improvements, the second patch in this set then adds
sub-register code-gen support for XADD.

Jiong Wang (3):
  bpf: improve dead Defs check for XADD
  bpf: enable sub-register code-gen for XADD
  bpf: disassembler support for XADD under sub-register mode

 lib/Target/BPF/BPFInstrInfo.td                  | 28 ++++++-
 lib/Target/BPF/BPFMIChecking.cpp                | 97 ++++++++++++++++++++++++-
 lib/Target/BPF/Disassembler/BPFDisassembler.cpp |  3 +-
 test/CodeGen/BPF/xadd.ll                        |  2 +
 test/CodeGen/BPF/xadd_legal.ll                  | 26 +++++++
 test/MC/BPF/insn-unit.s                         |  3 +-
 test/MC/BPF/load-store-32.s                     |  3 +
 7 files changed, 154 insertions(+), 8 deletions(-)
 create mode 100644 test/CodeGen/BPF/xadd_legal.ll

-- 
2.7.4

