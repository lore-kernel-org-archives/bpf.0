Return-Path: <SRS0=Xcm6=65=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4C0C433DF
	for <bpf@archiver.kernel.org>; Fri, 15 May 2020 23:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1923E205CB
	for <bpf@archiver.kernel.org>; Fri, 15 May 2020 23:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgEOXTp (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 15 May 2020 19:19:45 -0400
Received: from www62.your-server.de ([213.133.104.62]:44544 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgEOXTp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 May 2020 19:19:45 -0400
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jZjc7-0005It-8Y; Sat, 16 May 2020 01:19:35 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jZjc7-000VZt-0E; Sat, 16 May 2020 01:19:35 +0200
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: fix test_align
To:     Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org,
        John Fastabend <john.fastabend@gmail.com>
References: <20200515194904.229296-1-sdf@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <54f7d9ce-21b8-2c7e-1857-79dd77f97b8b@iogearbox.net>
Date:   Sat, 16 May 2020 01:19:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200515194904.229296-1-sdf@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25813/Fri May 15 14:16:29 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/15/20 9:49 PM, Stanislav Fomichev wrote:
> Commit 294f2fc6da27 ("bpf: Verifer, adjust_scalar_min_max_vals to always
> call update_reg_bounds()") changed the way verifier logs some of its state,
> adjust the test_align accordingly. Where possible, I tried to
> not copy-paste the entire log line and resorted to dropping
> the last closing brace instead.
> 
> Fixes: 294f2fc6da27 ("bpf: Verifer, adjust_scalar_min_max_vals to always call update_reg_bounds()")
> Cc: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Both applied, thanks!
