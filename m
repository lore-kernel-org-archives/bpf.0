Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D232C08D4
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 01:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773106254; cv=none; b=XBeQ2XSCZueavGoIu9ZKinyt13xvnC/1Vx5wae6zkPWm1S8XSty+Zc7TuUDZCYTd9VOT4ONj1lLqjbRZALXKdekj1WF0yBzIy6i+tcM2H9KMrFrxyPOGVi4J1mLLqJYnunMAawBxr2LmuNnh1eRoLpBUPvWdkEG7P0ULBZGnpDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773106254; c=relaxed/simple;
	bh=hBpxoXekpgX1LKijNmZBmmyAcTRgmljZTGGRw81xSko=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LztMARUoz4dcrdshTYvRQJvid0kfwRL80hTpJDaJiHLpeLGa0hh0Ht9zj3JWB1aq9y0RhPccHBiDkgSgziOw20FxxbPfYWjq8aP72jBoOJvND0zqi6z3bsdxNByImdrSJ7er1cv9j8n/6dfSSqoAM38uBggiq7sW1NPpyEpi280=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwomZWel; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwomZWel"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82985f42664so2766362b3a.0
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 18:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773106252; x=1773711052; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NeUM7agmgMZ84eXQ6j7BgARidMQw+mmMKNVn3IHtzKo=;
        b=AwomZWel/7UhuplXFkjKqEYWN/zF5b+iLteJTxQwapnOk6kIHTk1L55xzttYyNO6M5
         3BYwLEK6YjxekH6x0/YgZ4nv99vSi7KZczeatMmfTFdM+FRHVIpdcoeLJQQfDVc38eCM
         kLj4PGCVPfJj+mhN+F1HrABSmvbuJN/Un1KkfpCucP0bcyw8zIEnH7IM4yxD9fEBlUfL
         MlrjZVWZIRTh6YpOVAuJGjLheA+3a01AFc9LJ25bwpEApMGX9IgEVUqtKSfKMQlZcJZi
         8oCEwKKJtwGHxo+TLw1D8Nm8R9hP9W6HicedS2nRmoBZkEV1HkAIbJv0djNWL9DC0xMT
         ONcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773106252; x=1773711052;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NeUM7agmgMZ84eXQ6j7BgARidMQw+mmMKNVn3IHtzKo=;
        b=alY8semrXkOPPQPvkcBN7Xv9kczKe/L6v0gPMl4PyHCKaB5hRIbKa6us0QoEhHsetk
         +z4WBvC74o2MHoqB2crIMnIIfhXj7k4YCn0Mx9G4k6WyLskbelTqeni4gAseM23dD/a5
         9LKHjG7/vAG5NMpDiFb3mLgSG5BaB4kRt/uyNopXHUPe4FC7UFGB56gzAh4Lp95dek+V
         zHhq1snJCgATfOzjOuRVMnTbZwnrBLDJsTnPzf7VtMdRL0/4qborOxq44klGk1r/ozWp
         oNFAYOVv7Wk/CMAA+aavr/WS8CtexM/+Eahlx8q3mco6njyEkvyyVopJ1/LMUQ8XMFlt
         2wZg==
X-Forwarded-Encrypted: i=1; AJvYcCUEz2pfzxs7Sbe2zWbuyDatvMuOvGlOuFAVrSIm/XUXBnCMneTWnRDUTfoLCTHxnJKOOG4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1KJOY8irXItzC1tJIJ3bxKGIefmYS7UbeaD2FmxVgzHn/HYuv
	Vyw0iH6aP5EjqOWFfbr3BjPXdcVtNjsysrfhY9qw39Whj6P6whRrCZ1f
X-Gm-Gg: ATEYQzwc/E6ya66qrRZiJw62l9gRlPFWLHQaQBZQocDm9U5Mzla51yXRfKWxD4f9rZL
	fL4vKiYc67GjSXWptKCE49R4B1gruTIVgsqgroclwvpETwOlEtQ3Cp55BcX/k1GNRVEl7hDVgWJ
	EEFIXU4W2DJtjp7WJb5uvBFSiZqpDOqim9oezaJ3MUY2PYo/VxTmm/217pr2uG+ip+4US6VU9UG
	zqEw8FlKtUvY3FvDV5Y/n5xkLrL1FPKBIFnPV9BpcWOgqIIRihPG+HbBVvPAIAtuAyxC6/j6fFj
	l4Cgh256eH6Hs5aN9Evk7L0vKx7y2kxNSigigk9Lm09u1QHd8UA7R8Yjautu9oi7VNo2GKL+h4a
	r2Ln0NWT/EAmwPmfcbjP6IQHfAoy2hRAfpq7dcRbigB2EZ5qVA5BMwZ1Ss9s9KjrHgRrrNOdrhM
	60wnPgrlQIEdOi58Bh9MZ4QSFcjkBqWJ5TizMWva2bWGZzD+wmmdDHXniMnU3eS6PkMovqgCF24
	Si16OkNWs2nfqeKIcr0nMYP4bSF
X-Received: by 2002:a05:6a00:1905:b0:829:924c:348a with SMTP id d2e1a72fcca58-829a2f78bd4mr11451008b3a.45.1773106252399;
        Mon, 09 Mar 2026 18:30:52 -0700 (PDT)
Received: from ?IPv6:2605:8d80:5825:58f:4756:80b5:ef0e:8463? ([2605:8d80:5825:58f:4756:80b5:ef0e:8463])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4867e54sm11769815b3a.35.2026.03.09.18.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 18:30:52 -0700 (PDT)
Message-ID: <d4f6ebe35ff98cf3aeabe132027d7a05ae4dda4f.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Avoid one round of bounds deduction
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Harishankar
 Vishwanathan <harishankar.vishwanathan@gmail.com>, Shung-Hsi Yu	
 <shung-hsi.yu@suse.com>
Date: Mon, 09 Mar 2026 18:30:50 -0700
In-Reply-To: <621f8a301a3a29af041ea8384ab09498e3f20322.camel@gmail.com>
References: 
	<5b8fed05cc97cd3730bbdfbb452699b7edd16963.1772840030.git.paul.chaignon@gmail.com>
	 <621f8a301a3a29af041ea8384ab09498e3f20322.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-03-09 at 18:07 -0700, Eduard Zingerman wrote:

[...]

> Of-course, I might have some bugs in the test definition, but in case
> the definition is correct, I think I'm inclined to agree with Ihor
> here. If we can't mathematically prove that the sequence converges in
> a fixed number of steps, putting a loop on top of it seem to be a
> reasonable thing to do.
>=20
> [1] https://github.com/eddyz87/bpf/tree/deduce-bounds-reshuffle
> [2] https://github.com/eddyz87/deduce-bounds-verif
>=20
> [...]

Pushed an update to the test to check if new bounds are tighter than
old bounds (instead of equivalent). Still get a failure log:

$ ./parse-log.sh out2.log
Values extracted from log:
  s32: [-1686110209,  1907957760]  v_s32=3D-1411416065
  u32: [ 1746894847,  4030210048]  v_u32=3D2883551231
  s64: [ -4350478693995380738,   2172132303447261182]  v_s64=3D-43504786931=
50261249
  u64: [  2172132302103053322,  14096265381705949184]  v_u64=3D140962653805=
59290367

Running C code directly:
input:
  s32: [0x9b7fffff, 0x71b92000] [-1686110209, 1907957760]
  u32: [0x681f7fff, 0xf0382000] [1746894847, 4030210048]
  s64: [0xc39ffead797ffffe, 0x1e24f6d2501ffffe] [-4350478693995380738, 2172=
132303447261182]
  u64: [0x1e24f6d20001040a, 0xc39ffeadf0382000] [2172132302103053322, 14096=
265381705949184]

old:
  s32: [0x9b7fffff, 0xf0382000] [-1686110209, -264757248]
  u32: [0x9b7fffff, 0xf0382000] [2608857087, 4030210048]
  s64: [0xc39ffead9b7fffff, 0xc39ffeadf0382000] [-4350478693424955393, -435=
0478692003602432]
  u64: [0xc39ffead9b7fffff, 0xc39ffeadf0382000] [14096265380284596223, 1409=
6265381705949184]

new:
  s32: [0x9b7fffff, 0x71b92000] [-1686110209, 1907957760]
  u32: [0x797ffffe, 0xf0382000] [2038431742, 4030210048]
  s64: [0xc39ffead797ffffe, 0xc39ffeadf0382000] [-4350478693995380738, -435=
0478692003602432]
  u64: [0xc39ffead797ffffe, 0xc39ffeadf0382000] [14096265379714170878, 1409=
6265381705949184]
