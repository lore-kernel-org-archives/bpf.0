Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7207C433B4
	for <bpf@archiver.kernel.org>; Thu,  8 Apr 2021 21:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8741D610C9
	for <bpf@archiver.kernel.org>; Thu,  8 Apr 2021 21:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbhDHVjB (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 8 Apr 2021 17:39:01 -0400
Received: from www62.your-server.de ([213.133.104.62]:59488 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbhDHVjB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Apr 2021 17:39:01 -0400
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1lUcMS-0001mz-8a; Thu, 08 Apr 2021 23:38:48 +0200
Received: from [85.7.101.30] (helo=pc-6.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1lUcMR-000RMw-Ed; Thu, 08 Apr 2021 23:38:48 +0200
Subject: Re: [PATCH bpf] libbpf: fix potential NULL pointer dereference
To:     Ciara Loftus <ciara.loftus@intel.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org,
        andrii.nakryiko@gmail.com, alexei.starovoitov@gmail.com
References: <20210408052009.7844-1-ciara.loftus@intel.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <8d129061-ec08-06b6-95a2-0eeefc5ed981@iogearbox.net>
Date:   Thu, 8 Apr 2021 23:38:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20210408052009.7844-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26134/Thu Apr  8 13:08:38 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/8/21 7:20 AM, Ciara Loftus wrote:
> Wait until after the UMEM is checked for null to dereference it.
> 
> Fixes: 43f1bc1efff1 ("libbpf: Restore umem state after socket create failure")
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>

Applied, thanks!
