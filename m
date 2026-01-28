Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2114923EAB3;
	Wed, 28 Jan 2026 08:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769590014; cv=none; b=Qgg4DzK3umf3zm9EIqz9xi6S6sbeuC4u2S6bA+6Eixnpv3ZHSLV/mAumaAniHkJadObiCm7OJNRajWrEt5RMLt3QT3J/ZKCqsI4PtFaHV7FLIfjoiIwkYmw1U9cu6fVl7TisCiqtusbXg53r2Eu3xGxhmcmtOOO/FZ4LpTuHZCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769590014; c=relaxed/simple;
	bh=+XP7TKLKMP2iI43Cq419V2HCtzSjoQCGqsdjvG4LxYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXEhv46VFucex/a64MrPWOk0k5U7+E8XBqfhhcGrZ6NO85+WYe97/WKzPXM7rDJRrkgJB35Q1IBNhfrJzVZavqZNdLPEQbP6w1zytACBJA8tTmB0UFVH0ksNj/+yqqW447LqFdV14VW203JUV56LmYnT3P2BjOMuoWDoR4xtUsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CTaO7UHu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CTaO7UHu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ayBrCzFssGZ1vK+gQhCWjuWjGXFaXI8f7cM+Qt4R5zg=; b=CTaO7UHu4vz4tlMZz6OZSKzlPg
	S3vYo3dGdgqKxi5K4mPUVmGAOQxGWbO/dCV6LnAPXY2SMghsnAF+3ggFSLDA9knn7A+fd2M7NYLat
	QEhJnPeGjQwz3xD67uBPNpaskHSttt+jA5c//UJYwe3fIBH6hglP+RHwfLf21rHgZxk/qoKXthKan
	1sAiF51BWxAGWg9i3fEUTCjr1e9caKh6vgIlxF9l9wL5d+shmx2O8sbnGjRgDel9pUmqPSh6Il9FA
	NvxTt6CADDqg9z1UeHJ5jY2fTldO6RyBHoWObdcq+7esGgTY90QT3Lz39qnSwj1uWwpmK7/kDBb9Q
	dmioE3vw==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl1Bz-00000008lvA-42T7;
	Wed, 28 Jan 2026 08:46:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 51C8E300754; Wed, 28 Jan 2026 09:46:16 +0100 (CET)
Date: Wed, 28 Jan 2026 09:46:16 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michael Jeanson <mjeanson@efficios.com>,
	Jens Axboe <axboe@kernel.dk>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Florian Weimer <fweimer@redhat.com>,
	Tim Chen <tim.c.chen@intel.com>, Yury Norov <yury.norov@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>, bpf <bpf@vger.kernel.org>,
	sched-ext@lists.linux.dev, Kernel Team <kernel-team@meta.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Puranjay Mohan <puranjay@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [patch V5 00/20] sched: Rewrite MM CID management
Message-ID: <20260128084616.GD3372621@noisy.programming.kicks-ass.net>
References: <20251119171016.815482037@linutronix.de>
 <2b7463d7-0f58-4e34-9775-6e2115cfb971@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b7463d7-0f58-4e34-9775-6e2115cfb971@linux.dev>

On Tue, Jan 27, 2026 at 04:01:11PM -0800, Ihor Solodrai wrote:
> On 11/19/25 9:26 AM, Thomas Gleixner wrote:
> > This is a follow up on the V4 series which can be found here:
> > 
> >     https://lore.kernel.org/20251104075053.700034556@linutronix.de
> > 
> > The V1 cover letter contains a detailed analyisis of the issues:
> > 
> >     https://lore.kernel.org/20251015164952.694882104@linutronix.de
> > 
> > TLDR: The CID management is way to complex and adds significant overhead
> > into scheduler hotpaths.
> > 
> > The series rewrites MM CID management in a more simplistic way which
> > focusses on low overhead in the scheduler while maintaining per task CIDs
> > as long as the number of threads is not exceeding the number of possible
> > CPUs.
> 
> Hello Thomas, everyone.
> 
> BPF CI caught a deadlock on current bpf-next tip (35538dba51b4).
> Job: https://github.com/kernel-patches/bpf/actions/runs/21417415035/job/61670254640
> 
> It appears to be related to this series. Pasting a splat below.
> 
> Any ideas what might be going on?

That splat is only CPU2, that's not typically very useful in a lockup
scenario.
