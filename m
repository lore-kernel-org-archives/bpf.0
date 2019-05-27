Return-Path: <SRS0=XWQL=T3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E011C04AB3
	for <bpf@archiver.kernel.org>; Mon, 27 May 2019 21:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 287CF2075E
	for <bpf@archiver.kernel.org>; Mon, 27 May 2019 21:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfE0Vzs (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 27 May 2019 17:55:48 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:52599 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfE0Vzr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 May 2019 17:55:47 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126] helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1hVNar-0002th-8K; Mon, 27 May 2019 22:55:45 +0100
Message-ID: <1558994144.2631.14.camel@codethink.co.uk>
Subject: [stable] bpf: add bpf_jit_limit knob to restrict unpriv allocations
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Cc:     stable <stable@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Date:   Mon, 27 May 2019 22:55:44 +0100
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Please consider backporting this commit to 4.19-stable:

commit ede95a63b5e84ddeea6b0c473b36ab8bfd8c6ce3
Author: Daniel Borkmann <daniel@iogearbox.net>
Date:   Tue Oct 23 01:11:04 2018 +0200

    bpf: add bpf_jit_limit knob to restrict unpriv allocations

No other stable branches are affected by the issue.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
