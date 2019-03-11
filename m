Return-Path: <SRS0=tULY=RO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD77C43381
	for <bpf@archiver.kernel.org>; Mon, 11 Mar 2019 09:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B3A2075C
	for <bpf@archiver.kernel.org>; Mon, 11 Mar 2019 09:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfCKJlU (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:41:20 -0400
Received: from www62.your-server.de ([213.133.104.62]:45802 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbfCKJlU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Mar 2019 05:41:20 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h3HQm-0000fQ-Ns; Mon, 11 Mar 2019 10:41:12 +0100
Received: from [178.197.249.29] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1h3HQm-000IeP-E4; Mon, 11 Mar 2019 10:41:12 +0100
Subject: Re: 979d63d50c0c0f7bc537bf821e056cc9fe5abd38 bpf: prevent out of
 bounds speculation on pointer arithmetic
To:     Jason Yan <yanaijie@huawei.com>
References: <5d71646c-f897-2178-9d4a-fababe999f36@huawei.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Cc:     Jann Horn <jannh@google.com>, ast@kernel.org,
        gregkh@linuxfoundation.org, "zhangyi (F)" <yi.zhang@huawei.com>,
        Zhaohongjiang <zhaohongjiang@huawei.com>, netdev@vger.kernel.org,
        stable@vger.kernel.org, bpf@vger.kernel.org
Message-ID: <494a84f2-1a29-1521-e819-6e4fbed17641@iogearbox.net>
Date:   Mon, 11 Mar 2019 10:41:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <5d71646c-f897-2178-9d4a-fababe999f36@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25385/Mon Mar 11 08:43:35 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Jason,

On 03/11/2019 10:18 AM, Jason Yan wrote:
> Hi, Daniel & Greg
> 
> This patch (979d63d50c0c bpf: prevent out of bounds speculation on pointer arithmetic) was assigned a CVE (CVE-2019-7308) with a high score:
> 
> CVSS v3.0 Severity and Metrics:
> Base Score: 9.8 CRITICAL
> 
> And this patch is not in stable-4.4, would you please backport this patch to 4.4?

We don't handle kernels as old as 4.4, so someone else would need to
do the backporting e.g. from your side. The series has been backported
to the last two most-recent stable kernels at that time (we usually
follow netdev practice here), and there have been asks about 4.14 as
well; I've been looking into backporting for the latter last two weeks
on and off, but there are conflicts all over the place in fragile core
areas where I didn't have enough free cycles to complete it yet. For
old kernels, you're probably better off doing something like this in
your tree instead of the huge complexity with a backport:

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index bc34cf9..2cea2de 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -47,7 +47,7 @@ static DEFINE_SPINLOCK(prog_idr_lock);
 static DEFINE_IDR(map_idr);
 static DEFINE_SPINLOCK(map_idr_lock);

-int sysctl_unprivileged_bpf_disabled __read_mostly;
+int sysctl_unprivileged_bpf_disabled __read_mostly = 1;

 static const struct bpf_map_ops * const bpf_map_types[] = {
 #define BPF_PROG_TYPE(_id, _ops)

Thanks,
Daniel
