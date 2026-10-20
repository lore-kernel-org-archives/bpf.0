Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792540274;
	b=5WGllmVkX8buIT8xfGJPSewPB5g8pJBTlJ0Cgx8KHi99J4/K84R9o8Kqa3f7Q8tuy61o
	 TMucudy0lhp+KN+MdCAxvy36i8CxMX9RU0ibS0dGtKobSRnsT+z5Qi3+qubSNlrI6Zzav
	 qVUnNYtecfr1FeLMhQPtM2LsonTRz8fP4gSvibNsPI1BXV0KwOSzXsW4fydnKajId1AD3
	 dClbk6VuxUBr/3AdyB+FhzFMR5qs3T8O7twW3g3TnkvVGlt6abZ0P5C+/ZOuCzryBicxI
	 i4mGPDzMoi1gJvQRAX7rxcepdJkZ/K3c74KlScouF8sFWpfJz/C44ow4M6QMDrPEwNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792540274;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=PehXZcrvadP5J4z5HJ+PHlJPo930ZmM8+dDrOQ32K8w=;
	b=h6NlzLOna3FeF4m4ZhfOG4b4MWZ/EnjbBnNBRVBYLTqEv/C4QckXZTBljcdmG8X0C3md
	 83+aNbLc5hOoYAOVnclBcO8Ii9xJ3XWDkR3cm5cn6qZsyBpZRreNQU+X2JvVW2A1w5Wsj
	 8Usm2vE4JkbeeKk/rQ8fr4RvvuXteZ5xdi4rEzDvoaoHn7+v98bxoVr05UgqVDwcg0gpx
	 /jB/6GVwIuelpu44Vn6SMEcdJmXcN5ffFkJiAD+kiYVSoQ4WEYWFQm+1+uVcVM3D3pClu
	 MjfmzA5FVD8xHYRUruvCuB0H17U5mnuiBj2sYAfXG9Rqo3dWfC7nz9WGU1Kn+vySuyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ebytfI+T;
	arc=none smtp.remote-ip=74.125.229.6
Received: from mail-dy2-f6.google.com (mail-dy2-f6.google.com [74.125.229.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3BA606A31A
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 23:51:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF3BA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ebytfI+T
Received: by mail-dy2-f6.google.com with SMTP id 5a478bee46e88-35adc681e1aso185372eec.0
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 16:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792540273; x=1793145073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PehXZcrvadP5J4z5HJ+PHlJPo930ZmM8+dDrOQ32K8w=;
        b=ebytfI+TX7POzxtndJOrL89prTf0QmGSvG89QrvM90w7uvH7cJObqLg3xhAQHEN8Lb
         dva+vyjKAvXs3R6fxm1mvadLqfL0vyzyBB6XNrjz4Xu9j5ElInUEdm1BcruiZB1vnFp0
         /4T7iPe0+jVamDOJayyRucpmYfSMuPNCl5PFNrYXrxmJn/MDqfNUHJoFssAppOzMlEBH
         PC2CoSizMExbZdTDQwEY6CQTgAaossujMaEAg5iBs6e0QKNvanjeaKHEuZGKQTS75Z7i
         p6hHDu8rfdHXCsnmiCO648sE60I8T4WboBlbU7eOzAfbHuqKcWNES6gldQWMGW8sqmuZ
         8dhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792540273; x=1793145073;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PehXZcrvadP5J4z5HJ+PHlJPo930ZmM8+dDrOQ32K8w=;
        b=bodVIQjbh/J7H6bTHEB/7JeieteLN2gSp3/HbDxOUyrm93d1nzvrjCiXS5n6d1i2AJ
         jKDd5ZVmLhmd6F6KJyQfIhTd0CcDmA+gjRp6gusqCO3GVLuCbtO9ZlB0epEsOcUMULjz
         zNTExqxgT3s4CfdTwi226V6dWXclb/qehM0A2a2MU3biSU/+8wMmuDAcdEM0XCqok8uq
         dytug34FA2ZH3HlRs0R2JWfAVXkR8h4uU0nkpqwKVg9zeKLkwCxxNnVUCkiN7A0bwiCA
         9EdfU0Yo8GqQycnbuCqjce+rlcu4Wal9p68uU2IydpHUEGYHJJaCKcCWMkGdIxMBWQlT
         v6OA==
X-Forwarded-Encrypted: i=1; AKwUvBxWUAl/Qqwa89aAsR6ot+TN6bL/fmJ69Qt6DwqOg82NK2PJ89vSN/ggqciQNP6VUKR8RRA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLmzv1nX4ylio1qyODTORo0WfE8qDLz76F/BGnpgeoYU84g1I0g
	V1yNKAdJZYiFFXOfO/ffVy4LYZGnbLI7eT4KM0tJsfJiWbfPjp2uwkYO
X-Gm-Gg: AYBFou0KddErs7h/EORQzZm+OPWm7HrDaQocvqT3dbRa0HK064y513PQiWH8Qt/McmS
	vshi3mZFksiF/h68nBPPNZH5IUolUHis3/PXt/WZPpi/EHa3ZoGBqzQ4OwXlOWspTjHeKb7139d
	b/F9mvkzKwKfcDOszn/XAQDmHK+r+YiOuYOpZENPmx8iPSarwqaMMXGXfVq+g7THRI1EMR12y3X
	gQUrSGWteTVEySViqnHn6vJQ0NPh1GRL52t7SG5pQmjxU6HqlTedmIVeOVQ4lMmFVcbMsdf+aWv
	n8sruDTU/Jen5CBe9Sk2wk2RNrO78CFP6Qqo3q1zV6FtKNDOBmIvmewjTRZJPUSNyB9Mfo0etc6
	Cu033kVXF15p8gccXFA3IRhXXn2k+VN7LqemPfSAYUeu1VsZm8/1zhcL0szFE1uqDQ6h2IcpRhR
	aSI05Ju5MI6qysdqNLnclHo/AVhyQpQHg3CcVd6EyU9a306a3GAcal2HbyIyoEbsRwwbvwK8XZU
	5McNnk1msfxp/VZNWU0zZ4IiwD9BJ+TCfJ/GTtNRGkESWqmeA==
X-Received: by 2002:a05:7022:b90c:b0:14d:baf5:c40f with SMTP id a92af1059eb24-190a465c250mr427669c88.14.1792540272758;
        Tue, 20 Oct 2026 16:51:12 -0700 (PDT)
Received: from localhost ([2a03:2880:9ff:6a::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-190e29381d9sm149758c88.18.2026.10.20.16.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 16:51:12 -0700 (PDT)
Date: Tue, 20 Oct 2026 16:51:00 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Vijay Nag <nagvijay@microsoft.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, willemb@google.com, tariqt@nvidia.com
Subject: Re: mlx5: stale skb encapsulation metadata after native XDP
 decapsulation
Message-ID: <atf9BogSMMrUenOQ@devvm16445.scu0.facebook.com>
References: <SETP153MB2368281B3138379C3F88AF71C4672@SETP153MB2368.APCP153.PROD.OUTLOOK.COM>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SETP153MB2368281B3138379C3F88AF71C4672@SETP153MB2368.APCP153.PROD.OUTLOOK.COM>

On 10/20, Vijay Nag wrote:
> Hi all, 
> 
> In a setup where native XDP performs tunnel decapsulation before TC ingress, I'm seeing an unexpected interaction with RX checksum offload.
> 
> XDP removes an outer IPv6 header using bpf_xdp_adjust_head() and returns XDP_PASS. TC ingress subsequently calls bpf_skb_change_tail() on the decapsulated packet.
> 
> On mlx5 with RX checksum offload enabled, bpf_skb_change_tail() returns -524 (-ENOTSUPP). Tracing shows skb->encapsulation == 1 at TC ingress, even though the outer header has already been removed. Disabling RX checksum offload makes the same processing path succeed.
> 
> The following Linux v6.6 code paths appear relevant.
> 
> In net/core/filter.c, __bpf_skb_change_tail():
> 
> if (skb->encapsulation)
>     return -ENOTSUPP;
> 
> In drivers/net/ethernet/mellanox/mlx5/core/en_rx.c, mlx5e_handle_csum():
> 
> if (likely((cqe->hds_ip_ext & CQE_L3_OK) && (cqe->hds_ip_ext & CQE_L4_OK))) {
>     skb->ip_summed = CHECKSUM_UNNECESSARY;
>     if (cqe_is_tunneled(cqe)) {
>         skb->csum_level = 1;
>         skb->encapsulation = 1;
>         stats->csum_unnecessary_inner++;
>         return;
>     }
> }
> 
> My current understanding is that the CQE tunnel classification causes the subsequently constructed skb to retain encapsulation metadata corresponding to the original packet, even though XDP has already removed the outer header.
> 
> Is this expected behavior when native XDP decapsulates a packet before skb construction?
> 
> More generally, what is the intended handling of checksum/encapsulation metadata in this case? Is there an existing fix or recommended way to handle this interaction?
> 
> This was observed on a v6.6-based kernel with an mlx5 VF.
> 
> Source references:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/core/filter.c?h=v6.6
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c?h=v6.6

I don't think we have a good answer for this, there has been some recent
discussion here: https://lore.kernel.org/netdev/amEojEGsIGkUjIWn@devvm7509.cco0.facebook.com/

In general, from my POW, we should not carry most of the rx metadata into
an skb when there is an xdp program (until we expose some helpers to the
xdp to change it). For mlx, we might want to skip that cqe_is_tunneled
branch in case of xdp, you can try to send a patch and see what happens :-)

For more recent kernels, and for tc, there is bpf_skb_adjust_room helper
with gives you more control over these fields (in case you can move your
decap fully to tc).

CC'd Willem who might know more about csum+encap specifics and Tariq for
mlx5.
