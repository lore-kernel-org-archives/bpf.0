Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0EA411F9F
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 23:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786577356; cv=none; b=BwS2B4SqrXRMGioG8ahZRtJg8rUnDunPxCKCoREOXsQfMmlPbbfF12U7DdzG+vNTrw5cMFo0gfZLSqinqblP7PjLaQPcRws+4inSx0gqb7vHbFh8y09aBLoPtXPEgicziei5glN+pn5L+cI1BxyhwbpYqV1iHClsT0lo72dTFgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786577356; c=relaxed/simple;
	bh=4twr6rEw3HosjI6TCgO4qzNrqdMCBY1ipuIWG8ii8e8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qohVGDURti7zY35mGDjrsuwt3FrbEhTahfPdIhFaxtV4vUChdVFFA7EX7nB7GbIbhFdGP3MjTq890x/+DYwzjuZWUv245a499rn8+L/v9IMyT1H516rtuxLJMzR6OVDng4EbBZ1S0jwhSVIScZ+sE4gyr6Pgvtpg9SM1F//D3pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XPabgOzy; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPabgOzy"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cf452def93so3589615ad.1
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 16:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786577355; x=1787182155; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4twr6rEw3HosjI6TCgO4qzNrqdMCBY1ipuIWG8ii8e8=;
        b=XPabgOzyaFYjRFP3EhGxnirxrJx3azPAO7ZI+5PEtPuM8rBNSXbXCHOLTi6lCVOrQW
         LFXMLx3gqJfRAcKKn0ZaxIdCxTZbJlw3NWB8mX4bgR0hditEr8VJiUwEQrzaLRJ0ctOX
         VvHOyG8dSUP4qPanu2paWmdK2GH0UML2lAZEq96qYfNL1jWSvTlpgV+XC+gLoJjc+kAQ
         E60RCS7yjk2hUMwxoZ3KsyTRJxN4EIcNkEF8LJ9qXFTNiRxaLfF20xGkPg7sQeiHCd0E
         yIg45t9HnQrD/0N1yxd8nqKTtvCof9QES8dUz4XqfLKfTb9NsUl5pEdV6ZVPvlaRMHDI
         0Vjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786577355; x=1787182155;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4twr6rEw3HosjI6TCgO4qzNrqdMCBY1ipuIWG8ii8e8=;
        b=LcvCMeIsvVRyMd4WtTGVlAfw9oy/6pjAaav0RZF0/a9Eahxvn/2Mop6jmLgyAKZzCy
         NbIw9c9I0XkqgwySZGi7zZdZJeMM90I2zeDbnmTt5HuypD+o/AUqJVLUuJ1Aan9wKwWs
         yN7/1D1IN4IQdS47eLlkd/JrydXb8v1tL3HlrQ/UrOVYmqChA2dgzo2X191BgWas6mfk
         buQT1/Tj5OYLzTpJSlml+z8o0MrrOr0NmtYpD9+oQbNhZpZm0G6xETD5fa7XuWtQTE22
         mRjZ4n7ceIs+qGxkEQJvMrK0Qxeg8T4+2SiGOO74H6F9UIjQkFz/i/52YQG7qE84oPn3
         1VWA==
X-Forwarded-Encrypted: i=1; AHgh+RpJOTgX9VdD9RALzDgvV18Xs6a4RI5O7dpgOHU4OWBDjia2p7hSwz41OnTQgAYsyy6254U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/c/rVu6k9mv62TbA2KW9/pVElATLbPllya3lxOs1HMd+uesvC
	4Ikom0/J1K4h7iNKYlqqT+lgQYN1xtN2VsTRb6ChGcKcF8S7Jf9gggXH
X-Gm-Gg: AR+sD13wrl+lWU5LnXowMq/y/SAc9XYdRiTaL3mjtoQkd2gqNI/s080sk66SUwdTC4a
	P+1beGOuSxmWGExcmY9vR56UpYA5J2l0VuzyYkiE++/ZSJyO1JN+WCXKfftkxfGqX4EuUslS/bV
	ZHLFHcBfldJepcCw5tAg390ofzKk4SF0Ebwfr/Gq96jEdY9+/5/fpn0FAHw6EXZhDyDKnwTdHhC
	qvq6DvhuJSY5F1cwsBDXGkiWMjfpxPq9ys32l8WrbQnMGp3okkr/kKn+4iTK090c9B6gUDUgX6A
	bSqLiBUrmu0lyzmLGKkmX0Yij7dkcBiUhAu1faFOHFhff8JytNVgrmwmu6IW+NwekdwEAKgMW9p
	C1QXHMOgvMdlTZxU6L0IuDcKiQkHlt5Z+k+4aIvVktZQCRVo2KWNNT3PqHN5uWrfaI8TtL3e/Gd
	MtRo11oGR9T+dijoTxstCcWSRjuweY2ymzhN6pnR1BrRRFxqtej84/FbzYtdIyvX/rUtKFZyGRD
	4iv4nuS8MBG09UC
X-Received: by 2002:a17:903:37c8:b0:2c6:8d95:fd7e with SMTP id d9443c01a7336-2d37f651b22mr15014745ad.6.1786577354806;
        Wed, 12 Aug 2026 16:29:14 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d37c4125besm2071695ad.41.2026.08.12.16.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 16:29:13 -0700 (PDT)
Message-ID: <bdbd94d09064d30e7c0d445f8f8e9f04d17b9dd4.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 11/13] selftests/bpf: Add inline-asm and
 subprog tests for R0:R2 returns
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bot+bpf-ci@kernel.org, 
	bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 kernel-team@fb.com, 	martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
Date: Wed, 12 Aug 2026 16:29:10 -0700
In-Reply-To: <7284d446-b51e-407a-ba9c-fd42c8a8a99e@linux.dev>
References: <20260811001008.2383983-1-yonghong.song@linux.dev>
	 <47093952550af2c87bc5730d0d9cec8f1c6e622cfb0216a9b1256118d8413274@mail.kernel.org>
	 <7284d446-b51e-407a-ba9c-fd42c8a8a99e@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-08-12 at 14:08 -0700, Yonghong Song wrote:

...

> > test_progs tracks whether bpf_testmod.ko is loaded in env.has_testmod
> > and sets it to false if load_bpf_testmod() fails. Every other
> > testmod-dependent test in the tree checks both the architecture
> > capability and env.has_testmod before attempting to use testmod kfuncs.
> > Examples include bpf_cookie.c, iters.c, ksyms_module.c, btf_module.c,
> > btf_tag.c, tp_btf_nullable.c, module_fentry_shadow.c, and
> > core_reloc.c.
> >=20
> > Should test_run() fold env.has_testmod into its guard to match the
> > established pattern, so that the test skips cleanly in all environments
> > where bpf_testmod is unavailable?
>=20
> Yes, we should add env.has_testmod.

Note that env.has_testmod handling is inconsistent across the testsuite.
If anything, I think this flag has to be dropped entirely.
I'd suggest to ignore this llm suggestion.
