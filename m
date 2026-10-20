Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792519102;
	b=4IIDn2OyHUvwyJ5cPsNVck6nx8THHr8h0HWZv0dHPFb0w0Ik1t+m+IwIAKdb4Jl6ln1R
	 0qBdVdMJZ5rFU68pOI66m40skn3HJt2Gy1ivLqCbqBCWKm5Rz3WeUL4k78fen6WhT4Ray
	 29luMXOcdXOQ0WGZEYDE86Z3WpC1LpACcdjYVRKWu2IQQCgTGCJQxNRlha2f3PfUZlyzw
	 JmCivExghZqD4Pkj+j7eXBxkMPmG3212HYdrrBvonDdTR3z1X3JFjQc6FFAOhffDHr2Fj
	 WUH420LuzaIjEOZJL+wNB6MPMrR9Mzh2pna0QauF1jeGRnM6snsL9JCy5kh8AeNNLhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792519102;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=lfvzxumMX8GZYmj1PJHBaPnkGMwtjZCWGV30UbLz0Q0=;
	b=aPT7dM/VT/CYw+7SXac2CDca3WjOwOCrfN5asTN8nlE+Xtvy+J5FIpYB5NJuht6xBqTg
	 tAo/NIGUU3Fo78tJur/UkYW4a8ofBiro9GctEGwknm2mlMHljZAsJWUA7QzCHPCeiBSij
	 o32Eyu1r1UaAq2TiLktDbLzq0l4UsP4ma8XPStiQJZ/a1wSePmY5t35UcSyzEkF7FV10E
	 OTlQXr4XeKIMoTcfDnRyKbPDu/5gNCjc7STkkrdOtyoWpUwWz5/iyfk/QorUmyfT9hSv/
	 jYfR6q9ESLRYgr/PVuChEeHvvTklatZrub2lNpoczeY72U7dDDjAi1ak/nwRRGZxWCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="hk7DKm8/";
	arc=none smtp.remote-ip=74.125.227.136
Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C2B606A320
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 17:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80C2B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hk7DKm8/
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-3ac749e0719so976523a91.0
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 10:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792519102; x=1793123902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lfvzxumMX8GZYmj1PJHBaPnkGMwtjZCWGV30UbLz0Q0=;
        b=hk7DKm8/HVQtDM7SfuNCgwbY6d9oYkVDTzKvh3xFFVJcjWgeTit4nQ3APKC6JcXMvs
         5b1sQ076nR/cD60jiZzZnASVUl2A1IZZGCAtZTv89HFO9xMKTFkmD6zhLqjP8L3wg7YT
         EZ+XvNHUBXYD7s1wo8gn6iYgnI1fN0liSodgV4PIsesSa9bemHyZzT4hLir3wzeKGmpn
         2cfYdmBPyJQrErJTZ2N9KyeYzowC/aQbw4VYo0vWXFp7rwMFbz2ltIGvlLTQQcEQD2Dv
         OdgjfMkoZTll+JU+ZxsujBTKAj8fDZLFfw03WYAg+wLvoNDOd2pzWmEdC15h4Plr2owA
         0SZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792519102; x=1793123902;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lfvzxumMX8GZYmj1PJHBaPnkGMwtjZCWGV30UbLz0Q0=;
        b=AOj5xOtENotQUUSWbEM10OGxVdWRfVQ0MSnLp17flNrPh68VmDz30jgJZgvmxj5bqI
         qUeS4D/fe3oO+C/WIIkVposh7Ynp/gCyfjnNVpkYpRAZGIhGHm1hve9vOydUDNxxR3GQ
         vkdlKjkVnA3kVVLeZS8ppykUM5yd4Yq1lmUfhJiJfRmy6BYl4kEUBq8mWeW+5PQi1QhB
         3PT+Zv0YlNHT6DoB80awEFp29qEBw75HhdBJ24Vy96jme7fEONPM9pNwYXWMtoOB6D5v
         Wpkrc32DKVo1uJMyvzsm/DRicpQ+Ih53MHegeyb75ByMEytf2T3YqYoLqMD+0FRd0vlu
         uf4g==
X-Forwarded-Encrypted: i=1; AKwUvBxzCH/ggZIi4+iO4JGxiY9xvGDiAeDXcHPUyoEhEhrpsnkHxuXsdbOz5aSveOYAIuuem+w=@vger.kernel.org
X-Gm-Message-State: AFq9FYKBBT/0E6HRcvBuMMhJt70YHUU3Twnb3zGyWfqIRICbUp1Yc3ko
	ClB4+ekaal1OiGiv7/wgQu5s+rsGcSiDf1+WTOIu2FvaAnU1Xoi8uUKE
X-Gm-Gg: AYBFou2WkEMnuBIVzXS3k4Irec1iAlLGpbrnO1M31w9AmOj5ADPaFz0WkYx4r0SNpHH
	8UX0rALcVIqTevn4FnCmbbD87tpFi1bi34KqIUZX5BTorvFlRB+cXzE7zafxpkjXGuL4toMyu7U
	vaE4CDrPK68PAmL2aNBOBZuI5XVDgg/7gav/2ZGEjTTXIRzOxpHtqYf3rayJi+bXRHkQTakrk1p
	dX0x2mr3h5hNpYiYbtaYzdzfhKr63tLtDx6Z2VxydFdRDny61aHDJ/frAY7tOlbJ4KAnIVQ764T
	EwD5UWbjhtOfQk/HAzprGTNCpIptmdqK4yTn3t9gbwEC6q3tkr8N1ZWmdIyPWSUxHTYSp/LJ2Ci
	Rf24jc4so5UBDS5KHUaRzlMO1L6/rytnwssIzewMcDnJP1aaMRkPW04MTHaqZg/6pQ4C7jlloID
	t+l474lgKDQVDDDfnirKvDGBYSEEQL2Em7Z1RYARULpOeQ2aRQjXeFqmwt1yif2hLQoBwdPdrsw
	RGfKhL761EAEY2fG/IPxPVMe9eNb1yYssq4bUrzpT5w7cPU
X-Received: by 2002:a17:90b:4b09:b0:3ab:188b:c5bc with SMTP id 98e67ed59e1d1-3aceebb4bb9mr10542274a91.14.1792519101713;
        Tue, 20 Oct 2026 10:58:21 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:6::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad82f0c0b1sm133581a91.0.2026.10.20.10.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 10:58:21 -0700 (PDT)
Date: Tue, 20 Oct 2026 10:58:13 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Willem Ferguson <wferguson@cloudflare.com>, netdev@vger.kernel.org, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	ncardwell@google.com, bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, linux-doc@vger.kernel.org, 
	corbet@lwn.net, linux-kselftest@vger.kernel.org, shuah@kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [RFC PATCH net-next 0/4] tcp: carry a BPF-chosen identifier in
 TSval low bits
Message-ID: <atekzexnMd27Kctl@devvm7509.cco0.facebook.com>
References: <20261013103906.2660384-1-wferguson@cloudflare.com>
 <atFI9vl5hy09Dc0t@devvm7509.cco0.facebook.com>
 <87a4oaf3mv.fsf@cloudflare.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a4oaf3mv.fsf@cloudflare.com>

On 10/19, Jakub Sitnicki wrote:
> Hey Stan,
> 
> On Thu, Oct 15, 2026 at 02:45 PM -07, Stanislav Fomichev wrote:
> > On 10/13, Willem Ferguson wrote:
> 
> [...]
> 
> >> Questions for reviewers:
> >> 
> >>  1. Is encoding an identifier in the low bits of TSval acceptable in
> >>     principle, given the trade-offs above?
> >>  2. If so, what feedback do you have on the implementation?
> >
> > Don't see any feedback yet, so from the top of my head: looks like you
> > control two sides of the communication, so why not a custom (bpf) tcp option?
> > Would you need that on every packet and it makes it expensive?
> >
> > Or any other field you can abuse maybe? IPv6 Flow label?
> 
> Nah, we don't control the client unfortunately.
> 
> Client here is any device that connects to our edge PoP.

I see, so you rely on the fact that it gets mirrored back.. Btw, looks like
there is already some similar tsoffset/ts_off infra? Have you considered
plugging into that?
