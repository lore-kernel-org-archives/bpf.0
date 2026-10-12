Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6457A323417;
	Mon, 12 Oct 2026 16:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791822811; cv=none; b=uxG7FhyOwR9LNZkK3leP0/JIILoF0KQlI6CpMoTDZvGLDcD+C7jAsFyUcImjN7LLQjkoTeB9y7x4yABpYJDZKwhTzWJuPz1xuJVECdyJqQjdEefShawPZOLsJ4ML5bciQsSa4HCgAQRmrAiUzfGUPNiGN5TCdY29dEkEyg7etoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791822811; c=relaxed/simple;
	bh=jF4a8vEj4kKnYtkGomlyncS/Qcm/AMMDr/4fp6Y4520=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=VfG3SgrlR7MT0JvZdlE9CutZ0JR+FUlPZ2kItUSnzPSwIgmrBFOfDiU1M0Kfc3xUXmeoJEeEuS4RrI2wLoHRCqCLSLPmIWg7k3hhIFXYNlAHfEcQmQHvh2uYV3BLCujvR3p7xvaS0kwV93T2yxE/Wnay+Wu9UhDhDKdYNFUuIi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtOFj2yl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtOFj2yl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7821F0089B;
	Mon, 12 Oct 2026 16:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791822810;
	bh=dO0ntYknr/yLzVx5wLAfTgB8wcjax7gjtA2eSSlm094=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=JtOFj2ylpxPKwcih3U3vpAoiM6jlNrcWPVnpqhF1nfnQ/IFTZxA2PGeiYREoOfnLm
	 FNWstibW2ZLPjWeCXCwpbtNeB/dvE2LyWqOAKRnrPN5vLCwIU/o/hRIpHLT79eHS04
	 +uC8d1ti+ZxXEc8JWxQCKAt3iSij5IRv9Zcstb4URFhUiFZjN12gTNVniHXiqco7bt
	 hVdRyqQgk4lS/PtexA+/dbadO7MUubghS8ii573/nYfdZsBISFPnN7GjVfZeHmdAyy
	 IgKdeC0K6Q1jgpIqhb6fbtL9K8VKKwKUfcwSKcF9fBuS9mwkpfVX6jlChP+9LjiGzd
	 q3t92AFWT882g==
Content-Type: multipart/mixed; boundary="===============0469878428734354257=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <27aefec2042b0eb39044c3ddab44fccc3f93716d149162280311228e9de9d169@mail.kernel.org>
In-Reply-To: <20261012154024.29423-22-leon.hwang@linux.dev>
References: <20261012154024.29423-22-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v2 21/21] selftests/bpf: Benchmark tracing_multi bpf progs attachment
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,qmo@kernel.org,shuah@kernel.org,leon.hwang@linux.dev,yatsenko@meta.com,avinash.duduskar@gmail.com,a.s.protopopov@gmail.com,ameryhung@gmail.com,jordan@jrife.io,rongtao@cestc.cn,eyal.birger@gmail.com,pulehui@huawei.com,tanjingguo@huawei.com,malin89@huawei.com,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 12 Oct 2026 16:33:27 +0000 (UTC)

--===============0469878428734354257==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Benchmark tracing_multi bpf progs attachment

TL;DR:
- Benchmark may hit EMFILE with default fd limits (about 5000 fds needed) and
  exit
- Reported 7.14x speedup compares unequal work: fentry timing includes load
  and BTF resolution

> diff --git a/tools/testing/selftests/bpf/benchs/bench_tracing_multi_attach_progs.c b/tools/testing/selftests/bpf/benchs/bench_tracing_multi_attach_progs.c
> new file mode 100644
> index 000000000000..6cc6851eb488
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/benchs/bench_tracing_multi_attach_progs.c
> @@ -0,0 +1,193 @@

[ ... ]

> +static void prepare(void)
> +{
>
> [ ... ]
>
> +		bpf_program__set_autoload(target->progs.dummy_fentry, false);
> +		bpf_program__set_autoload(target->progs.dummy_fentry_multi, false);
> +		err = tracing_multi_attach_progs__load(target);
> +		if (err) {
> +			fprintf(stderr, "failed to load target program %d: %s\n",
> +				i, strerror(-err));
> +			exit(1);
> +		}

Does this benchmark need more than the default RLIMIT_NOFILE?

Every loaded skeleton keeps two fds open until __destroy(), the object BTF
fd and the program fd.  The BTF fd is not released after load:

bpf_object_load()
  bpf_object_post_load_cleanup()
    bpf_object_cleanup_btf()

only frees the module/vmlinux BTF, while obj->btf and its fd stay open until
bpf_object__close().  So prepare() alone holds about 2 * TARGET_CNT = 2000
fds for the 1000 target objects.

create_and_attach_fentry() then adds roughly 2000 more for the 1000 fentry
skeletons, plus 1000 entries in link_fds[], for a peak of about 5000 open
fds.

Nothing in bench.c, testing_helpers or libbpf raises RLIMIT_NOFILE (the only
RLIMIT_NOFILE user in selftests/bpf is map_tests/sk_storage_map.c).  With a
1024 soft limit, './bench tracing-multi-attach-progs' looks like it would
hit EMFILE at around target 510 in prepare() and exit(1).  Even a 4096 hard
limit is below the peak reached in create_and_attach_fentry().

Should setup() or prepare() raise RLIMIT_NOFILE, as sk_storage_map.c does, or
should the 'ulimit -n' requirement be documented in the commit message?

[ ... ]

> +static long create_and_attach_fentry(void)
> +{
> +	int link_fds[TARGET_CNT];
> +	long start_ns, end_ns;
> +	int err, i, j;
> +
> +	start_ns = get_time_ns();
> +
> +	/* An ordinary fentry program is bound to one target when it is loaded. */
>
> [ ... ]
>
> +		err = bpf_program__set_attach_target(fentry->progs.dummy_fentry, ctx.target_fds[i],
> +						     "target");
> +		err = err ?: tracing_multi_attach_progs__load(fentry);
>
> [ ... ]
>
> +	for (i = 0; i < TARGET_CNT; i++) {
> +		link_fds[i] = bpf_link_create(ctx.fentry_prog_fds[i], 0, BPF_TRACE_FENTRY, NULL);
> +		if (link_fds[i] < 0) {
>
> [ ... ]
>
> +	end_ns = get_time_ns();

The commit message describes this as a comparison of "1000 individual
fentry link creations with one fentry.multi link creation", but do the two
timed regions measure the same work?

The fentry window starts at the get_time_ns() above, before the first loop,
so it covers:

  1000 x tracing_multi_attach_progs__open()
  1000 x bpf_program__set_attach_target()
  1000 x tracing_multi_attach_progs__load()
  1000 x bpf_link_create()

Each bpf_program__set_attach_target() call goes through
libbpf_find_prog_btf_id(), which does bpf_prog_get_info_by_fd() and loads
and parses the target BTF from the kernel.  The load calls add 1000 object
BTF loads and 1000 verifier and JIT runs.

The fentry.multi window in create_and_attach_fentry_multi() covers one
open+load and one bpf_link_create().  Its 1000 target BTF IDs were already
resolved in prepare(), outside the timed region (ctx.target_btf_ids[i] =
btf_id).

So the reported "fentry.multi creation/attachment speedup is 7.14x" is not
a link-creation comparison.  Part of it comes from BTF ID resolution being
timed for fentry but not for fentry.multi, and most of it is probably the
cost of loading 1000 programs versus one.

Would it make sense to time only the bpf_link_create() loop on its own and
resolve BTF IDs on the same side of the timer for both paths?  Otherwise,
could the commit message say that the numbers cover program creation and BTF
ID resolution as well as attachment?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38273555988
--===============0469878428734354257==--
