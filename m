Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414293;
	b=zb3AWj5sBZe/bcX6SHWi7Ho8wM/V5cc+i/Diqs8yjvszJoQcLwL57lQFMC97ayhqQeqf
	 KQiaLheR1TeZyLtVyj6I0D7pKDEhVrb87Gcyc2VorRJ+08nZGu62KPO2o5RH+My4ecDqh
	 zVkoMOUhjw2hZSBV9waTYr0gM4yi3nO+RYdsP6Kz71OdRi4JyCXPmnqsVWBVpkTdsu64M
	 5NGvnepEVwlEjwLCyjF467MasathhzojBUEuVWsblkbKfsHVobLLaBKcln6mL36Z9iDTF
	 t4gk9XCapYugEHcUMWvvc4Fsa9g85vd3mhNqQUu8AjeXKF9NqkvGHKpWhiBaDkAm+cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414293;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=VNb+OjU/2UL93AbsN8RbF1WFO0841pKMK7DxOM4yYUg=;
	b=SPEjlIoCG+kyE01BHwkZ2LqivCvU4sP/vSXr4EFfK2sOUd1lmCZRlH/w4DCQI6yc6vul
	 e371DY3kvOGv2ZALqb8GU5JOOwfOd6yezukUL9GO1QZkrR0WE0oXvPaD246cY+uNaczjE
	 w/IN8D/tLZ4Qnn9A8m9aQFZdVDiPWQ59EMLkFOrOTp+N+iOhhlSytxoN3abwcjq0AVczJ
	 6qIEA6/shSg3uBcSwGI+0snQaWstfbXVmaRHH4s7lHB5hycF1QlYAEG+yCdOMlT8yM2/D
	 ReuM8wD3ayJZ92iMH0/k2HL5OztgvJIGoeyDzrRL9VhuF1LsEyvAe9U3ksJ1TRDuqcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z+3cWMs9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6811606A32A;
	Wed, 11 Nov 2026 16:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z+3cWMs9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84E81F00A05;
	Wed, 11 Nov 2026 16:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794414293;
	bh=VNb+OjU/2UL93AbsN8RbF1WFO0841pKMK7DxOM4yYUg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Z+3cWMs9Ar8z0h3luKDI0rdkliprRYS7CJL9jLZg9/zteLFKZS5yJcHC1mx+R+WGv
	 AGkqSeA9F8RlNYi6eCKJzgA+tLCwAHxII9bZLgv4SMb3M5+VONSl+dCWiq640pIpuT
	 OXpPuKYQ0tCEM7RB88HG/mU1aYpQNkgEGoNt5tDd69EOtqdHt/OwKu8CNW7F4U82s1
	 DS1KhN6aiMhXdP/gG0jHfwDLyLvT8iCXviCKiompfpJzBxCE8W40cpxmELhdMdcenG
	 6hUAnWQxXvBH4LwwP3J/ecyvv4zBSCnNNTHKR1zv/7gVRvvejNCK6EKZnUQeJdZpJz
	 cwKtHYv2eeWEw==
Message-ID: <306f9310-3e12-44ed-815a-b0d589cf4599@kernel.org>
Date: Wed, 11 Nov 2026 16:24:50 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v12 3/3] selftests/bpf: Cover recursive bpftool
 map dumps
To: Tianyi Chen <hi@tychen.cc>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, ihor.solodrai@linux.dev
References: <cover.1794380385.git.hi@tychen.cc>
 <be760a15c78cd2e7e27fc8b9bad6142488827573.1794380385.git.hi@tychen.cc>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <be760a15c78cd2e7e27fc8b9bad6142488827573.1794380385.git.hi@tychen.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-11-11 16:19 UTC+0900 ~ Tianyi Chen <hi@tychen.cc>
> Compare recursive dumps of array_of_maps and hash_of_maps with individual
> inner-map dumps in JSON and plain output. Cover shared and empty inner
> maps, an empty array slot, BTF values, and multiple roots selected by
> name. Check indentation of wrapped keys, values and per-CPU entries.
> 
> Use fmod_ret to make an inner map unavailable and check that only its
> entry reports an error. Count lookup calls to check that outer entries
> are read individually while inner maps still use batches. Also check
> unchanged output without recursion and reject invalid arguments.
> 
> Assisted-by: LLM
> Signed-off-by: Tianyi Chen <hi@tychen.cc>


I'm good with the coverage provided by the tests, but see the comment
from Alexei on another series [0]: selftests tend to grow very fast, and
you're creating objects (or invoking bpftool) more than what caused
Alexei to push back. So when reposting, for example once the batch
lookups series is merged, please look into reducing the cost.

Some leads:

- Dump each inner map once per mode when building the expected output,
with some cache in expect_json()/expect_plain()

- I think testing the plain output in test_multiple_roots() brings no value?

- In test_outer(), you could have one full comparison per map type
instead of two, because the recursion code only checks
map_is_map_of_maps() and doesn't depend on the type, so dropping
hash_of_maps should be OK

- Maybe drop test_unchanged()?

Thanks,
Quentin

[0] https://lore.kernel.org/bpf/DMOO53QTDUQ4.2Z9UXMZEPX568@gmail.com/
