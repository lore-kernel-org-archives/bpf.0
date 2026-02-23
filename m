Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D13337E307
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 23:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889017; cv=none; b=u2u0V+rtxor+X9g8lJYMxTuNnQpAWaycxMojKD1X2b3SohlCQF2q34P0LbP9jrhMCwI/GsgOEonZ7GX9IXadvfvJnVmj/dzODt0OuvGpMM6eu90Te/zCDShrdVPKzQGUoK5rgkv4LyXXlDdDeNl9FCZZs7pHDERj0R/Agd8VM3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889017; c=relaxed/simple;
	bh=+yS08vzvXpRUBtNCEXczRBKL4fzvSmytYy2fsXO33gg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WV7YgnIYs8mLoYM+Qq2ESfUCHBcTixaFMcTqBnSSibAob4QV6HhEaoDDvz5xUDH9SPmjr1Fit4dBcX6Fqbx2uwIgHj2NwgI1KNdtJb6VNRb51Okw9ZvUgtn/9Ph5+7rCVGQ4BOgEV+8Tq3h0BvcjIqRM8yXwW+s+h19jw7mSLdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5z8f8Hd; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5z8f8Hd"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-124afd03fd1so6714322c88.0
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 15:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771889015; x=1772493815; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+yS08vzvXpRUBtNCEXczRBKL4fzvSmytYy2fsXO33gg=;
        b=g5z8f8Hdo+PE+H2RTNBflOgGoYcpgmA2JAlYvl78uMEe9SeqlnVMynKswN7YqX0znM
         8NO2Vwdgj5f4M7CgNY4yJXqBObCUhuXVyEmzJM+S7KqOVNTrW345mOmTOBaMfq5xlojD
         kqny9fS6tblxsBjU8Reau0aVelLSnwbN1kbshHt8bgu/f+1FVwl4R1viDDm2FxkkqGAc
         AEeOiZ7fEFD/80YHeG43AYjMfCE5/1EoRE53NstweL/faFhSLWXQz35+3hJZ4VwAxA5q
         oBlF6UbrxDemRl6+lQB/wdOnWNWwpk6h+YBI3WwgyjwVVokhWwZ+MfVwAUitSFovMQ9N
         UTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771889015; x=1772493815;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+yS08vzvXpRUBtNCEXczRBKL4fzvSmytYy2fsXO33gg=;
        b=d6ldsPQzfHHkGgIP7OE7yZk6HPaHSNzM6S5xXOgMp1I5iUO1HQ+X52M9NB2PazDg8v
         jQO2FqIigpTiK/aTb9KajfzYoF3z3pgzOA4vsQPipAu+IX7jiJz9/7OihNPuzeU8g83+
         mdx5AnVcPqTWTmxpBzA7oIlj3GHMGN8oZUFPbyOFn7aMZh5jNwzCjB6xOy+9/YhqawJ1
         3t/rsBn2HI/h3x9TdAaDHUOxTbEeBacpIaAIA/EZCUVlGpmShf0dO0kgJ7ZNT2y6rStl
         0iaDKl3PVJ9EpSk5YiRB7pvmR1ZQ7o2Zg3UzkVWCsi43CwCLJMefzDvhgWmOxeH8aL1z
         STGA==
X-Forwarded-Encrypted: i=1; AJvYcCV4uAv+h55abqbSr0RSLXb8XVkRucFCC6YZa5idQ4ZLKQXcpTuoE2Cd9x23bhiVbe3bcHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTnKoG7u9wk3vNLQzsd+rUtpGkGzKS5JxTCNru5cjlPfTgW3yl
	5FyaFCwkQ++qyxXo/8dLaBTV6SFzjFoTxFBLRUZR70x3zBKdfFjDiqCo
X-Gm-Gg: AZuq6aLC4/kYB+1BJ1gDc83amSTohGUBN15Lf9IqK6Dl5CYx49+7Ye65i/MDEnhxf1D
	Hnd9z4iK2jRu3AxPRQPZWzKJpCX/6tU6SeviGUj411SPnu/PKJFmLK6k/6AuzXgzW6QrakKwj0e
	5mfYgoWrS/Fc0QtXnWRlS/FHAQzN1gDbW2SvILESBpvqC8wylgKwbLVbi423SS094IvkcgTZw1n
	/A+ak1CGWwe4Zz3PXeKU5ctqeb4oeHQe9nkkL63wxIelT+ex3TyoCD3RXkwHaxCmxv42KyBMxwM
	dakQ+TB/twc6Wh9A/z2KQ9Gi4Krt8k4iZWLDwzPcLTPkYq0otKum49UnDvPBeF3/IdMVD+VLhAk
	O/ZBc9/qnQMt1yKwVYSaASuXvNtHyU36QsZfX65qMtujpjcFdOQBqZVMsqS1grgQ2pgjCy2SbMS
	iWXAUjHmYi5DR0pSSFzLoShLerIM1LZiQ3A/7P9WCZAiLdbjjO4s6ot7SWwRpNoF84RtMBixZm4
	DqLlXwA
X-Received: by 2002:a05:7022:61b:b0:119:e56b:91da with SMTP id a92af1059eb24-1276acc03d6mr4109172c88.11.1771889015338;
        Mon, 23 Feb 2026 15:23:35 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:7bec:d612:85a2:37de? ([2620:10d:c090:500::1:3a66])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1276af9f74bsm7824594c88.15.2026.02.23.15.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 15:23:35 -0800 (PST)
Message-ID: <7d2353394d89e9d490a4437376e15c4aedc8a365.camel@gmail.com>
Subject: Re: [PATCH bpf v4 09/20] selftests/bpf: Refactor bpf_get_ksyms()
 trace helper
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jiri Olsa <olsajiri@gmail.com>,  Mykyta Yatsenko
 <yatsenko@meta.com>, Alexis =?ISO-8859-1?Q?Lothor=E9?=
 <alexis.lothore@bootlin.com>
Cc: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Date: Mon, 23 Feb 2026 15:23:33 -0800
In-Reply-To: <20260223190736.649171-10-ihor.solodrai@linux.dev>
References: <20260223190736.649171-1-ihor.solodrai@linux.dev>
	 <20260223190736.649171-10-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-02-23 at 11:07 -0800, Ihor Solodrai wrote:
> ASAN reported a memory leak in bpf_get_ksyms(): it allocates a struct
> ksyms internally and never frees it.
>=20
> Move struct ksyms to trace_helpers.h and return it from the
> bpf_get_ksyms(), giving ownership to the caller. Add filtered_syms and
> filtered_cnt fields to the ksyms to hold the filtered array of
> symbols, previously returned by bpf_get_ksyms().
>=20
> Fixup the call sites: kprobe_multi_test and bench_trigger.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
