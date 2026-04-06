Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FD4238C36
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 04:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775451112; cv=pass; b=rQoHRLdr13Y7tULsExwRXfzn6g4EyqVRYUhXSsQ80GsFZX863D30DxRIGN0rJacDaqyDr2NnCQndNQgraxMoNUrsTaUEeKYxRPMMRmgDyKcN1nteHVHES7NA2WQFXIuyI5vYAOULYhv62CIQaA2U+DRHdtLoohk6iqXpQF3Ufwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775451112; c=relaxed/simple;
	bh=lNz/Zp2Vrxz8A8k+nXWnEkP9tMA2yeLd4ut8OM18zfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a4LyL5AXjRVtO+7Cjvw1mWZVGlvg8587pTrWzyGtQwG02fJaeAotLJzQuB1uqQ7295tNf5gqYBy6YaaYgoi9gk28emohPGyD0ljE4AbiHaqWsyaVtJtDzqztxdBHjPRsKbqBL8m3eRWl5lvvUbzdsqnELksqwM/kIT7muUYRRS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2RZe7Wn; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2RZe7Wn"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488a29e6110so15252545e9.3
        for <bpf@vger.kernel.org>; Sun, 05 Apr 2026 21:51:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775451109; cv=none;
        d=google.com; s=arc-20240605;
        b=jHWucgrg2aQ55MqgUPC/y3W7ENvvUvrYRUU0WwpZ5lB2z2h1P/OKrMm45fsolAUE/m
         9RtDi+enK7ibaKPo7o6f6RPxqH/Kc1Z2bTha38wElTZmh8dqsTV28OCk8k7jTKcujnod
         ZcyHfus+06J7JW8v3Sr78yesi7LadA6EtygTeWmMNdJSIpnDoQKb1D/WfslanyhaO6f7
         0/VvbolaQXduBY3TjDwXZsDrnrS7MIa68HKP/BnFHqGtCUTfDZ1pZyqdWZnTuIP8FCf1
         bEDHqgFinQ9OwLExxU9Lq+PXtL8Ndj9ye9Tqb9RhO4qeLOLa2XtjOmxe5ihl0wM3BssK
         Mlbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lNz/Zp2Vrxz8A8k+nXWnEkP9tMA2yeLd4ut8OM18zfQ=;
        fh=wi89WQjOF2HvnYB0v50Lj11/w784Fae/K3mXW7+OEdE=;
        b=Dyqw2l2EKXsJb1yjhnTIBNl0APLyp1TLQDnfIKyWV+Z8a/GR1nasSoLXfvWI5/OWH4
         w1QYVhfEpf5pM1sFVgJ39RYBzy6zFdlzrU7Kfp7rRhirWB3MCH3adAcfdOCMs/S55FtI
         S57utGFoiG5TL7MCQ6UtF7zf8zGk2EPKZG0rbQ3+xqprc+XYtCNoCPPV0w/AmhuVpDtS
         kTT8/fqsnAedfLYj4c3JkveNrqjf4lXeDR/Ea2NNBq/PdmUPrCTmTmH2cn/Xr6eVzL1u
         4eKv1wkZ3bXxqrDyZFopbVzGNkgDMMN/cwCRTNHk+9p3lgm0ylguB205u7Lpf+lkUwaY
         hiZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775451109; x=1776055909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNz/Zp2Vrxz8A8k+nXWnEkP9tMA2yeLd4ut8OM18zfQ=;
        b=L2RZe7WnQr2Ztk9dUGOrIsPKSHG1PVb8iMDb4hFd5XZcasmsc1vbglaLl8NFlK4PgF
         dw8VU5zjsHM0/c0LazMZQJ+yQVc/xSvTMbS9wUcPf21zCVBSoMfCGvG70OAjkpvq/MPv
         jPWpibcRclg2EimviFfS+xQzA1ONg9iom7RUi/361VskAIQ9f+KNmb38yJw3gPIaf7SV
         CfG5pW0k4AGF0DDFl2jU2+KgS9mUHrhfttJSbhJLQlrK43xacYPLrGOPV6u9d8QIFHp2
         zqbIUDPQxswWBEZ181aoGHW5ThBgW9YPFoGvSwhQudOmCRstSQXVPALymeBahBTvZtYi
         oj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775451109; x=1776055909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lNz/Zp2Vrxz8A8k+nXWnEkP9tMA2yeLd4ut8OM18zfQ=;
        b=Fo1jMdgWGwMqC77fSEzMHEUFnBcKlrRPTvXl3mR2mqb8Z3/jQmboU4q5FZ+q969hmD
         py0PlvsVTl8KANSpiy2AzhVwDZOgGnsLXU1MxpII6jfRqXjIHYZKH+DDRGbRRoEWlmjZ
         nskSUzOBLlmvqYekh7d9ohB6C0fDXYvT2ODbYdq9PXTHCmoQMmlQeqtummheL4uUoRGX
         Zwf0Sm3VYuMusg1pphxE9KZuBgW+ZW7XdEX6HMeQvTS/OZf6YAWBKtQQWgvMfDtqA36W
         RnWTbFatbahuLDVwjAmVgnPH3GMlToxhkWTL15caWD9/r6DnMugUJ0kAs2v0recr3i+v
         w+BA==
X-Gm-Message-State: AOJu0Yw/80YW0d+GL9pIT4LMtxYzKs0dIo+jiy8vujOJ5K5+dnyruaa8
	VblbqpELxt7LyE3yEMA/spYD6Kr0xcLwyynHAdJAzTpR1Ss+KZKQLbO7gKUsIuezK6PetzXPWgd
	KSel0pn4g9BEVNs7jSZkavNMIzZ92IqQ=
X-Gm-Gg: AeBDiesQa+vmpM7zxgBX82zL53JQictsUBKbu4LHw1c315x8md22qnZZFJbbz+uzWR1
	Bj+ASBaIABmQ6todjveF4JC3uj5Po78E8PisjqeggW/WoD9T2Ut+BbOMBA3WHayX5hkoWdW7gLl
	GNHkacJunj+KS4/jgdB5rW89K6UbRBg1ZNh/0RzlG40Meixd6R/37JXC8ZSwaKet0ZL4XL5KVAT
	9/c6k2tkG9Wu3k+3iwuoK+mjjekCNmBED/+cVRJQ/RcgY6R6HoqVBgwd/MoXs8wVyl4UK0q3YjY
	54VMAvWsh3PXE63APZIx9+VX2fH8GLst8gm9JJxcwvywU0Dp5cSEDDXNmr21Dxn3PJtk2nuhl0j
	zH0lpt3KcVkXjqtyaDBjf3ia1VA==
X-Received: by 2002:a05:6000:4020:b0:43c:f4df:923b with SMTP id
 ffacd0b85a97d-43d292ff5c4mr16211033f8f.50.1775451109064; Sun, 05 Apr 2026
 21:51:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402012727.3916819-1-yonghong.song@linux.dev>
 <20260402012742.3917613-1-yonghong.song@linux.dev> <CAADnVQ+y1jZZTyNcXghD0UQ+JzD0pEu=icSP7=+QY4b=9dzv7A@mail.gmail.com>
 <924fde92-d28f-471d-9f0a-0c176958139c@linux.dev> <CAADnVQJdTffT5sdqZVdWX9W-jG2vPjiPAA0OT3iMPPsY9-KFmA@mail.gmail.com>
 <074ee11d-3f63-4e6c-b66d-c60a834cbb25@linux.dev>
In-Reply-To: <074ee11d-3f63-4e6c-b66d-c60a834cbb25@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 5 Apr 2026 21:51:37 -0700
X-Gm-Features: AQROBzD5qp1TZU9lrnhR2W0zr3DK6u0xec2yz6CrJ9FtalfgpPrmAvZy1gwcJY8
Message-ID: <CAADnVQ+9OdBFnUAXND-MW7epFnqwj9f2w-w0xPD7T73sTMj9Zw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/10] bpf: Support stack arguments for bpf functions
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"Jose E . Marchesi" <jose.marchesi@oracle.com>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 5, 2026 at 9:29=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
> >
> > For 6th argument JIT emits these two stx/ldx as moves to/from x86's r9.
>
> For stx case, we should move the bottom stack value (6th argument)
> to r9 and pop the bottom stack slot (8 bytes).

That doesn't sound right.
Passing 6th argument should not involve stack manipulation at all.
No push and no pop.
