Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639071B3B19
	for <bpf@vger.kernel.org>; Sun,  2 Aug 2026 02:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785639544; cv=none; b=eOUGm3nNzCQKpYVf0D7UE8qGX3dwF3xXEsPcstlR5zSkGls+ndyk0ERHH+/EZJ0IiKW98kuODJszjDC/7+cbBmKr3Q4PjwUht7zbPphWZTg/1LeebSdl8lUMgtoN8Wl+xCQkSQdTBqJvh9dM4S9lDr2ZGoxhQEH6qfnLJrc7j8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785639544; c=relaxed/simple;
	bh=/kI/uQPh08nBC+0A1WngsWcVx2slFH6YI60SAvHFtFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDhkowjvkGIl52+VmdFLEyrlhyWCeIi+cYlqGy226sgE7EF5cqe+laJgRS8lds4J9IynCrmL4aWSJ166LwxZ9zH+HUvvKxVDa9HQ+T6n6ogNy1Bo4cxH67YKmQtA39lY3FwOpLMNR7ooCDnb+qQm1w6/tMrfsk3DbFRdrjgJaeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcmgMzFG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcmgMzFG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE241F00AC4;
	Sun,  2 Aug 2026 02:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785639543;
	bh=O9/UOn0VzUwljjyURZfIwqsLzvzqkevEdbiLoOiL1F4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dcmgMzFGYoM70SKPq3fpXRicIhjbpOHbZrVeh4mdZHgvAQc9U7w762ae/cYwT/JW2
	 6CKWLxfuu+bj2/gd6m8M1fco/8FGuSqbZZEwyRhWNjaF3Gi0QT47DPG9RkktmbWjgq
	 bodWIYMRqxtTwSbZeqWskBDIR73r3VTWufX0luvMvJyQWQ44DDAOxcDyiUxWkW0ips
	 n/pECsrr6DySN4FkByicZVZBCyIKgFPSBZrYWYzSbLrNdNOIQI3N9r2V+zLijHOsBE
	 m8fZAfWnPWtXb0xP1Oo8Da67oaYU6ydbj5Jxo5IpV6Gid836lIwXBR6XDpaFVr/fHR
	 eWPSnAiBiXjqA==
Date: Sat, 1 Aug 2026 16:59:01 -1000
From: Tejun Heo <tj@kernel.org>
To: Imran Khan <imran.f.khan@oracle.com>
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/6] workqueue: introduce BPF iterators for
 workqueues, worker pools and pending work
Message-ID: <am6ydQ0kl-KVOf_F@slm.duckdns.org>
References: <20260728065525.653171-1-imran.f.khan@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728065525.653171-1-imran.f.khan@oracle.com>

Hello,

On Tue, Jul 28, 2026 at 02:55:19PM +0800, Imran Khan wrote:
> Nearly every subsystem defers work to workqueues, and their state can
> already be observed on a live system, just not at a granularity that is
> convenient to consume. sysrq dumps every workqueue and pool to the kernel
> log in a fixed format, with no way to select or aggregate; the WQ_SYSFS
> interface only covers workqueues that ask for it and exposes attributes
> rather than runtime state; and the drgn scripts under tools/workqueue/ need
> a debuginfo-equipped userspace and read the state from the outside, without
> the locks that protect it.
> 
> This series adds BPF iterators for workqueues, worker pools and pending
> work items, so that this state can be walked from inside the kernel, under
> the right locking, with filtering and aggregation done in place and only
> the interesting part copied to userspace.

I'm not necessarily against it but what are the use cases here? If for
debugging, isn't drgn + hooking into tracepoints mostly enough? Can you give
concrete examples where bpf iterators are essential?

Thanks.

-- 
tejun
