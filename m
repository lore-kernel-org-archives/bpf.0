Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13191E1E16
	for <bpf@vger.kernel.org>; Sun, 14 Jun 2026 03:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781408819; cv=pass; b=kFwRLBt+KdR/57a9vWBxhbATDqT1DcudhRms+2ruoeKhbl4wRKxNV4c9FwyvtYSwBybc75UY6Y4GPIDIRGFveCeiUstkbg/K+hV7DxR3ARJNAmUrFmQ4Voq8FV35oaT9iJ3fsiX0w7XtJMptsB62PLVV8G3DqqxZ65sAtCAjjFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781408819; c=relaxed/simple;
	bh=eRVFYlLNmeSGg3OY7gKvJQsWIErX/iR++Ro+lG+7u2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ivxudQ5e/9fCsvaPn5vopgZDANQFem7bWLIkVrUrMHS5zKQiCGCaz1j+PUs9rK/dpJt/1qY17gwQXGT0nybUo3kZv+tYIfOiMw9Mp+/uIp2H8hS7LtYCPpHV/K8YE6MNHDsXjHAm1XkCZ/OO+5suNE8OQlcOknoTAe3xlFcmCxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLzKiCBv; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLzKiCBv"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7e86d46b02dso23981607b3.3
        for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 20:46:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781408817; cv=none;
        d=google.com; s=arc-20240605;
        b=F1Qq6T2ZQZk9GrAtIjwImvXatyPGGVmibj5Jzmo3ZsIIooUr3v+XUwxsGxN2jNqy1U
         y51NALED69bBkTX5YLtJi/wKSDjqSaZqWwT1d5azWJwCiM/tsMqnr06HNXOzHxLeylGG
         JS6OpBbiH96RsV2CRri37ZhRwx8j3NKEZ8H0+wGWUGpY8koVALGQ2SZzpeYTT8yi9rcR
         E+N3mWhhOEtzkMLOl9exuk5dV82Fni/+/1s2h9ueolEfV52Qf7RcwdTAZgsUInlweSQQ
         fca44CsCvyqlswoCZQfUgHiTd6NjuLYQs32nvMqbRokff2iTmKKU82G5vPjRdOhAqCgC
         AVPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eRVFYlLNmeSGg3OY7gKvJQsWIErX/iR++Ro+lG+7u2Y=;
        fh=3AUpZzyEvfs6YHNcHbNsSE87L8Yhg/YwYhZF/g/eYdk=;
        b=eolPAZa/ga7SaZyskdav8XbVrmoa33gMdn12XrfaMtErqHeTVI3E2TI+0/i6hmWk6M
         rrwLkcnybj4eplqZJj1OMPgCCtxSX4fm+RjI8EjRPdoX0JTbvTvhebtDw1U6b7wEeYGc
         YVuS5A1Q4OwgCNL673ZGbyX9q2FqZ2vKKTOj1iYwsVAsNqkP+kFblH4mKV5qcHSBaUO7
         sddHWai5C2o6OXVkaAPLiwQmFr768OmYG5MDBFvFR/2NcIGEaqgyRP28mKzi+yZgWgi5
         aEotYiWyM5BHHIeFbaHtXILt+AZhWwHIQQH8GfDLwIlXpanN8NnFR19bkZCWpy/aTEi3
         3b2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781408817; x=1782013617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRVFYlLNmeSGg3OY7gKvJQsWIErX/iR++Ro+lG+7u2Y=;
        b=NLzKiCBvHBcuw4Q5i3phBnygyZxRE1PTbUnT0uRi1oaTxA+DYtMdX5YyX3/UIR5N6N
         qpnhdW6Jy/DGgBqFRqW64IHK2B8BHPgXORkNmthYK82/9+nB2TP01UfVmqx0w82C2tZ6
         LGSstKyCdeo9dbbBzY9InGtBYO+XQqjdyJ6A0gTBvueripynuCUUY018H1O3ReDu3tXi
         QxpHbhbBneOZH6JFcY9kuKYbKUJKulI5EPoqQnTFpSjHRn+bEjAnkdgTKnuuAdJsqsX6
         ieoyv8jMBmIngk+ar3kWqKZ4Q0i0cEmyjo8Jco7anIiObAzl8itFZSXrSfZ9JSV2CWir
         1oVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781408817; x=1782013617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eRVFYlLNmeSGg3OY7gKvJQsWIErX/iR++Ro+lG+7u2Y=;
        b=N4Jukx3MBKQ/CZuj9FXTh+t9DnGXALJohqthsf9ZbpwfvDaHbD8KZMcUd3axWEUzxy
         4K0fNG0s0eOZ4e/MG6bGm0Uta0B46TkMl+jPpXuhWsM4dVGnVBFnkUpXeRAWilaytSTT
         mrGal2ynyJ5UsslOu6L1dMOuHTFaDsiWo8ukmheaoYH/TSecw25ojCvivBYcyDpiZWAr
         NlgksJLHDSLGSqf8raO8qHTcCw/LD5fr4MWm512ZBeYQvbD8maXwG/eBZSi6vkN50/+I
         JIczlZWJHwv79gYPBqHey3yHV3ignEbOUyQKcqBzzNKsItF9iM1LeCZ+3hkvesi+bztm
         KMVQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ypLU8dpjW9PhQMGzNaXLgMOat2mu/CiQpf6VqrHHuk3s3xeYVgvxqzUpssf8VgbAh00k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+arRTMt450sG9l8N2Q3a/0FCm6wQ11h5xiJvMw5senPkMkKVS
	H9ucn9cNM9VMlOfrY6dtG+VN2uQRpi3oIyToQzpYC0cf3SHWuZI7s8lpCRRGGd9ZWZV7DfUlWla
	gTSMqo6RUF0IbT8iM1sQ3y/eKFOwoPMw=
X-Gm-Gg: Acq92OELplo4uveCQJlodMT8eGuRlL2oajTtid29lnf9Xex7I82pHnBZ7NBic5CxeY1
	rGnBVCbhjHkSoFLlyRSLRCCPyCYygJpeZPu/br/JHX8DD+/vnvf8gsu0jvlJx0+/rOa0NbXNZN+
	RJvOa7CR4ah4RvBDfmK+6MOMoxoZOAVRVvhHId91neSumlkknrXdtjHQK5ScWdkol4L4/2ah9Yy
	s7f0Y8F+GugQIdf6cCeLmEbbE3ASjCUQI8Asyz1GI0juGl0EJ9tpqfqspTu+0eq0ZEuw6INSvOL
	6AIpnE0wXgaNq8CMIsZziKIffcZLgZUMWxHBqEcQ/2d3A7ktZoW+XSaCzg6cUQ==
X-Received: by 2002:a05:690c:6c93:b0:7bd:9ce7:164c with SMTP id
 00721157ae682-7f8c3fdd5bemr51633187b3.43.1781408816861; Sat, 13 Jun 2026
 20:46:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612114032.244616-1-sun.jian.kdev@gmail.com>
 <20260612114032.244616-2-sun.jian.kdev@gmail.com> <20260613102549.0061a875@kernel.org>
 <CAADnVQJyOR0hppTmhbTRS8Sp5ci-L0fmQ6V+R9eiJDop_95rVA@mail.gmail.com> <20260613130343.3984878b@kernel.org>
In-Reply-To: <20260613130343.3984878b@kernel.org>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Sun, 14 Jun 2026 11:46:44 +0800
X-Gm-Features: AVVi8CeuSoLbqKZ8hO8Mj4s69jiQxW-2c__whedvojWfFSqVia9mVfTsO1WPvBM
Message-ID: <CABFUUZFG5fybb=2A_2x-aa0Y2zvHn86sTV-ZBoLSzxLw0VLvGA@mail.gmail.com>
Subject: Re: [PATCH bpf v5 1/2] bpf: Run generic devmap egress prog on private skb
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, "David S. Miller" <davem@davemloft.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Menglong Dong <menglong.dong@linux.dev>, Emil Tsalapatis <emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 14, 2026 at 4:03=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 13 Jun 2026 10:53:35 -0700 Alexei Starovoitov wrote:
> > On Sat, Jun 13, 2026 at 10:25=E2=80=AFAM Jakub Kicinski <kuba@kernel.or=
g> wrote:
> > >
> > > On Fri, 12 Jun 2026 19:40:31 +0800 Sun Jian wrote:
> > > > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > >
> > > I did not suggest this
> >
> > ohh. I didn't follow discussion closely.
> > Do you want me to revert the whole set or just remove that line?
>
> It's alright, I was just being grumpy.
>
> Maybe we can amend Chris's prompts to catch these?
> Noobs tend to add Suggested-by for people who simply commented
> on patches.

Hi Jakub, Alexei,

Sorry about that. I had meant to drop that Suggested-by tag before
sending v5, but missed it.

No action needed from my side.

Thanks,
Sun Jian
