Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D893A783A
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 18:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778697369; cv=none; b=hD9L4oRf4qQE7eJr/vgBVo0mbkjzw6SNSWMa3IgvARyZs8+emcvQ6QZxvCg6iS0DXtYPjQWroDplYBiQajRD602a2PZDQj7k4p1iIk6yPkJ5fvSQ7uAUJnJIdRtgVSlUNDW1lYJaV1BtV+CLNLL93sqVi1DZgNcZeR6Tm6nFCqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778697369; c=relaxed/simple;
	bh=5i5ggbJDToYjr2+UInbpK0MRjhOMp8AcYCW10B2FshM=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Subject:
	 References:In-Reply-To; b=KVDfyqO5GV8EPhvWgahHVQ8DETHiYZtFc1zPUuovtXhsKVBOprp/B9Ue1RSj4HA79FngOeRpvEFUFFZaMPhClfQF64mqO3OJU4znQZgyEjbGBvzFvkJ/bfzkHC4ql+5TdacqSoSXalN82QgSOxI0kmg0KpLSBI3Y5T11nj/F5IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KGxRQJR1; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KGxRQJR1"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-910bb291688so18065485a.1
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 11:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778697366; x=1779302166; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JXPN4dHTpE7jfcaAdc50cGnTTg4+LOwthwt4QuAKe2U=;
        b=KGxRQJR1PaCSVZClxfVIJVKeHxwPD3cWdY2pOWYMa10LLM/TsqddgqP7cvfTgSO+H1
         gzE1SVSINyajtBSKI+LoPZHPrurcJiYQ7O9sZu1LskrXDFCCNUq8YNCdPdQFadR/lHAj
         9surc6QjEfE6cO5+IOmm1eO3JKcnorrFZGsCMcLm/ls+Q/ecpch06AO1zIZw13ms+/cK
         ornXau18SPFp79eXCa6lb+uVnYwvT5niFXADrp7JYjC3RwA3Kyz+OiQ+Ii545IsqNKBW
         a0wLaG8GZ+yD7+QCOTHSajNkYF8SrB4rNBTCipKPUYaflZzXkOkB9KUGrQUelMQF12oA
         KyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778697366; x=1779302166;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXPN4dHTpE7jfcaAdc50cGnTTg4+LOwthwt4QuAKe2U=;
        b=NpxmhqdEz6+OuGP5m2c61ZG2xySrEjPdTzjSJ0xb+cTSEvCPPgrCIuQq6NezLl4hM8
         5JOTnibds7gG/eMqZOpVS+frMndYvLug6sfrsl22ia2xzAHvLkkXONibPPr3krMjEqEM
         xiqCsc+PyypD5lvYyNL5irvBWzZKejrhY3zGAA4KyS0/cgO6p5EWVC1ieGDjVCbn2qfp
         oIr1HeKMsTEwqPyFCo7QBabB9nmXJEmhbmdz4OvzWE43e7Khs0vORbyV9GW0YuJHjnI/
         Hktgs7suB86tIoQHuHq3BaKtKfxhhq8W0Zdlg182WbTmSJaSYBXyGRBrXNZ5eZO3zx8z
         odgQ==
X-Forwarded-Encrypted: i=1; AFNElJ9V/BTNxBQ4hBuPKrzjAMxP25Ld+wMgivA/GbPT44TpC3zZpxuFPIoXfuNEO6bjlH3unRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX+N8sWEM5D8GSwQly+fgKXpzNvHR+/VonLA6PFIyk5ih33GGP
	/TewCsK/9mqPI7WOHSKCe/DPEJLnBSt84VQy0PQD7ReMOMl2pA3IkQsMB+xMFFvJ8Q==
X-Gm-Gg: Acq92OFtQ4di4EJ7QOdaBkSO9LNYZXEBkploCc8G+mz0x2JUqqKT7vgQb2I2NFgEiTY
	XvkzAbS87GT/lHle3vaKDqySBYGckGBYyrQAr0a/wo3hDcbRnuDaY2F16u3HPONFmBrqhk42RZI
	pXM8qqN1byriwL7dxdepg7gAFSF5ZM6JIhDbrUx344OHTyVh3KIdYpv3O2ZhERjhiw8QGh5rNYT
	OJE7ChpPrhI2t+obBsUQg47Pp6zcDUOPhEouHv7hcq5CRU6QdTixzQLxOSRC6Q9Z3k5bNwOEulY
	g46m4UfgevZ8fYmjSzVTp0tZ5fpAKhtMdSRyhytShHURgz8IPOn0u/m+pCyTkORn+j0w0sPxAJZ
	OsLTxEt+5S5Xb7hXyQCOvgbIDagAmDhHisAEk2clB4YXYxAu4AGepXddYl88/IRo6DhR8uF8Fu0
	bK98UdkrQClH7GqEX6I1AzzXEtWxE8cHUH+0S7fId/+VwxuveHnTtvfRIF7yvwHVkwmCriytk4O
	lZHv+Q=
X-Received: by 2002:a05:620a:2584:b0:905:ec5e:bdf3 with SMTP id af79cd13be357-90f8afef681mr641592285a.49.1778697366269;
        Wed, 13 May 2026 11:36:06 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bc93d0casm29988185a.23.2026.05.13.11.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 11:36:05 -0700 (PDT)
Date: Wed, 13 May 2026 14:36:05 -0400
Message-ID: <283fb822eadeffcccfa519cbb582a363@paul-moore.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260512_1604/pstg-lib:20260513_1343/pstg-pwork:20260512_1604
From: Paul Moore <paul@paul-moore.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, "Blaise Boscaccy" <bboscaccy@linux.microsoft.com>, "Jonathan Corbet" <corbet@lwn.net>, "" , "James Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, "Andrew Morton" <akpm@linux-foundation.org>, James.Bottomley@HansenPartnership.com, dhowells@redhat.com, "Fan Wu" <wufan@kernel.org>, "Ryan Foster" <foster.ryan.r@gmail.com>, "Randy Dunlap" <rdunlap@infradead.org>, linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, "Song Liu" <song@kernel.org>
Subject: Re: [PATCH v7 3/10] crypto: pkcs7: add tests for pkcs7_get_authattr
References: <20260507191416.2984054-4-bboscaccy@linux.microsoft.com>
In-Reply-To: <20260507191416.2984054-4-bboscaccy@linux.microsoft.com>

On May  7, 2026 Blaise Boscaccy <bboscaccy@linux.microsoft.com> wrote:
> 
> Add example code to the test module pkcs7_key_type.c that verifies a
> message and then pulls out a known authenticated attribute.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> Acked-by: David Howells <dhowells@redhat.com>
> ---
>  crypto/asymmetric_keys/pkcs7_key_type.c | 44 ++++++++++++++++++++++++-
>  1 file changed, 43 insertions(+), 1 deletion(-)

Merged into lsm/dev, thanks.

--
paul-moore.com
