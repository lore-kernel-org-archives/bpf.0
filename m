Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5C4770FE
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 01:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770945102; cv=none; b=T1QkEZkp29sMfACgDTxz/C0l5dRWsDOnJ9+05DggOFSM2LTfmUVePXocjdOMawlo/gckTIv6qk4y6be0bkTg/BxaMjxVhiwsm8nuH6AoE3lj4albmqfdyxih/a9jk6LzpSI00wm/9ic0VOcNNX/ttaLLDy7y0Ry77BgweNB9XjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770945102; c=relaxed/simple;
	bh=jxYztWNpVeKvl6B2fZ+e32o0TLeGj2Yvrhrm8OWeD88=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fVTSAW+/deaiTmiPoqvuSiPVFToshBzcOndL90fwZBXAIEy31l3o+1KJiielMvHBMOYNrkLmJFTyS5BOpulPclWfwSSamzmW23czg/Xdqfuc3d7p/xlwHieNdB3sfl2oxmUZgwZjlbcZM9l6OjOcf8oeyI9HwMIPm9VxGx+sFcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=as2AqXqc; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="as2AqXqc"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82310b74496so268439b3a.3
        for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 17:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770945100; x=1771549900; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QfHpzoQp+eFrx7F5Ps2/mOH8QXCs+GOEEHm0ZjIL3HU=;
        b=as2AqXqcSAYext3an3bbrUMiyT/VFDH3jeAt4yxO+wz9KEh/evJGYhEkEOCBevlBod
         YjPjjWzg0D/BtKYTsUCu6D1pSLNKCAkJ6AXuxVxXWT8xWOet1NdIgztTYvgw795VqoX3
         yFQb4mG9g4XVQMLC8DlniE3R5Ht7ti/qnL+v7oUD+4mxGVd1WA4ZxIZXN9c3mLdNSDNm
         sMDdS2EbKt/i6eLny2nzmOzfJYv/5MiHKHMcHhWQdO7YxrNM/4cgUO6MOWdMrK5k2GRU
         ingyXCqEhJXLJ67xICu7U+kTFiknGQps7zOdX24rrZTg/mGi373uvfQ1FhwUravamJVJ
         lYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770945100; x=1771549900;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QfHpzoQp+eFrx7F5Ps2/mOH8QXCs+GOEEHm0ZjIL3HU=;
        b=Y+S01rtugqHzBlL9+2SZIUn7iBn+ch8Sm40+GIYYnm4TrwthL2xsx915kKYQey/JJq
         hOPHZXeVrqh8Xsd/9byuqfVseloo/itQbzotYA7H7PxYgEXYa9+rz66GXkXaX/9MZZ+u
         zHSW/ERe6aDw80Bm1u3ask7Hin9Msfq/qeCC+pfE8B24CGnO4whpuNwWPrgN0zRZX9LB
         +Y8HuqlSW1Jo3eKFaJ+wG2TqqpiO60c+vewP0phHPr3VK4VyM9oHlNmLQyReJGxxYKOG
         8dml9teqW7O8jr+TYqirXZpgCb++OTS3rrJMV/w7cbxW2YwiDgWZHS2uOPgS3o6enNph
         BPqw==
X-Forwarded-Encrypted: i=1; AJvYcCXKFJzHhHuTngDJfy5z3jJjq4A9HjyV++LFulcBYJ0wVQH+nGdWiCEhL6Xy1+UKRaA6SHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMkiIfNkfoUX13c8BU+iny2PmJD3dnl75UsY2q05FJlHeAEB2p
	zOI2Yv01vGGBvVHmUe2LDZ498HH/B6uXIzifqjkzD/C/Eup/1ezqyhjK
X-Gm-Gg: AZuq6aIN+bDQNc4N42Lg8fpdFXAxcaxOKo5iC2gU1WQzyL3Oufula/2BTH5RXLIFs6s
	yYDEtO569WpOAEoP+dwPgIk8Exofxg77y2bzhxdMbWjLmn/nyGCS10Ls63wpDHrGU8rrMpcWgTF
	oNHWOEGCcZSuOTG9mEiuJ87dDc/dVFC2y57DTBs7XOxzC6hzUsqihB96ywJt/opX48LKrVvw4mR
	HMkedFHfFihYNwhy/N/Se4sfEiue/nIoyn/yfa/QTv9YoHw8SCTvYxKJntakIudDDvTmGuOyf1k
	sQa5crez8Dnnm7zVqEqlH8lnR/NsdoIZNld/x7Lyppt3AD1JxEydTrR7TvewDWxTbtEtOWvPrVg
	HcrHCvaQwjxMUT4r+auY9SvrV9fXQ8fWFCfhB0Jdn6YV9mCwDdNpbNchIrBqg5iXwutUJ8SCoR8
	blKTVaNRVjB/lCwaZx6FmGeGkilydbrQ01HDbUljuBcKFluxlUryA=
X-Received: by 2002:a05:6a00:4305:b0:824:40d8:9d68 with SMTP id d2e1a72fcca58-824c95a644fmr336642b3a.32.1770945099630;
        Thu, 12 Feb 2026 17:11:39 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6a43ff3sm522384b3a.24.2026.02.12.17.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 17:11:39 -0800 (PST)
Message-ID: <59f6faf52bd77c01a96f495eea3c7389c3455b50.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 13/14] selftests/bpf: Fix out-of-bounds
 array access bugs reported by ASAN
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>
Cc: Amery Hung <ameryhung@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>, 
 Alexis =?ISO-8859-1?Q?Lothor=E9?=	 <alexis.lothore@bootlin.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 	kernel-team@meta.com
Date: Thu, 12 Feb 2026 17:11:36 -0800
In-Reply-To: <20260212011356.3266753-14-ihor.solodrai@linux.dev>
References: <20260212011356.3266753-1-ihor.solodrai@linux.dev>
	 <20260212011356.3266753-14-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-02-11 at 17:13 -0800, Ihor Solodrai wrote:
> - kmem_cache_iter: remove unnecessary debug output
> - lwt_seg6local: change the type of foobar to char[]
> =C2=A0 - the sizeof(foobar) returned the pointer size and not a string
> =C2=A0=C2=A0=C2=A0 length as intended
> - verifier_log: increase prog_name buffer size in verif_log_subtest()
> =C2=A0 - compiler has a conservative estimate of fixed_log_sz value, maki=
ng
> =C2=A0=C2=A0=C2=A0 ASAN complain on snprint() call
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> diff --git a/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
> b/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
> index 6e35e13c2022..399fe9103f83 100644
> --- a/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
> @@ -104,11 +104,8 @@ void test_kmem_cache_iter(void)
> =C2=A0	if (!ASSERT_GE(iter_fd, 0, "iter_create"))
> =C2=A0		goto destroy;
> =C2=A0
> -	memset(buf, 0, sizeof(buf));
> -	while (read(iter_fd, buf, sizeof(buf)) > 0) {
> -		/* Read out all contents */
> -		printf("%s", buf);
> -	}
> +	while (read(iter_fd, buf, sizeof(buf)) > 0)
> +		; /* Read out all contents */

Nit:
  -       while (read(iter_fd, buf, sizeof(buf)) > 0) {
  +       while (read(iter_fd, buf, sizeof(buf) - 1) > 0) {

  And keep the log?

[...]
