Return-Path: <SRS0=P9GS=RC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969D6C4360F
	for <bpf@archiver.kernel.org>; Wed, 27 Feb 2019 20:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A412218A2
	for <bpf@archiver.kernel.org>; Wed, 27 Feb 2019 20:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="i/Igys1S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbfB0Uu7 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Feb 2019 15:50:59 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:38579 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbfB0Uu6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Feb 2019 15:50:58 -0500
Received: by mail-wm1-f41.google.com with SMTP id v26so6891366wmh.3
        for <bpf@vger.kernel.org>; Wed, 27 Feb 2019 12:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=aIesCaRRnpSyV3SfCYURgT3msr+7NQuTZeIi+i6FAIU=;
        b=i/Igys1S+7M105OdUhCx+wtKApz1Lz8a6xN5JW6QfQaBFGGa0C6WT4lANS2rXTsXcP
         +T1C/eqrFzpNhxmu68+LljNwstWWGazroTvLNuiWMnPj+Gv7xC8oC+P7UhKyzLOPrA19
         dKHuNx8qQLrnhbNd38X2jkcVJpRxLYDtNl+IRicK3rbKH0Qny6JZzc7RYzQjswomAFM5
         0T7jXFQy3kpjK9q+ledZdEmXK6fKfGsmgFQt5A8lZDaTdN2ZYCcxaoDbuujNm8MSuQ5j
         iYtWrweiVHjJ0LodccR3qx+fojXpM30dZjbjZcQJom9sExwIGks35w/bzbPJb8VNfwMT
         PMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aIesCaRRnpSyV3SfCYURgT3msr+7NQuTZeIi+i6FAIU=;
        b=jdoWnmXX5croS7ES8mNuH64eksjJ2mox2eAylsdV9uHBqm6U8bnWOIK6fnM/RaX+/0
         yBMC7XVLBL16M+zUHyAqRLTVVNFHjEtiawecLj8zpBHUp7CziS5/r9NWSJYyfK4PEjIZ
         dYKu8lzFf1QqyP1jT7RJiDOcGneybOuJrMYmxEN5zkC79n0cWg5YOoG5CZYLeJ+Qo3Bs
         SrXg+OoVTX0y9llEDOMFZ4kKc1rkqofrFv7u/101Pl4uxotNeXphP+uRxmQgto6wqOz5
         t/rIGoRT7JahrZcW0+QXTljLIKxMYzgIWRKGKdrsCLb/CsIM5Yc/dzi9yTNWFRmUY4FB
         Rc2g==
X-Gm-Message-State: APjAAAXdr2wfmWgxCezMb5/hR9n0CJNMICY0vOa6+uJjGt7/RpaQ+rPR
        kA5xQz97CyZ7oyG3m2cmQ/b56c918TQ=
X-Google-Smtp-Source: APXvYqzNnY4rio+jUh3h3K2ZESzd1dI4JU3RAZuM7NdMu6Ls/2o3IG/12HvFhxWY+Iu119bXMSBjzQ==
X-Received: by 2002:a1c:c182:: with SMTP id r124mr714752wmf.124.1551300654845;
        Wed, 27 Feb 2019 12:50:54 -0800 (PST)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id e193sm5362912wmg.18.2019.02.27.12.50.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Feb 2019 12:50:54 -0800 (PST)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, yhs@fb.com
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH LLVM 0/3] bpf: improvements on XADD semantics check and code-gen
Date:   Wed, 27 Feb 2019 20:50:38 +0000
Message-Id: <1551300641-1727-1-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

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
designed for the situation where one register could be splitted into more
than one sub-registers for which case each sub-register could have their
own liveness and kill one of them doesn't kill others. So, tracking
liveness for each make sense.

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

 lib/Target/BPF/BPFInstrInfo.td                  |  28 ++++++-
 lib/Target/BPF/BPFMIChecking.cpp                | 107 +++++++++++++++++++++++-
 lib/Target/BPF/Disassembler/BPFDisassembler.cpp |   3 +-
 test/CodeGen/BPF/xadd.ll                        |   2 +
 test/CodeGen/BPF/xadd_legal.ll                  |  26 ++++++
 test/MC/BPF/load-store-32.s                     |   3 +
 6 files changed, 162 insertions(+), 7 deletions(-)
 create mode 100644 test/CodeGen/BPF/xadd_legal.ll

-- 
2.7.4

