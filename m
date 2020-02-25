Return-Path: <SRS0=/C52=4N=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C762C35DF5
	for <bpf@archiver.kernel.org>; Tue, 25 Feb 2020 05:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FEF921556
	for <bpf@archiver.kernel.org>; Tue, 25 Feb 2020 05:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XZy5ul8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbgBYFpI (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 25 Feb 2020 00:45:08 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44053 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725788AbgBYFpI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 25 Feb 2020 00:45:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582609507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Eko79gUr9+logn8fvR3Vy0N8FeE/3ZDnWVRg/X1bank=;
        b=XZy5ul8jeTPrlHrDJzWcUkKe397g3vKbP69lTTtJRil8iK1RwX4vpbMHhsj/P9sp/0Z3pl
        LtbV3OtWQrDH28g+42P5vYXJMpxxa43Ozb2SVlIZ9Ul5EuBvPnk9ITdnYrh1DD8G5q5pEu
        c5GQf1adOXhoV3fDLOOSGd3QX6wkruk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-FwuNFUYyOjyMm7LAhuO5ZA-1; Tue, 25 Feb 2020 00:45:05 -0500
X-MC-Unique: FwuNFUYyOjyMm7LAhuO5ZA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFBB28017CC;
        Tue, 25 Feb 2020 05:45:02 +0000 (UTC)
Received: from [10.72.13.170] (ovpn-13-170.pek2.redhat.com [10.72.13.170])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A5821001B09;
        Tue, 25 Feb 2020 05:44:55 +0000 (UTC)
Subject: Re: [PATCH bpf-next v6 1/2] virtio_net: keep vnet header zeroed if
 XDP is loaded for small buffer
To:     Yuya Kusakabe <yuya.kusakabe@gmail.com>
Cc:     andriin@fb.com, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, hawk@kernel.org,
        john.fastabend@gmail.com, kafai@fb.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, mst@redhat.com,
        netdev@vger.kernel.org, songliubraving@fb.com, yhs@fb.com
References: <20200225033103.437305-1-yuya.kusakabe@gmail.com>
 <20200225033212.437563-1-yuya.kusakabe@gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <1b3045d0-edc0-3f6f-5442-06f6f927ff94@redhat.com>
Date:   Tue, 25 Feb 2020 13:44:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200225033212.437563-1-yuya.kusakabe@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 2020/2/25 =E4=B8=8A=E5=8D=8811:32, Yuya Kusakabe wrote:
> We do not want to care about the vnet header in receive_small() if XDP
> is loaded, since we can not know whether or not the packet is modified
> by XDP.
>
> Fixes: f6b10209b90d ("virtio-net: switch to use build_skb() for small b=
uffer")
> Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
> ---
>   drivers/net/virtio_net.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 2fe7a3188282..f39d0218bdaa 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -735,10 +735,10 @@ static struct sk_buff *receive_small(struct net_d=
evice *dev,
>   	}
>   	skb_reserve(skb, headroom - delta);
>   	skb_put(skb, len);
> -	if (!delta) {
> +	if (!xdp_prog) {
>   		buf +=3D header_offset;
>   		memcpy(skb_vnet_hdr(skb), buf, vi->hdr_len);
> -	} /* keep zeroed vnet hdr since packet was changed by bpf */
> +	} /* keep zeroed vnet hdr since XDP is loaded */
>  =20
>   err:
>   	return skb;


Acked-by: Jason Wang <jasowang@redhat.com>

