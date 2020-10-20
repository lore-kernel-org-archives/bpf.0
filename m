Return-Path: <SRS0=ZEGR=D3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E43DC433E7
	for <bpf@archiver.kernel.org>; Tue, 20 Oct 2020 09:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E52882224E
	for <bpf@archiver.kernel.org>; Tue, 20 Oct 2020 09:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UP1Mi+zp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403952AbgJTJq2 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 20 Oct 2020 05:46:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24666 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403950AbgJTJq2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 20 Oct 2020 05:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603187187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=knt9S68tgKirjQKsf7Zso0Y78A5lUiSAACpKMVJzeN8=;
        b=UP1Mi+zpGG9b2ssmgVBqS4N4qPeeK7q2Qx6iy5cZJvSTP3oRsDBx3usPvnFPeyZZiry4iX
        0WeN4SblcBtpOz/jsKSahPtFX3Mjn49odEIOW2MxufygwDnPWqHQCScCLVojRnQwXIl980
        guAqZxNz1k+2eDtE8GHvHFFt4CfQN+M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-IaPcN5B_O_i6gFbNsz2Www-1; Tue, 20 Oct 2020 05:46:24 -0400
X-MC-Unique: IaPcN5B_O_i6gFbNsz2Www-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 632A018A0760;
        Tue, 20 Oct 2020 09:46:23 +0000 (UTC)
Received: from carbon (unknown [10.36.110.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B7B5A5B4A3;
        Tue, 20 Oct 2020 09:46:14 +0000 (UTC)
Date:   Tue, 20 Oct 2020 11:46:13 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
        kuba@kernel.org, lorenzo.bianconi@redhat.com,
        ilias.apalodimas@linaro.org, brouer@redhat.com
Subject: Re: [RFC 1/2] net: xdp: introduce bulking for xdp tx return path
Message-ID: <20201020114613.752a979c@carbon>
In-Reply-To: <62165fcacf47521edae67ae739827aa5f751fb8b.1603185591.git.lorenzo@kernel.org>
References: <cover.1603185591.git.lorenzo@kernel.org>
        <62165fcacf47521edae67ae739827aa5f751fb8b.1603185591.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 20 Oct 2020 11:33:37 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> index 54b0bf574c05..af33cc62ed4c 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -663,6 +663,8 @@ struct mvneta_tx_queue {
>  
>  	/* Affinity mask for CPUs*/
>  	cpumask_t affinity_mask;
> +
> +	struct xdp_frame_bulk bq;
>  };
>  
>  struct mvneta_rx_queue {
> @@ -1854,12 +1856,10 @@ static void mvneta_txq_bufs_free(struct mvneta_port *pp,
>  			dev_kfree_skb_any(buf->skb);
>  		} else if (buf->type == MVNETA_TYPE_XDP_TX ||
>  			   buf->type == MVNETA_TYPE_XDP_NDO) {
> -			if (napi && buf->type == MVNETA_TYPE_XDP_TX)
> -				xdp_return_frame_rx_napi(buf->xdpf);
> -			else
> -				xdp_return_frame(buf->xdpf);
> +			xdp_return_frame_bulk(buf->xdpf, &txq->bq, napi);

Hmm, I don't think you can use 'napi' directly here.

You are circumventing check (buf->type == MVNETA_TYPE_XDP_TX), and will
now also allow XDP_NDO (XDP_REDIRECT) to basically use xdp_return_frame_rx_napi().


>  		}
>  	}
> +	xdp_flush_frame_bulk(&txq->bq, napi);
>  
>  	netdev_tx_completed_queue(nq, pkts_compl, bytes_compl);
>  }



-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

