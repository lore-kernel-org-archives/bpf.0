Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5662B9B7
	for <bpf@vger.kernel.org>; Sat, 21 Feb 2026 00:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771635165; cv=none; b=m3rskLMidw8zL+rhifyI2IWH/d4YdQFYWdVXvsUBnM2WuKcMUjt8J4NuEd1Rzz4984WxV2uuvF8aqiMh84EByZqG5KhnRFtfn74B5DudDbuKZOgqKKPwKO827wzFSLChH5FAZ6nVkgVyJLfloVamnruJL+0vejCQDXWqeclQ/NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771635165; c=relaxed/simple;
	bh=PDhTLu6ZoOihFWcC3an8SrkTzYx2ob/xd3ip5nhnpTc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fydJ9LLbKqsS4AAYX1jPCUDe4ZNhMAaqMfBmaXJddgMM/rx4IZH8tcYR/K0p+IY+GH7tgH4Xdl3O0qH93/LqDHb/VnUb7zbyIr6n0dWB3n3mLKJydLlRa4Wyeho46bFoTAJ36ZLO+PMx4iB+FNxGrJBJL37sAZF6scYdHeVatqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxMIFW8t; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxMIFW8t"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2b86ce04c5cso5109776eec.1
        for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 16:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771635164; x=1772239964; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PDhTLu6ZoOihFWcC3an8SrkTzYx2ob/xd3ip5nhnpTc=;
        b=DxMIFW8t10XnSegv0/2j10gY2kJT0WhcbjLEuFj3/6lS3x5yzJ/0l5XEyRo+vPEip+
         V0Pap1KQMMhIJUl1dOK0Y/qkn4uZqnRFBJeX3FC/WclBDo6Yucgmc1EG3sjPRgTWibiU
         eFzc+HF2QzVwrprTgvyC/MZJdaq7HP9cZScRsEyyVYPubJ6C65KjySia+RhQGRjEzO23
         WFGuuFXnSBVInkeNdE0cbHB89B/MN56hVSxFeq04FI842utSG52ryjEmAP8n1X5W3WAI
         AIDn6gk/Pjkgm7NaQZHwBfhblurcgS9elFgZTC3Ps6d4ER/BqjpyX5PVxlvMYJAGDSSw
         znkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771635164; x=1772239964;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PDhTLu6ZoOihFWcC3an8SrkTzYx2ob/xd3ip5nhnpTc=;
        b=w2nCV8PVp8V2BdPNp/1y5BFsDt6eA106h+WwJn/f4Y71ZnRBR/1E9gxQuj9InvBjyO
         wHLVmXKR/bOGEvwgxSApwNqI2HCHE1tkHXsaDInpLpTuB60w5GrjBbm5Ycd/zSJcMflq
         6zIX3KMuuI2Tza7BiMjcYRXhydYhgcfcBBJ0laDn1ViZvaqWCvA1ND078CO0MnM/RziH
         tPfrn8dOFNvZZCBEt6lnyVryd4nk/OqkhEJJKMSzIePbld41yN8xugqcjX/1dOZhawJE
         j1V7UOY4xSKsmjru5BdzFXr+Jo138HIyurKJeaDOd7768XMkOchjY70ieU0OsoEK4Ezb
         0XMw==
X-Forwarded-Encrypted: i=1; AJvYcCU5KmlxmXbvRUxbcWLY9TEtQvPUExBdeL/MteUCvC8IRSzt5Q7JlcsfMG8usuaC9hHAjzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHqKFKIfeb+Zun5X25lySOZwM0OUqCVCAmyZ6vVaX6l5+tPwa+
	jk19mzNCwar9YS+ksGzwlBWhCn0jns8c8/4V69AbnQy/sdzDClX+Q6uy
X-Gm-Gg: AZuq6aKj/H6HBLXHrEnHgl8MxmJqikezs9TTTSb/7bO74tEVsmkvXcrdixziVa5HBfg
	9Aj/QoTEo+dU616uZC1YlL1O+w2zlWl/Fpug4C9mLz8c5/App25CMwZ4kos8l//S8bjxmeG2YnP
	2mn8VJstXC42nhIUCWwCiHuVBiczgKuRKwvTgjo66q5O6aks2Q7URA7VnK7G4wpOqvr6j/CUCpB
	u35/vZX07Z6YWCpQNBzon6yHD09IMZSsiPntVCTidoWKl28eFlNwhEt/n1A7aY89HealyFcr/fN
	uZGf1tba+9TOKJykYhxUechN9VsaC8fEll0YC69sbQvR4w0T6oBQBnvaV3xzuM/CMo27vKwAiJG
	NRqWDAKkvskeebdaTvykHJ+tMnZpCazo2Ic6slGh6dchU/Nanabu/Mw3MvtuvYB2LADcioQjiRM
	b8JQR3FE+85BJOFbR2aFtZJQnAEECQwY6481WBVSZGnxbhxVEZgN/gbKlycJjEof8FsTIKd7jJd
	FXWYnN3rTwqcKuUpog=
X-Received: by 2002:a05:7300:d70b:b0:2b8:711:ae6d with SMTP id 5a478bee46e88-2bd7b9efca0mr804687eec.5.1771635163655;
        Fri, 20 Feb 2026 16:52:43 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:dc10:521c:4103:cf1e? ([2620:10d:c090:500::1:a80e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7dc37867sm461487eec.32.2026.02.20.16.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 16:52:43 -0800 (PST)
Message-ID: <a70e6938c0122b50378e8d527599e495257c5dd4.camel@gmail.com>
Subject: Re: [PATCH bpf v3 15/15] selftests/bpf: Don't override SIGSEGV
 handler with ASAN
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jiri Olsa <olsajiri@gmail.com>,  Mykyta Yatsenko
 <yatsenko@meta.com>, Alexis =?ISO-8859-1?Q?Lothor=E9?=
 <alexis.lothore@bootlin.com>
Cc: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Date: Fri, 20 Feb 2026 16:52:41 -0800
In-Reply-To: <20260220222604.1155148-16-ihor.solodrai@linux.dev>
References: <20260220222604.1155148-1-ihor.solodrai@linux.dev>
	 <20260220222604.1155148-16-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-02-20 at 14:26 -0800, Ihor Solodrai wrote:
> test_progs has custom SIGSEGV handler, which interferes with the
> address sanitizer [1]. Add an #ifndef to avoid this.
>=20
> Additionally, declare an __asan_on_error() to dump the test logs in
> the same way it happens in the custom SIGSEGV handler.
>=20
> [1] https://lore.kernel.org/bpf/73d832948b01dbc0ebc60d85574bdf8537f3a810.=
camel@gmail.com/
>=20
> Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
