Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD40C481249;
	Wed, 21 Jan 2026 12:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768998733; cv=none; b=s+05WHDdV7Ne3YAFGSXvEw0ufJH+j8q6gGfBLUmoYXkrT2OCsMGK7qRH00rmh39Ni6jsNWzpL2CvhespOVC2/bex9DYG66cIfz09ycLfOxiX9r2Mz2MGCPfcGVdzsoK5edQ1uj/ocX+mvZN0tbKbwr3MoGzgrKPPJnuAgpY2WGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768998733; c=relaxed/simple;
	bh=TKmBD3wMTYGnnSIyqgHvZ8408CB0bV1cHpzW6hEk7IA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fv/4nTKETn53ZV5JNNLdnd5JdueqKSQ1u87XnYa1c7pABNrPjB5OOtl98+KlGs4LRhcwTtPj/2+U95R40mh9UFf9nl+NHNy4NdAEUXpHf2imyCoTpTAkNp7uR+ky8FzyAcGWCSA/+DhYDUnhEcK8oR1RfUNsVffvRvisoXZ0B8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Q5ofDBPh; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q5ofDBPh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jm9KOekyMaIvG1IHwWQxXsPb5I+Gjrh8cmaL7hob7N4=; b=Q5ofDBPhgIapiaO5Bl9LfVi8DX
	PmTWENthedXZmx+xRJtOweYa3h9fuJToRp7dJb2jw6WkdkRoKDd/pHMO5Kyy9VtroEWSZWtjdtRgj
	REBb2mJqkz2PjRnE4OVGb1MoRtkq1DMR6/pqkofzMf0lZmfiG9T8E7yhLukT0/pzwGXVpXhdFRSVg
	B1A7Igwx1sL0GKoKHI7YkPNOWG19mjeQeEUeWx2QJYQ9CxhlGmktmWEnW6No0XEDmrhZC8JIhrUgK
	u3uiuYDdQueCs0VbcmEhdbW/4TU01HZjpA7HZEjJl/sl+YwRu/NFfwxeJIrqW0BGs3pHtEhPseB89
	iEz+4WCg==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viXNP-0000000FzrD-1x4x;
	Wed, 21 Jan 2026 12:31:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 356433003C4; Wed, 21 Jan 2026 13:31:58 +0100 (CET)
Date: Wed, 21 Jan 2026 13:31:58 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Loehle <christian.loehle@arm.com>
Subject: Re: [PATCH 4/7] sched_ext: Add a DL server for sched_ext tasks
Message-ID: <20260121123158.GB166857@noisy.programming.kicks-ass.net>
References: <20260120215808.188032-1-arighi@nvidia.com>
 <20260120215808.188032-5-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120215808.188032-5-arighi@nvidia.com>

On Tue, Jan 20, 2026 at 10:50:35PM +0100, Andrea Righi wrote:
> sched_ext currently suffers starvation due to RT. The same workload when
> converted to EXT can get zero runtime if RT is 100% running, causing EXT
> processes to stall. Fix it by adding a DL server for EXT.
> 
> A kselftest is also included later to confirm that both DL servers are
> functioning correctly:
> 
>  # ./runner -t rt_stall
>  ===== START =====
>  TEST: rt_stall
>  DESCRIPTION: Verify that RT tasks cannot stall SCHED_EXT tasks
>  OUTPUT:
>  TAP version 13
>  1..1
>  # Runtime of FAIR task (PID 1511) is 0.250000 seconds
>  # Runtime of RT task (PID 1512) is 4.750000 seconds
>  # FAIR task got 5.00% of total runtime
>  ok 1 PASS: FAIR task got more than 4.00% of runtime
>  TAP version 13
>  1..1
>  # Runtime of EXT task (PID 1514) is 0.250000 seconds
>  # Runtime of RT task (PID 1515) is 4.750000 seconds
>  # EXT task got 5.00% of total runtime
>  ok 2 PASS: EXT task got more than 4.00% of runtime
>  TAP version 13
>  1..1
>  # Runtime of FAIR task (PID 1517) is 0.250000 seconds
>  # Runtime of RT task (PID 1518) is 4.750000 seconds
>  # FAIR task got 5.00% of total runtime
>  ok 3 PASS: FAIR task got more than 4.00% of runtime
>  TAP version 13
>  1..1
>  # Runtime of EXT task (PID 1521) is 0.250000 seconds
>  # Runtime of RT task (PID 1522) is 4.750000 seconds
>  # EXT task got 5.00% of total runtime
>  ok 4 PASS: EXT task got more than 4.00% of runtime
>  ok 1 rt_stall #
>  =====  END  =====
> 
> v5: - do not restart the EXT server on switch_class() (Juri Lelli)
> v4: - initialize EXT server bandwidth reservation at init time and
>       always keep it active (Andrea Righi)
>     - check for rq->nr_running == 1 to determine when to account idle
>       time (Juri Lelli)
> v3: - clarify that fair is not the only dl_server (Juri Lelli)
>     - remove explicit stop to reduce timer reprogramming overhead
>       (Juri Lelli)
>     - do not restart pick_task() when it's invoked by the dl_server
>       (Tejun Heo)
>     - depend on CONFIG_SCHED_CLASS_EXT (Andrea Righi)
> v2: - drop ->balance() now that pick_task() has an rf argument
>       (Andrea Righi)

FWIW (for all these patches), those v# comments, they go...

> Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
> Tested-by: Christian Loehle <christian.loehle@arm.com>
> Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---

... here, after the ---.
