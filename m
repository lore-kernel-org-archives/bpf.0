Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46325393DD8
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 21:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774645223; cv=pass; b=hkRFQ0JPhSmQR8k5a8qng6/QmPaaOxLD21TsJFU9DKSYFVOAJSENyYq8UK1UmyJZIaOMmCWafLmLpxujR7q2x/u41CpA2RAWNWWfSdUYlHAWK7ay1UCgQVs4hu0BKmEcFV5Idw+i3H42Tbil4DfIZin2dbeqDceT2ty2frMOCSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774645223; c=relaxed/simple;
	bh=boXAe/SBZRQ3vJHLFGMIondtcgS5qfNTX8dYY4IcdFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HUsnnf/N97bMfoaH5DdEowPsagG/WmffwhGc7zMibga63uU5pwtr1DM8Sb2e4Po+x9HM6zobqzAvLntoZ6+uSwUwLFnpPAC4f6nEv0eTux0MwMKhJyvCYNYeVMmV+kTLaGKj+2BK0L7ZV5xe415ktwgbjReJmvmQJF+5WXcbtCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hu8rF7T3; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hu8rF7T3"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48540d21f7dso28609135e9.0
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 14:00:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774645221; cv=none;
        d=google.com; s=arc-20240605;
        b=f/5L8S983kDp5weqIub9rUqvnPstLeCZNyhTZd2LZcwqM+yVLAGpe+4vjLmxlGUIgo
         EdHHIJAZTpTIKEyTThOUF6LBBKnvSAxU7Keu1x/WSzVbTh1sROMvmPkfeRC6TvFXs+MN
         CySyL7XWbyEv7eUoAe6We2wB8WkEnegewK6gj7jrrurRrDqpSC6AASRxweEKZfxIyLwt
         rwPc95HbElE3mUJa17NFhNz5GYsHzBYwOiO//exxv9cDh+EVL3B4CDdaCopw2TFtP8R9
         gQxyQfKJtcGC9QevnCYqSGKhRhTI6RuC2M5NftHZNUK/LlS/4oCYF0EuPvj3jyfixCFM
         GI0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=boXAe/SBZRQ3vJHLFGMIondtcgS5qfNTX8dYY4IcdFI=;
        fh=s8Hf09bqqN7dVwVE2qTrRX9L0OLipez4vLIHk1zGKOY=;
        b=Z3WEbOc07YTGNLHl8IYtFRPgXK1Z5R9iACvcBwh8tNKbc9J5grCaRmL/CH9zdfO0BC
         gsNYrS6U7pfUYJsHv+EXrO1m7d1eYWQ3ugCzw8dt+kf+9PsJBeLagTE9LBjDYjEPi/44
         JwI6o9vyMiAOYKO158H9JwV1FCJlYeIjgiDSBt1/rucBXofLTPXM60HT7Iv1QXHzuCVK
         5Cn0hU4IKyWq+YlqcAOIEHiif5Nfdynzl2Q/fmr06IrRPMxOxz6lPAgQLparutYrTok/
         NB0xStT+NlGH/C1Xoyo4kXTxBYVzJadpMV6EPfZGhep7PV9IVVPVZ3zO5UyiRFmp1EPl
         pXTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774645221; x=1775250021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=boXAe/SBZRQ3vJHLFGMIondtcgS5qfNTX8dYY4IcdFI=;
        b=hu8rF7T3CESjCcBc8XmsJoU3y4yAXPJmmE6Otk+gvjmblLLPSYiIQaSAkHfGo6oWq3
         Af2ewErzYIJhd+dVYOX4+ZNkqaxH1vah0u5VlKLG8UBzl+DuCizU3FbNbKIkmUlpADpW
         S0ZFPLUdsRLlY1qpnHMW0V4w1cCgy2UO7ZVG2C00VHBAQof/sxFlR8IH1ZGfQsCyVA9g
         tC6Gc6PoEZ2Xi96+P2SYkb54YJ3xQTTeyWvdBo6Hw+POuruKqMUPrQfC9WxLtt+m/K6q
         2zFy51rUqscheVuBnEYo2V9DE0GuUuYfmmRv9Yl2pqqqiRfhkILTXIXSvdyaGmcW+r+K
         eejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774645221; x=1775250021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=boXAe/SBZRQ3vJHLFGMIondtcgS5qfNTX8dYY4IcdFI=;
        b=TCt3E8ACoBiTJC/zhU2WYe7BbQ54pSaKIkjvNcvK/KsZAwClotTEUfkhIdv2dWhMq2
         BEjghm6uli5Xj0eR75LmFRl+YFl/5ewxv4T1OSizXgR2gswW2brQx2GMvp5t/asY8UHw
         Oc0tUgjoeLu9UcYiVETOIxeCp1EOPFlgFH/2fJYhDgcTmQTZnl0lzxJrFGyrkqkiUNb9
         EKRJV5lPzbBWVc5iPISEucVwGpyn+w4bhxQenHypjEuYUeVcjS8/luzIAybeV1/GaBLQ
         K1rGvxOTfD4iirxMVspCJOnOHUNSIkZFLKN4JNQjYjojNw0px9rf9HG2n7N03OjQ6t6v
         iecA==
X-Forwarded-Encrypted: i=1; AJvYcCU5ZXhqxPU4fCO1xMQZdxQD5zSgiK9viKjBDplE7KKDjtBvAE26pA8DAQq7+CyKlnV1nSs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2WnLLcyWLvHAMIDOikx8QBD+dVC3K5IeFAbBFXOLZ/nSpIkHi
	CU+7Hnc5anYOiZ1A6kGWUwIhas+NFoifxd23gPORyQWDYnht5zwILlEWl0EZDtLiy6RLCeYJEGI
	n1R6go7oTelwUhZKPXL6iZ7EKY7xEkBY=
X-Gm-Gg: ATEYQzx14HV2NHj1nQP6F1Ll+gsU05lc8xgTIuCxiiS92dSvDUFRduNjIjGBqNf6I8u
	MAojIaF2HVN/i2KnXoXDsvhKVfwPFmJhwwVLxsqbOtmLETC9xcDklGTcsmCEj6+nxosCtNsALfR
	x4W/zbtv407nehavaSugHsW/dgbH6AaqTNuj/FIAfF7tIbo1M08qoagkbdwLSaywl0Y3lp86VRA
	jaXpwje4KyyOqUYxpztEVVS0TSt8qMy2EwNKkwro1SC7/PGj4WRVWiAkYUSWfcYOl7XhUohqZ75
	xVJyTGnHa7sW6KgaVqafXKG+MIavfTstNANVinaAD31vlnVG4fQjpq/MySC3biUw5hb/sSWdaHV
	cKMa7YB4SpfdFM/bkleeWWp7Xdw==
X-Received: by 2002:a05:6000:2681:b0:439:c78b:cbef with SMTP id
 ffacd0b85a97d-43b9ea4a534mr6360629f8f.25.1774645220518; Fri, 27 Mar 2026
 14:00:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318234210.1840295-1-ihor.solodrai@linux.dev>
 <CAADnVQ+iXJK46cFcGN-Ta8KGxe7Y+m_DxgWNS=QC-gOWT=WxCw@mail.gmail.com>
 <b040711c-0fd1-475f-b807-e4e0b4324f6e@linux.dev> <CAADnVQKVEYhFXGXJ0u6TWQDe4t=zmq_tLpGKe2n_pOYT-J58qA@mail.gmail.com>
 <21e5333c-0b57-46ce-99c8-f6c414270e70@linux.dev> <CAADnVQ+bj2z0kzLcGTJ62NJgReTvqEu8fn6=7=bn+WKmfe9iTQ@mail.gmail.com>
 <676332b5-1f7f-4c8d-b41e-e2dbbc1d7e4e@linux.dev>
In-Reply-To: <676332b5-1f7f-4c8d-b41e-e2dbbc1d7e4e@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 27 Mar 2026 14:00:09 -0700
X-Gm-Features: AQROBzBXjQEEF8jsmGcuKt8gn_auUAUNeyeEuXgk4wEfA5f7-tXm5A5J0-pCG7Q
Message-ID: <CAADnVQLUTNoa4qXW357CU5e2hP+DpxM=QYK2ZuWHR_aLbmb7Hg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Support struct btf_struct_meta via KF_IMPLICIT_ARGS
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 1:55=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> On 3/27/26 1:48 PM, Alexei Starovoitov wrote:
> > On Thu, Mar 26, 2026 at 12:13=E2=80=AFPM Ihor Solodrai <ihor.solodrai@l=
inux.dev> wrote:
> >>
> >> [...]
> >>
> >> The above works, and the question now is if we like this mechanism
> >> more than current setup with explicit enums.
> >
> > Got it. Thanks for the explanation.
> > Your approach does sound a lot better than explicit enums.
> > Make a proper patch out of it.
> >
> > If we do this can we remove <counter><line> approach everywhere
> > while at it and only use named ?
>
> This crossed my mind too. I'll try to *replace* the suffixes and if
> it works fine submit that.
>
> One inconvenience is that with named suffixes BTF_ID() macro will
> have to accept an additional arg (the list name), but I think
> that's ok. We already have to pass struct/func everywhere too.

and that name has to be unique.. I think it's fine.
I'd do such change, and reuse all of BTF_ID macros.
So that only BTF_SET_START line will differ.

The overall diff stat shouldn't be big ?
