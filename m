Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B0A32E68D
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 14:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779358; cv=none; b=TotO4Y95B3svO2iC6JaeUTGFtq2BklEIHwdlK6PeY0ni5NZs7Z7InnA7T4lHzM0K9xDymxdNuF1Wy4hYLg4c0Psen2goArKFXvxXxYNl46Tug8EIMNak/uSnTkFKSD1Le24iiFqBsb7kgwzC0/TEwX1cpEp8OfJtRWfNcDzCuHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779358; c=relaxed/simple;
	bh=597cLbtMUEBJr8lSsi2igw6SIevmcZe9hDZjNrhB7O4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=VllfZS9NVBf5NsmH3G41qAvpH15hwBebvQFmw4a7N5yYUBXB92oz7LcaTa89MXe2E3i6L7Dgw3WiwyWQpTXLOlKX4QMgBYv6ARev95YC9B5lMS47tAB6UoeqbDaOIiWhySyyvNvYf/jvSTY/o/kxCQHpHuOgV5SwzqOvRJqEmOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqh8RwKM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqh8RwKM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8691F000FF;
	Wed, 30 Sep 2026 14:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790779340;
	bh=K5p13pQoqXECV3L+Ojt8WsEVjJms07MdJATbBRxqDQk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=dqh8RwKMiA4zAIwtTIN5/f54Nxxad7SFWRa/32kaZnhPnNBu42Pt1O6P5Dy6fv5cg
	 UKaY+hsFNGKgCfMfvdYGOA3JTm+ezgSpMhGUNdi5NgPdW3v1cGmKbF1xwhmCuTkY3a
	 PtsA9fmA1oGrE7Qs6zBQLDDwZ36I8xhnzvn9Fa1KHqNR8IliwZN3VuedH1FlXpsm0Y
	 Y+jTlhdVkMUyxKjbK9QhTjCKfjPTHS8ATK4jxK9JyoH3q6VyRa9HY0eS6EHyPv0PLJ
	 AJRerwaGofnrswk954py5MDpyRl+eAeGV5Ahpr/qElqmyrL5Lfhfd3IT9xiZpY0qD5
	 /gegF+XOQP+0g==
Content-Type: multipart/mixed; boundary="===============1632102394787516010=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8ca5c049e559db74e5f762c3562b9953887d0d9587499fdfbf8c00af35581829@mail.kernel.org>
In-Reply-To: <20260930135753.1063495-3-maghasi@disroot.org>
References: <20260930135753.1063495-3-maghasi@disroot.org>
Subject: Re: [PATCH v2 2/2] selftests/bpf: add test for percpu map flags combination
From: bot+bpf-ci@kernel.org
To: maghasi@disroot.org,bpf@vger.kernel.org
Cc: andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,leon.hwang@linux.dev,maghasi@disroot.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 30 Sep 2026 14:42:19 +0000 (UTC)

--===============1632102394787516010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: add test for percpu map flags combination

TL;DR: Nit only, not a bug: the new percpu_alloc selftest names (lru_percpu
word order, missing cpu_flag_ prefix) differ from existing subtests, so '-t
percpu_alloc/cpu_flag*' won't select them.

> diff --git a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
> --- a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c

[ ... ]

> +static void test_percpu_lru_hash_flags_combination(void)
> +{
> +	test_percpu_map_flags_combination(BPF_MAP_TYPE_LRU_PERCPU_HASH);
> +}
> +

[ ... ]

> @@ -565,4 +593,8 @@ void test_percpu_alloc(void)
>  		test_array_cpu_flag();
>  	if (test__start_subtest("cpu_flag_hash"))
>  		test_hash_cpu_flag();
> +	if (test__start_subtest("percpu_hash_flags_combination"))
> +		test_percpu_hash_flags_combination();
> +	if (test__start_subtest("percpu_lru_hash_flags_combination"))
> +		test_percpu_lru_hash_flags_combination();
>  }

This isn't a bug, but would test_lru_percpu_hash_flags_combination() and a
subtest name like "cpu_flag_exist_lru_percpu_hash" match the naming the other
percpu_alloc subtests use?

The map type is BPF_MAP_TYPE_LRU_PERCPU_HASH, and the existing helpers and
subtests in this file use the 'lru_percpu_hash' word order:
test_lru_percpu_hash_cpu_flag(), test_lru_percpu_hash_cpu_flag_create(),
"cpu_flag_lru_percpu_hash" and "cpu_flag_create_lru_percpu_hash".

The new subtest names also don't share the 'cpu_flag_' prefix, so filtering
with '-t percpu_alloc/cpu_flag*' will not select them even though they
exercise BPF_F_CPU.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36727325577
--===============1632102394787516010==--
