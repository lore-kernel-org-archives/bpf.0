Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7876B342CB1
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 08:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780994635; cv=none; b=jIHfLmUTIJZ0COvwqx4u8O8gHfbuCmz8Q6o5nGa9S/Wlx4HwSTCBMUNnybXC6AEP5db8gGjyl/rla+7uQR6H3/xtbT8aXxNrP+tbv5g+eDwrQOZdkYxuBPsvF7zv/EIUn5S/XODOpWTTvzZL6xATdcfcMcfc9/fo8HwfZwJnsWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780994635; c=relaxed/simple;
	bh=4rTCpYdKEey/fxpJBzRiYD23VkjVM1koVws/Fj54klA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=sFvyhHZXEWldyFoQaexK3htilEueKLoTWnpVGwwq+cmR0RFQxyqHpaZFcVdIyHM1P+QGNL/TpWNzX0cEpNriniRzw45UkPyM/hhysp1EnjwvKa8QaN2rA5nLTFcELOfjeC669AAwUT7GjYPAbTr30vxYMNGH/XxtscJ4gqOV3OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPAkhf1u; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPAkhf1u"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-45ef616daf6so4795660f8f.3
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 01:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780994633; x=1781599433; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4rTCpYdKEey/fxpJBzRiYD23VkjVM1koVws/Fj54klA=;
        b=MPAkhf1uquZqzFn6EULJov+ZxAnSdVdGje6+ibL577WuH8w69cfqy/zmD36dPcNysJ
         lw7EWhjKnbUo94gp9tGq6tjvv3UWGuFCRiC0e6NN6XLEkVSw6taCWkiiBmhgvi3ki0uH
         QNu8CUqYp2FmCiPxJmtIcdcEDeCCQtfLaxAHQHHhF4IuHI9u3EVHrhlRZPstaYX0XAKS
         oiB2fInu+VDd7Ynw4KLaCpdByGW9imd4dKr9DmFbI11wMpfPVs9adFQLzAmN8iBYzZlX
         JRYM3sIJxIpmtm0Bvs30+q6qLWiHMjLfaGvjhsWkfxjNsJvURrWbBq+Fzk7F2HzkG71q
         mTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780994633; x=1781599433;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4rTCpYdKEey/fxpJBzRiYD23VkjVM1koVws/Fj54klA=;
        b=H/DxHDt+fCnZCjkAzSeA0y5pRpTQdc8PdpK+aBh22gkgIxfC4l4PwxNZQYbVcPmIku
         zswPRhRV8jv0bY1BE95C/z4VlY31N0Yl26gblIoINXgq+ua9K3OerUez7as0veYBRgr2
         UlZ6fm5s2KspIZvC3L4oM++qKarmUTyxX8BjdXb4Mp2FuNMPvrTg0GwBln+qvtHIt8oi
         4CtDBrQDanqi6p6YUj0ZHqwSxtRnrvyCAD1QQhi5K7Efb6T3jn4ATeplbLjtOdmmsWVQ
         qwWx74S2hhT7kWXExyXELzYTR2Rpwl3XBGiI4nYwwMDetBGqy1ThD7VVpw7d/+hIOJjj
         lVjw==
X-Forwarded-Encrypted: i=1; AFNElJ/U2hU92aOWqJjsqidxRWMjEFm2FaC2eXfKtytgcMnTakA6ZEQ7AFg+torKAS9Z1Q77Z0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze8wCHQ2uENL6AEE8ydXBDlKQZt7BPF06H+OgHN2zkwxpPINDD
	/jEGEwxmw42c5oq4rjopdNx5Ku7b/Atj4hTzi13N2X3C/U31qwQseAF4
X-Gm-Gg: Acq92OFNxDArzPk9fH6klYQEJwovsP7UrEnSCTlA5jMwk7iWnnmo+7lpHpRgGQvXm0K
	KIa2QR1WOsvUKK/CcGMjwGHh59W21D3sX0zZ0vuB62xPMioxqCLPsZ3gjgYCOeJiaYYdQvnHQuu
	scQ2B72kxrnhLYDLxLqhwELaEkruA8trOlTaXCdbvAdrwQCj6TNPfpdDTmPktx4oAlNF7gqSmm8
	O/UTi0ysoEY3l2mGlQM4S/CJPx2ZP33hHWC+zjQsY6ltE1PiVzVCJ8aIGq3fMsDFkUoEI9RJfbg
	lroEYsz2EcuePUJZ4vOvMIGkbuyRZJTcU6hLjUSDf8ObWXMNrqI8ZAoILKNoJjPTFLB/fXpVtba
	R3H37qr3iUvib54UjCeK/YkP5tKYLKN1AyjQQFROTJGhn8XYLkZ4rerk/czrMkwkNyFllz1BUcx
	l+oFPs8+qJo5CwWH8rdeQt/RZG0JuWvNPBP9d4DePP3tlMcsTYnBkVCDeetw2jJ+5CdDKMfLtPM
	N81yJBoHN2ooqIoPdFOhlifMh4B6xFOC1jYQMc2oRcWgTIPnW5Rf8DEAXjeTY5l5GQxxC+kJM24
X-Received: by 2002:adf:e30e:0:b0:460:1233:ecf2 with SMTP id ffacd0b85a97d-46030609798mr22356467f8f.30.1780994632620;
        Tue, 09 Jun 2026 01:43:52 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcb13sm60610866f8f.2.2026.06.09.01.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 01:43:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Jun 2026 10:43:51 +0200
Message-Id: <DJ4DWMO4HXCM.3NVLDGNT2704E@gmail.com>
Cc: <song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
 <houtao1@huawei.com>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf: Validate BTF repeated field counts before
 expansion
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, "Paul Moses" <p@1g4.org>,
 <martin.lau@linux.dev>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <memxor@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260605234301.1109063-1-p@1g4.org>
 <189a79443144cacf4a257f0627586f917d8d18a2.camel@gmail.com>
In-Reply-To: <189a79443144cacf4a257f0627586f917d8d18a2.camel@gmail.com>

On Mon Jun 8, 2026 at 10:01 PM CEST, Eduard Zingerman wrote:
> On Fri, 2026-06-05 at 23:43 +0000, Paul Moses wrote:
>> btf_parse_struct_metas() walks user-supplied BTF during BPF_BTF_LOAD,
>> and btf_repeat_fields() expands repeatable fields from array elements
>> into the fixed BTF_FIELDS_MAX scratch array used by btf_parse_fields().
>>
>> The remaining-capacity check performs the expanded field count calculati=
on
>> in u32. A malformed BTF can wrap that calculation, causing the check to
>> pass even when the expanded field count exceeds the scratch array
>> capacity. The following memcpy() can then write past the end of the
>> array.
>>
>> Use checked addition and multiplication before copying repeated fields
>> and reject impossible counts.
>>
>> Fixes: 797d73ee232d ("bpf: Check the remaining info_cnt before repeating=
 btf fields")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Paul Moses <p@1g4.org>
>> ---
>
> Regardless of the sibling email I sent, I think that this is a good
> defensive practice to use check_{add,mul}_overflow() here.
> Having said that, it would be nice to have a selftest in the patch-set.
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>

Paul,
Please follow up with a selftest reproducer to exercise the bug.

> [...]

