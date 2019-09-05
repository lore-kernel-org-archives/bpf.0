Return-Path: <SRS0=JPvp=XA=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36523C3A5A5
	for <bpf@archiver.kernel.org>; Thu,  5 Sep 2019 13:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E665F2067D
	for <bpf@archiver.kernel.org>; Thu,  5 Sep 2019 13:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388444AbfIENNI (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 5 Sep 2019 09:13:08 -0400
Received: from www62.your-server.de ([213.133.104.62]:55328 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388400AbfIENNI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Sep 2019 09:13:08 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1i5rZR-0007Tq-Kf; Thu, 05 Sep 2019 15:13:05 +0200
Received: from [2a02:120b:2c12:c120:71a0:62dd:894c:fd0e] (helo=pc-66.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1i5rZR-000KeU-8j; Thu, 05 Sep 2019 15:13:05 +0200
Subject: Re: [PATCH bpf-next] i40e: fix xdp handle calculations
To:     Kevin Laatz <kevin.laatz@intel.com>, netdev@vger.kernel.org,
        ast@kernel.org, bjorn.topel@intel.com, magnus.karlsson@intel.com,
        jonathan.lemon@gmail.com
Cc:     bruce.richardson@intel.com, ciara.loftus@intel.com,
        bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org
References: <20190905011144.3513-1-kevin.laatz@intel.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f02d5d10-f2c9-e8ad-d6fe-b7ec2d952b85@iogearbox.net>
Date:   Thu, 5 Sep 2019 15:13:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190905011144.3513-1-kevin.laatz@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25563/Thu Sep  5 10:24:28 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/5/19 3:11 AM, Kevin Laatz wrote:
> Currently, we don't add headroom to the handle in i40e_zca_free,
> i40e_alloc_buffer_slow_zc and i40e_alloc_buffer_zc. The addition of the
> headroom to the handle was removed in
> commit 2f86c806a8a8 ("i40e: modify driver for handling offsets"), which
> will break things when headroom is non-zero. This patch fixes this and uses
> xsk_umem_adjust_offset to add it appropritely based on the mode being run.
> 
> Fixes: 2f86c806a8a8 ("i40e: modify driver for handling offsets")
> Reported-by: Bjorn Topel <bjorn.topel@intel.com>
> Signed-off-by: Kevin Laatz <kevin.laatz@intel.com>

Applied, thanks!
