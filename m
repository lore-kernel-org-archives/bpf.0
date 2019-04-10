Return-Path: <SRS0=J20p=SM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51844C10F11
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 07:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A5AC206B7
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 07:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfDJH6o (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 03:58:44 -0400
Received: from www62.your-server.de ([213.133.104.62]:46228 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfDJH6o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Apr 2019 03:58:44 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hE880-00059K-E1; Wed, 10 Apr 2019 09:58:40 +0200
Received: from [178.197.248.24] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hE880-000PeI-7d; Wed, 10 Apr 2019 09:58:40 +0200
Subject: Re: [PATCH bpf-next v2] libbpf: fix crash in XDP socket part with new
 larger BPF_LOG_BUF_SIZE
To:     Magnus Karlsson <magnus.karlsson@intel.com>, bjorn.topel@intel.com,
        ast@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
References: <1554879256-30587-1-git-send-email-magnus.karlsson@intel.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2354fbfd-8fdc-5e27-a868-306f10ade615@iogearbox.net>
Date:   Wed, 10 Apr 2019 09:58:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1554879256-30587-1-git-send-email-magnus.karlsson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25414/Tue Apr  9 09:53:33 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/10/2019 08:54 AM, Magnus Karlsson wrote:
> In commit da11b417583e ("libbpf: teach libbpf about log_level bit 2"),
> the BPF_LOG_BUF_SIZE was increased to 16M. The XDP socket part of
> libbpf allocated the log_buf on the stack, but for the new 16M buffer
> size this is not going to work. Change the code so it uses a 16K buffer
> instead.
> 
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
> v2: simplified code as suggested by Daniel Borkmann

Applied, thanks.
