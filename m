Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCAE37C925
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 14:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772722198; cv=none; b=rImygACui/caRvmZAT6zS9uu1969OfvkipsFv+NuKrwC8Xqn5khJDohrre/U6PXCX7zktEphnZRPU1SKw6y76RGXzby28bVA+8VbfOPv7Ao2jGNtA6bJWbN9D9BzaMAyHvrtDC6Gce0i0oX+sC75EQpgJDO59d0HQ40ptjOXgrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772722198; c=relaxed/simple;
	bh=TpxMQC8x06Wn0Zp5LR+hR9F0kgu+Q/Dd7ZEJK8oJt18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVsPIPMrP8Lai1QoiwvKbmX5jVKHXbOR1KI+A9qml8lBsbewwUEcrbAQYbhgoQ0EvwJFjbpKlkpupGruvpbRRsvH1kB1e6QCqnviHg9sHvyCf4EzLI1qeXJ9H9ocZWG3Q7tNXSckZPK/ENJKh56booPfaD/a7syn6ITEKQxcRzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gEv6gDPr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gEv6gDPr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772722196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M6dOvDC6ZsqfgTzl5sOOKWqKa2EpYtUemewgDtYzRbc=;
	b=gEv6gDPrNrzkt2i0dtzAHXSMS+NHUiIuMQ0dYWwJQSZpT3eepBeuIZc4qzxhP9/QVyz6Ch
	VkagqxsUPznb7N7tEO9cLn55pRlibcd5Jgd5cHwZDYqBCe4LzQPvteKSC9sYc7LM2Qf5JB
	mi9P5dcWBtSDA0ZpuTPHcPbSWC1OKfQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-246-xXCzklqnNJCPAnzODX1h1w-1; Thu,
 05 Mar 2026 09:49:53 -0500
X-MC-Unique: xXCzklqnNJCPAnzODX1h1w-1
X-Mimecast-MFC-AGG-ID: xXCzklqnNJCPAnzODX1h1w_1772722192
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3140E1956053;
	Thu,  5 Mar 2026 14:49:52 +0000 (UTC)
Received: from fedora (unknown [10.45.226.82])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E20B23003E9E;
	Thu,  5 Mar 2026 14:49:49 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  5 Mar 2026 15:49:52 +0100 (CET)
Date: Thu, 5 Mar 2026 15:49:48 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Max Ver <dudududumaxver@gmail.com>
Cc: Kees Cook <kees@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>
Subject: Re: Process killed by seccomp looks live by tracer
Message-ID: <aamX8uw8UN23rkc_@redhat.com>
References: <CABjJbFJO+p3jA1r0gjUZrCepQb1Fab3kqxYhc_PSfoqo21ypeQ@mail.gmail.com>
 <DEEAE764-41EA-4760-9606-341317E9FDC2@kernel.org>
 <CABjJbFJSYjQ+spicPrTnxkpcLWqSZ3aF-+b5DMKMXqcVU3mKwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABjJbFJSYjQ+spicPrTnxkpcLWqSZ3aF-+b5DMKMXqcVU3mKwQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Max,

On 03/05, Max Ver wrote:
>
> >This is expected; PTRACE_GET_SYSCALL_INFO is at syscall entry before seccomp filtering has run.
>
> It also happens at the syscall exit. Take a look at the result, it
> shows 'exit ok' twice.

Why do you think this is wrong? (and I don't think this has something to
do with seccomp, btw).

> If we can agree on this is a bug, I suggest the kernel give a hint
> about tracee exit in waitpid return value, what do you think?

But the kernel already gives you a hint, no?

Perhaps I missed your point, but see the change of your test-case below.

Oleg.


--- /tmp/PT.c~	2026-03-05 15:18:18.397319905 +0100
+++ /tmp/PT.c	2026-03-05 15:40:11.044415647 +0100
@@ -15,6 +15,8 @@
 #include <sys/wait.h>
 #include <threads.h>
 #include <unistd.h>
+#include <assert.h>
+#include <errno.h>
 
 void
 child ()
@@ -57,6 +59,14 @@
       puts ("child exit");
       exit (1);
     }
+
+	if (WIFSIGNALED(status)) {
+		printf("signalled pid=%d sig=%d\n", pid, WTERMSIG(status));
+		assert(kill(pid, 0) == -1 && errno == ESRCH);
+		exit(0);
+	}
+
+
   if (ptrace (PTRACE_GET_SYSCALL_INFO, pid,
               sizeof (struct ptrace_syscall_info), &info)
       == -1)

