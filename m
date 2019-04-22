Return-Path: <SRS0=ACyN=SY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DBDC10F11
	for <bpf@archiver.kernel.org>; Mon, 22 Apr 2019 23:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE3420665
	for <bpf@archiver.kernel.org>; Mon, 22 Apr 2019 23:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbfDVX6N (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 22 Apr 2019 19:58:13 -0400
Received: from www62.your-server.de ([213.133.104.62]:44682 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729094AbfDVX6N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Apr 2019 19:58:13 -0400
Received: from [88.198.220.132] (helo=sslproxy03.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hIip8-0005cv-B8; Tue, 23 Apr 2019 01:58:10 +0200
Received: from [178.199.41.31] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hIip8-0006iF-3s; Tue, 23 Apr 2019 01:58:10 +0200
Subject: Re: [PATCH bpf-next 0/2] bpf: parallel verification
To:     Alexei Starovoitov <ast@kernel.org>, davem@davemloft.net
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com
References: <20190419144455.853134-1-ast@kernel.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <a58562b8-4501-d976-29b7-aec15475afe5@iogearbox.net>
Date:   Tue, 23 Apr 2019 01:58:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190419144455.853134-1-ast@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25427/Mon Apr 22 09:56:03 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/19/2019 04:44 PM, Alexei Starovoitov wrote:
> Allow the bpf verifier to run in parallel for root.
> 
> Alexei Starovoitov (2):
>   bpf: remove global variables
>   bpf: drop bpf_verifier_lock
> 
>  include/linux/bpf_verifier.h |  5 +++++
>  kernel/bpf/verifier.c        | 33 ++++++++++++++++++---------------
>  2 files changed, 23 insertions(+), 15 deletions(-)
> 

Too bad we still need to keep it around for unpriv. Anyway, applied, thanks!
