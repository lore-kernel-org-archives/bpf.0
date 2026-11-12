Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501090;
	b=5T0EFIauUWHtvEokiz0NkYmtXamwXCB+EATmaRk/Lero7lSXF/e2ryCxykPqeSqHkUoE
	 aU8q42n0mcf8rAYaondkJqx5GvLt0fV0Bp/+fZrQ4aasX1JTJmjWkW28y11WDupZGn5mT
	 bYKzpyF7CYFhwIAJhKDroImA8ash53XSR0fe9wAbSlnNJBFR81eIwJlZxdcHy4PFcwtVc
	 ojyYLuXsC/jZ8oquLLVfzPfYKfYeyfVYxP9RF9CjcjW/T87YylCNhqt95t3nq64PlUrvy
	 AtckfUtiahCFCOQI/3d/CMRBYZmrvnyAA/LPm7kF6gDYjbQqi/lCjr8cOxT7P8mvoSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501090;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=NXHP9rMA5Jf8CLZLVoZt/ydGAK7mnAO+64jaDQMpezQ=;
	b=YJ3JfrCRhP6n5ZT+yG6RHE+GfXOidixvDkclnGVpAAFsD+qqosT6fUbGjalFcUuoqQAo
	 91gDhEXlEJgz8ePEcCFDLD6VzXAjIdvYc/zAK48j5CkYC6pAvZqlYsMkgpCSc6c3UcHxK
	 +UjAGDLf6JzfBCNVEoodNXerlQC4CmBSixK6YvaKMHomfSh7zqaszhC2GWc34aDY63HDp
	 2MWaDxkK+ZOMPhEGUvMVpRJ7W+9EKZTq+QgPuEx4MfgciqV4lyDyjWw5qcnGd4a6fAFN9
	 XUzuXvm+XeXZKjDGW+00Xj7ZfOaBs2fHoFuqk7owsokL37MLBz3TTnDcIPPEDA9nAWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=Dg8xYo+i;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD3F606A89A;
	Thu, 12 Nov 2026 16:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDD3F606A89A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=Dg8xYo+i
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NXHP9rMA5Jf8CLZLVoZt/ydGAK7mnAO+64jaDQMpezQ=; b=Dg8xYo+i5qYGvtChOj6GMyc4ct
	mBnTLoGePkq+8YXRuP0TMs/x53PffymBSVL8jWc+zW2Xbq8KBsvBtw3fne7+5O+rkpk3acMZc8DQ5
	W4jUoRslL/Xyck+MO+rgLS8gy7YnxhyQqlvvmy/UTP0fwofrbsc0pq9Hbtx1e+aY2mpwbyUHDyJyV
	t59j2XAdQ1C5d/JuC5v4t9VF11hOVZm5kb4b+mdak4OlPgWTRTceSr6GQvWj5d72IVHxeucKkPcyS
	e6wXM2ZzhAjbtPo8qTz/9zw4xfuFl02Qz21Xl0+yk682CX5uTFG5qarNKAuH4gy1WTyQy1fYcggcX
	TU/oK4SQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRXhs-00000008xQd-19qT;
	Thu, 12 Nov 2026 16:31:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B58ED303011; Thu, 12 Nov 2026 17:31:23 +0100 (CET)
Date: Thu, 12 Nov 2026 17:31:23 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tao Cui <cui.tao@linux.dev>, tj@kernel.org, void@manifault.com,
	changwoo@igalia.com, mingo@redhat.com, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH 2/2] sched_ext: Block a retained donor before PI deboost
 routes it back to sched_ext
Message-ID: <20261112163123.GW1779021@noisy.programming.kicks-ass.net>
References: <20261112144935.583937-1-cui.tao@linux.dev>
 <20261112144935.583937-3-cui.tao@linux.dev>
 <20261112152118.GD1813469@noisy.programming.kicks-ass.net>
 <avXjsO_fLaUC_4mG@gpd4>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avXjsO_fLaUC_4mG@gpd4>

On Thu, Nov 12, 2026 at 05:05:04PM +0100, Andrea Righi wrote:

> To recap, we ran into this while developing the proxy-exec support for
> scx. Earlier versions were handling the PI deboost case too and we also
> explored passing next_class into sched_change_begin(). But that didn't
> make it into the final version and it was left as a future improvement,
> to keep things simpler.

> Would it make sense to revisit the old idea passing next_class into
> sched_change_begin(), so we can handle entry into EXT consistently
> before recording the queued/running state and replace the separate
> class-entry preparation hooks?

As per my follow up email, I think all we need is for the existing
switching_to callback to return a boolean to indicate if the class is
willing to accept blocked tasks.
