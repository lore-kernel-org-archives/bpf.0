Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE9239E182
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 13:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771941418; cv=none; b=OWdchxQwsXI4+OoqCvrPrW/Ee8LsicYXI2bm7/pdixqQzfKxrFC+gdYIeB//AEZ0/BxUzsnMP3j4FHheBAV5ljN0RxjBpnb/oIN3zywUWG8y4KCCH+cIwEPMy+0i3/MjEzgPa63CZaujBxGTlQxehSmDn2IwGupdhezdzbrh350=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771941418; c=relaxed/simple;
	bh=44Ow3CJaR5qffqHLu/nrOjTG6J497iu4/cLtIO3Wgxk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=SEcUrEr4bpBfNYJtcb/y0UlQCL5OWhbPompskdWach9MHrxt6RlIzkV85WUgARyNmRya8OXn9XNMH84+8Egr/X4ADGE0M4ZZT10Nadye/vL7OzTemeIRr0a+eT72HNLXg6T7EXq94Y/++CB16CIcMpggy5mk/wjKPx7AwjvCsbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 0F5A414012F;
	Tue, 24 Feb 2026 13:56:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 97D8C20029;
	Tue, 24 Feb 2026 13:56:46 +0000 (UTC)
Date: Tue, 24 Feb 2026 08:56:43 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: lsf-pc@lists.linux-foundation.org
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei
 Starovoitov <ast@kernel.org>, Ian Rogers <irogers@google.com>, Blake Jones
 <blakejones@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Indu Bhagat
 <indu.bhagat@oracle.com>
Subject: [LSF/MM/BPF TOPIC] BPF deferred stack trace unwinder
Message-ID: <20260224085643.16d9b682@fedora>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 97D8C20029
X-Stat-Signature: qctkw3bnben65xf8wjcfbiuiciu8767m
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/qVARaUwWKlSO1ChzwipFLxICqTkNMrz0=
X-HE-Tag: 1771941406-434228
X-HE-Meta: U2FsdGVkX18APJBQe9T7TEFSFsNToAF8va4CUOCB80yiKscPKTXaCa3m2siLj3A50M1ERFD/z/iqiRph3/WPwzvYK59dw+b6yFFtNQHxmGmEBLtyWCKllbZnSpllHj+mqmKjx85VfYUdoHzlfEpKj3W3SCW9ifGssL09j0MF2t8YhpR6npnU8JKCJRyloR4Ou69bEJpngh9iR88uBaJyQYj6hsZksmFpjuVtfbeYZEhN3VT9FDZYCjGnuvfC72j9sxGvPHyw/f7+oQnM2vL2d/og/R4wJgv3KkonQOnV6jpOdi2hKuJDmc+pf23LEON69a5WAZu+558PinHDhue5k/TCDnnHjHmaFKRujT26KJZS25b9HVTip+bDQJla2M2MMYx5umvEL5vY2zsrDu0J1KIN3A6q7xaOXayRH5/5je/obwId1lsQ8g==

Hopefully this isn't too late but I got side tracked and never submitted.

We are currently working on enabling SFrames[1] to get user space stack
traces. This would allow us to retrieve reliable user space stack
traces from inside the kernel without the need for frame pointers. The
issue with SFrames is that they require reading user space memory. That
means reading the SFrame data can not be performed from an interrupt
context as the read will likely cause a major page fault.

To handle this, a deferred user stack trace unwinder was added to the
kernel[2]. How this works is to do the unwinding where it is safe to
have major page faults. The obvious place for that is just before going
back to user space (via task work). A tracer (like BPF) would call
unwind_deferred_init() to register itself with the unwinder and give it
a callback that gets called  before the task goes back to user space
with the user stack trace as well as a "cookie". BPF would call
unwind_deferred_request() at the time it wants the user space
stacktrace (could be in any context, like an interrupt or even an NMI).
That function returns a unique "cookie" that represents the user space
stack trace its callback will receive (along with the same cookie as a
parameter). Then BPF could record this cookie and have user space
mapping tie it together with whatever else was recorded then (like the
kernel stack trace).

Blake Jones brought up an issue that their tooling has with this
approach. That is it may be difficult to keep track of all the kernel
stack traces it needs to map to the user space stack trace. The reason
this is a problem is because the tooling saves the kernel and user
stack trace into a special hash. It is performed after a task is
scheduled out and back in and it records the time the task was off the
CPU with each kernel/user stack trace.

Currently the recording is done when the task schedules back in. But
due to faulting, it is not safe to call sframes unwinding at a moment
the task schedules in. It must wait until the task goes back to user
space and then tie all the kernel tracer to where the task scheduled
out with the user space stacktrace to create the hash and save it. As a
system call may have a hundred different places it can schedule out,
the tool can't cache all the kernel stack traces waiting for it to
schedule back in, as that would require saving a hundred stack traces
for every task. You can read more about the issue[3].

I would like to bring this topic up at LSF/MM/BPF.

-- Steve


[1] https://sourceware.org/binutils/docs/sframe-spec.html
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c6439bfaabf25b736154ac5640c677da2c085db4
[3] https://lore.kernel.org/all/20260126142118.2ea3cf13@gandalf.local.home/
