Return-Path: <SRS0=Pto2=7P=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB08C433DF
	for <bpf@archiver.kernel.org>; Tue,  2 Jun 2020 20:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3384020674
	for <bpf@archiver.kernel.org>; Tue,  2 Jun 2020 20:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgFBUuE (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 2 Jun 2020 16:50:04 -0400
Received: from www62.your-server.de ([213.133.104.62]:59878 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgFBUuE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Jun 2020 16:50:04 -0400
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jgDrD-0004XZ-QU; Tue, 02 Jun 2020 22:49:59 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jgDrD-000MMW-Gx; Tue, 02 Jun 2020 22:49:59 +0200
Subject: Re: [PATCH bpf-next v4 1/3] sock: move sock_valbool_flag to header
To:     Dmitry Yakunin <zeil@yandex-team.ru>, alexei.starovoitov@gmail.com
Cc:     davem@davemloft.net, brakmo@fb.com, eric.dumazet@gmail.com,
        kafai@fb.com, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20200602195147.56912-1-zeil@yandex-team.ru>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <40297825-f6d5-21b5-b0ff-7720a50c04d8@iogearbox.net>
Date:   Tue, 2 Jun 2020 22:49:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200602195147.56912-1-zeil@yandex-team.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25831/Tue Jun  2 14:41:03 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/2/20 9:51 PM, Dmitry Yakunin wrote:
> This is preparation for usage in bpf_setsockopt.
> 
> Signed-off-by: Dmitry Yakunin <zeil@yandex-team.ru>
> Acked-by: Martin KaFai Lau <kafai@fb.com>

bpf-next is currently closed due to merge window. Please resend once bpf-next opens
back up in ~2 weeks from now. Feel free to check the status here [0].

Thanks,
Daniel

   [0] http://vger.kernel.org/~davem/net-next.html
