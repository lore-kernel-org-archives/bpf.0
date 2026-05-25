Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEE430C62D
	for <bpf@vger.kernel.org>; Mon, 25 May 2026 20:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779739554; cv=none; b=A8O4qHtUwY8u+bdimLmiDOQoE766PVn+wef/UUsWXi2AhsdeiXKPb/vxdxumsHL1owIIrgjRkxaQa60JQSg+MejHMobO3Af96eNwCU3iAJg5nu+RwavVhWi4W8Uk3HcpZsmGK6oVFM8w5GpdO3CK//XfVKApEim3+CAFGLjCerY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779739554; c=relaxed/simple;
	bh=rkPW3Cdeqv9wQi4nfuOYFp92RUiV4WUYASBKoneturs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fv6h011onO8NvH1Pl548j1UHbC5WSqIQQwVEcvfROD0Q+5YsIZNHiI9nOzaNxPmTYJaWybjq0ix3FIOu3VO75E68mXsSlENMk4QkoihQcK5la4hJCvsBBW9qvg6m/hZK2WzfeBABpf7UBZFff/rxQtMU39YVDADS6jiViacU6UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDGgh4SH; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDGgh4SH"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d7645adbdso6259476f8f.1
        for <bpf@vger.kernel.org>; Mon, 25 May 2026 13:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779739551; x=1780344351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ewMf2lmYWViyGSz6F+OseoSTQqAf210wOm2Pxo2UVZ0=;
        b=TDGgh4SHjVOIyRwBOpigPov1XvW6VXkel3zMVLxK/p9cL1NurYlCKZoUwmMf2l2l9C
         U2INUxKSlLBK2Z+Etfi5gWc7sWn9idjygdzWv3TUmreVb9iuYigeNfbI4T7koBX7CzIq
         HYD9RVhM68GWUrv5TmoZZuojbK3K9a1FgBI8wt1M+Dk97r4C3qZRj5Vh2r+koMjOmnmE
         XO9hjBCNmTgb13n5LAXd7N0P5XLgYPwDnzWoXsQ9ayMtQXJqQN+Rv7H93i4Y2cmOBrIp
         NbUSoweL1iKuwFIxFuzfIq0nw6eQlirjToDDREDP0Tnpu6P33pXrmTVn9C/+MRwr+hC+
         bnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779739551; x=1780344351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ewMf2lmYWViyGSz6F+OseoSTQqAf210wOm2Pxo2UVZ0=;
        b=tLm7reeIPHisqxod10HmzCgSDsQoc5ZuaojuE/cO0I+nxZ6sITzr0tslIHnBux6uvJ
         6Hipr7L660S3EiyL/6Z6L0rkoDblIFu3819NHT98Csr4RmJ8eCYwMJYsolT6U5lzzrEc
         9xGcociS7ySRTmpQyUVB+N0pakBETpCC3zDugh7Zu/jfkWBCvXXI3RIcVqbhgLmGBFDl
         PBpRBGSEEdW+JHda87wI9MDvppPBhSHaWR5Aj31G5JuLY5tUnUSWvgCXgPpgKLt/bVi3
         78fvCqm7isS3Y5h55yN5mrbpUiIXsq+OMDuMz04xCgSvFmpMFNlP6b0C+KPVFB/aBXpk
         vZtg==
X-Forwarded-Encrypted: i=1; AFNElJ9zfSWD55TIPC9GljlTdmNWwzki9q07URAvjG2TtGw5kmpi0MOmMCXu4NrfWkE/XPWHIck=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQEZDjEwwJxTPm0fyjWcCnFhxwpHmwAg3YHYJNqumCZbwXWctG
	YKKBtGcGRWSlEOhmVtV5fxjgfR8dgLc4mkL4mojZjI4IyNt7T7llo1KR
X-Gm-Gg: Acq92OGe9JVIey6OnaA7u4biu2OUpeB3BlYIuzl8LztcANlONb+cT2wUJELQSGVfguB
	cWEy9WFlbOQLi+9XmCIhl6nNgaVzxNTFl8sEJIyf83N7NydNQUFmHvkKpoZ//a1fPYJQZCBf1Vj
	m/Yhx2cxgUTlC3l2DRZxIpBm/Hm+3YqzcdyaU8BuEX8Ior+IZ5fohp+CePFc7fWCqoaXFq0CWl6
	BfGo1u0mqhotncQjMeN2PVjKzQBiuHgJqIiU81TJrf0ikacaVkUT9ogB/Lul3IAtfzJEH+hI3Dy
	532gfbh0doUcxd2bKEpLLl69ZOujcA5tRVDblKpzXg2YNJc+4LJGs52gvK3YueS3n8LoNHC10il
	fin8IdJXFkF0LpsoHtG7dlNOPYjTQ7du3BCFRBeNmZ/TfJFIJlQtrWiGX2de3zxaQ8RPV8uQDGL
	QW2pwF2fNux44=
X-Received: by 2002:a05:6000:2c11:b0:45d:b14b:23f0 with SMTP id ffacd0b85a97d-45eb38b8a19mr28370921f8f.15.1779739550858;
        Mon, 25 May 2026 13:05:50 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d4903bsm27391548f8f.21.2026.05.25.13.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 13:05:50 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 25 May 2026 22:05:48 +0200
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bot+bpf-ci@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, kafai@fb.com, eddyz87@gmail.com,
	songliubraving@fb.com, yhs@fb.com, menglong8.dong@gmail.com,
	rostedt@kernel.org, martin.lau@kernel.org, yonghong.song@linux.dev,
	clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv5 bpf-next 06/28] bpf: Move trampoline image setup into
 bpf_trampoline_ops callbacks
Message-ID: <ahSrnM9nZdZFQXGE@krava>
References: <20260417192502.194548-7-jolsa@kernel.org>
 <8a315de2e20505875006c4e32af33c0838000a79484f7a2e44b1081187a01379@mail.kernel.org>
 <aec7d0Z70WKqC1b4@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aec7d0Z70WKqC1b4@krava>

On Tue, Apr 21, 2026 at 10:55:19AM +0200, Jiri Olsa wrote:
> On Fri, Apr 17, 2026 at 08:10:25PM +0000, bot+bpf-ci@kernel.org wrote:
> > > There's slight functional change for the unregister path, where we
> > > currently free the image unconditionally even if the detach fails.
> > > The new code keeps the image in place, possibly preventing the crash.
> > 
> > This appears to be fixing a bug where the image was freed even when detach
> > failed. The bug was introduced in commit e21aa341785c ("bpf: Fix fexit
> > trampoline.") which unconditionally freed the trampoline image.

actually the paragraph above is not accurate, we'd not prevent the crash with
this change.. that needs separate fix

jirka


> > 
> > Should this commit include a Fixes tag? The suggested tag would be:
> > 
> > Fixes: e21aa341785c ("bpf: Fix fexit trampoline.")
> 
> right, I think I'll send separate fix for current code,
> to have this fixed earlier
> 
> jirka
> 
> > 
> > 
> > ---
> > AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> > See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> > 
> > CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24583317711
> 
