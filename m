Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6FE3A9DB2
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 16:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060719; cv=pass; b=hccmxb8H7P3seRaurLa+MOgKQUl4LWuPA37oPRXZ9t1GLRHO+cBA0UK369aQJSl+/InYY9T+ifqGgpW6YQ9eW8h6/hSzYC5qz5vxMcG5qHkX4eGoScwQwrgG95X48/LruWKphKw1NqjyYX4k3738Pr7z2u3c3zzmmLZLdrezfgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060719; c=relaxed/simple;
	bh=2SB5GTo4Zggtv8jaq60i7uEuYoXPHDlZQ+kv8eHrM4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BRAnae45vkTHeUlNJVDCF72NQag5+6y01FS72tzWVd5NMpV/Gb+2ZX+xL05grhW2A6bx2Um9FPlC6nDcrQxdy6Mpc906pWTGRS+g4vwgbFIZJ+8iyCoDMeZKA9AeZJ5Gnk7CXUs5i9dkdNnaMQVh2VKfWdJa3vI70cwlaNC0QC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWUdhato; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWUdhato"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-486fba7ce4cso71754895e9.3
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 09:25:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775060715; cv=none;
        d=google.com; s=arc-20240605;
        b=Ay47fmiFuqcJwrcaW5sUcmbB/HM1oLDRwYlk4y09XXyAwAmUIU9+swclgU1RSz4txL
         wOL8mYq/5/sAbiyO7aqSkNGXM1nt2Ycp/3sOXc15tnUDQK4a3/y+ES0h8ifGMbp6ndqh
         mkz+kjxx0yDBgESXvlrGl4vMQpAxH1OlyrgFhk7wb3jVuRXYz19Txdc94vDqs8jEQmr8
         cac22IDhMR8+AZVEPpGC14QKAE0RMiMcGibnZp83iMmeLNVJ6gLrJAGWCruzeRpExZd3
         qOHtrctE0MoAzzIOnhzxx/7eHMJzwivOaJshz2EPdEvKkBBUQJ+y16yL018vp1bbATTG
         6CnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2SB5GTo4Zggtv8jaq60i7uEuYoXPHDlZQ+kv8eHrM4k=;
        fh=F49admYEmRlIS1ke38UDBFOEwZNK6v5qVKnMukXc4MM=;
        b=YntguqEpATRKU7A/VUqrykZhMuoo9ojx9dMRJgYJhGLu4hjrhlK7I913a47DgwCFbj
         8JGP/g/ZF77dbDhTcZvUvvwcnFLPGgCBaDrI1oqJ9VxLdxWlbeNHlmR+eNZLHt20RUuC
         iINSA87T2H1ZLOb0B6getKPnZsKZg9lccmI4BBwwFKILv0hzTa+cS6H9nsUqsXmxPwj0
         l1cEoxw60+iAXyxifS0Uc5X4T7BlIXDODp7In7IdpdN59V/D8yXoqEcMzTSzIjONf1Xz
         gsp8+XkZQ+4rQGoa3TZ1H8YSaC5c8YEAgOPoNUI7QWs9E/mnzp7ugVggHFH5onE3gweR
         bzlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775060715; x=1775665515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2SB5GTo4Zggtv8jaq60i7uEuYoXPHDlZQ+kv8eHrM4k=;
        b=NWUdhatojETtdn7tG92T/Q4gxnvbvX/hIt07AAHUVh5viklhAzip4uV1CdyVasxPES
         m437HJTcY9SrAH/dmCFhk1yQrXM7xyi83po5EQnXdiiquW8AsJ5cQ/AsmGNEMM7iiN6f
         BeHO1FByYpZapXKxM2KdFwiPaJB7oTQnHbKFnSwU7NK699EpK7IMHXTR6qSZlG3nKN5M
         BrW1bfxcfvYPEzNPhZlXcel3PhEOAPvBFVJor41TMZsE1Hhg017QoNKw92Qr1FHP3YCu
         XthwySICMQw/LRxTepmj0n6fQg+0WaS00wM79ntgojzTCicijfQ4YsHSaOdc+viHEBbf
         MXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060715; x=1775665515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2SB5GTo4Zggtv8jaq60i7uEuYoXPHDlZQ+kv8eHrM4k=;
        b=nGpWqmIrF3xKOuZq14qYev8v1b+UcP+BkOZIc5eBQ5S02u1fyKqnNWXoV0cbojdgtm
         W2sPxFuFFYmLCYAlhHUIBWc93x4jTqZamdSE3L5Z4O8DEsz6DkxUMqmzs9JyMg8D90ds
         x5ido1fk+mtys2sY2mzbRhtDBgzfP3hMZsVJxO2atphCprvnUYwSC0Zv1NHipHHDMdip
         pXaq8EekRiYvL1cXOA0crYabEVemeLiFfZSL8bBEF1ucPDxBF9o3lKLvhxzbM47jI798
         4kg07u4cLSSArTmkuFI8kgELdEqpc4g4z9Zgzu+9AeMut33LzDdy5S9VYWvkilnsrIxf
         BxnQ==
X-Gm-Message-State: AOJu0YwTkaN5Y2hV/YDsD3k/NOdKz8JMQ+CIVgQF/qTnjkYe5Ea1QnnZ
	sznRYcOVmdRsnqGUwkkCl54wbC3HU/jWYGU09j+heZOzHJhx8VE4iMr+NP8GMXu0uZ6V2nybpyR
	j6of9Pc/5Ihhzhiq2Kogn6hynWaaGYUk=
X-Gm-Gg: ATEYQzzI49ppw0Ik/9q3gAbRGwx++3SHsn6LGOdMJg2YlrNVf7+QFK5PzcrgSj47X+q
	Q0sQ0GN2dX0748GcnlT1/fjYOUsOEafZC197y4kYeMixqckuoxKqlMIp8WvX9oOlZS2AGTF6cwA
	8nYWO5idgLKYmpP4BWtcejluyiLyUrtESfMohvnC5Ygv/PnIk2YuRS80NqIwbUozzTbucdTSnzh
	dcV502dfVxS/QdsJeMuokTQ2RhYO1T+2NwLMYkHC9MSiiq9fa858AvK8cnziFaR2Bs1TgDPCr5U
	8xbZjPf1Ng+Zl0Fi/y0RbwMiSHELQ+i45wE7R0a/CaPpf6aS5fPDHJ85eM5T5lWsSjnVniRnd+5
	cATVtRroax1ydfbJCi2i4UylD0M+zcCe5sLJH
X-Received: by 2002:a05:600c:630f:b0:487:288:1198 with SMTP id
 5b1f17b1804b1-4888359da58mr62500725e9.22.1775060715299; Wed, 01 Apr 2026
 09:25:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401021635.34636-1-alexei.starovoitov@gmail.com>
 <20260401021635.34636-2-alexei.starovoitov@gmail.com> <4f283d2c-dc06-4598-bb21-d4d2491a7fff@gmail.com>
In-Reply-To: <4f283d2c-dc06-4598-bb21-d4d2491a7fff@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 1 Apr 2026 09:25:02 -0700
X-Gm-Features: AQROBzAJS341ZvKqRiwTtEsTpjJGo_p2rGCkJseZd1si_zkzhesN5-_h56zrWPk
Message-ID: <CAADnVQJWNfLFk58-jOZ5R+We1Kw-kEk5g+Q5PufsX=nBsqxPLg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/6] bpf: Do register range validation early
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eduard <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 8:56=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 4/1/26 3:16 AM, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Instead of checking src/dst range multiple times during
> > the main verifier pass do them once.
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> resolve_pseudo_ldimm64() runs earlier into verification, so it makes
> sense to move this basic check there and remove from other places. Looks
> good, other than issue that AI found.

btw as a next step I'll move all of the insn validation out of
the main pass. We're wasting cycles revalidating the same insn
multiple times.
