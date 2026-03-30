Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940EB3E5581
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 22:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774911522; cv=none; b=RwJxoYxXmydG1ja78KhhqyBK6Gz9dG9WNmCNBKQOxo0NvPZzXMN4dmfJfdKB2lRaU/DXFYzPzrTtWf/P/jHd17CHqLXDhTIuf0Sbwn1ibK020sHeHb/fsnZBl/0MpXhKdi3ZdKnGiyobyGV5EcsiPhR1KzkI/EWLeqRj0pUb3To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774911522; c=relaxed/simple;
	bh=PBL6A9j1PYa8/+gNJUwfixRW55hioSz6gYMA0dKmxII=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ApyQxUh6ivtvQgSaREniSPQUOy5MiRvEg8fy8KTvRGRH67gxXhk95eORKsojbJd9zwJZ0hCck2R5nbnH7sV0Smp8lQ0Sj3mMdrMUsW8xY7twZvkQzOE8YP6siKtj5d6V/0vwAcMQQC6aCWl2jtN7Z+4CcCdRd28DObOBQrrd7yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/RuexYQ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/RuexYQ"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35c124d2613so3273923a91.2
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 15:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774911518; x=1775516318; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bmHanOvT7cupotK5hwFMDmFdVkGrdt/V186UvlXBMs4=;
        b=g/RuexYQ4K5egbW1uG0nTKBLHza4xX6FO/Scp6/ELbUjo0p3oeCMwEvnUDNiIrRBRG
         glT2yjbmMQ/0KIIqsbuapFhWeLs0HQsFwA20eUJ3sKMXSGGyy0KV6Jc5N40Wy5gBShO/
         4EbWH8/99a5AR65sCjV8Rg8NPYbPGo/7Q1knpnf+hbg5ELethbNYb4OHh7yaC+mUQ65R
         ZDFg/A0OCCEWHrCPSMQACBFKsTxHWks6KUdj0kMt2FMB0c8Vixo9qN2FYYVD4PVd43Rj
         QDRxnt9yjR7MPT4xr+ID40TbOJYnBSY6KPNTitj0wsRsYdHDfldYCCNk8N1NdFQZVn4j
         kWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774911518; x=1775516318;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bmHanOvT7cupotK5hwFMDmFdVkGrdt/V186UvlXBMs4=;
        b=EmFiXejdvqdw1lw2n1mYIqLXyl5Ma/AlR5tZl8MttVNvrO07MR09tV0gFXSgLscj6q
         //QdPBdxtnbUAJG47P7rxw3acN6IhOR3CNYhTHw4/IgdXOAMlZXG0B4lG+qofTNl9ZiT
         iUiBiVa6y2OWP8pGqWeCkj2Pdg7edPvzFN/OzXY47djftnIjNE0E4O9Tf2Da01HkBH6R
         yxTXA0McnE6TNt0aihv/BlCMRKTOtavpmBINYOjb/Bd/Lm18ka6dDPCAAqO084PYV2bL
         N1QTMIMT81OS7hTrd21/vLIwtQab7+BRVJbapjVF3Pj6xU51fckZ5FrD7teMeY85gM5f
         9apw==
X-Forwarded-Encrypted: i=1; AJvYcCW6KT28f9IdIyYV3D+PA52kICt3aJaRySab8j6QS7IZ8GFXrfIzPBT5mDOWX6lp1wQUOnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTm9y3a2SUaabSmAGdTQxtSDzqfrFYmY7qT4Gqtg3hPaFbQ1ii
	WDyMosUJ13nTs4kPusTXaOUAslBrn9/jxmUB/Od0cTaZgvCJJ6xtE68Z
X-Gm-Gg: ATEYQzwE9ltBnxNknyKdlhLjBY8Jv1BXCcovsmzHIrs13kdfRwXpMsaiFDInNfGLS6R
	lCuty3kU+3wJYumnRlhHxG80BFBvWCmlLAFgdJnht16QLptDVXZXbsSSkQhoddXidn6c9Yu+Qq2
	F4sVwxg+PALC+98MckQ9vLanuN4TIeLe/dkBnM0IMzQkGvXTvpbYG7p8TBJGKDlSJg6AqL42vTJ
	u/Ywni5p4lti+yy6otcVcv253LIKw5vuO4uzIMedbIIc/ZIFRAXgP5gEujTf9okptSllnRwjx3k
	aN+OpLAaMCLN5b1HDE4Yf7hARF1WcZtHqcFwbvt0JSGAutYFQvYjBckCXSUzM1LZ8DNv/2xUxzQ
	mqpzQAo15VxH9tImnQtFJhjGO74bBJx6/PovB+rTyKbEW6arWUyYB1Hptt2FplEc3OD32It8R/f
	2x7iw7gfvGCrj2CvxhFU6GSQL0ecP11vy58h1/CfD8wxXTxMlNs1o=
X-Received: by 2002:a17:90b:1d52:b0:35d:ac66:ae72 with SMTP id 98e67ed59e1d1-35dac66b44cmr4003574a91.30.1774911518389;
        Mon, 30 Mar 2026 15:58:38 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35d90beda29sm8547650a91.15.2026.03.30.15.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 15:58:38 -0700 (PDT)
Message-ID: <3ef3fa858327758c900216613d4a2bc7e9358e66.camel@gmail.com>
Subject: Re: [PATCH 3/4] selftests/bpf: impose global ordering for test
 decl_tags
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org, 	andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, cupertino.miranda@oracle.com
Date: Mon, 30 Mar 2026 15:58:35 -0700
In-Reply-To: <m24ilxpbww.fsf@kernel.org>
References: 
	<20260326-selftests-global-tags-ordering-v1-0-5dd2ced5d9ad@gmail.com>
	 <20260326-selftests-global-tags-ordering-v1-3-5dd2ced5d9ad@gmail.com>
	 <m24ilxpbww.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-03-30 at 16:36 +0100, Puranjay Mohan wrote:
> Eduard Zingerman <eddyz87@gmail.com> writes:

[...]

> > +	qsort(tags, *cnt, sizeof(*tags), compare_decl_tags);
>=20
> Nit: As you will do a re-spin anyway, both claude and gemini say:
>=20
> If a BTF type has no declaration tags attached, tags will remain NULL and
> *cnt will be 0. Could this cause an issue with qsort()?
> Passing a NULL pointer as the first argument to qsort(), even when the
> number of elements is 0, is undefined behavior in C. This can trigger
> UBSAN faults during selftest execution because glibc declares qsort with
> __attribute__((nonnull(1, 4))).
> Should we add a check for *cnt > 0 before calling qsort()?

Huh, what a strange thing to demand from a possibly empty argument.
Thank you for pointing this out.

[...]
