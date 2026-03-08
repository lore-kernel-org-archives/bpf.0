Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCBC36DA09
	for <bpf@vger.kernel.org>; Sun,  8 Mar 2026 13:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772975338; cv=none; b=MlRlbTFNpRwov6XdRFNdxUF2XnWbvWa7IqKP3U44S5wBy2QpDpqosxY8KI1mTAAtToXMlLrCd/Fmn9f+SmRqGVeqtmnQdQ9nqEJOfhiojPlkEnnXipnW3W9ezyQfWPI9OkNOWVW2iOGDpVV7FuiZV5kJIvoanSRYtIV4D18L1VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772975338; c=relaxed/simple;
	bh=BgXzf9/DakieqP1vbKFJbeiTrM0BNzQVzd7gSPOSD0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AlsnJ/+OuMACOj1xQ4FzIfU86KMMShHBAOk3sk9S9Uy3GCys3y7Rd5B3CBQxhgYUiA/+Kzbq18PDX5G41ze7iaDdcgdfQ3MsXhMsxRIVJ8DqJOU9tR0iWcqB1BVUsn34QItU+Jb/N4CotdRTqMMscYymeX4FML+5F2wOkR6htao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KjAGBT9v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KjAGBT9v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772975336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i/Bsvt9jT0E4ZN9oplHUq+cX+ewJsum36FF0EKEPoDs=;
	b=KjAGBT9voDP5fWdPvkKX9o2Sak9pxANc4wUpGiTKrWAVhGJ9bdf0zBvCCK1D4g3gvMmNFf
	8BzkcOpc7BYc7t20j+zEQNH7flhL11odLovsgGe5QpyROVnmvINtnYxhR4PLzU2B07Y5xf
	EeYSTIDA50xvzIc9WPAZyb8DJjpglD4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-b78EP0AsPEm_FEBqcDVdBA-1; Sun,
 08 Mar 2026 09:08:50 -0400
X-MC-Unique: b78EP0AsPEm_FEBqcDVdBA-1
X-Mimecast-MFC-AGG-ID: b78EP0AsPEm_FEBqcDVdBA_1772975329
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 62872195608E;
	Sun,  8 Mar 2026 13:08:49 +0000 (UTC)
Received: from fedora (unknown [10.45.224.43])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 95AE330001BE;
	Sun,  8 Mar 2026 13:08:46 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  8 Mar 2026 14:08:48 +0100 (CET)
Date: Sun, 8 Mar 2026 14:08:45 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Max Ver <dudududumaxver@gmail.com>,
	Andy Lutomirski <luto@amacapital.net>, Kees Cook <kees@kernel.org>,
	Dmitry Levin <ldv@strace.io>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	Will Drewry <wad@chromium.org>
Subject: Re: Process killed by seccomp looks live by tracer
Message-ID: <aa103dEXEqU4QlgZ@redhat.com>
References: <CABjJbFJO+p3jA1r0gjUZrCepQb1Fab3kqxYhc_PSfoqo21ypeQ@mail.gmail.com>
 <DEEAE764-41EA-4760-9606-341317E9FDC2@kernel.org>
 <CABjJbFJSYjQ+spicPrTnxkpcLWqSZ3aF-+b5DMKMXqcVU3mKwQ@mail.gmail.com>
 <aamX8uw8UN23rkc_@redhat.com>
 <aanBUeT2kQKpDWxZ@redhat.com>
 <CABjJbF+vEwEr4fQo7zZwFtgPSJGM1veFnaaLrupOzaVDoi3hJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABjJbF+vEwEr4fQo7zZwFtgPSJGM1veFnaaLrupOzaVDoi3hJg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 03/06, Max Ver wrote:
>
> I suppose it's more reasonable for kernel to give a hint just after
> the syscall killed by seccomp at the fourth loop. So that we can know
> the syscall is rollbacked, or else we can only assume the syscall may
> succeed.

Perhaps you are right, but this is a question for seccomp experts...

Kees, Andy, what do you think?

Say, we can do something like

	--- a/kernel/ptrace.c
	+++ b/kernel/ptrace.c
	@@ -951,11 +951,20 @@ ptrace_get_syscall_info_seccomp(struct task_struct *child, struct pt_regs *regs,
		return offsetofend(struct ptrace_syscall_info, seccomp.ret_data);
	 }
	 
	+// currently not exposed
	+#define SECCOMP_MODE_DEAD	(SECCOMP_MODE_FILTER + 1)
	+
	+static long xxx_get_error(struct task_struct *task, struct pt_regs *regs)
	+{
	+	return task->seccomp.mode == SECCOMP_MODE_DEAD
	+		? -EINTR : syscall_get_error(task, regs);
	+}
	+
	 static unsigned long
	 ptrace_get_syscall_info_exit(struct task_struct *child, struct pt_regs *regs,
				     struct ptrace_syscall_info *info)
	 {
	-	info->exit.rval = syscall_get_error(child, regs);
	+	info->exit.rval = xxx_get_error(child, regs);
		info->exit.is_error = !!info->exit.rval;
		if (!info->exit.is_error)
			info->exit.rval = syscall_get_return_value(child, regs);

but probably this is not a good solution.

Perhaps we can add a new "killed_by_seccomp" member into ptrace_syscall_info.exit ?

Or even add a new ptrace_syscall_info.op = PTRACE_SYSCALL_INFO_KILLED_BY_SECCOMP ?

Or change ptrace_report_syscall(PTRACE_EVENTMSG_SYSCALL_EXIT) to not report the event
if the tracee was killed by force_sig_seccomp(force_coredump => true) ?

Oleg.

>
> Oleg Nesterov <oleg@redhat.com> 于2026年3月6日周五 01:46写道：
> >
> > That said...
> >
> > __seccomp_filter() does
> >
> >         case SECCOMP_RET_KILL_PROCESS:
> >         ...
> >                 /* Show the original registers in the dump. */
> >                 syscall_rollback(current, current_pt_regs());
> >
> >                 /* Trigger a coredump with SIGSYS */
> >                 force_sig_seccomp(this_syscall, data, true);
> >
> > This means that after syscall_rollback() regs->ax == orig_ax, so
> > ptrace_get_syscall_info_exit() will always report .is_error == 0.
> >
> > And since force_sig_seccomp() uses force_coredump == true, SIGSYS
> > won't be reported (see the SA_IMMUTABLE check in get_signal()).
> >
> > Again, it is not that I think this wrong. But perhaps Kees and Andy
> > can take a look and confirm that this is what we actually want.
> >
> > Oleg.

