Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071DCC433E0
	for <bpf@archiver.kernel.org>; Mon, 18 Jan 2021 22:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE4D622DD3
	for <bpf@archiver.kernel.org>; Mon, 18 Jan 2021 22:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389627AbhARWrX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 18 Jan 2021 17:47:23 -0500
Received: from www62.your-server.de ([213.133.104.62]:43700 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389762AbhARWrR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Jan 2021 17:47:17 -0500
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1l1dIB-000AxH-2e; Mon, 18 Jan 2021 23:46:35 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1l1dIA-00038f-TA; Mon, 18 Jan 2021 23:46:34 +0100
Subject: Re: [PATCHv7 bpf-next] samples/bpf: add xdp program on egress for
 xdp_redirect_map
To:     Hangbin Liu <liuhangbin@gmail.com>, bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, Jesper Dangaard Brouer <brouer@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>
References: <20210114142732.2595651-1-liuhangbin@gmail.com>
 <20210115062433.2624893-1-liuhangbin@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <cd70710d-1370-6b56-af7a-ba7dc9e4b03f@iogearbox.net>
Date:   Mon, 18 Jan 2021 23:46:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20210115062433.2624893-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26053/Mon Jan 18 13:33:47 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/15/21 7:24 AM, Hangbin Liu wrote:
> This patch add a xdp program on egress to show that we can modify
> the packet on egress. In this sample we will set the pkt's src
> mac to egress's mac address. The xdp_prog will be attached when
> -X option supplied.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

This has a bunch of minor checkpatch issues, see also netdev/checkpatch	[0];
disregard the 'exceeds 80 columns' but there is a double newline and other
minor stuff that slipped in (usually good to catch before submission):

WARNING: Missing a blank line after declarations
#133: FILE: samples/bpf/xdp_redirect_map_kern.c:139:
+	unsigned char mac[6] = {0x0, 0x0, 0x0, 0x0, 0x0, 0x1};
+	return xdp_redirect_map_egress(ctx, mac);

WARNING: Missing a blank line after declarations
#141: FILE: samples/bpf/xdp_redirect_map_kern.c:147:
+	unsigned char mac[6] = {0x0, 0x0, 0x0, 0x0, 0x1, 0x1};
+	return xdp_redirect_map_egress(ctx, mac);

ERROR: do not initialise statics to false
#164: FILE: samples/bpf/xdp_redirect_map_user.c:29:
+static bool xdp_devmap_attached = false;

CHECK: Please don't use multiple blank lines
#340: FILE: samples/bpf/xdp_redirect_map_user.c:285:
+
+

Please carry ACK forward, fix them up and resubmit, thanks!

   [0] https://patchwork.kernel.org/project/netdevbpf/patch/20210115062433.2624893-1-liuhangbin@gmail.com/
