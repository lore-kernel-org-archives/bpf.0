Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793759564;
	b=hz3VgZaRw2Eyc0lG4SCDCZ4IGFZFFaILmcdNv4lfeMs6K/GXTVMgpsmVc9LL2TK9s38v
	 e510SvpnDvko4xNAoFOakVSmtc8bj53a8Wx2ALwgwUGO/ffjcbf8hvTl1gHcH2SsfG10Q
	 xspoqkBEMF59g7FBqpk7sfQgUyB+ys8a9qovcEoZmEif2bPjDckbAcHF7Vm6nzwalhKq7
	 imtTH0KTlFBiKfoQfV+bT5hmJfQj9gbLc2K9f816soeVeUM5bYnhj6NMPEHoXOcSR0SRZ
	 NeE3abALZs+CghtsIpFm5h8OvslhHOa/DqM3OXrljd8JTncFgAI07YH94X2+W7s+8Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793759564;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=EpeEKBT2i8Xv42sIU/6Qhq6U7Mk/eS3sWEL7Re+cAEU=;
	b=ddD8o8uVPLBBPrPoAtjoJtnOxQ85EcYCncZduxZAh6z+M9PDLxw0+TsoNYBJc7yPHtHY
	 e8dvGFEAIJLHgwmueYXdVBaxpF0CtlcTZeZy+cG4i5fTPf34mqiuL57eTyoG9I3ebW3o4
	 TpWp28hkv4FvYMsZSNC3O40Q7ulD3jnSGWJ+2DXoGHA2aAwd4uWjQ1uDPTdiVOTzXNFj4
	 VkCTmfr8uQ4JG8WBUz/QaWKJHaDp9iKObO1CEwkY2M1osSdLTMhR4ZyYHUgqrUVU2HsVk
	 4qdS+uQOkEDJJoBXio8h1jL3VglDQoJ3OXk6Dw2mbLKjAtCn+uBE8HoFBTCdhTtnlPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JBKwVpQw;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2A6606A326
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 02:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F2A6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JBKwVpQw
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e946155442so1651995ad.3
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 18:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793759563; x=1794364363; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EpeEKBT2i8Xv42sIU/6Qhq6U7Mk/eS3sWEL7Re+cAEU=;
        b=JBKwVpQw39lAIPOTcLNMcTByMDKI/qifmz2Z6OIbdfHF0xLdHPKpsbAQkcWXHh6CXk
         2yUfDAgmTJqfuVhUmqNhhRhbKXe0aTc8h5alZPLu+ZpCL7Z5Wh6FrIW3f+HaMOrUIKAj
         xS9CKclqgSdAcybz41sxDnecuJXvnos1EghEF2H/DSjfBKLmqy/ODb5BpWJzn1m0poRS
         Pp8L11SyXWGoMPf20XoP6OCOamyDP97ioRzlcFe0P4HRnAKENFZkZoxSdZ4sPsPZCOfN
         3mAQrwdveLAuL562uRkV7eqIgnV6b+kGRl0pQeOujygIFqdrKzz1xZkhef4w/zedvdXL
         bAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793759563; x=1794364363;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EpeEKBT2i8Xv42sIU/6Qhq6U7Mk/eS3sWEL7Re+cAEU=;
        b=MUxPrXuQlNh9N/noo6fm57VCO/iM43vHYfV7IvU6ath9mhd1q7iW1pt6HZ7N0Pmwgm
         J0ZvK9D5axt3yj6M5Jsjri/Y2E8PEYhwfNsOMyJA9Jb7JtOovBmzDuyXKa2CIIQ3JbYa
         Jkre0kL1C094ixPfno0Amy+bnsrgaWy0saqzA5yXkw+ZKRr35VMknJI/jDnyBJJHmNkX
         aOuG/+2tDHvqAol7VpJPB7SFO/Qu4sS4Z1NK7hBc0oP7Cw5wyijJQ4qAjTwvMnbuYmYc
         YAZr6ffrfs1h/KRABsnhHmlJkYwST9WH+GoUkiyZRiIjeFxoeRx0XqGnefMj3GGTtRvo
         lM4Q==
X-Forwarded-Encrypted: i=1; AKwUvByoRzSgh6sx9LfxqyMFwJNFAMpO3WjChkyspt6lQIA5YkgXASFxEPcUeYsiGh4kWwBbjeY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8z44O6UdI1qByr2/W0Zq+vdiQ+3wFqTyneY4biqpMFw3Qo5olc
	mPbegSbK/svj6niOYHLgODlIxiH/YcdgfvQ5CMicl0ATR5KyMfHHIYT5
X-Gm-Gg: AYBFou2xg9+VwJgbtI91QDGPkx5vrvtCTpimZmERsRCGsXG7OcBLL/4wFCrKP196dm+
	8TzmKykf9tz0J+VcTZ0sN0Z/QGBJp6Hdal6LPoPQ3yGFFGpuIybcryjtLj4gbIY+QIsOf4BhXli
	8CcPmJmUyHeW/dva+DuMy3neGnrM1fQflqndxP7FIXpsaJ4WuUv+NlGn/xFfsvCj6/OuAvRvjAf
	vE24737ZtrLUwS1Kc9ucBZkroRINcNAZhXleJKpzSXALrhGhqQ6Rz5dmpRf4osGb4B2/nWhiYPi
	Xvcl8fd+E33yxwkbCvJnsdxcBgtsSSg5Cr+Bkdu/g0zjXrmXcj2+Tg6i1OTrKhi0H69SW5BTrep
	3dkyzGHjy+nMLj8wmc0bgSMWxdOHv9MNWLSbQ6SU+CA2VcEIeK7dE763bFURSs57jZvHI3zknBM
	KyQ8B3uLr3NJMshHDAcU3gLcCSMbDOO52axIhvUWV3NIzqo37qOoT2+4sVOLSx2dV1sI53AljCq
	VXFC8gGDr4bd8veaSIzuLTDypPXAfekXuJih4cqAM95z+1+iSyd4ME3r4LZCsx7aMGOGClz1mxT
	FuZnvWKGJ5hxzu5bKqsk6LEQbSo1F5+8/1IyqVqzoWWa6Rgsj3V0R/Up90li5hmFu3NhQEVOj2Y
	soCjEJCLiNW7yLdBJjcH0tKXl2IowgUWQ7mM=
X-Received: by 2002:a17:90b:2891:b0:3ab:1e1c:837f with SMTP id 98e67ed59e1d1-3ae898484d4mr11834421a91.47.1793759562716;
        Tue, 03 Nov 2026 18:32:42 -0800 (PST)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b09445f7b3sm1505304a91.5.2026.11.03.18.32.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 18:32:42 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 02:32:41 +0000
Message-Id: <DMM2P2LRLRBB.2AM6NI5CLIG96@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@kernel.org>, <yonghong.song@linux.dev>,
 <mason@kernel.org>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v3 03/14] bpf: Treat addr_space_cast of a
 pointer that is not in arena as a move
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
In-Reply-To: <20624e1d325fbb5acc44943f55c08b622648583bce6559911be3cf47d2d882ec@mail.kernel.org>
References: <20261104012401.1354861-4-alexei.starovoitov@gmail.com> <20624e1d325fbb5acc44943f55c08b622648583bce6559911be3cf47d2d882ec@mail.kernel.org>
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

On Tue, Nov 03, 2026 at 06:12 PM bot+bpf-ci@kernel.org <bot+bpf-ci@kernel.org> wrote:
> The commit message says these members are rdonly_untrusted_mem and "the
> cast is a move too", but it does not say that these registers hold as(1)
> addresses rather than kernel addresses, or that programs which loaded and
> worked before now either fail to load or silently read 0.

It's already explained in the commit log.

> Could btf_struct_access() return SCALAR_VALUE for WALK_PTR_UNTRUSTED when
> type_is_alloc(reg->type), as it already does for WALK_PTR, so that such a
> member takes the cast_arena path?  Alternatively, should is_cast_mov() not
> treat untrusted memory derived from program BTF as as(0)?

No.

> The same applies to the case in the commit message of an untagged
> (gcc-built) kernel __arena member: there, writes would stop loading
> instead of reaching the arena.

No.
