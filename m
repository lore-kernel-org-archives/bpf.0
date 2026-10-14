Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8873D4F4D04;
	Wed, 14 Oct 2026 10:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791974910; cv=none; b=Kfl2+lQGZQMblafOvIZUjyjS1gkChJPKN+0B838Acy4cqAYpW0YTw2PhTd0Khe0VhWld8ImM5udZP1XmNZZruDyq5DByqOqznhnzzBjyNqkQ29ArGXiahwL9JMsS8VrmmJVQ4MB0FtqWrZvkvLS31g+rkdwYiXga9eB4Hld7EHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791974910; c=relaxed/simple;
	bh=WCfi2qugMj4I6GjiJuHhxlBQXtSav2xymqNq9T+mh80=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=L4Qgl69O02Bkrh++H0WHSq8MpIFF+4N7VtDz/CkcphchoV87lFf5fTAnCtfFCEYd4cFyaiAvK8U7maEJjB7AIWIirxaR8xKJ9OZP3JJ9wiuwDP7QBqevWhTopYCdfPUlisd8ne2x6GxNDugm8kLX8NEqam66iJRSWqRPvzxGb5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+z+QX+a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+z+QX+a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C11461F00893;
	Wed, 14 Oct 2026 10:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791974909;
	bh=kCfrUYLmyOT0s9lgyHGceX/pqVcHmOszChV6jWmmeqM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=K+z+QX+amz3f4+eirY835V+fZljSFBilhzpjT0CCWK5cqRPrHzN6Vz9knCgdERfZB
	 e2vUaWhR+oevjQyOHykRggQNd66vpylIMZ7ohLYMEtWU0bfQCLj8Rz8KhCNMS9qIxR
	 XioyzJtQuTb7P98JtAg2EyE4tnz270GquXC7erleAKSPZCYh+fxOV5g474CfmV7180
	 VrwvdLzZ35KaYrernOEUZLbwVKYEhvZSvg41FhADxQmSCqbtrCGBPB54wy/Mt7rukE
	 Oj/vhLaMbRh/yhWufxZuO5NZEjwTEnDPeiT30zFoDx6DelXB2T81oYS1e19K9blvJt
	 datNfVhwL1yQg==
Content-Type: multipart/mixed; boundary="===============2384992696109271130=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <93996639c3a9d8900ff3ccde4f40acd93923ff546e717384a401b91b75ba064b@mail.kernel.org>
In-Reply-To: <20261014095743.35891-1-mahe.tardy@gmail.com>
References: <20261014095743.35891-1-mahe.tardy@gmail.com>
Subject: Re: [PATCH bpf-next v4] bpf: allow ksock connect/send calls from wq
From: bot+bpf-ci@kernel.org
To: mahe.tardy@gmail.com,bpf@vger.kernel.org
Cc: andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,davem@davemloft.net,eddyz87@gmail.com,edumazet@google.com,john.fastabend@gmail.com,kuba@kernel.org,liamwisehart@meta.com,martin.lau@linux.dev,pabeni@redhat.com,song@kernel.org,netdev@vger.kernel.org,sdf.kernel@gmail.com,ameryhung@gmail.com,kuniyu@google.com,memxor@gmail.com,jiayuan.chen@linux.dev,alan.maguire@oracle.com,mahe.tardy@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 14 Oct 2026 10:48:26 +0000 (UTC)

--===============2384992696109271130==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: allow ksock connect/send calls from wq

TL;DR:
- Changelog's nsproxy explanation looks wrong, and it omits newly allowed
  task_work and LSM-kthread contexts
- bpf_ksock_create() error change to -EPERM may be indistinguishable from LSM
  denial

> bpf: allow ksock connect/send calls from wq
>
> In the initial implementation in '7ae4eb14c5f9 ("bpf: Add ksock
> kfuncs")', it was decided to let the ksock kfuncs go through the LSM
> hooks instead of by-passing them, and thus to disallow the use of the
> kfuncs from asynchronous workqueues as the credentials would be
> different than the task context that triggered the kfuncs.
>
> After some discussions, in particular at Plumbers 2026 at the
> presentation introducing this new ksock API[^1], it was agreed that
> by-passing the LSM from socket created by BPF programs should be okay
> and thus that the process context switch from kthread executing the
> workqueues wouldn't be an issue.
>
> For now, the ksock kfuncs still trigger the LSM hooks but we relax the
> constraint on not using the workqueues as it will be useful for users
> triggering connect() or send() from non-sleepable programs (like
> tracing, support will be extended in future patches).
>
> Also adapt test_ksock_wq() added in 'c93cbdb13f99 ("selftests/bpf: Add
> ksock test for async callback guard")' to test that the connect() and
> send() kfuncs are now allowed and work when called from workqueues.
>
> Note that bpf_ksock_create() still checks for workqueue context
> execution and makes sure the current->nsproxy is defined as we rely on
> the network namespace to be defined (could be NULL in the case do_exit()
> was called on the task before the wq was scheduled) and to be the one
> from the task that triggered the SYSCALL bpf prog.
>
> [^1]: https://lpc.events/event/20/contributions/2430/
>
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>

Is the nsproxy explanation in the last paragraph accurate?  The changelog
says current->nsproxy "could be NULL in the case do_exit() was called on the
task before the wq was scheduled".

A bpf_wq callback runs from bpf_wq_work() on a kworker, so current is the
kworker.  Its nsproxy is init_nsproxy and is never NULL, and the PF_KTHREAD
test already rejects it.  The triggering task calling do_exit() has no
effect on the kworker's nsproxy.

The case where !PF_KTHREAD && current->nsproxy == NULL comes from
bpf_task_work callbacks.  bpf_task_work_schedule_signal() and
bpf_task_work_schedule_resume() are registered for BPF_PROG_TYPE_UNSPEC, and
is_async_cb_sleepable() returns true for them.  Their callbacks run via
exit_task_work() after exit_nsproxy_namespaces() in do_exit():

    kernel/exit.c:do_exit() {
        ...
        exit_files(tsk);
        exit_fs(tsk);
        ...
        exit_nsproxy_namespaces(tsk);
        exit_task_work(tsk);
        ...
    }

The removed comment in bpf_ksock_has_user_task_context() described this
correctly:

    Task work can run from do_exit() after exit_nsproxy_namespaces()
    cleared current->nsproxy, while current is still not a kthread.

The replacement comment in bpf_ksock_create(), "sock_create() derives the
network namespace from current.", no longer says why nsproxy can be NULL.

In the task_work case, current is the task the work was queued on.  That is
not necessarily the task that ran the SYSCALL program, so "to be the one
from the task that triggered the SYSCALL bpf prog" is not guaranteed either.

The changelog also describes the change as only allowing connect/send from
workqueues.  Removing the runtime check from bpf_ksock_connect() and
bpf_ksock_send() also newly allows:

- connect/send from bpf_task_work callbacks running in exiting tasks
  (nsproxy, fs, files and mm already torn down)
- bpf_ksock_send() from LSM programs running in kernel threads

Neither is mentioned.  No functional breakage was found in those paths,
because UDP connect/send use sock_net(sk) rather than current->nsproxy.

Should the changelog and the comment describe the contexts that are actually
allowed and why?

> diff --git a/net/core/bpf_ksock.c b/net/core/bpf_ksock.c
> index e9943aeeadd3..f74968397798 100644
> --- a/net/core/bpf_ksock.c
> +++ b/net/core/bpf_ksock.c

[ ... ]

> @@ -73,13 +64,9 @@ bpf_ksock_create(const struct bpf_ksock_create_opts *opts, u32 opts__sz,
>  	struct bpf_ksock *ks;
>  	int err;
>
> -	/*
> -	 * sock_create() derives the network namespace, credentials, and cgroup
> -	 * from current. Kernel threads, including BPF workqueue callbacks, do
> -	 * not carry the context of the task that invoked the BPF program.
> -	 */
> -	if (!bpf_ksock_has_user_task_context()) {
> -		err = -EOPNOTSUPP;
> +	/* sock_create() derives the network namespace from current. */
> +	if ((current->flags & PF_KTHREAD) || !current->nsproxy) {
> +		err = -EPERM;
                ^^^^

Was the change of the error reported through err__uninit from -EOPNOTSUPP to
-EPERM intentional?  The changelog doesn't mention it.

-EPERM is also a normal result of the sock_create() call further down.
__sock_create() calls security_socket_create(), and LSMs, BPF LSM programs
in particular, commonly deny with -EPERM.

After this change, can a BPF program that gets NULL with err == -EPERM tell
"called from a workqueue/kthread context" apart from "socket creation denied
by LSM policy"?

Programs written against the original 7ae4eb14c5f9 semantics that check for
-EOPNOTSUPP would also silently stop matching.  If the change is
intentional, could the changelog explain it?  Otherwise, keeping -EOPNOTSUPP
would preserve the unambiguous signal.

>  		goto err_out;
>  	}
>


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38548134159
--===============2384992696109271130==--
