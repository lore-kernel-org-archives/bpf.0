Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795450640;
	b=x22ba5B+6SkZkKH7Z4LNOw+ALbRROBr+r5A1b0EGZur6AOXah1H+RYEEDyfhOvV0eM4u
	 mpIeKxijdcrRVT+qDPAdoBOVPBPeDRia9Ow7SveeYBHB+9M1P2NJGqiCuJAOEdGL0NEij
	 7m4Ee6cUnQOIJrK0JgNtq0pmuIuFXH2btEtkIODj0CfKHKIpA5VXqHafJeXl1zJivHScT
	 /wCMQkpLAJqXPH8ix5zLrzD6+Ym+XMRE42IkfJmVVO+z8te3b+6WUfKTsbZxVe2C06bn0
	 1NqXQf38k+1Ghnd5U5MnChlNtDV6Nrn424WffGUb2Sn5HDJYi/AmUVyFKzJeRdmzRPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795450640;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+GHb/SYd6gXinJYqxw1GDlcMLdqBI2V3zFyLkxFbZ0k=;
	b=uBun7CnwsUCkkXQ9vdjKiu6LU+sQCLFRRIPbLUyfKD2LW0OxLz46VcCUCr1qgVPVVgZB
	 cPZunT0MotiurMB9r7GcxXc9cSIIUQBaBoF4YeufJKVJ1XGiOwpwJdzy9d5x2Ci8LqYYG
	 kO0Zkq56Ae+rnnbxv2otgfxV/WFI786V5tTNP0Nl0R84BXmx2ywY/X1M8l75qbCQEoxtU
	 tDL7o4MxVN9j6SR28qjaxNDNdijMdX5CCdtOZDeiMVSfcFH614kzzOXFEFfmZZKgWb6rb
	 VsASm3pSKy1rZRaDyycB8ezaHxDy2yuacyzT+wvI7bvhm3E3tJWirBJuO7UCA3DayuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IPd1nB6Z;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=EFWjYSTs;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84727606A31E
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 16:17:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84727606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IPd1nB6Z;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=EFWjYSTs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795450638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+GHb/SYd6gXinJYqxw1GDlcMLdqBI2V3zFyLkxFbZ0k=;
	b=IPd1nB6ZLVQPneWsEXFvVVQMx8was4lClAZCBRJ/L+sUBLyHeaHJ98E0y44GGj2IvD8Mam
	za2JsFaOFpufuJhaec8H2FOf+QS8CDWD6vLCgOC/WnmpZz0lMSflAG+Q6Annvq5f167pU8
	zvfRzKu0Apt8fzLRRPeMKIo2Gzy3Jw0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-xaGXiuD6MvqHaxA8Zgvugw-1; Mon, 23 Nov 2026 16:17:16 +0000
X-MC-Unique: xaGXiuD6MvqHaxA8Zgvugw-1
X-Mimecast-MFC-AGG-ID: xaGXiuD6MvqHaxA8Zgvugw_1795450635
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4bb68d624baso6692435e9.2
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 08:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795450635; x=1796055435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+GHb/SYd6gXinJYqxw1GDlcMLdqBI2V3zFyLkxFbZ0k=;
        b=EFWjYSTs6eZbKtZfTzVI20evhQuKBSbQFwBnL7ixe6pYNqb3IX5FdNJ1NXk12la/fo
         mtcq8GhB5fbnQhWtE3XAnfyxUDceh6nkUkIoCsejjiZ5xIUIo3D/lpZrrdqy6JZ1Uw13
         i8gGNOQfWASM9FbNeEqtG58xOZ0gLZR8bMdPEOX2aXVh5toHQitzAoqzO7HXU7XK/nni
         2yJbyWsuJtKRhA10Zs2K92JS5vL+KOQjUYEnkDWYjbNa0+6B+VTKq8E5pBfICJiVZpG4
         jYCFjpoDjxCISpe4VOF/NOPsukP9LGBo41m8ux/OAQcxreEp8Ej6xJTjSYH05IAQwH8/
         xjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795450635; x=1796055435;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+GHb/SYd6gXinJYqxw1GDlcMLdqBI2V3zFyLkxFbZ0k=;
        b=IYLMYcRX8VYpnt8QO1f9w5//Aicci3l85E5VQtnzVFYTvHVmrCW0kQhX7AuARDibKO
         xplaPle/izHN37aPz0i8yTOAKePkP7+yinGREm/i9Aqis19jFAK7MkJA+jIO+LTpM+2U
         VREA4l5sJdPQTiyWPDhF/bMd4PU2xe0pleNYp6nf5bsf50dF6xXgZuSCEheAbYkRGrUF
         X0WZdnT8v7HkO3X0pbhgAxZgBnhgqeq09Jqndsyw+X6J0GljDEkLPSOqQmZUZId9tqGT
         BI29SIX6+R7N9PD1cN2zMnIDtR7E/962E7k7wJCE+8uqhZHb8yOnDaHkru0a8FXQQ0iV
         PdAQ==
X-Forwarded-Encrypted: i=1; AL+hErGOxgNxWyAmWFh6cTPgrivLnHw7p+e1nHzKo6clg/popFqSC0Hzzgw7uuIsOJbjonQx6rM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9eDwSsy8YK1CeFMZYMgEIyv9rDwznBrUReIW8R7ovJB4AUEz/G
	Kq7D+k8Iy3jJrUX8fbiU/zgUvs+Rpt2M3bIzo3Z+S1exX6G6ZHSzi+OLfJlZ5Q5Gtg9cTokSylB
	RUctfsFjN5gWfmQh65pKFeiNZpf5smmlsjp+D602FczvQ0deUa0sVNg==
X-Gm-Gg: AZFdTZd95nSDgZTV8fVlpeY1AYkpU0ts58VKFbR0akLUX78YLzNE+iGZzZyNcmkzW5g
	lWpitEh98tDo+eaaQyTu6cwDbtfYWzAmpNtp5eA1q7Kx2GMAEdfgK9EK01fSvouFqVcI0s7c4T8
	e7kpPxWs0a/5Y71/ASzytQbFLK1rgEBZra56ww2GDusQrHxCGw1ugTFDaH3ssjZlib5rHNOyS2g
	ZqN+zVAej138/LDkRgqtlMLlGbknUhskfAxEsO67CunfZEN6yEf/yHO7W4W42mDMngYEWT7V0oX
	fViZ+KFcNNRj+tHwQrO54zZY4X7sgBohHF1N5F7fQqXD/VGbDabm1RGjwMgm5p1hwps7XltyTru
	1lS3XA+JDP7YGPBtUGyYDOusyHuOyZZpxuJLwPI6+Mwv8VmHBnluY7w==
X-Received: by 2002:a05:600c:674d:b0:4a0:1fb9:2f51 with SMTP id 5b1f17b1804b1-4bb88808263mr270420435e9.14.1795450634820;
        Mon, 23 Nov 2026 08:17:14 -0800 (PST)
X-Received: by 2002:a05:600c:674d:b0:4a0:1fb9:2f51 with SMTP id 5b1f17b1804b1-4bb88808263mr270419595e9.14.1795450634202;
        Mon, 23 Nov 2026 08:17:14 -0800 (PST)
Received: from sgarzare-redhat ([80.116.143.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb9067846esm209571105e9.4.2026.11.23.08.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 08:17:13 -0800 (PST)
Date: Mon, 23 Nov 2026 17:17:07 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: jrmmhm.kernel@eldare.de
Cc: Bobby Eshleman <bobbyeshleman@meta.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v6 1/2] vsock/bpf: fix zero-length, MSG_OOB and
 MSG_ERRQUEUE reads
Message-ID: <awRlwL1epH1j61Z7@sgarzare-redhat>
References: <20261114-kbh3-1-022-fix-v2-v6-0-96b6029bbffa@eldare.de>
 <20261114-kbh3-1-022-fix-v2-v6-1-96b6029bbffa@eldare.de>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261114-kbh3-1-022-fix-v2-v6-1-96b6029bbffa@eldare.de>

On Sat, Nov 14, 2026 at 12:59:14PM +0100, Jerome Mohm via B4 Relay wrote:
>From: Jerome Mohm <jrmmhm.kernel@eldare.de>
>
>On a vsock socket in a sockmap, vsock_bpf_recvmsg() sends zero-length,
>MSG_OOB and MSG_ERRQUEUE reads down the sockmap path whenever the psock
>queue has data or nothing is queued at all. That path copies from the
>psock queue and waits for data, and it handles none of these reads:
>
> - a zero-length read with data in the psock queue spins with the
>   socket lock held, and the delivery worker blocks on that lock;
> - MSG_ERRQUEUE consumes stream bytes from the psock queue, and the
>   zero-length MSG_ERRQUEUE read that MSG_ZEROCOPY users make to collect
>   completions gets -EAGAIN or blocks instead of reading the error
>   queue;
> - MSG_OOB consumes ordinary stream bytes or waits for data, where a
>   connected native socket returns -EOPNOTSUPP.
>
>Hand these reads to __vsock_recvmsg(), the path of a socket outside a
>sockmap, which does not wait for any of them. They now take one path,
>so the order of the checks no longer matters.
>
>The MSG_ERRQUEUE case was found with the help of Anthropic's Claude,
>its stream-byte and MSG_ZEROCOPY parts by Stefano, and the zero-length
>and MSG_OOB cases by the netdev Sashiko reviews. Each was reproduced in
>a VM with a vsock-loopback socket in a sockmap, without kernel changes
>or error injection. With this patch alone they behave as on a native
>socket. The vsock vmtest.sh single-VM tests and the BPF sockmap
>selftests pass with the series; I did not run them on this patch alone.

nit: IMO talking about series/patch is confusing while reading when the 
patches will be applied.

>
>Fixes: 634f1a7110b4 ("vsock: support sockmap")
>Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>Cc: stable@vger.kernel.org
>Signed-off-by: Jerome Mohm <jrmmhm.kernel@eldare.de>
>---
> net/vmw_vsock/vsock_bpf.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
>index 9049d2648646..c9b399f37720 100644
>--- a/net/vmw_vsock/vsock_bpf.c
>+++ b/net/vmw_vsock/vsock_bpf.c
>@@ -80,6 +80,9 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
> 	struct vsock_sock *vsk;
> 	int copied;
>

nit: a brief comment here with the reason would be nice

>+	if (unlikely(!len || (flags & (MSG_OOB | MSG_ERRQUEUE))))
>+		return __vsock_recvmsg(sk, msg, len, flags);
>+
> 	psock = sk_psock_get(sk);
> 	if (unlikely(!psock))
> 		return __vsock_recvmsg(sk, msg, len, flags);
>
>-- 
>2.56.0
>
>

Code LGTM, if you have to respin, maybe you can improve a bit more.

Acked-by: Stefano Garzarella <sgarzare@redhat.com>


