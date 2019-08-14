Return-Path: <SRS0=gekI=WK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A72C0650F
	for <bpf@archiver.kernel.org>; Wed, 14 Aug 2019 08:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A9E02084D
	for <bpf@archiver.kernel.org>; Wed, 14 Aug 2019 08:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfHNIVl (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 14 Aug 2019 04:21:41 -0400
Received: from www62.your-server.de ([213.133.104.62]:41026 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfHNIVk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Aug 2019 04:21:40 -0400
Received: from sslproxy01.your-server.de ([88.198.220.130])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hxoXC-0002tp-6H; Wed, 14 Aug 2019 10:21:30 +0200
Received: from [2a02:120b:2c12:c120:71a0:62dd:894c:fd0e] (helo=pc-66.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hxoXB-0000q9-U8; Wed, 14 Aug 2019 10:21:29 +0200
Subject: Re: pull-request: bpf-next 2019-08-14
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     davem@davemloft.net, ast@kernel.org, andrii.nakryiko@gmail.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20190813231639.29891-1-daniel@iogearbox.net>
 <20190813165902.41da0730@cakuba.netronome.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <6ddb1fea-4120-3767-05c1-5aebee057255@iogearbox.net>
Date:   Wed, 14 Aug 2019 10:21:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190813165902.41da0730@cakuba.netronome.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25540/Tue Aug 13 10:16:47 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/14/19 1:59 AM, Jakub Kicinski wrote:
> On Wed, 14 Aug 2019 01:16:39 +0200, Daniel Borkmann wrote:
>> Hi David, hi Jakub,
>>
>> The following pull-request contains BPF updates for your *net-next* tree.
> 
> Pulled, let me know if I did it wrong 🤞

LGTM, thanks a lot! :-)
