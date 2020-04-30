Return-Path: <SRS0=Oi1G=6O=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E64C83000
	for <bpf@archiver.kernel.org>; Thu, 30 Apr 2020 14:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9377206D9
	for <bpf@archiver.kernel.org>; Thu, 30 Apr 2020 14:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgD3OcK (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:32:10 -0400
Received: from www62.your-server.de ([213.133.104.62]:46854 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgD3OcK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Apr 2020 10:32:10 -0400
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jUAES-0000Pt-Kj; Thu, 30 Apr 2020 16:32:08 +0200
Received: from [178.195.186.98] (helo=pc-9.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jUAES-000SQq-D8; Thu, 30 Apr 2020 16:32:08 +0200
Subject: Re: [PATCH bpf-next] selftests/bpf: Test allowed maps for
 bpf_sk_select_reuseport
To:     Jakub Sitnicki <jakub@cloudflare.com>, bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        John Fastabend <john.fastabend@gmail.com>
References: <20200430104738.494180-1-jakub@cloudflare.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <52761b96-184d-65a9-91bb-11064cef4f9d@iogearbox.net>
Date:   Thu, 30 Apr 2020 16:32:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200430104738.494180-1-jakub@cloudflare.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25798/Thu Apr 30 14:03:33 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/30/20 12:47 PM, Jakub Sitnicki wrote:
> Check that verifier allows passing a map of type:
> 
>   BPF_MAP_TYPE_REUSEPORT_SOCKARRARY, or
>   BPF_MAP_TYPE_SOCKMAP, or
>   BPF_MAP_TYPE_SOCKHASH
> 
> ... to bpf_sk_select_reuseport helper.
> 
> Suggested-by: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>

Looks good, applied!
