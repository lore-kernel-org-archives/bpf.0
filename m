Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792820023;
	b=LZIe1NQVrz9wai25VoKtY+ZsbCLHl9LJVUozOlSGTxYgD7pkJgIUGFsHWDvDN9NWmTPv
	 xmkP+eHKTxFc54s9l6BDFAqjzwI5hSW8j83XZFQUMp5+p1L2TCNZajPbs32GcydpXwthB
	 HtAhNdIDJMLNLQsOSXEKKpbxHlgpOS5xq5k+xVWT6FvwsWAqaX69gAE2xB9gUI/hff6Az
	 PHYF9QV+nZoGTdmNU+86r7R/AH16EQZn5OwJUdwMnBdzdfT0Odh/h+hKE56tqKdASK4od
	 1bdZgtdcSjEAyoQIo/COZqgXNfj6uNUtcEw09D28XmL/2/j0JvaBAAHdA+ZifG0zz2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792820023;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=8RYcMq7w6DvNsYKG6ATFM2BYt1FkaCFMQQoNO5kDN84=;
	b=zJKkirrcYPsudA0rcCi3vTO98pkx5XODMAGHo+ZyTsWAQRVBBVzXa7wYwU1XbMgFBTiM
	 U/SBe4CwmV8p9d8He6GYVjUDZ4wrcIgPyDN0jdnePErv8jl8iHor57f0YpTDclk+EQAAG
	 iUOVe/qboQAc1SGei5+e9o/9OU57CP+RWn7eGGjmhNa9bApc3sv5BNDb7dpN5ik2VHB1T
	 jC1h9QUjZV9mbyuMq5Kmz9XR/P5pCBkMRyuZpZvtpoyY59zKzqrdST2CEV2BilRYCLXHC
	 Xc3KVtNS+KkDlRO21YcHTCSDHPrPpG3ZtewhNLuH/RIufIIL5fy7xeOyZUrZi19FTQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N5DnpdGq;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D49860A2612
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 05:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D49860A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N5DnpdGq
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a089dfee18so1403432b3a.1
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 22:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792820022; x=1793424822; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8RYcMq7w6DvNsYKG6ATFM2BYt1FkaCFMQQoNO5kDN84=;
        b=N5DnpdGqRP813Tc5pVina/b7yganlCA0tS+LidHyaBBdOsVRXM57PkZzNGelRw8r8a
         R4B2EYTGsDgC4eeKMKBV2WBMOXsh4Nof03xda8H++WeLv3pq8rtGZi6SFGzN4C4bK/U0
         6LF7+jAZxpznf0DURKNHDosJ3jKnJ0XlJsxtRkiMn3MiteDzFH2/M8XPqj14Q5QpU8hU
         UjMvlJLH+o6S3e7VpH32awHmcxFjoAUZUjnuUGJPkWmijG4MJ3WqTo+tc5l4kwchAjPv
         VX4Q65RIVZI62h8mHDAf7XdMrZIETmTLLNIo6HfZfrQ5vC7NEvY9d2qSOlnSlGRSJpdy
         NZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792820022; x=1793424822;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8RYcMq7w6DvNsYKG6ATFM2BYt1FkaCFMQQoNO5kDN84=;
        b=BrSl90I+It7iS8pHsvgoPvtgr6NH8l4HBoV5W24g0FunrUTvOnNozZbBWFBuQ+aQpU
         S9J4/ARTJhbtgO/Xv+nRSs2d9r4NafFuyJMQsZhqgvr/nwFhUBfiJJoS2tcuH6lrpsA1
         ffnOgGzZa1dYwxxdYG7Z76KOukBm6oYoXvdlK3xIAJATIWDcR3t5gzFStocz6uItqwPq
         x/Zk85KH0LStTYzk5nTEVEzpL3EsR/L6s4+gJDzFLspTSgN2vSmE7f/RT/lEbRiRSxhn
         4B9Za0Vv26IeZvhsbXdg6NziLkiwiBHMvCDG0OqbI2Agt99UZJSoejGQzg0/AGSWBykH
         zWIQ==
X-Gm-Message-State: AFq9FYLD1rf5VPt3a/CobfqE6DKTx8DA07mYpXAo9ewxYmu6KAhXKuHm
	wC9UfKyvurMo1ymGyPFOzRoizLCrAKU8v7XpWs5jkCq8epMFyU00ESs0
X-Gm-Gg: AYBFou08zL79NR2eYWBM95qZOMWjXEIpx2GVn43SpF8rt31Q/fNqQLQQTWDqFw7HRuN
	Pkn+9c25vMqiTsRffQuyA8v5qecGYKeeHj2UrGXHPX2I7cDjUa4zSZTHtN18adPFAFmykAvp0KW
	pU6RL8GkwoTsd01vT3hLMTZSLe4bMnDvWB8GC7Q7NaPgLGfrL2jy08bk6EEIgj3Tw4g1c7dQnuU
	xtdGdguCQaYCNxk1PFnNDsWiXeLK/XfwzvrqHgbN5ia67LcmatI1jv31LrJlNah3utVTeTi6mvD
	GjwiU5f9F4zzvZq9Ah+fSiDYk7UAC2kz+98VNWOwfhwrHmampzNY+MqEUPWyuIoXFQ0TIR93sOd
	Pst/pahkuwVrBj3jrZ89Mc0qTey4qyo64N+V6KiCLi+Z222r3jLwigwnQYYVUQeCMOs3hD/KSIk
	iLaMh534domc5c3I4SHcQJjvpkhrOhZZhuBVN3iTnZGu5Tm7xYFIWOfEHicrCFgk0ARHgx+ph63
	hgjVNE+AfikGsBf3e/1i2wRV5qwBN9lKuIKUDPo9juLKxju+vRQ4QNsNGNp7mldWamtJsKio4M5
	e0Ntrn4=
X-Received: by 2002:a05:6a00:1889:b0:899:529e:dc9d with SMTP id d2e1a72fcca58-8a36a6c5c9amr650448b3a.1.1792820021886;
        Fri, 23 Oct 2026 22:33:41 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a36b372888sm247824b3a.30.2026.10.23.22.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 22:33:41 -0700 (PDT)
Message-ID: <d33913a10334e5256a1120d4030acd86df2c4922.camel@gmail.com>
Subject: Re: [PATCH bpf-next 00/11] bpf: fixes and follow-ups for 32-/64-bit
 scalar evolution
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>,  Yonghong Song <yonghong.song@linux.dev>
Date: Fri, 23 Oct 2026 22:33:38 -0700
In-Reply-To: <CAADnVQJdCq8nKqPE4z1AOHhvwYg4=Acg1QT5ZoDHQoFQh1Peww@mail.gmail.com>
References: <20261023-scev-simpler-clamp-v1-0-d43a07eda7af@gmail.com>
	 <CAADnVQJdCq8nKqPE4z1AOHhvwYg4=Acg1QT5ZoDHQoFQh1Peww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, 2026-10-23 at 22:11 -0700, Alexei Starovoitov wrote:
> On Fri, Oct 23, 2026 at 5:04=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > Follow-ups:
> > - bpf: (zext32 (zext32 X)) -> (zext32 X) SCEV simplification rule
>=20
> Hit that as well. I'm going to send a patch for it asap.

It is a part of this patch-set:

  bpf: (zext32 (zext32 X)) -> (zext32 X) SCEV simplification rule
  selftests/bpf: 32-bit copy of the counter compared at the latch
