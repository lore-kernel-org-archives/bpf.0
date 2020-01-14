Return-Path: <SRS0=Nq9f=3D=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC142C33C9E
	for <bpf@archiver.kernel.org>; Tue, 14 Jan 2020 19:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA6924655
	for <bpf@archiver.kernel.org>; Tue, 14 Jan 2020 19:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgANThJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 14 Jan 2020 14:37:09 -0500
Received: from www62.your-server.de ([213.133.104.62]:37106 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANThJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Jan 2020 14:37:09 -0500
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1irRzt-0002RK-QH; Tue, 14 Jan 2020 20:37:05 +0100
Received: from [178.197.249.11] (helo=pc-9.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1irRzt-000LkR-Hg; Tue, 14 Jan 2020 20:37:05 +0100
Subject: Re: [PATCH][bpf-next][v2] bpf: return -EBADRQC for invalid map type
 in __bpf_tx_xdp_map
To:     Li RongQing <lirongqing@baidu.com>, netdev@vger.kernel.org,
        songliubraving@fb.com, bpf@vger.kernel.org
References: <1578618277-18085-1-git-send-email-lirongqing@baidu.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <7aa19e08-09b3-61b0-0622-130de0c0e51e@iogearbox.net>
Date:   Tue, 14 Jan 2020 20:37:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1578618277-18085-1-git-send-email-lirongqing@baidu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25695/Tue Jan 14 14:34:00 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/10/20 2:04 AM, Li RongQing wrote:
> a negative value should be returned if map->map_type
> is invalid although that seems unlikely now, then the
> caller will continue to handle buffer, otherwise the
> buffer will be leaked
> 
> Daniel Borkmann suggested:
> -EBADRQC should be returned to keep consistent with
> xdp_do_generic_redirect_map() for the tracepoint output
> and not to be confused with -EOPNOTSUPP from other
> locations like dev_map_enqueue() when ndo_xdp_xmit
> is missing or such.
> 
> Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Applied, thanks (fixed up commit message a bit).
