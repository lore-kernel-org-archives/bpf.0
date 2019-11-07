Return-Path: <SRS0=ta3s=Y7=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834B4C43331
	for <bpf@archiver.kernel.org>; Thu,  7 Nov 2019 16:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60984214D8
	for <bpf@archiver.kernel.org>; Thu,  7 Nov 2019 16:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729906AbfKGQGd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 7 Nov 2019 11:06:33 -0500
Received: from www62.your-server.de ([213.133.104.62]:44374 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388761AbfKGQGd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Nov 2019 11:06:33 -0500
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iSkIo-00063Y-8z; Thu, 07 Nov 2019 17:06:30 +0100
Received: from [178.197.249.41] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1iSkIn-000N0H-VX; Thu, 07 Nov 2019 17:06:30 +0100
Subject: Re: [PATCH bpf-next] s390/bpf: remove unused SEEN_RET0, SEEN_REG_AX
 and ret0_ip
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20191107114033.90505-1-iii@linux.ibm.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <618d1804-c801-34c0-e8e9-0192d431958c@iogearbox.net>
Date:   Thu, 7 Nov 2019 17:06:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191107114033.90505-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25626/Thu Nov  7 10:50:48 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/7/19 12:40 PM, Ilya Leoshkevich wrote:
> We don't need them since commit e1cf4befa297 ("bpf, s390x: remove
> ld_abs/ld_ind") and commit a3212b8f15d8 ("bpf, s390x: remove obsolete
> exception handling from div/mod").
> 
> Also, use BIT(n) instead of 1 << n, because checkpatch says so.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Makes sense, thanks for the cleanup, applied!
