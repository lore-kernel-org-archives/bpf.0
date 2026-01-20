Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208533EFD27;
	Tue, 20 Jan 2026 23:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768950605; cv=none; b=Dk6z8B5gApQtnhR8nRNmdybyvj2+9wo+jYYziijOHS6qO7ySYEgSUEfEgwSos+m9eHQnvXr0HTW8fEKmE+4MMVvCpU41WObcvX94cJrwakI8quu0yQ/Iv61bvkr1d597x2VwMBLNUx5rdcG1+sEKHAVlEtAeSWlHfRrY4e4d3kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768950605; c=relaxed/simple;
	bh=3IjOD+VAe3GNNkUX/GpyE+1pGlICS4A+BZXqn9AqPxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esz2+ZvUSzw9cx4Znimpne3CWxHkIEW4qNBDOwC3xN7PbuogT0E06t8vsM0oQ/avt2fcsu7a+aOZCFZ5jdwr6ZN6uvolxNuz1r1bG78LOIDWjS2EbvVx4rNqQb94xZOKwT5aDrzQt0RDknrbw6414Kt33PbnCBfepYLu6d+qMTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrAPU/Kt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrAPU/Kt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1FFC16AAE;
	Tue, 20 Jan 2026 23:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768950604;
	bh=3IjOD+VAe3GNNkUX/GpyE+1pGlICS4A+BZXqn9AqPxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FrAPU/Ktfm6dxyYY59hwlo0toVLt/BhpdvioyNY+14p9uOAkzQ7mpvcQatGAZU/vb
	 ZI9ZjBeywNo+e3ahs+108jYuXvNlTUwzTTYm0vqK529q8+xnN7fttD9Al5USirTbH7
	 cCmpAjoJDn6ZDQf3xJtMk39F9IirxAdd6Ltd1mGVmD15wnrhiPirITrvhelR+CaLiV
	 7i+qcWlMN9Sftw02YkNW60QtcSv07JRwYbpGMs842gpbdCwIdN2ASabDHbbwTdljM4
	 RN80jvkHIAdZVq+2zPkgC7o0LDIB2zRi+kPKxk4LV4h2StEuMsZTQwWFHmra2MWCMQ
	 hilE+hrl+sHGg==
Date: Tue, 20 Jan 2026 13:10:03 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET RESEND v11 sched_ext/for-6.20] Add a deadline server
 for sched_ext tasks
Message-ID: <aXALSwggUpMBJnZu@slm.duckdns.org>
References: <20260120215808.188032-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120215808.188032-1-arighi@nvidia.com>

Hello,

On Tue, Jan 20, 2026 at 10:50:31PM +0100, Andrea Righi wrote:
> This is a resend of the patch set originally posted here:
> https://lore.kernel.org/all/20251217093923.1556187-1-arighi@nvidia.com/
> 
> Re-sending to check whether there are any remaining objections. As
> discussed during the LPC sched_ext microconference in Tokyo, a potential
> "open issue" could be to define a better interface for configuring the
> assigned bandwidth for the DL servers (currently via debugfs). However,
> this shouldn't be a blocker and we can likely discuss this further at the
> upcoming OSPM.
> 
> Tejun, if there are no further comments, I think this series can be applied
> to sched_ext/for-6.20.

Yeah, this has been pending forever. Peter, Ingo, Juri, if there aren't any
objections, would it be okay to apply these through sched_ext? Or do you
want to route deadline part through sched/core?

Thanks.

-- 
tejun
