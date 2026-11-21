Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795263133;
	b=nRoZTKGQXew9LfIlZaxRRKm9rzHsrQA5UDFeTrc2XrbIxbZy7EyXOKE8T1GipGob/+dm
	 1n5fuEiTn6X+UOiwtx99fbk25VhMnCLYXjUsc045dXSCRJVcTqDYlXs8BLpDfcxdHgaQ7
	 cvNCmGzme4U7rC5qswulT1ScfCt4NvqbjssTEADHAHntmH+uZmsCY5btZKD+gsnbvN7s9
	 WAjSfXpmrCv9t7HC/KuDslS5vspdl4eoFS4r67XpRPOiUSXMrV+HdurL7qX7qF5KMMkm3
	 1o5kc3cPZBdVX1Op4IffuMTxJ9HQ4MCy019pGFYyNCYrrDvoN7W2IU4P0hD/YQL+8qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795263133;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=lGYwpKC1fByS7GG5SknYRcbt4FjMkQjX/lb3OlO0LP4=;
	b=D8zcq9KfnV6fgyR2NucoF4WJKuh+8gsGfwK6zIO11XiMr84wMMbfQwSiNiOVQnIwCseG
	 Jf9l2DPIV5dL7FCbv8ePv6pRGq+rdxBfZzS3K1ud4JHQhasv6hPPn9JSk05A8QlHQ7p+d
	 QiH3jmCWgF8C/puS5O3MFxbv82k76FEk18+o6H2d0JOJ1ch+7x4wPNX+2W6nnrE7zAUlk
	 IrqNWps+GVmrROc9Z6IOyOYVeK7gRk+yTFA1v0jl3fcUT2OaJmLu2hIy+QjBeI+LUF/Ua
	 amosrepMkFOAqBJvFIkbXJn4Wm6mQtwENI5L73HTTA/tGlNuKr0Uzt11OwhsplcDuIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=kernel.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1A2606A320
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 12:12:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD1A2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5569551d19dso30441111cf.0
        for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 04:12:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795263132; x=1795867932;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lGYwpKC1fByS7GG5SknYRcbt4FjMkQjX/lb3OlO0LP4=;
        b=iOXlsVtnGhkTxTHnLWX+//ZgCb9IgpIy2LMvOuA4Y476VDeQkFnvDwq2mECUlcwtc/
         vCtd7Hh2LLJCRhPH4RqirSQ8WmVwf2hZRV5iQXlSUzf9hgwKDImU7uCcup3BXOPh6C5C
         f7EKDolj1mBr0/Qi+N6yBBw1vmPWxF+B7+84d6wxQasxJ6u8b5EH2HkrvX/jYGtCu78B
         c8YBTOEKKckDUXAVS6flHxJgr++D1ro34qHfaj/TtSzqGJudbG0YW/7n+OkXlmaPcA7E
         ABASg3i/AkuSU55rUzILeNCHyb+7pYGVYO0TqtF+Ke2TaEifKpYevhY9QEQgqtPuUXLI
         o9Kw==
X-Forwarded-Encrypted: i=1; AL+hErEckc5ZSjHCHbChheVA1GPuX6DvPVUTdAh6WRIQ4rbLC5tUSWJwbXnrH1gvDxsnTJynwwQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ykSh9UTvOW27rmvgEa/Xx+sPYfSf2aDL2g/VbZ9+efB0lq7Go
	2DxIOSDwGLPJzipwjUQSU3wl2DnEq+UTi63gNVRjHne19Yaqt7o4F0aG
X-Gm-Gg: AZFdTZda32tq8OJlV+XLt25wQRSfDZ8vgNs0fC4iPN9napwrC/DItONXSyzT+cdT9/v
	5QdSpMildTUSX08eRRy7TZRMTI5gA1Zpw72bOuaAgkk4VZtk9L6q7amG1YWiYohRqrAqO1eIvAQ
	flQOkkYLB8LIShk0l23Ymi+hljgLd5qFBb92HyFKrmkp0t/qjYr2rtB4jKE8sl6c6TqpETm68Dy
	T7crVypQosSQilwWoWN3LBN5PJ5vGImgEe9f06YwQP7dUmNn3I3rtMRQaKFv8yjOnQjyyW77dJg
	JKhDtNjRjE02/0H5eMaaFboFFDExSlu868l5Uv1BgkoRJhz/gYnVQ89TE5qvVCamNNz0NADcMml
	3xFKcqRSiftIsGnFGFeXFgTY+ns+mQ4b4C93Y239t06apVlYHiUXFO0pRikbfvk0oYU1qyEVXhe
	VeHlAyUSnPddYWiJA0iHwsTHwQRuzfpYSDXw7IuBGFtGgD1UClN88mHeFs6ywCuY9Tj38ktDwnB
	ijZ75xmDqbxyTW0cyxDCiUOnz16ifBbEkWVwnl6u93R2JD5K5q63C7PDIWUNorH1P9dTv0Fc2vn
	hpwbnShgHb+7R2l2tm7oCcPe+OHfF77jwoAe4+hrF6xRyAFLxD5RCiCKxGVBnMixqwb7TX+7cM2
	5654sIojrfcuIAgi0oSEp2DVA3RtGLQshxVsAjX06zh14E6ho0+56
X-Received: by 2002:a05:622a:2283:b0:55b:9d8d:f29e with SMTP id d75a77b69052e-55d769c6d1bmr89159451cf.9.1795263131897;
        Sat, 21 Nov 2026 04:12:11 -0800 (PST)
Received: from localhost ([199.170.132.196])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d78812968sm48042081cf.9.2026.11.21.04.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 04:12:10 -0800 (PST)
From: Tamir Duberstein <tamird@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, shuah@kernel.org, xukuohai@huawei.com, billy@starlabs.sg, void@manifault.com, ihor.solodrai@linux.dev, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, awerner32@gmail.com, andriin@fb.com
Subject: Re: [PATCH bpf-next v3 4/8] libbpf: ringbuf: Add a caller-owned iterator
Date: Sat, 21 Nov 2026 06:58:00 -0500
Message-ID: <179526228002.45024.2428180539629576513@kernel.org>
In-Reply-To: <awFr3R3DPS_so3Pp@gpd4>
References: <20261120-bpf-ringbuf-fixes-v3-0-ff7ca15d6c37@kernel.org> <20261120-bpf-ringbuf-fixes-v3-4-ff7ca15d6c37@kernel.org> <awFr3R3DPS_so3Pp@gpd4>
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

> Can we make this internal helper __always_inline?

Done for v4, together with a private __always_inline destructor.
Callback consumption uses the private destructor; the exported API
wraps it.
