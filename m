Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792617289;
	b=YOd1z29nIDjfAC9boSibtCPSXbMrA3G0ubkBgKHwHvdx9Nd8oz3FassuB3rNd5+kaB6Q
	 4EPHo7KUHrwxzEYrLDu3Z5hogAQvTYJIM4CWnxIYN1ZBMiSBUXuTutoBO2hFRMj8xmcXf
	 ld4ygBfGxYVtUZxaOhnMgugOESdfZRrbW+XSwHBTNTIwhKpSV4Gq1SRmNlpO8Vwah94ln
	 q8++3rn2N2aYuacbOsgZnBm71urBTwIUhchU2YQH6ge/jbBk5DXu5FEodrSYUUFw3p+do
	 D/D7Jny/vnP6yU47pauBEjnDRWLX0dip/gV1fjpmCwtWjP7yOTwoxh099z8jfVYdKxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792617289;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=FAsKTM6LPOGOcL2qFvuxDOlj2gulUU/As0ETzNiEblc=;
	b=4YFbGaDAQZoNXPd75szFBya0POS3xq43yIqJj7dnhqUq3WC+iHxjvJOlI758xA08xPSP
	 /zswbLlEunaY61B8n+sQVlyYNV6OKLE4NDiJRcWWbhYE4TykkglIqJ2SMxrnxPVfUhN0A
	 V4KR/v/jBfrIP49x7TLuknXMrVgc4xoxQXdUmSKHZbUol6zq+KemtE8nzg4Of/RrCh83u
	 /3UeeHEvOsQMHPaepJ3vgaRW0em1AIzwSB0eTQOmPZABMOf4241f7G7SaWEAWJm/a45nZ
	 +Pvd5fhn+/SsFfy4nYiniWQj6oa95XC0tUG6Dyhd1ISvQIalVlqWEgEKgecH7iwbkFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JogChtiy;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A06A606A319
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 21:14:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A06A606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JogChtiy
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3a4b3ac8fb7so653418a91.0
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 14:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792617289; x=1793222089; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FAsKTM6LPOGOcL2qFvuxDOlj2gulUU/As0ETzNiEblc=;
        b=JogChtiyC35NTUb/CYn4w24zdLOr+oHVwYsamhg1aI4w+Cbzbd6wPLppeL+9mEGQvt
         /Ve1nZ8fuNZScHvsfmGaDsayuOXNogrFsG8uXOyuYwNfqUQeshDgUS9KgTXbtIaxL7tK
         qCDlMNwrxheE0D9d9hyUacmHV3CdlPkrEEjlsgK0PT0e0RkCUDsDMO2Fdew//Z2Ntg9N
         ThmTXCIDa96FRAJLgkPkn3jQkB8ar9u55f0Mqt4tiUZlPioBVaahFmcFIbNWBgiP1At9
         BLgQNY+klrIJZTFj1l1uY8llEhefuqfBvrVYF6q1hMpJAJjrqHRW9wd/xuOO2XHuXleD
         YWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792617289; x=1793222089;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FAsKTM6LPOGOcL2qFvuxDOlj2gulUU/As0ETzNiEblc=;
        b=2qTr0EQn32wrtLOud38dHbVBmsZ8XoF8DmHrq0f7gtF5SL2JHYQLtTynXJZ7CFem++
         FTtbY6d5M604gSaQj6XGpaR0t8lqbDsWdRUh7FmJqsCkUJygA4MlNw65l8S04LYMMYdH
         0RNOso+XLWwgFBgwX105tE+6+AZ5O8qlnaVBSDwYjx22eOyRthTwQfPQQSCz4fuWDPrR
         bXIzKVswx5QeUG907w//znkhly4eLxs2KjdkxZ0/oy+NU103e+ZNHGWSa8xZ3uo/2h7x
         Xt71Dn0KJZPq64O+oONatth3Fc8lNIe2GXEltlB1fkH87OiFpOMYuOhxnV5u7BkAxNAI
         pisw==
X-Forwarded-Encrypted: i=1; AKwUvBxVbdDtC5P+yyozbfPvE30PJGMAub7S8dcIKRTJ/IKZNg/8ILbvPqDcxHKHvSp/mIrkUFA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLp2dPVXec/M6cf07sHR3soqWNdmKr3d8HUXubIhehjrxAvRQ8+
	D+MqirppzSblqr6o24o4StLSsSC3VFwPkIJqzRw1ECTZ0L12crUYWbNM
X-Gm-Gg: AYBFou1fevOP9bOJZnybIdFykFAw1PuY520plvfTlg4446gpy8ffR/Dhre1HoG3Tqr9
	oXmHzSPgqV9Ws5Vw6HKdYQxhGvx5u9TyLU9dFFAqU0gPfo9mduKYnj/jZUGygE9Lp3+6d9WnkFW
	42hKONxspEIW3rS812fds0aPGquuAxNtAMcc98OnqYJGQwhh9teigOgsJRVEANbyjXt+TWXDv1d
	/JNddXU3qttRdjRndONwmQxLN/qkRqgDUmxrX60DspfanW0OGIpkN/4cRdo0YlrRTkS0U5b6diE
	VEHvkGzHdnNkTGYYgoqws1dko0X/fk/jqR2CkdjGf8JagLhDZCOFObi3WjSoijZYrSJ0FwUz4hY
	g5mwurNKphkLFqUlyQLVuHHgH5tSVo6rSY6TEFf5dEAqG/5DExsg8fgblGGghjGe9QaOFqFSAzc
	eEOwXRGs8XjOWPwgXDirHzW/WTbf7aBOQlmXKY/ts8FivCe/bfnemT+U24n05LTRVnE1NBSmk7e
	+4tH2R7p8Fcmmr1uuUyOcvi6+I82LSetqPWhUBuE0QCGvEnZuZ9flnEzRY0+UFjrvOxg1QEHZqS
	JLBitdBWyt/Tqqqs64c61RTGC9vCz6T/THibME4sbI/ZIgOsj9jgT9yWJOMBnw==
X-Received: by 2002:a17:90b:580c:b0:3ac:8ee5:e00f with SMTP id 98e67ed59e1d1-3ad86cc1a23mr2497296a91.57.1792617288777;
        Wed, 21 Oct 2026 14:14:48 -0700 (PDT)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada4890bb2sm1028954a91.1.2026.10.21.14.14.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 14:14:48 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 21:14:47 +0000
Message-Id: <DMATSL8V8543.1SMETESUIHO3A@gmail.com>
Subject: Re: [PATCH bpf-next v1 0/7] bpf libarena allocator improvements
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>
Cc: <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <daniel@iogearbox.net>, "Harry Yoo" <harry@kernel.org>
In-Reply-To: <DMASTFVS9NFD.1W46I66DW4NHU@etsalapatis.com>
References: <20261020181900.6755-1-emil@etsalapatis.com> <DM9ZQ59RPJ8P.2S767179JJRCC@gmail.com> <DMASTFVS9NFD.1W46I66DW4NHU@etsalapatis.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Oct 21, 2026 at 01:28 PM Emil Tsalapatis <emil@etsalapatis.com> wrote:
> I think we should keep the transfer cache, because with some finagling
> (e.g., checking the transfer array without its lock and dumping a whole
> batch when it's fiull the second lock during frees) it helps for heavily loaded
> producer/allocation configurations. This is both on allocs and frees. There's
> no config where dropping the transfer cache provides a meaningful
> speedup.

Makes sense. Speedup is worth 75 lines. Let's keep it.

> I can send a v2 with the transfer cache still in the patch just so we
> can mark the rest of the feedback as addressed and to make the updated
> design more concrete, and keep discussing there.

Agree. Pls keep it as a separate patch on top of the buddy_free_bulk()
spill and put the numbers into its commit log.

