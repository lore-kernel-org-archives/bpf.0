Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792602042;
	b=1loxxYmn/HQJmGvlbIqt0gZQVWOnXYgFAEOmry+VzzV+hWTj4joVGzgwwzVTb04oxVPM
	 3ap9icDukkqKyGS+i5sL/7/WEWU2EfUo4JGFqjGr9gxfMKN7KUtObE8akjmd5toCwTkhy
	 s1Sqgg6j3bo4yz7iBZlvRppUoPEwHDQh23QdmpNB5m6SCx0Qb/H9xONkdR3y9RuHCyGVZ
	 0HgGfhoefELZ1qM1uXFUdsS1DzY3smwfoZ9q1uNe7zD87VoGlS0NVI8FTMRmUOFASNbyq
	 gQ8+EyNQOoL0zQyoYKJW0wwnj7iwFvOaaVZ2YvKn64auGYDGWGPmABqcknJtyOG/fUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602042;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=hg756WFowYy+h+rv8OWF8+LfypVcqHe8wBiAPczjXtc=;
	b=dnZsSy8Ovreay5zsIfbJMTt1irtOVZTqjItCbyj8NDmrhti83+zmY9NVY8EMJp9o7my/
	 cTqPLpmeteQ72xHxcv1XZEi5cHzk826LcUQxWAm+Zl1CvkGO7w860/UNzKH1ci5hvtJw4
	 dD7KKg/i2l9BCCpB25ukH067UJms/QeSpUtJ0rUE6EbgXS+jfJf2zapo9jRjAyXQf384+
	 8UHFDVhreV0fDKRGjQeFxnGgWjkUx0oTVP8SHBrfKOthZfje+NHcU2eRq53gnK9CQBKa4
	 e2YreuEK2f0zgyIzgHVXtwZBo3fBwHK6ff7flia4I3Ka1pf38eEdy9W9tr03uhjueHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aMOpKt+b;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=UbimXrB5;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4591606A31D
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 17:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4591606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aMOpKt+b;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=UbimXrB5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792602040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hg756WFowYy+h+rv8OWF8+LfypVcqHe8wBiAPczjXtc=;
	b=aMOpKt+b9bJKokL70zGWAC80tgnRVx+0vL00xHOy4BGxAnBDFY/ZnOhEYHSXWUBfC7kL5I
	1mNBQgrBCMiqca+1yzH+dnr+cu9YyCJ5AlmIiazsUo3OY/vcRaYWp5yGindE5Q0VEu6UIV
	0SOHfV9sIwRK2D4FsQi82QtiRNQVsBk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-ef2U4SZ1MVOtCTaHNOT99Q-1; Wed, 21 Oct 2026 13:00:38 -0400
X-MC-Unique: ef2U4SZ1MVOtCTaHNOT99Q-1
X-Mimecast-MFC-AGG-ID: ef2U4SZ1MVOtCTaHNOT99Q_1792602037
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a019d53f46so9256015e9.3
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 10:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792602037; x=1793206837; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hg756WFowYy+h+rv8OWF8+LfypVcqHe8wBiAPczjXtc=;
        b=UbimXrB5dGdnO0TsxeGofcIk8ZGbuenQmt+4Krqq2N9jETg6GFKSrNicaEK8SOMOOx
         RluoUpqKAZKuoZPZ9zVK5w6urFc+EEZ5hb+k82B2vrSFzVHgu7/gXieOJSRCXrXUCY8T
         CWBz+rkJNObiVMAZ780stknk0A9ApMtdmB90IyGdeDNsCG1GOtGblwHv/0xVZ1+buReF
         9o/13GiC+N+12rejlU7VIsxpwkwSz0CvoF2npzfKLby1c8/AE+uHprSl/63+flNrHvxX
         1+7b60YK9e1RSmdPHh+y21luDknXV1MfF7sBf7Ky+XZK/IHLEFu0fLWQxMWGxDmQPvAl
         O3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792602037; x=1793206837;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hg756WFowYy+h+rv8OWF8+LfypVcqHe8wBiAPczjXtc=;
        b=IVS4kW0/PJRnLXjavkxiqnrlBkqyQrdjq1vfxdOPrMHWX3151yzxGI33ghgVBWpwHT
         0jplAlNrpqa7f/X7zgOTuAIYFYo+rOlbvelod3pXTrFQ/dEVrVnqL3JS3Dm+B4eAiGIF
         jDy34UIZH8CPp/AthiPGnwg5/32Ei2M+/MmlcGqoUx2oDhfbfaAZyagImROvjYRwy/uQ
         HypI1Tg48hvzXAFyBA2PGU44s7Tiq5MoqOxFcMuwxpz/3P1L9MiZVH2gVZ7j5tE+BwY6
         EbZoBiWLbnn6EJE+1qV6jbjKXySdk7Hy2idqq0yIijigHvCpDF1ZwnraQ+/WD7Bj5Wbs
         P73g==
X-Forwarded-Encrypted: i=1; AKwUvBzCEYUgwpbARolzybu6uwOWrYtbmkNa2rhM2G9pvVmmPmEemkIkx1RYwICSumzQU+vdiLU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJy0yeuK7pVcrFE1Gpw1a0X6xvMxvyM5gQMOq/5eE2QIeep00xc
	8c1bY7ExMQzcO+3LMtQSQ5kLIAdh8U+a39eqT1crlpZSGF+LyBZ/UsqFl/I14kT9d01rHj3RzWl
	neNJQpk8Duu+JT1UpmeKxsHMNX0s8DVEUYim15l09Hcs04JA+PG95zA==
X-Gm-Gg: AYBFou0+4CK733e9FH3LXzEn55L3liEqS7dxojXMCIiELzWLy5JaRjozKAeidYplY9u
	a6B0T4QqJgaFtpChmcOyO0egzIiXPvleWXOmBXVHriWmGFLYqHnZTBFY0LDR+wOzMX5HbQ7sHDe
	/oVpqztLwp8IB9pv1KxYFr3hNiBVxDBgCahUgzPqwQWUR4ZBbRngUhemeIbfjKuugatj1jRgWh3
	+M+zsDOcRi36AprldsVnOurR38GVlNlC2b+WKvAvAzCIaezhm3Db5HeJvBLe23mLhHKa+TCiXh5
	mrzxcgf1RgbLysSDLqVwfXaTeKRMQg/Qx8sNfNH/8lKIg9mw2kc8RrVS1JohkQ4UYTs=
X-Received: by 2002:a05:600c:8b6a:b0:4a1:9831:a69c with SMTP id 5b1f17b1804b1-4a1fdd3bc69mr52099315e9.30.1792602036432;
        Wed, 21 Oct 2026 10:00:36 -0700 (PDT)
X-Received: by 2002:a05:600c:8b6a:b0:4a1:9831:a69c with SMTP id 5b1f17b1804b1-4a1fdd3bc69mr52098645e9.30.1792602035808;
        Wed, 21 Oct 2026 10:00:35 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fcd360e4sm46139995e9.4.2026.10.21.10.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 10:00:34 -0700 (PDT)
Date: Wed, 21 Oct 2026 13:00:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: linux-kernel@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net v3] net: gso: validate transport header before
 computing segment length
Message-ID: <20261021125549-mutt-send-email-mst@kernel.org>
References: <52b8bfe4ee848aff8ace47752352de486171d45f.1792595507.git.mst@redhat.com>
 <CAL4Wiir3NTn8VdbzS=sV3tfz4XGoBXmSfjm96k9SBMTiYBBtjw@mail.gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL4Wiir3NTn8VdbzS=sV3tfz4XGoBXmSfjm96k9SBMTiYBBtjw@mail.gmail.com>

On Wed, Oct 21, 2026 at 05:49:35PM +0200, Eric Dumazet wrote:
> Le mer. 21 oct. 2026 à 17:13, Michael S. Tsirkin <mst@redhat.com> a écrit :
> >
> > If a TSO packet is processed in the stack before a transport
> > header was ever established, the TCP data offset is read through the
> > unset header offset, far outside the packet.
> >
> > This was demonstrated by syzkaller, back when the input path did not
> > dissect such packets: a virtio net header supplying a malformed
> > network header was enough.  Qdisc length estimation has carried a
> > guard against exactly this since
> >
> > commit a0dce8752193 ("net: Skip GSO length estimation if transport header is not set");
> >
> > the GSO length validators never got one.
> >
> > We used to, but we no longer allow such packets in: since
> >
> > commit 44378d02c5aa ("net: always dissect GSO packets in __virtio_net_hdr_to_skb()")
> >
> > the virtio net input path dissects all GSO packets.
> >
> > But as a defence in depth measure
> 
> I do not think we want this.
> 
> The root cause was fixed at the source by 44378d02c5aa. This patch adds
> code to skb_gso_validate_network_len(), which ip_finish_output_gso() and
> ip6_finish_output_gso() call for every GSO packet, including locally
> generated TCP, to guard against a state the stack no longer produces.

I just worry we missed some entry points. Shrug. As you wish.

-- 
MST

