Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D57184
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 01:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786585141; cv=none; b=JyoCCy/Je8YM74kDnGh60QnerDZeHg7s44tJZx5kkZhQLhqqT/98Arodp0QW8mBaji1JahFgJU9hPYOhuvBl3/YNmlHmoaqRYFWcGoVVG4UWvA3CH9ArrYzw4wEGNNHadaFMTwpExTxY5h/Cn0Dot5w4oqh4476z5QDx6YL7ezA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786585141; c=relaxed/simple;
	bh=RPutCC5jWNGXHSgg+HJ9w22JYejkHcTh7GAqg7OpZ+U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HPvgsXZdv4sx02/2zCzrDcLmWRW854hV54uffFKXUXZhv1CwHW5Xrl9HXs7S/FLSJ6NyI3/t5Jxl969IT3F5KixGCSiBomzPgR8hglvptYaXNuu61lQbDuSDBzck93CbwZC4+mrHhJmnWFdF0bn0sD6CbjbepueJgzrCg0T1scw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSAe9O1e; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSAe9O1e"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cedda2ce6fso10740275ad.1
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 18:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786585139; x=1787189939; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RPutCC5jWNGXHSgg+HJ9w22JYejkHcTh7GAqg7OpZ+U=;
        b=aSAe9O1eTuAOjkY/mIBLlEmhZL0n9zD/ObjKom5mJawAp1rJC0jhZqPRPBYGybBo02
         YQ92cENK2/owGhOtIZCHRvXL9yTYT+S2iEiIa2ggmw3Cv9RD7xIctOGGN072xCinDrWj
         zf5gYeHGTCtiP6DoO3F/MuSG/Bn4AYnDEP/6jv+QFyj/SAd/KAELse4NPI0+l0XonS2n
         BQN/SeuqSukdnrcvezwVjUh7wAVVQP2TgblmPGRw4SLUjMlz4IlRDFF7euxuTBBo7Oi/
         xZih8j7sh/DY+tC67iOmjv3igCW83rMT0K8nSZSzWLXpesu5UEMK47nY1XKGNH9T/1gr
         mgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786585139; x=1787189939;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RPutCC5jWNGXHSgg+HJ9w22JYejkHcTh7GAqg7OpZ+U=;
        b=UHyKBqiIgm/lkQ2bl6vKuV8UVMtsSzmKVRNJqKDBRm5TmNRc4ArFB9WW+u73Sw8D+z
         ho3CQorQsbWA73FYZktMruBl0ZYLIzFZIxs/3tQPDYHR6KPrcIVecNE1XJ6Ydexy/SEy
         ywpaf9d+L+Iv88gOUF9KUvPf30heb8/oR5WJeOg15qxU2FHrMKSD9iC2mPn+hkkExcV8
         jVf7lN+N5L5rsHjw8Cq7RJhp1od2A4oXVZglfV/43ln8mgsYXvcWiu8b7NoZtxGK90uM
         U7Nnfekvrie3BjqyQp5O6x/+KRgoKSQ5kRDBUjYbodVzu/5YKrlwfBeflkqA8tbLIwd4
         wlbQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro76WXhRTQZGFKfz7/gioylwJVYmH1G8GR5D/0yjNiEO4rQljVmAfuZC3vLy8QfGwCdpMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTaXjS2J949SIyWM1xxz+9Tl+nY+yGYTvc9mPTGmvuYbwMVZHz
	sAhaLWlq5jXFgaL5CxdHpTOp5MKtEQmLOWVexChfaLXuVPTrE0yMD4Ky
X-Gm-Gg: AR+sD13ztzPGbw7+rsIWO375zCnYxNphXTyI982tUdWynXpL3NSOEg44uQ3sS2U8o39
	4azEK1yqktXq6EB3Refvo299G0ubbuAKnrN8IV9V+gfQWcz/OG8hsSRyYDKXuY6BSsKxF6Z0pOc
	Orn+wwEhzluquw52MiPh2Bvx/Bq+eeGSBoeMga9Lb0CNTNyKspvbCqgZ8o12EYX0CMEPRSoCRwY
	SsTdcGqSlAzFu43zsaot3ghO9h6HDA/+nvgWUHW2/LOYDS2J1mcBpnTGOhnD7ibS3xXxo9fMnrU
	xW+7VDRWdW+G+/+qDAPHH0qJOPTyNlYhHTOnI6xViAeJntiiomQjnqYapsXD+4jx2Lp0zXT11nm
	assmiA/5s2A68SGBDdAuAx2M/akntsVo3rLEtWmvjOJZrzyy/uFJHBJ1jZoMcq34VZMO5SKVuN9
	YMK+vqaAK+B5a4Kketmw0G53apMjVR8XH/ykDwuZG7iVJfuof/wETllCx68EUft+Ak4bg8ik3RZ
	lI+34xtyRFQdYT2ZY42EB27sFE=
X-Received: by 2002:a17:903:2b0d:b0:2ca:9d5a:8b6c with SMTP id d9443c01a7336-2d37d57c45cmr27086305ad.5.1786585139039;
        Wed, 12 Aug 2026 18:38:59 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d37c4c8dd5sm2622145ad.71.2026.08.12.18.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 18:38:57 -0700 (PDT)
Message-ID: <a4e7eebf34507bf3041f232561e6f0a8acd47d7f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 00/16] Redesign Verification Errors
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Wed, 12 Aug 2026 18:38:54 -0700
In-Reply-To: <20260812233326.3575958-1-memxor@gmail.com>
References: <20260812233326.3575958-1-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-08-13 at 01:33 +0200, Kumar Kartikeya Dwivedi wrote:
> TL;DR: This set reworks verifier error messages to include source and
> instruction annotations, together with more causal context, making
> failures easier to understand and more actionable when debugging and
> repairing BPF programs.

This series is in conflict with
14c950ac2be8 ("bpf: Track verifier instruction stats for each subprogram")
