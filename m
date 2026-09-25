Received: from mta0.migadu.com (out-15.mta0.migadu.com [91.218.175.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E94E48A8A7
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 10:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790330403; cv=none; b=XfgfpN7zhvTlY8IyF35cGJV79Bs/yX9fb5s08t2pQ6FONXqEQ2FtvQnVQbvOyE+PU4SVBZLjtwmPNsr5KALdAwcgcKTH4m2iAIVNbmJdGFXFjt8kxQrIngqffYqEeqL75cbgtaVxSK0uTU+qXCuyifTq7toloEuOp7Clmh5dob0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790330403; c=relaxed/simple;
	bh=oDrTnQSt3rnYXR+E6uqseuk/HuuLa/CRWtEAh3DDTwU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=kWW0QApdC5PUFYM6m9bYNyYo0p6yKCG7DA9Cp7F0k9WHAlaGImYbmofHI5pD9GINvcazGuC1meTSoZZrOQZtaw6w5XBIiHuWGxIfQP6+eN4NM/b50jC/8RukzZmSCx376s68XHYYVA9puHfwKrBAj6Ahlz6ILIkKUIXKSZFAfnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WwDc5QPs; arc=none smtp.client-ip=91.218.175.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WwDc5QPs"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=oDrTnQSt3rnYXR+E6uqseuk/HuuLa/CRWtEAh3DDTwU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790330398; v=1; x=1790935198;
 b=WwDc5QPs9jNc3Jp2/HT7frjq2oSUrqQTawXCGhMbFh2HzqsOp0VAt9EKwBA+Le955HKza73N
 qIT6wZbRmGEeGHAmuRByTZhHv6BFkB9qZ/P/U0L7J1NOfA9VjnPWU0mgoqrr8HSLKqouipXFl5+
 vVG3PfEAUmNpd0VK1EvKgg/k=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ea20b57e532c7474;
	Fri, 25 Sep 2026 09:59:58 +0000
X-Mizu-Trace-ID: ea20b57e532c7474
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Sep 2026 09:59:53 +0000
Message-Id: <DLOB5OKRK23X.1VAD9QKRHYJ35@linux.dev>
Cc: <martin.lau@linux.dev>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
 <kpsingh@kernel.org>, <john.fastabend@gmail.com>, <leon.hwang@linux.dev>,
 <zirajs7@gmail.com>, <rhkrqnwk98@gmail.com>, <puranjay@kernel.org>,
 <xukuohai@huaweicloud.com>, <iii@linux.ibm.com>, <hbathini@linux.ibm.com>,
 <chleroy@kernel.org>, <naveen@kernel.org>, <bjorn@kernel.org>,
 <pulehui@huawei.com>, <yangtiezhu@loongson.cn>, <hengqi.chen@gmail.com>,
 <linux-kernel@vger.kernel.org>, <martin.lau@kernel.org>,
 <eddyz87@gmail.com>, <yonghong.song@linux.dev>, <mason@kernel.org>,
 <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf v3 3/3] selftests/bpf: Detach a trampoline prog
 while a task sleeps before it
From: "Florent Revest" <florent.revest@linux.dev>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>
X-Mailer: aerc 0.17.0
References: <20260924170543.1017048-4-florent.revest@linux.dev>
 <9ff9f911b980da0e9100578ccf6dba5c7a5414e0b0075922e750161220370554@mail.kernel.org>
In-Reply-To: <9ff9f911b980da0e9100578ccf6dba5c7a5414e0b0075922e750161220370554@mail.kernel.org>

On Thu Sep 24, 2026 at 5:53 PM UTC,  wrote:
> > diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_mod_race.c b/to=
ols/testing/selftests/bpf/prog_tests/bpf_mod_race.c
> > index ecc3d47919ad..f8497e764beb 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/bpf_mod_race.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/bpf_mod_race.c
>
> [ ... ]
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/tramp_prog_detach.c=
 b/tools/testing/selftests/bpf/prog_tests/tramp_prog_detach.c
> > new file mode 100644
> > index 000000000000..002eb4920c91
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/tramp_prog_detach.c
>
> [ ... ]
>
> > +static void test_detach(bool sleepable_fexit, bool victim_fexit)
> > +{
> > +	struct tramp_prog_detach *sleepable =3D NULL, *victim =3D NULL;
> > +	struct pollfd pfd =3D { .events =3D POLLIN };
> > +	struct uffdio_copy uffd_copy =3D {};
> > +	struct uffd_msg uffd_msg;
> > +	void *fault_page, *src_page =3D MAP_FAILED;
> > +	long page_size =3D getpagesize();
> > +	bool started =3D false;
> > +	void *thread_ret;
> > +	pthread_t thread;
> > +	int uffd =3D -1;
>
> [ ... ]
>
> > +	sleepable_prog =3D pick_prog(sleepable, sleepable_fexit, true);
> > +
> > +	/* Not armed yet so this doesn't block, make sure sleepable runs firs=
t */
> > +	if (!ASSERT_OK((long)run_sleepable(NULL), "dry run"))
> > +		goto out;
> > +	if (!ASSERT_LT(sleepable->bss->ts, victim->bss->ts, "prog order"))
> > +		goto out;
> > +
> > +	uffd =3D uffd_block_page(fault_page);
> > +	if (!ASSERT_GE(uffd, 0, "userfaultfd open + register address"))
> > +		goto out;
>
> A subsystem pattern flags this as potentially concerning: uffd_block_page=
()
> returns -errno when syscall(__NR_userfaultfd, O_CLOEXEC) fails. On a kern=
el
> without CONFIG_USERFAULTFD that is -ENOSYS, and the test then fails throu=
gh
> ASSERT_GE() instead of calling test__skip() with a message saying userfau=
ltfd
> is not available. While tools/testing/selftests/bpf/config sets
> CONFIG_USERFAULTFD=3Dy so the BPF CI kernel always has it, and the same
> ASSERT_GE pattern already exists in bpf_mod_race.c (serial_test_bpf_mod_r=
ace)
> from before this commit, is this the intended behavior for environments
> without userfaultfd support?

This is the same as bpf_mod_race. CONFIG_USERFAULTFD is in the selftests co=
nfig
so I'd just leave it like that.

> > +	sleepable->bss->fault_addr =3D fault_page;
> > +
> > +	if (!ASSERT_OK(pthread_create(&thread, NULL, run_sleepable, NULL),
> > +		       "pthread_create"))
> > +		goto out;
> > +	started =3D true;
> > +
> > +	/* Wait for the thread to sleep in bpf_copy_from_user() */
> > +	pfd.fd =3D uffd;
> > +	if (!ASSERT_EQ(poll(&pfd, 1, 10000), 1, "poll uffd"))
> > +		goto out;
> > +	if (!ASSERT_EQ(read(uffd, &uffd_msg, sizeof(uffd_msg)), sizeof(uffd_m=
sg),
> > +		       "read uffd"))
> > +		goto out;
> > +	if (!ASSERT_EQ(uffd_msg.event, UFFD_EVENT_PAGEFAULT, "uffd pagefault"=
))
> > +		goto out;
> > +
> > +	/* Detach and unload the victim prog, and make sure it is gone */
> > +	tramp_prog_detach__destroy(victim);
> > +	victim =3D NULL;
> > +	kern_sync_rcu();
> > +	usleep(100 * 1000);
> > +	kern_sync_rcu();
>
> Does this wait actually ensure the victim prog is gone before the task
> resumes?

It doesn't anymore. With patch 1 the prog is freed much later, and the test
passed even without patch 2. v4 waits for the .bss map of the detached prog=
 to
go away, which happens when the prog is freed, and the test crashes again w=
ith
patch 1 alone. The prog ID can't be used for this, it goes away when the la=
st
reference is dropped, before the grace periods.

> The test only catches the use-after-free if the victim prog has actually =
been
> freed before UFFDIO_COPY releases the sleeping task. The wait here does n=
ot
> guarantee that, and on the kernel this series produces it most likely is =
not
> freed yet.
>
> Commit 1c2316cf73ba ("bpf: Wait for an RCU tasks grace period before free=
ing
> trampoline progs") changed __bpf_prog_put_noref() so that a tramp_linked
> prog is freed through call_rcu_tasks(&prog->aux->rcu, __bpf_prog_put_rcu_=
tasks),
> then call_rcu(), then bpf_prog_free(), which calls schedule_work() for th=
e
> final vfree.
>
> RCU Tasks callbacks are lazy. call_rcu_tasks_generic() only sets needwake
> for wakeme_after_rcu (a synchronous waiter) or when the queue reaches
> rcu_task_lazy_lim. Otherwise it arms lazy_timer with rcu_tasks.lazy_jiffi=
es
> =3D DIV_ROUND_UP(HZ, 4) (kernel/rcu/tasks.h:145), which is about 250ms by
> default.
>
> Nothing on the detach path forces a synchronous RCU Tasks wait. Detaching
> the victim while the sleepable prog stays attached goes through
> modify_ftrace_direct(), and its tmp_ops is static, so it is not
> FTRACE_OPS_FL_DYNAMIC and ftrace_shutdown() does not call
> synchronize_rcu_tasks().
>
> The test waits only kern_sync_rcu() + 100ms + kern_sync_rcu().
> kern_sync_rcu() is membarrier(MEMBARRIER_CMD_SHARED), which is
> synchronize_rcu() on SMP and a no-op with one CPU online. That is well sh=
ort
> of 250ms lazy delay + RCU Tasks GP + RCU GP + workqueue.
>
> So when the thread resumes in the old image, the victim's bpf_prog and JI=
T
> image are usually still allocated. On a kernel that has 1c2316cf73ba but
> lacks 2ece3357872c (or breaks it later), the thread would run the victim
> prog without a KASAN report and the test would pass.
>
> Consider waiting well beyond the RCU Tasks lazy period (for example about=
 1s,
> or polling until the victim prog ID is no longer returned by
> bpf_prog_get_next_id()/bpf_prog_get_fd_by_id()) before releasing the thre=
ad.
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/360342=
51810

