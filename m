Return-Path: <SRS0=fZcT=UK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DD0C4321A
	for <bpf@archiver.kernel.org>; Tue, 11 Jun 2019 07:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 103FD2086D
	for <bpf@archiver.kernel.org>; Tue, 11 Jun 2019 07:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404277AbfFKHYu (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 11 Jun 2019 03:24:50 -0400
Received: from mga14.intel.com ([192.55.52.115]:20273 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404116AbfFKHYu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Jun 2019 03:24:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2019 00:24:50 -0700
X-ExtLoop1: 1
Received: from unknown (HELO btopel-mobl.ger.intel.com) ([10.255.41.162])
  by fmsmga006.fm.intel.com with ESMTP; 11 Jun 2019 00:24:43 -0700
Subject: Re: [PATCH bpf-next v3 0/5] net: xdp: refactor XDP program queries
To:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        magnus.karlsson@intel.com, toke@redhat.com, brouer@redhat.com,
        bpf@vger.kernel.org, saeedm@mellanox.com
References: <20190610160234.4070-1-bjorn.topel@gmail.com>
 <20190610152433.6e265d6c@cakuba.netronome.com>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>
Message-ID: <980c54f7-e270-f6cf-089d-969cebad8f38@intel.com>
Date:   Tue, 11 Jun 2019 09:24:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190610152433.6e265d6c@cakuba.netronome.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2019-06-11 00:24, Jakub Kicinski wrote:
> On Mon, 10 Jun 2019 18:02:29 +0200, Björn Töpel wrote:
>> Jakub, what's your thoughts on the special handling of XDP offloading?
>> Maybe it's just overkill? Just allocate space for the offloaded
>> program regardless support or not? Also, please review the
>> dev_xdp_support_offload() addition into the nfp code.
> 
> I'm not a huge fan of the new approach - it adds a conditional move,
> dereference and a cache line reference to the fast path :(
> 
> I think it'd be fine to allocate entries for all 3 types, but the
> potential of slowing down DRV may not be a good thing in a refactoring
> series.
> 

Note, that currently it's "only" the XDP_SKB path that's affected, but
yeah, I agree with out. And going forward, I'd like to use the netdev
xdp_prog from the Intel drivers, instead of spreading/caching it all over.

I'll go back to the drawing board. Any suggestions on a how/where the
program should be stored in the netdev are welcome! :-) ...or maybe just
simply store the netdev_xdp flat (w/o the additional allocation step) in
net_device. Three programs and the boolean (remove the num_progs).


Björn
