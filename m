Received: from mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59803B058C
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 18:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790275842; cv=none; b=UPMNtd4fKkluD21lTcVuF9g7KIrTM6IKDpJ2N2+/SxdGRB/9emtcNu8xzxL3VghX2U3O2AH+XVoa07w4F6IJFYJID8kphFY95auA77Ku+vV5g34P3YXu5lSDluq3UumbfI+LEpahPmFppqZXHFixtEFEXcJrcUdwN7/7RL7FEzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790275842; c=relaxed/simple;
	bh=wwO3fY8wiWeLu70HfX7+HYNTDjHJ8k0nCAXKE84dEZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfDOMmPyF5Zm1RSQA5g51rn/mPh6yyBsfo5xZTm+vLZwOvv5QViOfrm1Mga+SKDkl2H14vNthSnKw9zGNMG6ZhA0ekjsl8bC4N8h0csAJcKevScnZ29K/tz2IH0+mJttH9uzoxAVjvR4C4d8d9aK9QlQdDY+bfG+IVaZZT54PpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lJCCyO2F; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lJCCyO2F"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=wwO3fY8wiWeLu70HfX7+HYNTDjHJ8k0nCAXKE84dEZ0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790275836; v=1; x=1790880636;
 b=lJCCyO2FaalPN0PkwolHPxvv44Q23fPFcLTIU9qjZgx167d5q03NDdOhI4+AlMfbZTYA83MO
 o9VpV4tbAkI/FLHYkxrb0rn57gnLrGOGESVHUytz8Dy2RzOBhYwbLoE13NCWGx441jEkeeqZW/g
 +gqrkRzlFeNfGMHoFKaHmV40=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2b345eaae1d9b58d;
	Thu, 24 Sep 2026 18:50:35 +0000
X-Mizu-Trace-ID: 2b345eaae1d9b58d
X-Migadu-Flow: FLOW_OUT
Date: Thu, 24 Sep 2026 11:50:34 -0700
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Peter Zijlstra <peterz@infradead.org>
Cc: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Suren Baghdasaryan <surenb@google.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	David Dai <david.dai@linux.dev>, JP Kobryn <jp.kobryn@linux.dev>, 
	Frederic Weisbecker <frederic@kernel.org>, Aaron Lu <ziqianlu@bytedance.com>, 
	Daniel Jordan <daniel.m.jordan@oracle.com>, Hao Lee <haolee.swjtu@gmail.com>, cgroups@vger.kernel.org, 
	bpf@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/7] cgroup: charge kernel work to the cgroup it is
 done for
Message-ID: <arVwmhAg1CSQAoX1@linux.dev>
References: <20260924184529.879516-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924184529.879516-1-shakeel.butt@linux.dev>

Somehow the git send-email got killed in between. Please ignore this.

The full RFC is at
https://lore.kernel.org/20260924184714.912181-1-shakeel.butt@linux.dev

