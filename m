Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A8FC433EF
	for <bpf@archiver.kernel.org>; Wed, 17 Nov 2021 21:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3B8863215
	for <bpf@archiver.kernel.org>; Wed, 17 Nov 2021 21:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235050AbhKQVIU (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 17 Nov 2021 16:08:20 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:50672 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbhKQVIK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Nov 2021 16:08:10 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:36194)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mnS7C-00GZT5-5q; Wed, 17 Nov 2021 14:05:10 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:38220 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mnS78-0080bA-F7; Wed, 17 Nov 2021 14:05:09 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kyle Huey <me@kylehuey.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrea Righi <andrea.righi@canonical.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "open list\:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, bpf@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Robert O'Callahan" <rocallahan@gmail.com>
References: <CAP045AoMY4xf8aC_4QU_-j7obuEPYgTcnQQP3Yxk=2X90jtpjw@mail.gmail.com>
        <202111171049.3F9C5F1@keescook>
        <CAP045Apg9AUZN_WwDd6AwxovGjCA++mSfzrWq-mZ7kXYS+GCfA@mail.gmail.com>
        <CAP045AqjHRL=bcZeQ-O+-Yh4nS93VEW7Mu-eE2GROjhKOa-VxA@mail.gmail.com>
Date:   Wed, 17 Nov 2021 15:04:31 -0600
In-Reply-To: <CAP045AqjHRL=bcZeQ-O+-Yh4nS93VEW7Mu-eE2GROjhKOa-VxA@mail.gmail.com>
        (Kyle Huey's message of "Wed, 17 Nov 2021 11:09:14 -0800")
Message-ID: <87k0h6334w.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mnS78-0080bA-F7;;;mid=<87k0h6334w.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19k7z6hiJZlBFtRIljKy3t8xb3GbD3g610=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [REGRESSION] 5.16rc1: SA_IMMUTABLE breaks debuggers
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Kyle Huey <me@kylehuey.com> writes:

> On Wed, Nov 17, 2021 at 11:05 AM Kyle Huey <me@kylehuey.com> wrote:
>>
>> On Wed, Nov 17, 2021 at 10:51 AM Kees Cook <keescook@chromium.org> wrote:
>> >
>> > On Wed, Nov 17, 2021 at 10:47:13AM -0800, Kyle Huey wrote:
>> > > rr, a userspace record and replay debugger[0], is completely broken on
>> > > 5.16rc1. I bisected this to 00b06da29cf9dc633cdba87acd3f57f4df3fd5c7.
>> > >
>> > > That patch makes two changes, it blocks sigaction from changing signal
>> > > handlers once the kernel has decided to force the program to take a
>> > > signal and it also stops notifying ptracers of the signal in the same
>> > > circumstances. The latter behavior is just wrong. There's no reason
>> > > that ptrace should not be able to observe and even change
>> > > (non-SIGKILL) forced signals.  It should be reverted.
>> > >
>> > > This behavior change is also observable in gdb. If you take a program
>> > > that sets SIGSYS to SIG_IGN and then raises a SIGSYS via
>> > > SECCOMP_RET_TRAP and run it under gdb on a good kernel gdb will stop
>> > > when the SIGSYS is raised, let you inspect program state, etc. After
>> > > the SA_IMMUTABLE change gdb won't stop until the program has already
>> > > died of SIGSYS.
>> >
>> > Ah, hm, this was trying to fix the case where a program trips
>> > SECCOMP_RET_KILL (which is a "fatal SIGSYS"), and had been unobservable
>> > before. I guess the fix was too broad...
>>
>> Perhaps I don't understand precisely what you mean by this, but gdb's
>> behavior for a program that is SECCOMP_RET_KILLed was not changed by
>> this patch (the SIGSYS is not observed until after program exit before
>> or after this change).
>
> Ah, maybe that behavior changed in 5.15 (my "before" here is a 5.14
> kernel).  I would argue that the debugger seeing the SIGSYS for
> SECCOMP_RET_KILL is desirable though ...

This is definitely worth discussing, and probably in need of fixing (aka
something in rr seems to have broken).

We definitely need protection against the race with sigaction.

The fundamental question becomes does it make sense and is it safe
to allow a debugger to stop at, and possibly change these signals.

Stopping at something SA_IMMUTABLE as long as the signal is allowed to
continue and kill the process when PTRACE_CONT happens seems harmless.

Allowing the debugger to change the signal, or change it's handling
I don't know.

All of this is channeled through the following function.

> static int
> force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t, bool sigdfl)
> {
> 	unsigned long int flags;
> 	int ret, blocked, ignored;
> 	struct k_sigaction *action;
> 	int sig = info->si_signo;
> 
> 	spin_lock_irqsave(&t->sighand->siglock, flags);
> 	action = &t->sighand->action[sig-1];
> 	ignored = action->sa.sa_handler == SIG_IGN;
> 	blocked = sigismember(&t->blocked, sig);
> 	if (blocked || ignored || sigdfl) {
> 		action->sa.sa_handler = SIG_DFL;
> 		action->sa.sa_flags |= SA_IMMUTABLE;
> 		if (blocked) {
> 			sigdelset(&t->blocked, sig);
> 			recalc_sigpending_and_wake(t);
> 		}
> 	}
> 	/*
> 	 * Don't clear SIGNAL_UNKILLABLE for traced tasks, users won't expect
> 	 * debugging to leave init killable.
> 	 */
> 	if (action->sa.sa_handler == SIG_DFL && !t->ptrace)
> 		t->signal->flags &= ~SIGNAL_UNKILLABLE;
> 	ret = send_signal(sig, info, t, PIDTYPE_PID);
> 	spin_unlock_irqrestore(&t->sighand->siglock, flags);
> 
> 	return ret;
> }

Right now we have 3 conditions that trigger SA_IMMUTABLE.
- The sigdfl parameter is passed asking that userspace not be able to
  change the handling of the signal.

- A synchronous exception is taken and the signal is blocked.

- A synchronous exception is taken and the signal is ignored.

Today because of how things are implemented the code most change the
userspace state to allow the signal to kill the process.  I really want
to get rid of that, because that has other side effects.  As part of
getting rid of changing the state it is my plan to get rid of
SA_IMMUTABLE as well.  If I don't have to allow the debugger to stop and
observe what is happening with the signal that change is much easier to
implement.

The classic trigger of sigdfl is a recursive SIGSEGV.

However we have other cases like SECCOMP_RET_KILL where the kernel
has never allowed userspace to intercept the killing of the
process.  Things that have messages like: "seccomp tried to change
syscall nr or ip"

My brain is drawing a blank on how to analyze those.  

Kees I am back to asking the question I had before I figured out
SA_IMMUTABLE.  Are there security concerns with debuggers intercepting
SECCOMP_RET_KILL.

I think I can modify dequeue_synchronous_signal so that we can perform
the necessary logic in get_signal rather than hack up the signal
handling state in force_sig_info_to_task.

Except for the cases like SECCOMP_RET_KILL where the kernel has never
allowed userspace to intercept the handling.  I don't see any
fundamental reason why ptrace could not intercept the signal.  The
handling is overriden to force the process to die, because the way
userspace is currently configured to handle the signal does not work so
it is necessary to kill the process.

I think there are cases where the userspace state is known to be
sufficiently wrong that the kernel can not safely allow anything more
than inspecting the state.

I can revisit the code to see if the kernel will get confused if
something more is allowed.  Still I really like the current semantics of
SA_IMMUTABLE because these are cases where something wrong.  If someone
miscalculates how things are wrong it could result in the kernel getting
confused and doing the wrong thing.  Allowing the debugger to intercept
the signal requires we risk miscalculating what is wrong.

Kyle how exactly is rr broken?  Certainly a historical usage does not
work.  How does this affect actual real world debugging sessions?

You noticed this and bisected the change quickly so I fully expect
this does affect real world debugging sessions.  I just want to know
exactly how so that exactly what is wrong can be fixed.

As far as I can tell SA_IMMUTABLE has only been backported to v5.15.x
where in cleaning things up I made SECCOMP_RET_KILL susceptible to races
with sigaction, and ptrace.  Those races need to be closed or we need to
decide that we don't actually care if the debugger does things.

Eric
