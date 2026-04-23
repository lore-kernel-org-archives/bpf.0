Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC1B3101A2
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 14:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776953104; cv=none; b=LHQ2183vaTbU5UBCpn4DAMnvclCbxhmgPmBFIUZRF769yTdXqYRTBt51U6+cX265TqmYQDgNoPEPvlQCS/90jP6CvNndLkcDHGbjU7bvxCpxnfEzA9JEhw380H0YxXhoCmqwzNjrOhn2tJcnCzJMn3V0XjPdi2m2IYO8g1aEMow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776953104; c=relaxed/simple;
	bh=CwwcqDcf+8H4dQCGLI+kTp0j8hz2Qcpfx2g5xr0k2Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ENE0HpLWc64YkIw3umQlJ+NcIb9vLFrG6vCud3pY3kA6nFawF4p03h0bFlsrOLMpQkB0if1mc9OtXGLb6qCuGRdQxw0P98vgiFJg0Q9fh6V1rcFO+zpT19TF1MLPV4/JoBuoK1Qs3rzI7aJmFBRRhgGVdCoVKyz0XugAXZJ2fzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (lb01b-stub [10.200.18.250])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id ECA2D86E54;
	Thu, 23 Apr 2026 14:04:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 45EB220013;
	Thu, 23 Apr 2026 14:04:49 +0000 (UTC)
Date: Thu, 23 Apr 2026 10:04:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com, memxor@gmail.com, Mykyta Yatsenko
 <yatsenko@meta.com>
Subject: Re: [PATCH bpf-next v11 1/6] bpf: Add sleepable support for raw
 tracepoint programs
Message-ID: <20260423100452.25275b6c@gandalf.local.home>
In-Reply-To: <b06ad9d8-681e-41a4-bfd4-fc86f021add9@gmail.com>
References: <20260421-sleepable_tracepoints-v11-0-d8ff138d6f05@meta.com>
	<20260421-sleepable_tracepoints-v11-1-d8ff138d6f05@meta.com>
	<20260423095650.GA3126523@noisy.programming.kicks-ass.net>
	<b06ad9d8-681e-41a4-bfd4-fc86f021add9@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 45EB220013
X-Rspamd-Server: rspamout06
X-Stat-Signature: if9agz1uxn8oenncf4fi9dj1y6jt8t3h
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/c0ptWwkCMBFmZreMD4WOGn/vb2GY+MLw=
X-HE-Tag: 1776953089-381682
X-HE-Meta: U2FsdGVkX1+SDp7HoLYMe5xnXVbb4UBPUcsa/R3GABUgdi6Dve/9PAJSGYZg1ZwMYPcncmDdD8dftfM4pIC+X46x9qkyH2HlGQDMOojrhPaxgWZk0P7yhXDt4Lfnjp4uOk4XVu4WxzhfgRFnXoq7gFMKl/RujlRhzB7+i1vPZMEBJmKJ/p6Q/r27hcvpQKuqcfkJmGEKzz/aSjP0ZFly0DErvM00oYXpPJDUWtfpb6rNqdMV13dkRtdxFknz5kmy23QhpMDeX2nmDTutxPLInlzz7xFMkGA8BbiPrZrn3kpKiMyCCSuv2hwUiuEYQ1HD95evh2QJ6kQoBmh+RqF4ai5SuNt7i/KMYvw5Lj98OTA7W1+o1il6SQ==

On Thu, 23 Apr 2026 13:39:24 +0100
Mykyta Yatsenko <mykyta.yatsenko5@gmail.com> wrote:

> > Since you have a clear distinction between __BPF_DECLARE_TRACE() and
> > __BPF_DELARE_TRACE_SYSCALL(), would it not make more sense to have
> > different versions of __bpf_trace_run() instead of having a runtime
> > condition on ->sleepable ?  
> 
> Syscall tracepoint can be sleepable or non-sleepable, so the runtime 

I'm not sure what you mean by a "syscall tracepoint can be sleepable or
non-sleepable"? All syscall tracepoints are now allowed to sleep. When is it
non-sleepable?

-- Steve

> dispatch on prog->sleepable is needed anyway. I'm not sure how to
> get access to bpf_prog in __BPF_DELARE_TRACE_SYSCALL(), that probably
> won't look very clean.
