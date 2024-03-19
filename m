Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E896083A15
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 16:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710865022; cv=none; b=FSpZZ1C5Fidp9Z9NOsYilJPoVYtzoI5HVtreKrzDl5srVy4DVwD1dPhkBS/0Y3LIgt0coHB2XdYV4I6whiLsBhfVbekBBwuDtabFfZjcVdRMKtB4jLDAtQe6BH74rWYNOkhOr7g5fiqhjf+w9jiFxDQ90PWTFHufbSv7NvXh3Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710865022; c=relaxed/simple;
	bh=u6iYq34P9ythTjGIr61RfHVckycRnVyhkTffNVEZI58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eUJGnCRqDtOBcJQOMXBJJTgknRo1CdCjU6ZLWsCN8CESHn7ISiN1AOwJ+btmSvTYKDcTEY88RJ1rIA+ERhifPnBBL4QqCbCoqb1wTB/1FN1+dKfdm0y5MgdqGRirM+OgqD13dTARMuqT9ekDu7bCcoz4DF7y3y3nMPZAyLwCxZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bu3v9fzg; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bu3v9fzg"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e04ac4209eso6364415ad.1
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 09:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710865019; x=1711469819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6iYq34P9ythTjGIr61RfHVckycRnVyhkTffNVEZI58=;
        b=Bu3v9fzgNn0PYCOXombRuw/FobhDgaR6gxL3GS4ZfvA0mvogJ7HfawixuXce04pM1S
         K0NeklnWsCxrKcaCWhtoSwf4Ce3flT/YDlO1+uglXY0pYiEU0IDywwYrbl3eysW9wmDp
         FfpS/YdSiRt8SBvRHg9b4Vda344ucJOjB1OyjncTDwbAbbwaxtRrkBW4agknfJJQ9i6q
         K94F5SAmhQQzgGx4UQDJ6Hw8n0QgCIgCP9BDkX5rxbMKg/qOByX/SzNL1J+6HS5mNihX
         bz2ie7AVaEv8Amq8K8+MjAqVA67H8+RMZmPmivRoLWJJUu8yuSLBHpb8xXYeD/E+tj7d
         nH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710865019; x=1711469819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6iYq34P9ythTjGIr61RfHVckycRnVyhkTffNVEZI58=;
        b=ZXNAm3zguL/YxQQ21pSvcV02ALHOMOss/AcYQfs8izKhm8NLMnygZP6qsmaW5MeLvx
         yhZCciEmgrq/vuhxzbNMQyW9aRIJeENDeRX5soFJetqZ/ZE43K+GVGTSbjf624HYxC3o
         vxQ5FAhtSN2mbOdGe38BcU6Svp0DLMXKxXxr+wknUBL+eV0gHBFzjr60CvCXWq7ieXLd
         vPVjquuzoqPpImXVsQP93OrfuexoOzksQVDMRvZ9/kwdC4wqOVI2Go8hrIlClWgbySGf
         K2Ax9GCbuH1u/28cV/Edn2XtskhOOqjDVfZ4R1XG9gyLYFXDIZuyVNK86jiem5YmaP6E
         tmLw==
X-Forwarded-Encrypted: i=1; AJvYcCWWMxBoZ+pwvRVm6RygTB1BsM5Vvd2nw6PGrPTldF4c7Be0N+K6kTw4RVqDaPbg31rZoQiR3/ESc6XPKrweYc5vcACq
X-Gm-Message-State: AOJu0YySKOlGhCeM5B3CSWzxyjLBlaGXyDSIYJ4trsL2AQ6zILL0JW8F
	k9lkBPSdJgwg2SGnGf18mz0+T9hx35lne/Q4P27t3oRTKKkiHWOyEux1jObsH4WmTlQhvwVaGIW
	WUM1aehSPyq5z4bAPPQAA4ADOA0E=
X-Google-Smtp-Source: AGHT+IFNC1WrK1r16RG7ZeqBONnXZzUl+0DCOW3snDPt6JhNFq7xnzIFP9uhMCr+7CYC5fGKK3zlmXXIOL2y8oTn5WM=
X-Received: by 2002:a17:902:d54e:b0:1e0:479f:c834 with SMTP id
 z14-20020a170902d54e00b001e0479fc834mr2337526plf.43.1710865019117; Tue, 19
 Mar 2024 09:16:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318184037.3209242-1-andrii@kernel.org> <20240318184037.3209242-5-andrii@kernel.org>
 <2887bbf7ec08942ce15740044860aec9aa9870cd.camel@gmail.com>
In-Reply-To: <2887bbf7ec08942ce15740044860aec9aa9870cd.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 19 Mar 2024 09:16:47 -0700
Message-ID: <CAEf4BzYNCYyeZJSf0YUHf9TG2QwwqoFqgYg-C_bfe2rpHK2dAA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/5] libbpf: add support for BPF cookie for
 raw_tp/tp_btf programs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com, 
	Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 3:41=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2024-03-18 at 11:40 -0700, Andrii Nakryiko wrote:
> > Wire up BPF cookie passing or raw_tp and tp_btf programs, both in
> > low-level and high-level APIs.
> >
> > Acked-by: Stanislav Fomichev <sdf@google.com>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> But I agree with Alexei regarding 'bpf_raw_tp_open' naming,
> 'bpf_raw_tracepoint_open_opts' is probably better.

So I considered `bpf_raw_tracepoint_open_opts()`, but it felt so
verbose that I decided to shorten it to `bpf_raw_tp_open()`, given we
do have SEC("raw_tp") and that's very recognizable contraction.

Having said that, I'm not opposed to going with
bpf_raw_tracepoint_open_opts(), as I don't think many users will ever
need to call it directly, so verboseness doesn't matter all that much.

Let me know if you still prefer the `bpf_raw_tracepoint_open_opts()` varian=
t.
