Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00123290D5;
	Fri,  8 May 2026 16:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778256945; cv=none; b=V/dQnORMb5TzFHSpNTLFZWQLvQ0aF0vVOB4cuOdLy/RuXj8kOZouw7l3BOKVgrxPlSWxSKjENcZTfj8STVC9UyGYsVWRNHQDE+egx0+PywmDloPcdd62XP8JeICvnjXc565TtYPYTL0ca4sJY/hA3zOncnhrROxHvldefZ+I8jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778256945; c=relaxed/simple;
	bh=Ft2CV7mOczaOt1OzoiUOD/+6KLhVH4/495HB2YVzZFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H56Mxl/bBSk3n22DtdrYG+I5+UAHZ3IFxufBE5T5Y3d//kpTppSginm5Q5miUXdwrQg/Gp6OoNAIgYRaAE8TUqLoqB2iJbudk+i6OGWIXIiN4K9wOKaQzvkHRbMdC9S9Q5PrZDZ16bOvYEC0oYkWPVl6PuS1pdJcq6/lOoKNcNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJYFXwr/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJYFXwr/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9DCC2BCB0;
	Fri,  8 May 2026 16:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778256945;
	bh=Ft2CV7mOczaOt1OzoiUOD/+6KLhVH4/495HB2YVzZFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pJYFXwr/jVOt2dthilIBJ4EW9vU1GA/rNvI8q3uHg8znFcrjpqg2ecAz9ArE/89sc
	 vVnvuPJdelz2beT23aYiFRZ9Irxr4+CzIiLYEpSHF0neJd2dS+UhJfLGWA0H5vIDbp
	 1s3fylw+iVx7Jg5mmOnJXnrQBy5h35BfUZfzbopSEGmfIwO6GcDQNyYsGD9kI48He8
	 P+q7Npvr82EhjN6MwgVVpYFtPcmk3kobD633dw0VTxK6LA71K2K4TOPflRFhIPlxNj
	 3scx0jSRHVXvMDhRGFAfMCNtTfb/Dt8pXLEhwYKUlyUg0Dzu6AovNWAIeubFl0nfN0
	 utEYw6QNRQSiA==
Date: Fri, 8 May 2026 17:15:30 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Vernon Yang <vernon2gm@gmail.com>, akpm@linux-foundation.org, 
	david@kernel.org, roman.gushchin@linux.dev, inwardvessel@gmail.com, 
	shakeel.butt@linux.dev, ast@kernel.org, daniel@iogearbox.net, surenb@google.com, 
	tz2294@columbia.edu, baohua@kernel.org, lance.yang@linux.dev, dev.jain@arm.com, 
	laoar.shao@gmail.com, gutierrez.asier@huawei-partners.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, 
	Vernon Yang <yanglincheng@kylinos.cn>
Subject: Re: [PATCH v2 0/4] mm: introduce mthp_ext via cgroup-bpf to make
 mTHP more transparent
Message-ID: <af4KaeaCWUSfOS-Z@lucifer>
References: <20260508150055.680136-1-vernon2gm@gmail.com>
 <af4HYivyP7LDG2-k@pedro-suse.lan>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af4HYivyP7LDG2-k@pedro-suse.lan>

On Fri, May 08, 2026 at 05:00:04PM +0100, Pedro Falcato wrote:
> On Fri, May 08, 2026 at 11:00:51PM +0800, Vernon Yang wrote:
> > From: Vernon Yang <yanglincheng@kylinos.cn>
> >
> > Hi all,
> >
> > Background
> > ==========
> >
> > As is well known, a system can simultaneously run multiple different
> > scenarios. However, THP is not beneficial in every scenario — it is only
> > most suitable for memory-intensive applications that are not sensitive
> > to tail latency. For example, Redis, which is sensitive to tail latency,
> > is not suitable for THP. But in practice, due to Redis issues, the
> > entire THP functionality is often turned off, preventing other scenarios
> > from benefiting from it.
> >
> > There are also some embedded scenarios (e.g. Android) that directly use
> > 2MB THP, where the granularity is too large. Therefore, we introduced
> > mTHP in v6.8, which supports multiple-size THP. In practice, however, we
> > still globally fix a single mTHP size and are unable to automatically
> > select different mTHP sizes based on different scenarios.
> >
> > After testing, it was found that
> >
> > - When the system has a lot of free memory, it is normal for Redis to
> >   use mTHP. performance degradation in Redis only occurs when the system
> >   is under high memory pressure.
> > - Additionally, when a large number of small-memory processes use mTHP,
> >   memory waste is prone to occur, and performance degradation may also
> >   happen during fast memory allocation/release.
> >
> > Previously, "Cgroup-based THP control"[1] was proposed, but it had the
> > following issues.
> >
> > - It breaks the cgroup hierarchy property.
> > - Add new THP knobs, making sysadmin's job more complex
> >
> > Previously, "mm, bpf: BPF-MM, BPF-THP"[2] was proposed, but it had the
> > following issues.
> >
> > - It didn't address the issue on the per-process mode.
> > - For global mode, the prctl(PR_SET_THP_DISABLE) has already achieved
> >   the same objective, there is no need to add two mechanisms for the
> >   same purpose.
> > - Attaching st_ops to mm_struct, the same issues that cgroup-bpf once
> >   faced are likely to arise again, e.g. lifetime of cgroup vs bpf, dying
> >   cgroups, wq deadlock, etc. It is recommended to use cgroup-bpf for
> >   implementation.
> > - Unclear ABI stability guarantees.
> > - The test cases are too simplistic, lacking eBPF cases similar to real
> >   workloads such as sched_ext.
> >
> > If I miss some thing, please let me know. Thanks!
> >
> <snip>
> > kernbench results
> > ~~~~~~~~~~~~~~~~~
> >
> > When cgroup memory.high=max, no memory pressure, seems only noise level
> > changes, mthp_ext no regression.
> >
> >                             always                 never               always+mthp_ext
> > Amean     user-32    19702.39 (   0.00%)    18428.90 *   6.46%*    19706.73 (  -0.02%)
> > Amean     syst-32     1159.55 (   0.00%)     2252.43 * -94.25%*     1177.48 *  -1.55%*
> > Amean     elsp-32      703.28 (   0.00%)      699.10 *   0.59%*      703.99 *  -0.10%*
> > BAmean-95 user-32    19701.79 (   0.00%)    18425.01 (   6.48%)    19704.78 (  -0.02%)
> > BAmean-95 syst-32     1159.43 (   0.00%)     2251.86 ( -94.22%)     1177.03 (  -1.52%)
> > BAmean-95 elsp-32      703.24 (   0.00%)      698.99 (   0.61%)      703.88 (  -0.09%)
> > BAmean-99 user-32    19701.79 (   0.00%)    18425.01 (   6.48%)    19704.78 (  -0.02%)
> > BAmean-99 syst-32     1159.43 (   0.00%)     2251.86 ( -94.22%)     1177.03 (  -1.52%)
> > BAmean-99 elsp-32      703.24 (   0.00%)      698.99 (   0.61%)      703.88 (  -0.09%)
> >
> > When cgroup memory.high=2G, high memory pressure, mthp_ext improved by 26%.
> >
> >                             always                 never               always+mthp_ext
> > Amean     user-32    20250.65 (   0.00%)    18368.91 *   9.29%*    18681.27 *   7.75%*
> > Amean     syst-32    12778.56 (   0.00%)     9636.99 *  24.58%*     9392.65 *  26.50%*
> > Amean     elsp-32     1377.55 (   0.00%)     1026.10 *  25.51%*     1019.40 *  26.00%*
> > BAmean-95 user-32    20233.75 (   0.00%)    18353.57 (   9.29%)    18678.01 (   7.69%)
> > BAmean-95 syst-32    12543.21 (   0.00%)     9612.28 (  23.37%)     9386.83 (  25.16%)
> > BAmean-95 elsp-32     1367.82 (   0.00%)     1023.75 (  25.15%)     1018.17 (  25.56%)
> > BAmean-99 user-32    20233.75 (   0.00%)    18353.57 (   9.29%)    18678.01 (   7.69%)
> > BAmean-99 syst-32    12543.21 (   0.00%)     9612.28 (  23.37%)     9386.83 (  25.16%)
> > BAmean-99 elsp-32     1367.82 (   0.00%)     1023.75 (  25.15%)     1018.17 (  25.56%)
> >
> > TODO
> > ====
> >
> > - mthp_ext handles different "enum tva_type" values. For example, for
> >   small-memory processes, only 4KB is used in TVA_PAGEFAULT, while
> >   TVA_KHUGEPAGED/TVA_FORCED_COLLAPSE continues to collapse all mthp
> >   size. Under high memory pressure, only 4KB is used for
> >   TVA_PAGEFAULT/TVA_KHUGEPAGED, while TVA_FORCED_COLLAPSE continues to
> >   collapse all mthp size.
> > - selftest
> >
> > If there are additional scenarios, please let me know as well, so I can
> > conduct further prototype verification tests to make mTHP more
> > transparent and further clear/stabilize the BPF-THP ABI.
>
> How is it more transparent if you're essentially adding mTHP
> micro-programmability from the user's side? This series makes it
> _less_ transparent.
>
> If you actually want to make it more transparent, then I would suggest
> improving the heuristics such that (m)THP doesn't churn through memory
> on high memory pressure. Or such that it doesn't feel extremely compelled
> to place the largest THP it can based on vibes.

I agree but I also don't really want to see anything like that until mTHP is
actually stabilised and the code base is less appalling :)

We've deferred paying down technical debt far too long.

>
> --
> Pedro

Thanks, Lorenzo
