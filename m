Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794502640;
	b=ESFKNpGb6pEBO540GXAm5rQBUBD2ehXTvBv+dF0jTnZ26iN6gWJD7qk3jGaeZio4XlIY
	 7Y0q6evMvzPdSigSAl7vuPfWpSuAXbNLiFUYgTzMO27nCLvhsNjLl+oMg3lcm+3uOTajM
	 TR8v5m6H2f88K5r04Mie8jFN1/PeYDNaRuw1Um/XhtaTX/ALhRaWbybUI+vgfTX1I3nH0
	 D/xjWYG2qJl/JyYtWgN+3BE0uP3wBRppG1WaHFKisFLCw3uew1KZBajL9x3LWV27MRJII
	 h5qWsu7aEAxoRqUJ5UR93fHE2HjBePWntDsl0Qu6whtrbFQ6k1ant0ud7N8kDMy0cWg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794502640;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:In-Reply-To:References:MIME-Version:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=darN4TpL7cuu3l7AdV450Bjk03MaXBNxXOy+eZ4zU7o=;
	b=MBlcPEXpFKmZSSCiN/NMlh1/IKSIuC+0WNkAyp1ouYpuKxb6D5CCs4x3L7JClVAHbHuk
	 hZgT1gej8F2Zqyrx/H01UcByAJG4hn/XorJyKUiobEysVxL5DHHwYWidLO/kp6PQwaJR7
	 RmYPkhXCmc96N6av2KI0LCDVr/G9p/6dbUtmM168dE/JBtS+/VmiqB3whAkWeBFw58VmK
	 magUlXFzp8o/oXgLKPvwrUnKeLdA392pOV+fEs8nN0eZg3eccyVlyfM7IE8YO+GAwBlPO
	 S2WsO53qC7XIKVB/Fx3GXXsgVaBm/+BaP0WLirXc3m+wHulz6rEK8ylLGabm22xLE9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UqjQna8L;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=mfphcUTJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063C1606A32A
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 16:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 063C1606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UqjQna8L;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=mfphcUTJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794502639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=darN4TpL7cuu3l7AdV450Bjk03MaXBNxXOy+eZ4zU7o=;
	b=UqjQna8Lwhv/lQ+GEO0EG7uMSdw6y6djA8XejANFEhLekduExE3eiK1pcyNiW8cztlqd4B
	NO6D3D7CSHmIoq9kwAcTt1fcMrG3ews08K/XAJWqd23DhrdwvPSNZTijeYAycSPNhSSfi+
	wvXtGORpGBDySjvW/hX8K6GD4dZiIWw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-Rs2gemMIOdinDb5Jl1aP2g-1; Thu, 12 Nov 2026 11:57:18 -0500
X-MC-Unique: Rs2gemMIOdinDb5Jl1aP2g-1
X-Mimecast-MFC-AGG-ID: Rs2gemMIOdinDb5Jl1aP2g_1794502636
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91f1b3070f2so45266d6.2
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 08:57:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794502636; cv=none;
        d=google.com; s=arc-20260327;
        b=LWQYCFKYHTyYx1eSOJUDsb9VXAGp27BBNrsDZ6aR6Gei4JWzuaZZyiY/uQGGv5K800
         QVvNeuj9CGxh2vjo0DWsOXnNDFEejqNsNlR0TvrP2M0XtISqCNdrkjJb5kEGKz7KnkqH
         /vo2XX+CBtGwSuxNtRNKjqAbPcj8glEV3VXnTiDBCPwwY7j6xvuxx2Yox28AlSmqFHua
         +2gwrvgFu8z678QI8/vCbZX4Zr3jnRMLK9zGeUuKzXVnIUmn7MTbvW+OE/WqBzz2jphO
         FGFlWMxEyPZIHBksat4SlvvNJPZhr+OZsGKJ2P4Ue+FBtYONjBjKhDCYu6K1XNdiv9vC
         wPJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=darN4TpL7cuu3l7AdV450Bjk03MaXBNxXOy+eZ4zU7o=;
        fh=MbgZDh/KxmIbpx+Xi5LVKIS1+n5loxHIXwrm76ac3rA=;
        b=VSuYwNfKx/+LcBVK9lAAoc5D+XDAB5GZ2xI3fqDtGeFvntoRwFhgvzLfRevgnQywgS
         VvPacEcL18awgvTEmDws/OxbynN6ajeZp1qkTAKAu/LZc417/GFJeKgfXXH6l+4/Qds1
         McALaVcfXyj1sxsiVVjCUknT/O55y2gX6VvFxiwa1QUGlZ+kDnZHOY+2CEx9QyDBREJw
         IVqMNiu2awcwTClZ6bDFFsa7GOXZWN4/6DLnPZl/uOjP+34Iqq/F+4At6gYE/OD47lBC
         T82CwrKW7cawBKeNwfny9xZIK/J5IFaMS/0IprBWaTcfjmgrXLz83lsrouuAiypWv/jI
         i3gw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794502636; x=1795107436; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=darN4TpL7cuu3l7AdV450Bjk03MaXBNxXOy+eZ4zU7o=;
        b=mfphcUTJmKpNNjKE/vba8sbrm2GA7Y+gcHku8cTk1a+y2dk3EloihtRyKAQeirIvDp
         wvg8gkhJ5lC1AkaK6heaVC6iCZhP3qCeGnLlBSZBpeyaU5rKFLySsduaBj+RJQrdj/E/
         IvWZE44ZUGb6gMSkTITxuIkeJPwmU9i14CTY5gqBw8ihusdtAVkW8q/898LYixqHhZYX
         YqpsLL6HWprFGBwF9Jr3IbUomVpiAGiwrOGlg3zjzrZwjD5T5QVv8bgZRv4HjYSAOgZf
         YjJaZhabEjQq3VWp4hxuQIFQlsqsnhAkHF8n3rCUYqLL+Up6ZKGZVhESekpKQ0IoL+2B
         u0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794502636; x=1795107436;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=darN4TpL7cuu3l7AdV450Bjk03MaXBNxXOy+eZ4zU7o=;
        b=qCerJipSB/aYddjbLHo0lVsEryOwQvCALmRAxER2oiKyOaWi+YlOT4Wu5e5l6X+9YR
         XhOOuZY5XdyZWHTRODT+/PlUBW0LLWq8gQ6IRTjhfUUo6D85jjwHc6UhFYmw7+g9OJAD
         1AAVVg88J1z4ZhFJytemlqsP8Iun0r2xWLZ/USruFmUnTlJdic8DMbKaQVFvJU+Vfbm1
         RXQtzSQA9stadMNF7Nfyz/zLrVb5QcXw6RfrXShMHgH8dtbaINvg09s2hYAQ7ahFutKy
         MwscA1o6PQIa5Sg7D0bjy4U18ZDW+TGATP34pEs7lNehugQebBcwUSd3fKimHZh3IX2E
         vT8A==
X-Forwarded-Encrypted: i=1; AL+hErGMMVdd0kgItQA8vOO30sUoHehQVf6VMCcCMUaDbFFb5dsTw06M0C9yVYdlAj39EDWYduU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/SoReRQBGFN2+/c6gqYXMlWjR5vII/XWyIbxI6Sfk8c6r8A/DC
	YvxR5J6ZQ1tX93ou0XqoVsBuMewm6SbBx9HWu1O3lHFUav1xTnRnRGWNDYL6tzJ1FqgxXXfUbUu
	ouRHqqr44aTB/xOk1AX6tl+MDT920K71B+y8Lp5IEv1w5VLENqWGfYH8zEi/XoWg2drAidEPw1F
	Yb/csN4oYkrhLWL/LcEFalNeUKOgNy
X-Gm-Gg: AYBFou0PRhZ9x1Oanm5njfTdvqx8v5sx8hx42wW2WAGnZg4npNV7P1ilUFUMs40Cy9o
	MqqwLbhBDGMNbU819+tJN7IxykhuvIOjTveG3peaNbfb3kQIrk9xE25NBMjmBQSQcArth7nizw7
	XFHv7ENpqQGkRcSOcl3h/6yn0OUUF2dQADvgnD892ph0liwYTmQ1YHtuE=
X-Received: by 2002:a05:6214:4907:b0:917:af36:df30 with SMTP id 6a1803df08f44-91f04024a36mr108416406d6.16.1794502636081;
        Thu, 12 Nov 2026 08:57:16 -0800 (PST)
X-Received: by 2002:a05:6214:4907:b0:917:af36:df30 with SMTP id
 6a1803df08f44-91f04024a36mr108415966d6.16.1794502635425; Thu, 12 Nov 2026
 08:57:15 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 12 Nov 2026 10:57:14 -0600
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <aukO0YEZmiMIISaP@devvm29614.prn0.facebook.com>
References: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org>
 <20261028-vsock-dgram-support-v1-7-e457cf7cee78@sinrega.org> <aukO0YEZmiMIISaP@devvm29614.prn0.facebook.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 12 Nov 2026 10:57:14 -0600
X-Gm-Features: AclHuK97Vbt87h1PiWp1yuLFdgsXXBfxSod9rL7qWx7O4MzdkcMf0Vg2mTyClE4
Message-ID: <CAAiTLFV5g4XV7ZU+TYFboAi3n535murgSjh4SBw_PMnp=oQyww@mail.gmail.com>
Subject: Re: [PATCH RFC 7/8] vsock: preserve host-to-guest datagram boundaries
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	bpf@vger.kernel.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Bobby Eshleman <bobbyeshleman@meta.com> writes:

> On Wed, Oct 28, 2026 at 05:04:36PM +0100, Sergio Lopez wrote:
>> Vhost splits large datagrams across guest RX buffers, delivering each
>> fragment as a separate message. Allocate full-size RX buffers with
>> page fragments when datagrams are negotiated, and drop whole datagrams
>> if a guest buffer is too small. Refill empty RX queues even when only
>> one full-size buffer fits in the ring.
>
> I wonder if it might be better to do what seqpacket does, and just split
> the datagram across the buffers (for seqpacket, until the EOM flag is
> seen)? I'd expect that we will get better utilization of our vq buffers
> this way?
>

Yeah, I do like that approach better. I'm going to implement it for v2.

Thanks!
Sergio.

