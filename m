Return-Path: <SRS0=8CIW=7C=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1C6C433E1
	for <bpf@archiver.kernel.org>; Wed, 20 May 2020 13:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C939120756
	for <bpf@archiver.kernel.org>; Wed, 20 May 2020 13:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CISgtwx6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgETNSi (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 May 2020 09:18:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20671 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726570AbgETNSh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 May 2020 09:18:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589980715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OHGYUKfvJ5M3zCTUp9P9l18wl3V5wBTvg9xasGTVV6E=;
        b=CISgtwx6Zn63+k4YefMDYvYKdVoUj2TkXy0QWIvrGuxmYPtS1In+dRHgMPNwWuszNxipoi
        XlAauFKIMutBWjcT5HwZkUlcht5LARSbwzpvh/E/a50GS2tc/geSx4OmZiKQMUFdmMA4Yz
        4zSV41Yup8X/cXpHGhlPGXsz1mIVfFs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-w2Eb611aNJiVTHh8dLMl_A-1; Wed, 20 May 2020 09:18:29 -0400
X-MC-Unique: w2Eb611aNJiVTHh8dLMl_A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E003B1005510;
        Wed, 20 May 2020 13:18:26 +0000 (UTC)
Received: from carbon (unknown [10.40.208.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C3562E05A;
        Wed, 20 May 2020 13:18:21 +0000 (UTC)
Date:   Wed, 20 May 2020 15:18:19 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        magnus.karlsson@intel.com, jonathan.lemon@gmail.com,
        jeffrey.t.kirsher@intel.com,
        =?UTF-8?B?QmrDtnJu?= =?UTF-8?B?IFTDtnBlbA==?= 
        <bjorn.topel@intel.com>, maximmi@mellanox.com,
        maciej.fijalkowski@intel.com
Subject: Re: [PATCH bpf-next v4 01/15] xsk: fix xsk_umem_xdp_frame_sz()
Message-ID: <20200520151819.1d2254b7@carbon>
In-Reply-To: <20200520094742.337678-2-bjorn.topel@gmail.com>
References: <20200520094742.337678-1-bjorn.topel@gmail.com>
        <20200520094742.337678-2-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 20 May 2020 11:47:28 +0200
Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com> wrote:

> From: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
>=20
> Calculating the "data_hard_end" for an XDP buffer coming from AF_XDP
> zero-copy mode, the return value of xsk_umem_xdp_frame_sz() is added
> to "data_hard_start".
>=20
> Currently, the chunk size of the UMEM is returned by
> xsk_umem_xdp_frame_sz(). This is not correct, if the fixed UMEM
> headroom is non-zero. Fix this by returning the chunk_size without the
> UMEM headroom.
>=20
> Fixes: 2a637c5b1aaf ("xdp: For Intel AF_XDP drivers add XDP frame_sz")
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
> ---
>  include/net/xdp_sock.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> index abd72de25fa4..6b1137ce1692 100644
> --- a/include/net/xdp_sock.h
> +++ b/include/net/xdp_sock.h
> @@ -239,7 +239,7 @@ static inline u64 xsk_umem_adjust_offset(struct xdp_u=
mem *umem, u64 address,
> =20
>  static inline u32 xsk_umem_xdp_frame_sz(struct xdp_umem *umem)
>  {
> -	return umem->chunk_size_nohr + umem->headroom;
> +	return umem->chunk_size_nohr;

Hmm, is this correct?

As you write "xdp_data_hard_end" is calculated as an offset from
xdp->data_hard_start pointer based on the frame_sz.  Will your
xdp->data_hard_start + frame_sz point to packet end?

#define xdp_data_hard_end(xdp)                          \
        ((xdp)->data_hard_start + (xdp)->frame_sz -     \
         SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))

Note the macro reserves the last 320 bytes (for skb_shared_info), but
for AF_XDP zero-copy mode, it will never create an SKB that use this
area.   Thus, in principle we can allow XDP-progs to extend/grow tail
into this area, but I don't think there is any use-case for this, as
it's much easier to access packet-data in userspace application.
(Thus, it might not be worth the complexity to give AF_XDP
bpf_xdp_adjust_tail access to this area, by e.g. "lying" via adding 320
bytes to frame_sz).

--=20
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

