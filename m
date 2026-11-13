Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794577796;
	b=Rw6JaBtOozZe/Gk/at5PAXnolhLup8pob9VY9gBoSyPjLC5VB/kLw7WNSe2nC5jw+6dP
	 Tyslct3i48WdLjSAniB7UFV2czJPfWPV+UazjaEiYnS5xFM+KGrTsC36Iuo2OrE7dewRu
	 +hE3EerO0XIIRWm/uMl1LYym13Gz/Uai/ZegOeOP7fqwCwi5KWJ43ChXg0m68pMIlIDok
	 bF13JZBcbGaVQ56U4m5UM14IvZ7JaXgHuWwIZ5gxHLIPVrRVbxQ5uljNVqcfYCcO4v3rc
	 at00zItaG1i6LhfSnH2Lx+cH9pvUnrTnPiBDvTrav1a/5Thm+5PyS9V0bQQWYdFrNOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577796;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:In-Reply-To:References:MIME-Version:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=8e2MXnw38pYzH1XVs1yXJtejPbQN6bZltGajv/NaWc0=;
	b=cdy9H9RL8BpOedkMq/e5dIJwwRTm9JVU6691rn0Agnpi7Heaf9SiBC0Lt9A7zAlcYeuz
	 xYkR4LjWxBA/KNgh/HrILvRp/wf8ziQPvtfrqzmvmZvhNOM4urphKLjjrZT5bNuUppXrj
	 n6hHz1HcRt5wIKjW/pepI82wMOgauVwo7qyVcYpAwXk8Ueu1o9kKOKA9KRU+q86fkZ2EP
	 RH0t93+NGKDFTPj82Qpl5BoCByLIOawFsgA5HsNbo92uVraVR/0voEGwXT62cG9UKhEXD
	 eBeUhqKFrWcMLSTlQ3/Lc3Zs0IqgpXAS43ecnv5o6baCpNJDa0OsiFdShBcvymdvgQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dnr4bWaa;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Ga5oluTv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0661760A3832
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 13:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0661760A3832
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dnr4bWaa;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Ga5oluTv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794577795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8e2MXnw38pYzH1XVs1yXJtejPbQN6bZltGajv/NaWc0=;
	b=dnr4bWaah9/wySNrHe71UxG7yxYO1hP4OJsDO4UuONplGfOBRiaQICVPWXH0a5xAfClVPc
	t+VpNg58eHK3YP5XWW59CAcUzV5E/GfH9p/c18EmHQRz6zpg7GqxOWWu1kW44oqkX5txvm
	zu2Lk64sIPPATltWgXHym6Mxatxh5HU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-2BmY-q9APo26dGN74L9iTQ-1; Fri, 13 Nov 2026 08:49:53 -0500
X-MC-Unique: 2BmY-q9APo26dGN74L9iTQ-1
X-Mimecast-MFC-AGG-ID: 2BmY-q9APo26dGN74L9iTQ_1794577793
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91edde88d16so12636476d6.1
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 05:49:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794577793; cv=none;
        d=google.com; s=arc-20260327;
        b=gEPVpAP7CQPwBY1PSQ40d2a5vQTA5AXrCQA2f3zTb8QkRfg+AhZfjuGTj0egFDw9uT
         MgDaULl9+CZBUzBJ4urWgETLEH0FadUtDyHDEDMUWpbG7dME/WJZOAiXWeYAU209Wqdf
         Nv18DD7EbWKy/KDCSXOsNXayddnZqe1Ih0gCydNCj1XCpaazz4fDtz/8EeCbvq5jptTG
         lTrlivVluCQ+knxliBSzF7UFC+MLdF3B9dOQWs77pJi/jKRBnk8DmHyliCunfLiCGuaG
         Sbndmi3o9WspV7qpBwFiVPb47n5k3kDJSoJqU2N10aM+ujTPstXMN1WlRiG+nOt1fFYn
         EWGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=8e2MXnw38pYzH1XVs1yXJtejPbQN6bZltGajv/NaWc0=;
        fh=ZIhQg+3CwRsgkqII+zl7SiNUHt6v8lKGAlFlpQPyZB4=;
        b=XaMhwm2XLNxI3Pu5lnujU8MhdtAtqqDtGAfr+odINIDtQvvIhTQIbo6lys6mrxq7sv
         xtfV44tnRZgO8Bq9cKXKh1kDcQH5zGrtneOjQFX11ObSHMdhDPwtFOCZUeq2WUq/Z+rg
         Hs2poIUtdyDkgNS5l3rLuQ7nWtIHsltaapd/WHNcIlJQU3h7jAOy/nHWJvkjcEsUWqgY
         zS6VOr1TSDagUenfs+0hsEN2KF8qQgVoJi7CCTxAUrvwza+zfVEdZInlfy+uiGI2uz2J
         8BTSsCmQF+etiK5Am89JOYRUW1ZMTGHzT76kGk6jLwIdv8L2XnTuxMt5PZWmdYuO7+KO
         pMgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794577793; x=1795182593; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8e2MXnw38pYzH1XVs1yXJtejPbQN6bZltGajv/NaWc0=;
        b=Ga5oluTv2VoCAk4tJJMwd4DcHxnzZN8P5RMMfsYuwHSiMT40x247pqXYZppw40aUfp
         AgXHj7O5P5EGzLh4fIFmrS2LDUH+QEQZYT3NfXESJ7+2AAzl/5iG4ssuum/lz5MnkbiY
         FEWaupRQi3hJm3DKU1Rj2ZQVesMwID+ZlD3yg4Dcq13ucBIA2y5CuZZ0qDg+hag5pCQ2
         rQ5GzjunzI61xrZyS6U/SOWzCL5dpAMnK6H42AAF/0so3HDc8I1e5CduBSEcu1Nj+iKT
         Na7YqNXXzrX2iDdPop6PnLFczlm8s6Y4c3Y6Takf75DT2e9wYXuz0ZE7I3UrxJfbFVUJ
         fD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577793; x=1795182593;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8e2MXnw38pYzH1XVs1yXJtejPbQN6bZltGajv/NaWc0=;
        b=kJhqOeDvyvb38Sc3c0v/PF9OwNB9tqqu8XCSNHJKdM7rE67B/OcPosu2vFK9iwzJ6U
         DbPgnEEcZXSD18fTO31shbjzQGJof88eqfxrRkyim88wv4+vX0UymgFSO3/HM2wxY0o8
         lU+ckITMvLyKTpVkBSytKEM10cWqqDBzyPDvtxt9JtKRomwDL9NezugO+c/ZbVBRC1H5
         NopMylSauVcw9H1HxlPT7/vB8muH9xy4kZsnh6RJJ3t34DjoR2l77fPKu4jvUqgAvIQy
         QXFFdyz4TO5KMapExX4Erb4+ihZMk1DXvsL0ZEJ8D8o0M5jH+glFrjLUZyOBEH2n9zKA
         SBQA==
X-Forwarded-Encrypted: i=1; AL+hErFBnK9/OKX2sr/p4Lkl4CC9VFrD4tR6X8fuJ2b5n6BvNOQDejeySAVhFTntXyQkm/VbtcI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/F01gd89LVqdgwmX1MnE5JDgb4WteoX7Bq17EPmOV9PljbnY5z
	eGDnk2UDJHA4YP/kiuog4CxuEi5GGkhXrZmNqYvDLWbBgaSIkeGYkfLqdDiDkZhzMfyWw8GVkEo
	yowsDPh1f/hA3nsyoaWrE0fw67ECUE03GeJnlO/CkfjsXV16heiolJjz490EymKJ0TQLu/YCRe5
	CzWyVtb+CIWaGu/GjbqJOZnfyDy/QX
X-Gm-Gg: AYBFou0waW/uMkJl6A5S6ttHV21LtdJ7MKNAmw1B67ZN/8hsuK4EL14FRRoy2u310Z+
	pURpUjLxnDAXsjgG2/dmuGFXedpDVh8nvXJOHj25aTO7lK4D2rXfZiYzfYOJp2ncvMuAWB5g+OF
	/x+1wF/9d4oVPExmgUupzTFhAJscuDnWKFeaHsyWXOj+pclQ/Lao1HVvI=
X-Received: by 2002:a05:6214:85cd:20b0:91e:89d8:a330 with SMTP id 6a1803df08f44-91f241f6d2bmr27649196d6.25.1794577793105;
        Fri, 13 Nov 2026 05:49:53 -0800 (PST)
X-Received: by 2002:a05:6214:85cd:20b0:91e:89d8:a330 with SMTP id
 6a1803df08f44-91f241f6d2bmr27648836d6.25.1794577792581; Fri, 13 Nov 2026
 05:49:52 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Nov 2026 07:49:50 -0600
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <20261113080506-mutt-send-email-mst@kernel.org>
References: <20261113-vsock-dgram-support-v2-0-bacfc85b71ce@redhat.com> <20261113080506-mutt-send-email-mst@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 13 Nov 2026 07:49:50 -0600
X-Gm-Features: AclHuK9yYj2AE7jCL2Q7aluEqsTHouql9M7zvOo0Tu9GOsA54iFCZqauW8Q06G4
Message-ID: <CAAiTLFXvuHY=r8FPM7TFNTAO1oyco-brcc6YAc=YN432h87RSw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/8] vsock: add datagram support to virtio and vhost
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Alexei Starovoitov <ast@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Fri, Nov 13, 2026 at 01:47:33PM +0100, Sergio Lopez wrote:
>> This RFC adds SOCK_DGRAM support to virtio-vsock and vhost-vsock through
>> the existing AF_VSOCK API. It is intended for guest and host services
>> that exchange independent requests, responses, or events and need message
>> boundaries and sender addresses without a stream connection or application
>> framing.
>>
>> VIRTIO_VSOCK_F_DGRAM gates virtio traffic in both directions. Each virtio
>> send carries zero to 64 KiB of payload in one VIRTIO_VSOCK_TYPE_DGRAM
>> packet. On the RX virtqueue, the device may split a datagram across
>> page-sized guest buffers.
>> START and EOM delimit the message; the guest reassembles at most 64
>> fragments and 64 KiB before delivering it to a socket.
>
> where do these limits come from? how does peer know not to send more?
>

The 64 KiB limit comes from VIRTIO_VSOCK_MAX_PKT_BUF_SIZE. The number of
fragments is a reasonable number to prevent the driver from putting too
much strain on the device.

Both limits should be part of the spec. This is the relevant part from
the draft I have put together so far:

+When VIRTIO_VSOCK_F_DGRAM is negotiated, each rx virtqueue buffer supplied
+by the driver MUST have room for the header and at least 1024 payload bytes.
+The driver MUST discard a received datagram packet whose \field{dst_cid}
+differs from the current \field{guest_cid} configuration value.
+The driver MUST reassemble consecutive fragments with matching address
+fields and MUST NOT deliver a partial datagram. It MUST discard an orphaned
+fragment, a fragment with an unsupported flag or operation, and any
+incomplete datagram interrupted by a new START or an unrelated packet. It
+MUST discard a datagram if its total length exceeds 65536 bytes or it has
+more than 64 fragments.

Thanks!
Sergio.

