Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2BF47605F
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 17:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784656406; cv=none; b=OXLKYQXv10rTP/4xATtk5XZrOvNC4xgi8LDds1LViWJIabf83N67T2bTVvTfmds0VfSk4sHCPeOhQqP17yjA5uTOWXJHHTiJE4Nl1dx1B0UhxKWCs5Kq8bv6lfed831E1x7LQC5IQU6sn699vjpamhiipV1ulhi3R/+Wt5+meo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784656406; c=relaxed/simple;
	bh=9bOIQfOIO7jUxR9USLLtIp5kwMZB+FXuWw9uBz+5kkQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mydLyHRxkuXCvFMxZEYqJNEn+n967WKIpxv6aEXM8lnznA9e9BoeASBu3EHFyZ+tunxXkukcicnPtcalTP4265AyHoHk0GGmS+geBQJbyG/R+wiOgweByXMediWAD7Z6z17YUaVmM5lH0hgr4drBpbTg3qsL37tr/0oVw80ZOLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OksEfLxq; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OksEfLxq"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c9c26a5fb98so3408004a12.0
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 10:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784656404; x=1785261204; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9bOIQfOIO7jUxR9USLLtIp5kwMZB+FXuWw9uBz+5kkQ=;
        b=OksEfLxqLVjOYaJ7uLsP4njZR92BXiSO2XlkuqRXIAKtNMqKy1msGz2XsTSEU8W1i7
         VmyayyTwudAcGZQp+5lAKKnCWS2N+INtrVIhw7NG4+zBb0YngFSzhsZNy5PbYSzwO6Xd
         eNNy+F/vqywnpr6c5TOWqT5cFAYcc90Mpaqlk/y4uMOr9jssywaGReOdUB9+LCLu1qRv
         x/TiZMXrfu4MYjEUV9YjAVD46033xmPGZNuyN/dvhYvrxy/9M6+1VUeiM5bWRadmZ3Y6
         mAlMcKlDktI3kmDN5id4fAU7jF4HuQR6lEDfiRZQ5CmHhkByYr6nZa5WjIBlBlLXVI6h
         Kasg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784656404; x=1785261204;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9bOIQfOIO7jUxR9USLLtIp5kwMZB+FXuWw9uBz+5kkQ=;
        b=VtLdMWo98Sta/KWgDZQVJhTFHdnzSSFynT83FQ70TfS7QY3rYDs+CK69EB07iCmVSC
         9qjZJxbl16kQa4ssIpymfp+P17lYbFXwx9Iy9PEIOZJIGIkSjJmAJjAHy/ZtFzkryxDu
         gI5RYH+YKXMce5gc8Bxem54oM1ECFcnyTZidunS8GZS4TEj6Gmbc20djhm5DqSxaK5xC
         HsH2kvElsYYZOnSY725izzwkjYYrURRaYK0QrSXA8vdxiPDY1YvEEtWh/5aMm/Gy0ONe
         3L6LiwShPWdrrdUZ8L4u0jvZaWBFgNN/e3GcYU1+qGYEboFH2G8frmjrDWIC/vLRPg2k
         Uqbw==
X-Forwarded-Encrypted: i=1; AHgh+RqHbkmNOMr6SaZZouZVKQZ+JzD9+T+cHpmUVSKSrMK1sj/BqmVzMuYJQxzL1c4gZSNRY4A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz+JfKoVYL1GqpSQMgvbtR05p0aTwZR+T5FYi2R2O7b87lZnmQ
	d4L8wn9UJwZd9fciTTcd9vxQoDWSuY4enJFp0n+WiDyiV8WlfcMT3q3X
X-Gm-Gg: AfdE7ckzx4r5HOAUFsPeBQxVWrwmcT2HLLE20o322OdiUrGkamQThcUjjFHqN1Xty9E
	BfU2+/Bg2GCp1zzLEbOQDUgaKkk+WAnlrh+rssorNfjrNVp2tz+H0Nrv58j0Io8yBGryeJpMgR+
	T1nUyMajugNvBl+1Z6UxSOutqSUv+IpeGDUtJrSejLBQgOwg5Rkwbv3XstBn5z7glifWRHlgFKK
	iIJPQcc5fp5gqnz0AqGhddieZJzpFVxje3muAxISxp/o0j4eHsbxY5zqF+8TX4c7PvG9mbj3m7P
	i8JX/26lDcwSkX7px+S2AAXXA+2o71vDz8R8qQjyoQTUI2eTiBt3twt5RgipAbeOFPlIUHzhUAL
	L8KwaR30pyn37sA8/95Gl4GYoKIyu5gkssq4Li0K9L0MveaRfpgaax37Ny2RWL/nvu5r/+NJ54q
	19QxE5ghEAT8hI2Esyq+gY/H6LdZ3oxmc3kcwhj8XdVn6WKMo/0YQHw6kZ
X-Received: by 2002:a05:6a21:b92:b0:3a2:c9a1:2c26 with SMTP id adf61e73a8af0-3c42921e59fmr624315637.7.1784656404389;
        Tue, 21 Jul 2026 10:53:24 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:cda2:e912:7f2e:f787? ([2620:10d:c090:500::7827])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e1bc886sm818227eec.26.2026.07.21.10.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 10:53:24 -0700 (PDT)
Message-ID: <5e3a1732ded365c5d8fc2363baa91d248f0a03f6.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Allow bpf_res_spin_lock() in all
 contexts
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Tue, 21 Jul 2026 10:53:22 -0700
In-Reply-To: <20260719113551.1294284-2-memxor@gmail.com>
References: <20260719113551.1294284-1-memxor@gmail.com>
	 <20260719113551.1294284-2-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-07-19 at 13:35 +0200, Kumar Kartikeya Dwivedi wrote:
> There is no particular reason to keep bpf_res_spin_lock() disabled in
> tracing programs, since it is safe against reentrancy and deadlocks.
> Remove the restriction for tracing programs covered by the predicate
> is_tracing_prog_type().
>=20
> This is a prerequisite before the definition of is_tracing_prog_type()
> is updated to include raw_tp, fentry, fexit, and fmod_ret. Existing
> tracing programs will be updated to use bpf_res_spin_lock() instead when
> it is available.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Talking to Kumar, tracing bpf_res_spin_lock() with a program that uses
bpf_res_spin_lock shouldn't be an issue.

...
