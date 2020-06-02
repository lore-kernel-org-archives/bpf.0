Return-Path: <SRS0=Pto2=7P=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B61C433DF
	for <bpf@archiver.kernel.org>; Tue,  2 Jun 2020 20:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A69DF206A2
	for <bpf@archiver.kernel.org>; Tue,  2 Jun 2020 20:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbgFBUg3 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 2 Jun 2020 16:36:29 -0400
Received: from www62.your-server.de ([213.133.104.62]:58324 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728854AbgFBUg2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Jun 2020 16:36:28 -0400
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jgDe5-0003F6-NR; Tue, 02 Jun 2020 22:36:25 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jgDe5-0003gA-Ev; Tue, 02 Jun 2020 22:36:25 +0200
Subject: Re: [PATCH bpf] s390/bpf: Maintain 8-byte stack alignment
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
References: <20200602174339.2501066-1-iii@linux.ibm.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <08a13d4d-31f3-be7f-a4af-4975f17169ab@iogearbox.net>
Date:   Tue, 2 Jun 2020 22:36:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200602174339.2501066-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25831/Tue Jun  2 14:41:03 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/2/20 7:43 PM, Ilya Leoshkevich wrote:
> Certain kernel functions (e.g. get_vtimer/set_vtimer) cause kernel
> panic when the stack is not 8-byte aligned. Currently JITed BPF programs
> may trigger this by allocating stack frames with non-rounded sizes and
> then being interrupted. Fix by using rounded fp->aux->stack_depth.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Applied, thanks!
