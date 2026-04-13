Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C0331354F
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 21:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776116610; cv=none; b=n95rInV7C2nDwcUAJqNdbG943OwHYLT3Fn96FvrdRTpfYzpwFg9nLOuQbgq3nOzibeQYph5SKXs4A/4CDWfXWvgpaRG+YKSmXBDcUVsTg6LgkH/jxaxpILrXEJCk2sLz97BaPsswx78X+Fwa5tS5Ng5EHlAaOmS1fiRWMdslwzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776116610; c=relaxed/simple;
	bh=EkuZsIwIZ4Stmk4f/1zPkGvys8i5ZgOj583Pkaelhkc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BPps1RFqulZrqWw88Lhrcc2IU4odbUbzqpedNzeym6HchPAHkqfvSO2yHw+UJiPU5KZXccbltuj1vI/ft+TTidq0I/QOs8OjnJC6oBJDQ50wNM/vHsrixntEshxeb2646xkOdguCDYWfU9xDZ3K6KtQxpV+tGcWW8IFDWfXgbX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVFAOV7X; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVFAOV7X"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c70c112cb61so3159096a12.0
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 14:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776116609; x=1776721409; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EkuZsIwIZ4Stmk4f/1zPkGvys8i5ZgOj583Pkaelhkc=;
        b=FVFAOV7XsUXZ3TcpStjWt9T99AbclyyMh0H4l5jzw6Zg0KDD64r5rFlh2tgnLWuuv5
         vA2G0iuoJk0oIOa4fEdTDWXlJQqZy7NbjlKB3d8kxojrOU+RAmClqyPV12tkFmWxms33
         aPpIUOkNSfc0REJX8FbkVaTvZUU1kX4+G54ROqSzPQUUE/DLCuffnbA+uCPoQ04ckvWz
         wV3nujKi9lvHLta731OQ50woikikz3R5qLhA9UV884mngDXZb0lCMGoVuUhIlIlFM/R4
         mxMLMSru6Q3riZQEt6dlQBA+s+3HGV65Mb/tpA2GmegaIphEs+9YtLYviLnqUZ9yDg4F
         MaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776116609; x=1776721409;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EkuZsIwIZ4Stmk4f/1zPkGvys8i5ZgOj583Pkaelhkc=;
        b=ZspswjJQ/zGnO4F1n3Pbkr6adx66kNj4i7R3WUhvABG5DsHiqL87jvAe2NplstUAxS
         +NPmtiUaGIZBpC1ey3ODqC+0SAxm9ubv5HRUoDu419mmGn7ayzS9TSo0jiVgKXxZo/wY
         y6g8ZojnnScTnZGXIXkuOYHqF0x5vSsOu123c5jZ05/Tk13fxujDrlrT6hlC8YTymh2F
         tmCDqCICxNxy/8+Fz9tZfV5zO94pHZ41TnME86rDPS4nH3qgKgRY3wfX0mElsRTBBlXa
         dO1msLT76oeXC2GJmL3GU0NJacCacohapTcqrn+xC1sfUYXa1bYvO1I05xyx8oqE/1Ko
         Y2pw==
X-Forwarded-Encrypted: i=1; AFNElJ/RsCqX2XTEuFQohMkpaIdzRU0TgAp/7mmmgS4oh78WDPhTV/GVAIbL/pQIkJ5Dlv1BZu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBA19ztRGQPVA+dyEUd+0C9J1QIV1+EikMiSSO0oPklcHUUcXU
	czfSTvWPbUhiWNOUQngBR5nnPQ26ZUT9PT9HSUnZy4vsTyFotpRTvrtLgzZH5g==
X-Gm-Gg: AeBDietPIzJIe1bgR1g6KLmtLa7MJmc6KYF1E7GNsT5XdrdL8Wbd+XV7EZhc2doiS8A
	8CL2fjg6gvbDDWwR0LRZa1GsbEr5/5lLdhjEW/5lxtn+KMXuFFAdRLm/hsVg/iKhttw/uuqjTxd
	coh7LfPqGJzfN3Gz0xU2kTp6gdVbVs0IeI++XXFodctHIZopIlTr4WGuo30HJ5nlaGyMuDfBKBS
	RyBPUvuRlb7d+jerSG2ZOVn2CSijPkqi/WLGVbjfWKlw7xvmOAsEQsx9b+29yV/jDSENId4ALcU
	iKFnz1yEFXRkb/kVZ/Y4sxIGIHI9I57eORppjmK/9itcVXGeIMBqysgMOMAZQgxqutm1KDYiiR5
	4yiMOFygweRPyrwezACeYFFw+pZP2tDnm0HxGzcWE+Di1MTt72HCPuieCHVjszSCvmyeqllrYJs
	LUmUngAULcUI3+Ers3/Syfsa8w4AEDaynPNU/qkO7xVWEORUWFn1jA
X-Received: by 2002:a05:6a20:4324:b0:39c:4af6:4303 with SMTP id adf61e73a8af0-39fe3d6557dmr16500588637.20.1776116609045;
        Mon, 13 Apr 2026 14:43:29 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c20aed6sm12252069b3a.0.2026.04.13.14.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 14:43:28 -0700 (PDT)
Message-ID: <5258cc4b95c2c835b699598f0ce24b3a318b5bc3.camel@gmail.com>
Subject: Re: [PATCH] bpf: btf: reject division by zero in btf_struct_walk
 for zero-size flex array elements
From: Eduard Zingerman <eddyz87@gmail.com>
To: Dudu Lu <phx0fer@gmail.com>, bpf@vger.kernel.org
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org
Date: Mon, 13 Apr 2026 14:43:25 -0700
In-Reply-To: <20260413085033.71952-1-phx0fer@gmail.com>
References: <20260413085033.71952-1-phx0fer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-04-13 at 16:50 +0800, Dudu Lu wrote:
> btf_struct_walk() computes `off =3D (off - moff) % t->size` when handling
> access to a flexible array member. If the element type is a zero-size
> struct (e.g., `struct B {}`), t->size is 0 and this causes a division-
> by-zero exception. On x86 this triggers a #DE fault resulting in a
> kernel panic.
>=20
> The BTF validator does not reject zero-size structs: btf_struct_check_met=
a()
> passes trivially for vlen=3D0 structs, and btf_array_resolve() skips the
> overflow check for flex arrays (nelems=3D0). This allows a user to load
> crafted BTF containing `struct B {}; struct A { int x; struct B flex[]; }=
`
> and then trigger the crash when the verifier calls btf_struct_walk()
> during program load.

Could you please add a selftest as well?

[...]
