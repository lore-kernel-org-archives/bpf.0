Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA79B3D45FE
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 14:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790691826; cv=none; b=JU/D+bai6rAiRvgJO/cD1pS1d0PSbAJ00+dBDKYBlPr/0xjMhxCGsFvHbwGxnksgS+QcwCHoaq7y9SVeoTt9AhsV6zPi/HkI7mvTf8sI70vDLXWCSpWglfeLUN3vz2gRIqdKMupoZagDaZj6Ih1IAUWfd8trcS7Phjl9M75XkZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790691826; c=relaxed/simple;
	bh=YFg442dzmYLAsAia1lyH3HC9c9oEaiM/RKHPe9FKX+A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sPrqVM/pW/al6dOel8wsGwh0ZdyMgteAAfyRlD57qpl0cJYvMVMrXuqYAAtdeES0KEHTw38l+LXpBjmZ7ah70lHW5CWbUMMNxUyhFrXc7KCCE+rd9sA9zDQm2QtHBH0ScOYHP9uEa+tGSq6r9WWldZ5N4rrG6+JlHW2rG4CddAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WKqg66mH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FtqM8gch; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WKqg66mH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FtqM8gch"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790691823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YFg442dzmYLAsAia1lyH3HC9c9oEaiM/RKHPe9FKX+A=;
	b=WKqg66mHeSrHia1FOPYarywABjz5JB+fzEIqY9Kgn60wjwYVPxn7xCZVWjb9pZtaGiMghw
	8NeWQcaOWRHqktl58ZJjcZt3JuCOR85Cb45SGzHCF4WNfGLFEI/e0s3foomWZOajf21koZ
	VRG5/gkRll91gw+Us5n4mi/LRDlmepw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-CDhn8UM4P5qE4ee8t3JGgA-1; Tue, 29 Sep 2026 10:23:40 -0400
X-MC-Unique: CDhn8UM4P5qE4ee8t3JGgA-1
X-Mimecast-MFC-AGG-ID: CDhn8UM4P5qE4ee8t3JGgA_1790691819
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a009f82bedso14636065e9.0
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 07:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790691819; x=1791296619; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YFg442dzmYLAsAia1lyH3HC9c9oEaiM/RKHPe9FKX+A=;
        b=FtqM8gchF+ManqU9ls2eCinTJbMR7qlydUZQ+c0yY62zIhZfVgOJNWbYo/kWufCoE8
         SAYysEnlLGLhhPcESPqLMrjY74KODwIyTqQgOhsKxPrwXYAND8AmQppBBBdicabMBRLu
         pm1ps3GWAgAAENzl7sXT/2tIfCbH4oqV5UqMGwvj4n4jaAR86+tID9exwdc3KGEIYh+B
         WL/ilTyNq30bgbmXfRTnBW1Ym2mJPdnTF9uhY4qHk2jy60UWwU0R+a/IkeC7U5rPQimr
         xI8ODD2RhgodcnlK4gQr0FbmwZqMgdDy8O+Ip8zyWSB3vfGUeiVUK0YHLH/RurKGnKcE
         yMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790691819; x=1791296619;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YFg442dzmYLAsAia1lyH3HC9c9oEaiM/RKHPe9FKX+A=;
        b=AoAStGmVb+psQiHdLV+ftGCxdcsAZ46CLKiFE753EheQXF7GAetL0uRpgmplgupOO4
         pXBJ0LY+i4VlXd+6Bn7wl5Uq2kceayq7nNOj6gMgAbZW9tTr7K3CWCrm8Xo2yjbHbLbV
         uw/Tv9QLynIm7H2Pqr8qv4u9Ys3kDOOfjZyMUrWLiGsupk9YeM0JtXoEJOTlsIh8nhuB
         DD4P8n9VFfw5W0NfghDZmc8P5HmLXCO1a/hgfw47sAfZcCZGY18PT9lkvyP2z6F0VvqN
         HAhQj5fcGiQsaFMzpY3h4cHOwyJ5L879Dhw0SbeCuzQ0GCOJHISpfiGjsQKToLnJazFN
         yOrA==
X-Forwarded-Encrypted: i=1; AKwUvBynLIO6e8x8vmQmi4+a7HPC0iS6Rl9B1Sdkwn2a2SEI7eJ03rEznGE2LrGlOdnGwPde6bs=@vger.kernel.org
X-Gm-Message-State: AFuF++lQbWYle4kw+SMP27FbRebiEW1I6teUkcQZ+T5+HRqd8VWh8Z42
	dhHKvL8+8CFILCvvYXmXmldYGEci21Uq16f9rZ4LAp4ErcDLMq2Zn/tozVXJhrub+Gkj6/IrfXN
	W8eMEvnQnQWFugQpc5xVy/3oGFNuADpvF0QYwb7diXFLe4dtBb1hAcA==
X-Gm-Gg: AYBFou2Xch0zwHvCS2Pt/jF5H/Qze1zR04XsqAuG3nNy1hhvFSM7z66Ik7ttJUcgsny
	wG/NYMffuk324JJ2SLGSYotAtFAndOykS00YLpON27180jpjGAWBjwScpGsN1V5S9zQsBcpUYfi
	jxTvbh/M3eGE9JkU1+9m7Ywzk3ypRjmTx3So3vAoqjrp+nkCkZYqLW8k228z6xOIb2BubbSd0LZ
	LZB1c8JZCs0YQAjzBB4yK8s3O5rmHcEJjmLk6KXGlVXGskWW/e+1HkBILgxqzqOV6p9gt7jbDYA
	lL9/VdCpEBt45m11ItLJkrVRNG543L9pF+SyVela40697UJYMDB6HcSuJTbocyBu810BcVPAWCU
	1kabtApwHuhD6lTg6evQoSgwZ5g==
X-Received: by 2002:a05:600c:8b32:b0:49f:fc13:189d with SMTP id 5b1f17b1804b1-4a00c6813dfmr53749125e9.1.1790691819353;
        Tue, 29 Sep 2026 07:23:39 -0700 (PDT)
X-Received: by 2002:a05:600c:8b32:b0:49f:fc13:189d with SMTP id 5b1f17b1804b1-4a00c6813dfmr53748395e9.1.1790691818907;
        Tue, 29 Sep 2026 07:23:38 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cf9dd27sm83481025e9.2.2026.09.29.07.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 07:23:38 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 3D5A3A1017A; Tue, 29 Sep 2026 16:23:37 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, Marcin Wojtas
 <marcin.s.wojtas@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, Lorenzo Bianconi
 <lorenzo.bianconi@oss.qualcomm.com>
Subject: Re: [PATCH net v4] net: mvneta: clear XDP pfmemalloc flag between
 frames
In-Reply-To: <20260929-mvneta-xdp-clear-frag-fix-v4-1-1e63b25eeed8@oss.qualcomm.com>
References: <20260929-mvneta-xdp-clear-frag-fix-v4-1-1e63b25eeed8@oss.qualcomm.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 29 Sep 2026 16:23:37 +0200
Message-ID: <87h5j8jfva.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com> writes:

> mvneta_swbm_add_rx_fragment() sets XDP_FLAGS_FRAGS_PF_MEMALLOC on the
> xdp_buff when a fragment page is a pfmemalloc one (page under memory
> pressure). The xdp_buff is reused for the next frame, but only the
> XDP_FLAGS_HAS_FRAGS bit was cleared at frame start, so the pfmemalloc
> bit leaked from one frame into the following ones. mvneta_swbm_build_skb()
> propagates the flag to skb->pfmemalloc through xdp_update_skb_frags_info(=
),
> so the skb of a subsequent fragmented frame could be wrongly marked as
> pfmemalloc even if none of its pages are under pressure.
>
> Clear all the xdp_buff flags in mvneta_swbm_rx_frame(), which is invoked
> for each new frame, instead of just the XDP_FLAGS_HAS_FRAGS bit.
>
> Fixes: ed7a58cb40bd ("net: marvell: rely on xdp_update_skb_shared_info ut=
ility routine")
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

