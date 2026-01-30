Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E39BF507
	for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 00:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769732431; cv=none; b=mx3ZcbE7uzib2kS2xpSt88EwIqbp9OPCH2lJ1yip3s1+UryIBAM5+sVaniPkpz+pZcMLkKoy05zB0wPslTnjAUq6loD991cK111+GHYA1jYr0NhT7MoXQwAgZrNVXIjfRUqKub5+osUCEOYaHtTiOgfErPXR/IXyabAX/gRJwnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769732431; c=relaxed/simple;
	bh=d3pN3ZqURn7m9Kll7g9wucXUukIajYqJ65oOxIxUBI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TDs8zES7NCgd0njAOl7xYmvbjwuL10GVPAMWAYEwxlfEz3vAJzjYL6bgjRwtMUPM5vIMO2X5k+OmqAoD71frscCtTF6qOe+6fmNuXob0Mt/rwC9ETn7WKiSo9GlQUZPACcfSDzDc16JhMRbhkLGcxzyH6Sv4m0aCOy3Fj/D6VfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eKQAG9xM; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eKQAG9xM"
Message-ID: <969dda1a-1126-4313-80dc-b2df8e5435e1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769732427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TAAk0lB9kOwahuMysui5IUk6b/Kc/Wb9vWPicJvP6jE=;
	b=eKQAG9xMX6PshhZsAVZTqj69zG1lomtweQqeTkkresApMhHpkRp47oYQ2pBaYmnEW2cz0z
	yEsVs1UI9WpSxjQBvUFxboTkQVWf5KF0CPtC3t00oojKjTrCBmHkXk1fxpvRIm+9rshVc8
	ajU72XOauGBmo+RONJ06eFBvPTIDvF4=
Date: Thu, 29 Jan 2026 16:20:04 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [patch 0/4] sched/mmcid: Cure mode transition woes
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Michael Jeanson <mjeanson@efficios.com>, bpf <bpf@vger.kernel.org>
References: <20260129210219.452851594@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260129210219.452851594@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/29/26 1:20 PM, Thomas Gleixner wrote:
> Ihor and Shrikanth reported hard lockups which can be tracked back to the recent
> rewrite of the MM_CID management code.
> 
>   1) The from task to CPU ownership transition lacks the intermediate
>      transition mode, which can lead to CID pool exhaustion and a
>      subsequent live lock. That intermediate mode was implemented for the
>      reverse operation already but omitted for this transition as the
>      original analysis missed a few possible scheduling scenarios.
> 
>   2) Weakly ordered architectures can observe inconsistent state which
>      causes them to make the wrong decision. That leads to the same problem
>      as with #1.
> 
> The following series addresses these issue and fixes another albeit harmless
> inconsistent state hickup which was found when analysing the above issues.

Thomas, thank you for addressing this so quickly.

I applied the series as temporary BPF CI specific patches.
I'll report if I notice any relevant issues.

> 
> With these issues addressed the last change optimizes the bitmap
> utilization in the transition modes.
> 
> The series applies on Linus tree and passes the selftests and a thread pool
> emulator which stress tests the ownership transitions.
> 
> Thanks,
> 
> 	tglx
> ---
>  include/linux/rseq_types.h |    7 -
>  kernel/sched/core.c        |  170 +++++++++++++++++++++++++++++----------------
>  kernel/sched/sched.h       |   45 +++++++++--
>  3 files changed, 151 insertions(+), 71 deletions(-)

