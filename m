Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D507D823D0
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 16:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710865583; cv=none; b=ARC6CU2caMPcSiJLjj8CRvQdIm9NsQWv2slwcG/lHdlUaRGZEbFpib5fOiYdH9Hwef2aUiDwOPCcIr23kzIY+MMt8pgwlwEjcVWTT937gIbL5NrbBxtC8QOp41B+LWoo0A3G22waaLiD3QmOhYev2m/YqcnVnNw2CleYUnsk4j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710865583; c=relaxed/simple;
	bh=2Zvud8jR3Bs/murdkznVoVKbL8lY2br3bmcOJbTKni8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VF/LDn6GvZV4OCnmircR5mB7ouxAVdSY3SoVFkIjQ40IbRlixRAPAktYvDs8ibm0NkyxX3CGCSu/6PkaxBlYyL1ThWJbFg7nrvMB48+EA6sQR0Kp2L+ADY0ntygB8NF6nnthRQmWv4w0nWg4i3r9g46UI5zXaChvWZBP0iyIu9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azxKJ6jI; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azxKJ6jI"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-34100f4f9a2so1717488f8f.2
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 09:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710865580; x=1711470380; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2Zvud8jR3Bs/murdkznVoVKbL8lY2br3bmcOJbTKni8=;
        b=azxKJ6jIxt9YCM91v8fyExtm5KdkDY+Ukf4mgC4IAMCYRlN+XQwHyVzYFz6ho1Saf2
         hx5A42v77cWnEwM+e4NWYsYBGGWjC6MkMYXl6hwdRMzGVSF8+mhQn7qwQEpS8xuUVvQq
         Szl6epOz2LwMqfTs/KuhFBpnizxwDg2MevFGMi56eBEf+/mp/SoFb/0RotLUxxAcFH0M
         q2qYQR7GaXqDMWO/C6sy73Id3Id25oAHMrJf7Qfc4m09wHTwxyva2dMBeRl7LjpgU2p0
         g/t5smZq1UlZVjEV+oga1Nlnt443SUykodbAe1vZ42LD4hdu5zuxPHAGFYnMJ0tILWkT
         fcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710865580; x=1711470380;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Zvud8jR3Bs/murdkznVoVKbL8lY2br3bmcOJbTKni8=;
        b=IBn/2E+9KOA3sejaK2vXnD+9cAMLmNBZpmgMVo6kRrO3lEbAiT2efijisTzxzuPnvg
         jDeEon8rVAmmipPQVyKUBXAneaZ/QfBd2rCvf/ba0B6o7cUiPhzbBqc8uKT5MMHG1Btq
         Y33mVE08VVC2FmjRQX8wYzCLl86jo0gjt6J0qd8IbKbqBPtuN8Db7tQM5rPLXUFhGT2U
         1DBFqW3Ad1wBSIqDLhlYtR/VQMfPM8DXGQu6WnuWKBWVIwFnfZCCLcyIWAjHz9fmSK5w
         z/zQ8b0Rr9Jm51FZ3qtCHlxx7DY7r3ObdL2qmKUhiv31qssR7skVcp5DCgBMaS2uhJoE
         /W3A==
X-Forwarded-Encrypted: i=1; AJvYcCXgdQtx55r0ap/CC6vqP5/k5u7jhWWScxt+osrL0/mf90AEb/7ip/pgX80NxQ8sP8I/ado3+A+Ek2pz4QcHj2YOlfsd
X-Gm-Message-State: AOJu0Yx27mB1M5gpB61YhZF8cgQ73uqSaoKOJ6jvoYLgRHHrzJY5wGWT
	NxCVeIEz64mjlNN7dO1pZE7EXjbmzmsnsNt2r75RyVGV1TaMvh2f
X-Google-Smtp-Source: AGHT+IH+rWJ3LgkJgp1pUWCtJqdOQcz0WtBPtK/LB7gVYeu0DRhOTVE1Ice11VIIXBcaC2fMRbNk4w==
X-Received: by 2002:adf:f1c5:0:b0:33e:d605:b8a3 with SMTP id z5-20020adff1c5000000b0033ed605b8a3mr8402059wro.39.1710865580161;
        Tue, 19 Mar 2024 09:26:20 -0700 (PDT)
Received: from [192.168.6.255] ([5.1.5.0])
        by smtp.gmail.com with ESMTPSA id k4-20020adfe3c4000000b0033e48db23bdsm12710510wrm.100.2024.03.19.09.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:26:19 -0700 (PDT)
Message-ID: <20b6174a74fdbf00a1b0f5593b854518cafc92b7.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/5] bpf: support BPF cookie in raw
 tracepoint (raw_tp, tp_btf) programs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jiri Olsa
 <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org,
 kernel-team@meta.com, Stanislav Fomichev <sdf@google.com>
Date: Tue, 19 Mar 2024 18:26:18 +0200
In-Reply-To: <CAEf4BzYp+rA+jov+GZsk2BjO2nBUYOe6vCL_ndiGQFP4dxH-=g@mail.gmail.com>
References: <20240318184037.3209242-1-andrii@kernel.org>
	 <20240318184037.3209242-4-andrii@kernel.org>
	 <43eaaada2757048eed490ef2bc74d5d310889410.camel@gmail.com>
	 <ZfmJm21mKaJN4vyh@krava>
	 <CAEf4BzYp+rA+jov+GZsk2BjO2nBUYOe6vCL_ndiGQFP4dxH-=g@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-03-19 at 09:09 -0700, Andrii Nakryiko wrote:
[...]

> > > The struct bpf_trace_run_ctx has two fields: bpf_cookie, is_uprobe
> > > (there is also run_ctx but it's size is zero).
> > > The is_uprobe field is not set by the code below.
> > > Is it necessary to zero-init `run_ctx` variable?
>=20
> no, not really, we need to initialize fields that are going to be
> used, and is_uprobe *shouldn't be used*, but see below

Ok, thank you and Jiri for explaining.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
