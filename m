Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7260D3DDDC7
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 08:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780561165; cv=none; b=lh5iI/TECHRoVWCrn8W3r0bMYL4h3cJGHYdn+XRuy8CeFkVUvMWaupzcnHSRb4OU9+6SPIT0uw/EjYdOPOHcbN+3Z397M/9A8klGJ9urtLRywyKcEKEFQkkU2JwAKjxd/fK0ECe9d+F41Nz0Ztl+QGEqBTp6pA+4EF/jWc8vPGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780561165; c=relaxed/simple;
	bh=r/1JZU+p1JTnijcgW9lGSXp3cQDS4Nl8dLA1OtHelPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c0VHc1IKjQCYLmuMQz2LbvRj8+dV85wocL57fZhW70BjAE3UHPMHraN/jBUBJkvJdJQpusSmbhRbrshtK/q1qyGHjCjVMIw8aCNkAsANISoOXudpiHQYKDkmA0RubuuqJO84OWUEjErvAVqgiHVxgcpCsu5PflqTzU65NsHw7L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CV2tCiOL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rz+DwbAC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CV2tCiOL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rz+DwbAC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780561163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h/xg/NprpFFa1S1OuVvOXsTg8NUTOjkhpfmdrUxTz2Q=;
	b=CV2tCiOLc03oHoR0PNz9uyhr+48MyU3etnGzhLJ0j2C1ZLFh05tdebTXWANTBNVp5k2Tn+
	3GNbhgyPola7sRuklj8RzS4Xh+R2XK02bWAGWYcXagQV/olPEYJexTxqtbvj8Zv12T7ooD
	OchXiopKUWc1Yoy7ZvXdDlpovl4v1m4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-cS8hsDw9MEqn1-YPGLvdVQ-1; Thu, 04 Jun 2026 04:19:22 -0400
X-MC-Unique: cS8hsDw9MEqn1-YPGLvdVQ-1
X-Mimecast-MFC-AGG-ID: cS8hsDw9MEqn1-YPGLvdVQ_1780561161
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-46010bc0f1eso254884f8f.3
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 01:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780561161; x=1781165961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h/xg/NprpFFa1S1OuVvOXsTg8NUTOjkhpfmdrUxTz2Q=;
        b=rz+DwbAClZP9UJcZo/TS+NgUejj2nx9sf5xBpBjD9/klnJkE/qp/DTh5bbopm2fxwD
         ijtFseLbS3jXYRB42bm9vsLr0mFLu+HCmHR1Fi+8NzeRm+HJOywEzbmsh7/IBieKsGV9
         D1Pz0Iu07qkQXk7gKc9Y/TuH/EB8zvZ0l0TkLgShVQVaqcsxoDLr1JMqUYbQdvo1Mp4r
         habhCagaQptu04uazOiRiAVuItXs8LFVPebEeOoet3yTK51XWS3vvg6LrWSmyj08JNz2
         GldkVQCpy5UH/XdcemydLi18ktIcVYrFdp8bj+hI/IgjC2E/3kfh2e/JaBVFakVCHVba
         GscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780561161; x=1781165961;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h/xg/NprpFFa1S1OuVvOXsTg8NUTOjkhpfmdrUxTz2Q=;
        b=Qpe78CZ0Vp0Om/j/3v087NvPzjfqErBKO/7g/eV7FqrsMFqfn0/3WckRqbrTWcV5PY
         2bQcnGfPDdCJNrHtdL2ZreW+RpcYJu6icjr7xpt3dXjjZNwdp+OvIFSo5N1KB/EATRrI
         WpPBV97FmCQXP+PcOFGwfnGJHsYHmMWgweHiBLmobRqLUEE2ZtaKMY9uMQGXEBR38lg9
         +j0AFIDj0OtL+UWtHAGRKxP5qL3jd6wGr2kS84hoBEy0jGXH/Cj1Q9e7siuBwq83GhIG
         +UsZvX0CwVVsKxrqY+VDTXbJUc1LBplQxH9v5gCtQxlyOZL+HaXIIN4REhD3enaWSvaU
         Qi3Q==
X-Forwarded-Encrypted: i=1; AFNElJ+2CjF05odNQCPWHygMRwUSmQElfcLIPNxIz5NNjctr6Qq5qPB1KoYhDGUzgnsp1my2oLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Eft2GYG8ZV1pHkCD6/f/5dIcrFhag3cMylBLdhSJ7j7Y2Hde
	f2gSQl5AxvpgcNNvzvg9O5IhDeedePwqCCvjEOF9rggRqSb3IGKzvz6MCekOwxPpdPQUo4XJ7IA
	Gw2VGESsnLplTGJhWmW1MSsKeQ1YfCIYDVGpLswhDv2BMiMB2pLGPBQ==
X-Gm-Gg: Acq92OFR9kvOBz8oe49LfZEBzaXg9J1ZoNynSV/SBrE+RQWXefxIsXZ0F5T7ykTcbPe
	SU6e/8NjZlDhRXmWIkjJOpXoz9fySxyo3gAVNdeK6YfltOhzELvYFktwSX9HBYh5SbkB3nDJQRL
	G9Gu8V10z7k2+tXzlZF+aJlBIBVD9GahUVshQ45gY/a3LwShT0BuNzz7lMorCVcvp3BANp/S+jn
	korPF9pYqGRlHSQQBv8Ag7YmkbWqQJLiXm3bQc8b3uC7D4h1jlI1Ph5h+BiOOkcsHSP2MRZFhyZ
	qDBavORp/xAH4Kj/9cKzdpOfrGkkPsYJXEmqb/UeQXR6aB99Xfmw8lzwXeBGi68eiGSkG+jN9JE
	8BU+yJZaSlzEErAVPXTKCfCn5JrpXGce/9DWPQGdxCh30zerCHJ9cBFGjiOIeW2+OJjA=
X-Received: by 2002:a5d:6447:0:b0:460:1f34:cf80 with SMTP id ffacd0b85a97d-4602183b991mr7634983f8f.18.1780561160797;
        Thu, 04 Jun 2026 01:19:20 -0700 (PDT)
X-Received: by 2002:a5d:6447:0:b0:460:1f34:cf80 with SMTP id ffacd0b85a97d-4602183b991mr7634948f8f.18.1780561160348;
        Thu, 04 Jun 2026 01:19:20 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dc577sm14133428f8f.3.2026.06.04.01.19.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 01:19:19 -0700 (PDT)
Message-ID: <a7d86867-3c2b-4fbb-902b-61c4e2a561bc@redhat.com>
Date: Thu, 4 Jun 2026 10:19:18 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 2/5] veth: implement Byte Queue Limits (BQL)
 for latency reduction
To: hawk@kernel.org, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260527135418.1166665-1-hawk@kernel.org>
 <20260527135418.1166665-3-hawk@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260527135418.1166665-3-hawk@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/27/26 3:54 PM, hawk@kernel.org wrote:
> @@ -348,10 +381,11 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
>  {
>  	struct veth_priv *rcv_priv, *priv = netdev_priv(dev);
>  	struct veth_rq *rq = NULL;
> -	struct netdev_queue *txq;
> +	struct netdev_queue *txq = NULL;

Minor nit: please fix the variables declaration order above.

> @@ -1092,6 +1137,24 @@ static void veth_napi_del_range(struct net_device *dev, int start, int end)
>  		ptr_ring_cleanup(&rq->xdp_ring, veth_ptr_free);
>  	}
>  
> +	/* Reset BQL and wake stopped peer txqs.  A concurrent veth_xmit()
> +	 * may have set DRV_XOFF between rcu_assign_pointer(napi, NULL) and
> +	 * synchronize_net(), and NAPI can no longer clear it.
> +	 * Only wake when the device is still up.
> +	 */
> +	peer = rtnl_dereference(priv->peer);
> +	if (peer) {
> +		int peer_end = min_t(int, end, peer->real_num_tx_queues);

Sashiko noted you may need to additionally complete/reset the tx queue
in the <old_real_num_tx_queues> .. <new_real_num_tx_queue> range, and I
think it's right.

/P

