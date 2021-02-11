Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FB3C433DB
	for <bpf@archiver.kernel.org>; Thu, 11 Feb 2021 23:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A77B464E4A
	for <bpf@archiver.kernel.org>; Thu, 11 Feb 2021 23:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhBKXkj (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Feb 2021 18:40:39 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:37210 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhBKXki (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Feb 2021 18:40:38 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 657AC72C8B8
        for <bpf@vger.kernel.org>; Fri, 12 Feb 2021 02:39:56 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 30CB34A4751;
        Fri, 12 Feb 2021 02:39:56 +0300 (MSK)
Date:   Fri, 12 Feb 2021 02:39:56 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     bpf <bpf@vger.kernel.org>
Cc:     Vitaly Chikunov <vt@altlinux.org>
Subject: EFI boot fails when CONFIG_DEBUG_INFO_BTF=y on arm64
Message-ID: <20210211233956.em5k4vtefyfp4tiv@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

We have boot test using OVMF/AAVMF EFI firmware on aarch64 in qemu. When
we try to build kernel with `CONFIG_DEBUG_INFO_BTF=y' (pahole v1.20)
previously successful EFI boot test fails with:

  EFI stub: ERROR: Failed to relocate kernel
  EFI stub: ERROR: Failed to relocate kernel

Without EFI it boots normally. On other our architectures (such as
arm32, i586, powerpc, x86_64) it boots normally too (all without EFI
boot, but x86_64 is also successfully tested with OVMF EFI boot).

This is tested on 5.4.97, but I can try 5.10.15 if needed.

Thanks,

