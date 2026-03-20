Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295F42DC791;
	Fri, 20 Mar 2026 14:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774016298; cv=none; b=cWmgFumEPYQxsSv3HQLgu9PQbkPdVeLyg6hcD4PIvf42L9zr74NXqYqEXnZtBJMAzG3wPF/YLpB4WyMElv6xZOQ47HGzZsIzOo+NwAbIwx3eHz+a/dnNHOozZEhggiCgHXq2q/TXGwzCyCJilDEhDs03tbZpDS1CxTY+ue6MuCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774016298; c=relaxed/simple;
	bh=BR55ZlK4CO/9cMmS2/cb6m9UmoHQy6C3fA4PTLZWYZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJLUkZ3e0PgYsa9Zo+aVjYRq1ReqNCxFTy4N5Y5Ie4elRjZ63737vk4yT4r89kgy748G8vZI9JjpExVNuiwCqs718i+JhnrLxmQoMNFij/wQJvLSXP9dyPeCyI8LCN9TtS9JlMZ+fofqbQemD/A4XrDdLr/j0G9+Txz3euFEVwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=sP75c17Z; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="sP75c17Z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BR55ZlK4CO/9cMmS2/cb6m9UmoHQy6C3fA4PTLZWYZg=; b=sP75c17ZdlbbpiY21pJ7HGz9Q2
	sWF878w3fToPNoHUmOHcZetoOA89Ka3fOuBcC0tYUThWpQhLDh3FA0QJ4OQkuULUycEahsIcgeeI1
	TK4qddVjP2k5pIM61L8pWUQgQRL/Z5hZBaN9sVMzgJ+r0yeORNYinETtx68CRfFoB4+xq8m/U2MBs
	YykXBpxQBHpnP2hwnc07jUDknj6NBBbwKOjTs1DHytef89FhJ7ll9d2sHtSbvihz0sAIWKzyYXYZO
	XPEA0zb307XzSjfz7KLtgkM97uV4C1V/n3lSVYulqF+oj5aai4HX9h/P2bWGZc4a59y6A3QuYm69p
	G3EWULPg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1w3afu-005GQQ-Qy; Fri, 20 Mar 2026 14:18:05 +0000
Date: Fri, 20 Mar 2026 07:18:00 -0700
From: Breno Leitao <leitao@debian.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com, 
	Andrii Nakryiko <andrii@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] coredump: add tracepoint for coredump events
Message-ID: <ab1Pd31OoCdglbwF@gmail.com>
References: <20260320-coredump_tracepoint-v1-1-34864746cbb3@debian.org>
 <20260320-habilitation-umworben-edeb157af1a3@brauner>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320-habilitation-umworben-edeb157af1a3@brauner>
X-Debian-User: leitao

On Fri, Mar 20, 2026 at 02:21:48PM +0100, Christian Brauner wrote:
> On Fri, 20 Mar 2026 05:33:34 -0700, Breno Leitao wrote:
> > Coredump is a generally useful and interesting event in the lifetime
> > of a process. Add a tracepoint so it can be monitored through the
> > standard kernel tracing infrastructure.
> >
> > BPF-based crash monitoring is an advanced approach that
> > allows real-time crash interception: by attaching a BPF program at
> > this point, tools can use bpf_get_stack() with BPF_F_USER_STACK to
> > capture the user-space stack trace at the exact moment of the crash,
> > before the process is fully terminated, without waiting for a
> > coredump file to be written and parsed.
> >
> > [...]
>
> "stable" with a grain of salt. We make no such guarantees that it won't be
> moved around if needed.

Ack. At least tracepoints offer more stability compared to
fentry/function-based approaches which can be inlined, renamed, or
otherwise modified.

Thanks for reviewing this.
--breno
