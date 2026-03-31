Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7585A30E0DC
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 16:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974396; cv=none; b=pLbavUiEdZsK/JdxmjSS1M/st3I+VaY7k+f6mVS6RsPdCjTR2DjOL7/yFw0yGAXT/kJCzfI2lOauuMbzwL44SuWV314Q8UJukNCiJt6t4NXJrMseDAFiQawb9Yguatoabolcmf88AFNaRSZiBPkMcOkHplj7fZVwmCgfuQfNObI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974396; c=relaxed/simple;
	bh=5rpKWBOoMW3biKy1NHAgBZkXBuuG9AwPsKfmKK7Mp9w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YOT2wOmotsg6F22msLR8RX+LdiRlx+O/+0zvt2w9JlbuIyGoVS/n0VvLKsjimEKD+RANNOrHBuawybSiBDX/Rgk6NaiTnKQTdJxlEQrXRPHiF3QsKAd/HXYfA8grlGdlHrIyuzF3c/tIIg35RT5VtHWO/fiTF6WgIC5BOxep0+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 41E371B6E42;
	Tue, 31 Mar 2026 16:26:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id BBB162000D;
	Tue, 31 Mar 2026 16:26:29 +0000 (UTC)
Date: Tue, 31 Mar 2026 12:27:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 kkd@meta.com, Kernel Team <kernel-team@meta.com>
Subject: Re: [PATCH bpf v3 1/1] bpf: Fix grace period wait for tracepoint
 bpf_link
Message-ID: <20260331122727.7283e589@gandalf.local.home>
In-Reply-To: <CAADnVQLjsJCyPBXdEy5A0r_es8wyDJVFXJh+PNU2dMVUMD0DJA@mail.gmail.com>
References: <20260331005215.2813492-1-memxor@gmail.com>
	<20260331005215.2813492-2-memxor@gmail.com>
	<CAADnVQKP3bmuDP2NzKYhU776RFVuN4fOs3y-kyQ8AFzsoK3_2A@mail.gmail.com>
	<20260331120329.7126fe6a@gandalf.local.home>
	<CAADnVQLjsJCyPBXdEy5A0r_es8wyDJVFXJh+PNU2dMVUMD0DJA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: izesytqoc6btyjyabftxb69oy8nawgka
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: BBB162000D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/DfS3LuJiNGe/Wjhf+sN6AmNnPWHu6Vyc=
X-HE-Tag: 1774974389-417324
X-HE-Meta: U2FsdGVkX19e32LPEcpgMVqpKv++mMlKgMPl7rlfLGw5v7EH3myLDoN1lk51E5sfDGvTMQoHPrA41JK4uhTxkyEPErOqlkk3LHpv3sAU2OmFqvEfltIECii7E9fOgWsCaPhpIfdfsBWQOdanx76MyK0M8NP1JjNEXm7pSqZQs5SrAWssYaboclbX5zO9MFSOTNzkzE43Rapp+qsZQ/Ty/TUedomuUDMQ6vYZsHm25ttTCG6clVH1AdCQhOApECxLAZKYOi+FVJq68DdQDYbiJbWPfihIg2twTVF4DT0Utv9vcY7lONGvnrjZcsBlo4KlVWQnIwEMn56ppJ/dSnvivp2YwLlTc/77

On Tue, 31 Mar 2026 09:04:33 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> > I don't want "srcu" involved in the API. That's the internal workings and
> > who knows, it may change in the future (like it did going from RCU to SRCU).  
> 
> so? When it changes we can rename it to.
> I don't think "srcu" part of the name leaking anything.

I prefer to have a API describe what it's doing and not "how" it's doing it.

We can have:

  call_tracepoint_unregister_atomic(...)

and

  call_tracepoint_unregister_syscall()

The "atomic" describes tracepoints that can be used in atomic sections,
where as "syscall" means the tracepoint are safer for syscall context only
(faulting, etc).

Yes, it's still long, but I like descriptive names.

-- Steve
