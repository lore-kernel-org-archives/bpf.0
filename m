Return-Path: <SRS0=GR7L=RI=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274C1C43381
	for <bpf@archiver.kernel.org>; Tue,  5 Mar 2019 14:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 017A220848
	for <bpf@archiver.kernel.org>; Tue,  5 Mar 2019 14:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfCEOaN (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 5 Mar 2019 09:30:13 -0500
Received: from www62.your-server.de ([213.133.104.62]:58340 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfCEOaN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Mar 2019 09:30:13 -0500
Received: from [88.198.220.130] (helo=sslproxy01.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h1B58-0007te-EJ; Tue, 05 Mar 2019 15:30:10 +0100
Received: from [178.197.248.17] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1h1B57-0000Ek-UB; Tue, 05 Mar 2019 15:30:10 +0100
Subject: Re: [PATCH bpf] bpf: fix sanitation rewrite in case of non-pointers
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     ast@fb.com, afabre@cloudflare.com, marek@cloudflare.com,
        bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20190301210529.8218-1-daniel@iogearbox.net>
 <87lg1tz9ys.fsf@cloudflare.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <831131a1-59e3-e7c7-f56e-7b69d4850ffc@iogearbox.net>
Date:   Tue, 5 Mar 2019 15:30:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <87lg1tz9ys.fsf@cloudflare.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25379/Tue Mar  5 11:47:12 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/05/2019 03:12 PM, Jakub Sitnicki wrote:
[...]
> Could you please queue it for -stable which has d3bd7413e0ca ("bpf: fix
> sanitation of alu op with pointer / scalar type from different paths")?

Already done here yesterday morning:

https://lore.kernel.org/stable/40b25ec1c31e234cf7eee75d62083a9a4bcbdbfe.1551702973.git.daniel@iogearbox.net/T/#u

> Thanks,
> Jakub
> 

