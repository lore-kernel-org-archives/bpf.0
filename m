Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795805940;
	b=R2g1eKCQy4HI4zFd+l0ExmvsY71ByzB2MKDA7taA1ZQ1u0QO38vF1eO3hNTsInj4xXL4
	 kq6lLrlFPuIE6an1IJhEcj88X7O9OpzTo8EBKxtNrqlnMgomioA+TaRVvxQKUjw4MWLHu
	 T72I9fdNYIS3Dtt1pYdQYPz46PrfQt1gWXzfEIviBxQBR4eeb7PFkGnb2qWRsOt56gCy7
	 tNYdZ3UvcGCsGTQOfwaGb1NU0nkk5DMffUtiZ3hWX7Aim4aj7u742XtE4v6vN7okSuxxo
	 aVtdY125eAntBCPI5BqOiWsUYrZXhlSH09EgC4R8q0dOODC8AVdvBkyfLAkwV5cGtPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795805940;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=KbQUbOAxpb4rVHmZzp9pO+Se32gC8akOyQIXtIttG8I=;
	b=WZEkHQq1ZmKfJiJgzO3ZvVQv7Nc1l7OGtHLKYpudnZivLUx5auL7evgCQumwXbkShliE
	 dxndOv8woilU7sjDp6Fywv0lBxTpT2yRgU7GukNI32IIBPDw+K+cS0PgOUp+7yJU7SMqv
	 qs8vM8hChl61ktLYsgN6c7ZCTJN67SeGH4eSWn5fnHBlz6xzVTBTeQJJJxZsaUcGFXcry
	 0Gm9t73QqnZmnKtG1guuG8F18/foOPHqT+04IJRZ5PSfijTs/G+zbVL3xca1g+zvgrhXi
	 jJarbX9aYOpqmAe/+IFVd97PkKgFi1vmlKFRlzvx8aJ65rIc24r3pVMKGf6dl+ViBIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IjKDfnKH;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=SVkxJOwc;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AE2606A326
	for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 18:58:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0AE2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IjKDfnKH;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=SVkxJOwc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795805938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KbQUbOAxpb4rVHmZzp9pO+Se32gC8akOyQIXtIttG8I=;
	b=IjKDfnKHsl8k1lnV1GG/RXHpE7ExCLpKTA2jdK0hFHJRLqPqGL94fLDLGbstwY38dM5QeI
	wskU4bL0dA6pN6esF7qLfl9zzzy6eFFr0Dm8DKXaQGyRSBW1ClmI//P/WFRKohxf0Puhn0
	dL6YSx9e05KdH6igmU756Xu4E400yHU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-J17FP16QNTCbNsisFDoaag-1; Fri, 27 Nov 2026 18:58:57 +0000
X-MC-Unique: J17FP16QNTCbNsisFDoaag-1
X-Mimecast-MFC-AGG-ID: J17FP16QNTCbNsisFDoaag_1795805936
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48e011829easo4998958f8f.3
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 10:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795805936; x=1796410736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KbQUbOAxpb4rVHmZzp9pO+Se32gC8akOyQIXtIttG8I=;
        b=SVkxJOwcMjK9s+rPQpn+sQVX3Lbi75QxwYQZqf1pva5cEkZvAt1lMndrOVX5jhnX9z
         cD/4ntDol/dIExvxi8+/BHLE0+arVu2SXXO6rCKr/K2ElLXvgbNYO/CYxyLV206lee31
         6m94MGQHGnEUMh5ZOtkP1f82936GBJ6L9Hl0IN3A3umpVDIKd4JwFDq9gyFgS0GsqqDX
         z2+fTQ/Dj7Xz3ClXBIUVC6Rz+SIWksJl4fsZPlxe6wa8U4u42CzoKDJfvj4SEW9dbg2o
         rnDayg2IyFr1fRrYZlrMinZxm+xYOn5DRCqGNstLoklqFbrrJjh8fBbEtIO8X2iEUerN
         zZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795805936; x=1796410736;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KbQUbOAxpb4rVHmZzp9pO+Se32gC8akOyQIXtIttG8I=;
        b=ATq+Vy4xGnEAizqKUv9CXNCsgOve+tal/kbyf+avBBkM104YtxZ8bme/hPvZzJB6TX
         n9TdEf6PuCy+MrKAE70rweoAiT1leoefzUOt4TosT8520tGhHaz/S2NLbhCBYWR7qRdu
         T9XEUWIswBufTgrDILTzDeE8LIGD0tJsLhrNe/+Uy4cjRAIc5BBnu/lpaAmSearEvLl3
         RdjHCReJH3ZkCCImvQMUKLVNF+MuILXYO/IMD+prhCWvq6WzQ10SXuvRK/RboF8DXWC1
         XSDs5/mVoMW8O+N7HlfsP7KmF7+NYAqItIP/tQ+I94kmLGC2lVd5/CX376ytw5qoxySY
         lS+w==
X-Forwarded-Encrypted: i=1; AL+hErEnRjTw1yDb6eLBWeJ9x0qSJ3/++QEIED2PA7zDDn3HPDK3BGfgq4qzVFc6QWKZtil7TJE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+PuLyPMCVtWmfHsQkM20xKl4q01Zb2idIjP7KCfIPT52Qbl98n
	RHqLI89Wv15G1EufQ4kPbnXOji2gW/1oAvWXqGz/LwAivIEpPk25AUwPg89jyIfHENT7yZ7FY8m
	lBaPzvhWd2ivnSrSX6F0SmD+36o4Ucuet2QcGKF3uFBdSI62GaC4TWA==
X-Gm-Gg: AZFdTZftePP6SdrZJlIJ67+IMuB2KOiI+hbGLkN6XugTOxNlhX2FGYiV4rO3g7qVHUW
	Lze9GSKtQte4riGbdQGKzs94nKyVYcbqNRQ3xaSIZtnOOYdBlVxzoD9DV7iAegn/TpzaMOasj9E
	xONlvnTGE3Md2HMKGFy1oU974jjLaYMs+UlJeYKL1rNVBgerbh0neBU1vwbThWWG9Eo0R6btOPW
	yVLKK2lI1MkxoiP7q4cRpT6YpSgxT6KDlbMT0iJHVcmn8xhg3PwLn2C669CnFqoTNjFJgvUUpGm
	pZp3ksGtxDIrbAbNtD/GnAA+XMgrkqrKu36JI9cNwU9WoxT54of44PqDJrk1mslo2aqRGf6JLUf
	zdw6DiXDjgqvJUC6z7Q5Noc4vLXHHrCnFfscmwmQtJlyt
X-Received: by 2002:a05:6000:310b:b0:4b7:6dcb:e92f with SMTP id ffacd0b85a97d-4b76dcbea9emr28203586f8f.21.1795805935770;
        Fri, 27 Nov 2026 10:58:55 -0800 (PST)
X-Received: by 2002:a05:6000:310b:b0:4b7:6dcb:e92f with SMTP id ffacd0b85a97d-4b76dcbea9emr28203553f8f.21.1795805935295;
        Fri, 27 Nov 2026 10:58:55 -0800 (PST)
Received: from redhat.com ([2a06:c701:73fa:9a00:793e:eac1:d749:dcc7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b8b7888sm48971276f8f.42.2026.11.27.10.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 10:58:54 -0800 (PST)
Date: Fri, 27 Nov 2026 13:58:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>,
	Jonas =?iso-8859-1?Q?K=F6ppeler?= <j.koeppeler@tu-berlin.de>,
	Jason Wang <jasowangio@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] ptr_ring: add PTR_RING_BATCH
Message-ID: <20261127135832-mutt-send-email-mst@kernel.org>
References: <20261125152311.805325-1-simon.schippers@tu-dortmund.de>
 <20261125152311.805325-2-simon.schippers@tu-dortmund.de>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125152311.805325-2-simon.schippers@tu-dortmund.de>

On Wed, Nov 25, 2026 at 04:23:09PM +0100, Simon Schippers wrote:
> Name the batch size in which the consumer frees entries, so that users
> of a ring can size their own work to it. The next patch uses it in veth.
> 
> No functional change.
> 
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---
>  include/linux/ptr_ring.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> index 631c43fde4407..b851a9c170bf6 100644
> --- a/include/linux/ptr_ring.h
> +++ b/include/linux/ptr_ring.h
> @@ -27,6 +27,11 @@
>  #include <asm/errno.h>
>  #endif
>  
> +/* Consumed entries are freed in batches of this size, unless the ring is
> + * smaller than two batches
> + */
> +#define PTR_RING_BATCH	(SMP_CACHE_BYTES * 2 / (int)sizeof(void *))
> +
>  struct ptr_ring {
>  	int producer ____cacheline_aligned_in_smp;
>  	spinlock_t producer_lock;
> @@ -506,7 +511,7 @@ static inline void **__ptr_ring_init_queue_alloc_noprof(unsigned int size, gfp_t
>  static inline void __ptr_ring_set_size(struct ptr_ring *r, int size)
>  {
>  	r->size = size;
> -	r->batch = SMP_CACHE_BYTES * 2 / sizeof(*(r->queue));
> +	r->batch = PTR_RING_BATCH;
>  	/* We need to set batch at least to 1 to make logic
>  	 * in __ptr_ring_discard_one work correctly.
>  	 * Batching too much (because ring is small) would cause a lot of



If this helps, sure:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> -- 
> 2.43.0
