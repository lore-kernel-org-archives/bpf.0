Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A1349A3B0
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 19:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789585348; cv=none; b=lrwYKwv06O3lQBTdUjut3r/QJaI6L4g+nTIxFd4V7vtZyqyNshatBKoTc96V5OyhinUL6h/whV6EBF3EE95h2+CLbdObo69NwN54XyCVFkPMoFiCPc1O6QIbCL9BAMYdvZeII7WLN8VkyENdooFPOmtWxfl6iEZCqd59/g1cA44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789585348; c=relaxed/simple;
	bh=vnBf+fKfrQllok3PKuYNQBvYk0+o0JxP57ZuYdEJUT0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=sQhn01pLIQjnpcycLQI7etuS/8uoNsLRPXX8Ri11011ny52SVgw0Pyp1VPICmYT0SvCAcZKYxFnlb1xSWR7Ok/gsRtSst5y4FDXcliB0seZQkQ1wsyiW6voI1dh4J6jVGiu25CRLNyOM9jOWDNfBS08hbXDvOwxnYiGJqUkBvdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjaOpgk1; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjaOpgk1"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49b46dc430fso173015e9.0
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 12:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789585332; x=1790190132; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vnBf+fKfrQllok3PKuYNQBvYk0+o0JxP57ZuYdEJUT0=;
        b=QjaOpgk1JfJGg246epJfhPIttEnXPxAQUolYTehZv0U6Bg2U9RcNfi9qGchAfB67sU
         b/xhgR+F7vGel6Iqog303wj/P6ZZRt9zSsmrUqqK4WKudVoZBavP2t6eSx1O+rGsAJvj
         8dd98JYflqcHzWV6ng2SpJHba28Dp3vHtFikwv/7lswZfnP6dNLeTW9CY+7VXBG8ASa9
         Dcej386FwZTm3M6HcioMRaCN5oNZbcaHnu94twyG83/7I7P3QE8YB0rw3q6ibOrAifnT
         mIFA5cLn+W4DGMJMEKxsQSZA/UqWoajMXIdmIvfBfmBajF1A6OzmnGpdJ+heP1S9yXwa
         gMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789585332; x=1790190132;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vnBf+fKfrQllok3PKuYNQBvYk0+o0JxP57ZuYdEJUT0=;
        b=m7Im6dWYIeFHfvJ8/Yq4pKGsd/Xe9rS9dr6MKZPZZneFkXsLy429bxrI5Ig5HwSjzl
         mY7p/l9iSiEMhj8I0fBxHkuGYGOkLvrIIeYLedGqWKFdJxZ9NT2OzWZu0Nv2TbNprjYA
         s6E5qWrG7yFjuWO7KHZZm2hmtpTCyjKJi60/NHb27lnFBFnHBmUMTy3LxGBRGpZgUsGg
         jbfoJkzwdO0pu5xtO7nKBjwh4WRAJL0WY3EJHglfiToJXeoSG/hVV+uqyPLn2ht5wcIf
         Rrm6jPijplNtWc9JK2iKnZopUI+46L9dlyDs50rASAjJk4nP3hH16r7+XWAEBxuPJrhy
         3quw==
X-Forwarded-Encrypted: i=1; AKwUvByo/aJSy9v+XuwxJ4hLP19Y94NuCmWovN+ef/m3/I4hUnm6avFGi0lfZ0i5tzqdxwq6DpE=@vger.kernel.org
X-Gm-Message-State: AFuF++kB3W5DAeENbzHvNcFJ4e8AoZJvreqd5udT7OWaSVqbR1Ylxk2O
	wXQsjP9SdFYqpH9KggAhpIPREVOekj/G+qSrqvhZuD1aAO6oj3WDHyTV
X-Gm-Gg: AYBFou06nnhCtO1xwwnDUM8CYQclVLTjE5r3ejnfpmFgmxv9RMblOpeC2w+Co2y3rNW
	g2n2alLuT/LRlJnpllehAkaEkUeI0keyY2aVds/B6Slb+DaXsLLhOykK3p8dc8gltSzePzA1C9H
	tshmmG5nvMMxAQhNAHywsqFTdDLQ6+7HSJVEHdr8x0eTB20WmNSQ6XaRIx/OSYKqskClY4EDxy+
	cSSt3oiQJaLU00E9BWN2pQLH9JtqaM4+PCPdSrm+PPMYbjtHO81oixmM1ikkYKaNwc6nSmLWZaB
	6HrLr3jSooBnCmMyfBAGqNQMbYM4SJJlvWIxCY6xWtkB5XdNTWzkfCvEIfWNCpbmVTJ+4fQ3VBX
	QCo1ihYb6UCkCoLKMi8wa1MThVOCQCjIhvRuJq4cnoAOHP9Sdk+wrS2MssXqol32OGHF59iEZk4
	0WLI1U8hMeYN7rhj/z7OlpmBRfqc7aWLwm5zAClJNMN/iqloB3AI6//IKVq05ua40Bxz++tViVh
	e+ihP7ZO9fp9ebBgCoh4xjSVHbGBeDQBwo5ajQEszIInIkrnEGpsPYNrj54TlGKlSbRgmlX+go7
	S9XwlaFsEYPj3HwlM13ZQzY4Jnr9NqizIpOBIw==
X-Received: by 2002:a05:600d:4447:20b0:49f:bcce:13f5 with SMTP id 5b1f17b1804b1-49fbcce1a1dmr9978555e9.24.1789585331796;
        Wed, 16 Sep 2026 12:02:11 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd1d0978sm12248815e9.2.2026.09.16.12.02.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 12:02:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Sep 2026 21:02:10 +0200
Message-Id: <DLGZ1ZGB8P0L.3VNPYDVX64HKE@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Nicholas Carlini" <npc@anthropic.com>,
 <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf v4 11/11] selftests/bpf: Add truncated CO-RE ldimm64
 test
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260914222514.1635018-1-memxor@gmail.com>
 <20260914222514.1635018-12-memxor@gmail.com>
 <b8b26cfa2ce3b93e364b3b1d5544c07062d8aeb7.camel@gmail.com>
In-Reply-To: <b8b26cfa2ce3b93e364b3b1d5544c07062d8aeb7.camel@gmail.com>

On Wed Sep 16, 2026 at 8:43 PM CEST, Eduard Zingerman wrote:
> On Tue, 2026-09-15 at 00:25 +0200, Kumar Kartikeya Dwivedi wrote:
>> Exercise CO-RE relocation of an ldimm64 instruction whose second slot is
>> missing. Build a valid BPF object with a compiler-emitted relocation, th=
en
>> truncate the program symbol to retain only the first instruction slot.
>>
>> Without bounds validation, libbpf reads or writes beyond the exact-sized
>> instruction allocation, depending on whether the relocation resolves.
>> Exercise both paths and require bpf_object__prepare() to reject the
>> malformed object with a precise diagnostic.
>>
>> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> ---
>
> Tbh, assuming we are going for simple ldimm64 check at the start of
> the program verification sequence, I'd just add one bogus test case for
> test_verifier runner under tools/testing/selftests/bpf/verifier/*.c.
> That would be something like 5 lines of code.
>

Ok, I will rework the last fix. But for now, if there are no other concerns=
, you
could skip the final two patches when applying. Otherwise will respin the s=
tack
with corrections.

> ...

