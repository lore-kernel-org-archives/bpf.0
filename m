Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B067D26FDBF
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 17:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772732763; cv=none; b=myGW3of1EOtw51RdqsoYGAYCO+ETpi05/XFuvoMFiXY9/rhiIp0hHtUCj1dDuCTOdv6HFCZZupue+MhIJzVYd5RJ/wULjFXdyyFbkacWER8Bzz2kIUYXHG24Xmn4ByfSMCJpB3rZEQdPWgj93rFQRKcYpFD2+mN8Vn3SW2/1kAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772732763; c=relaxed/simple;
	bh=s3TnuQQ1K9PX0ogs5CXq8Tn31nHmMNzbSCayZQB2qUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMuBWXLpJI8AR3CkdMdvAYeT5U32ZH/CSif+VHAwfUltyHG77rbM6+dKJXtFkpA1VrHvrbGphjT1LAo7u4zgCtK/tNsc/Zpkrs8B1H3Xy5wRGkj+r4WleMGFGDGwDJD7bGzBZ+C/Oh2c7G2/WEGpZyNRH08R3Dk+5kMlTZ5M5mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S2dyNZEY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S2dyNZEY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772732761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rY+/lJzIlxUiGtxnnlP1DQymRICCZjM6z0CRz3OdQpM=;
	b=S2dyNZEYiBLfxchby2SuaQhk4v+1/y2chtXpPXyWO0zvxfkkec+Mcn68c3BZ6ftJqJhgtB
	D/9LxWRwYbEFUghv1JlvCKM+1rObiNDKVG4bMBgzpOcc6F4txR928RvM6FwgqWUvUVJ7gv
	AzoTRfX84A0casnRnimejjYpteAn9F4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-5Fx2zuqQPk-A1EOVaeK76w-1; Thu,
 05 Mar 2026 12:45:58 -0500
X-MC-Unique: 5Fx2zuqQPk-A1EOVaeK76w-1
X-Mimecast-MFC-AGG-ID: 5Fx2zuqQPk-A1EOVaeK76w_1772732757
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 245D618002CA;
	Thu,  5 Mar 2026 17:45:57 +0000 (UTC)
Received: from fedora (unknown [10.45.226.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A43B918005AE;
	Thu,  5 Mar 2026 17:45:54 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  5 Mar 2026 18:45:56 +0100 (CET)
Date: Thu, 5 Mar 2026 18:45:53 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Max Ver <dudududumaxver@gmail.com>
Cc: Kees Cook <kees@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>
Subject: Re: Process killed by seccomp looks live by tracer
Message-ID: <aanBUeT2kQKpDWxZ@redhat.com>
References: <CABjJbFJO+p3jA1r0gjUZrCepQb1Fab3kqxYhc_PSfoqo21ypeQ@mail.gmail.com>
 <DEEAE764-41EA-4760-9606-341317E9FDC2@kernel.org>
 <CABjJbFJSYjQ+spicPrTnxkpcLWqSZ3aF-+b5DMKMXqcVU3mKwQ@mail.gmail.com>
 <aamX8uw8UN23rkc_@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aamX8uw8UN23rkc_@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

That said...

__seccomp_filter() does

	case SECCOMP_RET_KILL_PROCESS:
	...
		/* Show the original registers in the dump. */
		syscall_rollback(current, current_pt_regs());

		/* Trigger a coredump with SIGSYS */
		force_sig_seccomp(this_syscall, data, true);

This means that after syscall_rollback() regs->ax == orig_ax, so
ptrace_get_syscall_info_exit() will always report .is_error == 0.

And since force_sig_seccomp() uses force_coredump == true, SIGSYS
won't be reported (see the SA_IMMUTABLE check in get_signal()).

Again, it is not that I think this wrong. But perhaps Kees and Andy
can take a look and confirm that this is what we actually want.

Oleg.

On 03/05, Oleg Nesterov wrote:
>
> Hi Max,
>
> On 03/05, Max Ver wrote:
> >
> > >This is expected; PTRACE_GET_SYSCALL_INFO is at syscall entry before seccomp filtering has run.
> >
> > It also happens at the syscall exit. Take a look at the result, it
> > shows 'exit ok' twice.
>
> Why do you think this is wrong? (and I don't think this has something to
> do with seccomp, btw).
>
> > If we can agree on this is a bug, I suggest the kernel give a hint
> > about tracee exit in waitpid return value, what do you think?
>
> But the kernel already gives you a hint, no?
>
> Perhaps I missed your point, but see the change of your test-case below.
>
> Oleg.
>
>
> --- /tmp/PT.c~	2026-03-05 15:18:18.397319905 +0100
> +++ /tmp/PT.c	2026-03-05 15:40:11.044415647 +0100
> @@ -15,6 +15,8 @@
>  #include <sys/wait.h>
>  #include <threads.h>
>  #include <unistd.h>
> +#include <assert.h>
> +#include <errno.h>
>
>  void
>  child ()
> @@ -57,6 +59,14 @@
>        puts ("child exit");
>        exit (1);
>      }
> +
> +	if (WIFSIGNALED(status)) {
> +		printf("signalled pid=%d sig=%d\n", pid, WTERMSIG(status));
> +		assert(kill(pid, 0) == -1 && errno == ESRCH);
> +		exit(0);
> +	}
> +
> +
>    if (ptrace (PTRACE_GET_SYSCALL_INFO, pid,
>                sizeof (struct ptrace_syscall_info), &info)
>        == -1)

