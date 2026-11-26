Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795718941;
	b=pd0Zl+1fG1QnIazIURSc3AJN/LJrEr2y8zyQZ/irUfqJpwBe/AgXjHZ1SMNDIWaOs2XE
	 mCK7xcHFwG2oYMXkExcMtTyb9iToleqAOKDLRFFlH6tEJ+MOtH+rfdvg/jRmivNWaQvsG
	 ZY0MOz+rY6veJxlu+J5/vvWmggn1zFHDvHZsgAnxkVqK7szRMMifBQnK1IGcDXE9CJxux
	 Xwme5seb86SjvdRyn3D+D39ykZtMIvX/GmeNJAaoxTvJLJM99SahGuYlBhSFnboahtRYt
	 DL1GahM6vXP6Z4WDTf4HMXYamvya2G3r7bhkGaZsZzoy3ToNY6r4mBnqE6bb2rCamqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795718941;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=fBtb0BMz5hkNQGeq8zzQt7EyteYPxkW8SwexoB3Gq1M=;
	b=L7I1HUJWa1LE7IQ8FCZBcOT39mJGiNvui5kYMlEck3FfsIp3ziYtaOsNGDPtcP6d8PAM
	 aATfR3bS+FAD8lVkIfVND/ucyKoATdBZ8s6gB+v6A5KIbnNrRT3Do9qyYjv+achGkEMeL
	 MC6AAi8Lk7c/kQEFSmZQKVFlVCsRH64KbBINeYvMrfpZIlRo0+DHzb56g49cLpDB/4tPe
	 lu0vlYl1VWp33+zeG+MpyaYNsFv8qejKgSNCi+jN32N5MBsv9DSY08p9uXR/qBhnjiapt
	 6a6OTbDqrdEMmQJGo26PkYXEEyVA8fc1yUr07xHbndwOUyPh8vNsq9I+JaQ/mtT03Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--willemb.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bhqpbwgU;
	arc=none smtp.remote-ip=209.85.219.69
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FC9606A31C
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 18:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07FC9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--willemb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bhqpbwgU
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91256a7b7b3so105063176d6.2
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 10:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795718940; x=1796323740; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fBtb0BMz5hkNQGeq8zzQt7EyteYPxkW8SwexoB3Gq1M=;
        b=bhqpbwgUDX6KpywFECdFKx+yR6Vmxexr77cWP7CfQ5RrH7RlteE5HSiWONA+v1gFDG
         lx2uRNLgEy/P0pEGf9XCQO2Q3Jm6ysDvrB9BJRPT1DHC4qImbkCSo2Bzl7UQ9bjiijHv
         I1I8arFPDQVPqz4QkStm1Faw4/Uhr7cyBTdnA3Ap72OZAUOOixub0LWeQGcR6FXCt5Zq
         xTra2RXtW3u+N+3f/UFzlyUqX27/9L6ibodGkodwU5mQsym30uyP3DnZHYD0mZdrSLGr
         zG1RjB0kvOOjMC8cpiZBfjZT4GurB8jE330ChQ6qlIt5EY98MNd/ApmiP33G3Hg9e9N0
         fMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795718940; x=1796323740;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fBtb0BMz5hkNQGeq8zzQt7EyteYPxkW8SwexoB3Gq1M=;
        b=oD2dTX8yDMUKedfjqaxRclz9189Ig7Bol6mNkJLGe5hJP30/xUOiMMgwnCw7AtuN68
         /sfqNLFGGutf3KQyMbQ+r0nqsIQBmLOhRzJlDFbcuMz7HkaCHo8SNaiZjULzPZ7AcEKO
         sk2+hOU5oosBBiqD1mNp8khH/tTQhPqeoIKT1H5vzPaXamcqe6C6ZoS8S1oFRqPPR8z6
         nV9E/0qXi4Wai/lvC9oraqWrVt7c4csYMV90DnV79VITlNuVZKoOLCLO+krwxUl/4uRQ
         sC/qnvZx/ec+XTgaBY3KG9SIdGy40ykvFOwRGu/TItBmjinob6+no2LYDOWS7GR4fxzA
         x6FQ==
X-Forwarded-Encrypted: i=1; AL+hErHIuav1sagWXj35Vf0DvoqpPKaVNk10V/IfJ+BYapBg2Iw5/SztAvaTmfVgKm7n4N/O7JA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9htfwahhWQ+H1qDGtVS6AHy3fRFygWsAwlg6dIHwVLlECfjxyg
	EQ9FBl941DDkHZu7oFWbHGpbZr2MACcNjNGPagJEtN2RsrIOwBWUGWsMeNlNRFJBXMFIXDCGdNQ
	ya8jPwQPoCw==
X-Received: from qvbw16.prod.google.com ([2002:a05:6214:6350:b0:921:8507:17fc])
 (user=willemb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6214:4902:b0:921:4095:deae
 with SMTP id 6a1803df08f44-9214095e374mr373511836d6.42.1795718939796; Thu, 26
 Nov 2026 10:48:59 -0800 (PST)
Date: Thu, 26 Nov 2026 13:48:59 -0500
In-Reply-To: <20261124235959.1141963-3-antonio@mandelbit.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261124235959.1141963-1-antonio@mandelbit.com> <20261124235959.1141963-3-antonio@mandelbit.com>
Message-ID: <willemb.880316e8f949@google.com>
Subject: Re: [PATCH net-next v2 2/2] tun: skip the virtio-net header parsing
 without IFF_VNET_HDR
From: willemb@google.com
To: Antonio Quartulli <antonio@mandelbit.com>, willemdebruijn.kernel@gmail.com, 
	jasowangio@gmail.com
Cc: Antonio Quartulli <antonio@mandelbit.com>, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	sdf@fomichev.me, netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Antonio Quartulli wrote:
> Without IFF_VNET_HDR, tun_get_user() still passes an all-zero header to
> tun_vnet_hdr_tnl_to_skb(), which then only resets the MAC header. The
> parser is not inlined, so that costs two nested calls per packet. Reset
> the MAC header directly, as tap_get_user() already does.

> 2.0% fewer instructions per 1400-byte UDP packet written and dropped at
> the raw table, 1.2% fewer when forwarded (qemu -icount, x86_64).

> Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
> ---
>   drivers/net/tun.c | 17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 408bb0b40348..79aaadd9a2aa 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1951,11 +1951,18 @@ static ssize_t tun_get_user(struct tun_struct  
> *tun, struct tun_file *tfile,
>   		break;
>   	}

> -	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr,
> -				    (tun->flags & TUN_TYPE_MASK) == IFF_TAP)) {
> -		atomic_long_inc(&tun->rx_frame_errors);
> -		err = -EINVAL;
> -		goto free_skb;
> +	if (tun->flags & IFF_VNET_HDR) {


     Checking tun->flags & IFF_VNET_HDR a second time here is not tied to the
     earlier check at line 1832 and introduces a narrow TOCTOU race with
     tun_set_iff()

     snapshot `unsigned int flags = READ_ONCE(tun->flags);` once at the  
start of tun_get_user()

> +		bool has_eth = (tun->flags & TUN_TYPE_MASK) == IFF_TAP;
> +
> +		if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr,
> +					    has_eth)) {
> +			atomic_long_inc(&tun->rx_frame_errors);
> +			err = -EINVAL;
> +			goto free_skb;
> +		}
> +	} else {
> +		/* a zero hdr would only reset the MAC header */
> +		skb_reset_mac_header(skb);
>   	}

>   	if ((tun->flags & TUN_TYPE_MASK) == IFF_TAP)
> --
> 2.56.1



