Return-Path: <SRS0=iiTG=57=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A11C2BB55
	for <bpf@archiver.kernel.org>; Wed, 15 Apr 2020 12:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD9F32078B
	for <bpf@archiver.kernel.org>; Wed, 15 Apr 2020 12:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369779AbgDOMeq (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 15 Apr 2020 08:34:46 -0400
Received: from www62.your-server.de ([213.133.104.62]:43634 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S369772AbgDOMek (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Apr 2020 08:34:40 -0400
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jOhFU-0001Ck-G1; Wed, 15 Apr 2020 14:34:36 +0200
Received: from [178.195.186.98] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jOhFU-000HvK-4x; Wed, 15 Apr 2020 14:34:36 +0200
Subject: Re: [PATCH bpf 1/2] libbpf: Fix type of old_fd in
 bpf_xdp_set_link_opts
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        ast@fb.com
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        David Ahern <dsahern@gmail.com>
References: <20200414145025.182163-1-toke@redhat.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <27989444-8f60-c543-f9d9-94f9f610a4a7@iogearbox.net>
Date:   Wed, 15 Apr 2020 14:34:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200414145025.182163-1-toke@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25782/Tue Apr 14 13:57:42 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/14/20 4:50 PM, Toke Høiland-Jørgensen wrote:
> The 'old_fd' parameter used for atomic replacement of XDP programs is
> supposed to be an FD, but was left as a u32 from an earlier iteration of
> the patch that added it. It was converted to an int when read, so things
> worked correctly even with negative values, but better change the
> definition to correctly reflect the intention.
> 
> Fixes: bd5ca3ef93cd ("libbpf: Add function to set link XDP fd while specifying old program")
> Reported-by: David Ahern <dsahern@gmail.com>
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>

Both applied, thanks!
