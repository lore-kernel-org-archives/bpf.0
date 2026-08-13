Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8955FDA7
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 00:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786581564; cv=none; b=EPt5OJOr/IJ9e7HKLPDOoEZZQTSUQC3TwubzH7aTQ4v5xZUviHfnIKQIPdsv+1Bgo2lmbLAXUkp9YiOYFxHLTGW//aVGrazpT1g4bsd+DUFJR970UrUdA5xT0pTDkcxkhbNrBlZdbVzvvmmRvACrpEwKO/qOw8PV/FAlp9vDTUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786581564; c=relaxed/simple;
	bh=AKzNnUGpIQgsID1GH1LN6KeL/O3OduRfA1oucI1lPeA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T4Qt/2d363vPUN/PGn+oKuqLKf88P0PiO/1z2K3c3e9jPnhytlRexPU6ak9kOqVHoYh00SNOoE/8c2kTEFoo4Tq3m+3a/D/dKB80HnExUkjWW0kCiYAS48EiiPkIpy4OXbdn7KSP1NPz+Hi0vMwT8qMPfHSTsIUrxjhZ5038LFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBfWFF4i; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBfWFF4i"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84847482584so371981b3a.0
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 17:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786581562; x=1787186362; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AKzNnUGpIQgsID1GH1LN6KeL/O3OduRfA1oucI1lPeA=;
        b=YBfWFF4iymYKlraRhRDJd92U5V9CPJpWQw+58lO+lFmjGCLr+s6vizu0jVFcl360T1
         c8motLw6iqDSvaaJ/iVw5rxiajdDJERQcX3EApxx1Dj7+pdpSmuEe3T9EyYwu6vMOORM
         L2trKypMRdhYD92i9LIAtCiZdjKruufd/JO6IYeJfM0kAqL28MIKUKDGG6vFkGkuL4xQ
         YKvgRUMVeyBKL9N8jm7O3jkPJFc4HTIiUourc8PUw8WppbinIbTAwcTSRQPRvOyBYl/A
         HnJDN4PfHjR/UN6f/4S4nnTLO7xpl0HHGBaDMYktmXZxrD5X63gBziVWY4EDkJku7VGP
         4orA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786581562; x=1787186362;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AKzNnUGpIQgsID1GH1LN6KeL/O3OduRfA1oucI1lPeA=;
        b=RQNTt7vSnibr3Eq6i7ylTk6hCW7RE1B7SuYFJvXnp5JMrDyOFOTh5SGaTxxVnLiTqN
         fOPWgLw1SycR5nSTCpW6B8faS+wR3oIXx5/a7MPppEO9aaeg+gMlz3QDNN5MYkxeVrGs
         0rGuR2QyaMXpkczqYymGO5vnY98+Uny5iS4ljmi6vicK1aE2sYBotMSRZ+ZM1JFZNfgA
         V4ZevhlZnRMjg04O2I3eRO+FO6xHrs7gA0JEvxPIJhk7Cl5yWs4m/Ut+zwZ17k0eUiwF
         8q4dVHeNodOOzasAmoMF1KhdES0iQRFGVqoftBXrGvFXpbAKEE3h+1sJQAnQPCLKapF5
         AJ7A==
X-Forwarded-Encrypted: i=1; AHgh+RoD/ZmeeVE996SXRzLySrkFYBXjcDGdtudgx08Det+7kPp/51t6WpiWkYuiFhhznG8wjV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaRAip5DR6Bvq90UU22a2Mf7xf+CbSJnEAR/vP2ybbQ22nSBHH
	WRhecWSkYoqczQkUv58zkHcFOH8oPIyj3ALPMMB9F0uzgVulIfX1VfLu59WoZA==
X-Gm-Gg: AR+sD12YtZ3Akj3L9XOkonswDXeuAHaTM7sRGlKXbqmfPtTSmCvCk0YVN7Wap4T6G6f
	3a+9tbttdNfrQct2vJI++/Vky8jtFJ2KTFDJ1+L7gA8HXJ/GyhFlBI+1jv7VD9RypmAZMYhGLcI
	B/PO2/Eq/kyV0BUcgVG01QpMvrI7EwvtC2HJ0eLLS529c3pRhNoDMLQk+g/CxvLYNa3hAm5XYAZ
	5HNE5sAqaql2fnweS91ihy4Rd4TG4Vonspja0cG/TYm28krbcwfPhRHHxiEcFRZ35dsbqP3vGj8
	ApDAlGAfws7/IvcgNMLrJyhZijkxItTXjNk7gWCbxKQOzwDblcm2i+4j8Yjk1GM5Xj5VWeUryJS
	PWW+MrFV0wkvk31heSej4SejCIzTsnYLGnnjKq9cevDp4okxtqD6eTQHiDIHGUWRTDougw3IOHK
	hS2iDBkW5zsmhZOVlz5917uQ5pbo44gLRReRVbfnHeI1gGJ0cl4MgzJASHapu+erAxSW0KdsVmt
	Eg6SkXqPRHxWo5F
X-Received: by 2002:a05:6a00:170c:b0:836:6f2e:bb6d with SMTP id d2e1a72fcca58-84fc7c59135mr1423262b3a.14.1786581561989;
        Wed, 12 Aug 2026 17:39:21 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fc477e556sm211415b3a.13.2026.08.12.17.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 17:39:21 -0700 (PDT)
Message-ID: <e2b1029ee3473e43603412c185302757c918b17f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v8 2/6] bpf: Attribute async callback
 instructions to verification roots
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Wed, 12 Aug 2026 17:39:18 -0700
In-Reply-To: <20260812221925.3358041-3-memxor@gmail.com>
References: <20260812221925.3358041-1-memxor@gmail.com>
	 <20260812221925.3358041-3-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-08-13 at 00:19 +0200, Kumar Kartikeya Dwivedi wrote:
> Asynchronous callbacks are explored as fresh frame-zero verifier states,
> so normal callee-to-caller accounting cannot propagate their instruction
> budget to the main or global subprogram whose verification scheduled them=
.
>=20
> The callback exploration still happens within the same do_check_common()
> invocation as that independent verification root. Record
> env->insn_processed at do_check_common() entry and override the root's
> inclusive count with the delta before returning. This includes all direct=
ly
> and transitively scheduled asynchronous callbacks in the root's total
> without maintaining a separate accounting call stack.
>=20
> Static subprogram and callback totals remain local to their synchronous c=
all
> paths. Their self counts continue to account for each processed instructi=
on
> exactly once.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
