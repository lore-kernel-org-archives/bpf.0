Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C01D3E3D96
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 18:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782843135; cv=none; b=gVK11iF5UDfX0T//qzT1NYooYA/fGNQJZWUZADsC3n4lg5ucERtPo962RtCCPkbQM2DZLGS85C0BTMYFW4dEAJX7Bfm5wZgS9EL7DTtBmXiCtjDA2e76H5WaOTu2+p3gg1myFX/jey76uzI6P4l9+fPSsn8UwsivQwx4FgW6dYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782843135; c=relaxed/simple;
	bh=pvWRmKTAcAp8dmz/maDS8HquG+9SlriuXgB7hqLdUPQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=KUcQ5TTUriHL+DUmk6huSUT+jQ6KZ/ZQcCLEvzWWMDBwsRh1t9hCk4xcUuD4Tc1QZbbCaoARmQH65GKAMo6tStwNZa0JYxx40wbtSJmbpDPYvWRn3ummORC6/CrSwDinsh2D8BsIxVigZx5r24JUUQl6wCOAtXNTP+zEKUXeMh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wzj92MFP; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wzj92MFP"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7e9bc8dd61fso3115602a34.1
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 11:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782843133; x=1783447933; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvWRmKTAcAp8dmz/maDS8HquG+9SlriuXgB7hqLdUPQ=;
        b=Wzj92MFPLA7sT640jCH2G4tA4tiRPw4D2CJPh2KSsSqFcf7RVy/WCKcYb3pzAjn9gF
         gVjQZ5/klf6LAGezCw+MxHOkC+6YbndoEKvHI5dn8B6LiwTOLfmT12dMNbxwqJZwJcLB
         8wtxbrCpRIGXQfS3oLfd5vKfLdU1u1J7erKAIkP9dpKtxoD4ehs024JsU5PLoSPBrcjI
         SO1rVxtrLdWm1KIkzgjToH5aAMn2piSgUD6vVYoV8zv040z1rpXXEkU9NEpCuzIBMjTa
         8T1DANLpzQ1CBS8tPDTB7KvnMYGxaFfozKY638FXhQsbjeI8wuZ1QKJcm2pxmMe/g43a
         sJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782843133; x=1783447933;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pvWRmKTAcAp8dmz/maDS8HquG+9SlriuXgB7hqLdUPQ=;
        b=KtvkYX0TXk3/JQbyrXEAxHlGIMEcHL9qX5Au6512glBAIVnSVWUyLzlJdPABSn7tQQ
         Tb4PLi4fdhbc4eyTSrdsu16qu+HqK1qIOGUKdZbbi3h2NE0C7ZRmVOfVfNah5moFXHuQ
         n+d9YbWzQLAaG/ZOWrRaCQS6g/Mz3xlsKEujMQFPJZYJCDL0DHshqlrBY5dtRVwcVQ2z
         O2bq5jrqBu86TU6lROIftHK3S/yjnr+bo+pzj0pd2u3JO2DQpyG8W5JEmXPAFlzrJqPI
         pk6lkMYXAB6WtFN4BEsEWhhq1c1TSbTKHfZcb/o2+vBu6JTGUZB5VMlpebTx80u5xYKf
         CLRQ==
X-Forwarded-Encrypted: i=1; AFNElJ8u7ObPGyQd+ZHBEXjzemhARI0oHrq1tc6RCQcpNoLuZxgKiqZz7w2Nr0DwA4dxpk2WMSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlW4lRXROIqgLxr9KRaapphFdOD5aU0h0fLIP6ubZE4q3/U89V
	7UbDkm3kYd8p6IYgOylzUZ8ApvfW2w+kqAgGT6xXVX+mC92WLEszqE5a
X-Gm-Gg: AfdE7clMXcN1Fac5aaNm53UFxTvpg0BKobRXmi8qYfI0ZNtFhzRfzzR4zF0OLlF6So6
	DuHouBfDxmqnzlDXAMF8L0kd5L9hNAXuoVDN/Fp4swsUzVuSAmVwp82wJHkoBkFc2kMMgieDwLE
	R31aNk7CT1f/MT87W/8VO/vhh5lxVWUDo3td6w2BUUxRpNiHbdwiTuNSpPCUbfOgNHB0AkhyTGB
	p/iKu5AHuAyY6c9BFXpJxY/+YmPrS8F6QSsMOrkwRGtDmIlzupXrOVTLYI8ne8B8oNGDnBqFffT
	UJdz/Fyd7xv6E1jhK6lmWEkAaI33Dfa8cWDm93gKLGU6MeVqBlVGb8J1UBNZ0RwBZpQBwj0al57
	Z07KVRpSif54n7duuXnYsnFmuXdG3BXb8b2eGIZ7luCC9Uz9Ln+N+KSdt7I0qGSkwrQvxHVKq/U
	32r4Nxpfwc668HBuzeZ42xWuyUtTMyvYxk+NdB2gGsfN8uN5McPp/hgjgoc2yUgVzxjOeZUCCgt
	2lKFZA=
X-Received: by 2002:a05:6830:6aba:b0:7e4:163:49cc with SMTP id 46e09a7af769-7e9ec5a2671mr3575916a34.7.1782843133450;
        Tue, 30 Jun 2026 11:12:13 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4c::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9ebfcb3a4sm2896041a34.7.2026.06.30.11.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 11:12:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 11:12:12 -0700
Message-Id: <DJML5849E02H.EAOD5MGEV8L0@gmail.com>
Cc: <andrii@kernel.org>, <eddyz87@gmail.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <memxor@gmail.com>, <martin.lau@linux.dev>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
 <emil@etsalapatis.com>
Subject: Re: [PATCH] libbpf: Add length checks for path parameters before
 memory allocation
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Masoud Aghasi" <maghasi@disroot.org>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260629122559.3828469-1-maghasi@disroot.org>
 <DJLQR3M9S62V.2FYC7QDSTU3DJ@gmail.com>
 <87da609e-ff8a-4f26-929a-338399f75288@disroot.org>
In-Reply-To: <87da609e-ff8a-4f26-929a-338399f75288@disroot.org>

On Mon Jun 29, 2026 at 11:46 PM PDT, Masoud Aghasi wrote:
> On 29/06/2026 19:23, Alexei Starovoitov wrote:
>>=20
>> The code is fine as-is. We don't add defensive checks.
>>=20
>> pw-bot: cr
>
> Thanks for the review.
>
> I'm just starting to contribute to libbpf, so I'd like to make sure
> I understand the design philosophy correctly.
>
> Is the following understanding correct?
>
> Since the caller and libbpf share the same trust boundary
> (same process, same VAS), libbpf generally assumes that API arguments
> come from a trusted caller. If an application accepts input from an
> untrusted source, it's the application's responsibility to validate
> that input before passing it to libbpf.

No. It's nobody's responsiblity to validate anything.
Users of libbpf should use API correctly. That's it.

