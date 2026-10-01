Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A913909BF;
	Thu,  1 Oct 2026 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869788; cv=none; b=QouiOd/M7ehOBaqR4TeG0DgAnswWqnLr+PEKDnzNgLVV4vXvXQ0UFW3jkKcAwYNIzSB7z0bgMYGdxfqaSwE3KczGSjqWTz1Sf4WPzcvnzsj8rs9Ycuuib+UGJQJgEdIwZl3hHF+VPp2XOVxMVXEN+rcniFo3TSgYmNbwjdMFDgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869788; c=relaxed/simple;
	bh=WjKuKcb5daavebDKTVBv1ViKiif6cXNwReONapeldT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvnAXx8+ghw96jtkrU0/TWcUo58tGR2Pukzht+jjP7V7a61w1qdtQ7HnQ9Kcg5mf7qGfOqartsTi5/NBogR9b31LgDSgiUAmAsY51XEnnWzDTmvNrqd9exxve8/+D2dmP0Z84UCsn9AAWc0g8zLcWm4659vwO5LNp/LUZsdjeyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mB3xQ7OL; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mB3xQ7OL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CwCNZwJCJdJ17fMRBLRacvbvjnwe/+Ql4dP2Gc32nCs=; b=mB3xQ7OLqbg/Kz8Qh8PyFfK9F2
	CHugfzwiu3uarezWfDbPROBM1Ol7/L0ytpdAWL49EmZuTWGSWeq6C3xM8jpED9xNN9yj02xBt4M+T
	nIb6mOkH9kOfMzpBU6Phh8mWJalYlsPMXrvE6tEcckkO7cM6HZhngC95ucomAb2nN8jBEKx8JC9mN
	dP+GF4YLEzFg7D/1mDCo/1a2WKMZsS9g7kX6MVNg34NslPHkXr0AhIKdwTU5/n0PNYd93iQA3pwgZ
	P/n67HUonp4+I5xPIJoJTP9x9n81jLgIDzc4+lg5Zw3GAcOa7Q8zkO7Rfqg2pMmI/ZUpVgphn/d4Y
	AOFxnyqg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1xCJ2N-00000005A22-3JVy;
	Thu, 01 Oct 2026 15:49:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9A2B8300390; Thu, 01 Oct 2026 17:49:34 +0200 (CEST)
Date: Thu, 1 Oct 2026 17:49:34 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Nam Cao <namcao@linutronix.de>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Wen Yang <wen.yang@linux.dev>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH v2 01/15] sched: Add task enqueue/dequeue trace points
Message-ID: <20261001154934.GT88198@noisy.programming.kicks-ass.net>
References: <20261001152042.124445-1-gmonaco@redhat.com>
 <20261001152042.124445-2-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001152042.124445-2-gmonaco@redhat.com>

On Thu, Oct 01, 2026 at 05:20:28PM +0200, Gabriele Monaco wrote:
> From: Nam Cao <namcao@linutronix.de>
> 
> Add trace points into enqueue_task() and dequeue_task().
> 
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>

Obviously I don't remember anything at all. But also, you 'forgot' to
send me the rest of the patches which might hold a clue. As is I'm
clueless as to why we want this, since the Changelog also offers none.
