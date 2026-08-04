Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB489386C21
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 01:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785807752; cv=none; b=cCjjHqS5rSbFe4pdH61DWEAP69wfPV7HMIuvj/srTHwR3rM3aVfR/KW5tlhQwEkriYYO4/3jvUxpA99tMiSa6QNNeLeCR/VkrgcPB0GBOlT5gTiHhkDV5QwOU61NfV10HJ5fJhgr0G2zqu5v6Z34q5AFUHbzsER6zJ7mOZud6K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785807752; c=relaxed/simple;
	bh=EjR5YmZ2k8x3T7lxFCWIaJg7u4Us8pT7Gf/Ii03TP1s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S9rZXTeB1CBRiUGKEMLuki6/Yp1M3nXL7oMFH/dExROgi4QYeWIUFVTvTufibQTrQiLacag6IpCDEYdh+lUYYu2zt35CXGNk25PDfsd9to9S0pdaBoksIvkmBObkgeF5qBpbJnoySxFz63etLj3EFMtbYAS36a80KJFNnH1KbSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AW/TJyN8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AW/TJyN8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45ECD1F000E9;
	Tue,  4 Aug 2026 01:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785807751;
	bh=TgGuyPVxiZl8+sEC4VHRFz10PqwyVTFJ+HbhNuYdOi0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AW/TJyN8H2ZVXhXyjeYF24ComfaHIfLkMTTOf/J/ygG0vCzYLZWFAmts7id3lGJhZ
	 PX48kx1OIk9p2e8+Ll+9UlJTn/xxWcSqM00iSZhkRwp6js1vE137MlsZ7BgPpRivQ1
	 FCvxCtFGbHH/RLDe3nmUSvbhl34EY/1asvpDQhhgVl3FOKN+bcYDMPXkN4Fpgph9tx
	 sqk48zNoYWzsQZey8uBV+/Y9SpG3tLJtWYlVhhL75urRhqWlt1wq69trpXc+wpST7h
	 ialoU9z8O56RtATLWWss7nZXdEhGMPSGpnVbIGptaMR/JirN784WxNDQqLilv08tb4
	 08FnQDV9XU9/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] selftests: net: reuseport_bpf_numa: consider
 cpuless numa node
Reply-To: sashiko-reviews@lists.linux.dev
To: "Feng Tang" <feng.tang@linux.alibaba.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260803014214.80748-1-feng.tang@linux.alibaba.com>
References: <20260803014214.80748-1-feng.tang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 01:42:30 +0000
Message-Id: <20260804014231.45ECD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Spelling mistake in newly added comment: 'unlikeyly' instead of 'un=
likely'.
--

--- Patch [1]: [PATCH net v2] selftests: net: reuseport_bpf_numa: consider =
cpuless numa node ---
commit 4e53579a82f841c838d35fa42c245feb267f6bcb
Author: Feng Tang <feng.tang@linux.alibaba.com>

selftests: net: reuseport_bpf_numa: consider cpuless numa node

This commit fixes a test failure on platforms with CXL memory where a NUMA
node might only have memory and no CPUs. It adds a sanity check to skip
cpuless NUMA nodes during the NUMA binding test to prevent
numa_run_on_node() from failing.

> diff --git a/tools/testing/selftests/net/reuseport_bpf_numa.c b/tools/tes=
ting/selftests/net/reuseport_bpf_numa.c
> index 8ec52fc5ef41b..b5fb576fa61af 100644
> --- a/tools/testing/selftests/net/reuseport_bpf_numa.c
> +++ b/tools/testing/selftests/net/reuseport_bpf_numa.c

[ ... ]

> +/*
> + * Return true if it is a cpuless node. Return false if it isn't or any
> + * error (very unlikeyly) happens during the libnuma calls.

[Severity: Low]
This isn't a bug, but there is a typo here: "unlikeyly" instead of
"unlikely".

> + */
> +static inline bool is_cpuless_node(int node_id)
> +{
> +	struct bitmask *cpumask;
> +	bool ret =3D false;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803014214.8074=
8-1-feng.tang@linux.alibaba.com?part=3D1
