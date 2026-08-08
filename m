Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A14141C72
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 09:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786183076; cv=none; b=uAo5oma/P73cRIk47trqPPuuVtjw0CwjNRLxoeQzHW6bWFb7KuYKSNFJWxCw321J4xm07ubCfzDaBUH8JIfK9McCZ122W+1M9Oud6dVlvZWaqMmUb0UQqIoTn6YPrz4/hdkUDdhAEt9ZQPYwzTEluGlBijoclZrOAlaIE0OlN4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786183076; c=relaxed/simple;
	bh=kRfUuecHeqAfeBfUhk+A4z7NOabRibC5BBKZvcBPEHM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hKHucQn/+OIphLvxEfLuVskeiLnciuatUQzsobQhS2WDV8TOVFMHsEsIpULx7hqRvwoqbsTZzOkIQ9qfNRNCySX3rN0z3+tFrepyRYP7biuDhAHW26+bV6IL3ihSeTcWcVmnFcaHkZatLpoBqkKdWAim9qqnlqd+KyqNHKysVRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5G3jNku; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5G3jNku"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ce98cb8165so2985975ad.1
        for <bpf@vger.kernel.org>; Sat, 08 Aug 2026 02:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786183075; x=1786787875; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=kRfUuecHeqAfeBfUhk+A4z7NOabRibC5BBKZvcBPEHM=;
        b=I5G3jNkuuAaOGXXcmCRWHDiNGzCX2MG2AQCSi483LFRgX8t1ZTZ5kzyq/zggndpzPO
         TibVck5vW+Hbp6mQPQWG8q21lmIzOwYGvZWCCa2RkM3bvYOUbJjPxRBxqDl0glFp8IXU
         W8w0vgvrKXVbGTYhUJktUAHIDwYWsM1oU/kDabLM8U4TZpsukNIxjUV+Xrq1UWaWCXnu
         gIHhoZh4WECWJuOiSHT1bOnaN3VwbxVfqun5EYVom7eNU8F0SYM8uDR99wA/OXaDD1N5
         Gq9pByi/kTNKV6vo4zZNVNF+8NKNzxnLHGbYxcmPj8u1Cqd1AcS0I0f5iOw43wRc287+
         Vwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786183075; x=1786787875;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kRfUuecHeqAfeBfUhk+A4z7NOabRibC5BBKZvcBPEHM=;
        b=g2sTnhYuASdHIjIyL/PclV4Enn4ioZg2tW7pKJwvoLBQYefubsCGhdPtBj3HImXQvP
         Idgtd5QDsqYVUluJ+ijyFWf1Q6hcFugJyKHs7tSnaFQirSHq3gqoeQN8idBnLVQ8L68V
         7HAM8pbqfeCvdnlkowhCgU0YIO5Mt93oIY3uZLoTp8duFvT7AgPfRfq4AtvfIbLxvsOP
         JXSE+QputkDoW8/ouqmPcNvyrlbOzwjIe9kCLWHGaXwQrRjmj8t7uAuURMX0Nz2pVbg/
         tWya6+a0Xy8/tw3rjEyjvIEz4XgmW36/pR6BDfjVu62lCkhCz1EGMad14fRCSYsU010Y
         H5dA==
X-Forwarded-Encrypted: i=1; AHgh+RrzejyFPnuMH/zlNV5wQc4zAx2EcIc19nsuKfXYqifIxh5T+LPszUavdFwzgBMN3IZ7S+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2X6uWEDjJwYS4xLeBlfxmZrZAFrQiMRSZTfxDxY6R/mt0Zz7r
	3blq/iIjczZE/n09ynMcoL3xfjAC7PzBZB1d/tYbW/jAJwXp8S8lo0FH
X-Gm-Gg: AR+sD11lm1uai2bvXgzELSJUbWP4W/mjZJoeXt9scvcvXE298gDxxgGIeqagyWa8AMK
	sHotM/teEq95qe4sIboq0+cYI+qiHgJiIGusvT5snCpNnL9bpqHdvK2cqRAd82D09cH+aydCSYo
	wjyY4Xh1FbJbPWvlx2gWUYBbHECs11eQV6eUDnLHbRuUf3QDfe9YmIM44aBNdjwGRr0sbap0EA/
	1SvayEdStZIUT8XYXgydgb0WrvFPPSKHWcUGm00vd4T0yZ+Dka1SRQivAM6PVU7es5RQmLbN/xy
	ug08uo3xq/FN44YuE4N0o8gce7d7R9gsoXgAORqNQMt+ZTHKaom+BsN/ASrL0FNeSCxyL8cEkm7
	GvTE05a9CaQ+/vo7NpuHNS9ugIaM8mJxKKXoxoCi88NKpe9JTVxYn6LcBTSLxI9faIhEoW/UjCS
	aEPQzr01bYuYWpv+J0OUkXqcJ0aeiA7Cm28kT2xDwqcIZVIVtJZdVbDP1d5DgQFVSXeTOh+sTkt
	yDQtAg9wL9ktZhT
X-Received: by 2002:a17:902:e84c:b0:2cf:af20:4254 with SMTP id d9443c01a7336-2d2b2e5e10cmr53881625ad.10.1786183074700;
        Sat, 08 Aug 2026 02:57:54 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d14ccb0b2dsm17755375ad.3.2026.08.08.02.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 02:57:54 -0700 (PDT)
Message-ID: <184112d9aae234d626c8610f5d46bc9a4a81bd46.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 13/14] bpf: Reject tracing/freplace progs
 for struct_ops with arena args
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, Tejun Heo <tj@kernel.org>, 
	kkd@meta.com, kernel-team@meta.com
Date: Sat, 08 Aug 2026 02:57:51 -0700
In-Reply-To: <20260808003938.3486067-14-memxor@gmail.com>
References: <20260808003938.3486067-1-memxor@gmail.com>
	 <20260808003938.3486067-14-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-08-08 at 02:39 +0200, Kumar Kartikeya Dwivedi wrote:
> Reject tracing and freplace attachments to a target program with arena
> context arguments. The struct_ops indirect trampoline converts those
> arguments before entering the target, so a generic tracing trampoline
> would otherwise expose arena offsets using the target BTF pointer type.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

It appears a similar check is needed for kfuncs with __arena args,
let's add as a follow-up. (But we need figure out how to properly
handle these args eventually).

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
