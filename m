Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794167602;
	b=lw+6kWvxij7SkAWShDNZgh2O2nGpQ/c5r+8EfovVNzCEiF1hQdiY9N6df9FKP+QUsN2o
	 rwp4PERkfJimCHBgYy4sa+QYBGLnJY8/dDrKP5xHGUwmrlSPxHCri3mMtdf4khpRxkoSK
	 YwZ4PuvsthETqouZG4eKP67vVz6qoI9PCkNv6w5KA1DDwG58aaHqpU8D8u/95NyqFmq6l
	 bkOHdIN3cH4c0/guw0uaWOt8/Al0FXD+IheprXdreSQh6aIU1ctXdvOys8542/ts39iQD
	 kunwSwx4XuyQLZJlpZil1KG4UyVmpnaWfBW4QKTGpDzO0LVZMdvsyrcGolxP7s3mlSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794167602;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Virus-Scanned;
	bh=Ravdk8H3Z70kEwXonw9CRp+OeG/Mx3E36w9XSyrBJWc=;
	b=KhaeqlXTzEVSunltOHzU2qsluN1a5kxh5PXUiCcrnALKkJk43hsacvP2iUpTkP0YZDNe
	 AG562a14eNL2FunGc3epnUpTn4N61ZbTQgdv858t+SWrOjrLm6IehICa7/k8JSpuW1IlX
	 fM3yVm83pcZFycibb9nT2Tn4CMfJBXFop3oHaLat04eKBN6CHzSYMA8//Q2eIY1SCWyeI
	 WVrkghHbzb+3t+KjURnRsvGvK8swxjtZ6WDXrt4+HbyfMyy1ji8CtAhA6oKHkgwroKbj/
	 1sH0WcTdFONefaX0QWwm7jtbwosV0SAVj64wH4JKiZ+mquQ7fLv3KhGkDqv7OhT+Duw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=V1Oq4MwL;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E31606A320;
	Sun,  8 Nov 2026 19:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09E31606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=V1Oq4MwL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Ravdk8H3Z70kEwXonw9CRp+OeG/Mx3E36w9XSyrBJWc=; b=V1Oq4MwL/sOEGm6ObJOTW1RCsf
	sQWyRM7UmxErA/xn38dNRT4RnJ76KJeKHVFnEw6reqSckiGNS0b4jDwhvD0PlYDDxISb9VdKY3KSy
	wK6kpXdvbfh7d8lfV8zN53gOof6jOq5NeUdvMszFPyv4IZF2r6XDAsa1Yudg7nsh9P1h8dMXbstOC
	tus8aqhHTCBYBWPmYF99fdMhM/RqaHt0EDe1zAFz2kK54JKLasbY1NJ9fxO+mhHbDWY+vxelAi1kD
	+vbk16HGWQJw78HxnOhGw/xCzgJZUlyokspxRRDqoO3kiK7wUf1msEpbwZQAG2spDQizKi9x5QFd4
	IsRtwdtQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xQ8x6-0003k7-0D;
	Sun, 08 Nov 2026 20:53:20 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1xQ8x6-000GOk-0I;
	Sun, 08 Nov 2026 20:53:19 +0100
Message-ID: <a7605e34-15d4-4bc2-a424-fbab47d20bea@iogearbox.net>
Date: Sun, 8 Nov 2026 20:53:16 +0100
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
Subject: Re: [PATCH bpf-next v3 08/24] arm64, insn: Reject invalid and
 unpredictable operands in the encoders
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <cover.1794165614.git.daniel@iogearbox.net>
 <a039fe7efc077061852c80b14b6ebcc81cdef75d.1794165614.git.daniel@iogearbox.net>
 <sashiko-outbox-203981@kernel.org>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
In-Reply-To: <sashiko-outbox-203981@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28177/Sun Nov  8 07:23:52 2026)

On 11/8/26 8:38 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] arm64, insn: s32 offset truncation in aarch64_insn_gen_adr() for
>    ADRP
Not used the the arm64 JIT, but I'll follow-up with a fix for this case as
well once back from travel.

Thanks,
Daniel
