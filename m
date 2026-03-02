Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA373319859;
	Mon,  2 Mar 2026 17:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772473646; cv=none; b=dASVomjtW9cTJSABz5daN2aw+WZCFhjpwFoCEPfwGKZ+hM7UJQtGqZOL7prjIxAxOQUN4gFsi8/GU4ZNDgH5aAhBaqqhCcwzr4zEGtOUycl2aEJs4LiPniu3rr4G2ac+TK/XUsPMqfYxMZxmusJpHLeRJAolr4l/7t/E/Lpbr3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772473646; c=relaxed/simple;
	bh=gftfk5cC+2sQAr2KvI2yGpQcdXHc8k9Rcab7MrLDm1A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VHa9OUAg8FjnlhWURwfKSSmvMBPM3ADWWFsIJWncGG97RxBJVnpaQOAtRK59j+ohk7Op5J0Bg7Oslo0w3CN5vl6zAVSc8pn50LgWapbZNaYE9RtQ6Pst2UWLWxF/40c/6kOwo3YS6T2aAZjzNIAX62wXOdaOscM3ZQ4tw09CxwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GtxkrlNT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GtxkrlNT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 143C4C19423;
	Mon,  2 Mar 2026 17:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772473645;
	bh=gftfk5cC+2sQAr2KvI2yGpQcdXHc8k9Rcab7MrLDm1A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GtxkrlNTLludhtqKhzafGALsgNKsmBnyNjKUZWdzbi8RXKjABVIDtLbhsA5+/2JuM
	 lPTmRkmQO0/27D9ycnr/8Df+OwHWFoq9YykKY+ui5NXNp1IOktV044Oa0DtCQRSKZk
	 mKQj6hBM2IXO18NRy07VqQ/xMw8bOuzWHfmMCGwv/ADcyUqYpd9+w4PT9yNYtsLywH
	 F5Fpt5kyduI79Fh5ruTL4eCnGkKDYNF6GpfHIe0exA3Bi0dzmo19drpHJPGyXUvVfC
	 nNwf1HMYXViRwaphPnbylMj/Bgp+ToA4iGw/l1yQtP3q2IfWJsBnPsTsIQ7X7JU8dl
	 DvtEsaxxrCoEw==
Date: Mon, 2 Mar 2026 12:47:55 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Ihor
 Solodrai <ihor.solodrai@linux.dev>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, linux-trace-kernel
 <linux-trace-kernel@vger.kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Menglong Dong
 <menglong8.dong@gmail.com>, Song Liu <song@kernel.org>
Subject: Re: [PATCH bpf] ftrace: Add missing ftrace_lock to
 update_ftrace_direct_add/del
Message-ID: <20260302124755.4ff16264@gandalf.local.home>
In-Reply-To: <CAADnVQKBx71HOwVcRFj7ja+y_NL83rpKQ0BRcismOwdCNx6pbA@mail.gmail.com>
References: <20260302081622.165713-1-jolsa@kernel.org>
	<CAADnVQKBx71HOwVcRFj7ja+y_NL83rpKQ0BRcismOwdCNx6pbA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Mar 2026 07:58:11 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> Steven,
> should it land through ftrace tree?

I added my review by tag. It's small enough that you can take it through
your tree.

Thanks,

-- Steve
