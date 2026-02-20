Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51781366553
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 17:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771609527; cv=pass; b=SZsRx5Tl+wQG2GWU9iWnRJwVj5ixbEA08LzQpafbD/0+6FVCGjS991RJZHUFJziZ9ooOKv5n4Bb+mb9XbrKbqWL4L40B7GH2ws1EoVcHQvoxB1evPjud/YX6cwIApEjvUODLCToCITrlkPIZ6JFm48iE/nnMkdrjuUrqhC17CR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771609527; c=relaxed/simple;
	bh=17osSV2Ybp3FZazgMVnr6OXGlcJHiy1r4+ZefyUIG3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EGc0w6fhPdm2G1MRgPPrMILy+z92wpzdfo70nN/nNqJXLC7Ue8qMX3CbANkciw4PJ5vR0JBopqJ7zFeCsjj047yShMIEDTROVp4LM8siXZkngU74Q9OiILVw62Jnp55FOYr7FEbe1D0TVQoz3NEIKpGUlZUKtf3kCLLPpI6JoE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6nvK8fu; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6nvK8fu"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4806bf39419so24776715e9.1
        for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 09:45:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771609522; cv=none;
        d=google.com; s=arc-20240605;
        b=IT6SCCIdz3LlaHkSH/Di1NHifqTyGGlcetmL+2BD75DQvWT2egrXWonz8kQrmc5zCr
         hmpjSTzNBamudRJNvi89Sus+D3zBD1X6E7K6kh3/Cl/hCBcgsqVh2IqP+/JALwgFqdii
         QwnuP5TAikRSVBDtufMklejxRgRye26WNJ/uj5wrdlVDGJmshbjUVH5XaympTZJ3/961
         PVzm4HulkOZxHDsr+W+xv4DfNWrgWEhuUPJi4Uz3oAW/rlxtqlHnSo2T73m8vDAC8+eb
         PiEMG5AwVM4OO7EUzagZMiFX5+4//93SNU6+dbDvNFvTItECH2ZC11uF/uK1spE4j6ei
         aabw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=17osSV2Ybp3FZazgMVnr6OXGlcJHiy1r4+ZefyUIG3Q=;
        fh=lms3VlM6RfOB6YFFN9hPmbbDFssyVozN1PBWMqJfJVs=;
        b=TUfCFat7UwW3zvSdvZsvJJ8YecP6Oj+IuHotn06guznDctVum5PHtIeLpyeaDCvmfD
         /XuP1lglOmnxxLNfXV6qUp/0IxLqJbRHihn0A/nbB+EX0aTI/Ba3bYVojq887ACPKj13
         MpTd+tq4NwIdnfkONWCKoVNHojUTYDy3WlOOC43toOq3ryMjF7+z5aYqkYGrC+Us3uFN
         LpL3fzY/i+2IP80OFdJzeVACDuEUf6jUGtZorb9Ql80j16tgqw71dbd4boXrL9Sw6tFB
         R9WZ9oFWFB8MNABQC4QbRWqIsu3OTqT9I+gpotHBP62TIVPxADzJvPpY58ROLKkpfbcb
         Xu9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771609522; x=1772214322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17osSV2Ybp3FZazgMVnr6OXGlcJHiy1r4+ZefyUIG3Q=;
        b=U6nvK8fuOXr+e4cG1Xbi8KhfCZ3M7j2xPDmC3U5S8p7bY/cwmWwKjxBk+OMDzU2G0j
         zGQ8/hIVjhCLqdXTY/Vs9cPTc5F0OfM1Rh6tRBVN4T3d7J1dx9KjASXMPGoKiTapZsyz
         Ygrx2UNpL6TG5nrV+wmaLzHn6y4fUHcaKzPuTetXE29UrMAZ4KTtk4Li0Yekvibog/Ty
         rWwggbdZPyGXmLpcp1yvg1kMF36NszQb3VidzYx92qVg7h2RXPu1jrV0YFBPSsoDcSXi
         Jv18kQt9mJ+fJFHXT0qhl718d2r3Z90wXZmfpqzwqeM6n1l+Bg2bWfhWw3dwrrQUh5QY
         HtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771609522; x=1772214322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=17osSV2Ybp3FZazgMVnr6OXGlcJHiy1r4+ZefyUIG3Q=;
        b=T1Jp6Y59vZz7umbs1DTAJZYU9myVuFv5E6AlUNvss037d7AldRMq58vtb5PyZUw20U
         RO+NkEv1sXUwanp2XkEruBlOoMPKrfZu3RbX1Gu6aCtyWWUV2QvDZWBn0aaEBoqcvIiz
         E0581igGnP5msVJQRxAfdeZHOf705ZP0IoXswEmEYaQzQjg2H6RSjn54DPQ1OWEKjTfD
         OGVsK+li3AhGkMylfSdaPvCn4bPNB61q0F8flwbpm+/Lc3OkG1Rq7YF08xm/OyaQrm9u
         bY96Jn3X1hQb5I1xgHEgoPS6UXn9L8ebbYIcU1N4xazAWr24FZEz13IoaLmC3xmhiRq6
         BMTQ==
X-Forwarded-Encrypted: i=1; AJvYcCW44zT+a5apSWfPK3PQcwDxu/0so7j+gaxbX58oHUeDjDre5tL4UZ2Z4D7qPy5kb7O1o7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPGxkrgBiK5TGMmivEKBE3tNMWyDwMkU16akwmnajsbIJ7lJPC
	23KS1rFEjpuSbiaXzCSpxFlQYVocO0xjBuOVBj0b8dSyhjHqJDlzQNZxCsooSJJk9vujbPdZ44K
	C47UGxIfSLTE5qJCWf6T4U+y0fDHRpfs=
X-Gm-Gg: AZuq6aK8gNppOYk43zvT3e1WPJdroywcx51NJ+pG0EPjDbXuWd6xx9LZPLn7LRL4kQb
	s37RaYZVMKpFzYCZxnjDG32Y1sExbDyVUR8XqP1A4VSFrhYrJkD40Wgn++GvMaex7nX2fomfiAx
	+bAYq64V2PUDfSZmpxdOdj2CBOdAnWRXY8PJ9soB06PxF+TIJqlwllLQ04iaUmbB7bgJuJqC/QE
	cI+0LbralPoM6HIsGHC1QhZ/+5akNQqHc/Z7uDnp0RPD5UcaeoMzMI9gqkc/HAf4HAq/mK5ymVZ
	nNHv/E+QwbnYZD1wVNejMgLlej/QAhsXvwajl/Vai7SK4Ij7Cvo4Ag8vOA3GIsM3ZPiQgNKStAG
	Ra1fLaFYvzTZkeWNc7d0i4y5vbA==
X-Received: by 2002:a05:600c:3b22:b0:477:9a61:fd06 with SMTP id
 5b1f17b1804b1-4839fe97501mr102528005e9.8.1771609522273; Fri, 20 Feb 2026
 09:45:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1771327059.git.asml.silence@gmail.com> <7cc147a959ac068c55dae4f540e38e9e4ab121e0.1771327059.git.asml.silence@gmail.com>
 <CAADnVQK0RaOA9ZYZdYyQxOzLde9MR8HpMM0SexcW59A9u7X2Jw@mail.gmail.com> <84e2f3ad-28f0-4e9a-804f-2647cba9b30f@gmail.com>
In-Reply-To: <84e2f3ad-28f0-4e9a-804f-2647cba9b30f@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 20 Feb 2026 09:45:11 -0800
X-Gm-Features: AaiRm52OfKCQJR5H9mRJjJZx21uNukzF7RXIa2wgJFPVKsoGW-XQ7s--_qWO_YI
Message-ID: <CAADnVQLSEoZ0V1m5j3ggX0o0gzVKyiDHL=J6F0wRXB8qk-MCGA@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] selftests/io_uring: add a bpf io_uring selftest
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring <io-uring@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 3:41=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> I had such examples, but selftests is not the best place for that.
> It can use abstractions, and I want to make them reusable instead
> of people copy-pasting from selftests.

Sure, but please still post them as extra patches so it's easier
to see what's the end result.

Also please reply to that thread:
https://lore.kernel.org/bpf/CALTww28QMg=3DYXqKWpWLZrLO+xiqOe3LGyput8dx68-dn=
Qsxg=3Dg@mail.gmail.com/

It's not clear to me whether your io_uring+bpf setup will work
for Xiao's use case.
I don't think we need 2 ways of doing it.
In networking bpf is hooked at xdp, tc, socket levels,
but those are different abstractions.
