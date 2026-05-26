Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE9D3955C1
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 03:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779764784; cv=none; b=lg9Hgmt52UVixamB0hyn5yL2uFophblQLnF7iUKjd78tyY5iIzHEqkLpfuWHkODKDRiUMSB3/jzbp/I/fgOuO/+h3BlDoccjhWFjntwRsHlM8FkjdgQ1eRa/JI6/j9iJq4aUF6nn753prQGeftyuUE1QMnKV8bAOzhPKVOChzPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779764784; c=relaxed/simple;
	bh=ZYQJjYUtEm0QnEmNIebtbpmQ48wEvaPB7OLHfrgiXbM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cHrjXppvo5fuHW+JR0nYocYKhPsH+MFM/KYgJ1TmKqclzKzHJ/WdITBJT568rQ+wmo0wOHk5gGujsxhCRddza5qoA29eNzUvokpLhduQrwZb761jpCsH8YO59paElCxFj5mFHt+JgVNaFwRnOtye3NVevMX1xygn3VOSkTyofgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKO7kxCE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKO7kxCE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2967E1F00A3A;
	Tue, 26 May 2026 03:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779764782;
	bh=v+0yQ3pV0FseQWa8Z4enQRuNuO8nEk6wlNQxDeLRRH4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XKO7kxCEWnjBpnSEOzFYqvb6XxMKFfIcv1yaNmdRqObsjhEvWUoxuAN5824cg4NI4
	 JsAmK/R+QKD2q/kKwcliqRhYKXWm6ac9EG3aVgcnsfoG1pRLK8B4Ao0mYaiYkxFx/+
	 tDt9qFBZgmFapwVz31FpY4HmwCg3ss7VgWv492RoBrbTuTBKIKIO9KK4BTqJKYHAxk
	 +kc8l7MpJ4TqbcviWZqeoOxmKQ+n8O9CNaHQpotPY874bK8daEkC7SBHSx1mVWKxGz
	 PSauLQ/U1z3It5Ji5SSbDmcJTCiiHMnF4e8J0VUnHBWOzOMaK4ty1lj2nF1NIRst9w
	 rl9dsTpntrIZg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next v7 10/11] selftests/bpf: Add selftest for
 memcg async reclaim via BPF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Zhu" <hui.zhu@linux.dev>
Cc: hannes@cmpxchg.org, tj@kernel.org, mkoutny@suse.com, bpf@vger.kernel.org
In-Reply-To: <b3af3d0f9a925f79a6e4e7218e8ce84dfbeb5254.1779760876.git.zhuhui@kylinos.cn>
References: <b3af3d0f9a925f79a6e4e7218e8ce84dfbeb5254.1779760876.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 03:06:21 +0000
Message-Id: <20260526030622.2967E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [High] The inline assembly intended to trigger page faults evaluates the =
pointer address but does not dereference it.
- [High] Hardcoded `ONE_MB_PAGE_COUNT` assumes a 4KB page size, leading to =
integer underflow on architectures with larger page sizes.
- [Medium] Test uses `/tmp/` for file I/O, which breaks memory reclaim and =
causes OOM kills if `/tmp/` is mounted as `tmpfs`.
- [Medium] The test is structurally flawed and highly racy because the asyn=
chronous BPF workqueue cannot keep up with the synchronous high-speed file =
writes.
- [Medium] Failure paths fail to reset the `async_free_run` lock state, per=
manently deadlocking the async reclaim mechanism.
- [Medium] The helper `get_cgroup_memcg_from_id` stores acquired references=
 into a struct passed by pointer, causing verifier rejection if not inlined.
- [Low] Incorrect format specifier `%lu` used for formatting a `u64` variab=
le.
- [Low] Double close of the `cgroup_fd` during the error handling path for =
the second test phase.
--

commit 52716fb46cd2997bdfa1c7eea08763279dccc7d6
Author: Hui Zhu <zhuhui@kylinos.cn>

selftests/bpf: Add selftest for memcg async reclaim via BPF
   =20
Add a BPF selftest that demonstrates and validates asynchronous memory
reclaim for a memory cgroup using BPF struct_ops and the BPF workqueue
mechanism.

> diff --git a/tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c=
 b/tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c
> new file mode 100644
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c
[ ... ]
> +static int
> +setup_max_cgroup(const char *cg_path, u64 cg_max, u64 *cgroup_id,
> +		 int *cgroup_fd)
> +{
> +	int ret;
> +	char limit_buf[20];
> +
> +	*cgroup_fd =3D create_and_get_cgroup(cg_path);
> +	if (!ASSERT_GE(*cgroup_fd, 0, "create_and_get_cgroup"))
> +		goto cleanup;
> +
> +	*cgroup_id =3D get_cgroup_id(cg_path);
> +	if (!ASSERT_GT(*cgroup_id, 0, "get_cgroup_id"))
> +		goto cleanup;
> +
> +	snprintf(limit_buf, 20, "%lu", cg_max);

[Severity: Low]
Can this truncate the u64 value on 32-bit architectures? Passing a u64 to
"%lu" might be architecturally unsafe. Should "%llu" be used instead to ens=
ure
proper formatting across all platforms?

[ ... ]
> +static int read_file(const char *filename, int iterations)
> +{
[ ... ]
> +	for (int iter =3D 0; iter < iterations; iter++) {
> +		for (i =3D 0; i < FILE_SIZE; i +=3D page_size) {
> +			/* access a byte to trigger page fault */
> +			p =3D &map[i];
> +			__asm__ __volatile__("" : : "r"(p) : "memory");
> +		}

[Severity: High]
Does this inline assembly correctly trigger a page fault? The register
constraint "r"(p) loads the pointer address without forcing a memory read,
which means the test might fail to generate actual memory pressure. Would it
be better to use "r"(*p) or a memory constraint to ensure the address is
dereferenced?

[ ... ]
> +void test_memcg_async_reclaim(void)
> +{
> +	u64 cgroup_id, old_max, new_max;
> +	int cgroup_fd, ret;
> +	struct memcg_async_reclaim *skel;
> +	struct bpf_link *link =3D NULL;
> +	char data_file1[] =3D "/tmp/test_data_1_XXXXXX";
> +	char data_file2[] =3D "/tmp/test_data_2_XXXXXX";

[Severity: Medium]
Will this test run reliably if /tmp/ is mounted as tmpfs? Shmem pages
without swap backing are unreclaimable, which might bypass the BPF program
entirely and cause OOM kills in test environments using tmpfs. Could migrat=
ing
to a block-backed path be more robust?

[ ... ]
> +	if (!ASSERT_OK(get_cgroup_memory_event(CG_DIR1, "max", &old_max),
> +					       "get_cgroup_memory_event"))
> +		goto cleanup_data_file1;
> +	if (!ASSERT_OK(write_file(data_file1), "write_file"))
> +		goto cleanup_data_file1;
> +	if (!ASSERT_OK(read_file(data_file1, 2), "read_file"))
> +		goto cleanup_data_file1;

[Severity: Medium]
Could this workload cause spurious test failures? Unthrottled file writes
might effortlessly outpace the 32-page asynchronous batches from the BPF
workqueue, resulting in direct reclaim triggering before the async batches
complete. Would throttling the foreground IO or scaling the batch sizes
prevent this structural race?

[ ... ]
> +	// test with async_reclaim
> +	close(cgroup_fd);
> +	if (!ASSERT_OK(setup_max_cgroup(CG_DIR2, CG_LIMIT, &cgroup_id,
> +					&cgroup_fd), "setup_max_cgroup"))
> +		goto cleanup_data_file1;

[Severity: Low]
If setup_max_cgroup() fails, it closes its internal file descriptor on its
error path. Jumping to cleanup_data_file1 will eventually fall through to
close_cgroup_fd, which closes the fd again. Should the fd be set to -1
after closing, or the cleanup labels restructured to avoid a double-close?

> diff --git a/tools/testing/selftests/bpf/progs/memcg_async_reclaim.c b/to=
ols/testing/selftests/bpf/progs/memcg_async_reclaim.c
> new file mode 100644
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/memcg_async_reclaim.c
[ ... ]
> +static int get_cgroup_memcg_from_id(u64 cgroup_id, struct cgroup_memcg *=
cm)
> +{
> +	cm->cgrp =3D bpf_cgroup_from_id(cgroup_id);
> +	if (!cm->cgrp)
> +		return -1;
> +
> +	cm->memcg =3D bpf_get_mem_cgroup(&cm->cgrp->self);
> +	if (!cm->memcg) {
> +		bpf_cgroup_release(cm->cgrp);
> +		return -1;
> +	}
> +
> +	return 0;
> +}

[Severity: Medium]
Will the BPF verifier reject this program because it stores acquired
references into an indirect stack pointer (struct cgroup_memcg *cm) within a
subprogram? Applying __always_inline to this helper might resolve the safety
violation.

[ ... ]
> +static int async_free(void *map, int *key, void *value)
> +{
> +	struct cgroup_memcg cm;
> +	bool started_wq =3D false;
> +
> +	if (get_cgroup_memcg_from_id(bpf_args.cgroup_id, &cm) !=3D 0)
> +		return 0;
> +
> +	if (bpf_try_to_free_mem_cgroup_pages(cm.memcg, 32, GFP_KERNEL,
> +					     0, -1) > 0) {
> +		if (bpf_mem_cgroup_usage(cm.memcg) >=3D
> +		    bpf_args.limit_bytes - (ONE_MB_PAGE_COUNT * __PAGE_SIZE)) {

[Severity: High]
Does hardcoding ONE_MB_PAGE_COUNT to 256 cause issues on architectures with
page sizes larger than 4KB? For instance, evaluating 256 * 64KB produces a
16MB offset against a 12MB limit, causing massive unsigned integer underflow
and completely disabling asynchronous reclaim. Could a dynamic page size
calculation be used instead?

[ ... ]
> +SEC("struct_ops/memcg_charged")
> +unsigned int BPF_PROG(memcg_charged_impl, struct mem_cgroup *memcg,
> +		      unsigned int nr_pages)
> +{
[ ... ]
> +	if (__atomic_compare_exchange_n(&async_free_run,
> +					&expected, 1,
> +					false,
> +					__ATOMIC_ACQ_REL,
> +					__ATOMIC_RELAXED)) {
> +		elem =3D bpf_map_lookup_elem(&wq_map, &key);
> +		if (!elem)
> +			return 0;
> +
> +		bpf_wq_start(&elem->work, 0);
> +	}
> +
> +out:
> +	return 0;
> +}

[Severity: Medium]
Is there a scenario where this code permanently deadlocks the async reclaim
mechanism? If bpf_map_lookup_elem() fails, the function returns 0 without
resetting the async_free_run lock state, dropping the virtual lock forever.
Would it be safer to enforce unconditional flag clearance on all error path=
s?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1779760876.gi=
t.zhuhui@kylinos.cn?part=3D10
