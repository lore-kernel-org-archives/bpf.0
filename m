Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C557AC10F13
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 22:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973412146F
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 22:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfDKW5W (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:57:22 -0400
Received: from www62.your-server.de ([213.133.104.62]:43332 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfDKW5W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Apr 2019 18:57:22 -0400
Received: from [88.198.220.130] (helo=sslproxy01.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hEidB-00023M-M0; Fri, 12 Apr 2019 00:57:17 +0200
Received: from [178.197.249.32] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hEidB-0003en-CZ; Fri, 12 Apr 2019 00:57:17 +0200
Subject: Re: [PATCH bpf-next] bpf: explicitly prohibit ctx_{in,out} in non-skb
 BPF_PROG_TEST_RUN
To:     Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org
References: <20190411224707.104655-1-sdf@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <efdce339-f353-cb49-736f-af0d21d8483c@iogearbox.net>
Date:   Fri, 12 Apr 2019 00:57:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190411224707.104655-1-sdf@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25416/Thu Apr 11 09:55:16 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/12/2019 12:47 AM, Stanislav Fomichev wrote:
> This should allow us later to extend BPF_PROG_TEST_RUN for non-skb case
> and be sure that nobody is erroneously setting ctx_{in,out}.
> 
> Fixes: b0b9395d865e ("bpf: support input __sk_buff context in BPF_PROG_TEST_RUN")
> Reported-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Looks good, applied, thanks!
