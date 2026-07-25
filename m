Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BB130C156
	for <bpf@vger.kernel.org>; Sat, 25 Jul 2026 01:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784944657; cv=none; b=Nv/E1GI7TB8sdxVLE1btZfgo4XViY/64UXLvfqgt9rg6JOSw8ZS+8fYHRHlGzSihzpOmAmEHD4pypLFXBAf7ZY071zXgdYumG8qbdruoqHY+HAoGWZgD7sIwtcMguCWLZwi/leL8r1KRPTkdNZuVgdT5Kkx1j8ffeyq0WZ9jRhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784944657; c=relaxed/simple;
	bh=ezyoiGRpuqCY5hHiKdgNqnkdCQ6lqqlJwadeN7XCdtI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gzaDiDd5B1z+a8SQav0ik0ifpVOln++Clj4ea+TFhXG7LuF+7jJez4m8jI9kWCCKoX+uxeZ5ABIaEUL8CATe4T1z2h52yOj7uxT704PYpJipRWtyR0F6V/KTMYHt4ffR8t02bbgTJWU+0rWi2QyZ05gOmwQksBnOaZKz4PokpE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Swx1+B+m; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Swx1+B+m"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso1377308a91.1
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 18:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784944655; x=1785549455; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ezyoiGRpuqCY5hHiKdgNqnkdCQ6lqqlJwadeN7XCdtI=;
        b=Swx1+B+mCqBN3PLJeWtvdgsa5vbls2xVQRkpi0e1vpdvUVMBthVrh2eY4JmYcV4fwa
         sMYW++ErclGSYbFHXK/Sw/uTLnhBZoxLrqFbSG6t32YFQXD2UHtcyRICdWVqiclqPbpl
         sWPwh2bV6+GvIJq6IdwmqIfQtvYyG4U8O22jrf7OE/KePcy+OjWXEy/fTzGeUYzljlTR
         J4NRiSykcjkznIdYzh6U2EsPRNGJlQ8SzqTjplOFJ3eMImT2I9Md4yq5QaZzmojZMqPr
         /aGhFF6WbtlKA0uipoVFsFLhn4i/XlLQFrsj301Wm2yTSvZm1qBa3mVYBgHIMyf/aKAx
         rdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784944655; x=1785549455;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ezyoiGRpuqCY5hHiKdgNqnkdCQ6lqqlJwadeN7XCdtI=;
        b=HPfIylFyu9CZZo5m7DX38UdzDlZE1jxSQEA6yOasujf4sR2jK0fSFKQmist+ecnrMs
         SECMuqNxkLI5CnIPip4ypRwdvF31NMfSL8ApvJrVGwbCydTjLA6dDNakem6Qw3qtkW1v
         WEJlYeRHV3YVu5ZMbYS0JaH8q49PCWePldlmrkua76pq32gEexK2I7mJspGIq3k7iHRw
         5yuMfdH2AKMXKpN2pSVUBMXu7Yr7D1MLNsqFE0FPKPsJzNWKYfogSlpbBn9U+hADNNj1
         s39/RMONQn3W8UmHk/WOvEBezCEcojzc5XNl+Kyl9lycQ73uQ9yBFiGEy/gCA7xqNP/4
         sV2Q==
X-Forwarded-Encrypted: i=1; AHgh+RokH8Av+Da8yNkNoyGiCu6O9u/zb/pztFNrd/W/fYHLKqqQxf0ZxmJkq6z7vot0bZA4PbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1h66Jqs1I4kIy16oufWE2cQUnoMUA2WP/LPQmn4WkB9Kb6/YC
	KUsZLnOtlXqu0xcMnm0DXuq6BRYZnQNSFchOQbSC0KlZ0akFk0ll1E0Y
X-Gm-Gg: AR+sD12dpFXfPZOSyi3zq0knyUBpPLBTOW90mDEe2lh+Ji0tJNag6uYWM5vMX+EWN8c
	agfie3h/KBue+yvcPL6vCBchHr/9dwOnEOXAcAXUM97QsUvM6OkoXvIbUAcHBr8Op4d7x9ejUQM
	WevnU2krpjjxOPcgOn38mTnjBNj6ChEjnjrhMdZtbX38cvHc3Zoq5v3vmbsuT3087t5e6hrNAbr
	3Jr6/GqMaP8eAtORidQKsA/pdYpugdXEkCyoGxI9GfuXQFZSIZAO1sT/1RmM0cMVmL9eijG7jxQ
	4/gDDEeHuUxIxzYK9FbbOzHeEY4VWHir8lwSuFTXFq+BEyIletJB0S6YqC8LPY/nrsM4z1rFy3i
	v6L6k00p0TI5hQTtcAMNR+S6xbPAkArKwfsYG3Lf2CGDkyguIcCV1X9GlZuwBXOBPRsFm6ocdNY
	nArlTAsePjEtRRFTKZSTMcmyuO3tK7xg==
X-Received: by 2002:a17:90b:1cc4:b0:38e:64b0:8bce with SMTP id 98e67ed59e1d1-38f296554c0mr699351a91.20.1784944655578;
        Fri, 24 Jul 2026 18:57:35 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03b0eabesm2362908a91.6.2026.07.24.18.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 18:57:34 -0700 (PDT)
Message-ID: <3b40c3c30db47998a146fed0904704f7b34278d3.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 02/18] bpf: Unify const map ptr argument
 checking for helpers and kfuncs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	memxor@gmail.com, kernel-team@meta.com
Date: Fri, 24 Jul 2026 18:57:31 -0700
In-Reply-To: <20260724190813.1458271-3-ameryhung@gmail.com>
References: <20260724190813.1458271-1-ameryhung@gmail.com>
	 <20260724190813.1458271-3-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-07-24 at 12:07 -0700, Amery Hung wrote:
> Both the helper ARG_CONST_MAP_PTR and the kfunc KF_ARG_PTR_TO_MAP
> recorded the map pointer in meta->map and, when a map was already
> bound by a preceding timer/workqueue/task_work argument, rejected a
> mismatching map.
>=20
> Factor the logic into a single process_map_ptr_arg() used by both
> paths. The bound-object name (timer, workqueue, or bpf_task_work) is
> derived from the bound map's btf_record, and the register numbers in
> the message are computed from the map argument position instead of
> being hard-coded.
>=20
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

...
