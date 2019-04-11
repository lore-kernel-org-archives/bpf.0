Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58D7C10F14
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 19:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BBBB2070D
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 19:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfDKTxC (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Apr 2019 15:53:02 -0400
Received: from www62.your-server.de ([213.133.104.62]:45826 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbfDKTxC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Apr 2019 15:53:02 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hEfkm-0005CA-5w; Thu, 11 Apr 2019 21:52:56 +0200
Received: from [178.197.249.32] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hEfkl-000F0L-UQ; Thu, 11 Apr 2019 21:52:56 +0200
Subject: Re: [PATCH bpf-next] bpf: fix missing bpf_check_uarg_tail_zero in
 BPF_PROG_TEST_RUN
To:     Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org,
        kbuild test robot <lkp@intel.com>
References: <20190411161202.167610-1-sdf@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <0ae7a9ae-1d07-afaf-c31f-1c46f48df9f2@iogearbox.net>
Date:   Thu, 11 Apr 2019 21:52:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190411161202.167610-1-sdf@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25416/Thu Apr 11 09:55:16 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/11/2019 06:12 PM, Stanislav Fomichev wrote:
> Commit b0b9395d865e ("bpf: support input __sk_buff context in
> BPF_PROG_TEST_RUN") started using bpf_check_uarg_tail_zero in
> BPF_PROG_TEST_RUN. However, bpf_check_uarg_tail_zero is not defined
> for !CONFIG_BPF_SYSCALL:
> 
> net/bpf/test_run.c: In function ‘bpf_ctx_init’:
> net/bpf/test_run.c:142:9: error: implicit declaration of function ‘bpf_check_uarg_tail_zero’ [-Werror=implicit-function-declaration]
>    err = bpf_check_uarg_tail_zero(data_in, max_size, size);
>          ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> Let's not build net/bpf/test_run.c when CONFIG_BPF_SYSCALL is not set.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Fixes: b0b9395d865e ("bpf: support input __sk_buff context in BPF_PROG_TEST_RUN")
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Makes sense, applied, thanks!
