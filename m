Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795459761;
	b=q8yWhP7l7i+DEu69uNENVpN9uMRfMhHV2HMDkl+hrHJZ8z6zqpHN0uCFB12uZfLgi9TA
	 LBSs+yS8YjeU93B/hUP7t0GIStzX9GMqKEV1OD+JPnc/oZW7fXQYHOTFnR+/P+KTNFgO1
	 dsydr+eFNPLKNlhvRQ7TEdgJjhaCLtzprI+JppNxZTj0UZ/EAfYzCeJ4r3IlR+YTv+Y7l
	 db326XsfIZE0tr1lOL8QKPWPs1vaoAS7vG5dz8xAN87n326zKGKtcDdgXVEULbhy1IPy+
	 TKfHy2yj/+RhzzUUN+HM6u3vOnqETdjps7Q3cboPTMczl4ATfNz4Zxv6tiV9R7oA56A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795459761;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=yuo3RMT5uLMlvZjj6lcxSmCTKfmm/IW4Uhs7jIPyUXI=;
	b=xk1OkrR0qEF2F0Xj4hgBm6/4YFQ6R5XKdVIAK0OssN/VpQnBaQwP6/Cs0RpTG5BP6hEf
	 UCzozjqE5guNciWkqxQ3LUqOwpxYO/RQ6hG7SWFUhfOkbvZ6zdv9f3uK4Z13y1+kixqbz
	 eg9ap//K5OMYB/KXo9sqSWtwQ2p6TSnSHt10IEK6AYU+0m3DBaUBPwsUUvrtfMS5bjH4y
	 oIBfCkPTvH7YXpu8FP5YTjUREagZzEnR0JfG9rhiISvGX0OPXBT+55ITtalb3Sp1VH6MU
	 ZSOSY/3qzqYI1iWDkTmDZ4xzcHqf02e1Tf0vfHOLbLTPBjWeBF6ocbVi9Ynv37i99Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w7jGtki4;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFC4606A31E
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 18:49:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CFC4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w7jGtki4
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2f0414c1062so20193205ad.2
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 10:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795459759; x=1796064559; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=yuo3RMT5uLMlvZjj6lcxSmCTKfmm/IW4Uhs7jIPyUXI=;
        b=w7jGtki4ZNHDaxJHdNHINnnG1eGgqNHOmaOFMEhXYYECSTurvVVpvhOHfpRhGZfRVH
         dvdEgf1tPzTHs0Qvcg1TfNgJrlj81iO3dUjfhEd+4hx0gskPRnaDVIz5XRMXSAbHW9Yb
         TAsGuLwZETbA+nkI6b1cyr40k9QOlx+0e7/0Ciz0/K854rGqx9tkiGVOWBDa17jZLP0X
         dUH6ZqvsrmnKsiJLlwWQFDGKPZUtdVqCj5XxvTN3J9jf2q29J1c15RKMZ3cRtVW4PTK0
         Kb5ftldDi2ddAyVXx87wlBbRpe1ikddknZWHIeQBfA1QgnBFkC8UpRZS5h+l4dDDti8F
         ru7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795459759; x=1796064559;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yuo3RMT5uLMlvZjj6lcxSmCTKfmm/IW4Uhs7jIPyUXI=;
        b=RAyipslU40Y+QzzjKNRBG1I9XJ9n/hqHTcQ5OS9xRmH//Ayc/2z93hZIsdfeu5M1GV
         9xEa++uD6RDaxul7EXBtbz/Xv+YwpPafq9PBVX+acPsdVaRrAMSRIgiandqp0T18QnPL
         1iG0h+RGNSllnk5ssWcX+23XwKJIe5VPIEk2fc5pL8Pq1U0v3ZyiQG956jmgdDO0jZNC
         iklzfNV1np0nXgfEIBt2KSLv32KqPOc3cwB6+WejYsj0Mo3Xchs4VbvX4sVK2Y1Vqdge
         TKgVY5fbWRS6zu3g1suDWAZlG1aPB+igBFVwzWHEqSRFPAcVZthpuOUdwhLOsR6oB6vA
         gsmg==
X-Forwarded-Encrypted: i=1; AL+hErHQ0bA6NuOwPNFOmd0w/7V8hlIbBDj0C4TkIQKS30XIHLM1AvpQtbVaFSyY0RokDBu3f8Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z/fZOc2IZLNTIJ7cXrj1128q1fhIFmnmpGTt05qlZ8tEWV3n85F
	aE+7Of1F8tUDcobTk0LtbixmHSpfBbucc8LoxUR26+7RTePVy5gasqEC
X-Gm-Gg: AZFdTZeFIuePdGSqH969c6RYuYe39oVLkjsKK3+Gx798558O3Zb0UkJg7rw0RE0tXjX
	1J08j3CZ/X1DbcjxOmKvrsH77FSxODE72cV45ht+uZFLTJbrJwjW95d9Bde+Kddw61eyJYzUnyj
	XqQM+1bFCOy/jCZteegGBtQP0jBEAgK+BN0wJKHxp3q9pNseV5N7W9bvqOJy/5Sdtf94t12XZ8P
	PXvj4I02eOsy47RoeDTxw7cR5WLZotkQkyAE3HcOkEsZo2vnh8bEJzWZdnTOonakNU4DBSpyUMv
	jeRy1jtN8c8hUl8b0t40E0+OWDjUp3PLn9qCC/dvUR+VsFc9QOaqjBy8firssCvRmiTrHW18Zys
	3WzpA3LuiKWBXIcH8U+MXPTWGxguGpM/d5EtJYM0Kj5+MdGXLqXsSEH4VzoX/qTlXGKlEUYLxll
	bPl5pDcTf57qZdMk+DaXNu3+I9293jLS8CvyA2rjbMsZLrjVVU5X6o+wZt8lMXJzm5Jtx5pXjxY
	y2c5TL2EjlI+dFEMWatVv0SBStl3Fd0XPjRCw2+1nYL9V00pOVIetZ2B0KBo63kI7bPTpXJRhjQ
	FPyxLkhKhYd6nHPY/C1hEQ/zOzYAil+Exs8NYJFwjTATHm42M6xeUQziMKv/wiZITLnWV4S0Lug
	StiFG+XuxMEv+lOjR+Gbv2FCfezlgBd1WPBs4rXpE9GlciJ9aeZ6vM2+zzqTgmLp06bw=
X-Received: by 2002:a17:902:e80b:b0:2e9:9a19:c43 with SMTP id d9443c01a7336-2f03f118277mr119957685ad.15.1795459759098;
        Mon, 23 Nov 2026 10:49:19 -0800 (PST)
Received: from ?IPv6:2605:59c1:38c:400:82ee:73ff:fe41:9a02? ([2605:59c1:38c:400:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2f03f1207f1sm57374525ad.64.2026.11.23.10.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 10:49:18 -0800 (PST)
Message-ID: <3adef4b4d528780bae31f2fb02d0a08bf9c8ebd5.camel@gmail.com>
Subject: Re: [PATCH net] ice: do not report CHECKSUM_COMPLETE when an XDP
 program is attached
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Tianyi Gao <tianyi@cloudflare.com>, netdev@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
  Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,  Simon Horman
 <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Jesper Dangaard Brouer	 <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Paul Greenwalt <paul.greenwalt@intel.com>, Alice Michael	
 <alice.michael@intel.com>, Eric Joyner <eric.joyner@intel.com>, Jesse
 Brandeburg <jbrandeb@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
 bpf@vger.kernel.org, 	kernel-team@cloudflare.com, tianyi.gao@linux.dev
Date: Mon, 23 Nov 2026 10:49:17 -0800
In-Reply-To: <20261121012402.84848-1-tianyi@cloudflare.com>
References: <20261121012402.84848-1-tianyi@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sat, 2026-11-21 at 01:24 +0000, Tianyi Gao wrote:
> On E830, ice reports CHECKSUM_COMPLETE with the generic checksum (GCS)
> that the hardware computes over the received frame. If an XDP program
> changes the packet and returns XDP_PASS, that checksum no longer
> matches. The stack then checks the packet again in software and calls
> netdev_rx_csum_fault().
>=20
> On Cloudflare servers, an XDP load balancer removes the encapsulation
> of the packets that it accepts locally. Our production traffic hits
> netdev_rx_csum_fault() all the time.
>=20
> Do not use GCS when the ring has an XDP program, as mlx5 has done since
> commit 5d0bb3bac4b9 ("net/mlx5e: XDP, Avoid checksum complete when XDP
> prog is loaded").
>=20
> E830 also sets the L3L4P and checksum error bits, so the packet gets
> CHECKSUM_UNNECESSARY or CHECKSUM_NONE, as on E810. For example, a zero
> UDP checksum over IPv6 is marked as bad and gets CHECKSUM_NONE. A zero
> UDP checksum over IPv4 gets CHECKSUM_UNNECESSARY.
>=20
> Two pending series [1][2] give XDP access to the checksum status.
> Neither of them supports CHECKSUM_COMPLETE.
>=20
> ice_rx_csum() reads rx_ring->xdp_prog again after the poll loop ran XDP.
> While ICE_VSI_REBUILD_PENDING is set, ice_xdp_setup_prog() can replace
> the program without stopping NAPI, so the two reads can differ. At
> worst, a packet in that poll gets CHECKSUM_COMPLETE as before this
> patch. The pointer is only compared with NULL, so this cannot crash.
>=20
> Link: https://lore.kernel.org/all/20260715-bpf-xdp-meta-rxcksum-v5-0-623d=
5c0d0ab7@kernel.org/ [1]
> Link: https://lore.kernel.org/all/cover.1794281983.git.tianyi@cloudflare.=
com/ [2]
> Fixes: 905d1a220e8d ("ice: Add E830 checksum offload support")
> Suggested-by: Jesse Brandeburg <jbrandeb@kernel.org>
> Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
> ---
> Tested on an E830 (8086:12d2, board N31483-007, fw.mgmt 7.9.5, DDP ICE
> COMMS 1.3.63.0) with an XDP program that removes a UDP encapsulation
> header with bpf_xdp_adjust_head() and returns XDP_PASS. The kernel was
> based on 6.18.64, where ice_rx_csum() is the same as in net:
>=20
> - Before: 63322069 netdev_rx_csum_fault() calls in 30 s.
> - After: 0.
> - Without an XDP program, the port still reports CHECKSUM_COMPLETE.
>=20
> On an E810, which has no GCS, drivers/net/xdp.py, ping.py and
> hw/csum.py give the same results with and without this patch.
>=20
> Request for comment: I also prepared a drv-net selftest for net-next.
> It removes 16 bytes from the UDP payload with bpf_xdp_adjust_head()
> and fails if the packet reaches the stack with CHECKSUM_COMPLETE. I am
> not sure we want to enforce this for all NICs, so asking here.
>=20
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/=
ethernet/intel/ice/ice_txrx_lib.c
> index e695a664e53d..ad22d855436e 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> @@ -123,6 +123,7 @@ ice_rx_csum(struct ice_rx_ring *ring, struct sk_buff =
*skb,
>  	rx_status1 =3D le16_to_cpu(rx_desc->wb.status_error1);
> =20
>  	if ((ring->flags & ICE_RX_FLAGS_RING_GCS) &&
> +	    !READ_ONCE(ring->xdp_prog) &&
>  	    rx_desc->wb.rxdid =3D=3D ICE_RXDID_FLEX_NIC &&
>  	    (decoded.inner_prot =3D=3D LIBETH_RX_PT_INNER_TCP ||
>  	     decoded.inner_prot =3D=3D LIBETH_RX_PT_INNER_UDP ||
>=20
> base-commit: 92e97d7cffc7ec6adfa4699203c18b1ab0c8b314

I'm not sure this is the best fix for this. If we are needing all NICs
that support CHECKSUM_COMPLETE *and* XDP to report CHECKSUM_NONE in the
event of a frame being modified by XDP it really feels like we should
probably look at moving this further up the stack.

Otherwise the proper fix for this is probably going to need to be
spread out to far more drivers as I suspect the intersection of the two
is likely not that uncommon.

Also even if we go the multiple driver fix route I wonder if we
shouldn't look at adding a new XDP return type to indicate that we are
passing a modified frame so that we don't have every XDP program out
there forcing NICs into a state where they have to start turning off
various offloads across the board when they don't need to.

What we are going to end up with this current path is one group of XDP
programs dragging down the performance of others since they will take
the penalty for the ones that are making the dirty modifications.
