Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AF54D6C2F
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 11:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791975882; cv=none; b=XR+Omt6sBkdgjtNCUI+vggKCjd1Qr8dBp+tSqWAQKnX+gK6sTA9kb+4PFSkJZNnyJQMIpDle5U7yuFdAkjYZwm4Xv7S0wAjgEQDIvAE/XUY1qGUBCv7hkCdHsW91ZDwr8TaKd6al27e59Cxp3/HdDCTQQT9ZlPm4f6C05u3mAVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791975882; c=relaxed/simple;
	bh=7O6rWrEbMDVfy9c5rtx+EWfOlyYdJ0SxRACNu4mckQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNDpx1AMtj2046jKqLfvVjOH8ALP7o5dUaQdI7T6y0qQapEKmN2yHASP8K4U1peiGgxaQyOV4GK+LQawNlRrmsQXA8XUXYbzr9J3nHe5092AashT3iaPoYRY6/IQUYPA32fyocrH5ptzdoOoTPNUNoJwRFr08b6LiyX/g9nBQXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3g92KyS; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3g92KyS"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48afe75f055so302074f8f.2
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 04:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791975873; x=1792580673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wAN4a5Qn+9mrwQZxJyTfVQaGWT0bG6L+Hmxi8yJDhvs=;
        b=Y3g92KyS4J/fJmGW511dUC81gg6F4rEzTDAwsck/YDWWnLXSavkgoUWQVvQNDq9n9D
         v5GqKfXkMwFVYvPZag+tNdy8StQ6GViprgG9ubi6PpWRvmgxcfYT0Jg7ETjxc1LzeP9V
         HW/RTfWxYtJiS/2rCFVb0EOXimvBpg5+hhs6QbHxnOFYxz8d2khC5OFjM1rqJMEMjpf3
         9xTZ+VMFJ2V9sk3c7jHOyNPvrIi/ucY2MkCHZRaCmeE0g0wq4oDcr+rpL0TwJhUGsvM9
         EhBv+g6gh/ta1gSs0LWIhTfYaJZsUe7jkr6E1NWNEqpsGMQtCkVDXz+KyAUS1YagqYcO
         d4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791975873; x=1792580673;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wAN4a5Qn+9mrwQZxJyTfVQaGWT0bG6L+Hmxi8yJDhvs=;
        b=tYd4l5j98VpC+FH0p81hIngSXWWHPl7gOwnN6awiWZ7ZwsIQ19/oOr13W7ae0cxyey
         nST08QbEw4e2LRn8MN/MQcOK6Al6PSkMU4dZhO2dMbkIGAjGt/DxpYpFYD8tUFJ5Affg
         dtZqoanJkC1fKk57ZUuWWXHe5ctOC0GCFuDobGMom/wNJbe/Rcxu6OFpEXz/lva8Cotq
         5ECSEVuy78JeqmimMfKIbR/GaVbNMIFqRNKDkqvHucc7XRvnK1HMCwsfAfjoIy9En/00
         Ac9mtnjvL3z/uThlVjWYbEFoEQRhH3LTLHZFdIrPCAw/jmdzk1d68HOdnesjVm5plUDe
         JB+w==
X-Gm-Message-State: AFq9FYK/HBRomJXJPkU0Mv/oohV3k0J12ADJN0cC/tpQto0/M2/EcAvO
	6bjQKahIo3t7iZcNxaAKUtQL4xZwX2yqv96ZBFMUcse7xND3OpRoJAAb
X-Gm-Gg: AYBFou3hRjpvtHhqoauC3WjI4Rur4oudl13FjwUdqPeS87X7RWzAXDDdFshWeA1Xmaz
	loA7dM1VUUl10QhSPdKiEGjaBCMGJVtAlCsx9qnt7U8Zq84Vskle2J5gNJA0FoPQMd5+Kp1HDr7
	2K4R2IWxGl7i5NYDPxCPvJycRCmI8D+cRBU6KYSCeO0ydrOhXG751lpVuk8ZKndKJZxXaKqR4lP
	d/3fmYO2Eiy4ry2oAIws0VCVkZ5UdNvSWZxLcV9w4DAIQCvEzeQYPvFT9PBtsj+px3SzCG6KJoq
	wzBQ4aJPlOe+viXy68KbRmOSbrBz+OiAhdnhaxxyJkN9SfTJ8v0/f8TsDPGfX5I2P1pJqfpdEYm
	h32e6EebFUY0/RGjAzaNx49o8orfvl2X23XlUxA2i1ch32VbDoSI4iRHAN1hGVHRmIVM45dq9ka
	KH0FVwe5lxLw6j4AWvTfpcCqc7c6azvlXlf8Gv87Xz5HWjVK0gyVAcoqpnfHKAlRn5C8A2AMWYX
	FRIC0ETaDcXta9IeEyWw3IutBxVBAlTL9x+
X-Received: by 2002:adf:e011:0:20b0:488:57ad:d5c8 with SMTP id ffacd0b85a97d-48dba787c28mr22113841f8f.3.1791975873101;
        Wed, 14 Oct 2026 04:04:33 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ac5257sm11587825f8f.42.2026.10.14.04.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 04:04:32 -0700 (PDT)
Date: Wed, 14 Oct 2026 13:04:30 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com,
	edumazet@google.com, john.fastabend@gmail.com, kuba@kernel.org,
	liamwisehart@meta.com, martin.lau@linux.dev, pabeni@redhat.com,
	song@kernel.org, netdev@vger.kernel.org, sdf.kernel@gmail.com,
	ameryhung@gmail.com, kuniyu@google.com, memxor@gmail.com,
	jiayuan.chen@linux.dev, alan.maguire@oracle.com,
	martin.lau@kernel.org, yonghong.song@linux.dev, mason@kernel.org,
	ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v4] bpf: allow ksock connect/send calls from wq
Message-ID: <as9hvsd5zEqWhMGb@gmail.com>
References: <20261014095743.35891-1-mahe.tardy@gmail.com>
 <93996639c3a9d8900ff3ccde4f40acd93923ff546e717384a401b91b75ba064b@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93996639c3a9d8900ff3ccde4f40acd93923ff546e717384a401b91b75ba064b@mail.kernel.org>

On Wed, Oct 14, 2026 at 10:48:26AM +0000, bot+bpf-ci@kernel.org wrote:
> > bpf: allow ksock connect/send calls from wq
> 
> TL;DR:
> - Changelog's nsproxy explanation looks wrong, and it omits newly allowed
>   task_work and LSM-kthread contexts
> - bpf_ksock_create() error change to -EPERM may be indistinguishable from LSM
>   denial

Valid review: I'll push changes for those two points (changing error
back to EOPNOTSUPP and improve the changelog) if we need a v5.

> 
> > bpf: allow ksock connect/send calls from wq
> >
> > In the initial implementation in '7ae4eb14c5f9 ("bpf: Add ksock
> > kfuncs")', it was decided to let the ksock kfuncs go through the LSM
> > hooks instead of by-passing them, and thus to disallow the use of the
> > kfuncs from asynchronous workqueues as the credentials would be
> > different than the task context that triggered the kfuncs.
> >
> > After some discussions, in particular at Plumbers 2026 at the
> > presentation introducing this new ksock API[^1], it was agreed that
> > by-passing the LSM from socket created by BPF programs should be okay
> > and thus that the process context switch from kthread executing the
> > workqueues wouldn't be an issue.
> >
> > For now, the ksock kfuncs still trigger the LSM hooks but we relax the
> > constraint on not using the workqueues as it will be useful for users
> > triggering connect() or send() from non-sleepable programs (like
> > tracing, support will be extended in future patches).
> >
> > Also adapt test_ksock_wq() added in 'c93cbdb13f99 ("selftests/bpf: Add
> > ksock test for async callback guard")' to test that the connect() and
> > send() kfuncs are now allowed and work when called from workqueues.
> >
> > Note that bpf_ksock_create() still checks for workqueue context
> > execution and makes sure the current->nsproxy is defined as we rely on
> > the network namespace to be defined (could be NULL in the case do_exit()
> > was called on the task before the wq was scheduled) and to be the one
> > from the task that triggered the SYSCALL bpf prog.
> >
> > [^1]: https://lpc.events/event/20/contributions/2430/
> >
> > Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> 
> Is the nsproxy explanation in the last paragraph accurate?  The changelog
> says current->nsproxy "could be NULL in the case do_exit() was called on the
> task before the wq was scheduled".
> 
> A bpf_wq callback runs from bpf_wq_work() on a kworker, so current is the
> kworker.  Its nsproxy is init_nsproxy and is never NULL, and the PF_KTHREAD
> test already rejects it.  The triggering task calling do_exit() has no
> effect on the kworker's nsproxy.
> 
> The case where !PF_KTHREAD && current->nsproxy == NULL comes from
> bpf_task_work callbacks.  

Yes indeed this is for taskwork not workqueues in which we could face a
NULL current->nsproxy. I should update the changelog.

> bpf_task_work_schedule_signal() and
> bpf_task_work_schedule_resume() are registered for BPF_PROG_TYPE_UNSPEC, and
> is_async_cb_sleepable() returns true for them.  Their callbacks run via
> exit_task_work() after exit_nsproxy_namespaces() in do_exit():
> 
>     kernel/exit.c:do_exit() {
>         ...
>         exit_files(tsk);
>         exit_fs(tsk);
>         ...
>         exit_nsproxy_namespaces(tsk);
>         exit_task_work(tsk);
>         ...
>     }
> 
> The removed comment in bpf_ksock_has_user_task_context() described this
> correctly:
> 
>     Task work can run from do_exit() after exit_nsproxy_namespaces()
>     cleared current->nsproxy, while current is still not a kthread.
> 
> The replacement comment in bpf_ksock_create(), "sock_create() derives the
> network namespace from current.", no longer says why nsproxy can be NULL.

I might just keep this in the changelog instead of a code comment.

> In the task_work case, current is the task the work was queued on.  That is
> not necessarily the task that ran the SYSCALL program, so "to be the one
> from the task that triggered the SYSCALL bpf prog" is not guaranteed either.
> 
> The changelog also describes the change as only allowing connect/send from
> workqueues.  Removing the runtime check from bpf_ksock_connect() and
> bpf_ksock_send() also newly allows:
> 
> - connect/send from bpf_task_work callbacks running in exiting tasks
>   (nsproxy, fs, files and mm already torn down)
> - bpf_ksock_send() from LSM programs running in kernel threads
> 
> Neither is mentioned.  No functional breakage was found in those paths,
> because UDP connect/send use sock_net(sk) rather than current->nsproxy.
> 
> Should the changelog and the comment describe the contexts that are actually
> allowed and why?

Not sure we should mention this since those paths are safe since not
using current->nsproxy but the net associated with the socket. Might add
a line about it but this was generally the goal of this patch.

> 
> > diff --git a/net/core/bpf_ksock.c b/net/core/bpf_ksock.c
> > index e9943aeeadd3..f74968397798 100644
> > --- a/net/core/bpf_ksock.c
> > +++ b/net/core/bpf_ksock.c
> 
> [ ... ]
> 
> > @@ -73,13 +64,9 @@ bpf_ksock_create(const struct bpf_ksock_create_opts *opts, u32 opts__sz,
> >  	struct bpf_ksock *ks;
> >  	int err;
> >
> > -	/*
> > -	 * sock_create() derives the network namespace, credentials, and cgroup
> > -	 * from current. Kernel threads, including BPF workqueue callbacks, do
> > -	 * not carry the context of the task that invoked the BPF program.
> > -	 */
> > -	if (!bpf_ksock_has_user_task_context()) {
> > -		err = -EOPNOTSUPP;
> > +	/* sock_create() derives the network namespace from current. */
> > +	if ((current->flags & PF_KTHREAD) || !current->nsproxy) {
> > +		err = -EPERM;
>                 ^^^^
> 
> Was the change of the error reported through err__uninit from -EOPNOTSUPP to
> -EPERM intentional?  The changelog doesn't mention it.
> 
> -EPERM is also a normal result of the sock_create() call further down.
> __sock_create() calls security_socket_create(), and LSMs, BPF LSM programs
> in particular, commonly deny with -EPERM.
> 
> After this change, can a BPF program that gets NULL with err == -EPERM tell
> "called from a workqueue/kthread context" apart from "socket creation denied
> by LSM policy"?
> 
> Programs written against the original 7ae4eb14c5f9 semantics that check for
> -EOPNOTSUPP would also silently stop matching.  If the change is
> intentional, could the changelog explain it?  Otherwise, keeping -EOPNOTSUPP
> would preserve the unambiguous signal.

Maybe we can keep EOPNOTSUPP, no strong preference but the confusion
with LSM denial might be enough to justify this.

> 
> >  		goto err_out;
> >  	}
> >
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38548134159

