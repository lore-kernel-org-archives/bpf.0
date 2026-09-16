Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D83C49A3CA
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 19:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789585473; cv=none; b=DjEg9wVGxu8mrY8xeGs70kc4y1b3UgIngh+3Kzp5pzGl887EArItnzcy+6An2UoDSB6Tapoi9+Sifn1xxjY4OKwOauUiTPTZG+DeXIWcUUsM+dlH1R2vRpe/To6GdWJAHfCqVlhIY3DMrj4Sawhk8EgaJVcocOnmxPfrD5WLBqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789585473; c=relaxed/simple;
	bh=/4/WYagneTiyhGM8VRdhs1QUgfv35ZgBuU2YVifU6wM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cxdWE1UAZO1YUs5EE6CJEn0zt0R9ihcl14Eh4SyJ3AmFVPL1PR8MdSPD3OAcBIg+TOkHfSUo4J40eT/7yHD/hFOONr+cVFKCIjjmjIQA5PFM8A0MGV0lmfsnjWyBAlk2Mnjic1cn5NhngLBEEykh8zaHPv141xJjMEOaS4ksQwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jsmHy5XX; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsmHy5XX"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-398cb5615deso11742a91.3
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 12:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789585464; x=1790190264; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/4/WYagneTiyhGM8VRdhs1QUgfv35ZgBuU2YVifU6wM=;
        b=jsmHy5XX2zhgyHtXnjWy7X3pjSoq/erl2HgVRbv7mcaVkNGdNDdqyuB7Ej2/xaHuuA
         lwyAOkGFUy6xArax7y30r7aoZ+BYq5XqkYhw2QwXZqM/RFVhA0gB14/gW09mFjMTDEso
         lcTq27PN0caURVFMrJiWOFkmxNhdjGBR8vjheXhCWM6wF+cUTDUEFtS/+Mg42IMR7uNF
         M4E25S5rqwilLaLKRuAjenmgkaIi6ObtXYGbMS5x7c2ZNCUD0Tl78L4IO3znB2zw6kzM
         ekOgcM6hbJ6RnvQ7bxwcN3/2M6WUFuuuasxQV38Ghyd9R/iuQk0pTPwFe6NiCjJUS4ix
         RhpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789585464; x=1790190264;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/4/WYagneTiyhGM8VRdhs1QUgfv35ZgBuU2YVifU6wM=;
        b=gWaF6hOZI/WwrAmHnocFDv0QAORyi+2rKQgQRDdZqZMpS+23kW8HrVIgfznRpmFvbo
         SWKLx3iHx9n4EzDTw1VW2dUjthWMwpi94F/bTh/V4dqmPQz/gcGstera+8c2IE6uwBaN
         /t+bBBNrQtXQdG4X/g4tbFqiCdCYqZIpOgAh/Oi4jlJyeGHeUitRnlcDBOmxN947OHR/
         m3UUAgp/jJJ3jU0Z7v2N12+yvUCSFoFbmRkZC3FTqaDhv5H5pE74WhaHt/KqzfqWq4zf
         JCLmvK3eHWF/s6XsMxs9n98sl0iBYxMcY909mGRU/93LJFMSxb2H3d6OeO5aoWfkKDq7
         rs5A==
X-Forwarded-Encrypted: i=1; AKwUvBzt7pGpM8LisuE1SFgsKrIJPtoh3K1GN89ZXQxdhenPSOJXWJyBIm1g5TEs364Ew0UjB6s=@vger.kernel.org
X-Gm-Message-State: AFuF++lsuKlEBwZiOLyFvkDse6SaWUuuf+Sxjwe1fJFsS52n3mm4AE2k
	V9TRawLpvEq3PHLllJuhKm1fgu33Smb6eBxp6y2uVziMHScs8KuKCbiK
X-Gm-Gg: AYBFou1Lg37ZM6Qlfd9q5w3Urrqjh17zdA1K51KWc4DTv9AbcMlmEuqIelNJ0YC6oJO
	6sh8nPYs4UemPf0Jf2eeWgYyxSlcrR0ZyxYabA5Tedx2iTB45Ueb7O43d+lM7nEmXiPxYgvShr4
	IayAhfCeaygWBtXS8m0hMo0gVHucJkgphFVOB/TYIUwsvL/Fb+jKKaTv7bz7blvn5LqriHoON7W
	7Tma8BQ778gM8GwkR/UpxMm3GumeshpA75wKoJNmzHU79eiU0ROF+9+XP6Y3FFt/BKKrCeo8XQA
	PsV2Nk5YAVgfjmEjo5X2SjPe/Fq/+m4TqmDj5tVO2+hmuo6w8IHpUe8SCx8MOgVURDeCGA3jjx4
	o4H955tytCo1QC24oVYtjxyFjDP4oypHyAPwE6F/IqXvMMQSq62mGZd1gUhHkGqoUgf0SrKdoIJ
	FDE89flG05ki1eUpjVX4QQyI/MX3qp0Y/p20uwnq26RLurviWVVpeftV47xgzYJaOU74cIIDfnC
	DYG9T04c88VMvUhkXYgWNVZKUk=
X-Received: by 2002:a17:90b:17c1:b0:39d:e75d:f33 with SMTP id 98e67ed59e1d1-39e1e4c6388mr8014539a91.19.1789585463983;
        Wed, 16 Sep 2026 12:04:23 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e3617443asm838927a91.9.2026.09.16.12.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 12:04:23 -0700 (PDT)
Message-ID: <708c9ff7d777f76f26b56e95e132505d0fc7e8be.camel@gmail.com>
Subject: Re: [PATCH bpf v4 09/11] selftests/bpf: Check callback map value
 lock identity
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, Nicholas Carlini <npc@anthropic.com>, 
	kkd@meta.com, kernel-team@meta.com
Date: Wed, 16 Sep 2026 12:04:20 -0700
In-Reply-To: <20260914222514.1635018-10-memxor@gmail.com>
References: <20260914222514.1635018-1-memxor@gmail.com>
	 <20260914222514.1635018-10-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-15 at 00:25 +0200, Kumar Kartikeya Dwivedi wrote:
> Add a verifier test which retains a map value from an outer callback and
> then acquires a lock through an inner callback value before attempting to
> release the outer callback value. Both values can denote different elemen=
ts,
> so the verifier must reject the mismatched unlock.
>=20
> Also exercise callbacks reached through two inner-map lookups. The lookup
> results share inner_map_meta but may refer to different one-element
> arrays, so their callback values must retain distinct lock identities.
>=20
> Keep nested and one-element array callbacks as positive controls for
> balanced locking through one callback argument.
>=20
> For timer, workqueue, and task-work callbacks, lock and unlock the value,
> then pass it to bpf_this_cpu_ptr() to expose its ID in the verifier error
> log. Require a nonzero ID, following the existing lock identity tests.
> Balanced locking alone would still succeed if a constructor stopped
> assigning an ID.
>=20
> Extend the existing spin_lock test table and reuse its array and inner-ma=
p
> fixtures to keep the callback cases alongside the other lock identity tes=
ts.
>=20
> Update the nested callback reference-leak expectation for the extra
> callback value ID.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

If we are going to respin because of the ldimm64 patch,
let's also trim these tests. I think that only lock_different_value()
test cases are necessary.

...
