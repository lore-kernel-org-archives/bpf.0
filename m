Return-Path: <SRS0=32pG=TQ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2B0C04E87
	for <bpf@archiver.kernel.org>; Thu, 16 May 2019 01:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E7F20881
	for <bpf@archiver.kernel.org>; Thu, 16 May 2019 01:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfEPBqW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 15 May 2019 21:46:22 -0400
Received: from www62.your-server.de ([213.133.104.62]:58024 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfEOXmN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 May 2019 19:42:13 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hR3XF-0002s2-9O; Thu, 16 May 2019 01:42:09 +0200
Received: from [178.199.41.31] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hR3XF-0003Or-3y; Thu, 16 May 2019 01:42:09 +0200
Subject: Re: [PATCH bpf] libbpf: don't fail when feature probing fails
To:     Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org
References: <20190515033849.62059-1-sdf@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f1e80396-fc52-3b3d-19e2-df9daf975666@iogearbox.net>
Date:   Thu, 16 May 2019 01:42:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190515033849.62059-1-sdf@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25450/Wed May 15 09:59:26 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 05/15/2019 05:38 AM, Stanislav Fomichev wrote:
> Otherwise libbpf is unusable from unprivileged process with
> kernel.kernel.unprivileged_bpf_disabled=1.
> All I get is EPERM from the probes, even if I just want to
> open an ELF object and look at what progs/maps it has.
> 
> Instead of dying on probes, let's just pr_debug the error and
> try to continue.
> 
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Good catch, applied, thanks!
