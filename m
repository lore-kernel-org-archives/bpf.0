Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793961093;
	b=z9tdI679cx0YRd/hyV1Nd2E2qf5Ht1nCcoyvQwz0GeUtjDGdsqRIa3KivC4sy9i96Lam
	 V7WxCpgtLK8FsswI8FShqZap+zYOxJr2gBWeLvhJqla5nBYpv7wOwOJFzCRdkSsmBVTbW
	 C2blAVzIdVuq4xXtMMnHaG3hZgI82+evDO1KrCeuR6UEnM6kEB7hk1oCY0SVpnNLpDo24
	 bLV0jJXqMWKgg2rahBoP9vHvZv7uW0rCbHizWVxjDKmHPtcEf/ApMt+p6TjgczYvRJT2+
	 lUgcZSDxP8xJrCmf+w1vDfU6B0ZekK2R+rySenPrg0MrORVOneHXcjrv80myyBcq5Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793961093;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=bdOl/n8yCttaUwy/7cbPLal3E6oXQPQKJPAZ4q/K8dw=;
	b=G+CiulfV/MU8FS1YL/7XUHa9GBaRsm6fz0ueBi8qqq8csPoxDYinnLuKCSliiVWg4ppe
	 GptfKi89R92sxvQRJgTKwR3lsmAm6O/zhs1LNYgFII129OYYO54IQrewK+nCm+v5wu9a5
	 WQj3ISdqh7Zm1Nr7dgLf1Ls9dU0qqBeogeyFnL476J0fwTPxP9W+/cY0CDYz9ghg4hPB/
	 znKPd/QTHEo4j4QFyHTmiYT3g4NcKFJMfQ87BGYu8I0QP+8VPl0Dg9TWRl0dYx9IGW9xu
	 j7mTkdP8MHQtmQ4Ef2+X9KqhG9n68dANLcvSsfSIem/4jYyATDNW2UsyZtiIqlIscaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jY4JNXcd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C518E606A32F
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 10:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jY4JNXcd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE11F1F0089F;
	Fri,  6 Nov 2026 10:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793961092;
	bh=bdOl/n8yCttaUwy/7cbPLal3E6oXQPQKJPAZ4q/K8dw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=jY4JNXcdunIDk6ngA9Y9N/8skifvz4F4rlSnejd8NOFz+EkCAo4tFRBhzTpJhTGoM
	 79J7hSr47pF/DriungwzOoBRTIbJz3T0F/PVXQdvOmdky/4xDPvEjqsM9CYQcH+B0G
	 RtYmvigCV4q7OqDNMXkpxqTFcjJCFfDjA+zFQaDZerUtYrJmeXge/UPl9k1yOVuSx9
	 CBpaedNFR4J47KLwzpWpDB+S19ibuV9xWiZQEshMQjwe/LbMU0ZGZ4YEXzJHJBbJRu
	 V/63b7GoDy/d4GSd7I91tnVsORcD131P1g5Sd3Sr2+6vJ0CjQjqqVALxY43ya09Xkk
	 7v4G+p5/iqPkw==
Content-Type: multipart/mixed; boundary="===============7978934990594762189=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <1afc49e2331b659357e786542b82b5343f1456769214168f6e68f9d0e0ee74e1@mail.kernel.org>
In-Reply-To: <20261106095747.471718-4-luyun_611@163.com>
References: <20261106095747.471718-4-luyun_611@163.com>
Subject: Re: [PATCH bpf-next v2 3/8] selftests/bpf: Check task work value membership
From: bot+bpf-ci@kernel.org
To: luyun_611@163.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev
Cc: yatsenko@meta.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  6 Nov 2026 10:31:31 +0000 (UTC)

--===============7978934990594762189==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Check task work value membership

TL;DR: Test issue: LRU subtests with max_entries=2 and no CPU pinning may
spuriously fail (-ENOENT) if the thread migrates and the LRU evicts the live
key, with no kernel bug.

> diff --git a/tools/testing/selftests/bpf/prog_tests/task_work_membership.c b/tools/testing/selftests/bpf/prog_tests/task_work_membership.c
> new file mode 100644
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/task_work_membership.c

[ ... ]

> +static struct task_work_membership *open_test(enum bpf_map_type type, __u32 flags,
> +					      bool use_signal)
> +{

[ ... ]

> +	/* A full LRU map can evict the target while obtaining a candidate. */
> +	if (type == BPF_MAP_TYPE_LRU_HASH) {
> +		err = bpf_map__set_max_entries(skel->maps.values, 2);
> +		if (!ASSERT_OK(err, "map_max_entries"))
> +			goto fail;
> +	}

Is max_entries = 2 enough to keep the common LRU from evicting the live
key 0 in the lru_replace_* subtests (retired_value(BPF_MAP_TYPE_LRU_HASH,
0, signal, true), REUSE_ROUNDS = 8)?

htab_lru_map_update_elem() calls prealloc_lru_pop() before it looks up
l_old.  With 2 elements, bpf_common_lru_populate() sets target_free to 1,
and a node freed while pending on CPU P goes back to P's private
free_llist, not to the global free list.

If the test thread migrates between rounds, this sequence seems possible:

  insert_value() on CPU 0:
    node A becomes key 0, pending on CPU 0; node B stays on the global
    free list.

  thread moves to CPU 1, round 0 of update_then_schedule:
    takes B from the global free list (B pending on CPU 1);
    htab_lru_push_free(A) puts A on CPU 0's free_llist.

  round 1, still on CPU 1:
    prealloc_lru_pop() -> bpf_common_lru_pop_free() finds CPU 1's
    free_llist empty and calls bpf_lru_list_pop_free_to_local(), which
    flushes B to the global active list, finds the global free list empty
    and calls __bpf_lru_list_shrink().  That force-shrinks the active
    list and unlinks B, the live key 0, via htab_lru_map_delete_node().

Back in htab_lru_map_update_elem(), lookup_elem_raw() then returns NULL and
check_flags() returns -ENOENT for BPF_EXIST.  The program stores
mutation_err = -ENOENT, so ASSERT_OK(skel->bss->mutation_err, "mutation")
fails without any kernel bug.

The test does not pin itself to a CPU, whereas test_lru_map.c uses
sched_setaffinity() for this reason.  Could the LRU subtests pin the thread
to one CPU, or size the map so the global free list cannot run empty within
REUSE_ROUNDS rounds?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42200504781
--===============7978934990594762189==--
