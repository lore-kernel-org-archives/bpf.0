Return-Path: <SRS0=LFNc=BX=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA0CC433DF
	for <bpf@archiver.kernel.org>; Thu, 13 Aug 2020 21:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68FE420768
	for <bpf@archiver.kernel.org>; Thu, 13 Aug 2020 21:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgHMVgW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 13 Aug 2020 17:36:22 -0400
Received: from www62.your-server.de ([213.133.104.62]:47086 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgHMVgV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Aug 2020 17:36:21 -0400
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1k6KtU-0007dv-3b; Thu, 13 Aug 2020 23:36:16 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1k6KtT-0002h9-UF; Thu, 13 Aug 2020 23:36:15 +0200
Subject: Re: [bpf PATCH v3 0/5] Fix sock_ops field read splat
To:     John Fastabend <john.fastabend@gmail.com>, songliubraving@fb.com,
        kafai@fb.com, ast@kernel.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org
References: <159718333343.4728.9389284976477402193.stgit@john-Precision-5820-Tower>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c55c79df-5c80-1cb4-3f8f-a1ab8d5135a5@iogearbox.net>
Date:   Thu, 13 Aug 2020 23:36:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <159718333343.4728.9389284976477402193.stgit@john-Precision-5820-Tower>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/25901/Thu Aug 13 09:01:24 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/12/20 12:04 AM, John Fastabend wrote:
[...]
> v2->v3: Updated commit msg in patch1 to include ommited line of asm
>          output, per Daniels comment.
> v1->v2: Added fix sk access case

Applied, thanks!
