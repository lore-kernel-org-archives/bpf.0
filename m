Return-Path: <SRS0=hZ0g=SS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691C3C282DA
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 08:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A0F720868
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 08:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbfDPI6s (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:58:48 -0400
Received: from www62.your-server.de ([213.133.104.62]:36654 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfDPI6r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Apr 2019 04:58:47 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hGJTG-0006JL-2j; Tue, 16 Apr 2019 10:29:38 +0200
Received: from [178.197.249.32] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hGJTF-000JKP-Qw; Tue, 16 Apr 2019 10:29:37 +0200
Subject: Re: [PATCH v3 bpf-next 1/2] bpftool: Use print_entry_error() in case
 of ENOENT when dumping
To:     Benjamin Poirier <bpoirier@suse.com>
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
References: <20190412030322.15494-1-bpoirier@suse.com>
 <20190415071536.19287-1-bpoirier@suse.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <df8f91a3-0d4e-dee2-fe36-12a7f3eb7a2d@iogearbox.net>
Date:   Tue, 16 Apr 2019 10:29:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190415071536.19287-1-bpoirier@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25420/Mon Apr 15 09:57:25 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/15/2019 09:15 AM, Benjamin Poirier wrote:
> Commit bf598a8f0f77 ("bpftool: Improve handling of ENOENT on map dumps")
> used print_entry_plain() in case of ENOENT. However, that commit introduces
> dead code. Per-cpu maps are zero-filled. When reading them, it's all or
> nothing. There will never be a case where some cpus have an entry and
> others don't.
> 
> The truth is that ENOENT is an error case. Use print_entry_error() to
> output the desired message. That function's "value" parameter is also
> renamed to indicate that we never use it for an actual map value.
> 
> The output format is unchanged.
> 
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>

Both applied, thanks!
