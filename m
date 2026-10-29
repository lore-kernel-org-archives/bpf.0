Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793268856;
	b=yTUTegLhyW4gdFoIovbQ0qCR/SqSYiGaTzG0M0SB0gF3VO4j63fClPw0H1AECT6XlKqv
	 +BaFakv/LybjuIUFo8fBFuHzRzIXyRDuDVGlWFsLQTBuBKfbcAfm8HbR5lm8Iq4tgSg+z
	 HdaC5xrbTaI9XnWpJXz8/Yi6DsYOGDRwlCAZuOUaiHSoM8O/uN67S/SFI0rOw4jzFm02s
	 MTqewClNcwtdYtGdvq+Kq57QciYnGMc+9KQSp64sBRrBKaK8Piabq6aFj+5fEZob0trbn
	 FsUFrZb57k5OJgdjKbqnYgRzLCZxS773jHRCpBH4Ku00zXsvWxJPBmuagInH8dg6tsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268856;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=g6ZvoJA1lnqkwFVkrQz/iNNGer9RaAvDbUj4LHUnhUI=;
	b=2Muzmvae4Mn6szEEm8X5/DGsSkqVFfHS5e2mHe/iC4gP7WKExSXZQ4z9lSk/QxLE9Xa9
	 4gG5QNZQbVRG83inweug2unjHDwWTa09qeeKdfyQ42H1dOSqZ7P5KKp42t7vMMhT0yqDg
	 gq3ElwGZsiNjQDfQo3G7d6ZP75HNBQOavgvf/Rsrig35SQCyxoIS1AwA0VMqMATkThvlB
	 /lm6S6iRwFNEIZxQKurWmwPogIEKTd45waEh2kjeme4YDUx0yf+GGfQfaLBjDSZ/v+l+7
	 RpEsbErdEG14pQsh4DIIAIf3R/7ibP55p0n0W+ONgyVsW1iMrb7xkz/B+ADG3zCvFWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XPn6YHW9;
	dkim=temperror header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=h7ylYXOz;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D5A606A31D
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 10:14:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49D5A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XPn6YHW9;
	dkim=temperror header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=h7ylYXOz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793268847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g6ZvoJA1lnqkwFVkrQz/iNNGer9RaAvDbUj4LHUnhUI=;
	b=XPn6YHW9DhQDS2o01aDR7o0dCOnq6CquwPB4VX55o1hUbxdWsfheCQhMdnVytLhkeNBxIk
	qxRTdx0ETjekO7E/HdDs++jhLVLjz8XT7ZMHX3qZt3uC28+tjlBU03IFenZ2OHNlxssXhQ
	yTfS7NJGpImf7kTMHt/t+5gDhnQpfCo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-lU3vIHTGPhuvVz8cTZb11w-1; Thu, 29 Oct 2026 06:14:05 -0400
X-MC-Unique: lU3vIHTGPhuvVz8cTZb11w-1
X-Mimecast-MFC-AGG-ID: lU3vIHTGPhuvVz8cTZb11w_1793268844
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a4af69e06fso14103145e9.2
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 03:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793268844; x=1793873644; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g6ZvoJA1lnqkwFVkrQz/iNNGer9RaAvDbUj4LHUnhUI=;
        b=h7ylYXOz2UEdPWY1fYVL5jqH4FnZo3/o7js8VE+c/8/gAN938wWuh3nsk052MoH7p4
         VUo348ObDvXdzkJm0/SeUzsJ5m/fx0WbXiyB2sWmuKip59WMuap8Ih7pNkz/tUElCCkg
         r1hZtXwv0F5wdnwfFGzkdFpJnwS5w+U1E5iabmrHmThpkUTw4/6uDvm1ZTzdQdGOkNQw
         f29jlZccEfymQux3/Lq0XpMLvscWSlGh0BrIfiiuxxTW+NMMT9NmOqMjXlj25njsrJTm
         Tl/J9cGN1L3z7lzyz0Or4HMAG5vZS9W8A7pT2CPkr4scbUY1sDx8nQApFziLLPZLQpPH
         9lpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793268844; x=1793873644;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g6ZvoJA1lnqkwFVkrQz/iNNGer9RaAvDbUj4LHUnhUI=;
        b=rtOr0fEL62aJO0XtsinwfJV5QSJsb6HrlfsRCtZLDkADV8C8CMJV+bcqFqK1VI8lL6
         a0xQkJmdP90uXT0TgGUXegstLasZscghq8sSDgazB2/GRe8kjANuLtxGZ2TsBE+HvQJY
         DVJ5HSshzmWUOgo6AhIohsi0Yg2GwqrfTxkeXEqCbUVueCKeMuEbHIdPeDiDsVQfDmbW
         mcubPRlsdijbL3P6rrbrJHPn6tDbmKYVFoSey9sDAWLucePjz+OpcflwOuzjuV8jmxE8
         khfRfdl3O/V8hJbZBpnaM5wuEO02cgBophppXw8u0eIS5yRcaf6JYn7hyszxCDL+h6tM
         YqWA==
X-Forwarded-Encrypted: i=1; AKwUvBwhXNkN83r+YO+JePe3ARxr5rVpqx7o9waaUCmF8rky3SKEl8/l628DFfmbD7KCdKpth94=@vger.kernel.org
X-Gm-Message-State: AFq9FYJH5PNg2VmAWyGfcH73frxH3E25fQ4Lsg1msTAoLhUmKkeJK1zo
	Ipd2f1S8y2R1EIb1clpwQ8OpEe8n888gjBkKKeiYnMFyu+k6LeGyWCQr8U5Dzt53VTKhZ6tRcjQ
	T0gZ8b8VdFM/gqQYKvDNCecBeUVMYSrC2s7/qghLrXfCVc/2Kx4tr2A==
X-Gm-Gg: AYBFou34x3fJRphtp9ciTiCnsfGQ6afS+1+ddMlbKtQ5beT9C4EkFQvgqZu/CtiMsm1
	EzQFmutJUR3G1gPFwjZHwA+9DLCdQ4cSKx/tJWIQQdw+hzdkR1nsnMINXDN+UEMo76T9IeLgL1o
	1MJryV3lDx2WFkvhe3UVGzh7Lcn9LVc5cfXIx9PBAbX0nOgAdHkL+lO5WW7SwpbXjhNwqlh0Tn2
	mVqkYMwudd4Bp3zK/UMljI+pOHvg8JPNGDhnGyhqo7pF4eVxwTpAKkoMEUA4JmhWsBZcMjU0vis
	/T7MHdjWAAXOptRaT6zaoXRXOm8JohkfYxNED3Xv9pr42HhwMRJ3EzRjMdi3IWSRtviiCtuAN15
	6eZU4E2mPPMNS0hyvuwi6o9xteD6bU7uNtWx1GrazXsGaHsYO2O66eCgyWXAgKxZlczDJOwhclL
	Qez5fxkruQjgFoUw4bWBPPAPsLQWS+OZgvvGEKjgKnEOILSoQ=
X-Received: by 2002:a05:600c:870f:b0:4a1:fcfa:2a07 with SMTP id 5b1f17b1804b1-4a967f84822mr125620615e9.30.1793268844553;
        Thu, 29 Oct 2026 03:14:04 -0700 (PDT)
X-Received: by 2002:a05:600c:870f:b0:4a1:fcfa:2a07 with SMTP id 5b1f17b1804b1-4a967f84822mr125619965e9.30.1793268844145;
        Thu, 29 Oct 2026 03:14:04 -0700 (PDT)
Received: from [192.168.188.234] (ip174-129-192-82.pool-bba.aruba.it. [82.192.129.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdd5b3sm33496102f8f.53.2026.10.29.03.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 03:14:03 -0700 (PDT)
Message-ID: <bdc71cf3-5b16-4dbf-ac33-8f35b1a97d9f@redhat.com>
Date: Thu, 29 Oct 2026 11:14:01 +0100
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 2/2] net: stmmac: Stop Tx queue when
 (en|dis)abling XSK pools
To: netdev-bot+sashiko@kernel.org, kurt@linutronix.de
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, kuba@kernel.org, edumazet@kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, yoong.siang.song@intel.com, faizal.abdul.rahim@intel.com,
 boon.leong.ong@intel.com, bigeasy@linutronix.de,
 maciej.fijalkowski@intel.com, nb@tipi-net.de, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
References: <20261022-stmmac_xsk_crashes-v4-2-15c0c750bb96@linutronix.de>
 <179299947058.3134.16617492920924670801@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <179299947058.3134.16617492920924670801@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/26/26 08:24, netdev-bot+sashiko@kernel.org wrote:
> - [High] stmmac_xdp_enable_pool() (stmmac_xdp.c:59) and
>    stmmac_xdp_disable_pool() (stmmac_xdp.c:102) now call…
> - [Medium] The patch only works if __QUEUE_STATE_DRV_XOFF stays set from
>    stmmac_xdp_stop_tx_queue() until the ring is rebuilt.
> - [Medium] In stmmac_xdp_xmit_xdpf(), first_entry and entry are read from
>    tx_q->cur_tx when the locals are declared (stmmac_main.c:5263-5264).
I understand that the comments raised on patch 1/2 are sort of pre-existing,
as the reported races can be reached by __stmmac_release(), but the above
ones look legit and unaddressed/unanswered.

You can target `net` with the next revision, and please reply also to
already discussed comments, even with just a pointer to the previous
discussion.

/P

