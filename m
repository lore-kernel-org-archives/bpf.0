Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FB742314C
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 17:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780594090; cv=pass; b=D5nvp+SyJYAdrWM/yNHyqaRTbU2k6ghN1ylR3+rJu82zF0fsGZXO9ocRCiCFuIjYZBf3E/CFgxePjYLn6XoWJv+0u7nOk3nGzBPesiPFgNcRlTorYR8cSHZEiHc4Y8wcYKH3+QekGCQ7zdGvyZLACZsIlAfB5D+o2CXMsDtv19c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780594090; c=relaxed/simple;
	bh=m1L2TvtgAAnS+V1WcP9D+Xsmvaep525L7WjpOyp9fA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XYAY5dfubHzy4lXj9bI6QnNbRmg2qi4gmvW+7YK5/9U6ZrIktgst9aZtMzm6N2ebBEefH1AIiIp01UxPzelS3uTHjsmyLwZMoAE2LvsOeXZX8YmvKH54MfOxTfP3GpAK0VmTb9SOjnNw1niTPcBt9kOsRiT79HN9u+UEfUaXmeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qerc3kNx; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qerc3kNx"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45eedc94d37so537004f8f.3
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 10:28:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780594086; cv=none;
        d=google.com; s=arc-20240605;
        b=hhUYByGaUUyVQGgonQcLvJS4gc62NO8BJVsL6vvMAAAEH9rxoXYqq1ImcNyO81coa4
         jrkFtaxMUKE+1grq/BP+Hn/UDPABDKbdtWEcrDk2Odzi/9NjhJWVVJJu3bGqIgYRo1vk
         R2oHe6Jq+tmYGKAzEhUZT7GEKTkEUiQcyUnpcYcuI2LfI67MDIKktgcBZo5WPo62Nl29
         IUUMYctBjYsY/tEPTrZFjJ2/a8HZfjUcx/CeduP4eJ/COzNA7G3deaxj7Se4NmwnnjtO
         QFn9RdD/J/6d+LUSvSowgR7HLpYD1OqtzD43EgNqPN1873LYPtWVlMiZSW1KS5x1cpui
         pfrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C3bk3niJK7w5wDH9w15RhlRYMDrZTOP/BdDoOyLE63k=;
        fh=kK+8Yl76qNzlrnSDUMZ8UelHYxd3JpfbpTXl/HeyFwY=;
        b=WrbZVB/YbDHzOcRdVQj25X/mC9chZc2SCfulaz8CCUoBi5NcHzsAxosxf1UvyvWjU5
         DWuXPO1lBmbuBsutUqDWZzUqItxZYPyVJ1/MUaWXvzdNIFjcZEvi0pMFTmmDxejFai/e
         bnwXboHTVpnrBpB6XMwrSRsdYhqwFcGi4IOA4IL/VnE26CayTdCz2M9u4HVvURDZfNL2
         qAKvAt+pEnWy4e2BhgATkmK+abJTj3j0+H63gdgBmpFfkEl1M8A4uzTHXEr26PlAQIVq
         FdEWlnFjX8imJW5m6g6jEYDMEm0WAw9i6eG2M+AEaEwqQ11hhgAUiVB0T8rn2WR119M7
         xJvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780594086; x=1781198886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3bk3niJK7w5wDH9w15RhlRYMDrZTOP/BdDoOyLE63k=;
        b=Qerc3kNxq9xLgHZj0QI/1khDoSDAWQPfYwQOibaZwweVthkcMoDwnCABr+7tm/Yk60
         PqODnbk5lSSOs1wk5HcQpkvC0tVesYYkyZKYPasmWYUTTMW0E/qLmUeK95dZdl96CaeW
         c2ncnbAc9ElGWT+hDPCBlg1eOygzKnZntNK+jq7CeUlWvZL1y+T1/A7LZQAqx3eiNMwt
         wp4Vt0sGEiNRaqnm1kLHo7q9wrU9BsBwOFE03G0Oax5ZPWMj2vBIT3enTzljT0wkeJ5d
         rUFdWvDIwlgaja8YyR9d/StxQTVTC5tAfzGRx42p83909/j4M9kxtUpPnujkl5mkee7+
         uTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780594086; x=1781198886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C3bk3niJK7w5wDH9w15RhlRYMDrZTOP/BdDoOyLE63k=;
        b=KhYSpYNVuYFIpBXALFrtE6WDFPEdbn0Vp+/l71oK1o+zVmXt8kRDug1G07X2OgLc83
         pxk4qRxgFqYZn/qgEVRy+CgOQeWnlEfKK1O/QkKiCxFZ026hZaUVix+yJHklTR4Q3zOK
         romGCf1ix6IPmR+2o0HQuSiT7palvM5E3DMxruy+UhFY3XW5shZXs91nRxlFpEvcyfhF
         4PCZPPJ23n7QdX2rQLKx1m5tazfHtjQwsWv3DqHaMdP7+ciy4sjicA/UXrxWuApaJHsw
         nbO7rzijs2KRVoCZW3RhngIeyYSbXtSVOhmf/Wi88BAEY5zumalHEMlQMw3hV/4GCkho
         zTog==
X-Gm-Message-State: AOJu0Yz+Aa8pnPXDfGhBGJ3pMUDLUwgjMxt0neKpmyZ7HkE9jA4qvyMH
	TRwaSum18KmebL/1aBwjgBNWwaMQys34bfGcLq3sxRjaC2ZTReuWMt0ZnhtVngN8dogDYoCfhRL
	KSzRAOkfdScGx00GmsiqFY7ACj40WlmE=
X-Gm-Gg: Acq92OGsCDvgShgHyjrYlQbrkT6hWgVIuFZlsJSf4CluW6QobQfDZiMsd7yaDNPBtMT
	GZJYtnvoX5xffj5yOmLQ8XA3UoK3bAm1GtWm7CeoVkqnhvtllmG3M/N+CBl6jKjior4JOk8OTPE
	Axp3sfZ8OCoICNLy1vj3mFIFjbhNLEd1/nkWArCE5jCk0JiZ5TXMk1SLSHhEtqEy2RFj+Kq8wWa
	QMMw9Z4/sTk+rqbBbc00/tZLFnXE7s7yLCcKlh+Tj3+JvfYqvpv35cp7QcH/NBjkJrhrnV/9lTB
	yRj0F64ITCNM/eSV8B3iQ+dcASR8b7URoX43actX2CkjoHX41GmvFAD8qxwRkwSZ8e4XZUmVyiJ
	dJinHZIsCuP8LXSNpig/24KDs2/mLcv3lnQ==
X-Received: by 2002:a05:6000:181a:b0:45d:817c:b8b2 with SMTP id
 ffacd0b85a97d-4603065b5f2mr32414f8f.30.1780594086199; Thu, 04 Jun 2026
 10:28:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603182727.3922-1-emil@etsalapatis.com> <CAADnVQLCk1gVt6XOcZnuvsULx+R+T0DaJBQ7-sYHFSaEKPW=ZQ@mail.gmail.com>
 <DJ0FG1XDA4ZU.3MA6IY4M6LA51@etsalapatis.com>
In-Reply-To: <DJ0FG1XDA4ZU.3MA6IY4M6LA51@etsalapatis.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 4 Jun 2026 10:27:55 -0700
X-Gm-Features: AVVi8CdUdk6z5bzQEubI34Z2biCN_VVprv1Vsl7ENKk8QO_FUGX-HwJ3xPA0Y6g
Message-ID: <CAADnVQKA5Fj-OTqJUP5qpBKuk1Gvp_L78ZH8uh9ed2G5qv4Ffg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/3] selftests/bpf: libarena: Add initial data structures
To: Emil Tsalapatis <emil@etsalapatis.com>, Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 10:05=E2=80=AFAM Emil Tsalapatis <emil@etsalapatis.c=
om> wrote:
>
> On Thu Jun 4, 2026 at 12:51 PM EDT, Alexei Starovoitov wrote:
> > On Wed, Jun 3, 2026 at 11:27=E2=80=AFAM Emil Tsalapatis <emil@etsalapat=
is.com> wrote:
> >>
> >> Add two new data structures to libarena. These data structures initial=
ly
> >> resided in the sched-ext repo (https://github.com/sched-ext/scx) and
> >> have been adapted to the internal libarena build system. The data
> >> structures are:
> >>
> >> - Red black tree: Fundamental tree data structure that can also serve
> >>   as a base for more domain-specific data structures.
> >>
> >> - Lev-Chase deque: Queue data structure that allows efficient work
> >>   stealing, useful in scheduling scenarios.
> >>
> >> The data structures are accompanied by selftests that are automaticall=
y
> >> discovered by the existing libarena test_progs selftest and incorporat=
ed
> >> in the CI.
> >
> > bpf CI says libarena tests are failing.
>
> Looking into it, the issue is not manifesting with LLVM 22 so trying to
> see why. In the CI, the compiler is generating code that is doing
> the address space translation then still dereferencing the scalar
> instead of the PTR_TO_ARENA like so:
>
> r0 =3D (scalar)
> r1 =3D addr_space_cast(r0, 0, 1)
> r2 =3D *(r0 + 16)
>
> In my opinion if it's not a programming error we should prevent this
> kind of code sequence from happening.

That sounds like a llvm bug.
Pls craft a small reproducer and pass it to Yonghong.
