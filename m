Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795721976;
	b=IxStw3S5gB5wWIkvB2oyBR4SPQCUFOWh6fbJDna/ysI24IsqQjEyzYReWiTgj0RWlaip
	 hWVKlw3baRcVPIG77GI3OLdRZjSXZkAv1thAf/1N6NGyQxfhcXb/5gP5Lv6ZRj5Z0cSOf
	 YizFIPqJG5w6XUivL6BhI74n3J1naMQL1usUmRhgXvCfquWsS5xN41TEiMYPFS41qcKxv
	 iL9W0l0lkPvpl7i4O8VX8z3rltARaqhlNAwTK2xb1zikjiKrn4R2amLoi2dLyLledTRYD
	 TLvT2FrpwubgDcuQ8cJ4kOqkNaA9lQP4FqnUQisJ7rqeyCRMicPP2HzqyTG8a/GGx2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795721976;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=1JyQHuNi3zirNTL3+DOhmQ/6X/ugkLPIWASz+EFn6GQ=;
	b=WUM5B8ku8YDS3vgYR2dz68Hz0aSYTXTKDYnbaY55mT+7SlUmlpNHsUmzB4DeXuIHn/2y
	 lTAhxI+ze3jkZ8H9QvYXXIY9SomDaRuZRKdnyluBlbt4SfDYrx8NHWpJrieUrfoy4TIVb
	 2Ox0b2hlT0MFY2YmKYCPrZAEsBhY+SKE2x4lSvvOYROfAxgnrJ0Dl5wEkr6cJkU+/VWk6
	 kSWUEnLeH09lw690oG7DU9n5W65hZyMwBf/5X8hk9daQHBpu3mx039R25u7AsRN90atcU
	 GO6D8+1bKcE4iI5c8tOcRXgaD+cb44eRhw47BnG+w3f1+Z0p33j3nY397hz1BMv6YWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hXgRsW1s;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7546A606A326
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 19:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7546A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hXgRsW1s
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso3459443a91.1
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 11:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795721976; x=1796326776; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1JyQHuNi3zirNTL3+DOhmQ/6X/ugkLPIWASz+EFn6GQ=;
        b=hXgRsW1sPKv9RP/Rm3tgbgYtDYEQxgSCQaaOHYzKOU6WeKrPL0tEZXdrCOOfesO4d7
         6ef3DDJcrWSSVyCl0YrGxi2zUwjfrKy+LOMGYKhs+NNVMhuDRHmfUutq8+BnCh7tW0op
         4tozsnVg+3cuWvAmlRIRUwU5nBDIQvW/TNSpFjo8ox6hq73yf/Vu0LF33FKcg1qh87fM
         gU3n0wUiysK+NH7OUb/0R4nj/xT64OZLLUsgE0/uhaFXj12lzsDa5qFgMtixmo3BEH5l
         3SfHLg8VDGAGWpxcMegXrYRb9FKAftlF9h1QiTBT8W8acFT5TA/wBfxOze7TFUn555Xj
         VoFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795721976; x=1796326776;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1JyQHuNi3zirNTL3+DOhmQ/6X/ugkLPIWASz+EFn6GQ=;
        b=1FgRSkp2O/TaTPXgxx9X6LHKUcqpLwI7kiIP6CvBBLhA4GuVqQSDqdyKqx8Tip5KWU
         XRsfod7bndrZj+K6/+CqU2XxIKZ16Gv4besSS16th5ixDaWGqvsxNDDpNtHcUahkaVYm
         02/D9CUZmXrarEU+xs5YmeFeY2bq6AVFwTMrAQX4V3u+z4aknk9SQ4ulShiDR6biFUl1
         ytfVQE4joN7oJE+ZsoI5V5uFOiuHloeR4Uj+Rj14pG87WYDQ1TD+jEvSZJFv2bVNEhMW
         fOaI/UwjaMB8FUZmQklYpucMXakThSheAh7e192tNLampRDBFE8npiPxBAW0Dk9j8chr
         C/dw==
X-Forwarded-Encrypted: i=1; AL+hErHzC1hf//YBcNIVEXCaZjvaF7BpfgFTkvxKixdOz4j4CiTWd2yGn0x7nXLoUKk1D0AaXn8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9gtnNxaT1qZL2/aiagyzbtuNyVCRhggm17jxgeQB9D10QJlo3h
	wuQFYY+28bGz6WsfbmQuvaBmKTtzkU65fwe2sC+UmZnpqpQaS3/0hJ23
X-Gm-Gg: AZFdTZdONYEW3gqOxyD7e2uYeZ7GYPwJSHvl0gbBRWkffhMaIaBXo7nWHHYLFWSOJJD
	U86c1yZrmIu9euWcrBNBY4KlDPWfqhguAq3+cEkiMHXdmM574D3eX2Rwow2YJClAIHb1g1mMhXZ
	o/mkBUsYL5QfsP/TSbTX+wBFlYNOCdCctI3geMG4xrrGVDIoJ9ZXOyapvWaNkTB1+Cw24gFDtqY
	EHWUu9iScXBCUIK5lTKGc32/t6qkkDA8FB9pEt1EfnAtR5y6whd6i5ei5kq15Y4h6QLT9he+/bn
	DfoUK8aZh2L3w4aZQ6stp6QY3m7DNsnlrTj2EehpS+frjhOuiK/Gd3XbXABa0LxX3Li/bTII/VG
	er8KMjkSic5T20lc3VmFkAEgrM+1jSGOTQ+If/AmnjLLjgayaFrVoOikUnqGYtJ6rFAssAvoO9v
	30T9P0snYSx4HmwO0UppVMEsI9YrEE0o9xBLsi2rPXbkFjeuQFQjjgbs7Nvq6qq9QrI/gWxKBkB
	9x2srWlS3ZL0vWH0AUVlrVhtVFbaxzE3TqK5sQNQrbRceXDAi154KCMw/BuI+gdOjfmc+qCidfO
	Z2sgoz0SsRHVINIbVJoMrpudRzQEFw==
X-Received: by 2002:a17:90b:2701:b0:3b4:1bf1:9873 with SMTP id 98e67ed59e1d1-3b41c8dd1b8mr20338360a91.19.1795721975723;
        Thu, 26 Nov 2026 11:39:35 -0800 (PST)
Received: from google.com ([118.150.148.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b53479b149sm37761a91.6.2026.11.26.11.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 11:39:34 -0800 (PST)
Date: Fri, 27 Nov 2026 03:39:27 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: corbet@lwn.net, geert@linux-m68k.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
	memxor@gmail.com, gerg@linux-m68k.org, skhan@linuxfoundation.org,
	rdunlap@infradead.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
	ihor.solodrai@linux.dev, marscheng@google.com, eleanor15x@gmail.com,
	jserv@ccns.ncku.edu.tw, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	bpf@vger.kernel.org, daniel@thingy.jp, martin.lau@kernel.org,
	mason@kernel.org
Subject: Re: [PATCH v12] m68k, bpf: Add initial BPF JIT compiler support
Message-ID: <awiK1SMNCNxNipjQ@google.com>
References: <20261126170538.3471057-1-visitorckw@gmail.com>
 <0eb06d3a00f2e4d56c2f25db16eb8b02160387281fe455b0e0e5d7466492657e@mail.kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0eb06d3a00f2e4d56c2f25db16eb8b02160387281fe455b0e0e5d7466492657e@mail.kernel.org>

On Thu, Nov 26, 2026 at 05:45:05PM +0000, bot+bpf-ci@kernel.org wrote:
> > m68k, bpf: Add initial BPF JIT compiler support
> 
> TL;DR: Nits only, no bug found: the m68k JIT hardcodes the tail-call limit
> (0x7021) and the 44/48-byte prologue jump offset; suggests named constants and
> a check so later edits don't quietly break tail calls.

I'll hold off on respinning just for these nits and fold them in if a
v13 is needed.

Regards,
Kuan-Wei
