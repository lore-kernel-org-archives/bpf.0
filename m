Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793578609;
	b=kLKjUM9KUnQF+ibBLOl50GVb1n/fAmXyB7e+N/s3+FHzrfSFbmZLkovvJkzq79Ab3hBr
	 BFgg32bfI7xR02O0r6cTCVLegZvT79b2vS9PUuPI9RzlQvoTw/5Msm0OF+O3ZdukAXimV
	 MwcrsslGPqrP58op0Rxzv7QSjj9YRbORCvlVxiTquaE2L1KN1ZPkxgbib9BgpcloHYfe0
	 PCWlfDrNWoy2vE0W8wHAsGLDtZHcO4xhut9J0fyT0TmJjk6rn5WRtKNWXC83/sLIyey0a
	 sM59hLEUrX8jZSRZgJSy8qsxj9CUV5EPGqXb4vp79FCtuboKTtnviGU1p2CD5CD1wyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793578609;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=mozC9xUwsBeOwQ4lriF7JYk3bRm59v0HIYqRgo2OnDk=;
	b=OSkMHnbo7QuPg1HFvZ/vrVYonuv+mlBeThI5QZIbnvArZmJuHScwjUdUPG0wiSGrEDcp
	 owHTUIltAfLhZoabYsgkCHH7Umpn9rXP2pM2rORC4E/MVbol3X0g/6EqE1uuiKmbVmI/i
	 bYU+GGToyskkaDTCVubtMnVfHm5sq+nXw+pTslgYF9Z+/y3YJBoaQb1i9a8shzQ4cXxJ1
	 PndsYmhjtgJMILPpaQTUDQMMTokFfsxbX1grS5ETAyiF+pAeWtVOAomr3EzuK8H3INhXi
	 2OEv8sJR8oY+/vZLw0uFRSZRdUTAHh8CZhV4b+M3VzqtEE7Flopww653r6EJPFEJrYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WPo3mEYD;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040B3606A326
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 00:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 040B3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WPo3mEYD
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc7e79c1eaaso799133a12.2
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 16:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793578608; x=1794183408; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mozC9xUwsBeOwQ4lriF7JYk3bRm59v0HIYqRgo2OnDk=;
        b=WPo3mEYDJwXZ0UINs+yOswpbyjvoLJGG3YlPr1DAWBzj4FbCL83SjLCragkf6rr8WM
         Uw47YZ9aWEEVoRqrr59hdx1a/2T6KN/8wogO0nAf7n6tYVgiW5N3c/BsAH8NJbuGYTB3
         ZXRPBcTAHdpKeq+yKAn9VFU5mIDvIweBX00b/iatE+451zK3+PSmTLFwrG5+ktwoJ3jx
         tE+s5g4B81Wr/tUjdatg//VD7grGG7JbHGapfcNzQwAbi1r9UgVdwFqt6Pi31ScjCv+Y
         pB5+ultysV7bnXgaSgDhuupYLhyDKRSAo1EsSMgwX59bFu30Oo8N1A6OfLdvT2rLjv25
         M0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793578608; x=1794183408;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mozC9xUwsBeOwQ4lriF7JYk3bRm59v0HIYqRgo2OnDk=;
        b=J2iaF6K827CgNiXJftvoX662qw4rdwBQ/K7DMwpdEJzVgPPrDibUeocug+c6xO8qTB
         dkbWuC/ZAsUYoxBvWjdB2QIg+FKW5okPnb1MeHLMkIIrMN2ik9XDrjOAB/qWJUxHa4K4
         O9blb1/3bX9ZJ04pqmViCbicU6YHHmoKnEwr36iX+Yx8/mtF8hq/69jS5f5Th6lVqSkH
         lya94mM9+qaB5bKk/o7ytyaJQc3G3hJrSSEc0dGJ6eox5n3qT2bfVTeNFl11lvhM2/e2
         OQYXlxSyD4P29WCpcNwD6JlTw7ktGUhQ0HNOP8nSd0qKsovsLqqqYfvU92tMx5yUSTHD
         Y1mg==
X-Forwarded-Encrypted: i=1; AKwUvBy1d7LkjxpY73Kc5VNI5EjY8VXH2gFFI6uM3eEBKiMe6BMKHFpkd9E1G1iuB06iCg2+Ngk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+x+qRdafKlnP98OyEDCUlFCVR7/+u99PnDCH+5F1cyyK6liYB7
	2XXHjB+AU7MmtGEAJxnlpQuJMw+hnXeg4lK6D75dMp0MqZHaUosbuNGBfuwLFA==
X-Gm-Gg: AYBFou155BWWTGK/I4Q+EUZBdokSTmgr1prN6Pa2fzzIjLsZY/naXIKrbiyD/hW9WBJ
	8htfakC/hCPtziF6empMUsPhF3ma6Bf4bAbykyJYbsjfH0giSLUIL9G4K6xS9byV0+PpWU3iTjh
	ojV7rBIiO5EVY45AYolWig96geiW057tGjzCVGfnIEBfGacGIriS/yCfS5uxCwCEMdFv2ZbdEQ1
	0cbLhRPu9efpO8noY2lLYTBHKCrZStkXRHQc7cQIrzbHcjzVcCWZCdJCxxMFHCe+0nAfmWyIFOe
	RETBqvz+GY1w7YgQ8VOt6Q3BmhsBOycWPp2lKA9W+h0X0/n3mDOhmbQ41sVNoozjcvqd85enIXJ
	2qgGBKmhRs3/2Qsm3h5eafFVKR0tPF4Nqr0y/LRIev7NPLekptw9DpgNqwPv3D6QcvpHIM/RGPd
	LkrgWwq4Hc8S9WGDmqggsphUOKEY2aSOqwESisDXkE9Q3JZcRBj02rGb2U7QSKsIpPyK+llJhIl
	DEThGGtAbd1F7ve7f6AIYo/2rLtII5czBij5o48eJjfqx1WdDTYXK70PYbGGY26LhvX0lzJWtuq
	2hPts/4eFi6vnl/kWbQVdOb9uw1IWgXl1iVUDIvzwb/U5nw5wT8MidF+amJHAco8RLYvVAls1ne
	j2LHxmEfdSEaFJdjg+BuVrxuATcAWFFs4Edc=
X-Received: by 2002:a17:90a:e70c:b0:3ad:a232:4044 with SMTP id 98e67ed59e1d1-3ae8979969fmr6431543a91.38.1793578608316;
        Sun, 01 Nov 2026 16:16:48 -0800 (PST)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae85f3e087sm6950889a91.1.2026.11.01.16.16.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Nov 2026 16:16:47 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 00:16:47 +0000
Message-Id: <DMKAJXEISH7G.1I34WXM92FRMI@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, <bpf@vger.kernel.org>
Cc: <mptcp@lists.linux.dev>
Subject: Re: [PATCH bpf 03/15] bpf, sockmap: Don't let an SK_PASS verdict
 cover the next message
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <sashiko-outbox-192629@kernel.org>
References: <20261101192057.2296489-1-alexei.starovoitov@gmail.com> <20261101192057.2296489-4-alexei.starovoitov@gmail.com> <sashiko-outbox-192629@kernel.org>
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

On Sun, Nov 01, 2026 at 11:42 AM sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:
>>  		if (unlikely(ret)) {
>> +			/* A part of it may have gone out */
>> +			sk_msg_apply_bytes(psock, origsize - msg->sg.size);
>>  			*copied -= sk_msg_free(sk, msg);
>>  			break;
>>  		}
>
> Wouldn't Thread A subtract its own sent bytes from Thread B's
> psock->apply_bytes, and if psock->apply_bytes is 0 when ret == 0, reset
> Thread B's psock->eval to __SK_NONE and drop Thread B's psock->sk_redir?

Not a bug. eval, apply_bytes and sk_redir belong to the socket, not to
a thread. B's verdict ends early and the prog runs again for the rest.
B sends with its own reference to sk_redir.
