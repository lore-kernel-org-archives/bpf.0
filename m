Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D675E35A393
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 17:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777137715; cv=none; b=BZHlyNfkqQYvGbL0vGbdnly/4JMEYytpvM23drL5/gYdGQHKQ6JBmMtpS0m9VEoENvCeBopzGIorGAF+jzyWSf1UadVPjSp+Hnp1q4hYkt5QaDduHAZA+fyX0iVT20IIFZQz8MhK22jJhh/Hzkatpi/w2KEUGRepWVPzV10axLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777137715; c=relaxed/simple;
	bh=Tt2GTafJyrtQGNKbZrn0loJdG1oXtTGJV/1+jzNUpG0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WrLt4qDP+hsZV8Cb98Ot68oM5BNTVDv8+3AZPUAwpZmyBaQDXLWo6LIVP+X868PIAxj8IPx1/bJ47uHJE/mZRxOgWsDTKgm8wv6/xRfucnHRNNufPfA5XXrOEuFIuJxb6Qd4AVg6c0eLMHL6l4Sm7YohQhBIRpe0cuk2mc7Qo9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fivTLnEP; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fivTLnEP"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3614826eca4so7961041a91.1
        for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 10:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777137713; x=1777742513; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gzbxk8L9uFRzgE2/BRv9/1H2pVTDOyEIt1GV7kkjRwA=;
        b=fivTLnEPcwOLmfSnX1JzkWASqYBGIbDcIxlzzZqyIZDKhtE7/iknvylKCE7/RVcKte
         ZdV4FtyjcMKZmvZmhcrW3TL/pmSecdnGTtN+1xaz98vQW/k6roiCm8TWwVZwfnGd+ljK
         8yLHGGWu4/zB26+qMjA02K9Tq5X1Id/GYoUWsRsjVfSiAoiwxeGxLIAlDrwZQyECP6CU
         jnfq+Yso61F01UdB4W4QfdaO1DaDq90vMi8amtKPw3zvEuZvxYzU8/cvR8YPQLqJ43Ws
         VLuDKCfP7sQyCshZsgbHUYzLTCRHoCFrCtymtb9mQKgK3sIpg710VTwCyh6cyuPsS8p3
         aqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777137713; x=1777742513;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gzbxk8L9uFRzgE2/BRv9/1H2pVTDOyEIt1GV7kkjRwA=;
        b=XOuKI06GHKThszfAMgfFIt+16h3x6oh7BK6vyYpLq3l7Cqqz42GLgzcVq0em9hqC2T
         k6++lNBEOKkNJFZxhL4B51se/mMRZ3def4mEurnMiVQ2H6GwN+Sja5sICgdSnMBhRlN+
         vlwBcQ1Qvw1u3vSF5BTGd5BDeqDcpXXXojwGAmisN1Df4+JNTehbSy1EegmKpbZooW//
         ywqUb6o5ocw2O4km/ABl9RAdFNAJgn3sJzVBxT3/YaT8RlWrQlRCnZ2rCwgisYSNjI+Y
         iATW07Nz7HtBhnOHD7QbHRW6PxJc+K0J+BnURj75aR18l8JKiGy9pMkIkBDpbicIiJCP
         F4Tg==
X-Gm-Message-State: AOJu0YyRGPttIoZt0AhmwTFr5ZlCSghfOnes6KMAdr8wvWDYadevfY/N
	ozENQxB+7rZqGZCIudtECX+ZDaUhG3G62i2p5j+Jr1oPpphe/16r+Ea2
X-Gm-Gg: AeBDievLfz3d9gLpIjqJpVBK9Ez4jB6O+CU6Rwr1NShQXM+lfSYGecY0g8Agx1iqkWk
	h+JlRWvz2rwVdMqFVHR70DWDNQfiQ/VQ/BAVdE/l2cBIX909I7uWOPmdCjcmrkrYs1aBPnVZX02
	MTS540Z25dZfroD8Zkxaz+Qx3EzlUSb8jxRjqxLAmYlB6XW8AvLU3jhW8NpGwAFiaHJByCfgyiq
	PXVY56zTKKbN9OUALFCw/AAeMJsOd7bL7yI1hA5Q/lvNUj6IMKd3BeIT8eKUJ6mXFAfdM5+pW0u
	9+3vvpuw9pGGZAO8kjOx6yZwMQSCQoFQbTIhY4cv0Fu14wW6QbdPJWhsvCPQHTlWSruOYOOJhTF
	6OPc/ce2vk9Fu8PmKz2bZUuXheWZGf4sRUSRJtReVYNIhFxgQV9t0Keh0gl/g9Ix+NnOJJgoQeZ
	wHTdps8rDtbH1PQNAE6qo42SJSCPU6N0W8QaDjdunOJnJCF9jknDMyw3Q4O8/6XMk=
X-Received: by 2002:a17:90a:e704:b0:35f:ccf6:69a5 with SMTP id 98e67ed59e1d1-36140478a16mr36994277a91.20.1777137713136;
        Sat, 25 Apr 2026 10:21:53 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3614198f775sm32895374a91.16.2026.04.25.10.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 10:21:52 -0700 (PDT)
Message-ID: <fd376f47b9512daf669a87b23573f614ec146385.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 0/4] bpf: replace min/max fields with struct
 cnum{32,64}
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song	 <yonghong.song@linux.dev>, Shung-Hsi Yu
 <shung-hsi.yu@suse.com>, Paul Chaignon	 <paul.chaignon@gmail.com>,
 Harishankar Vishwanathan	 <harishankar.vishwanathan@gmail.com>
Date: Sat, 25 Apr 2026 10:21:49 -0700
In-Reply-To: <CAADnVQJa0x3ph51Eb_0UbO51B5OYfdfLoNdhMNt5nTD3LfpQ1Q@mail.gmail.com>
References: <20260424-cnums-everywhere-rfc-v1-v3-0-ca434b39a486@gmail.com>
	 <e0d8a24cbc3fd21cc361b93a3b25c9b412bc8c6a.camel@gmail.com>
	 <eefc176f8803ab1da8bbb0cae03d35d8d3df661a.camel@gmail.com>
	 <CAADnVQJa0x3ph51Eb_0UbO51B5OYfdfLoNdhMNt5nTD3LfpQ1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-04-25 at 08:20 -0700, Alexei Starovoitov wrote:
> On Sat, Apr 25, 2026 at 4:48=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Sat, 2026-04-25 at 03:05 -0700, Eduard Zingerman wrote:
> > > On Fri, 2026-04-24 at 15:52 -0700, Eduard Zingerman wrote:
> > > > This RFC replaces s64, u64, s32, u32 scalar range domains tracked b=
y
> > > > verifier by a pair of circular numbers (cnums): one for 64-bit doma=
in
> > > > and another for 32-bit domain. Each cnum represents a range as a
> > > > single arc on the circular number line, from which signed and unsig=
ned
> > > > bounds are derived on demand. See also wrapped intervals
> > > > representation as in [1].
> > > >=20
> > > > The use of such representation simplifies arithmetic and conditions
> > > > handling in verifier.c and allows to express 32 <-> 64 bit deductio=
ns
> > > > in a more mathematically rigorous way.
> > > >=20
> > > > [1] https://jorgenavas.github.io/papers/ACM-TOPLAS-wrapped.pdf
> > >=20
> > > Uh-oh. range_within() needs an update.
> > >=20
> > > [...]
> >=20
> > The fix is as in the attachment, the tests are still passing, but the
> > stats had changed a bit. I'll send the fix formally later on Saturday.
>=20
> +        if (FN(is_empty)(outer) || FN(is_empty(inner)))
> +               return false;
>=20
> too aggressive.
> empty inner should return true, no?
> If both are empty, is also 'return true' ?

Actually, yes. The correct operation name should be 'is_subset',
hence on empty 'inner' it should return true regardless of 'outer'.

This wouldn't make any difference for states comparison (at-least at
the moment), because of the simulate_both_branches_taken() logic that
considers branches with empty registers dead. But still, having
properties properly defined after mathematical operations will save
some debugging time in the future.
