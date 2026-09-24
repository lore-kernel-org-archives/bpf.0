Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AA6DDA9;
	Thu, 24 Sep 2026 17:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790272419; cv=none; b=oEGQOkWdD7ptYohvYKGLFkRo3qah0eZm+ChMZWqMpnf9pusdfWYk3HDEMQ0s7seaThaDhA54KQIrq+RLzeSCBnsoXPh9ImrqK4u61A3AsJr3Sl1Q5yPI+ot5meQUv1D43ESDMamExjxS+kOusvYAx+o+AqViTPKTWaNYlDovHKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790272419; c=relaxed/simple;
	bh=kJnwXJt8x25uiov7kuDwLLMKBOyadOT3tRfrITNfba0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Ep8XnSeLRel7ao9OKpt6Bnbd+uMrRkjBpbz2kEIHc3YU0R/NswimHlKibMypOSIa2di0xV1xxbzqnwtK2d4WC3+Kg4drN7QDFyq9Vgvnlqi+Fq+rdCVwZy07wHra80sHwuQZTr7iDu4J+H0vOGazbnbCgZyOWzdO4cLkhTbcPnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efrgByyQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efrgByyQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654A21F000FF;
	Thu, 24 Sep 2026 17:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790272418;
	bh=4UPw7OXirCe0mF0T2wa7/6PbS5yUoNJ22h+T3YjbRl8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=efrgByyQk4aaVEdaC18avWJMFAEbxwh00sDdZjeO1fvqXeNZ0RJnKuGozi75Ps6MV
	 j+mpMpel0P2r+94rRysc6FBzSiO5lXIPpgrfBzenW8BFII5cmj4JW/eRwrTNcro5bl
	 uYOmcBdTvI7LZWHjkxcpW+clt+h6/nY8vV/RUW1hLuxOF1lkNN/cBA4tMb0GtjuRdp
	 ljOSoFtXG/MpOjQPG8VDGja8imGuB3ROlfgiD6a3CCZmH+Z+/rjQGiWSm1YZEShup2
	 BwBcL98oKW5gtoKi0shBL4yYm19ZIGYfJ/HyfcDKQoWobJUiu5bltWOPaUnLtbp/pq
	 ooY1qgCZkF5KQ==
Content-Type: multipart/mixed; boundary="===============7400983552028659018=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9ff9f911b980da0e9100578ccf6dba5c7a5414e0b0075922e750161220370554@mail.kernel.org>
In-Reply-To: <20260924170543.1017048-4-florent.revest@linux.dev>
References: <20260924170543.1017048-4-florent.revest@linux.dev>
Subject: Re: [PATCH bpf v3 3/3] selftests/bpf: Detach a trampoline prog while a task sleeps before it
From: bot+bpf-ci@kernel.org
To: florent.revest@linux.dev,bpf@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: florent.revest@linux.dev,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,kpsingh@kernel.org,john.fastabend@gmail.com,leon.hwang@linux.dev,zirajs7@gmail.com,rhkrqnwk98@gmail.com,puranjay@kernel.org,xukuohai@huaweicloud.com,iii@linux.ibm.com,hbathini@linux.ibm.com,chleroy@kernel.org,naveen@kernel.org,bjorn@kernel.org,pulehui@huawei.com,yangtiezhu@loongson.cn,hengqi.chen@gmail.com,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 24 Sep 2026 17:53:34 +0000 (UTC)

--===============7400983552028659018==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_mod_race.c b/tools/testing/selftests/bpf/prog_tests/bpf_mod_race.c
> index ecc3d47919ad..f8497e764beb 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_mod_race.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_mod_race.c

[ ... ]

> diff --git a/tools/testing/selftests/bpf/prog_tests/tramp_prog_detach.c b/tools/testing/selftests/bpf/prog_tests/tramp_prog_detach.c
> new file mode 100644
> index 000000000000..002eb4920c91
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/tramp_prog_detach.c

[ ... ]

> +static void test_detach(bool sleepable_fexit, bool victim_fexit)
> +{
> +	struct tramp_prog_detach *sleepable = NULL, *victim = NULL;
> +	struct pollfd pfd = { .events = POLLIN };
> +	struct uffdio_copy uffd_copy = {};
> +	struct uffd_msg uffd_msg;
> +	void *fault_page, *src_page = MAP_FAILED;
> +	long page_size = getpagesize();
> +	bool started = false;
> +	void *thread_ret;
> +	pthread_t thread;
> +	int uffd = -1;

[ ... ]

> +	sleepable_prog = pick_prog(sleepable, sleepable_fexit, true);
> +
> +	/* Not armed yet so this doesn't block, make sure sleepable runs first */
> +	if (!ASSERT_OK((long)run_sleepable(NULL), "dry run"))
> +		goto out;
> +	if (!ASSERT_LT(sleepable->bss->ts, victim->bss->ts, "prog order"))
> +		goto out;
> +
> +	uffd = uffd_block_page(fault_page);
> +	if (!ASSERT_GE(uffd, 0, "userfaultfd open + register address"))
> +		goto out;

A subsystem pattern flags this as potentially concerning: uffd_block_page()
returns -errno when syscall(__NR_userfaultfd, O_CLOEXEC) fails. On a kernel
without CONFIG_USERFAULTFD that is -ENOSYS, and the test then fails through
ASSERT_GE() instead of calling test__skip() with a message saying userfaultfd
is not available. While tools/testing/selftests/bpf/config sets
CONFIG_USERFAULTFD=y so the BPF CI kernel always has it, and the same
ASSERT_GE pattern already exists in bpf_mod_race.c (serial_test_bpf_mod_race)
from before this commit, is this the intended behavior for environments
without userfaultfd support?

> +	sleepable->bss->fault_addr = fault_page;
> +
> +	if (!ASSERT_OK(pthread_create(&thread, NULL, run_sleepable, NULL),
> +		       "pthread_create"))
> +		goto out;
> +	started = true;
> +
> +	/* Wait for the thread to sleep in bpf_copy_from_user() */
> +	pfd.fd = uffd;
> +	if (!ASSERT_EQ(poll(&pfd, 1, 10000), 1, "poll uffd"))
> +		goto out;
> +	if (!ASSERT_EQ(read(uffd, &uffd_msg, sizeof(uffd_msg)), sizeof(uffd_msg),
> +		       "read uffd"))
> +		goto out;
> +	if (!ASSERT_EQ(uffd_msg.event, UFFD_EVENT_PAGEFAULT, "uffd pagefault"))
> +		goto out;
> +
> +	/* Detach and unload the victim prog, and make sure it is gone */
> +	tramp_prog_detach__destroy(victim);
> +	victim = NULL;
> +	kern_sync_rcu();
> +	usleep(100 * 1000);
> +	kern_sync_rcu();

Does this wait actually ensure the victim prog is gone before the task
resumes?

The test only catches the use-after-free if the victim prog has actually been
freed before UFFDIO_COPY releases the sleeping task. The wait here does not
guarantee that, and on the kernel this series produces it most likely is not
freed yet.

Commit 1c2316cf73ba ("bpf: Wait for an RCU tasks grace period before freeing
trampoline progs") changed __bpf_prog_put_noref() so that a tramp_linked
prog is freed through call_rcu_tasks(&prog->aux->rcu, __bpf_prog_put_rcu_tasks),
then call_rcu(), then bpf_prog_free(), which calls schedule_work() for the
final vfree.

RCU Tasks callbacks are lazy. call_rcu_tasks_generic() only sets needwake
for wakeme_after_rcu (a synchronous waiter) or when the queue reaches
rcu_task_lazy_lim. Otherwise it arms lazy_timer with rcu_tasks.lazy_jiffies
= DIV_ROUND_UP(HZ, 4) (kernel/rcu/tasks.h:145), which is about 250ms by
default.

Nothing on the detach path forces a synchronous RCU Tasks wait. Detaching
the victim while the sleepable prog stays attached goes through
modify_ftrace_direct(), and its tmp_ops is static, so it is not
FTRACE_OPS_FL_DYNAMIC and ftrace_shutdown() does not call
synchronize_rcu_tasks().

The test waits only kern_sync_rcu() + 100ms + kern_sync_rcu().
kern_sync_rcu() is membarrier(MEMBARRIER_CMD_SHARED), which is
synchronize_rcu() on SMP and a no-op with one CPU online. That is well short
of 250ms lazy delay + RCU Tasks GP + RCU GP + workqueue.

So when the thread resumes in the old image, the victim's bpf_prog and JIT
image are usually still allocated. On a kernel that has 1c2316cf73ba but
lacks 2ece3357872c (or breaks it later), the thread would run the victim
prog without a KASAN report and the test would pass.

Consider waiting well beyond the RCU Tasks lazy period (for example about 1s,
or polling until the victim prog ID is no longer returned by
bpf_prog_get_next_id()/bpf_prog_get_fd_by_id()) before releasing the thread.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36034251810
--===============7400983552028659018==--
