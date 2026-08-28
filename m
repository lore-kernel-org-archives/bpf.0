Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7383C0635;
	Fri, 28 Aug 2026 19:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787944816; cv=none; b=M5cuuIxEV4lGCJzI3+0S/3IkcMrw+TE0mFnRgjUjSjrtncpCV09yER6oK/OT+NvlZA3goO25/dFMDnBSMBHewH9fWFPpfODjcnPJeTQTS31MIbAig1/FTUAlhlgf9lq9FmR5pfN8aKON63RmKMDr2CHZ6vcdvHFqr8+5DYBfliE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787944816; c=relaxed/simple;
	bh=UdnvFOwwykS8c2+NQn/oufyhz+Crer07sPsKyM8EjKM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=m+khlnRyjQTZUn+W/yieanRdyqNtN/DNA07DDwX+DAPVKWjeoS3aBIcNaAHmiHeznOvw9awzV8XK2j2JCDZx3sI9KIOMwYp43RgvLVn3Y5HTuW8zW9qabOlt4TkpNtYYD0axM8XMAvdpCxHr2F4KEhehm4syiXkbt7Be8t0J4sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFpmlwke; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFpmlwke"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7711F000E9;
	Fri, 28 Aug 2026 19:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787944813;
	bh=xeO8K8urtRRpzneGp75YRRQW+VtVinclfOs0PEYddzo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=cFpmlwkevEepHtLO0hRKbkA5fcrshuQA3wMKRXblfX6xLjdSCC6IwSpAFevmOdzUS
	 ZepXn7yUvmWFJcaSnKf0/havel88tIeySDeK1aeY5js8Xw0LcUaW0zuL2lc+fJ9rF+
	 TT0YIyC74bqF7c5TFZr3HUOonMpwlSG2JXu49Z54aRWEp1j/twCAXjh6OdGVCJ6i95
	 I1pNMvPWgaZLMIj5pf7sQZgNB+vXg1S0CBcQyWYg0VWdZJbTfw1skuT0m3okV5p5I8
	 PT7DcpY6jSMWdrG3ywLh9cfnME2vVhVzpKEhcHXkG/QpTTA9Gk+06xQTsIFC8yV5L3
	 /yZtolE4bqEGQ==
Content-Type: multipart/mixed; boundary="===============7842322834384672897=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <346b4f3064cb8ce5081488d5baf604c843439e0730e9a9c0b16ec6ce3e189fbf@mail.kernel.org>
In-Reply-To: <20260828183326.3330530-2-sh_def@163.com>
References: <20260828183326.3330530-2-sh_def@163.com>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: add RHASH iteration stress test
From: bot+bpf-ci@kernel.org
To: sh_def@163.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,yatsenko@meta.com,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 28 Aug 2026 19:20:12 +0000 (UTC)

--===============7842322834384672897==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/rhash.c b/tools/testing/selftests/bpf/prog_tests/rhash.c
> index 98bb66907b7f..a2ecd7e7905f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/rhash.c
> +++ b/tools/testing/selftests/bpf/prog_tests/rhash.c
> @@ -3,12 +3,17 @@
>  #include <test_progs.h>
>  #include <string.h>
>  #include <stdio.h>
> +#include <pthread.h>
> +#include <stdatomic.h>
>  #include "rhash.skel.h"
>  #include "bpf_iter_bpf_rhash_map.skel.h"
>  #include <linux/bpf.h>
>  #include <linux/perf_event.h>
>  #include <sys/syscall.h>
>
> +#define RHASH_STRESS_KEYS		4096
> +#define RHASH_STRESS_DURATION_NS	(3ULL * 1000000000ULL)
                                       ^^^^

A subsystem pattern flags this as potentially concerning: the userspace
RHASH_STRESS_KEYS (4096) has to stay equal to stress_rhmap's
max_entries (RHASH_STRESS_MAX_ENTRIES, 4096 in progs/rhash.c:12) for
the test to keep its meaning. The point of the stress driver is to keep
the map at its capacity so that rehashing happens and a walk has enough
elements to exceed the budget. These are two independent literals in two
different files with no compile-time or run-time tie, so raising the map
size in the BPF object silently leaves the userspace threads churning
only the first 4096 keys.

The function fetches the authoritative value at line 113
(max_entries = bpf_map__max_entries(skel->maps.stress_rhmap);)
but uses it only for the printf() at line 144, so the key range could be
driven from max_entries instead of a duplicated literal.

Could the value that gates the assertion (RHASH_STRESS_MAX_ENTRIES) be
used both for max_entries and for the overrun threshold to avoid drift,
or could the userspace key range be driven from the fetched max_entries?

>
>  static void rhash_run(const char *prog_name)
>  {

[ ... ]

> +static void rhash_iter_stress(void)
> +{
> +	struct rhash *skel = NULL;
> +	struct rhash_stress_arg args[2];
> +	LIBBPF_OPTS(bpf_test_run_opts, opts);
> +	atomic_bool stop = false;
> +	__u64 start;
> +	__u32 max_entries;
> +	pthread_t threads[2];
> +	bool created[2] = {};
> +	struct bpf_program *prog;
> +	int map_fd, err, i;
> +
> +	skel = rhash__open();
> +	if (!ASSERT_OK_PTR(skel, "rhash__open stress"))
> +		return;
> +
> +	prog = bpf_object__find_program_by_name(skel->obj,
> +						"test_rhash_iter_stress");
> +	if (!ASSERT_OK_PTR(prog, "find stress program"))
> +		goto cleanup;
> +	bpf_program__set_autoload(prog, true);
> +
> +	err = rhash__load(skel);
> +	if (!ASSERT_OK(err, "stress skel_load"))
> +		goto cleanup;
> +
> +	map_fd = bpf_map__fd(skel->maps.stress_rhmap);
> +	max_entries = bpf_map__max_entries(skel->maps.stress_rhmap);
> +	for (i = 0; i < ARRAY_SIZE(threads); i++) {
> +		args[i].map_fd = map_fd;
> +		args[i].stop = &stop;
> +		args[i].seed = i * 977;
> +		err = pthread_create(&threads[i], NULL, rhash_stress_update,
> +				     &args[i]);
> +		if (!ASSERT_OK(err, "pthread_create"))
> +			goto stop_threads;
> +		created[i] = true;
> +	}
> +
> +	start = get_time_ns();
> +	while (get_time_ns() - start < RHASH_STRESS_DURATION_NS) {
> +		err = bpf_prog_test_run_opts(bpf_program__fd(prog), &opts);
> +		if (!ASSERT_OK(err, "stress prog run"))
> +			break;
> +	}
> +
> +stop_threads:
> +	atomic_store(&stop, true);
> +	for (i = 0; i < ARRAY_SIZE(threads); i++)
> +		if (created[i])
> +			pthread_join(threads[i], NULL);
> +
> +	ASSERT_GT(skel->bss->stress_max_visits, 0, "stress callback visits");
> +	ASSERT_EQ(skel->bss->stress_overruns, 0, "stress callback bound");
        ^^^^

Does the stop_threads label fall straight through into the result
assertions? If pthread_create() fails for i == 0 the BPF program is
never run, so skel->bss->stress_max_visits is still 0 and
ASSERT_GT(skel->bss->stress_max_visits, 0, ...) emits a second,
misleading failure (unexpected stress callback visits: actual 0 <=
expected 0) on top of the real pthread_create failure. The printf()
then reports "stress max callback visits: 0 (limit 4096)" as if a
measurement had been taken.

The same fall-through happens when bpf_prog_test_run_opts() fails on
the very first iteration (break out of the timing loop). Every other
error path in the function uses goto cleanup to skip the result checks.

Should the thread-creation path goto cleanup, or should the two result
assertions be guarded by a flag recording that at least one prog run
completed?

A subsystem pattern flags this as potentially concerning: the
load-bearing assertion is ASSERT_EQ(skel->bss->stress_overruns, 0),
i.e. no single walk returned more than max_entries. On a kernel without
the iteration bound fix, the walk still terminates naturally after
visiting roughly nelems (<= 4096) entries whenever the
rehash-during-walk race does not fire, so stress_overruns stays 0 and
the subtest reports PASS on the unfixed kernel.

Nothing in the test reports whether the race was actually exercised:
bpf_each_rhash_elem() runs under migrate_disable() + rcu_read_lock(), so
on a 1-vCPU CI VM the two updater threads cannot mutate the table during
a walk at all and the test can never detect the bug there, yet it still
passes.

The companion liveness check, ASSERT_GT(skel->bss->stress_max_visits,
0), is satisfied by a single visited element, and stress_max_visits
reads ~4096 both when the budget clamped a duplicate-heavy walk and when
a quiescent walk simply covered the whole table, so the printed number
cannot distinguish a real pass from a vacuous one either.

This isn't a bug, but would it be worth recording something that proves
the stress happened, such as a count of walks that consumed the full
max_entries budget, or a skip/warning when libbpf_num_possible_cpus()
is 1?

> +	printf("stress max callback visits: %llu (limit %u)\n",
> +	       (unsigned long long)skel->bss->stress_max_visits, max_entries);
> +cleanup:
> +	rhash__destroy(skel);
> +}

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/rhash.c b/tools/testing/selftests/bpf/progs/rhash.c
> index fc2dac3a719e..eca428db1fbc 100644
> --- a/tools/testing/selftests/bpf/progs/rhash.c
> +++ b/tools/testing/selftests/bpf/progs/rhash.c

[ ... ]

> +SEC("syscall")
> +int test_rhash_iter_stress(void *ctx)
> +{
> +	/*
> +	 * Concurrent rehash may produce duplicate visits. Check that the
> +	 * helper still gives one walk a finite callback bound; no snapshot
> +	 * or unique-visit guarantee is expected here.
> +	 */
> +	long visits;
> +
> +	visits = bpf_for_each_map_elem(&stress_rhmap, stress_iter_cb, NULL, 0);
> +	if (visits > stress_max_visits)
> +		stress_max_visits = visits;
> +	if (visits > RHASH_STRESS_MAX_ENTRIES)
> +		stress_overruns++;
> +	return 0;
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33200467478
--===============7842322834384672897==--
