Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC6639AD5E
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 21:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786050628; cv=none; b=e+8lHwGTKF+lnCUouY2gGYR48InHWqx8R8H4L+U7AHyyDbwNhFDaqWdFoXkn0htxNRNCH5A/1ySDad7ZnCEcRSr2qaBTeF4HaXvuire5WSxf6exnTO3MeAeX6mKW/IMVHy4rsT/jgF+MnCE+8dov5SNLcTOneMflqxVBT2JObcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786050628; c=relaxed/simple;
	bh=X/1/nh17iAaHSSedkWuIlxe89TWYv+7E/dLNS0ZMXnU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OxZby8gFl7eFk0S/j/H4Jm/jHI6jYfOEj4fD4lryX5NFKzn2Qw/ETRuOvMSw9AcJKuoXs6vNTkv8bo5JZVxW1jYELo/j/MH7cVUIkvHVAdw0/kEi1seFviZKZR21e0MzUlaZuCnZcmzcM/H/YVa2BA8o71JesAsjN+eOi+f2Mss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=saiYDMm1; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="saiYDMm1"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84a652535dcso1830371b3a.3
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 14:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786050627; x=1786655427; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=br8sc75nCicYG1aNbpfZEi7CdGIV5zpF/CKA38+JJPg=;
        b=saiYDMm1PZWYfCDdsGilcBSUJYgidovfphvtOipUnPmcmUnZ1baAygqR/RWm7U7fTh
         SSbUVgzc/lWojDD8BsSTuNYXPvmR/Ip2mFdb0OFQKoVmm00Z6OlPDuRRdPkc+KBZHN5Z
         n5wYqjalxtdNQqfAPKp3uxzgfHAa967yLriPihnN6HxAp/R9ehD8vSM36UQ1EHSCrw3/
         RnE+m2sBH1T0U4z9JAWimaYKDBWttedroNFKVpN23b/JVitfhj43VAkWl3UdAKDA9uEV
         75YNnuY6fD2ib/J/5wvv0bbQ78yXccm16lBRncxtCcI3hMqsC9dw54iwArL7CYk/uCek
         zNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786050627; x=1786655427;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=br8sc75nCicYG1aNbpfZEi7CdGIV5zpF/CKA38+JJPg=;
        b=P5jM2GAZo6Q5ks8IzIKPd8t9m2kILUZmHvkx0T/A0hq819jDrnoEsTSF+ZZ8Ktg8r/
         cDCRGZXW3AhEipzIAEAaRW+Kye7Epu1W8nlcRZoBEwgz6JGlxXRTi8cDKzaeUjRrMkU4
         V17g2Tu17vbeULhRSqtxH+kA6Lt58K4E9miLxSWqHgwO7dlIz4r2IiZYpIPd5aqEls3W
         D9tY17cEuNbynJR3tN+iNw9OE4W6k95d0p5lgUoKblkMdc8AG5HfwdOR78k713M52sT5
         nO1UQmSym5RRfh5gCvQzrjp+YG5s76tW+ZRrd+MwGWtm7rFB8V4d5wm1kGG+YzKpiypE
         KBTw==
X-Forwarded-Encrypted: i=1; AHgh+Rqgc+tP38byKS71aiY4EqF8GM9xWaZ7ERRiImpUtRUS1NgBixrQHYMfNUdj1hGDKpo9StQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqHalhBLsPZDi3gVcfiPsXBPHUJoJxzC8C1QrGVRH5f4wKPGq4
	DuBItgwivRRug6wlBjtGqyP45N/thr81hiqddad1CibUCybXPV/Cz7Zh
X-Gm-Gg: AR+sD12V6M5rEaqHKOI4dMyngEFshrBv4OWar7scuTMVsIcPnhwc+1peH3ZlxWzlqw3
	UUrj6rIjkg0FfiZ//tblVE1Nqo0/zkZmtt/T4GL+VOZ0FnWSG5ABKG8nOsQmE/qbNZi+e5rKIk5
	78awsrL7fCz2i5qOXS4eJ2nZwUJQQxYFvncwtjYKDzgUhGCHTweyoJuAkdPWhkip0brS2Gs8aVA
	1aI6gvGujSxwBlChoZV0bwveSjN1UWuKH5amYEGQAJR45zrmo3yQpn+jyK30a2AGTDm+CGYOU6d
	ANebf4gdGa/iJk2elH+XcTpPuGj6zESzsujslm67Lbe1ZEAdWYXpm4IcDL7bG1ffsh5P6ZGs5y3
	oTg03ZCQ9qmhEITh2Y4CywipUTad6h9VxIXf3DJWteQIGAUCm8It/zp0ma0efyFwv7VZqiAUIAx
	BILJIYAOwy3uI4rvcs1g28DO+IkG85uypEQsrZmsA7uEwNLZPqzQ7tMCank+bCUn9mCyI3+Eiq4
	uaCU/7HMxZmF8dX
X-Received: by 2002:a05:6a00:32c3:b0:848:47d3:47ec with SMTP id d2e1a72fcca58-84f2e0826afmr22167939b3a.31.1786050626677;
        Thu, 06 Aug 2026 14:10:26 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f456ba8b7sm2077640b3a.29.2026.08.06.14.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 14:10:25 -0700 (PDT)
Message-ID: <8818323417f335355e02d7e10d220ef2ff370c0e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Fix sleepable context checks and
 remove in_sleepable helper
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Thu, 06 Aug 2026 14:10:23 -0700
In-Reply-To: <20260806164049.3158887-2-memxor@gmail.com>
References: <20260806164049.3158887-1-memxor@gmail.com>
	 <20260806164049.3158887-2-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-08-06 at 18:40 +0200, Kumar Kartikeya Dwivedi wrote:

...

> Several call sites incorrectly used in_sleepable() where
> in_sleepable_context() is required. This allowed sleepable programs
> in non-sleepable contexts (e.g., inside bpf_rcu_read_lock()) to
> incorrectly use sleepable iterators and kfuncs:
>=20
> =C2=A0 - check_css_task_iter_allowlist() returned in_sleepable() and
> =C2=A0=C2=A0=C2=A0 therefore allowed css_task iterator in any sleepable p=
rogram,
> =C2=A0=C2=A0=C2=A0 even inside RCU/preempt/lock/IRQ-disabled regions. Fix=
 it to
> =C2=A0=C2=A0=C2=A0 use in_sleepable_context().

...

> @@ -12083,7 +12078,7 @@ static bool check_css_task_iter_allowlist(struct =
bpf_verifier_env *env)
> =C2=A0			return true;
> =C2=A0		fallthrough;
> =C2=A0	default:
> -		return in_sleepable(env);
> +		return in_sleepable_context(env);
> =C2=A0	}
> =C2=A0}

I don't understand this change. The comment on top of the
check_css_task_iter_allowlist() says that it is about
cgroup.c:css_set_lock, not the current context per se.

The flags on bpf_iter_css_task_new() and bpf_iter_css_task_next()
is what should govern the decision regarding whether the function is
allowed within some kind of a critical section.

  BTF_ID_FLAGS(func, bpf_iter_css_task_new, KF_ITER_NEW)
  BTF_ID_FLAGS(func, bpf_iter_css_task_next, KF_ITER_NEXT | KF_RET_NULL)

Should these wield a KF_SLEEPABLE?

Looking at the bpf_iter_css_task_new() body, it uses bpf_mem_alloc()
which does not sleep and css_task_iter_start() which takes and
releases a spin lock.

Please elaborate.

...
