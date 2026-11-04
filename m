Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793793875;
	b=DQiZv+MnQl4qERwHn3EsYq8BSz4+2fMjIqWVcJ10fhlsTK1FdyQF7b2bMnfZNHbjttGM
	 J8Pvu8DBVdHGmu81IVM2yCb7EvLWGNIui6R3YsWCnIMrdjBKx6W+fXhRTpUkQ37xZkwyh
	 LhxM78fxWW28SimbdCCqLfYsjcY0Yupo2vwx9poYg0F39ImWc1f9AG6jCpk9aqxUovMG5
	 R15quaOyYLXgaEDS8Qd7xoRiclKO/Pp/nKvLHbv64rsYE892omeEXtfbUGZguRc6tKynq
	 /SZ6UnuO+Z/CWSho5qyERVNjKNySFd4ZkQc2UHJunfNCjagwYfxRmVYNXzMLa/ImgYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793793875;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=OUiJjgiBoxlCfwD7k2wmbIMBxvsfPqQZKBPmjCnOmAg=;
	b=AU08sxBd/Xki6g8yharDhT0Je/n1Q9Nz6QlREdpW+4nZLS2jn2f+SpN8nbJ4IhzwL+59
	 l/bc/sXMHv2rqFmSlmEddtyZ6vPyvad1f7lBxcLSJoDrqATFva7wJ/kzrQjmdVFHKQpRZ
	 UwUF9Wtleg1p9KxWghCbNdB6sRfbi3q4W9Kr9ZjvAIu4UfUVWG1lT0dCJz94MGdJcM0Zr
	 NTlMMmU9GPlLPRssO8h0i4jVzlHFcsup7DKPlSD4cWgT5CKOr0lXTVSsM5y0K+vtH4OO4
	 tHsv8IiiwX8lqpUsElAh6lpDGf8q0mq9kX1DVaLj72qLc9/lrcbNj+GabliZTk78C+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VLs5gJaK;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=XY4SsWNC;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DB4606A328
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 12:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02DB4606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VLs5gJaK;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=XY4SsWNC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793793872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OUiJjgiBoxlCfwD7k2wmbIMBxvsfPqQZKBPmjCnOmAg=;
	b=VLs5gJaK7bx8YTuEZMp56OkEoRmYZ9vkbXW0ZUO2IkulnY1Nn/+OZXJNQljLs5Nzc+G9YM
	sFFI1w+VxA4bCKT+YMwnTgOtIlcEhIQus/0+qLY1bp4762PZwm4+MTp0+RS6plAAaCsyV4
	oAgGsTT5qej6kIlyofvIdoPvOgrat7I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106--LNWRAdoNL6cpJANFEJvkg-1; Wed, 04 Nov 2026 07:04:31 -0500
X-MC-Unique: -LNWRAdoNL6cpJANFEJvkg-1
X-Mimecast-MFC-AGG-ID: -LNWRAdoNL6cpJANFEJvkg_1793793871
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e011829easo414076f8f.3
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2026 04:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793793870; x=1794398670; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OUiJjgiBoxlCfwD7k2wmbIMBxvsfPqQZKBPmjCnOmAg=;
        b=XY4SsWNCd/XyU4bYIRGZpysUegzvuvZjLZwC9/pkKxhwrQvlMsnFy1RNbVfp+sFKXf
         c0OGUwcXRMIFZ0LfYbkEHiGiEn930zYX1E6u5PRXkoViBsWCGQKrnEVgdawdALpC4gPo
         hqW+JhS4TmRElOr4HGCVNzELVq1D1Dtw44VTNT9DVaxzp7l20rkUqbTeefUXmiCb8FBy
         ig+m4gcVtIgasXfARf7/uF8n0l73dj7ImFfbN2BPSfYzs25EzNgu+tC6O8Iz2S4TJwPW
         CSFT0UkEFSbBQbL7MeF+5FrHHLxxIaqSfN95ZZYrZ1DkbGtuayqpPqR0RjoZf94GdPj+
         +/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793793870; x=1794398670;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OUiJjgiBoxlCfwD7k2wmbIMBxvsfPqQZKBPmjCnOmAg=;
        b=UdCpPh7W+lGjQtD/rtxY9f5fwIL5D/vwn9jr4yZaIUoeQKKFFR2ldLiWVYxkDicXp6
         fRBP4Co+czwnPQQMZbiXUS+sY+o1j1pgCpWz+kzOBjF7oTEp0INOj6HIVN7+XXK+U4pK
         UUQ4DqPUUeW29++ZaAlCqJVyon8LElUA3ZFSd6+gYFvFkPApvMQMcl6EJiGbrrZTdlSQ
         76gDGfiC2AxfrfrERJjHoWq8Jht9EhBLVj7plVu8JKa+DJN8q/nKsSWRVj0SAmsiFFjr
         sRWQkjlg0VdZJ2Rs/ArfJpy8cVout8GatoExgUxmwudtdscA6uyS1PXjCRkm+AWodjEG
         qjwg==
X-Forwarded-Encrypted: i=1; AKwUvBy3cI4gGx4gdP8U7a7Zv44i143pHhRbXa3fHq0VnbgpxYJYjG+Mm09Y/mQOgR7DMzitgoM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+0iAZAYTMyaS2nLQAxOknRgomMCch0F9mNGld0jQy3zNX1mEoR
	XW0aPTU152xzKSGPF+jS+oGoj4OA3ROhqbhG55mnjcf5lOhdTwPPl7TWVgv4oqMsnj18GwxW4jW
	peZdSTGdtoIaPEG9k4r6/fiX73VjfGoKmT5P5Zi9i71XNzY9Xs5hhIg==
X-Gm-Gg: AYBFou0vuj19Ro1yUkPftHtlfKrzH9mMQF4pDLqheZEkrTzC76frnwsPuo2veVTOxKI
	MLtp+LWuhUXCdLQMeFKs3Pn7w2x1J7RvB5B0Xz79Vy6DIgnmwiTdwAZCMy9g9C6xMEWAF+b76e9
	Nm3XkZec1fVtItlPBXD/TNb7s8SEtycbMkrpHKqEGGxcDwyWnS8c0eVHa8Zb3OsGxIBNEWg3MQR
	NksTx9YrTMPg+QlqkPhhygYAWb9SjnQLscuyGT5dP8495nL2yxk4dqoCVscxcYANqz2TGBxCO9d
	n2pftODUmSMRuWOnezbb+3aPv4EdmzwXmYIRFYMQ2yeLhwjMXw1T/3egA6TLJzepsVOGzVu74x4
	yjtFxjDuW+25mQTezkxBQZc/uRxImZ8Vn7NiVr0iRnw==
X-Received: by 2002:a05:6000:15ce:b0:487:1662:cf4c with SMTP id ffacd0b85a97d-48e6e2c155cmr25924777f8f.7.1793793870302;
        Wed, 04 Nov 2026 04:04:30 -0800 (PST)
X-Received: by 2002:a05:6000:15ce:b0:487:1662:cf4c with SMTP id ffacd0b85a97d-48e6e2c155cmr25924726f8f.7.1793793869640;
        Wed, 04 Nov 2026 04:04:29 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed0844e2sm2780896f8f.28.2026.11.04.04.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 04:04:28 -0800 (PST)
Date: Wed, 4 Nov 2026 07:04:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	dongchenchen2@huawei.com, bpf@vger.kernel.org, daniel@iogearbox.net
Subject: Re: [PATCH net] net: reject a negative TCP header offset in
 qdisc_pkt_len_segs_init()
Message-ID: <20261104070345-mutt-send-email-mst@kernel.org>
References: <20261101194433.2637113-1-alexei.starovoitov@gmail.com>
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
In-Reply-To: <20261101194433.2637113-1-alexei.starovoitov@gmail.com>

On Sun, Nov 01, 2026 at 07:44:33PM +0000, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> qdisc_pkt_len_segs_init() stores skb_transport_offset(), or the inner
> offset, in the unsigned hdr_len. A header in front of skb->data gives a
> negative offset. For an offset a little below zero, pskb_may_pull() gets a
> small length and succeeds. Then a 64-bit kernel reads the TCP header far
> after the skb and can crash. Further below zero pskb_may_pull() fails.
> 
> Commit 28a57fb2c5df ("net: iptunnel: fix stale transport header during
> tunnel decapsulation") fixed one source of such offsets. Other code that
> removes bytes from the front of a packet can leave the same stale header.
> 
> Return SKB_DROP_REASON_SKB_BAD_GSO for a negative offset in the TCP branch.
> SKB_GSO_UDP_L4 and the other GSO types read no header and still get a wrong
> qdisc_pkt_len(). On a 64-bit kernel only packets that cause the read after
> the skb today get a new result. Then __dev_queue_xmit() drops them and
> returns -EINVAL, but sch_handle_ingress() ignores the result. Their content
> can be valid. Thus the code that leaves the header stale needs its own fix.
> 
> Fixes: 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

and cc stable, maybe.


> ---
>  net/core/dev.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 3ac700d37e59..ccf4b02e08de 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4320,7 +4320,9 @@ static enum skb_drop_reason qdisc_pkt_len_segs_init(struct sk_buff *skb)
>  	if (likely(shinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6))) {
>  		const struct tcphdr *th;
>  
> -		if (!pskb_may_pull(skb, hdr_len + sizeof(struct tcphdr)))
> +		/* A header in front of skb->data gives a negative offset. */
> +		if ((int)hdr_len < 0 ||
> +		    !pskb_may_pull(skb, hdr_len + sizeof(struct tcphdr)))
>  			return SKB_DROP_REASON_SKB_BAD_GSO;
>  
>  		th = (const struct tcphdr *)(skb->data + hdr_len);
> -- 
> 2.55.0
> 

