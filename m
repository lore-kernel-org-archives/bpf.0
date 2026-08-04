Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E488D46A5F4
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 16:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785860927; cv=none; b=ffQx7Uh2ANY9M0luCVhTcI2/yre5JQ6k7NLftnWpmtP8ScxhlZRHfrEYQk2CwsGUiJ1t5cSTxBJwGr3VeNe/MT+J5AL2aTo1Mo1Gb02U433FRRkN8oAG4DYQ1Hod2JjFIW7AGos8M8x3uW4PPi5xd/KN/mcHdO6ngLdqeGY+XHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785860927; c=relaxed/simple;
	bh=C1YvCU666YdkoYKlaraFDoHVGRC4GTJL5hHvurCpOn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qyb0YsqifcdSUcj30+DwcMleSmgLbkPZ5lmeOnBOYCr9RsmZG2v1Js+75vlj7EgGUFWl/bS4p634c4Hh+DlMuH48eIBpLQyHeCnZ5CHVizOitPQGx/LBZJc7+RJg03rIM05v7aEV4JxjAPlnJ/vNMi7cezx7GtyEncTIoz7LuAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUwbH437; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUwbH437"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB43D1F000E9;
	Tue,  4 Aug 2026 16:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785860925;
	bh=J//62sSHnCK2JgEZb16oR+3Vg6EBt8NC3zpqrpYicfs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=OUwbH437Oyy7mTiW0M9BX5qIh91VXCgiEaO+6QiEHhbAB41sVfyeBJafksGTbA+6o
	 3QS/DHTWPqYO2FvnNJlv9T3iH/2DP8+sKcU74cQ5I6SMTw5V6mugr55mkzrr+orxmy
	 t3fa0tH2Afm/rf7lxmRsGQ2YMcg3tIF9RuW0RgFNkBdFiaHrlnxJNyXLzidyRzIz2I
	 VP9Ra/pbW8SXd4RairHyIuDlgqXPDg1gOgRnwXLEh02D7U5cVIYue2NGEaWE6gnDyM
	 mdlA//cWAgUH5ySoMYHa7qGHoThm4Iw4AqUWPyaJjGIcc+dri3+sAYXJZpVNLOriMU
	 hP7bDAcv5+tGA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B6E68CE19CF; Tue,  4 Aug 2026 09:28:44 -0700 (PDT)
Date: Tue, 4 Aug 2026 09:28:44 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Ning Ding <dingning04@gmail.com>, bpf@vger.kernel.org,
	Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Invalidate RCU pointers after final
 spin unlock
Message-ID: <aba45a18-fb2f-4993-868e-976723b2e017@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260803112615.3362122-1-dingning04@gmail.com>
 <m2zez2i2hp.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2zez2i2hp.fsf@kernel.org>

On Tue, Aug 04, 2026 at 11:50:10AM +0100, Puranjay Mohan wrote:
> Ning Ding <dingning04@gmail.com> writes:
> 
> > In a sleepable BPF program, a spin lock can provide the only RCU protection
> > for a kptr. The final spin unlock ends that protection, but the verifier
> > leaves the pointer valid. Another CPU can then free the object before the
> > pointer is used. A capability-limited runtime PoC triggered a
> > KASAN-confirmed task_struct use-after-free.
> >
> > Patch 1 invalidates RCU-protected pointers only when an unlock leaves the
> > final RCU-protected context. Patch 2 adds a negative sleepable test and
> > positive controls for non-sleepable and explicit-RCU contexts.
> 
> I think if we are doing this we should do it for all things that act as
> an entry to a RCU read side critical section [1]:
> 
> 1. Disabling preemption
> 2. Disabling bottom halves
> 3. Disabling interrupts
> 4. Acquiring a spin lock
> 
> As you are doing it for 4, can you also do it for 1 and 3? I don't think
> BPF can disable bottom halves right now.
> 
> Paul, can you ack this? Let us know if there are more things that can
> make a BPF program enter a read side critical section.

This is quite true!

There is a range of complexity/capability here.  A set of partially
overlapping RCU read-side critical sections are implicitly "flattened"
into one long critical section covering the full set.  For example:

	spin_lock(&mylock); // starts RCU read-side critical section...
	local_irq_disable();
	spin_unlock(&mylock);
	preempt_disable();
	local_irq_enable();
	local_bh_disable();
	preempt_enable();
	local_bh_enable();  // ... and continues to here.

And rcutorture tests randomly chosen combinations up to eight segments
long.

So it is an interesting choice as to how much of this should be accounted
for by BPF.  Choose wisely!!!  ;-)

							Thanx, Paul

> Thanks,
> Puranjay
> 
> [1] https://docs.kernel.org/RCU/whatisRCU.html#:~:text=Note%20that%20anything,side%20critical%20sections.
