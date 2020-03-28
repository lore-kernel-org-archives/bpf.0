Return-Path: <SRS0=dppq=5N=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDBBC43331
	for <bpf@archiver.kernel.org>; Sat, 28 Mar 2020 17:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B4C2206F6
	for <bpf@archiver.kernel.org>; Sat, 28 Mar 2020 17:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgC1RPs (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 28 Mar 2020 13:15:48 -0400
Received: from www62.your-server.de ([213.133.104.62]:59240 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgC1RPs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 28 Mar 2020 13:15:48 -0400
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jIF3a-0001t9-Dm; Sat, 28 Mar 2020 18:15:38 +0100
Received: from [178.195.186.98] (helo=pc-9.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jIF3a-00053Z-0U; Sat, 28 Mar 2020 18:15:38 +0100
Subject: Re: [PATCH v4] bpf: fix build warning - missing prototype
To:     Jean-Philippe Menil <jpmenil@gmail.com>
Cc:     kernel-janitors@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <3164e566-d54e-2254-32c4-d7fee47c37ea@iogearbox.net>
 <20200327204713.28050-1-jpmenil@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <8ec5aa95-4a3c-b2e1-7af2-6a4a2a6c0a5e@iogearbox.net>
Date:   Sat, 28 Mar 2020 18:15:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200327204713.28050-1-jpmenil@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25765/Sat Mar 28 14:16:42 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/27/20 9:47 PM, Jean-Philippe Menil wrote:
> Fix build warnings when building net/bpf/test_run.o with W=1 due
> to missing prototype for bpf_fentry_test{1..6}.
> 
> Instead of declaring prototypes, turn off warnings with
> __diag_{push,ignore,pop} as pointed by Alexei.
> 
> Signed-off-by: Jean-Philippe Menil <jpmenil@gmail.com>

Applied, thanks!
