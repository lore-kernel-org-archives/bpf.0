Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC55D8615A
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 13:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709731610; cv=none; b=L4Mq2yPduQMMa8+Dehd1D8lWxNT5UHgSdOI/rbgVTXUFKwSpmg1QZ0t7YYLGsGwRSpNn3AvRMdsrmJGQH4XfberCOYOuO+Peo/EGQBXTpoAGzO23k3hGU4ziWYvGw6MsVLiR0pBJAzaDDG3HKDjUDRF9lv8OUpW5r+n/50HaTHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709731610; c=relaxed/simple;
	bh=D9FuA0fqLR2DmTZUbjpYnvl3klXEaO8sSJIOjtMD01U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i0bbk3ZXwiGqqNhtwjmI+zMG29aCggO7kbOpi+y27ElgPssMhojKIUKt13PYeHLXkX4APLaYtQhPsEMeQ0zgMBkkyiyVt66ThFbGXG2PTSCxq/uA080BV8EymPb1o8yrWPzxLXWXrzy2Waxy90g3HIwVd0rFzk35EE/QSyB5o0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+BNny7/; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+BNny7/"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5673b5a356eso2191024a12.0
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 05:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709731607; x=1710336407; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mMMfr381whOTEmEy7U3n8tN7jcThyTPb8JJUihFzpvU=;
        b=V+BNny7/9/XeYcq4HMnuXtjcZslZNYIygjrFHBiVDJPKDHSTlx7U/PTQs6LteiwC2c
         2NM50tJqQGbE3fa1FsNoeAwswD+qgEHc/4uSk5peCkrjJnqaLCtIMkrQFnNbTPkbF6qb
         nYeTsbv2px1QiuMGhyZqfkxxpX8KklKPCV/kKDo1myeQxjtaFKfMf5msw4mVmSn8DREj
         ZuYlhMViLV8408TZlRpPUarXCbGARkztzJlEOiF889AfoyBLQgVIih3KaE8ODbMlOQPv
         mSGFUQy9HOn44UIblYbkirtgdOUax/AFvkb03d6r8pbvAZ2YyflVevalM4rATxjZKXlM
         C8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709731607; x=1710336407;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mMMfr381whOTEmEy7U3n8tN7jcThyTPb8JJUihFzpvU=;
        b=rvyStNAUVn9tcc1+9aaFGVq5+f3kHXBuTgEBqP3ujZ9CEZnNPXkb4Ii/akGWus29Nm
         YeRYXOJoH0bmOsb6AaCJpbRnX/DPl5dYybJdTfpC6FmJos35jhwOk9ZuwoL44dYyBb6N
         WMhsjtt01bvk3GEjk/BTdWscIb7MWqKfFU4EHRxf9d807X9Aipnl5T90+X3vk/iC0EQM
         zstqiDmVfHwWwVdqSw527HJI7GTEzCrZiO5HnkiT3kBbEnvbnmghFqM19t+Gu5IBC1b8
         uXCyiukzgC95n6JXwOgNKXdyLqcnQi5ZugRbK86iDyX5N1kyPxPnA627fPA3hmLtPEU8
         btMw==
X-Forwarded-Encrypted: i=1; AJvYcCWVKIwBKL8sjnRrpWXBOo+K+DHrvrvJ9TyIGbFHpzwhD9SNMKLrK662gd10pxnVPPdYVIWZqoDgwWFRIkQ00sSHsW+l
X-Gm-Message-State: AOJu0Yw12527qzkEe1flzZH9iSZ6sCcAEY1arSYjBDTHr5/7z7fFKOV1
	3v8TAkAhRCzmzEuej17dwnd3iz1VRQXGjRGe40EVt5XOD9JhAFp0
X-Google-Smtp-Source: AGHT+IEfUcD/QS95QZsRayG4uHmLEH2582Eo9/G1RrUc5KLR8AbeTlNi1fJr+LOM7ZvlrMMzIRLQvQ==
X-Received: by 2002:aa7:c85a:0:b0:564:7921:37c3 with SMTP id g26-20020aa7c85a000000b00564792137c3mr10080797edt.19.1709731607196;
        Wed, 06 Mar 2024 05:26:47 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id 7-20020a0564021f4700b00567ed256052sm577738edz.19.2024.03.06.05.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 05:26:46 -0800 (PST)
Message-ID: <e4fcd2c9f88e7ce31d356cb31e686bab22382bab.camel@gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: Add cond_break macro
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	memxor@gmail.com, john.fastabend@gmail.com, kernel-team@fb.com
Date: Wed, 06 Mar 2024 15:26:45 +0200
In-Reply-To: <20240306031929.42666-4-alexei.starovoitov@gmail.com>
References: <20240306031929.42666-1-alexei.starovoitov@gmail.com>
	 <20240306031929.42666-4-alexei.starovoitov@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-03-05 at 19:19 -0800, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> Use may_goto instruction to implement cond_break macro.
> Ideally the macro should be written as:
>   asm volatile goto(".byte 0xe5;
>                      .byte 0;
>                      .short %l[l_break] ...
>                      .long 0;
> but LLVM doesn't recognize fixup of 2 byte PC relative yet.
> Hence use
>   asm volatile goto(".byte 0xe5;
>                      .byte 0;
>                      .long %l[l_break] ...
>                      .short 0;
> that produces correct asm on little endian.
>=20
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

I tried rewriting with offset +1 and an additional goto:

	({ __label__ l_break, l_continue;		\
	 asm volatile goto("%[jcond]; goto %l[l_break];"\
			   :: __imm_insn(jcond, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 1, 0)) \
			   :: l_break);			\
	goto l_continue;				\
	l_break: break;					\
	l_continue:;					\
	})

But BPF_RAW_INSN needs filter.h, which can't be included because of vmlinux=
.h,
unfortunate :(

