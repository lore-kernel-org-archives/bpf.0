Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794586640;
	b=2OeNwmsL80TH3+JdT2h9byR2GnVeeoHTFlXSlcWnanmHu3XXRdV77FjJoKBj8J7NggRP
	 mBwS67hL/SxU8gCnybUO7HxfAS4kBWQTH6NmBc7g+Bqm9G8L5PXJcr/RA4K7nQCk5exWL
	 4TgplN5jUBWYZXoa246jgxoebD3DcLvsxVI7cY8jaFpyobhSwiICmDjt46pHxhPOa2QoV
	 75k4fnzX6Mh2SD/GaFX2K6AsPj+n59LUuxgOGQYuQ0dcDRP5z0NV+V1+CWuz3+6bWcdeU
	 lgV5H1f3iSCmvCjvw/hURsr3LkCwuwuRJb3y0xoM2OwoOQoNexz8TFS8faODlar5ddw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794586640;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=BRpA10axCrXVZ099IyeUTv8IF2etUVslsgkPoau4YqY=;
	b=1/LKKKwdQoIrxWFyjuvUbdsDRvm1TU0SLcxmABH9aJqw7x/N2d5d3Js1XsapuHwBQffq
	 0VQSvyLVYKFdfZVXwbzsSaPWzeanhsBoOulndWnL7XaPuC8pl+8VzMQdWlWhU36SnZAOW
	 64/MfQ8fDjDSSdlsvxop1nzXR9DLoe9RX3USNTTV4H/x6hINBiXZXoc1ypI09JEPxHBJk
	 pKeMRSkpQaoYliIFDCT2s2mOl0jO7b/h4TETN41WCEtz13UrZH//b+LjZcOCbTE6lDlSm
	 VGKznR27jsmtdOlLEGnkp+ZCphJVcLhY9WH/ZlY5bsCM40NpDajpdCWBgfRpADinF+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wi6zE+ZS;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24954606AE20
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 16:17:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24954606AE20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wi6zE+ZS
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ee2072d1e7so1706325ad.2
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 08:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794586639; x=1795191439; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BRpA10axCrXVZ099IyeUTv8IF2etUVslsgkPoau4YqY=;
        b=wi6zE+ZStl1hmfGJ0Vf2UO5LdI8hkGd/Z/YsjxveZdrZ7ZIeX10KPqQpFpe7ENuDXb
         LuLlg+jm6kucLV4UojKYhkusLD6XKV4UPRh6gUqgv9uJBOM6wgHqUHTUmbDYz0TIOrih
         K64pI+yfDyTuUSTCu9XJTw3kAssGmU+rXduB+a082Q/hHtb0Tb8lG7NBC4dWca73OYEF
         v+M4dRXAWo2Jng7ETPDiO/lO3XjKQ02ElwcORuZC2hHBN+oYrQMWcPI0z/h4b2irqFIW
         yn7zsfY0MhNwFCAWBPaDDc3gy10J4mpHBC0wWh/rYE2+e3E8oWe80sIwvanFA5TcUXgQ
         6QKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794586639; x=1795191439;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BRpA10axCrXVZ099IyeUTv8IF2etUVslsgkPoau4YqY=;
        b=awz3GquW9DBkQxNuvmCOSU3146gzBzz56/2Nk1oXQNYPSZmP4ABVaVo5PsESK94bnJ
         ZtlsPHx9kI3Bw0oZJGcaHZnSpFP4ko76KEdhb5qM55Z+uvz01hblXjvvgBsDPnZB2BkK
         +V6IQ2lvgYJj14ZK0xH5ZiJXTHljCiFG5u5lGXYpNzPfknoojImaBk+vi5noGbf5rBc6
         fV7ZD2PW0i/I9V/Jfe8TRKLvnjMwMjQvvrvvKCLM/gh++LmnZcPzf+a00C00k9zwlB9X
         VtlETgy8TWtFtwDJiRzD+pXvV1w2C0V7XbGK0hoqZxyXBIMjQm8Byh/crMIVtozyFPsG
         MC8w==
X-Gm-Message-State: APuU4Z884YXP0HnTiT8mNi5uMIJWMvNYdYEKECeIORKDene4bKPo1ubU
	fIy7M1dbYg2fFNySp9f4iYjhENmXYdYNd1/PqCvItTigsZ88lAThyQ3k
X-Gm-Gg: AYBFou0OXpwEXw6kw+PfsO1R8eu8TXjw+Te+L5R1igeLyhEM+bsINC8BtFvYZcBQeAm
	eBZdO5iPptTeJte1QQH4ZAcYre12CVNFsQs8V40yogQ/wjIEvFuRSMaCRE7xYidyazlNog7Tdbi
	tP7W2Br9G6qkK+EL1Pbd+BeoKXaY39iUni0ugNVQ/V6hGGqI9wLU+CxxLvNTGVT1yzk0r7Vvkgp
	LP1QTrHZxqHidJhtvUAWTfIG6Z1EP0UkWCpUBrz01Ou2J/Uxl3xMBNvQmV4hxImBCR4RPGRqi2K
	gYGbG4F1b3l3k/fVvNcgJL1QsJSnT8koiNYBKcTrilQaw7zMUuT3cYOVyorE8HmOnj57pd2FXpl
	AA41gGbeHlYV6gWQtgyjRpkWznoyuBVLy2BHdgbXiA0mWfcAO6OxjAbFB+zRFHNOdMZcAGFWC2Q
	ho8aUjR9/YPddVfvweqQCT5Srm9uiqMM2EYWNmYLNzCwQXZwSGzxhOA0QbzcnKASChIv/gIkeDA
	TZMvKgXWtEXYs1qD1VIzajvoX9ZxvzsGJMdt5GDKEzk+EjCeLiCP+AWasj/SN8ZIa+o5XOwkxEz
	+knI3y+D1iENmdNxJ5G+wLsypaCJTSLEdpjP7sh+lNO7PELed3D65dVJ0oE7n52/i4L9yZBkR53
	poffWF77lpvqJMRROilR4sYk3qtE7Fcd72DE=
X-Received: by 2002:a17:902:e54b:b0:2e9:3395:cca8 with SMTP id d9443c01a7336-2ee0dc779b4mr27718525ad.46.1794586639096;
        Fri, 13 Nov 2026 08:17:19 -0800 (PST)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f7cf891sm12972395ad.28.2026.11.13.08.17.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 08:17:18 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Nov 2026 16:17:17 +0000
Message-Id: <DMU7VC37HEEP.2K1XVHJJN8FFQ@gmail.com>
Cc: <bpf@vger.kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <memxor@gmail.com>
Subject: Re: [PATCH v2 bpf-next 09/13] bpf: Allow fmod_ret on tagged
 functions and check the return value
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Anton Protopopov" <a.s.protopopov@gmail.com>
In-Reply-To: <avcApw6Q0_DUmWkE@mail.gmail.com>
References: <20261113050901.1399091-1-alexei.starovoitov@gmail.com> <20261113050901.1399091-10-alexei.starovoitov@gmail.com> <avcApw6Q0_DUmWkE@mail.gmail.com>
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

On Fri, Nov 13, 2026 at 04:20 AM Anton Protopopov <a.s.protopopov@gmail.com> wrote:
> Please consider taking also this commit from v3, which requires JIT for fmodret functions: https://github.com/aspsk/bpf-next/commit/f8abd203106bc3f0cf978f2292148d4a63f66b26

Makes sense. Will add it in the next version.

btw bpf-next enforces JIT_ALWAYS_ON=y for x86 and arm64 already.
