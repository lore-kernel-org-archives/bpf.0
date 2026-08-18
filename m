Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AF3444719;
	Tue, 18 Aug 2026 09:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787045201; cv=none; b=gNoFKprwbyHIkY6Qx8hWMmO1rNqi4fifpFIcF0nopzNArn5+Mp5OId43Mkrqax4DJ7XrkQYfVgKRSA97QB39b7ccAJtXVJUVOboTWNTxI6AAWlLf3SFHAtbkmlhPacspj1ZPLhokMnT9Y+ZQN/HyUViFOsE+m5hy4NjxdmzUGnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787045201; c=relaxed/simple;
	bh=w2mXB+G2cqXpsbH5HZJcuinN+NMLVUNNsvMyIE6zyhw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ia0WidrzJt97Gk0quTN+VFwLHuW2egO9RcIgJfgsrWLA32TIujjlO2Xc10EJMs5YZdWHRIFbxPOP1PHwhh66cLcviE4lyib8v3DVZdnQSpTc7GZV85vbo5r+yLiZb328zPiNMtdqI+FhH045OuNnmA1qJliO5j0wA+8oeD1IZkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkJ6jLJQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkJ6jLJQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0521F000E9;
	Tue, 18 Aug 2026 09:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787045199;
	bh=PgMvfxbktmsh8z2sNcgfa34myhEySY7N/HUtGax5cqo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=JkJ6jLJQ8T/wSxS0RY7i5RH1Bu7AskrEnoJdB4WwKHO+iET/6x8BgIlPYRN33zjZw
	 4dhzUea+HMUaRR13Se9RCNr/UPDekI/JK+pnUIZDZ2WnpIkyJDNgq5HHjEBu1Cxox3
	 c+Jz7rYkP3ZZsAfEXESVX6DnI9zQQvtBJMRY3Tj4aWstGxEkZeQN/pqXJ4yhdbRZFY
	 E1gIEhvbN0UqjMoFLcVxb72Jf06clJpU6RrT3RDvOwyZk2Zrxdd7/OOIYsCAqVQeCi
	 YuizKLEo3L86JUEUfdjVWwu0hh7Vb5cqFZ8YIrNN8CXqk8ry+/iCALaZJj6rTuir+J
	 PVv/H/spSlYqQ==
Content-Type: multipart/mixed; boundary="===============1992217807985281510=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <839088e0c2d18d415b2acbcb4f4c09204d5cfdfb92d52f443cb802dcfffd41b2@mail.kernel.org>
In-Reply-To: <fbbeaf46501c66372d792c712349eac0205beea7.1787040082.git.zhuhui@kylinos.cn>
References: <fbbeaf46501c66372d792c712349eac0205beea7.1787040082.git.zhuhui@kylinos.cn>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: add memcg async reclaim test
From: bot+bpf-ci@kernel.org
To: hui.zhu@linux.dev,roman.gushchin@linux.dev,inwardvessel@gmail.com,shakeel.butt@linux.dev,akpm@linux-foundation.org,andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,baohua@kernel.org,geliang@kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-mm@kvack.org,linux-kselftest@vger.kernel.org
Cc: zhuhui@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 18 Aug 2026 09:26:39 +0000 (UTC)

--===============1992217807985281510==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Add memcg_async_reclaim selftest that verifies BPF-driven async
> proactive reclaim can mitigate refault-induced slowdown under memory
> pressure.
>
> The test creates a parent cgroup with a fixed memory.max, and two
> child cgroups (high/low) under it. Both children concurrently write
> and repeatedly read-fault a file larger than the shared limit. A BPF
> program monitors the "high" cgroup's WORKINGSET_REFAULT_FILE stat via
> a periodic timer, and when it detects refault growth beyond a
> threshold, triggers async reclaim on the "low" cgroup using
> bpf_proactive_reclaim(), expecting the "high" cgroup's workload to
> finish faster than without such reclaim. The reclaim work is queued
> asynchronously via bpf_wq.

Two claims in the changelog do not match the code being added. First,
"expecting the high cgroup's workload to finish faster than without such
reclaim": the test never runs a no-reclaim baseline.

test_memcg_wq_async_reclaim() calls run_high_low_workload() exactly once,
with the BPF program already loaded and its timer armed. The verdict is:

> +	if (high_time >= low_time)
> +		PRINT_FAIL("high cgroup not improved with async reclaim: high_time=%f low_time=%f",
> +			   high_time, low_time);

This compares the high cgroup against the low cgroup in the same run (the
cgroup that is being reclaimed and is therefore expected to be slower), not
against a run without reclaim. As written the test cannot detect that
reclaim failed to help the high cgroup; it only detects that reclaim hurt
the low cgroup.

Second, "a file larger than the shared limit": FILE_SIZE is
(32 * 1024 * 1024ul) and CG_LIMIT is (32 * 1024 * 1024ul) - each file is
exactly equal to, not larger than, the limit (only the sum of the two
children exceeds it).

Should the changelog or the test structure be corrected?

> diff --git a/tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c b/tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c
> new file mode 100644
> index 000000000000..6fab88203e7d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c

[ ... ]

> +static int setup_high_low_cgroups(u64 *high_cgroup_id, u64 *low_cgroup_id)
> +{
> +	int ret;
> +	char limit_buf[20];
> +
> +	ret = setup_cgroup_environment();
> +	if (!ASSERT_OK(ret, "setup_cgroup_environment"))
> +		goto cleanup;
> +
> +	ret = create_and_get_cgroup(CG_DIR);
> +	if (!ASSERT_GE(ret, 0, "create_and_get_cgroup " CG_DIR))
> +		goto cleanup;
> +	close(ret);
> +
> +	ret = enable_controllers(CG_DIR, "memory");
> +	if (!ASSERT_OK(ret, "enable_controllers"))
> +		goto cleanup;
> +
> +	snprintf(limit_buf, sizeof(limit_buf), "%lu", CG_LIMIT);
> +	ret = write_cgroup_file(CG_DIR, "memory.max", limit_buf);
> +	if (!ASSERT_OK(ret, "write_cgroup_file memory.max"))
> +		goto cleanup;
> +
> +	ret = write_cgroup_file(CG_DIR, "memory.swap.max", "0");
> +	if (!ASSERT_OK(ret, "write_cgroup_file memory.swap.max"))
> +		goto cleanup;

A subsystem pattern flags this as potentially concerning: missing
prerequisites are turned into hard test failures instead of skips.

The enable_controllers(CG_DIR, "memory") call fails when the memory
controller is unavailable - CONFIG_MEMCG has no `default y` in
init/Kconfig and is not added to tools/testing/selftests/bpf/config by
this patch.

The write_cgroup_file(CG_DIR, "memory.swap.max", "0") call fails with
ENOENT when the kernel is built without CONFIG_SWAP, because the swap.max
cftype in mm/memcontrol.c lives inside #ifdef CONFIG_SWAP.

cgroup_helpers' __enable_controllers()/__write_cgroup_file() return 1 in
both cases, so ASSERT_OK() marks the test FAILED where the correct outcome
might be a skip with a reason. test_progs provides test__skip() for this
pattern.

Should this test distinguish between "feature absent" and "setup failed"?

[ ... ]

> +static int real_test_child_work(const char *cgroup_path, char *data_filename,
> +				char *time_filename, int read_times)
> +{
> +	struct timeval start, end;
> +	double elapsed;
> +	FILE *fp;
> +
> +	if (!ASSERT_OK(join_parent_cgroup(cgroup_path), "join_parent_cgroup"))
> +		return -1;
> +
> +	gettimeofday(&start, NULL);
> +
> +	if (!ASSERT_OK(write_file(data_filename), "write_file"))
> +		return -1;
> +
> +	if (!ASSERT_OK(read_file(data_filename, read_times), "read_file"))
> +		return -1;
> +
> +	gettimeofday(&end, NULL);

The elapsed time that becomes the test's only pass/fail criterion is
measured with gettimeofday(), i.e. CLOCK_REALTIME. A settimeofday()/NTP
step or a slew during the multi-second workload directly shifts elapsed.

The verdict in test_memcg_wq_async_reclaim() is an unmargined comparison
of two such numbers:

> +	if (high_time >= low_time)
> +		PRINT_FAIL("high cgroup not improved with async reclaim: high_time=%f low_time=%f",
> +			   high_time, low_time);

So a clock adjustment on the test host can flip the result in either
direction. Wall-clock timing in kernel selftests should use
clock_gettime(CLOCK_MONOTONIC).

Also, the comparison has no tolerance and the run is not repeated, so when
async reclaim happens to have little effect the sign of (high_time -
low_time) is decided by scheduling noise.

Would a minimum-improvement margin or best-of-N approach make the criterion
more meaningful?

> +
> +	if (!time_filename)
> +		return 0;
> +
> +	elapsed = (end.tv_sec - start.tv_sec) +
> +		  (end.tv_usec - start.tv_usec) / 1000000.0;
> +	printf("%.6f\n", elapsed);
> +
> +	fp = fopen(time_filename, "w");
> +	if (!ASSERT_OK_PTR(fp, "fopen"))
> +		return -1;
> +	fprintf(fp, "%.6f", elapsed);
> +	fclose(fp);
> +
> +	return 0;
> +}

real_test_child_work() runs in a fork()ed child:

> +	low_pid = fork();
> +	if (!ASSERT_GE(low_pid, 0, "fork low"))
> +		goto cleanup;
> +	if (low_pid == 0)
> +		exit(real_test_child_work(CG_LOW_DIR, low_data_file,
> +					  low_time_file, read_times));

and every diagnostic it produces is discarded.

test_progs' stdio_hijack_init() replaces both stdout and stderr with an
open_memstream() FILE* whose buffer lives in the test process' heap
(tools/testing/selftests/bpf/test_progs.c). After fork() the child writes
into its private copy of that buffer, which is freed when the child exits.

So the ASSERT_OK("join_parent_cgroup"/"write_file"/"read_file") messages,
cgroup_helpers' log_err() output and read_file()'s "File size mismatch"
fprintf(stderr, ...) never reach the test log. The parent only ever sees
`high exit status: actual 255 != expected 0` from run_high_low_workload(),
with no indication of which step failed.

Should the child report failures through something the parent can observe
(distinct exit codes, or the already-created time file / a pipe)?

[ ... ]

> +void test_memcg_wq_async_reclaim(void)
> +{
> +	u64 high_cgroup_id, low_cgroup_id;
> +	int err;
> +	double high_time = 0.0, low_time = 0.0;
> +	struct memcg_async_reclaim *skel = NULL;
> +
> +	err = setup_high_low_cgroups(&high_cgroup_id, &low_cgroup_id);
> +	if (!ASSERT_OK(err, "setup_high_low_cgroups reclaim"))
> +		return;
> +
> +	err = setup_bpf(high_cgroup_id, low_cgroup_id, &skel);
> +	if (!ASSERT_OK(err, "setup_bpf"))
> +		goto out;
> +
> +	err = run_high_low_workload(&high_time, &low_time, READ_TIMES);
> +	if (!ASSERT_OK(err, "run_high_low_workload reclaim"))
> +		goto out;
> +
> +	if (high_time >= low_time)
> +		PRINT_FAIL("high cgroup not improved with async reclaim: high_time=%f low_time=%f",
> +			   high_time, low_time);

The pass criterion does not check what the changelog claims and has no
tolerance.

The commit message says the test triggers reclaim on the low cgroup
"expecting the 'high' cgroup's workload to finish faster than without such
reclaim", but no no-reclaim baseline is ever measured. run_high_low_workload()
is called exactly once, with the BPF timer already armed, and the only
comparison is high_time vs low_time inside that single run.

There is also nothing that verifies any reclaim actually happened (the BPF
side exposes no counter to userspace, and the test does not read one), so a
kernel where bpf_proactive_reclaim() reclaims nothing is indistinguishable
from a working one apart from timing noise.

Finally, the check is a bare >= on two wall-clock doubles measured in two
separate processes running the same 32MB/50-iteration workload, with no
margin: the two children are symmetric apart from being forked a few
microseconds apart, so ordinary run-to-run variance decides the verdict.

Should the changelog describe what is actually asserted, or should the test
measure a baseline run and/or export a reclaim counter from the BPF program
and require a minimum improvement margin before declaring success?

> diff --git a/tools/testing/selftests/bpf/progs/memcg_async_reclaim.c b/tools/testing/selftests/bpf/progs/memcg_async_reclaim.c
> new file mode 100644
> index 000000000000..62c2bb7e037b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/memcg_async_reclaim.c

[ ... ]

> +static int get_cgroup_event(u64 cgroup_id, u64 *val)
> +{
> +	struct cgroup_memcg cm;
> +
> +	if (get_cgroup_memcg_from_id(cgroup_id, &cm))
> +		return -1;
> +	bpf_mem_cgroup_flush_stats(cm.memcg);
> +	*val = bpf_mem_cgroup_page_state(cm.memcg, WORKINGSET_REFAULT_FILE);
> +	put_cgroup_memcg(&cm);
> +
> +	return 0;
> +}

WORKINGSET_REFAULT_FILE is an 'enum node_stat_item' value
(include/linux/mmzone.h) that is baked into the object file as a plain
integer taken from whatever vmlinux.h the object was compiled against.

'enum node_stat_item' is not a stable ABI - it is built up from NR_LRU_BASE
and contains config-dependent members - so the numeric index is only
guaranteed to match the kernel the object was compiled against.

The only other BPF selftest that uses this same kfunc family,
progs/cgroup_iter_memcg.c, deliberately wraps every index:

	memcg_query.nr_anon_mapped = bpf_mem_cgroup_page_state(
		memcg,
		bpf_core_enum_value(enum node_stat_item, NR_ANON_MAPPED));

Should this program use bpf_core_enum_value(enum node_stat_item,
WORKINGSET_REFAULT_FILE), so that the index is CO-RE relocated against the
running kernel? Without it, an object built against a different kernel
silently samples the wrong counter, and because the test's only assertion is
a wall-clock comparison the mis-sample shows up as an unexplained failure.

(This also requires including <bpf/bpf_core_read.h>, which the new program
does not.)

[ ... ]

> +static int async_free(void *map, int *key, void *value)
> +{
> +	struct wq_elem *elem = value;
> +
> +	if (should_reclaim_cgroup(wq_high_cgroup_id, &elem->prev_event,
> +		elem->event_delta_threshold)) {
> +		reclaim_cgroup(wq_low_cgroup_id);
> +		bpf_wq_start(&elem->work, 0);
> +	}
> +
> +	return 0;
> +}

async_free() is the bpf_wq callback installed by bpf_wq_set_callback(&elem->work,
async_free, 0), and it re-arms its own work item with bpf_wq_start(&elem->work, 0)
with no delay and no iteration cap.

bpf_wq_work() (kernel/bpf/helpers.c) is a plain work_struct handler, so
process_one_work() has already cleared WORK_STRUCT_PENDING by the time the
BPF callback runs; schedule_work() inside bpf_wq_start() therefore queues
the item again and the callback runs back-to-back.

The design already has a pacing mechanism:

> +static int wq_timer_cb(void *map, int *key, struct wq_elem *elem)
> +{
> +	bpf_wq_start(&elem->work, 0);
> +	bpf_timer_start(&elem->timer, elem->check_ns, 0);
> +
> +	return 0;
> +}

wq_timer_cb() kicks the wq once every elem->check_ns (CHECK_PERIOD_NS = 2 ms
in prog_tests/memcg_async_reclaim.c) and then re-arms the timer. The
self-requeue in async_free() bypasses that pacing entirely.

The only exit condition is should_reclaim_cgroup() returning false, i.e. the
WORKINGSET_REFAULT_FILE delta between two consecutive, zero-delay samples
falling below elem->event_delta_threshold - and the userspace test sets
EVENT_DELTA_THRESHOLD to 1, so a single refault event observed between two
samples keeps the loop going.

Each loop iteration does bpf_mem_cgroup_flush_stats() (rstat flush, walks
per-CPU state) plus up to RECLAIM_MAX_ITER (32) try_to_free_mem_cgroup_pages()
passes on the low cgroup, and re-acquires/releases the cgroup and memcg
references twice. Loop termination is not structurally guaranteed - it
depends entirely on how fast mem_cgroup_flush_stats()'s rate limiter lets the
cached counter advance.

While it spins it burns a workqueue worker and drives continuous reclaim,
which also perturbs the wall-clock comparison (high_time vs low_time) that is
the test's only assertion.

Should the bpf_wq_start() at the end of async_free() be dropped (the timer
already re-kicks the work every check_ns), or should the repeat have an
explicit bound/delay?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32118218829
--===============1992217807985281510==--
