Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767202D248D
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 22:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773439335; cv=none; b=LeqB/ZbzMU2C/oJtWN2TehcsQkjrjcknv9sM5TZrjxXCsdCEb3x1Lse6qR4BARXJg66tFFGS7IulUwy2k0Wz1tVJrdy9UgcmO0nUXw32rRh7uRm7HIarj+qHqE08Fas0LGB5e/JUudC0twYu/7Q3GB03M2hHWrNA+D/SnRhf//g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773439335; c=relaxed/simple;
	bh=qXvj5r7hF4JCM7PHL6P1CbcIqTrZzQBonF7UVduL/nI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G3mHPpkQNUKPIObeT8A0BJRvZ4+0eMm4lrw1QhPPiIJ5/Fgg79PoBLd+ngm4zHT68/F+EVdQS6nPP3yZ8KpMQl9Jv+lNZRKuabtNfr+82os38MuVUKL9sjOwlj4shriHsZUDlllRU+O4KkYmNgsw2NaK4xLQHkXwPt64eCsikow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQwvenSX; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQwvenSX"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82985f42664so1768972b3a.0
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 15:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773439334; x=1774044134; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qXvj5r7hF4JCM7PHL6P1CbcIqTrZzQBonF7UVduL/nI=;
        b=CQwvenSXIHd4iS0sYbS1pvushNdYGByipYVpV3/G60rIM5Utu4KEcKTY2Xi+8vbE/k
         z+2L2l4/bvSHocZ2RRc9O18BfurfEBm9q26aqOTw2KG6nZmqGdCcVXpk6RRePP9u6JaS
         +lc4HFmarmUswuw/LdER/Dhf7P8jIhd/6RxoFQZgvNqf9Uy/JD+fuSEsFgOS5qCuUVPN
         zhQYC2I8qoEABbQhUhOmYamIcCERzuierEp9K5PzSQqKtqH+DHza81G8nZ1RESiDZwib
         AXAhjBOly4sTdAN9Eu0bL0C3icF9p7E0yf+x4i8owiaVYOdsr92NTd/MtYNi47NCjg48
         HIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773439334; x=1774044134;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qXvj5r7hF4JCM7PHL6P1CbcIqTrZzQBonF7UVduL/nI=;
        b=TYGSY9Z8ua5yqyoyWv7Cl6ZnWjbMaCuQ1ZUMxakYdK0dOD8bssf5vZa2IKL7VykUdq
         qFEn2BA5dbXW3GqN/Adwh9LAprCCPVKRKUrjA9Z5yfmb9dE7PF49NOq/05yXOump74Ax
         iWOQa/MG9u/onGspImpCVyqAZBpZyCpqZAy1hiZsUGScrozKnUb5dYADH7dVC72eCi2P
         loae+Ebx7Ie2v8Omc9IyjdfcExD3ubWNXxljFijdmQbtbIDMoPXn13N7cQuH3nVDNnGp
         vTi/MiMEr+C+XNtPVY7PtdfG2ZbfXjaf70TSb1C8xuM81M+iQsJCr1OXR4vZSTxt0lH9
         foWg==
X-Forwarded-Encrypted: i=1; AJvYcCV4B4SUsNgy5SbyfpotI8CjBPn3Qap58WiH5wQaLzrWbkS3DglWC5WcOJc2tBFV41cjpKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMxhFTKEn19Y5AnULCGVLxhiWiiLIaFg/t3l8Hc30KGsNgeKZq
	V9w7BKLKX31bD81HcFm82PPV7pLNHUC5ba8MK6gYq5wsEno3EqeIoJ+3
X-Gm-Gg: ATEYQzwtBbb+8gfTgYT0z8zpIL1iOzbf6uJqooz36jX+I+pOVdLpIWjccQc5Hn7v3LI
	KbBhcI7bZwrURzfgUI+7UaCYSFHArb3/IP5ZjT5kCC6iBfKeIF8pUJKptk6dMeG4WVXkPo84oVK
	WJcSccJxLR0LuCAturvsWPAKXqmiaNRrxetRsmzDHm4fm40ciavbWnTBmL5OJp4/3Wq0RbsjF5t
	OBWn7xqBfL019WL+4z17j5jN3gvIOXl0dUdBdD2so4AOJNjwUZwpmL0XZHDb/+7uyD2hgsy1lfl
	EfEG7f7MOsXprMYX+3NEepY/KhkRk4foZRQKKGSlyCYZecMKdFh8pv6MSGXmEbj/AZHNtY8NY/a
	+1RAMZpkizBCuvVC5hDkt0HeK5R2DOoauG7Up8Dr7iKCVTw0wLSTp5+Y4+mllv1/yHfsWhxAf0s
	4IK2J1HXHWDvARzGZh6IcN5VG/lz1NdKN6LNpSnwH9aN5H/dHuqpw=
X-Received: by 2002:a05:6a00:4404:b0:81c:8d47:33ff with SMTP id d2e1a72fcca58-82a198d68f7mr3763476b3a.47.1773439333623;
        Fri, 13 Mar 2026 15:02:13 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a072612e2sm8948335b3a.21.2026.03.13.15.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 15:02:13 -0700 (PDT)
Message-ID: <ede050cd3a7ac94a839c2960a8a09b1dcd1f0777.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 0/3] Optimize bounds refinement by
 reordering deductions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>,  Shung-Hsi Yu <shung-hsi.yu@suse.com>, Paul Chaignon
 <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Date: Fri, 13 Mar 2026 15:02:10 -0700
In-Reply-To: <cover.1773401138.git.paul.chaignon@gmail.com>
References: <cover.1773401138.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-03-13 at 12:36 +0100, Paul Chaignon wrote:
> This patchset optimizes the bounds refinement (reg_bounds_sync) by
> reordering deductions in __reg_deduce_bounds. This reordering allows us
> to improve precision slightly while losing one call to
> __reg_deduce_bounds.
>=20
> The first patch from Eduard refactors the __reg_deduce_bounds
> subfunctions, the second patch implements the reordering, and the last
> one adds a selftest.
>=20
> Changes in v3:
> =C2=A0 - Added first commit from Eduard that significantly helps with
> =C2=A0=C2=A0=C2=A0 readability of second commit.
> =C2=A0 - Reshuffled a bit more the functions in the second commit to impr=
ove
> =C2=A0=C2=A0=C2=A0 precision (Eduard).
> =C2=A0 - Rebased.
> Changes in v2:
> =C2=A0 - Updated description to mention potential precision improvement a=
nd
> =C2=A0=C2=A0=C2=A0 to clarify the sequence of refinements (Shung-Hsi).
> =C2=A0 - Added the second patch.
> =C2=A0 - Rebased.
>=20
> Eduard Zingerman (1):
> =C2=A0 bpf: better naming for __reg_deduce_bounds() parts
>=20
> Paul Chaignon (2):
> =C2=A0 bpf: Avoid one round of bounds deduction
> =C2=A0 selftests/bpf: Test case for refinement improvement using 64b boun=
ds

This note is mostly for Alexei,

Me an Alexei discussed converting scalar tracking to cnums and whether
we should proceed with this line of work in that light.
After some additional tinkering, I think we should stick to what we
have and land this patch-set. I'll share details on cnums later in a
separate email, but tldr is that cnum representation is strictly less
precise compared to combination of signed and unsigned ranges
(probably this was obvious in the hindsight).

Thanks,
Eduard
