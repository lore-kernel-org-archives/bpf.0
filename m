Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9673334EF11
	for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 20:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769804629; cv=none; b=e+7i/vovkbl2YVlBsDu/7OrpGSzIdpaZMnPh9cNxoks7+CHuQwiIp019AeHP3LltoObcEGX3MOaUNqnLiXMgq37PW40BtsHmKjqM+z3n/lqabB9YYHmrjbEE4yA1AdYDwSiI0bAT0Ph7Xx4L0DA+8wd8TwRLGhQLV1e3ORfSR1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769804629; c=relaxed/simple;
	bh=ZjPyLSoSl5jKeP970aGv1eLYndAF9mj4WgowxDUtICo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pjdu2jlm6fwBjDpiHl3oz/hMXdlpJ4NOiOyUwaE3waJrOUrwmWsqgZWftrs+1MOyVuadqL1d/9sYUUE3n0feiBdM2I4D5NHlV6hy+4SKR8J4JrpFLV6eUsSfxk74vVnQSChi/YTshA+/SCB2zOkRT8+eeAaaOWn6hjc4SBGM2cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 341D28C330;
	Fri, 30 Jan 2026 20:23:46 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 6095E80011;
	Fri, 30 Jan 2026 20:23:44 +0000 (UTC)
Date: Fri, 30 Jan 2026 15:24:00 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Blake Jones <blakejones@google.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Ian
 Rogers <irogers@google.com>
Subject: Re: BPF with deferred stacktrace and sframes?
Message-ID: <20260130152400.6a71abb8@gandalf.local.home>
In-Reply-To: <CAEf4BzaEiQ8FApp1KMrCvsBVs+xLrk_mtQFUCfXZ3co2D6Oayg@mail.gmail.com>
References: <20260126142118.2ea3cf13@gandalf.local.home>
	<CAEf4Bzax24jJVDs2bBiJuz1ZuuDihsb5Xq8pGcy18vLUMMLxbg@mail.gmail.com>
	<20260126192010.4f14bcb9@gandalf.local.home>
	<CAEf4BzZ0cYkJ-3Kt-O+2FTvTEirS7cSuea2swgaom18Q_sve4A@mail.gmail.com>
	<CAP_z_CgozbHejsuKeLRQHN-bz5jPA+C+c0GBNitgEvwOucm8TQ@mail.gmail.com>
	<CAEf4Bza91wTWzESxAyz5qP4e8siwGn=rvm-Few6xT_VpW9oJzw@mail.gmail.com>
	<CAP_z_ChhkA1W_5Bd0GQYpo2Vb-p-zP+Lbdp1cZw8Fr_WHQ=TcQ@mail.gmail.com>
	<CAEf4BzaSgmgzqfjToDx-O3BRKNZECJeeLpN81yNNWGF+N_uMNQ@mail.gmail.com>
	<CAP_z_Choy4Pe_VgdxwFzkUo4P71+TA=xAM8kov8QacGpRS5irg@mail.gmail.com>
	<CAEf4BzaEiQ8FApp1KMrCvsBVs+xLrk_mtQFUCfXZ3co2D6Oayg@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 6095E80011
X-Stat-Signature: 7a9tnx1tpbb3ow4jtanq9rk8zijgnnow
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+50cSypQi16vJ/muFzakZ6ifpewbfcCCw=
X-HE-Tag: 1769804624-105672
X-HE-Meta: U2FsdGVkX1+I1vQqqR3izLvXa0ncoEmQHgbb2zFuJCrkT118NGur+BL0yqFjOZdhqtpMIbHesqjrF2HQnaqX8TYFTLCyLFwM57gmumP2gxWUbw/Rr1Z1Jt4zQIDHA15NJGAQADiiILeINcn5odR7BqUhaqw21j1r5+Mt5u75Xz5d+bqdkqCBbSIMvthJz7wGYwTEZQCmpBHCudRb2h6XlfyyNGtiOY5t0bEL7JF5XYfMejpnbPDbCh0+85dAUBxR+AloBPha+AkroRrP82y7BCp8nlXiASaT6KM/7emo3X8GR3Mav/J/hgQWL9lxQKb/U/BJVLH2hu7s2iA8JrpAolkaLoHM8rdi

On Fri, 30 Jan 2026 11:50:16 -0800
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> I'm not really proposing anything. You have a baked-in assumption that
> you will have a user stack available *synchronously* and that you can
> use that as some sort of lookup key. This is simply not true with
> SFrame (and asynchronously captured user space stack traces in
> general), so you'll have to redesign your approach (or you just say
> that you only support frame pointer-based synchronous stack traces).

=46rom my understanding of what Blake's tools are doing is that it records
stacktraces (both kernel and user space) when a task schedules out and for
how long. This shows how long tasks were off the CPU due to being blocked,
or sleeping, and even preemption.

Currently, when a task schedules out and comes back on the CPU, the kernel
stack is combined with the user stack and it's put into a hash table where
the time off the CPU is added to the hash entry's time. I'm not sure of the
details here, but this could be updating BPF maps and such here.

The issue that Blake has is that this cannot be recorded when waking up
because only the kernel's stack is known. The user stack isn't known yet.

One solution we discussed was to make the hash key of the kernel tasks and
save it in a small array that also stores the time it was off the kernel.
If the task schedules out in the same location multiple times before going
back to user space, only one entry needs to be updated as the hash of the
kernel stack would be the same. When the task goes back to user space, the
kernel key is attached to the user stack trace hash key and added to the
main table that associates both the kernel and user stacktrace.

But if the task were to schedule out in many locations (Blake has recorded
over 50 unique locations where a task could schedule out in the same system
call), then it would need to save the time off the CPU for each of those
locations. When going back to user space, each of those locations would
need to be attached to the current user stacktrace hash key and added to
the main table individually.

Note, these temporary kernel hash keys are unique per task, as they haven't
been associated with a user stacktrace yet, whereas the global table is for
the entire system. That means any storage of these temporary kernel
stacktrace keys needs to be done per task.

Blake, did I explain that correctly?

Now the question is, is there a way to easily store these unique kernel
stacktraces along with the time the task was off the CPU for those
locations and be able to attach them each to the user stacktrace when going
back to user space?

-- Steve
