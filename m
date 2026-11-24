Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795541969;
	b=WX9h1qQwIWvBElNj+K6/RiWnDJS3ciNjrhDp3bITdQNIwDlHabN0B9BPYtuws9gX2ZsD
	 /2ut2DCEj3evjTHNKa57uRaIT9bLAjsbf8dPLI+eHUWB21n2wBjBUpLr3ruc+mqqQ0yuo
	 a3CEvpoC88wYbRSJYwgqMP0yUEbsKF4F1tQR2gPIWkKjGgHFZSw2It+/gn1Hqh+VkQdLA
	 fefGmaK6aOfvg93EdADEEDhJsdabAtGaXBHyQkhwVJx4k8mZ219JGHWvT15Pqicn44WOC
	 gNZ3VIPek2+FfuQAItOLSnOTwIafBFFzV+qNByTCvfgOIECP8oaXQRkxKPLPlVxcyIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795541969;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=wEVUsPXL+/9WghyRMIFhi+HChMwXmmXY3YDSRyt6xMQ=;
	b=kl7EgUZQ43y1nBMmNAdEBDVXGPvqrcyzaWRyNJIQqBSbOFcpsryOFqIrl1D1/rJj2ODd
	 l+0TPUuD9/EKs9at+sPsetFpwa+p7G9Q9XpkIoF1THkHx8cU9tH/sFPSrKsSqB+3DDGos
	 ODC8OPLIBrAyi0IC+FBN9WBj3aJ6h++Dd+e7Fh2ZLMpxNM5ZwZjGERICfn7HwpI15unRQ
	 Rjl9jTvf/NltZHLNip88GbS9OuXIddDulAp1ObXpMDFGIkzACkywoSry5sLyziAv1UiVQ
	 knB522z8/NHWPowhKTsp1tzBP96ToJpq+CDsxBXESo8VGD5ChHlOJoiDLnvkW5nAz+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=kernel.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46C3606A31E
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 17:39:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B46C3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-9213fddb596so60580886d6.2
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 09:39:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795541967; x=1796146767;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wEVUsPXL+/9WghyRMIFhi+HChMwXmmXY3YDSRyt6xMQ=;
        b=UzNO4ICPgZWg6iMs4KXPKdP9KRYhWALYyd9hWMr14W0EUTgxgt9DyCANWAQ/7jLupt
         QDZxuJ1+z+E1VcHMmJ5tfyHW0NVrrB4wDLDTNy5uj4xzzK9QDd0oM1q4+JCNMs1diwAD
         pcvoOcBaL0awXKWbpj2IBaiWr9cGTAyurv+Jm9tBTRqfBDLn+u+R5nqF4fWKzuaFqILY
         my0H4PpPDNXX2jkeYbZ3/CbAo8fWUSrS5Yz2z0ddAN94d/UuwFKhwCHb4S1bAvfL9PQS
         sMD/8RSDal9MSh5QlyQwVV/C8Y8bzs014wmJeIvKje9GLW8Dx2QVxFrDS6TxzKar/wCi
         uaxw==
X-Forwarded-Encrypted: i=1; AL+hErHHUhyftqmGgU+JrLVSyLXS+EvjjHZKPaG28bDz9ep1g53Eyo2PorT8MABT/UjcddoBBZA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8sHo+8/ovqOftln/MjX2KdZvqgDd5SPbVm/U+6GPBdtxsPMWzI
	E5hWdJjHBVqdgIH9IfK9ILuUkwZocTUAwEa2QvMEcqZlWCCwrsQ6TBWE
X-Gm-Gg: AZFdTZcDE8E0x2SHt1CMhcqoy1TEcQk3seautzaATjw7pogzHMP376SPcGJv/40Ezux
	P7U/dfUKorZ0rUiFIjeCY9Bw9hNl35JIP8cdLye1kWxI0gnya21UJX0pF6iCGMwGlWrxAIVTLEP
	y6cyksoCqxYX4gNFD/OfNuzL5YcK11us8eeL6f55Njb1fd84oIcn8nZsiUQyppSG9a1fug2O0CJ
	2MuLOW9d+iACREusSAHHAfNkbpdiUuC2umDjzO4C6WhvL7UUy6Gs7B9DAI0GzO5jQjH19usyn7H
	aLtod/rKVhZq80lR25iEbLQgmPxoTmL2y8f4QME8pjJmjuX9esHiAETMmk6Ql69xWOv2JGW3Tcq
	GWl0w/TQTyy5Fd2CDPQVCCaQBAt4iFQLSJ5r2PFX1XjARVG0PoqVjYuu127Ya7ZlkGlV0nlylZ8
	l8rM4LveFPPJR+4pRMrKpUfJjLTbywUYuof0Xcx6JwkhKp7qab9XJ8QYxEEQxqQZEK6eJmV93dO
	x+MV6EEPn1W2dVQxVwUovQZn9igJFLzIlOC3oWQvu4U18I1a9A8nuK+URyLkhDxfgbBWSc76cnC
	eOBurQ1gyeS2ZgozOulvOsuBSd3kkiyL7XnvrJLomDbsHnQr1LhHMpiLL/DaZlF+6NshYpUVTWG
	qtIChWPShtQ13nYupmVf37M6AggaNNRiZA6i4efM+fciACgyzMyGU
X-Received: by 2002:a05:6214:1247:b0:91f:355d:d7f4 with SMTP id 6a1803df08f44-92134a7a7c0mr274698866d6.18.1795541967504;
        Tue, 24 Nov 2026 09:39:27 -0800 (PST)
Received: from localhost ([199.170.132.196])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349f8c34sm141160046d6.32.2026.11.24.09.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 09:39:26 -0800 (PST)
From: Tamir Duberstein <tamird@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, shuah@kernel.org, arighi@nvidia.com, xukuohai@huawei.com, billy@starlabs.sg, void@manifault.com, ihor.solodrai@linux.dev, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, awerner32@gmail.com, andriin@fb.com
Subject: Re: [PATCH bpf-next v3 4/8] libbpf: ringbuf: Add a caller-owned iterator
Date: Tue, 24 Nov 2026 12:31:21 -0500
Message-ID: <179554148179.68173.17534252990255417064@kernel.org>
In-Reply-To: <DN2WJMWD5G0R.27OOI2IBOXA6M@gmail.com>
References: <20261120-bpf-ringbuf-fixes-v3-0-ff7ca15d6c37@kernel.org> <20261120-bpf-ringbuf-fixes-v3-4-ff7ca15d6c37@kernel.org> <DN2WJMWD5G0R.27OOI2IBOXA6M@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

> We can compare notes on the API design and decide on the path forward here.

I'll drop the iterator proposal from v4 and keep the fixes and their
tests. Your series can build on that; it leaves callback consumption
unchanged, so the callback wakeup fix is still needed.

I've reviewed your series and will send comments separately.
