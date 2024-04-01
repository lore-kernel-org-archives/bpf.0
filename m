Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B2D47F6F;
	Mon,  1 Apr 2024 16:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711987624; cv=none; b=tlbB3qlEE5IRYXgbxOGcY/z8P7k7aw234OGyC17nc1WV+rmbouB4IGd4PxhNA49Af5FhgVa1icXl/zeytrLU+S1PuNv4h7OxMuFhc2IEVhgCbhaPUI7oveBKbixQgYPF2Xaz/k9MMt0OsRpyNIznKiKvFphKO38JC5HfY5yFbNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711987624; c=relaxed/simple;
	bh=Q1hwWXWXCgYXXh9MF+p0s/m1L07P8j/P4KskXlXKs9g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fFrGJP9YX+V7IIgIbr5FdAbcbw5vjU2HxrkiGowqhckobnSTskYrlMc9grd8SBpp6IeyU/ZNZlVJ2XNDlO2VQRQJXxjNrfKVLjf5kZSXYYujoYB7n7mLBcxFTs/Or1oxp96nwA6JsjRjbPgg7CzvEz3Xbxs5wLF27ofwPOmr6Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC6FC433F1;
	Mon,  1 Apr 2024 16:07:03 +0000 (UTC)
Date: Mon, 1 Apr 2024 12:09:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko
 <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, jolsa@kernel.org, "Paul E . McKenney"
 <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] ftrace: make extra rcu_is_watching() validation check
 optional
Message-ID: <20240401120918.67cc3191@gandalf.local.home>
In-Reply-To: <20240401202552.470d845bd79c841b9158fb56@kernel.org>
References: <20240322160323.2463329-1-andrii@kernel.org>
	<20240325113848.32a70948d1cdb0fa76225690@kernel.org>
	<20240325181338.39376089@gandalf.local.home>
	<CAEf4BzazyWqLRmruj6XPXMYSYrrFPRAJRizWGhKtTt9A8zWE3A@mail.gmail.com>
	<20240326150121.68e9db8a@gandalf.local.home>
	<20240401202552.470d845bd79c841b9158fb56@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Apr 2024 20:25:52 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > Masami,
> > 
> > Are you OK with just keeping it set to N.  
> 
> OK, if it is only for the debugging, I'm OK to set N this.
> 
> > 
> > We could have other options like PROVE_LOCKING enable it.  
> 
> Agreed (but it should say this is a debug option)

It does say "Validate" which to me is a debug option. What would you
suggest?

-- Steve
