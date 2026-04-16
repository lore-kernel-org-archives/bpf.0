Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D283E2AD00
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 01:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776301854; cv=none; b=gE1NgNXbCHb7Nub4hYKamSLwJYOnbyYTQvAeE2PkshduPmnL8cjPkeUOnZH1LLLwvJCVuq/SonbfEXrDtHqjQuBtj6DAn3Qqc4MtRKieQts0DlE7GObh9V0tm9tc0NIO33YJh/PNORBEP+5WqF1gxQO+ZqqWbjZWK8f+5hgqubM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776301854; c=relaxed/simple;
	bh=nR5KmZg+iOgFpJDYb0z/sk4QWEv9D2q8SZC1cx1KZSU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MYdXP1xzvB+DQpt8a8mcYTI6TIRYcgOipmAKGemjQfK9ojr62MgyhUK1YexJIbNldRbQQYftSnzxMCj3cW79I0dUhfvg++E7TTRxKE7RwHUN4YoSbyF3xHTplJpS91WF5bVJRnhXIBXW5EHatgaCjvsMgf+kawFWNyRDPCTAp0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EwNTSbNb; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwNTSbNb"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1279eced0b9so10857293c88.0
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 18:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776301852; x=1776906652; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w/2DhHX/AcUDzYaRkgycqJhyDudsJEwLnbM/jW01VZA=;
        b=EwNTSbNbgGpMI5CiJZkLEbr2p9VBnwqNtxD4apQW7p/KOT7QquiDQVJzK0yEPXi/Hu
         o20Ip5ZlDFm1n1qoyGXIAV6vfrWMOoGIKQ0QLELILfw01i/qDBbp6Y/WyIUCY+cuXRSy
         N5y1m4ktUepoJWohLTnwSPJ75KkePOO17HUqDkjG4Jpb2nyluPjUVZF134LHf4RAtgMT
         YIqWubcShP2Xh1VxcJGokt0N3vI6sYWLlTx8xuxdxwxGw/rKiBk4b3WAC9sEtaRHUUuu
         DT/HTEhfFfK0x4wqX2G0XH1qEGa7O+xO0Xb5kdnutn7aZyrik0rtZWcEfmVEImTmW8Wp
         vnUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776301852; x=1776906652;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w/2DhHX/AcUDzYaRkgycqJhyDudsJEwLnbM/jW01VZA=;
        b=nHKFjqxPI3U4yORxNL2mRTZu3v1SMGJqeANq45wNvimVoY4TIHKwtuCep8HoT/o5jy
         dGiN2XDTL1hUsRRnSeAlB1NTvbFVNa504IDGR8rDj+RTWltzZSkgry27duzFW0dcakEZ
         2yEg84kmeQF+2u1A9rB0a1lUtSFNVInLWpmoOy+Go4f4yEpuTD4/Y2cebLEmTjVGE/cD
         SYrkTdA2OomiIiztuSssGAQnf0jWY2nMiYanhqm5Gw4NwTXqMJ0Qff97wt9WQ3ibywCO
         8fKrtVUnX9GlFhdZt4H260QegG2foWLEQhwVK2AVM0SMocaznaoLN89bSAt1l7dr/ynB
         ZWbg==
X-Forwarded-Encrypted: i=1; AFNElJ9UwejY4G7Qz4WlbrHymb2TfUTT9tRmVhXDrLUcr94V5L8tdBlMnDPQ7sPoD8arvbJ9b6k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye8smtFjkRjwzNXsSrRjPojD2PjMnSqn4YHfqF0Q59MkZiYqth
	1lPE6AWJe+Y3ZzTy4HeG53UFe8LOUAjOJ0Y3bmNdvFLjIlW2UKIiE4/f
X-Gm-Gg: AeBDievr4gU3i1kGuCB9xw0qViVImHHX64wL6vtR30fImBp+DRZOn6U9rkffJU79dz8
	4/FsX7eySDxgZz8Hb0Jy9Q9iU8Cf2fiziJ+aT3gUVgwpzOTId2bCbcvRuXmCQp7MVXBRXwU6SLl
	0bfSJZKBZ/O19fK8/QPDreOqg49wdYynUE+QxY2uVfTkURvnmlX+tbxdRh4qt+XKEevy/l8lEu+
	FUzep6aDCFReJ4ali9UU5krCx60rVpLg4/SmFTCUUKc6YRhqLZ7RHYWblE/BbrqiBHwFjiUm6XM
	4hyAU9NIWLSC46llZ4bUCcJ2CI5FiG7rBRXoaqwPjjoT/HvuDcSwjCFHkSfFWzRDfpML0ztKM11
	xy+a2gG157BEzVFmNMrn0SfKwfmPkWqf5RADBnoWcAgqleUwxP2QmG4UorpEWeoTfls3BbwR34S
	mbvIvcvhgi9XXfwc/vN1k8axn80lubZKXIfjZy7P272PcTuInHAbgfNQ2jyp5AX7R4aTIYHthU+
	X8nvTdo
X-Received: by 2002:a05:693c:3007:b0:2de:2f38:a7d6 with SMTP id 5a478bee46e88-2de2f38a8e0mr2979489eec.13.1776301851743;
        Wed, 15 Apr 2026 18:10:51 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:f669:42fc:9948:a037? ([2620:10d:c090:500::2:7c3f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8eb8443csm5258543eec.14.2026.04.15.18.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 18:10:51 -0700 (PDT)
Message-ID: <2ec3db2d2960d9c13577d630306f16873ebb53e5.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf/verifier: Use intersection checks when
 simulating to detect dead branches
From: Eduard Zingerman <eddyz87@gmail.com>
To: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, 
	bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Paul Chaignon
 <paul.chaignon@gmail.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>,  Srinivas
 Narayana <srinivas.narayana@rutgers.edu>, Santosh Nagarakatte
 <santosh.nagarakatte@rutgers.edu>
Date: Wed, 15 Apr 2026 18:10:49 -0700
In-Reply-To: <20260415160728.657270-2-harishankar.vishwanathan@gmail.com>
References: <20260415160728.657270-1-harishankar.vishwanathan@gmail.com>
	 <20260415160728.657270-2-harishankar.vishwanathan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-04-15 at 12:07 -0400, Harishankar Vishwanathan wrote:
> This commit introduces checks to detect if the ranges and/or tnums have
> intersections between them, and uses the checks in
> simulate_both_branches_taken and reg_bounds_sync.
>=20
> The verifier is known to evolve the reg_states correctly (i.e. soundly)
> on a live branch. In a previous commit [1], we used the ill-formedness
> of a range (e.g. umin > umax), identified by range_bounds_violation, to
> detect dead branches and prune the branch along which the ill-formedness
> occurs.
>=20
> Another opportunity to prune branches is when the ranges and/or tnums
> have don't intersect. When the verifier evolves the reg_state along a
> dead branch, it is possible that abstract value in one domain (e.g tnum)
> doesn't match with the abstract value in the other domain (e.g. u64), so
> that there is no single value x, that is contained in both the abstract
> values.
>=20
> First, we introduce intersection checks for each of the 5 domains (for a
> total of 10 domain pairs), and wrap it in reg_bounds_intersect.

Hi Harishankar,

I thought some more on the topic if checks for all 10 domain pairs are
necessary and now have some doubts. Ideally, what one wants to check
is that there exist a value included in all 5 domains.  Unfortunately,
it is too complicated to encode such a check, so the patch-set
approximates this doing pairwise intersections.  Since we already are
talking about an approximation, it might be fine to do additional
simplifications.

For example, given the current implementations for
is_scalar_branch_taken(), regs_refine_cond_op(),
deduce_bounds_64_from_64() is it ever possible for u64 range not to
intersect with s64 range?

After spending some time with pen and paper for BPF_JLE operation I
suspect that it is not possible. I also encoded this as a small cbmc
test: https://github.com/eddyz87/intersection-check.
I suspect that same reasoning applies for other operations.

I'd suggest to drop the u32/s32 and u64/s64 checks, unless a counter
example can be found. I'm not sure about 64/32-bit checks.
Wdyt?

[...]
