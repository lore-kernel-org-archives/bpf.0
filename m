Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3608E80618
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 16:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710865668; cv=none; b=B4EFdeyCm5DcxY/itvt8oLJVcqdzHLKZ2GHPqQfhkpwt5MWLD0ItCtlVmt9sQiruIxZ4vpjR4bF9/t6ApBJ6FP829uaSzeTFSKk3sgVz/f3JMJd54gaTQ7B4M0b7tGjUe4Vy3f9RlxVyY5fSh0gklWO1ABw2goKegAkJQCpfLPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710865668; c=relaxed/simple;
	bh=UqNwzFoSq6UZJjpvFkIB/qIGoIufHVbA72OTWkOllxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JSkp7l+lQol+c7R0UPQuHhlZ7H9ikb2JowPEUQflUBGPB+pYSG1NiR0ED0+qlbAd4lF5Bm5hLsopCcifFfFnao8k8fYSjr35csz6MkJnqCBjSGQ33Z3ieuXxMXXfnYTRXha5muhTeW0sx5ZWPva9VZq3mJFtK1coyIzaNgCugzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4U9ett6; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4U9ett6"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e036b76725so15364835ad.1
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 09:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710865666; x=1711470466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UqNwzFoSq6UZJjpvFkIB/qIGoIufHVbA72OTWkOllxQ=;
        b=E4U9ett635kFq7zNjV13rjdtF8pdS9E0AWap7az5tEjRrG/F7SpD8uhpc7jDgA0wOR
         4IUJkbC5kyf04jgTg5fVaIS8+6plrUgCeUgbQaX47ewrXB56QA5v1+7P8hG5g/FSYEXs
         GTZkT/0oG2RLG9/H5FXLjTaiTSDQGKNtLeObyTha3v0xafN6SMHF+gyFt1uB1Ypu56bw
         P1DPWXCEaXVP1nVHgB4diFPSac7q/L20Cwl7koNaT6VDPSOWb1M4IQKFyMJ3E6CGTV6w
         U6+CUQ12vWxONAvwk5Qlql5CKLhmLcxOmEm94HxEHTDqmJ6Z3pN7vQfGqakSJ7NvyXpJ
         Oqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710865666; x=1711470466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UqNwzFoSq6UZJjpvFkIB/qIGoIufHVbA72OTWkOllxQ=;
        b=cJEuWZBWYuG9K96B6Q4KoUyBlv0EFD5LQiT5tzloy6GFe9KlL2b2sLo6uxyxcnyovE
         aBJ6uK8d8+KsYmsJV2qi0+JlhIiUU4aMwlC8SY/RaQJsC7YrxG2jL4oNg2cpXqJEukzB
         M/6ywhDhnq/QGZFTr4C0Vq3ALYza8AVQIbDqtCZrAyfUSMMyHi801F58CWhclPVV3fwd
         z+jd5WVv+L+hPEStPdtg/bUIBxFEIwx038g3EPLCEPgLV93A0VraOnjaOl7aYLwSR2vX
         kfkbQOx4LwI9Rb1rwWZhqsYAj9cMbUNv39S4twfjmjcSNndvP19ek7iIkEW0DAh7PQrQ
         6YaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUEXRf2p8zK8ZmpZS7JPyqRuirC2nPxT+X96Q9CgORy1prARHy1MK1O6cFxvhIJ/EupGR/HqYKBrOCp4qcaOEf31rL
X-Gm-Message-State: AOJu0Yzt4xd4fF/ceskfkP7ixFGAV9fJDujM5RhKE7khCQ7FJpRPARcd
	zNvkRhxJ1K/OCb7g9WvmGKb3BgE7kMFz/Hq1OFaNbZ3uIBWeJdnBOx2q8BbcXmA52u+KTrJBb+N
	eEP5X+nG0vnPz0nydj6kPS/lptpI=
X-Google-Smtp-Source: AGHT+IHfVUYpqNoRC9B1cH9osDCjozcYxVaO6bFVK4lW/hBJ7mg8k0GrZ3LI14uYNAV7MqZkvKk9nfd5+aOxNIJKNDE=
X-Received: by 2002:a17:902:6e09:b0:1dc:adad:f54b with SMTP id
 u9-20020a1709026e0900b001dcadadf54bmr2754442plk.44.1710865666439; Tue, 19 Mar
 2024 09:27:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318184037.3209242-1-andrii@kernel.org> <20240318184037.3209242-5-andrii@kernel.org>
 <2887bbf7ec08942ce15740044860aec9aa9870cd.camel@gmail.com>
 <CAEf4BzYNCYyeZJSf0YUHf9TG2QwwqoFqgYg-C_bfe2rpHK2dAA@mail.gmail.com> <6a904a7257998dd5576ee18f46c204c426f10cee.camel@gmail.com>
In-Reply-To: <6a904a7257998dd5576ee18f46c204c426f10cee.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 19 Mar 2024 09:27:34 -0700
Message-ID: <CAEf4BzYmAVbtp1u0MY5aHQ0opd1of5P39Bey_EUABqgK2boUdw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/5] libbpf: add support for BPF cookie for
 raw_tp/tp_btf programs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com, 
	Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 9:24=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2024-03-19 at 09:16 -0700, Andrii Nakryiko wrote:
> [...]
>
> > So I considered `bpf_raw_tracepoint_open_opts()`, but it felt so
> > verbose that I decided to shorten it to `bpf_raw_tp_open()`, given we
> > do have SEC("raw_tp") and that's very recognizable contraction.
> >
> > Having said that, I'm not opposed to going with
> > bpf_raw_tracepoint_open_opts(), as I don't think many users will ever
> > need to call it directly, so verboseness doesn't matter all that much.
> >
> > Let me know if you still prefer the `bpf_raw_tracepoint_open_opts()` va=
riant.
>
> I'd prefer the longer variant if you don't mind.
> I'm a relative beginner to libbpf internals and seeing bpf_raw_tp_open
> instead bpf_raw_tracepoint_open_opts kinda broke my intuitive
> expectations based on other APIs, so we can use it as a test :)

Ok, sounds good. You can see I didn't deviate in high-level API
(bpf_program__attach_raw_tracepoint_opts()), even though this
verboseness is breaking my heart, because that's way more
user-visible. But I guess it's not worth it, I'll post v3 with
bpf_raw_tracepoint_open_opts() then.
