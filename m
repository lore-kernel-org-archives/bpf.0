Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF182E040D
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 21:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786483096; cv=none; b=J/3nfjrewRKv+kornPssdfx1+P8hS3I5SEdD+GuB+62DeESRgY8S4e4boSr7c0zOgNWb0o0L+CpTBZ9pew1gbIHb7BRA+DV5Ey5xcMa8jdPSTZUedFcNWLAAGpxXEOSlZeys8AqiwFg0cusxTpe2+armOl/1zUz6mMD64OkKneE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786483096; c=relaxed/simple;
	bh=yvVFdMCLFQ4jCt861GA9Jbk0Z4xWTIBEIGz7jITQoNI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iOTLGNV0flAtgo2UzpZ0H2wrN27FZcJY1T3Vo1QByhm3k+7WG222o5jodx9B0mzBqiiIBumHwYdcfsVeWhUBg4vFFgC9aZmZ+uzkYRAJt2bHjhR+DMdNLcenzUpWB2TRHIpkvivXpSDT/uara6lslEwj4jOao4dIt++cD7ox1nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWj63kU6; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWj63kU6"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso276261a91.3
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 14:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786483094; x=1787087894; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=yvVFdMCLFQ4jCt861GA9Jbk0Z4xWTIBEIGz7jITQoNI=;
        b=FWj63kU64Go2XY2iYWZe6bsslFt4kNQo2ZXucChFWFsA7+XPB5Zx75bqgAFFACQGUl
         Z5bnnH0/Ng9gvdGjsOs6QjbOzztsfnNTIyOccWNMyIBT8JNqVJRQbXOvO8eU+eZJ7fDV
         CJg5IRw3NHHpBAD+Ny1NViYE9rF7Dr7Cz+xSTteUwLDwSiJ6D5xfGh22FHJu40/bmyA0
         8TvvxfcCim2qgsjWilRBzuMJew6DImLKskHcLWf7HkcsV/nU7BfCEpYmh5aQCvuuZW43
         gVvyzmdczZqLEoJU6uGOyVowF/DnqcjD8QCa9Dxk/t1jhfE8hJ7rLCn89yI7nrlDo5vv
         y7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786483094; x=1787087894;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yvVFdMCLFQ4jCt861GA9Jbk0Z4xWTIBEIGz7jITQoNI=;
        b=UTsPH35XEFmkofZqYB42LgGbfqnv3y7MXUIpP8O4uLp9u/qehp4SM8aJFU88z5Bl0d
         tjGHuNBYveacnoCYi9zfeTAiCB+/+uWIu3U+cnfSa+NzZ5mJEYJj4hBaMkrkxMyelLmV
         QM0AEmj/W9EvM6dWdLuiB+vwX4J5hOiVNAwg+AkQTk2XbgDF2n9xKMNEDOdXjVyLGB+K
         SV0dXvxpQtKmyTi2l5ff5dsmYMmglMJ2qkgjbyhd+9RwZ1JVuzLFebDY0bxrpoSGEafY
         k+CQJRqFw0IoNBECS7wX/YC8kpqqAt3Y6ABVqZMrmU2xT4U/Vh1VUaRIRz7tr9ttGqet
         mNqw==
X-Forwarded-Encrypted: i=1; AHgh+RoxwTDaO2l4q2XOsblfmA9M8RnWe1BiFdPoInGFrPyOgQORbBalI8qkz8+loAgm8+B5xp8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb+iY70T0SWoTz6263LNqRS1vyvfabaYHklzWA2XPj+pRckgd9
	gj3M8x34mQnTRcq8838i4UqkONPcTSF0k1Po481c9GXH4LuIm7VvlOjE
X-Gm-Gg: AR+sD10rapxAuhAwEw5fxS/j0edxe8bx747lzHn46tbUPO19Jtx/I9cfbuCOYO4Wpn7
	AwtyDNOssO3B51Oc3RkMdUNQ7bDXCKt35mvIUChF7eC0/xhzpVZqoIUUPQZ6GxHsZIgI997Kmf1
	F4aCqalqHEykBhANeiEw4wzmWNifF7bp9OKaZprD+dlHzgOB/VzyiRonSaVRkmB/4CatFjSIVU/
	Qo0Bb/KxjGiknSSj/RUBH3GF3Llo7+3LTG3J8vabw8ELv1dbwtQG+48MsyH+lQDoInsoOFNjH1h
	IuUzF7GUg0PCDvN2zv8P0dbSssuiwF1kkmbi0bnH3y1oPY0M0wYlTAXCDvJF8LL5jBZQpUV7SMk
	wQVi7UkQ0YLSr0G3RTo79oOiMzMbmaGNy++xcWdTJ5l9ZtP2geyZUMJ3RrkXZ0qH0qgrVUgJduN
	uU0ml0qafPKQUMjJqpDmWINzjR1UYfltKGoUNRytRomCTHuepSnMCXJWhrcF1t3zEUnSi4KtrlF
	T09tux9yt4zFZCgxdrZ8z5uIxoLR1c8f+sd97CgjF7NRg==
X-Received: by 2002:a17:90b:3bc6:b0:380:f389:447b with SMTP id 98e67ed59e1d1-392ec5b6ac4mr6903596a91.11.1786483094505;
        Tue, 11 Aug 2026 14:18:14 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:cd18:dfe8:e39c:4123? ([2620:10d:c090:500::4:f345])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf6d7a3c7sm4287189eec.29.2026.08.11.14.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 14:18:13 -0700 (PDT)
Message-ID: <30556eee7f66e8b5ffd4a180d43c2d5fa20fbe4d.camel@gmail.com>
Subject: Re: [PATCH bpf-next v7 5/6] selftests/bpf: Test stack depth stats
 without BTF subprog names
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Tue, 11 Aug 2026 14:18:11 -0700
In-Reply-To: <20260808062601.1070988-6-memxor@gmail.com>
References: <20260808062601.1070988-1-memxor@gmail.com>
	 <20260808062601.1070988-6-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-08-08 at 08:25 +0200, Kumar Kartikeya Dwivedi wrote:
> Test the per-program insns_self, insns_total, and stack depth statistics
> emitted when BTF function info does not provide subprogram names. Check t=
hat
> the subprog 0 main record and static-subprogram records use <unknown>.
>=20
> Make VERBOSE_ACCEPT request verifier statistics so the raw-insn test can
> validate the output without a test-specific log level.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
