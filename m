Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796FEC433DB
	for <bpf@archiver.kernel.org>; Wed, 27 Jan 2021 23:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 280B664DCE
	for <bpf@archiver.kernel.org>; Wed, 27 Jan 2021 23:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbhA0XSg (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Jan 2021 18:18:36 -0500
Received: from www62.your-server.de ([213.133.104.62]:58402 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbhA0XQX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Jan 2021 18:16:23 -0500
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1l4u2B-000G1t-9Y; Thu, 28 Jan 2021 00:15:35 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1l4u2B-0005Xu-3V; Thu, 28 Jan 2021 00:15:35 +0100
Subject: Re: [PATCH bpf-next v2 1/6] xsk: add tracepoints for packet drops
To:     "Loftus, Ciara" <ciara.loftus@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        "bjorn@kernel.org" <bjorn@kernel.org>,
        "Janjua, Weqaar A" <weqaar.a.janjua@intel.com>
References: <20210126075239.25378-1-ciara.loftus@intel.com>
 <20210126075239.25378-2-ciara.loftus@intel.com>
 <7100d6c0-8556-4f7e-93e7-5ba6fa549104@iogearbox.net>
 <c40e361d0ef2475db93cfb5d007599f2@intel.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <dc3a1b1f-a7c6-31bd-3813-74e226b87e0a@iogearbox.net>
Date:   Thu, 28 Jan 2021 00:15:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <c40e361d0ef2475db93cfb5d007599f2@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26062/Wed Jan 27 13:26:15 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/27/21 3:10 PM, Loftus, Ciara wrote:
[...]
> 
> Thanks for your feedback Daniel.
> 
> The stats tell us that there is *a* problem whereas the traces will shed
> light on what that problem is. eg. The XSK_TRACE_DROP_PKT_TOO_BIG
> trace tells us we dropped a packet on RX due to it being too big vs. ss
> would just tell us the packet was dropped.

But wouldn't that just be a matter of extending struct xdp_diag_stats +
xsk_diag_put_stats() with more fine-grained counters? Just wondering given
you add the trace_xsk_packet_drop() tracepoints at locations where we
bump most of these counters already for ss tool. I guess this was my confusion -
as far as I can see only the two XSK_TRACE_DROP_{PKT_TOO_BIG,DRV_ERR_TX} are
not covered in xdp_diag_stats. Is there any other reason that the diag is
not sufficient for your use case?

Thanks,
Daniel
