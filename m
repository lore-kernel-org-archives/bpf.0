Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8C84F7983
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788539721; cv=none; b=hLWoojcjZmQk1wQr3or74klnQSsfrIsAHhsu29mGOkHre5BL/mQAahpQ0sl+MUsJvdLE76fhF7TR5qkM2sWRivfeWMsJeRj3ehcxnZkT2xNJse4jDIzgUJIi7MiF1g0SbCIUEcAQ6xs88SPMcnXUBQfof+mg1oB3RCezRljb/0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788539721; c=relaxed/simple;
	bh=gNzgQLmdkgkmMBhIgH6SXGBJt97loe2MqDImYk7P7h4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=prnV6yYXj4zgOvaEm95NUL/B3GuxX6ZkUcTK7c7E0Teq7otUskrsxeNw6ClS01ooGFeAAbscL+ZtFfczAUQzCYDFcZIUZaPIlx5gk97cnjS0XgEhHmUAa7D+DrG7UHwrY3QUbyPhdIpQTTBVRMyTz4rqlQtqVRnJjRCl1AvYu1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GhgRrJbK; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhgRrJbK"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4b28d7c729fso972792b6e.0
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 09:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788539718; x=1789144518; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gNzgQLmdkgkmMBhIgH6SXGBJt97loe2MqDImYk7P7h4=;
        b=GhgRrJbKSJYAbHCaH+IPCtEvjG1Cw6RK0YR+9rLvMzhOe2WOkFifP7m4B1qdfkdJRm
         VU7c3jUWc8cXh9ynJMt46iqhCasqRs/QvIh20WIPb2HPQVWm1ZxxHFioK9/0sL+W76AW
         S55lsZ6ekD1A/Z5QAKTuprRigDcwDmOwEggaqsC16Ch371ombwNFGkfYS4pjSRQKnIGw
         tdvW2D/4JS7+4RtEvsnqaY7mjww5M32B9AciQtM1llEKHCKvQB9pssQahM/IKP0qLJka
         1SmleXwyQxgvLKp3o7/7repDKNhhNbTbI7UPd23dUtNlOVd0BIaw3iQDgKdw+7GjCCGg
         UifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788539718; x=1789144518;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gNzgQLmdkgkmMBhIgH6SXGBJt97loe2MqDImYk7P7h4=;
        b=Lsd8DcCNQ2TWPON+lnEotMz6ysPxyYPSgTfIDHWbePnrGaTuu+5RnE232QTQR9tEF1
         t31ni15m2yrWwhgWrDKZjfLBJDzRj0p3FVDYeQqy+47HkR4fA91RWOAsMZ/tgMB5zf+c
         jiKb1JCpWHoUIQyXEQGyCI9BXAceHi83Trh97wje+4RKIlUFxywBnvEosWnc2fzLZTqa
         CxY1rxwoKMQykpViv8WdkoTaOsssJWpBdML7QQktmqNbUFn8d1ENfYVDrqx0or949zjC
         kbJEoKlGJlN1ar2xrkMaNCNMQlr6DjgZT8oS+DWClMpORVDRe2PJ4HAeloilh/T/blAV
         8RLQ==
X-Forwarded-Encrypted: i=1; AKwUvBzYciolhrbxUJqiPGVPJdvCyupyMKSeH2ue9cFGiewNczBhn1Xk+bmz3qMSG83f2MZiKE4=@vger.kernel.org
X-Gm-Message-State: AFuF++luaT6/3EA73gS3tUEGgf/+jGobWgfYbJ71J9fRZderriNSoQV6
	69Pvs1VzJaohd3Y/eqDnkP11NisD4/xoLScf1O17JC3Ohs2oES4+zUgN
X-Gm-Gg: AYBFou01wHyAZ7ci5TQZwvgoN+ySIVeGFV8HeahHKgXsGrnwn6inoUGbx/d6MjJfPL6
	Wkq8Sh3MbAW5Yl2zMzwukp0QCxSfjune0FOOH4JFTyv14bNnBiT46QRIUIkxJExvwBS9Fz+8a06
	zYyiH/F13DJST82yu8ZVhq52OttxE88gcOueFiCodoPvdtk3QJq+GSQI85iuM+27zER3h8jmk/R
	yX+8+W+diuHxoj24DHUnOUK5C7t9WMvV4IPA7mL+SNwYpVjaUZWvI8BFrXNTP1xggu6TLQU8gh8
	GHArdFJoAtZEM6PP24nxyDISTLmBvk9is+XF8K+maJrdnpAMN7nW/1I2Q3Oz6aE/lqqbUobEHin
	GM5uMoWBwHgJJOYLde+RX03w10lRU4wOzSeUbt3Lslxs9+N9mkkcVq9Ur9JI8r3j+cofuNZTpzF
	bOvyMBKGTanPlaqL9dBXrWtypPc4ZVDaVs2Df5aKwEGG8DiQKuNIMy9kjwK0T/ls0BOe3JmuiUY
	TJZiZVFqx1kUlLLjf/91A5lSFtFI/e4HRNdpEmoqK8nP0I=
X-Received: by 2002:a4a:e842:0:b0:6b0:ab1f:ec0c with SMTP id 006d021491bc7-6b6fd1cc120mr5186609eaf.34.1788539718519;
        Fri, 04 Sep 2026 09:35:18 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:f06d:de86:9b68:17d2? ([2620:10d:c090:500::5:4f3d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a534d0asm8180958eec.8.2026.09.04.09.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 09:35:18 -0700 (PDT)
Message-ID: <40418ce913972dc14276a2e8954cd63595c5eee6.camel@gmail.com>
Subject: Re: [PATCH bpf v1 5/8] bpf: Mark NULL kptr stores precise
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Nicholas Carlini <npc@anthropic.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Emil Tsalapatis <emil@etsalapatis.com>, 
	kkd@meta.com, kernel-team@meta.com
Date: Fri, 04 Sep 2026 09:35:16 -0700
In-Reply-To: <20260904104203.345917-6-memxor@gmail.com>
References: <20260904104203.345917-1-memxor@gmail.com>
	 <20260904104203.345917-6-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-09-04 at 12:41 +0200, Kumar Kartikeya Dwivedi wrote:
> check_map_kptr_access() permits a scalar store into an untrusted kptr
> field only when the register is known to contain zero. Unlike other
> verifier checks whose outcome depends on a scalar value, it does not mark
> that register precise.
>=20
> A state checkpoint reached with an imprecise zero can therefore prune a
> second path that reaches the store with an arbitrary nonzero scalar. The
> program can write attacker-controlled bits into the kptr field and load
> them back as a PTR_TO_BTF_ID.
>=20
> Call mark_chain_precision() before accepting a known-zero register. This
> forces state equivalence to compare its scalar range and makes the verifi=
er
> visit and reject a path carrying a nonzero value.
>=20
> Fixes: 61df10c7799e ("bpf: Allow storing unreferenced kptr in map")
> Reported-by: Nicholas Carlini <npc@anthropic.com>
> Suggested-by: Nicholas Carlini <npc@anthropic.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
