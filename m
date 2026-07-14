Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E46127587D;
	Tue, 14 Jul 2026 23:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784073377; cv=none; b=kISQ4q1/bU4v0TggFpy+kOy2vrWB5Tg2NaxEeXsRYCzh9g41fo8m+exc8wdS7A3ggf4ktoM5/ip/CdI/6pEgBC7/Vpq2/JkhKBRQdIICDZ5zju8QHxvVQxM/jS7or3mU129/1dRdSufxno/YbvL+KTLweFZjITu0I2Z1YEi3y9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784073377; c=relaxed/simple;
	bh=lv+Vv4vLOjz9vGIGt0vpsKkIVSI5c/rk3NRjSUaYapg=;
	h=Date:Message-ID:To:Cc:From:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o99++7lJm05QSe5USpLrp/lqN42reIquVrhtkGOygT9nz/xtmSyVF+b+10kWbITcBjiVQqKU5v9qFlfCs976v1pAjLG2UCs+rMkzC14SdBmwnL35maNzKM7COjEsOdylr4xPSm9TsOWL8pZX2Xzevd6Kk91vC7H6xiiZxT/K0dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gg6bNl3l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gg6bNl3l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3077A1F000E9;
	Tue, 14 Jul 2026 23:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784073376;
	bh=0h5Va8ni1OohLi1Sssv6cbVzXGa++iFfEvuH90v5y5I=;
	h=Date:To:Cc:From:Subject:In-Reply-To:References;
	b=Gg6bNl3lmKw+NRzUEzgK1q68hYwul3RruxnDCh4lw+47I9/SG9gXOTz3eCyUtmYit
	 Jcf6+34eTfPMMwM1SH7Ff9X5J3tR81MXm92AmSRhxE7nsBYAR/VV/2pA+bwMW1Z4rG
	 KLxHfdBnqZ/+M/VdRlqd7oenWP4HTQK4bdG8CQSxDhEv0Ry1xh59PoNSBMBFGPeYTK
	 I1fe7QVX7de+dMDl8FPCaZ3WTJ40LpDuBfFVOa52H1KnbrlnCk8WcwTaOyRtseY5FH
	 KlhenNwdiL2NnJeccVnbxS5WLLBHiVcDV0onJ+V99TmtoGp3tbemGYed6ncAElioGa
	 pBnasDgnY+f3Q==
Date: Tue, 14 Jul 2026 13:56:15 -1000
Message-ID: <7c5d028a7a46a2917a3fcc8d1eccf084@kernel.org>
To: zhidao su (Xiaomi) <soolaugust@gmail.com>
Cc: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] sched_ext: Validate cid override before updating tables
In-Reply-To: <20260714024704.3318132-1-soolaugust@gmail.com>
References: <20260714024704.3318132-1-soolaugust@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello.

for-7.3 already does this. scx_bpf_cid_override() validates the whole
mapping first (cid_valid() and the duplicate check) and only writes
scx_cpu_to_cid_tbl/scx_cid_to_cpu_tbl in a second pass, so a failed
override leaves the tables untouched. It also kmemdup()s the input up
front to avoid a concurrent-mutation race.

The patch is against an older cid.c and no longer applies, so no respin
is needed.

Thanks.

-- 
tejun
