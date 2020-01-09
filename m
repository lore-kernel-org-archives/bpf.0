Return-Path: <SRS0=lXkO=26=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7F9C282DD
	for <bpf@archiver.kernel.org>; Thu,  9 Jan 2020 23:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B49CE20656
	for <bpf@archiver.kernel.org>; Thu,  9 Jan 2020 23:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgAIXNY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 9 Jan 2020 18:13:24 -0500
Received: from smtp5.emailarray.com ([65.39.216.39]:52140 "EHLO
        smtp5.emailarray.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgAIXNY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jan 2020 18:13:24 -0500
Received: (qmail 63182 invoked by uid 89); 9 Jan 2020 23:13:22 -0000
Received: from unknown (HELO ?172.20.55.144?) (amxlbW9uQGZsdWdzdmFtcC5jb21AMTk5LjIwMS42NC4xMzY=) (POLARISLOCAL)  
  by smtp5.emailarray.com with (AES256-GCM-SHA384 encrypted) SMTP; 9 Jan 2020 23:13:22 -0000
From:   "Jonathan Lemon" <jlemon@flugsvamp.com>
To:     "John Fastabend" <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net
Subject: Re: [bpf PATCH 7/9] bpf: sockmap/tls, skmsg can have wrapped skmsg
 that needs extra chaining
Date:   Thu, 09 Jan 2020 15:13:16 -0800
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <87694789-2BBE-4DB9-ACA8-240175FA269B@flugsvamp.com>
In-Reply-To: <157851815284.1732.9999561233745329569.stgit@ubuntu3-kvm2>
References: <157851776348.1732.12600714815781177085.stgit@ubuntu3-kvm2>
 <157851815284.1732.9999561233745329569.stgit@ubuntu3-kvm2>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8 Jan 2020, at 13:15, John Fastabend wrote:

> Its possible through a set of push, pop, apply helper calls to construct
> a skmsg, which is just a ring of scatterlist elements, with the start
> value larger than the end value. For example,
>
>       end       start
>   |_0_|_1_| ... |_n_|_n+1_|
>
> Where end points at 1 and start points and n so that valid elements is
> the set {n, n+1, 0, 1}.
>
> Currently, because we don't build the correct chain only {n, n+1} will
> be sent. This adds a check and sg_chain call to correctly submit the
> above to the crypto and tls send path.
>
> Fixes: d3b18ad31f93d ("tls: add bpf support to sk_msg handling")
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>

Acked-by: Jonathan Lemon <jonathan.lemon@gmail.com>
