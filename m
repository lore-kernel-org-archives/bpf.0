Return-Path: <SRS0=hZ0g=SS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AF3C10F14
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 08:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B3020868
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 08:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfDPIzJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:55:09 -0400
Received: from www62.your-server.de ([213.133.104.62]:35944 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfDPIzI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Apr 2019 04:55:08 -0400
Received: from [88.198.220.132] (helo=sslproxy03.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hGJrv-00084d-12; Tue, 16 Apr 2019 10:55:07 +0200
Received: from [178.197.249.32] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hGJru-0003ZF-MO; Tue, 16 Apr 2019 10:55:06 +0200
Subject: Re: [PATCH bpf] libbpf: add binary to gitignore
To:     Matteo Croce <mcroce@redhat.com>, bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>
References: <20190413013732.18432-1-mcroce@redhat.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <90311f8b-b0fd-d895-4df9-b72fec2c8ccd@iogearbox.net>
Date:   Tue, 16 Apr 2019 10:55:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190413013732.18432-1-mcroce@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25420/Mon Apr 15 09:57:25 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/13/2019 03:37 AM, Matteo Croce wrote:
> Some binaries are generated when building libbpf from tools/lib/bpf/,
> namely libbpf.so.0.0.2 and libbpf.so.0.
> Add them to the local .gitignore.
> 
> Signed-off-by: Matteo Croce <mcroce@redhat.com>

Applied, thanks!
