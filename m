Return-Path: <SRS0=yGwg=UZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B1CC48BD3
	for <bpf@archiver.kernel.org>; Wed, 26 Jun 2019 14:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058EB2133F
	for <bpf@archiver.kernel.org>; Wed, 26 Jun 2019 14:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfFZOcS (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:32:18 -0400
Received: from www62.your-server.de ([213.133.104.62]:44660 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfFZOcS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Jun 2019 10:32:18 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hg8y8-0000Zi-LF; Wed, 26 Jun 2019 16:32:16 +0200
Received: from [2a02:1205:5054:6d70:b45c:ec96:516a:e956] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hg8y8-000A5w-El; Wed, 26 Jun 2019 16:32:16 +0200
Subject: Re: [PATCH v2 bpf-next] libbpf: fix max() type mismatch for 32bit
To:     Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, ast@kernel.org,
        netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190626103837.6455-1-ivan.khoronzhuk@linaro.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <44ad3d98-f304-628f-9f8d-dfc1faaabfaa@iogearbox.net>
Date:   Wed, 26 Jun 2019 16:32:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190626103837.6455-1-ivan.khoronzhuk@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25492/Wed Jun 26 10:00:16 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 06/26/2019 12:38 PM, Ivan Khoronzhuk wrote:
> It fixes build error for 32bit caused by type mismatch
> size_t/unsigned long.
> 
> Fixes: bf82927125dd ("libbpf: refactor map initialization")
> Acked-by: Song Liu <songliubraving@fb.com>
> Acked-by: Andrii Nakryiko <andriin@fb.com>
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>

Applied, thanks!
