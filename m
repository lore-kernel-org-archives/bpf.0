Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DA228505E
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 19:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771961529; cv=none; b=apook7o2uW91MpC9/mTb/coeUax+RZmWhSSGmDQ9SYJXKFJR4uUkQiGMKZ8GQAKoLpgMm2DLhAsN/BbZ1MdI2m3sWmhbFzOuY5lSXcv+fIuHrsSdxrKwOQlRGNkCX2OdiWWvmKiSGPSNJw4sP2QTXxlrBs3eUqNM1xVWzyPQ+RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771961529; c=relaxed/simple;
	bh=+gpgPS+296ux0RWQi7opFzJj5P8E6ymnBW7HsRJjZEo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ms8Kf0EEr6OeTbeBDFaL8WuMJ4HRmsRZrJxS7RAhWvm52/d4QhyAq+18Uh0WaHLky3FaivUSmbXErFfMWS1/KPmMJkLjQ1LSz5MljWfj2LCvLz8nZtC2iFKoejFAarmbjQHZblrDWtufXSJYekPP+XhInKDgljKfAIJZEU9tOqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPJLXgcV; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPJLXgcV"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2bdb17511aaso700771eec.0
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 11:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771961528; x=1772566328; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WXkEdnL1SZKoZsw4pbMeH7Q3k5nWxw7dOirng6qX9E8=;
        b=FPJLXgcVl8lRsIDzS33WEREPadgTD5h3adeI7X1f277ZiZguWsTauRen5ovd2Mf3vC
         qmSYWNjFoeg/hzmoRda3wD7uM4Op6rS7Hgz0OeNbjvhIjyfmuy/rujzyyv5QKTRz1eeH
         h0kTAKfOA3avevOnxt63WFFtdSUHOJ4+wqhKIS395azYZkZsGX1A10JFs6eeC6ikNj7e
         eCdjlDVuvNJFnTWiejKQ0Y7GgCBdU/pJQJQg8nvEOxsqtlwRQrLwRbTPgUvQOpSuylMs
         3gdya7pHYFBRqXTwLYiBXBwJJ7v6BmdolY4QU6cV57nPfjUiy6YSAocqeqAXQtn9y2r8
         xnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771961528; x=1772566328;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WXkEdnL1SZKoZsw4pbMeH7Q3k5nWxw7dOirng6qX9E8=;
        b=ge473BuXh3+CtOJ589h4BFxof+bVAsfq48C+M/Tl2g9ZSpjVwvX9szbnNCjdFU4K74
         BZJTrJuHLfGFe3u5negPvEp1TdG7OzQvqcgu+JbwOOYu/ZDycM2iw7HnYgCD5glOpDMR
         jlZmPPwDGcqt53dIJRJggfSMlDNc3kQPxDCqO3kxETzWV2B+eTYvJrT9QOCjVBz37nYo
         DhejyllWYquVzOzNJmTi3ojsOOiDtiZ97bACIdzIsXhsAT4efzdC9GSYFuNfRkAxrGNa
         qgHexfLVUf5cYd73d8U+ddPzTxsurK0XKGpUpyWqxYNSt5QTocNArbmdH2dBjcPQlMGm
         GQYg==
X-Forwarded-Encrypted: i=1; AJvYcCVgfttvo++izwK+sA/TYKdUpNQ6VQJhUJG0snrywHXIzN9GVPEI5BRF8eFTTHDocv+T3tQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiJk9wLKtXZSuSln649zeoEO7Bnkwk49TJdwfRZ9IhsA5AQS3c
	FY/Pj/X6EUT4AdgMoifWs9RhiGWXVwRhBhgCp2+1CeVGbIWNtvoIH9Ub
X-Gm-Gg: ATEYQzzu12Bxkr363cV1w5oMC2j6akSaI195cubyuLL1rQNLe/KxPpgjrTNSZuA5d1g
	Tv2MUKYm7Hgffy0JkxEPaTPyDiFSTIGm+oDJKnHqmYp2aABVaJF0kFj4oEMJxxkwwoV5HiPV1WC
	sxAr8sEwP01Ige/8eabbkUQh0UNtDKIoQ+Hav6SgLk91qdwmHy7HhHmkwtFzL4eVzVLwak2yQwJ
	IYrqwpHiSL4cN04HHaVo0gCIfMbLHO19F7qv34GQ74w2amQA4hKm9M/DmTUNid5XR0kCl7yXRB6
	jvsWFrkUH+65SH+I7bqrUO0AilhsmSXbtH0PBj0EQEIuWZ2PVOSaT87ebvky3JYH7p9dIOl86ki
	I+WRdDdEFiP1ifoL2HTDABnUIomqFJeBZpAOU7bVHtpMdRyR7mbG11sGQLwK+E0ygoR5xaO4R0R
	XBckht0Lx4zoao/D0gFa7k3ypEigKPrURt+rsgeo6XlmY1EqDmlvCN5+AdoZCZ7TSk5y0mF02Ty
	tC6q2J0b3Xt68eC
X-Received: by 2002:a05:7301:434b:b0:2b0:571a:28a5 with SMTP id 5a478bee46e88-2bd7bd2aacemr6692076eec.18.1771961527687;
        Tue, 24 Feb 2026 11:32:07 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:79f3:c942:f01f:96aa? ([2620:10d:c090:500::1f1f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7daa9295sm7291121eec.14.2026.02.24.11.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 11:32:07 -0800 (PST)
Message-ID: <5b559b4fe805d18c73139a0079894595539ca412.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] libbpf: Introduce bpf_program__clone()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Tue, 24 Feb 2026 11:32:06 -0800
In-Reply-To: <83cf0430bf164c46abe56d2ec6565ca57ead1663.camel@gmail.com>
References: <20260220-veristat_prepare-v2-0-15bff49022a7@meta.com>
		 <20260220-veristat_prepare-v2-1-15bff49022a7@meta.com>
	 <83cf0430bf164c46abe56d2ec6565ca57ead1663.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-02-24 at 11:28 -0800, Eduard Zingerman wrote:

[...]

> > +	OPTS_SET(pattr, token_fd, OPTS_GET(opts, token_fd, 0) ?: obj->token_f=
d);
> > +	if (attr.token_fd)
> > +		attr.prog_flags |=3D BPF_F_TOKEN_FD;
>=20
> Nit: should this be 'if (OPTS_GET(opts, token_fd, 0) && attr.token_fd)' ?

Nope, bpf_object_load_prog() does it same way you do here.
Sorry for the noise.
