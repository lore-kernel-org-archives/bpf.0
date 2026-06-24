Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106BC3B893C
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 13:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782309456; cv=pass; b=R/l4JXQ0+UW4ahoQJALibq7YEtzKyt2deqBI51rer4aKoj7prPa/64jXbGdiNriK/9w/nZhkUekZv0efxtdR8r+AUD56q6ppzfiGt0TKwMAov84RQyPs5JsGucCCoinpOL0imvWBlim30WJyMMKxjKSPplnlkkhcTOUUlGGK5+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782309456; c=relaxed/simple;
	bh=uGIoMiwB2AyMib6mxd71XC+AdlwasVD8+0Z4/dxNlcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WLlEe02Zdj8yZ5ZG+NwsZ40SCzD43a7Q+h0qGhbuZkaTSETnRBtHEPzQM4e5U9FevRxG9z+z3Uw5sWSjBMUobVxCmQiXLJ3yxRBovnZNKvYznUV9rJ3I6MILbXpBB3OGeSnV+KeLDnpdjHQDTeUqvPK2pyez6ztsvB40uiz9m6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CSJ6nSw7; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CSJ6nSw7"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-809ee64a490so913577b3.0
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 06:57:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782309454; cv=none;
        d=google.com; s=arc-20240605;
        b=leI16/wyaBnxZoFyyXbSQA4O/xWzIvAzU+ofMiSDPKkkZGohsjMl5tpHx40cMOYGid
         KhQ70PpiGSlKHYyDaoY9JF+Q0QzgSywPJE/L2P5T2zFULgGXzJfRKM+pbezY5VMzW0dS
         JuBJc6UfIa4QB3LI86HqbHXGYMx0DsvZQ8RPnRP2mBtk/498F+yEsy2g+1qFhvQZ5zEs
         aIJmdCp/IxOuZnPd5ApnMvhVnWoDNX6t0Gka13hHaEqgUMO1+HqddOXxTuTwUPxqgB3F
         yijD4KWz2tBOY9gsXrtJqBf2DR1mF0jxY0BmQlmmFI4R//fuTqLk+3mijnZ6rK26hVhn
         5y4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uGIoMiwB2AyMib6mxd71XC+AdlwasVD8+0Z4/dxNlcw=;
        fh=T0Zz0a8T2XSqPlWSyoyzoqZRBnKxZGwcft7+/IZiMns=;
        b=UG4NoGWgS+LSVbq7kuQRsRDGoUxpgbf6XBEWSn3q/w8mR5Y2nnCawoeidu+A6Mh8Sx
         yavyVURoy1x7zCBUHkVxIMy70zQ0TU1sEeTAAZX7lbw7Rw4KPe9mjqrWLagZQYPmBBxE
         eiFGo/JZbl5eDEmyHvOI4V4yPbdH71Gnr2+lnfBAZoG9KVPjzsC2QrOlG/8Ts71YSPqD
         3lNRuNQc9uvWX4g8TxtqOuNEgM3fNOpqO5Ulqxsh9Jo8HdUtlaVYA76nLh8eDMQysEwk
         /CLzMgNXAyeWlViKynzUA21m9y6N+PrDXi95HpAMgbKut2X6FFI5aLrSWS8gunqwPitO
         HDeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782309454; x=1782914254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGIoMiwB2AyMib6mxd71XC+AdlwasVD8+0Z4/dxNlcw=;
        b=CSJ6nSw7okKcLtPLZg7CHIyQ9GwPj26MgSh0cBV7nHw3eavhtpkmDjyKq2OmpO1EDf
         f62uIfzjq9AVP6a0CGultDm21IVNYwpRJqMEzkoEh3YZgeYlYdUT9VnrcUfVfaIbWwxb
         lI9RBCzysCd+teroH+chPTmMV23Xq0jbKj6Ow1A1Lfg/axV3jd/jXglN86iAXXYZWSK2
         O7mubnqsVvh747m5HKRZUm5fxuLPuGKKcptJj4MGiiJ1YEQZqRiDnzWubimHawETaoNj
         I348iLIsQw1Yi/9L163MWrhzD5xgJs0SRo3cnJk26/zuQ2M4VcP144Qk3vVU0NKnXMAp
         NILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782309454; x=1782914254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uGIoMiwB2AyMib6mxd71XC+AdlwasVD8+0Z4/dxNlcw=;
        b=IyQlivqJ0fQWvr4ROOg/X7BWR/PnsENd1g8Ftb9x/eAwELhOtLm11IXuE3m9ug3/4g
         aGJyP1TWNNa9Yl80Z4SYmzfAgfpcuCzIveqCdXaWi3Ha5Cpv8ILKmLI74RyBwevgfnvj
         BCqZg/Wbi6v+VC4N431SxRLwuvjwB8nPHzs1rcA0UHjKVJC065WqBYmby8ln6Pfm16d3
         hj1DMKao9OP4O4aRuPHa9QWNDHIOzjIMwnQ7LMjofD7IX/wOUQ7zmhfuYpfRL9T2I8hm
         jq4l91kKQnA33U2gj50N5ZsBDAszmNf3OfTO7lPFFvI3aJOfbmU9/rtwPxobWoUCqfLj
         DFUw==
X-Forwarded-Encrypted: i=1; AHgh+RpOwi+14KgiTPs4LX3I5xnbqHv2L9EyYXGRDVI5+PlFCmiLEXym/tEyceABGYM1L9dp/WA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkIq8+/Bw2vUcAEWKuS0Xm8aQdkLQvf0D794iYDe264WvFfSJw
	cUj7NJ5iyje77LHtxKvLzyGGQv3w4nUFb4zCepQ2ofzvB/FEpnodNXm2ezmu4KyKHNDqiayJzSm
	TlO1og3D1rPwBasdDVkjAAlqsm4OKuDP7DeqAqpjIycTlp8uqHr+FThnZg0FqQn/7
X-Gm-Gg: AfdE7cmD9GhINO0FRhFg54UpWZeTaq8X6gp7iKVSeil6TCMq9qdL+4K/TIKEkTf+rTi
	U9x+u5kTR5HVqnJYgXwd4oDXSzwu2dPX4VA8uR3qrRccdD8mTibPz88e8LDUmKKAmyK25vcBUOI
	245A6zB28B/tB8uSiSVbzcbYlqmV4ur1SN6bFtXHpdGsuGdAfcljO/Z851j5vxCioJLbCZqV/Ci
	/HKMVk2kMCHLXffnCNVrtZ8JnHvW/SC17URYTYo/NAk6A8B969dxoKROFUX0XoH7X/E0v1bBVSL
	Oqz3+0j/NLUhQM9MFXQ4xbG8Z+M=
X-Received: by 2002:a05:690c:680c:b0:7f2:9d64:991e with SMTP id
 00721157ae682-807f211f18cmr30285457b3.9.1782309453687; Wed, 24 Jun 2026
 06:57:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623-bpf-lskel-fixes-v1-1-90600b40e7cb@google.com> <CAEf4BzYBwi5V0XPMEczdKxjW6N7xT0wZk1Q8cvH6UceyoJP+gQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYBwi5V0XPMEczdKxjW6N7xT0wZk1Q8cvH6UceyoJP+gQ@mail.gmail.com>
From: Sid Nayyar <sidnayyar@google.com>
Date: Wed, 24 Jun 2026 14:57:22 +0100
X-Gm-Features: AVVi8CeeK8hhqdWlixg3QvzAz10RuPIkQgJt-nVtGag48Ox91OrPF8ssvc3njPs
Message-ID: <CA+OvW8Zxcfa2knGB3AvT_nMa=fY-DbKL_JmbfwgkYBOt2oVRLw@mail.gmail.com>
Subject: Re: [PATCH] bpf: allow BPF_LOG_KERNEL from kernel space
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Giuliano Procida <gprocida@google.com>, 
	Matthias Maennich <maennich@google.com>, Tiffany Yang <ynaffit@google.com>, 
	Neill Kapron <nkapron@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 9:50=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> This feels a bit dirty. We already have BPF_LOG_KERNEL which is passed
> through log_level, so wouldn't it be better to just make sure that
> BPF_LOG_KERNEL is not rejected when program is loaded from inside the
> kernel, instead of passing along extra bool everywhere?

I was concerned about userspace loaders exploiting this to spam the
kernel logs, hence decided to implement this way. I guess I can
enforce a privilege check at the syscall boundary points to prevent
that.

I will follow up with that implementation.

Regards,
Siddharth Nayyar
