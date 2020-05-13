Return-Path: <SRS0=dL5Z=63=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03053C433F1
	for <bpf@archiver.kernel.org>; Wed, 13 May 2020 15:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2207522211
	for <bpf@archiver.kernel.org>; Wed, 13 May 2020 14:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389006AbgEMO5T (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 13 May 2020 10:57:19 -0400
Received: from www62.your-server.de ([213.133.104.62]:49148 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389058AbgEMO5T (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 May 2020 10:57:19 -0400
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jYson-0002dc-Ir; Wed, 13 May 2020 16:57:09 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jYson-0002vB-7v; Wed, 13 May 2020 16:57:09 +0200
Subject: Re: [PATCH bpf-next v4] libbpf: fix probe code to return EPERM if
 encountered
To:     Eelco Chaudron <echaudro@redhat.com>, bpf@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, ast@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com, andriin@fb.com,
        toke@redhat.com
References: <158927424896.2342.10402475603585742943.stgit@ebuild>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <1c706733-47cb-0216-e8a6-214979af7494@iogearbox.net>
Date:   Wed, 13 May 2020 16:57:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <158927424896.2342.10402475603585742943.stgit@ebuild>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25811/Wed May 13 14:11:53 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/12/20 11:04 AM, Eelco Chaudron wrote:
> When the probe code was failing for any reason ENOTSUP was returned, even
> if this was due to no having enough lock space. This patch fixes this by
> returning EPERM to the user application, so it can respond and increase
> the RLIMIT_MEMLOCK size.
> 
> Signed-off-by: Eelco Chaudron <echaudro@redhat.com>

Applied, thanks!
