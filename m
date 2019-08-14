Return-Path: <SRS0=gekI=WK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA56C41514
	for <bpf@archiver.kernel.org>; Wed, 14 Aug 2019 20:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED042084D
	for <bpf@archiver.kernel.org>; Wed, 14 Aug 2019 20:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbfHNUEs (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 14 Aug 2019 16:04:48 -0400
Received: from mail1.oneunified.net ([63.85.42.215]:35834 "EHLO
        mail1.oneunified.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729479AbfHNUEp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Aug 2019 16:04:45 -0400
X-Greylist: delayed 1096 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Aug 2019 16:04:44 EDT
X-One-Unified-MailScanner-Watermark: 1566416786.88654@llTxkVrR0i2rcv/yasm9fQ
X-One-Unified-MailScanner-From: ray@oneunified.net
X-One-Unified-MailScanner: Not scanned: postmaster@oneunified.net
X-One-Unified-MailScanner-ID: x7EJkJbN031716
X-OneUnified-MailScanner-Information: Please contact the ISP for more information
Received: from [10.55.90.10] (h96-45-2-121-eidnet.org.2.45.96.in-addr.arpa [96.45.2.121] (may be forged))
        (authenticated bits=0)
        by mail1.oneunified.net (8.14.4/8.14.4/Debian-4) with ESMTP id x7EJkJbN031716
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 14 Aug 2019 19:46:25 GMT
To:     bpf@vger.kernel.org
From:   Raymond Burkholder <ray@oneunified.net>
Subject: bpftrace / bpf program 'Killed' on kernel v5.2.7 during load
Organization: One Unified Net Limited
Message-ID: <9b763db5-2d31-9e72-7236-4e4c9f91180f@oneunified.net>
Date:   Wed, 14 Aug 2019 13:46:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The simplest test I have is the following for a difference between kernels:

# uname -a
Linux nuc8i7hvk01 4.19.0-5-amd64 #1 SMP Debian 4.19.37-6 (2019-07-18) 
x86_64 GNU/Linux
# cat /sys/kernel/debug/tracing/events/syscalls/sys_enter_execve/id
677

# uname -a
Linux nuc8i7hvk01 5.2.0-2-amd64 #1 SMP Debian 5.2.7-1 (2019-08-07) 
x86_64 GNU/Linux
# cat /sys/kernel/debug/tracing/events/syscalls/sys_enter_execve/id
Killed


This prevents bpftrace and other bpf helper based applications from loading.

apparmour, selinux, and audit are all turned off.

Is there a new 'enable' flag some where?  Or are things done differently 
now? Or is this a Debian 'thing'?

Raymond.
https://blog.raymond.burkholder.net/



