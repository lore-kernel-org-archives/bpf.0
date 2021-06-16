Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB06C48BE5
	for <bpf@archiver.kernel.org>; Wed, 16 Jun 2021 04:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F9CD61369
	for <bpf@archiver.kernel.org>; Wed, 16 Jun 2021 04:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbhFPEI0 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 16 Jun 2021 00:08:26 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:15080 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229483AbhFPEIZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 16 Jun 2021 00:08:25 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=chengshuyi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UcZz33p_1623816378;
Received: from B-39YZML7H-2200.local(mailfrom:chengshuyi@linux.alibaba.com fp:SMTPD_---0UcZz33p_1623816378)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Jun 2021 12:06:19 +0800
To:     bpf@vger.kernel.org
Cc:     kafai@fb.com, andrii@kernel.org, songliubraving@fb.com, yhs@fb.com
From:   Shuyi Cheng <chengshuyi@linux.alibaba.com>
Subject: How to avoid compilation errors like "error: no member named xxx in
 strut xxx"?
Message-ID: <756efe9a-a237-e5d1-17fc-47936e76dacc@linux.alibaba.com>
Date:   Wed, 16 Jun 2021 12:06:18 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I am trying to write a bpf program that supports multiple linux kernel 
versions. However, there are some differences in the definition of 
struct net in these multiple kernel versions.

Therefore, when we include a certain kernel version of vmlinux.h, the 
compilation error "error: no member named'proc_inum' in strut net" will 
appear.

However, when we include another kernel version of vmlinux.h, the 
compilation will appear "error: no member named'ns.inum' in strut net".

Anakryiko mentioned in the issue of libbpf/libbpf-bootstrap: vmlinux.h 
is just a convenient way to have most of kernel types defined for you, 
so that you don't have to re-define them manually. Link here: https: 
//github.com/libbpf/libbpf-bootstrap/issues/31#issuecomment-861035643

But struct net is a very huge structure, and it may be very difficult to 
add it manually. So, how can we avoid compilation errors like "error: no 
member named'xxx' in xxx"
