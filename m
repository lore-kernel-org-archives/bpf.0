Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7803E1D12
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 22:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786919095; cv=none; b=IEAUjmn9uyPopPFVp3338qDz/hhrZV6uerWZCryJCsV1xp+LTWFdGp1ki0y1bBVaDJQDHyyejM8CIb7A5RwWkAoUm6JuFFhNRJYvLNwNR3z6sfhxaoXdv2bVRlPurcK9YlTGrVrFTymrEMP+kSu0KLWwGzTxybb+1KfyuYIxj2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786919095; c=relaxed/simple;
	bh=grL8NGYY8U0Vvvm9vVPteW8wTfo7rgYvTJ5cG+NxyiU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mtILDhMAcxy9JAXG65RVRVo5g1NKq3NzYObwFPy7hnvw8ZVKduo3uGUA3qBJJxXzRYQCaBW3XzSdkEOupnaHAO0tGA2KGcyDJhXqeWfjRu+rLH770GWZYS64vfpJyRcXAMQoo6pQRrMgnZ1qfnT+/BzgSAk4UuO0SBKpVbyDuQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=im1fLsfl; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="im1fLsfl"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84830c774a0so2333337b3a.1
        for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 15:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786919093; x=1787523893; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=grL8NGYY8U0Vvvm9vVPteW8wTfo7rgYvTJ5cG+NxyiU=;
        b=im1fLsflmk/D74Ha+UM9qLSBXakiIIkuMFTZkcTQFVIZ2ey9PCdLR0CXaI0W1IpB+n
         P328dzE0vk9STPOI4KNBxje6hbKWUEudXP0IQblcrPqZ3RoLEPuNQWRizK4hwmXXvc5j
         IjTGhcr388Os7pWh3C+m1dDEWmuXbm/oc5q2x2tHl5/UDqpP8Vc2Hv9U59E+rM/GwjRj
         Uoe2agnOM7+TvlnDEEtmiZjjlrT0zUZ0s/LMFRsBPf4NTBPrnwTFYHOTA2Ttx6KJA71O
         H3OPY3Qs9TlUCdww77Ko1NuojtGN1VXCauT/7rJr1dCa5iXcZl4F8Uho0fNGu/FUBApn
         V7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786919093; x=1787523893;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=grL8NGYY8U0Vvvm9vVPteW8wTfo7rgYvTJ5cG+NxyiU=;
        b=FnpGsfYUSTsWWNVBKh7oQrwneUgkTZC86QfKJWW2FegbjzAskBKudTUwUYNClOj10k
         dzHqXL2UubbvfskLvsU8SE8qFUbezerXgbOG3dS981cSanneTLjSVMdLfge7kL241A2k
         T+LPsHR4NbM3lF8eLYeYR8aELBloFCFfzXQRAiz3Z4/oOeJqqtTBnihR23lhWdQh+3pa
         1kKoQ6V8u39iXwU9IFeQYfZzMfob4AODAGKvc3KWVrLCjqH8GrV57sWSDZOar6euaJd1
         qzfbtGEu35qKpClR8wWGh7uaZ9h/R/m/7SXFnIIddc1VW01MoSj84S7QqFIf6QGGZLFw
         WYcg==
X-Forwarded-Encrypted: i=1; AHgh+RoKcTw1jT7XqWT9K13bTBX1UUqMCt91FeBT0QOS+0JZJLAdfTgn3BMqFwhXyE+cH55T5do=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIWULsLeg85X8jOhnNPnAhSnbHkzQj88Kt270mCYIpko/yylFi
	WgfyiIRi5kgPV7i2siLrHbbqr1FIvIRZkmE1QFV1k7q05BKBGHh9WZpX
X-Gm-Gg: AR+sD13XaZEWKMqBxI8l1eRpaxHTQJ4rXBbQD+E+Qymb1KOanSqsHKHrHIplNd1yCNq
	r669donfKRnhPnqakMK3gYQZvANp/cHFbY3QgMmHiZxuE+ZZvXXl9fxUlU9myb8adSjK2zWOmWx
	2WoIYuSfUf7CqrUGzh+HBG994GafJ4epMEZB/Dh0SHBpaJV/uPl9l62Sy+Yapbn+GpRd4Mb6YPY
	MXJCoEUuN0SopqkxVhoasvHlsIMTZVpX8fuzCAmwL7QmCQ7sBexscIgjN3vCB22unkYMNjEKjt1
	uzWh2cGlPGtBW8gDxDph2r8p2o2eqyaJ4GNK+7x0NXvDDw7LFm0riykhshoicYrllz60RGvCIeu
	mxm14HEFfMyi3fYN67YPLNPPb0kKEq3QbrX9z2Hrw2ZEs7MnPTLROMQH5W7JWg6lh9siPCSQHR2
	rp9VnUfkQ19e4e5hOXJW1UfwR+z56HZOEMbHEdimOkkmz1cLufZIfBzoltb4JEcBZgzIKk+YuvY
	Dfn8iAFV9poJBwj
X-Received: by 2002:a05:6a00:399a:b0:847:9267:2104 with SMTP id d2e1a72fcca58-84fde1cea2bmr19461653b3a.12.1786919093010;
        Sun, 16 Aug 2026 15:24:53 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc095a1fbf2sm2623526a12.19.2026.08.16.15.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 15:24:52 -0700 (PDT)
Message-ID: <2447337fd08c971d7f95f4b4589b85f182c4bae5.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 6/6] selftests/bpf: Add tests for fault
 prone loads out of RCU pointers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: memxor@gmail.com, bpf@vger.kernel.org
Date: Sun, 16 Aug 2026 15:24:49 -0700
In-Reply-To: <20260814215301.709827-6-daniel@iogearbox.net>
References: <20260814215301.709827-1-daniel@iogearbox.net>
	 <20260814215301.709827-6-daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-08-14 at 23:53 +0200, Daniel Borkmann wrote:
> Cover the two loads which used to lose the BPF_PROBE_MEM rewrite, both
> reached from an RCU read-side critical section.
>=20
> =C2=A0 # LDLIBS=3D-static PKG_CONFIG=3D'pkg-config --static' ./vmtest.sh =
-- ./test_progs -t rcu_read_lock
> =C2=A0 [...]
> =C2=A0 #332/1=C2=A0=C2=A0 rcu_read_lock/success:OK
> =C2=A0 #332/2=C2=A0=C2=A0 rcu_read_lock/rcuptr_acquire:OK
> =C2=A0 #332/3=C2=A0=C2=A0 rcu_read_lock/negative_tests_inproper_region:OK
> =C2=A0 #332/4=C2=A0=C2=A0 rcu_read_lock/negative_tests_rcuptr_misuse:OK
> =C2=A0 #332=C2=A0=C2=A0=C2=A0=C2=A0 rcu_read_lock:OK
> =C2=A0 Summary: 1/4 PASSED, 0 SKIPPED, 0/0 FAILED
>=20
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
> =C2=A0v1 -> v2:
> =C2=A0=C2=A0 - new patch
>=20

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
