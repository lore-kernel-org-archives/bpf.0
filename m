Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE051221D96;
	Thu,  5 Mar 2026 13:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772716853; cv=none; b=XZdSVMGbh+mEeaMhGX8pUbtOCzYMlbEj94LHUwJpFoKt2c92SH+lnxTH72RHsTU/F4JUWFqvT4pidpDPVoTR0b2J4PboZ+zinqwjw0brl2Yt9ATU5dEA+BVrjqLpucjApxBDCRJ2sOgIel23OwZQHdzfN8bKwexeZ8Hvcw5Wiuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772716853; c=relaxed/simple;
	bh=CwGtpqWlsou0kFKNtq+6I3wxRsvfeyxuVZBpgGDbidk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M54hWdovmKsepvnZo7D6vibRb7nrugmrudMPHqS394zQ2GP/kdK446ccZybKqlsnyaidpa024TAeOQATGmnf0RolyW9QZeVEHCENdZBr80hAOexoxRKjwUh72RR35es4J6UzLp3oerfOOgsjqoNvCSj2QRKVFa8MxsYt4WCtrh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 08C221A015D;
	Thu,  5 Mar 2026 13:20:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 5B4F88000E;
	Thu,  5 Mar 2026 13:20:47 +0000 (UTC)
Date: Thu, 5 Mar 2026 08:21:25 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Waiman Long <longman@redhat.com>, David Laight
 <david.laight.linux@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 mingo@redhat.com, will@kernel.org, boqun@kernel.org, mhiramat@kernel.org,
 mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] locking: add mutex_lock_nospin()
Message-ID: <20260305082125.35d8539c@gandalf.local.home>
In-Reply-To: <CALOAHbAsiVNC7COL7rCJBdaC-8oZQvg+pjudR4QexQQaYLBmgA@mail.gmail.com>
References: <20260304074650.58165-1-laoar.shao@gmail.com>
	<20260304074650.58165-2-laoar.shao@gmail.com>
	<20260304090249.GN606826@noisy.programming.kicks-ass.net>
	<20260304095415.4d5f2528@pumpkin>
	<20260304155742.7b4de2d1@gandalf.local.home>
	<20260304214447.3e5817ea@pumpkin>
	<CALOAHbCOynnRdc8JkNJHb-nyoerrz0K5GUhnD8OR2hv4x==5LA@mail.gmail.com>
	<20260304212802.458b878e@fedora>
	<CALOAHbBA643_QOsnTmrfjKE71hSa+v1cToiELvGk+vjtcgJsxg@mail.gmail.com>
	<20260304220019.3efa12ab@robin>
	<CALOAHbA4Dtc3cXs2JiQ=kxES3kT+Acb=amUxkOvQ22fns-Mqgw@mail.gmail.com>
	<748e8e0d-5164-4c8a-9bb9-110874c5daa0@redhat.com>
	<CALOAHbAsiVNC7COL7rCJBdaC-8oZQvg+pjudR4QexQQaYLBmgA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 5B4F88000E
X-Stat-Signature: dbt6fsqpbjakohchp87mf59hxz83abbk
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19nGggTJBCCXPbN6dgsUGRGeCssd4zkOd4=
X-HE-Tag: 1772716847-196258
X-HE-Meta: U2FsdGVkX19/nA7nkiJ+lEu/bhXZ7iVnaGIQF1IGFnFPwc+FBle9wIBmCB012lsGYBm/ecU20fIb9h2Up+hs15uH8elqdHCi0G3TKEXS4dCoBkuW2NRWvaeukGOlePrAdQU/a70KaOhUwsW/6T3ifdbDbWVADRweNv6PzeNFZ1MXlFELAQn6yQ2HRgvFwIGJQFIVoN+wTm/6fORb8dm5MTGNAG+KdDNVQKc62AMItK1vRGaJHXayne1B1oqLjvIgcLZEkkXlt0Z0kw42eGDegYpC2iKed6u6cNE8ce0Ino9bt/uYjEp722x3tUsNf3ZbBce/8hYHfJKk44l1CmslOzhLQsjlxBwf

On Thu, 5 Mar 2026 13:40:27 +0800
Yafang Shao <laoar.shao@gmail.com> wrote:

> Exactly. ftrace is intended for debugging and should not significantly
> impact real workloads. Therefore, it's reasonable to make it sleep if
> it cannot acquire the lock immediately, rather than spinning and
> consuming CPU cycles.

Actually, ftrace is more than just debugging. It is the infrastructure for
live kernel patching as well.

> 
> >
> > BTW, you should expand the commit log of patch 1 to include the
> > rationale of why we should add this feature to mutex as the information
> > in the cover letter won't get included in the git log if this patch
> > series is merged. You should also elaborate in comment on under what
> > conditions should this this new mutex API be used.  
> 
> Sure.  I will update it.
> 
> BTW, these issues are notably hard to find. I suspect there are other
> locks out there with the same problem.

As I mentioned, I'm not against the change. I just want to make sure the
rationale is strong enough to make the change.

One thing that should be modified with your patch is the name. "nospin"
references the implementation of the mutex. Instead it should be called
something like: "noncritical" or "slowpath" stating that the grabbing of
this mutex is not of a critical section.

Maybe an entirely new interface should be defined:


struct slow_mutex;

slow_mutex_lock()
slow_mutex_unlock()

etc,

that makes it obvious that this mutex may be held for long periods of time.
In fact, this would be useful for RT workloads, as these mutexes could be
flagged to warn RT critical tasks if those tasks were to take one of them.

There has been some talk to mark paths in the kernel that RT tasks would
get a SIGKILL if they were to hit a path that is known to be non
deterministic.

-- Steve
