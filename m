Return-Path: <SRS0=5OmT=ZH=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A10C432C3
	for <bpf@archiver.kernel.org>; Fri, 15 Nov 2019 22:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A1820733
	for <bpf@archiver.kernel.org>; Fri, 15 Nov 2019 22:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfKOW1n (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 15 Nov 2019 17:27:43 -0500
Received: from www62.your-server.de ([213.133.104.62]:50526 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbfKOW1n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Nov 2019 17:27:43 -0500
Received: from sslproxy01.your-server.de ([88.198.220.130])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iVk46-0007MD-4k; Fri, 15 Nov 2019 23:27:42 +0100
Received: from [178.197.248.45] (helo=pc-9.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1iVk45-0006hA-RZ; Fri, 15 Nov 2019 23:27:41 +0100
Subject: Re: [PATCH bpf-next 1/2] samples/bpf: Remove duplicate option from
 xdpsock
To:     Andre Guedes <andre.guedes@intel.com>, bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org
References: <20191114162847.221770-1-andre.guedes@intel.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <3e99c28f-651d-0b67-5aa1-292c891b9392@iogearbox.net>
Date:   Fri, 15 Nov 2019 23:27:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191114162847.221770-1-andre.guedes@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25634/Fri Nov 15 10:44:37 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/14/19 5:28 PM, Andre Guedes wrote:
> The '-f' option is shown twice in the usage(). This patch removes the
> outdated version.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>

Both applied, thanks!
