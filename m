Return-Path: <SRS0=kBJA=UX=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27856C43613
	for <bpf@archiver.kernel.org>; Mon, 24 Jun 2019 15:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E6A205C9
	for <bpf@archiver.kernel.org>; Mon, 24 Jun 2019 15:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfFXPAG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 24 Jun 2019 11:00:06 -0400
Received: from www62.your-server.de ([213.133.104.62]:33420 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbfFXPAG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Jun 2019 11:00:06 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hfQRw-00055l-S1; Mon, 24 Jun 2019 17:00:04 +0200
Received: from [178.199.41.31] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hfQRw-000UUS-Lv; Mon, 24 Jun 2019 17:00:04 +0200
Subject: Re: [PATCH] xsk: sample kernel code is now in libbpf
To:     Eric Leblond <eric@regit.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
References: <20190621201310.12791-1-eric@regit.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <32cddde0-47d6-a5c1-9a8c-aa2bc408dea2@iogearbox.net>
Date:   Mon, 24 Jun 2019 17:00:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190621201310.12791-1-eric@regit.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25490/Mon Jun 24 10:02:14 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 06/21/2019 10:13 PM, Eric Leblond wrote:
> Fix documentation that mention xdpsock_kern.c which has been
> replaced by code embedded in libbpf.
> 
> Signed-off-by: Eric Leblond <eric@regit.org>

Applied, thanks!
