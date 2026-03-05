Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079EB190462
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 00:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772671734; cv=none; b=mTkAq9k1S+HrBFs/KC9ZaLXkdN07hZdrL3VhyigIpz2aYcr/xELaTPccs6ZIj0BM5v2ITWzOw/HdjA0ohLPa90hDKWd9Qh891sOdg1Bc7sCgjWvCTOxLdTs3o8G7I1z9FgL9qNKFAYai0j7jNhEiZd9sJeL+ZosCl2Ec6akdYWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772671734; c=relaxed/simple;
	bh=nK431fd7b3+zMItLeANdhfvFIPZw970bPhV16CyOiGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bafYrmOFJyJ+BJUc7a9E/pPU0yeBctjYYm8zSAbrXWckcPCBFj0Gl5xkG5l4rzKD/YX8WKwyTTAM1hABbFhdVkf7ssVSd4I7lp1W4KxZL+uX74JOtrhpsQLmNgkm0XMIbKDgLeVIuPisKma1n/4T7/sdZCk2kvHTbcTQxZxxbzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JpJ+JzX4; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JpJ+JzX4"
Message-ID: <d9c98aac-6c4c-483e-9e9a-0659dc03f9e7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772671729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=llDAxjq2rbQmr/Q2MAZkSmBnkUtdyt81+GrI0Pnmgy0=;
	b=JpJ+JzX4wtWICq/vuRxVS1WFSoRBZ16/kCxhl1I6Eu97BgL3cUKWRUoYX8pHoemx23T59m
	AQPF0227sh9Foi6LBA09MhSuB6ii9IC986YLT3pUodFe3VdgGsTB4zJYQusch4tEbH7TA1
	owzjQxQyGnbJ1SClQ4v9cElCb+T79EI=
Date: Wed, 4 Mar 2026 16:48:43 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/1] bpf: Avoid one round of bounds deduction
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
 Kernel Team <kernel-team@meta.com>
References: <aac2GMpnpoAKD4jX@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <aac2GMpnpoAKD4jX@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/3/26 11:27 AM, Paul Chaignon wrote:
> In commit 5dbb19b16ac49 ("bpf: Add third round of bounds deduction"), I
> added a new round of bounds deduction because two rounds were not enough
> to converge to a fixed point. This commit slightly refactor the bounds
> deduction logic such that two rounds are enough.
> 
> In [1], Eduard noticed that after we improved the refinement logic, a
> third call to the bounds deduction (__reg_deduce_bounds) was needed to
> converge to a fixed point. More specifically, we needed this third call
> to improve the s64 range using the s32 range. We added the third call
> and postponed a more detailed analysis of the refinement logic.
> 
> I've been looking into this more recently. To help, I wrote a high level
> sequence of all the refinements carried out in reg_bounds_sync. u64 ->
> s32 means we used the u64 ranges to improve the s32 ranges.
> 
>     /* __update_reg_bounds: */
>     tnum -> {s32, u32, s64, u64}
>     /* __reg_deduce_bounds: */
>     for (3 times) {
>         /* __reg32_deduce_bounds: */
>         u64 -> {u32, s32}
>         s64 -> {u32, s32}
>         u64 -> s32
>         s64 -> s32
>         u32 -> s32
>         s32 -> u32
>         /* __reg64_deduce_bounds: */
>         u64 -> s64
>         s64 -> u64
>         {u64, s64} -> {u64, s64}
>         /* __reg_deduce_mixed_bounds: */
>         u32 -> u64
>         u32 -> s64
>         {s32, s64} -> {s64, u64, tnum}
>     }
>     /* __reg_bound_offset: */
>     {u64, u32} -> tnum
>     /* __update_reg_bounds: */
>     tnum -> {s32, u32, s64, u64}
> 
> From this, we can observe that we first improve the 32bit ranges from
> the 64bit ranges in __reg32_deduce_bounds, then improve the 64bit
> ranges on their own in __reg64_deduce_bounds. Intuitively, if we were to
> improve the 64bit ranges on their own *before* we use them to improve
> the 32bit ranges, we may reach a fixed point earlier. Said otherwise, we
> would need to move the *64 -> *32 refinements to the beginning of
> __reg_deduce_mixed_bounds. (The logic would then also better match the
> function names, but that's secondary.)
> 
> After testing, this small refactoring does allow us to lose one call to
> __reg_deduce_bounds. Without this refactoring, the test
> "verifier_bounds/bounds deduction cross sign boundary, negative
> overlap" fails when removing one call to __reg_deduce_bounds. This
> patch therefore implements that bit of refactoring and reverts commit
> 5dbb19b16ac49 ("bpf: Add third round of bounds deduction").
> 
> As expected, this change didn't have any impact on the number of
> instructions processed when running it through the Cilium complexity
> test suite [2].
> 
> Link: https://lore.kernel.org/bpf/aIKtSK9LjQXB8FLY@mail.gmail.com/ [1]
> Link: https://pchaigno.github.io/test-verifier-complexity.html [2]
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>


Hi Paul,

(trying to do my part with the code reviews and learn in the process)

Side note: you might be interested to know that Eduard is working on
consolidating signed and unsigned domains [1].

If I understand correctly from the pseudocode there is a dependency
loop between *64 -> *32 -> *64 -> *32 -> ... and so on.

This got me curious, why don't we actually try to compute a fixed
point here with a loop? If we were, we wouldn't have to guess how many
iterations need to be there, and the order of the narrowing steps.

So I implemented a dumb loop in reg_bounds_sync() with a limit, and
added global counters to collect stats. Pasting a (mostly vibe-coded,
sorry) patch at the bottom.

Then I ran veristat on a suite of Meta BPF programs against a kernel
with this loop (without your patch), here are the results:

  $ grep bounds_sync tools/testing/selftests/bpf/veristat.log | tail -n 10
  bounds_sync calls 12400636 total_iters 1349388 max_iters 2 avg_iters 0.10
  bounds_sync calls 12451162 total_iters 1355717 max_iters 2 avg_iters 0.10
  bounds_sync calls 12501688 total_iters 1362046 max_iters 2 avg_iters 0.10
  bounds_sync calls 12618333 total_iters 1377655 max_iters 2 avg_iters 0.10
  bounds_sync calls 12734978 total_iters 1393264 max_iters 2 avg_iters 0.10
  bounds_sync calls 12790555 total_iters 1398860 max_iters 2 avg_iters 0.10
  bounds_sync calls 12846132 total_iters 1404456 max_iters 2 avg_iters 0.10
  bounds_sync calls 12846174 total_iters 1404459 max_iters 2 avg_iters 0.10
  bounds_sync calls 12846320 total_iters 1404465 max_iters 2 avg_iters 0.10
  bounds_sync calls 12846321 total_iters 1404465 max_iters 2 avg_iters 0.10

  $ grep bounds_sync tools/testing/selftests/bpf/veristat.log | grep -o 'max_iters.*' | sort -u
  max_iters 2 avg_iters 0.09
  max_iters 2 avg_iters 0.10
  max_iters 2 avg_iters 0.11

This is across 400+ progs of various sizes. The vast majority of
reg_bounds_sync() calls don't change anything (0 iterations), and
those that do converge in max 2 iterations.

My interpretation of this (assuming I haven't messed up anything while
experimenting) is that the situation you hit in [2] is rare. And I think
it is safe to implement a loop in reg_bounds_sync() with a reasonable
iteration limit (10 maybe?).

Am I missing anything that makes it a bad idea?

[1] https://github.com/eddyz87/bpf/tree/cnum
[2] https://lore.kernel.org/bpf/aIKtSK9LjQXB8FLY@mail.gmail.com/

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d92cf2821657..dc1082590f04 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -369,6 +369,11 @@ static const char *btf_type_name(const struct btf *btf, u32 id)
 static DEFINE_MUTEX(bpf_verifier_lock);
 static DEFINE_MUTEX(bpf_percpu_ma_lock);
 
+/* Global counters for reg_bounds_sync fixed-point convergence stats */
+static atomic64_t bounds_sync_total_iters = ATOMIC64_INIT(0);
+static atomic64_t bounds_sync_call_count = ATOMIC64_INIT(0);
+static atomic_t bounds_sync_max_iters = ATOMIC_INIT(0);
+
 __printf(2, 3) static void verbose(void *private_data, const char *fmt, ...)
 {
 	struct bpf_verifier_env *env = private_data;
@@ -2757,14 +2762,34 @@ static void __reg_bound_offset(struct bpf_reg_state *reg)
 	reg->var_off = tnum_or(tnum_clear_subreg(var64_off), var32_off);
 }
 
+#define REG_BOUNDS_MAX_ITERS 1000
+
 static void reg_bounds_sync(struct bpf_reg_state *reg)
 {
+	struct bpf_reg_state prev;
+	int iters = 0;
+	int cur_max;
+
 	/* We might have learned new bounds from the var_off. */
 	__update_reg_bounds(reg);
-	/* We might have learned something about the sign bit. */
-	__reg_deduce_bounds(reg);
-	__reg_deduce_bounds(reg);
-	__reg_deduce_bounds(reg);
+	/* We might have learned something about the sign bit.
+	 * Loop until bounds reach a fixed point.
+	 */
+	do {
+		prev = *reg;
+		__reg_deduce_bounds(reg);
+	} while (memcmp(&prev, reg, sizeof(prev)) && ++iters < REG_BOUNDS_MAX_ITERS);
+
+	WARN_ON_ONCE(iters >= REG_BOUNDS_MAX_ITERS);
+
+	atomic64_add(iters, &bounds_sync_total_iters);
+	atomic64_inc(&bounds_sync_call_count);
+	cur_max = atomic_read(&bounds_sync_max_iters);
+	while (iters > cur_max) {
+		if (atomic_try_cmpxchg(&bounds_sync_max_iters, &cur_max, iters))
+			break;
+	}
+
 	/* We might have learned some bits from the bounds. */
 	__reg_bound_offset(reg);
 	/* Intersecting with the old var_off might have improved our bounds
@@ -24799,6 +24824,20 @@ static void print_verification_stats(struct bpf_verifier_env *env)
 		env->insn_processed, BPF_COMPLEXITY_LIMIT_INSNS,
 		env->max_states_per_insn, env->total_states,
 		env->peak_states, env->longest_mark_read_walk);
+
+	{
+		u64 total = atomic64_read(&bounds_sync_total_iters);
+		u64 calls = atomic64_read(&bounds_sync_call_count);
+		u32 max = atomic_read(&bounds_sync_max_iters);
+
+		verbose(env, "bounds_sync calls %llu total_iters %llu max_iters %u",
+			calls, total, max);
+		if (calls)
+			verbose(env, " avg_iters %llu.%02llu",
+				div_u64(total, calls),
+				div_u64(total * 100, calls) % 100);
+		verbose(env, "\n");
+	}
 }
 
 int bpf_prog_ctx_arg_info_init(struct bpf_prog *prog,



> ---
>  kernel/bpf/verifier.c | 138 +++++++++++++++++++++---------------------
>  1 file changed, 69 insertions(+), 69 deletions(-)
> 
> [...]
