Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739193242BD
	for <bpf@vger.kernel.org>; Fri,  3 Jul 2026 18:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783102579; cv=none; b=jwhxq/jiyM6Q2N4dJYbRRm5FQZtOU8nrz0Xg0kU4niaHemvsJHxeNwJTHbPPskIkK1O2WFTXy5oThroZ8JZ0pDy5tA27aX0j6p6i/DNzu7mNAGkbAqkH69Ms60E9CcPvTHrb5Ayk+cHuaG204SpqcNtxjndpQWUxfFRXThNlsoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783102579; c=relaxed/simple;
	bh=tHaRnBkHGDwxe27vTn4OgEjwyrOSNdq/sa3ntNRDUrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QraDh+Jj2oiOnggE/L4neEPPyIvK/zTqfqVG9n+ygAaJwYtICYI/LCzMPmHE72tkK+Ow7dxwxOND520nGW9XQLFwytNOidXWDYwo+O3y9CAuq5wi8HM5+91o95JIBS07KI3qWAVIUvWB6M8A5tAwmbUZaOvErrvSdicnIHxdLBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHwECOXa; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHwECOXa"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-475417f010dso542026f8f.2
        for <bpf@vger.kernel.org>; Fri, 03 Jul 2026 11:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783102574; x=1783707374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=vsSwgqydI0TUTd1LdM/qdllikjjCJsaJszfdOZPreSE=;
        b=WHwECOXacfOlaFdVXkN4YzhO4D6o4cjLpP9QdnIb10K0/XQqjQRQrcAOmrou58QHlj
         rFYMA+KOGIiJunbI3hoJTotQ2gu4haGYpfWRqvSXprOYB97UBOSZj/S5eJLNgooT8ze1
         8h4r9G7Op/XhAjuoeaxOog8U2MPjcnzkzyaUaVjsF1w4/eCyaOAhNh7C2k6XtY+i7vB0
         txYIe1r4KDL6POc+hVQKh54v/F6L7c6RMaPCLV2ZeKjRW6JbgIaQbUlBAzB+PxQVF3lP
         YrVMQbCm8rYFnh+CYYc2UFWSVpqpNOGeLHSaIlBdw8YM4ovnxp93oBkfXtcgXvFM/Q21
         YvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783102574; x=1783707374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsSwgqydI0TUTd1LdM/qdllikjjCJsaJszfdOZPreSE=;
        b=h1E+wSxIjTEo+DqNoo0LIe94LJnX/KjtnqU8z2Qo4V49gYhEjKskxXL5XSd+nr7IqR
         Lo/7JcLflKVUGzO8mUr+BzuDsI6ae1zXlSidGsuc2kxc5KHgqXeE2a7YAmN9eqTLuUD4
         nevsCawVlyO4fZmdnYHUCOQI0SnwBLLH/ckKqj6IAbYzwF2R1xQiWld41hHpmhnbfBBo
         7z6FdTeRvfbzi9pOA4UrJ0wvRiLVBD/P/lYySRBTSQY50c5AVwI/dJFe+WdOK125mSKg
         XHJ9o3dniD+62eQ4IdvPzukzCLrpXnIBRp09xST5bHw4R76CGUc7TUzm+BIrp70+XBTf
         /FDg==
X-Forwarded-Encrypted: i=1; AHgh+RpjkJEd56/yy0DH5Vn6+o0xAY3/1ji8MhwwgqjBbuWDe5Xff4wl1j7XzwZdNXmeDYZK7i8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9q5gv0sPNAf0U3yk0uWoFOVjAwpkwNxn8lNUhVyAee+CoTpmg
	tuTQabFKENsXQ+WJADvViqsnu2/JoNLdGrDwohBPgNSQNk5NBh55i7Ll
X-Gm-Gg: AfdE7clB2e7AgTDeVTpBrC2djqqU4tf930/YBm2hNjzXXURrJb5Wpwe7/kpzsbBefYh
	JGXyBhF102g3YpveIfq89GJ/DbeU9ONLlhtZ0MFM5BEg+D/97gv2c1fbYeSL6xsrs+Ka+G//3Yf
	fe6k3KXMak3EpOuEvngc8JScUs80dl0j2qqfGrBy8IJkCBerCu5FpV31Wx6lsgR45NVvNDgLhmn
	pF1cy28ymoGU+iIdbTRrjMgr8tUtZTxrYixarGCI2rgRrbbUM7Lj34OATFu73pAo24xyNL4Ie52
	m9KZ/EoRpYdPFpUJBYibHUeggUu9MaG1znIfHuxQcl7Q8X5pAuzkqi5NT6sG9rmGfdO9NUN0Go3
	jrH5yyNS+XkUAe1Q7HlEIfYV7pVZ4pO66uH5nfkwpqL3vawnVbJPqX+z6jlduh6NUpWN3XIRZKN
	DtJI52HRl0BBpxgTSTLOzO7hdLj3brTU2FB90b7HxaT9xME0050fupLybiWvk5NcwRrgAnb2Rft
	EZd6Zli
X-Received: by 2002:adf:f3c8:0:b0:470:a7d8:75f5 with SMTP id ffacd0b85a97d-47aab77041emr390229f8f.42.1783102574577;
        Fri, 03 Jul 2026 11:16:14 -0700 (PDT)
Received: from [10.128.11.240] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d8f1sm1195806f8f.3.2026.07.03.11.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 11:16:13 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <92264294-afe8-4752-9f22-2b633373b288@gmail.com>
Date: Fri, 3 Jul 2026 19:16:12 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 14/15] barrier: add tests for
 smp_cond_load_*_timeout()
To: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
 peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
 harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
 daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
 xueshuai@linux.alibaba.com, rdunlap@infradead.org,
 david.laight.linux@gmail.com, broonie@kernel.org, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, ashok.bhat@arm.com
References: <20260702013334.140905-1-ankur.a.arora@oracle.com>
 <20260702013334.140905-15-ankur.a.arora@oracle.com>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260702013334.140905-15-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ankur,

On 7/2/26 02:33, Ankur Arora wrote:
> +config BARRIER_TIMEOUT_TEST
> +	tristate "KUnit tests for smp_cond_load_relaxed_timeout()"
> +	depends on KUNIT
> +	default KUNIT_ALL_TESTS
> +	help
> +	  Builds KUnit tests that validate wake-up and timeout handling paths
> +	  in smp_cond_load_relaxed_timeout().
> +
> +	  Say N if you are unsure.

Could you follow the kunit documentation for the kconfig entry:
Documentation/dev-tools/kunit/style.rst

Specifically, these two guidelines:
1. "be named CONFIG_<name>_KUNIT_TEST: where <name> is the name of the
test suite."
2. be visible only if CONFIG_KUNIT_ALL_TESTS is not enabled.

- Julian Braha
