Return-Path: <SRS0=gSIr=6W=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F695C38A2A
	for <bpf@archiver.kernel.org>; Fri,  8 May 2020 11:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F01C2208DB
	for <bpf@archiver.kernel.org>; Fri,  8 May 2020 11:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FfGxiU0Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgEHLKj (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 8 May 2020 07:10:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49340 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726950AbgEHLKe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 May 2020 07:10:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588936233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yWyjwLJXZxQgAoMof8jZyYQOP6JcXM52G0/5WnsnOLQ=;
        b=FfGxiU0QWLL+yEv7hKfJfFzkIJqWL8jPFGFn4bYAV/mYppC93rGqSHFjz7A1OMvm4Zd3BO
        tDn9QF5zycXOHpmbb1QzYQq3YEXMezDCA30Ujym0IW4XwRcJJtKk8VEMuz/yPYV5QdfGD3
        HJvql4rB9v/1cNAwBvxBJKd2QbBzMbU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-_r7AnXUGPcO0V-vWj4IiyQ-1; Fri, 08 May 2020 07:10:31 -0400
X-MC-Unique: _r7AnXUGPcO0V-vWj4IiyQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28B99805724;
        Fri,  8 May 2020 11:10:29 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 95DF25C1BE;
        Fri,  8 May 2020 11:10:23 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id 8A3BF3063F605;
        Fri,  8 May 2020 13:10:22 +0200 (CEST)
Subject: [PATCH net-next v3 19/33] tun: add XDP frame size
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     sameehj@amazon.com
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        David Ahern <dsahern@gmail.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>
Date:   Fri, 08 May 2020 13:10:22 +0200
Message-ID: <158893622248.2321140.5028576547350158000.stgit@firesoul>
In-Reply-To: <158893607924.2321140.16117992313983615627.stgit@firesoul>
References: <158893607924.2321140.16117992313983615627.stgit@firesoul>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The tun driver have two code paths for running XDP (bpf_prog_run_xdp).
In both cases 'buflen' contains enough tailroom for skb_shared_info.

Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/tun.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 44889eba1dbc..c54f967e2c66 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1671,6 +1671,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 		xdp_set_data_meta_invalid(&xdp);
 		xdp.data_end = xdp.data + len;
 		xdp.rxq = &tfile->xdp_rxq;
+		xdp.frame_sz = buflen;
 
 		act = bpf_prog_run_xdp(xdp_prog, &xdp);
 		if (act == XDP_REDIRECT || act == XDP_TX) {
@@ -2411,6 +2412,7 @@ static int tun_xdp_one(struct tun_struct *tun,
 		}
 		xdp_set_data_meta_invalid(xdp);
 		xdp->rxq = &tfile->xdp_rxq;
+		xdp->frame_sz = buflen;
 
 		act = bpf_prog_run_xdp(xdp_prog, xdp);
 		err = tun_xdp_act(tun, xdp_prog, xdp, act);


