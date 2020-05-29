Return-Path: <SRS0=8dm5=7L=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CEAC433E0
	for <bpf@archiver.kernel.org>; Fri, 29 May 2020 08:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D170620810
	for <bpf@archiver.kernel.org>; Fri, 29 May 2020 08:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aAjsps5X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgE2IXP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 29 May 2020 04:23:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38282 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725775AbgE2IXO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 29 May 2020 04:23:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590740593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KWYZqDk4lOdNL6rwyEOGey4QJZ8jcrwG5XAlkMAlWuU=;
        b=aAjsps5Xi5L+V3iuCXqMM8eMNo2M8ccpRG2j/vUpwB5539KLuhCfNN+4gTxep17NbLqtXP
        3qXolP/n/ZJwtDQIW9JA4rbmyaOBumAO5lpxgd47gfJHJ9pDsDDV7nYfGqrpawReaZzTCP
        A3/sKLOWM2KVmRjhYi+Yr14Q6PCXHPs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-6br0s6aeNOaeFARZeVDxOQ-1; Fri, 29 May 2020 04:23:11 -0400
X-MC-Unique: 6br0s6aeNOaeFARZeVDxOQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EFE8B835B41;
        Fri, 29 May 2020 08:23:08 +0000 (UTC)
Received: from carbon (unknown [10.40.208.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A15B7A8C7;
        Fri, 29 May 2020 08:22:58 +0000 (UTC)
Date:   Fri, 29 May 2020 10:22:56 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     David Ahern <dsahern@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
        kuba@kernel.org, toke@redhat.com, lorenzo@kernel.org,
        daniel@iogearbox.net, john.fastabend@gmail.com, ast@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com, andriin@fb.com,
        dsahern@gmail.com, brouer@redhat.com
Subject: Re: [PATCH v3 bpf-next 1/5] devmap: Formalize map value as a named
 struct
Message-ID: <20200529102256.22dd50da@carbon>
In-Reply-To: <20200529052057.69378-2-dsahern@kernel.org>
References: <20200529052057.69378-1-dsahern@kernel.org>
        <20200529052057.69378-2-dsahern@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 28 May 2020 23:20:53 -0600
David Ahern <dsahern@kernel.org> wrote:

> Add 'struct bpf_devmap_val' to the bpf uapi to formalize the
> expected values that can be passed in for a DEVMAP.
> Update devmap code to use the struct.
> 
> Signed-off-by: David Ahern <dsahern@kernel.org>
> ---
>  include/uapi/linux/bpf.h       |  5 +++++
>  kernel/bpf/devmap.c            | 40 +++++++++++++++++++---------------
>  tools/include/uapi/linux/bpf.h |  5 +++++
>  3 files changed, 33 insertions(+), 17 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 54b93f8b49b8..42c884dfbad9 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -3625,6 +3625,11 @@ struct xdp_md {
>  	__u32 rx_queue_index;  /* rxq->queue_index  */
>  };
>  
> +/* DEVMAP values */
> +struct bpf_devmap_val {
> +	__u32 ifindex;   /* device index */
> +};

We do need this struct bpf_devmap_val, but I think it is wrong to make this UAPI.

A BPF-prog can get this via:  #include "vmlinux.h"

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

