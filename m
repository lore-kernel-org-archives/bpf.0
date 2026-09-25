Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFFF4EA368;
	Fri, 25 Sep 2026 16:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790354593; cv=none; b=jutzZN+3xbwZtK2ZsC7nqWdNJRU+re7Mgjp+7thkpKDX8OpovGxxvKcrXZ8eqzfgWJaQTzhk/DQyfYXUsOB6FBR/odDu3JWWmaNV309ceL1lrSs4rGJO3PzXkOXygLvm3n6sJzXet32G/OQzwZk2OoWTUuXtS3yicTRiClcbGcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790354593; c=relaxed/simple;
	bh=P3w6KMXjzLlN6nAljQD/5grUF93zr/UQ9AJoIQbvkpw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=M1SuUK1zkn+K5WCptRsFEkBjjX4pYOAKUvYDhY+In8PFCw9ySt7B0Eu5r2qqzkG9DIjGODkZnjO5Xypwdmsr11lFDTxya3p+8EGPopbgO1M3EU00N+Q1yk5kSv/AIcbjQYuTgNytIJ62eKPWPwBV8oW9AL6HbEoMLzwve5DYCT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFGDgU7I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFGDgU7I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72A31F000FF;
	Fri, 25 Sep 2026 16:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790354563;
	bh=Td8d4StGwfViCnmZPo1eb0gqFXmqlEDNpKnck2rJhM8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=QFGDgU7IKMnHqdexzNTe0J9OMuvOr7gXytEcQR5jvi5F+E0moIp5uwXVWFrhZuqpA
	 tQu5zKqPQ9sXNki6y5QXUPclXS4I3jt7QDVjiHziQVh3nobUMaghdYb1NKjVzxUY7r
	 n56U64tB+OEzMGbGsUmxUP942DJzYitlSB1QzhJCXFLqFzmG/lzBlaFiUSah6kXWdO
	 upVPFVojzMDT+AjxE0J0H3K2Xqmt3k6nh0zQ9QoHLQ7DP1qdVJALDFCOAP2mzP3pJq
	 WRORlXemmQjOHARWBTZL+V4DEUHmKzM+6FaHadtiraYtOD4vhhLs+Jz3Z9h3vT21da
	 MZTP+y+tCnVMA==
Content-Type: multipart/mixed; boundary="===============6809303146770183891=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6a6f53bff017aa1e0c758a1a87da09ae0165d5523b13e65dc944e3494377e3fd@mail.kernel.org>
In-Reply-To: <20260925154029.3673513-2-eva.kurchatova@virtuozzo.com>
References: <20260925154029.3673513-2-eva.kurchatova@virtuozzo.com>
Subject: Re: [PATCH bpf-next v2 1/1] selftests: bpf: size the map in test_lru_sanity3 to whole refills
From: bot+bpf-ci@kernel.org
To: eva.kurchatova@virtuozzo.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,willemb@google.com
Cc: linux-kernel@vger.kernel.org,eva.kurchatova@virtuozzo.com,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 25 Sep 2026 16:42:42 +0000 (UTC)

--===============6809303146770183891==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests: bpf: size the map in test_lru_sanity3 to whole refills
>
> test_lru_sanity3 fills a map of tgt_free * 2 elements, and then reads
> back all but the last few. Whether that passes depends on the cpu
> count alone; on a machine with six it does not:
>
>   test_lru_sanity3 (map_type:9 map_flags:0x0): test_lru_map.c:463:
>   test_lru_sanity3: Assertion `!bpf_map_lookup_elem_with_ref_bit(
>   lru_map_fd, key, value)' failed.
>
> The kernel hands elements out in refills of lru->target_free, which is
> clamp((size / nr_cpus) / 2, 1, LOCAL_FREE_TARGET), that is 128 / nr_cpus
> rounded down. A refill the global free list cannot satisfy in full
> calls __bpf_lru_list_shrink() for the remainder, and that evicts live
> elements. Filling the map therefore evicts nothing only when computed
> 128 / nr_cpus is a power of two. Any other nr_cpus variation fails.
>
> batch_size is already __tgt_size(tgt_free), the refill size of a map
> is __map_size(batch_size) elements, so size the map that way and the
> fill consumes whole refills. Start the keys of the last insert at
> map_size + 1, just past the new size.
>
> Above 128 cpus __tgt_size(tgt_free) is 0 and there is no size to build
> on. Skip the test there.

The changelog states the skip triggers "Above 128 cpus", but the code
skips from 65 CPUs up. main() passes tgt_free = LOCAL_FREE_TARGET (128),
and __tgt_size() computes:

    batch_size = (128 / nr_cpus) / 2 = floor(64 / nr_cpus)

which is 0 for any nr_cpus >= 65 (since 128 / 65 = 1, and 1 / 2 = 0).
The new `if (!batch_size)` check fires on 65..128 CPU machines, not only
"above 128 cpus".

The sentence "batch_size is already __tgt_size(tgt_free), the refill
size of a map is __map_size(batch_size) elements" is also hard to parse.
The refill size is batch_size (not tgt_free); the map is sized to make
the kernel's target_free equal batch_size.

Could the last paragraph say "Above 64 cpus", and could the sentence be
reworded to clarify that batch_size becomes the refill size after the
map is resized?

> diff --git a/tools/testing/selftests/bpf/test_lru_map.c b/tools/testing/selftests/bpf/test_lru_map.c
> index 0921939532c6..84e9a930471a 100644
> --- a/tools/testing/selftests/bpf/test_lru_map.c
> +++ b/tools/testing/selftests/bpf/test_lru_map.c
> @@ -441,8 +441,15 @@ static void test_lru_sanity3(int map_type, int map_flags, unsigned int tgt_free)
>  	assert(sched_next_online(0, &next_cpu) != -1);
>
>  	batch_size = __tgt_size(tgt_free);
> +	if (!batch_size) {
> +		/* More cpus than this tgt_free gives a refill for */
> +		printf("Skip\n");
> +		return;
> +	}

A subsystem pattern flags this as potentially concerning: the new skip
reports with printf("Skip\n") and then returns, so the binary exits 0
and CI counts it as a pass. The selftests guide asks for skip results to
go through kselftest.h (ksft_test_result_skip() with a reason string),
and says skip messages should always include a reason.

test_lru_map.c is a legacy binary that never includes kselftest.h, and
converting just this line would be inconsistent with the existing
printf("Pass\n") pattern used elsewhere in the file. The concern is
narrow: could the message at least say why the test was skipped, for
example printf("Skip: nr_cpus %d > %u\n", nr_cpus, tgt_free / 2)?

> +
> +	/* A partial refill shrinks the LRU and evicts live elements */
> +	map_size = __map_size(batch_size);
>
> -	map_size = tgt_free * 2;
>  	lru_map_fd = create_map(map_type, map_flags, map_size);

[ ... ]

> @@ -466,7 +473,7 @@ static void test_lru_sanity3(int map_type, int map_flags, unsigned int tgt_free)
>  	}
>
>  	/* Insert new batch_size: replaces the non-referenced elements */
> -	key = 2 * tgt_free + 1;
> +	key = 1 + map_size;
>  	end_key = key + batch_size;
>  	for (; key < end_key; key++) {
>  		assert(!bpf_map_update_elem(lru_map_fd, &key, value,


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36157128898
--===============6809303146770183891==--
