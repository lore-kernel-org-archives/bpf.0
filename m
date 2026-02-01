Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EEE2D8DBB
	for <bpf@vger.kernel.org>; Sun,  1 Feb 2026 09:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769936489; cv=none; b=Xas4KnNI0Hc3dn9uG/Ek3rsG3lBf9ofyMwQvBgSjIiXb3dPyHXXYPqGuM53uc/3c2ZBuDmbjFzh4Xtjv7ra4rsmUewT+cAMPa/lBRhbiYff5sJdlsPrE69aQaxDGPGflA/1/m6ieW7ksHGyaoMLOkL7302FMuSfpKOw0MmEs0uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769936489; c=relaxed/simple;
	bh=uLCjGvitM7MZI+iiZOhsAyamc3vLUAP3Bnzyj3zmxmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/KscdZdfoxuoMXsw2/21F/qNhbPvxxlduKnGrbnBes/fLUKV64X6+/VHgHJYu96/bFgb1qTJvfYe+GB+Sjo3DfBilpz/B4rWQg5wf3rDpqTp7XSaDf7guuSi8MH92sNyT2DMnu8sPvGVaXRPiyG1cI4pwqmznCImnWU/ZVZCmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XK9lUsSg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=U1PRsJnp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XK9lUsSg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="U1PRsJnp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769936485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PbdMtd8ZV0Hoqg/gvmWguCwsRV3oQaDigUGA5FFlPEw=;
	b=XK9lUsSgv5NmGKEW2yTbUcVZFlIN3gn6FVpOPZzTGj2iAkW6M30LRWxWBpmXbgMYy2zEx4
	UmOIm8j8nIfsLX05vipwZJ4njvGoLoJmOMchwA3pBhCJKiaE7YOXEPMnz0TBmZOaKHP1uf
	Gh9ewvy+u49vmQVe2LPZZ50PPddgPA0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-_oKcRYVhN6Kbrbsl_lNzvA-1; Sun, 01 Feb 2026 04:01:24 -0500
X-MC-Unique: _oKcRYVhN6Kbrbsl_lNzvA-1
X-Mimecast-MFC-AGG-ID: _oKcRYVhN6Kbrbsl_lNzvA_1769936483
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-432db1a9589so2316621f8f.0
        for <bpf@vger.kernel.org>; Sun, 01 Feb 2026 01:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769936483; x=1770541283; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PbdMtd8ZV0Hoqg/gvmWguCwsRV3oQaDigUGA5FFlPEw=;
        b=U1PRsJnpLnDt6xCnPPIfMra8LELIvxROw7qE+hyB2URGbVFeGBJYqSDEMOJTQHzdz0
         sDU/W86iLqgbUjCCjzfMTgiU1RUqOMJX4JYQ0GkjXnFS9s+vz2IFyaZW2m+2IpTBPcnL
         aUkKcz2iMSl9NkFKMkFjzOqGutRASDRxfHCHm15rFQHSvFKhQOG87K8K5aY3Acvgq2jM
         tq0Pm/CPPV7qmTU98/vkqmKTyQXUECl0Elpu9fFtMSj3Sq42fkHau7FchxSsoW7j+wny
         +R1Zm2Eg7mDrF1pwYypkCy5597RqUFl3s47MSvwzspuQwKubwTmJnQjzE9Ny1gG/YxQ8
         sDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769936483; x=1770541283;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PbdMtd8ZV0Hoqg/gvmWguCwsRV3oQaDigUGA5FFlPEw=;
        b=UmXLBCUHMjDkOMMdD3Nkivf04DhTaYF6u3iOVnKkcoisIrRuHNmz97+4TSqzGqw6x3
         AgWwUsKKAx5tVIfj3c+YSKt4Lq7ECnoa5ijv0oU3yEf1OZePHRrUbY2wE2SLCiiB4IKO
         HZ4lvCdPw4eqSQEkdwkYCxumd+8HxhSD94KamXJNbqjeaAjULJRcaqdEs4lPPPwpI56a
         HyWihoa7xPh9AhXwYEp5WKkY6Y42TAa4Gc4CGafASd9RwNSHgrpHgmTSA7FazN3Kk7e3
         IZxlWfFhEcUH0MbwbQ6RLgXkX7xi3hFT3yhL+vPtM0AHegOnX5tRcbW2vVeH8hsKi41w
         IMLA==
X-Forwarded-Encrypted: i=1; AJvYcCUPLBEziApKYM1VMwoQQ+q+LX/zbBoNdBeuKybCAceVcWsIqgrbmKu+heT5vdvO3wYTHNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnEicJq9zrTC/G6Gtg7oiJj7TueTcdr2BG23f43MNPBN9QYMK2
	yT8CpYyVYnhJO3W1hMDXJwPz885ECGYrnZ8/OXoBCqgP5J1eABKV++ZP3ZIyy9GoxJIGEUzTQB9
	u0xQpe5DHGfDK/7a0RYcXuHEhMNg3JlvsJWHL4AfisckM/+Hpg8oQSA==
X-Gm-Gg: AZuq6aIkvyCdXknizKyf+PZlngsvNrE00cs3MwuhD901pIIuUkn0vTfERAccvq0Ev6O
	9pn9s3uMb/OYyfweuZGC3tI98i2zliuUMcw1+iL8kNUgt4Um3xm1C3NwpZK8hQKi3CZad/shD0Q
	ju+qEgx79FfaHRzvnx2UPCZkSaxTfSXytGvq9YXHtl6T9/90NwkvZbsuxQwlJuUe9CEvLcd6jHu
	eHJ3wKl2wDxOD1dN6udnHfI7PtiEDIZaT/HM6bruHGENtKkyaXTgCILyZUb5QMd86eYLIk9h31C
	OtS5LkkSvdrbCnGxFNZZSsSZc5KGrma2n7DeNoCwdOdvSeDU0wx1XYagYi2NhNLeAZsUIXn7TOq
	ctbsq1wfa/lVJdK6G/UyykfbUB4uOh1bmOQ==
X-Received: by 2002:a05:6000:2883:b0:430:f742:fbb4 with SMTP id ffacd0b85a97d-435f3aaea5bmr11593857f8f.43.1769936482902;
        Sun, 01 Feb 2026 01:01:22 -0800 (PST)
X-Received: by 2002:a05:6000:2883:b0:430:f742:fbb4 with SMTP id ffacd0b85a97d-435f3aaea5bmr11593790f8f.43.1769936482295;
        Sun, 01 Feb 2026 01:01:22 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e131ce70sm36590005f8f.27.2026.02.01.01.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 01:01:21 -0800 (PST)
Date: Sun, 1 Feb 2026 04:01:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: chia-yu.chang@nokia-bell-labs.com
Cc: tariqt@nvidia.com, linux-rdma@vger.kernel.org, shaojijie@huawei.com,
	shenjian15@huawei.com, salil.mehta@huawei.com, mbloch@nvidia.com,
	saeedm@nvidia.com, leon@kernel.org, eperezma@redhat.com,
	brett.creeley@amd.com, jasowang@redhat.com,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com,
	pabeni@redhat.com, edumazet@google.com, parav@nvidia.com,
	linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
	dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
	kuba@kernel.org, stephen@networkplumber.org,
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
	andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net,
	liuhangbin@gmail.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, ij@kernel.org,
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Subject: Re: [PATCH v1 net-next 1/3] net: update commnets for SKB_GSO_TCP_ECN
 and SKB_GSO_TCP_ACCECN
Message-ID: <20260201040043-mutt-send-email-mst@kernel.org>
References: <20260131225510.2946-1-chia-yu.chang@nokia-bell-labs.com>
 <20260131225510.2946-2-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260131225510.2946-2-chia-yu.chang@nokia-bell-labs.com>

On Sat, Jan 31, 2026 at 11:55:08PM +0100, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> No functional changes.
> 
> Co-developed-by: Ilpo Järvinen <ij@kernel.org>
> Signed-off-by: Ilpo Järvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Subject: comments?

> ---
>  include/linux/skbuff.h | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index e6bfe5d0c525..30a8dc4233ba 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -671,7 +671,13 @@ enum {
>  	/* This indicates the skb is from an untrusted source. */
>  	SKB_GSO_DODGY = 1 << 1,
>  
> -	/* This indicates the tcp segment has CWR set. */
> +	/* For Tx, this indicates the first TCP segment has CWR set, and any
> +	 * subsequent segment in the same skb has CWR cleared. However, because
> +	 * the connection to which the segment belongs is not tracked to use
> +	 * RFC3168 or AccECN (RFC9768), and using RFC3168 ECN offload may clear
> +	 * ACE signal (CWR is one of it). Therefore, this cannot be used on Rx.
> +	 * Instead, SKB_GSO_TCP_ACCECN shall be used to avoid CWR corruption.
> +	 */
>  	SKB_GSO_TCP_ECN = 1 << 2,
>  
>  	__SKB_GSO_TCP_FIXEDID = 1 << 3,
> @@ -706,6 +712,14 @@ enum {
>  
>  	SKB_GSO_FRAGLIST = 1 << 18,
>  
> +	/* For TX, this indicates the TCP segment uses the CWR flag as part of
> +	 * ACE signal, and the CWR flag is not modified in the skb. For RX, any
> +	 * CWR flagged segment must use SKB_GSO_TCP_ACCECN to ensure CWR flag
> +	 * is not cleared by any RFC3168 ECN offload, and thus keeping ACE
> +	 * signal of AccECN segments. This is particularly used for Rx of
> +	 * virtio_net driver in order to tell latter GSO Tx in a forwarding
> +	 * scenario that it is NOT ok to clean CWR flag from the 2nd segment.
> +	 */
>  	SKB_GSO_TCP_ACCECN = 1 << 19,
>  
>  	/* These indirectly map onto the same netdev feature.
> -- 
> 2.34.1

