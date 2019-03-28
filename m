Return-Path: <SRS0=idkB=R7=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2C9C43381
	for <bpf@archiver.kernel.org>; Thu, 28 Mar 2019 15:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DCC02183F
	for <bpf@archiver.kernel.org>; Thu, 28 Mar 2019 15:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbfC1Pj1 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:39:27 -0400
Received: from www62.your-server.de ([213.133.104.62]:53558 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfC1Pj1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Mar 2019 11:39:27 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h9X7k-00050i-Q8; Thu, 28 Mar 2019 16:39:24 +0100
Received: from [178.197.248.24] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1h9X7k-000JEp-I5; Thu, 28 Mar 2019 16:39:24 +0100
Subject: Re: [PATCH bpf 0/2] libbpf: minor packaging fixes
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        ast@kernel.org, netdev@vger.kernel.org
Cc:     magnus.karlsson@intel.com, bpf@vger.kernel.org,
        xiaolong.ye@intel.com, qi.z.zhang@intel.com
References: <20190327135114.17026-1-bjorn.topel@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <4bca355e-379c-fb41-0168-1889dba912c4@iogearbox.net>
Date:   Thu, 28 Mar 2019 16:39:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190327135114.17026-1-bjorn.topel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25402/Thu Mar 28 08:54:39 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/27/2019 02:51 PM, Björn Töpel wrote:
> The DPDK project is moving forward with its AF_XDP PMD, and during
> that process some libbpf issues surfaced [1].

Great to hear!

> This series address two, minor, packaging issues for libbpf. The
> header file xsk.h was missing from the instal_headers target and
> libelf was not included in the libbpf.so (shared library) build.
> 
> 
> Thanks,
> Björn
> 
> [1] https://patches.dpdk.org/patch/50704/#93571
> 
> Björn Töpel (2):
>   libbpf: add xsk.h to install_headers target
>   libbpf: add libelf dependency to shared library build
> 
>  tools/lib/bpf/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Looks good, applied, thanks (also fixed up various typos in the commit
message while applying).
