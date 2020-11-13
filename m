Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF59C2D0E4
	for <bpf@archiver.kernel.org>; Fri, 13 Nov 2020 01:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 542EB221E9
	for <bpf@archiver.kernel.org>; Fri, 13 Nov 2020 01:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D8B2w7Xv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgKMBHH (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 12 Nov 2020 20:07:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26552 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726017AbgKMBHH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 12 Nov 2020 20:07:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605229626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NAJPNJiBjA+zW0NJG9v+lLPLZ2lgHVWFrFFvvRxwxWI=;
        b=D8B2w7XvCpYzQPdq9B7igXoU8P3tS/yrTlMUQKtNN7NekGenJ2cAnIz1Vm5JyPUHYA35+B
        WAqHDgBM3OswFv39usbgeK1Ag83yEHUQgzseFK7fp+Xwm5uM7oyPoEXPXmgBwo7fon3h+6
        7/QDJK1JXTNmSXSH7ntoVfNcz1zPerw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-qHD3FHzsMGGY3LmKWLbBEg-1; Thu, 12 Nov 2020 20:07:02 -0500
X-MC-Unique: qHD3FHzsMGGY3LmKWLbBEg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 573EB10066FC;
        Fri, 13 Nov 2020 01:07:00 +0000 (UTC)
Received: from [10.72.12.208] (ovpn-12-208.pek2.redhat.com [10.72.12.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 04F3119C59;
        Fri, 13 Nov 2020 01:06:53 +0000 (UTC)
Subject: Re: [PATCH netdev 2/2] virtio, xdp: Allow xdp to load, even if there
 is not enough queue
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, mst@redhat.com, davem@davemloft.net,
        kuba@kernel.org
References: <cover.1605184791.git.xuanzhuo@linux.alibaba.com>
 <c2781b22ebfab5854afc1f6a1eb77b5018b11ccd.1605184791.git.xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <09cbe8ac-34ec-3945-88f4-a31e863c44f7@redhat.com>
Date:   Fri, 13 Nov 2020 09:06:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c2781b22ebfab5854afc1f6a1eb77b5018b11ccd.1605184791.git.xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 2020/11/12 下午5:15, Xuan Zhuo wrote:
> Since XDP_TX uses an independent queue to send data by default, and
> requires a queue for each CPU, this condition is often not met when the
> number of CPUs is relatively large, but XDP_TX is not used in many
> cases. I hope In this case, XDP is allowed to load and a warning message
> is submitted. If the user uses XDP_TX, another error is generated.
>
> This is not a perfect solution, but I still hope to solve some of the
> problems first.
>
> Signed-off-by: Xuan Zhuo<xuanzhuo@linux.alibaba.com>


This leads bad user experiences.

Let's do something like this:

1) When TX queues is sufficient, go as in the past
2) When TX queue is not, use tx lock to synchronize

Thanks

