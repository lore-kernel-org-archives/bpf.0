Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A222E3C8C7C
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 19:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786909452; cv=none; b=KAPsYdhlZTq1Z4naYumHtzdzU/mZSNtBLZ0QDEEtgPx09xixzHFdNoSb+8qpQvUAPWFKdfSevL9Ja/qQy6f2XEw5WZfpQbMhtllgOxQEz3Bj3YzlCkgB86cBQ64aD+UU3pguscI1zEiZyoLnZy93YM12/EOqlDroPaqPUQKA+h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786909452; c=relaxed/simple;
	bh=SJJu9iTyPMJ4Vzh6QpdH22dd2FZ7mCSrO+94z4SP+LQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cbYqJrTAbzs5mOB9R66gIQ133bgIxssMfck+DeaXpkn0xNc6cv830zyLEcih5EVUTBoVnkwdyF7rZ71zKjijbzHl+24ZIwFfhDQRFjkj5xwlr/3CM73VkdkSYnXK+E1YpRK74uQSkF9HDvcCI+wzKrRULbO51fZRkL4dqLsrmBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3vrZ6QE; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3vrZ6QE"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so1983518a91.0
        for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 12:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786909451; x=1787514251; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=SJJu9iTyPMJ4Vzh6QpdH22dd2FZ7mCSrO+94z4SP+LQ=;
        b=U3vrZ6QEZ5bVPNJ7agrf4aaUhzomqA4m7hSHdH3/9+5A5o/AIlEJCXmrcBqpyRHN+l
         156S5r5YyfgqbJr3be/fW/hKVnmyvRIXrfy+sHyRYotKCZe2Aeyvww4V1ghGqxl/t222
         mYCp9ztBxOcnOMMceJme3fz+oQrvWmsjlHvIBbhlQfV7VsIJHirypzNNbW29pgK5JY7/
         beqg2lj6OIncA5Rl0SBwoyhsAI4pqPJ7nzKkYtEdcYyUG8p/7cvUwh8Rc25+rok0kWvH
         UBm+1ULpoOlK8VrKwrFtkBFfhoSSHsenrVO7oD4xqCP/uLm1tEk9lo4+yiXm4wHj5TlN
         ER+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786909451; x=1787514251;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SJJu9iTyPMJ4Vzh6QpdH22dd2FZ7mCSrO+94z4SP+LQ=;
        b=eugDMIBKGimksKKOAYzTcDCHEK0E8lmuneWRItzn4Xmrthb4LoVNwMhm6yRiWopMHn
         hpoj9AhZtYohTPh+2OHWl7APi8/TCTv/ksOHVldB/umxzkiocPqVsK8oPnb60qEcGl/w
         ONU1H2POP1r0gh6+F5HLBfGM6P3neMvv9Kh2BIXh5ztN9WvsZZ61oq4UaxBFKZCbDDUG
         A9B9sBGCBYyUrAVZIaxa4HmJkrU/WXg+hP5wvqUIiDL2mXlV80Z8TjkugbCzqoanUH2x
         n13Ap1bCKPZd7geYc6citC5PVyRY7s3WS2WAPqBu1UABN8XB6gA6eZVwpNI5QQvhr+mE
         j2zA==
X-Forwarded-Encrypted: i=1; AHgh+RotQ/SvwKFcsJKo7GkNEiOKgrZHWYPkrgcEvw2i293ZtIMfiP0BLHPtEsObqgeEFuS2+Co=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRhY8HruXy5tInwsTiBwMvoki6NqImyp4udAkswgBkrVvercKM
	zWODWrij0c58Z+VeEb62Vmgyz0skTBl4DGfuAApRkvhHJCF0p31pjasay6D74w==
X-Gm-Gg: AR+sD11VaRZ/C6aOjnuf4+WoziEv4Dnc1s25w1+jVXdpylSHESVDoPdvUiCg3+5H6pY
	PyqC+yTwmaKd96olAXjva8w9Ixc0AjU16yNgqMUvJyCnKva9JUFQOA17EBoJuEkZHbQDCrCO00q
	cFwzClQFeFzD9OfvFhk39L5OZhBqHYhRjI/f4Ewvb0aVOV+zbc0LMXP6R1wW82ua76DIQKDWUC/
	KmzorAnAg5XBII/Osja5+MlmjjlrcxygUY4rTGl37GOyPbmQkFCannIOvJS0cUCL2DWR4zgaYSL
	QOgZlZcCxu1iG08bRs68yFAlcCuqDfGVHzVQ3S0vBTNver3ieg+Pj3WMVi4TEh72vU/TJtug3Ax
	mCAurw90/edKapphqoLImyJLC0gdVCfTSsEinnVoU8lc1BSbmITzSMGJdmcJur0Evz//cKk5p/l
	LiMFAvP7jrkNtPwOQD/bNiYYe6Ccy61RZqLH8xyMJ+apu80MSw8Ji6S6Mv2trNoX0Md8Ygp0N+V
	gfvV68bDi/o65wW
X-Received: by 2002:a17:90b:37c6:b0:38e:2e86:ed02 with SMTP id 98e67ed59e1d1-3933b8f3573mr20973349a91.14.1786909451076;
        Sun, 16 Aug 2026 12:44:11 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531ee7d46sm2245753a91.16.2026.08.16.12.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 12:44:10 -0700 (PDT)
Message-ID: <b7cde4015bcdee1fded1ef47c1915187e8d9c459.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/6] bpf: Treat a fault prone PTR_TO_MEM as
 a pointer type mismatch
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: memxor@gmail.com, bpf@vger.kernel.org
Date: Sun, 16 Aug 2026 12:44:06 -0700
In-Reply-To: <20260814215301.709827-2-daniel@iogearbox.net>
References: <20260814215301.709827-1-daniel@iogearbox.net>
	 <20260814215301.709827-2-daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-08-14 at 23:52 +0200, Daniel Borkmann wrote:
> reg_type_mismatch_ok() enumerates the pointer types which must not
> silently share a BPF_LDX with a different one, since the type recorded
> for the insn drives a rewrite in bpf_convert_ctx_accesses().
>=20
> f2362a57aeff ("bpf: allow void* cast using bpf_rdonly_cast()") added
> PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED as another type in need of one,
> namely the BPF_PROBE_MEM rewrite, but did not add it there. Fix it by
> adding the missing case to reg_type_mismatch_ok(), so that a PTR_TO_MEM
> which may fault on deref is not mismatch ok anymore. The triage in
> save_aux_ptr_type() then merges them.
>=20
> Fixes: f2362a57aeff ("bpf: allow void* cast using bpf_rdonly_cast()")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
> =C2=A0v1 -> v2:
> =C2=A0=C2=A0 - new patch to address PTR_TO_MEM case differently (Eduard)

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
