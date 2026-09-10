Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA653C3459
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 21:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789077236; cv=none; b=ZaXfRjUyAF3uL1E/OmLbtSXMom4B0AdMQS3uI6fGRie4loilSJ3j6pBRdA0wGMpYaK5tzCfUUTvfsJ/EaGBoDYkEEKX+2/SGr7Nrp35w5Uwns45rkzAau4wUW4jb9Mb8zH6ksOc8BkPjkwzQAXfLcYNiuZ9hhF0mmiOtq5dyALA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789077236; c=relaxed/simple;
	bh=fYceEmhQ9cSzL/cO4AaweTkHGnMFU02VkQovjSJrMGM=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=SazrUYnRyyCi/iQvoJzuZs00MKsSMhq2lLKWACR14qP39yMrzOV9/+9/8QYzE9uw6yI2bkI+GHG/GmEBes9I640BfaXDKLHLHU/uB+K6+EuWVJUjm6cByL2YiVh1oFhBa1fSWBZiVR1/mjYKRdC9vKCUEjXA0F90WRiPphwfd4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q45pHIPE; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q45pHIPE"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466ccde2ad8so161121fac.2
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 14:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789077224; x=1789682024; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=11FgZIbI/jp2fvZ+QVpLIyIJFprJ73W7wj4+xdxsQG0=;
        b=q45pHIPE91g9qKAsyBbJlnm83v84HuP0ianXVmt23555U/hUMC8z2mVRwJqVD0JoTC
         NN1/LJDjrPxH2Tcb2SqZqsuOCnO/QWOXxWIZBvoU5N5uZ/MbJwM81a5DxgqHUWsmT9++
         zIdZ150mOlrln4BJn4jremgyhfv0oq1cYvoIlC2onEKn3F46sBxMsk8eaGO21IqEjL/H
         IeLxT+faIWH94+k3F2SlYSq53PIrxAtwbRpBOHtwuor6Kq06FkwcZwuzpOrigicLvj+P
         ShYN7U8fFlRrrAIIbVxn73+uiK4M5rKDMRfBtobh2ZQyKjlyeKKpPDPmqyjhw4kXlh5W
         VSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789077224; x=1789682024;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=11FgZIbI/jp2fvZ+QVpLIyIJFprJ73W7wj4+xdxsQG0=;
        b=SdZFiw6zEZ/UxbL70vlPGHju22OosHr4eHmrZbBwcWUnLDEVyWiVN5jOSVs58gcRky
         tLSBfnd3Cz/VbIgj1Xn7hqhdyxu+dCpmIiS07+keZQD7TibuJAQx48dDPamvWOnBvF7D
         XSQwHwLJAJb/AGxH3fjCM5BwA2UApMi8Va/XvAU1PT645fWh3yilOz4DqsSyPB3YnpXv
         JqeYdALH1RgPt+d9sLhnbBeEWyWNKTDUqj/9EbUn9e6RrrMF259Fyyv1e62BbyfWO5Ve
         FLLIg8PK5P8kX1Q48xkZJg16N8GNe14vkvdHqyVS6bXmleVCB+c90x+LakZwaVbEKX2R
         pMWA==
X-Forwarded-Encrypted: i=1; AKwUvBzBXK27CB+ESyvi0gwo3WPhhgx2UJVR/I/D669KPr/ertvk0V4dTgBi9dmczWJkTEEMlWA=@vger.kernel.org
X-Gm-Message-State: AFuF++kl897Z3IfYBp09i5A1FI0JNCXsrp43yZ3alDZ/nVuYLcUeF6rA
	HL4EnbAR2UhgM4teQ2e8w8H53XIab8VpLXee0PxDkjzIqOwttKgLkWO3
X-Gm-Gg: AYBFou3O3U8r3XA2tZO1rZHCuKb+lauvFini3Da7hUUIJvwGAdENKqHlJwIevSFOv6L
	/0z6GFtf5Yl2IMl4J0tikaoBqpliH4G8tohkgclGQ8BjwC50qR7Ahz/uhP21/AuAa1AFb1/dWYd
	FG+JHxzvezoARJnpcsnqchXerRRO4PRM50T9B3pbQrlJo5AfoVktXXIVWlnykCMxuUs/aJQXzP8
	J6D1CVS38caauVoCSOvjDJ3nnYgnJiHXq0f3s4FwGkOEypSMtXAjSVoH1zvHLMOz5/EwJYpNJpM
	wD2WnY2Jqx56xQ5RgJwWHN7qyfta7gpzDp+2waOtLiB52xXchH0vo2zS1w6yTVsRvQB7QeqV55f
	HYg2+Lm34ctGQvA/Lqv+mN/EFioOM6/pD4CWsPK+IrVnS4CJDW0MRYeDo6szA32J91OWhvictOV
	K1/BOnjKqceazbVm3WvwE7iGSbmhYwCRVE7eeG37Wx0ybpfZaLg3EXt9ZjVW4DGO0mOyTGqrlK5
	wxTIjevPnc2EO32yyvqB7/3fw7EuiQ2yJI9WiddC+5xPjdah039O3AtL/joECcTEvbJyqTitJVS
	2Q==
X-Received: by 2002:a05:6870:6c0a:b0:47b:d053:6a3e with SMTP id 586e51a60fabf-47de94e2ecdmr1323247fac.11.1789077224378;
        Thu, 10 Sep 2026 14:53:44 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4e::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-47df8bc8884sm387439fac.10.2026.09.10.14.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 14:53:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Sep 2026 14:53:43 -0700
Message-Id: <DLBYY2250A90.R1ISQQXJ44R4@gmail.com>
To: "Amery Hung" <ameryhung@gmail.com>, <bpf@vger.kernel.org>
Cc: <andrii@kernel.org>, <daniel@iogearbox.net>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v1 22/22] bpf: Check helper and kfunc arguments
 in one path
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc
References: <20260905220117.922028-1-ameryhung@gmail.com>
 <20260905220117.922028-23-ameryhung@gmail.com>
In-Reply-To: <20260905220117.922028-23-ameryhung@gmail.com>

On Sat Sep 5, 2026 at 3:01 PM PDT, Amery Hung wrote:
> +		err =3D check_mem_size_reg(env, buff_reg, reg, buff_argno, argno,
> +					 access_type, zero_size_allowed, meta, &failure);
> +		if (err < 0) {


can reduce indent here as well by
if (!err)
   break;

> +			const char *buff_arg, *size_arg;
> +
> +			buff_arg =3D bpf_diag_arg_name(env, buff_argno);
> +			size_arg =3D bpf_diag_arg_name(env, argno);
> +			verbose(env, "%s and ", reg_arg_name(env, buff_argno));
> +			verbose(env, "%s memory, len pair leads to invalid memory access\n",
