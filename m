Return-Path: <SRS0=ovpu=UL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B50C31E46
	for <bpf@archiver.kernel.org>; Wed, 12 Jun 2019 05:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C8420866
	for <bpf@archiver.kernel.org>; Wed, 12 Jun 2019 05:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730239AbfFLFij (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 12 Jun 2019 01:38:39 -0400
Received: from mga05.intel.com ([192.55.52.43]:52680 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbfFLFij (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Jun 2019 01:38:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2019 22:38:38 -0700
X-ExtLoop1: 1
Received: from nisrael1-mobl1.ger.corp.intel.com (HELO btopel-mobl.ger.intel.com) ([10.255.41.147])
  by orsmga008.jf.intel.com with ESMTP; 11 Jun 2019 22:38:33 -0700
Subject: Re: [PATCH bpf-next v3 0/5] net: xdp: refactor XDP program queries
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        magnus.karlsson@intel.com, toke@redhat.com, brouer@redhat.com,
        bpf@vger.kernel.org, saeedm@mellanox.com
References: <20190610160234.4070-1-bjorn.topel@gmail.com>
 <20190610152433.6e265d6c@cakuba.netronome.com>
 <980c54f7-e270-f6cf-089d-969cebad8f38@intel.com>
 <20190611102245.1565e742@cakuba.netronome.com>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>
Message-ID: <23b18044-dbd2-f04c-0669-9cdfd043656f@intel.com>
Date:   Wed, 12 Jun 2019 07:38:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190611102245.1565e742@cakuba.netronome.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2019-06-11 19:22, Jakub Kicinski wrote:
> Three progs?  Are we planning to allow SKB and DRV at the same time?

No! :-)

> One prog and flags looked fairly reasonable to me.  Flags can even be
> a u8.  The offload prog can continue to live in the driver.

Ok, I'll take that route (only adding a u8 flags member to net_device).

