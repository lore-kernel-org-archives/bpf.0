Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CE23DD50C
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 20:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782334745; cv=none; b=uuKH2BdboEU0QiCXC8Cal+7QyD1ky4yAaTl3GrxGtrAZQQy3JjgYc0iD1DpgtzANX/ljK80+13R3Yyce3uhpYonEC00KYPzMZ+PL3/MpaxwuzVnX6Eosnjuv61q5DtE8FC32CwYWi0Ugna3RAzA4gBBAmRr9nUu30aAd7+Sfwd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782334745; c=relaxed/simple;
	bh=EBkFIJ93p7H/YLvd1bjDixSjBj1WJcUuUZBZooQYb6I=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=H0aWgA4AJkRkxf2DIa5JvldVKAxX3GA0dJ5psc5+HFzG+1OagJDVq/3V4RPbnkSxae2ThOM84RKh5p15GLp0N+4edicM50eF9F1zc3wptCmlWsaADSDL+7D71sJjxYCMzkvkYWt2rY3gN/MS+AMqicjXjFlRGWE6lnoinFNb5ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEu8tmHw; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEu8tmHw"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-43d16405b54so740833fac.3
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 13:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782334744; x=1782939544; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBkFIJ93p7H/YLvd1bjDixSjBj1WJcUuUZBZooQYb6I=;
        b=nEu8tmHwx2U1PBAEVk9SSfaKDiWHpWY0GgE6lK42n19VrwT9Yhbx3bqUjkJlvyV6e6
         McKV/XKeL5WVIq5rbaObT75GmdM4C+cuolkcEXQ6+pQJ80+ClZws1fyHkABkBo3Q7koP
         T4SQPvwKcW994KV3TwAQ7YlE+RUvL6z39EHjoA6DAtHh699CI+v6Bh0UhuAaQ4TWmoyi
         A12Fxepo3h5RNXzCp7lkr8rUQ9ydZarT/GpW567cP9s5Gd2awsVxDRpI5OYwzvsFx7nu
         z3eeYl4KzvslZetxr0dhx5ixvHwhXBwLTVz/xANyimNjvKc96mpbS1Mykys45X1RtbG+
         KUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782334744; x=1782939544;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EBkFIJ93p7H/YLvd1bjDixSjBj1WJcUuUZBZooQYb6I=;
        b=IS50Ru0edf1bBiEP/XDhnxeevJnzkkriMx2i+wMdAkgRfBR1Ar6xEMmv8h3bpZscPJ
         8HAVKmysNTg2BFtGqGQtr02tC91IRNZaN10vw0k55EleviBE0e6C0IrFD1cb2qAxo1nB
         N/Cj9FZPdzUVzclzrjwUB+du4wXM4XeO9nAJpIlV6+IiMraqFNvjls42NiE9Nnym4wK2
         YQU9Ml+ATD7QKLU7LePkwX4fYXZVMNyuSQEH15x06UTT1aacbHfchjs82zsF77c9Ueua
         saf50uVQExYocJLuH3yqoZpVBMeuVCjONYRkURlHrOk9kkNnmsWE7wuaT25IWcFySqzX
         RVzg==
X-Forwarded-Encrypted: i=1; AFNElJ8dziGkyaHCSjqWveTxcR6eeLnX4F+1ma9L6S0VOLaecQ69fy84mRmW1fBabYsl1VN8QrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyoOp1Hg3vdJgmHQd5x03yUOD6KZxgHalnFOvBMlHQg1xs61zv
	n5JdR83HOXZT20raaMvreOXipUFxc9vhDMk3hdIiGlhQrGuRbRYx1xz2
X-Gm-Gg: AfdE7cmeyFdIr0MLQ8kh1e+iQWZVvAYX04pTpRySZ7qx4RY5moEq7tVPH3XZNtC52hr
	kF0ZxIkivVtr3o+72gEWfgRk776YHjIDqWp+gjzp3JZG5d+6KuhyH8zptiIz37hmVGimaFLKxv5
	U+dV1m/6mraPgGjT+1uB3E5h1FyZtfY8RiJv4U3cMfPral7Jjws1a/2S9+RH7WraNghIIDZh6wT
	aBGheZ0H035Lx6rYsTxZwcBaGLZC6B/SOEFj2jxY8w02kEdG74zkXCvcPRMT9AdJmBThVIzi4DK
	iJQWfU18PYTHL2EeLlpHwYrCpugn43BeEhVnUE1meXPvp3p0Sxq73c81GRq07XnmCdygEH0532u
	Qg61CD9fSkXlbnYZ3r2pzvbEvQX53lULdoKZGuFIDHkym3TimnDuvOIgB4vDGf0Yr5OzdVloLgs
	p0PcJKbtAIvKb6RqBZ651AyHa9nc03XkMTjCVwcAS5AfN3Mmw+dYcUlTF1iZrwJ9EpIJozfyBy1
	GTYGQ==
X-Received: by 2002:a05:6870:f28c:b0:447:48b6:83c6 with SMTP id 586e51a60fabf-447dce9c2efmr3673260fac.24.1782334743603;
        Wed, 24 Jun 2026 13:59:03 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472efb37fesm11646096fac.10.2026.06.24.13.59.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 13:59:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Jun 2026 13:59:02 -0700
Message-Id: <DJHKXOX035PB.5RNR3ZGIELZS@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Sun Jian" <sun.jian.kdev@gmail.com>, <bpf@vger.kernel.org>
Cc: <ast@kernel.org>, <daniel@iogearbox.net>, <john.fastabend@gmail.com>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <emil@etsalapatis.com>, <shuah@kernel.org>,
 <laoar.shao@gmail.com>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf 1/2] bpf: Preserve link info metadata on ENOSPC
X-Mailer: aerc
References: <20260624111837.889209-1-sun.jian.kdev@gmail.com>
In-Reply-To: <20260624111837.889209-1-sun.jian.kdev@gmail.com>

On Wed Jun 24, 2026 at 4:18 AM PDT, Sun Jian wrote:
> BPF_OBJ_GET_INFO_BY_FD for bpf_link copies struct bpf_link_info back to
> userspace only when ->fill_link_info() succeeds. Some link info providers=
,
> however, can return -ENOSPC after computing valid metadata when a nested
> userspace output buffer is too small.
>
> For example, perf event tracepoint link info can determine the required
> tp_name length before copying the name fails with -ENOSPC. The current
> top-level error handling returns immediately in that case, so userspace
> observes -ENOSPC but loses the metadata needed to retry with a sufficient=
ly
> large buffer.
>
> Allow bpf_link_get_info_by_fd() to copy the top-level bpf_link_info back
> on -ENOSPC, while still returning -ENOSPC to userspace. Also let perf
> event kprobe, uprobe, and tracepoint link info fill their metadata before
> returning -ENOSPC from nested name buffer copying.
>
> Fixes: f2e10bff16a0 ("bpf: Add support for BPF_OBJ_GET_INFO_BY_FD for bpf=
_link")
> Fixes: 1b715e1b0ec5 ("bpf: Support ->fill_link_info for perf_event")
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>

This one is in "wont-fix" category.

Please stop taking AI reports and convert them to pointless patches.
Fix only what humans can hit.

pw-bot: cr
