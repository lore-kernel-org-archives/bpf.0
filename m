Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B113B33291B
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 21:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770759015; cv=none; b=as78OWXNc/5TxL+jYWpCAAry97uH2AcpB6r5jmAAPyze1sxC/Ze8RhGEd45uI7hBS0ZEWMLIms5LRQVJ+1GcLXNH1Ro8PTYQHQ7fbe/1EIjYMlThTuuSnErtdchKL2rBJE+go9JWMqhbpP8aQYHhveHyyapTMTaeFJmNy5wtkDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770759015; c=relaxed/simple;
	bh=XvNwR8+KR3aOQEZ0KrvuRPBpPFw7c0VadR1UCM335Is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amDet76v9pJF0hJWuJyDsFOrbdzmpb75zgdqd0cMR3r4hkzUi195jdT9tZ2SEm7dOUBz8LSZdaX2VqAodWuJ1fh6kvvgtAvqTiGMjvVwEgjHpfD6u5eBZ1Amn8lXbz9rBOFZ6nlRL5gDhEdwkCRFQ9cP2LL+k/8+tny4mT9QxNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BV/YMBJ8; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BV/YMBJ8"
Date: Tue, 10 Feb 2026 13:30:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770759009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CK8De2d/erFzHUPFoy/Rd9TefUOCN8ZZOFUkQMvFVF8=;
	b=BV/YMBJ8tbHLUhRmxOpeod2al3Nw3/i2930wbCeo3QhGqxsnaAq/aehMHreve5V9/y6SKv
	Uvdqlflz6eST4UOFMxPAK4JJp7hginhzTbgCbyd0J8jcJFEgJuJkMRB5RWlvzR+vaiHUv5
	4yCY8TKhivkjvGVbGGZsSSx+iY6C9Zw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, surenb@google.com, 
	Ruikai Peng <ruikai@pwno.io>, Thomas Gleixner <tglx@kernel.org>, 
	syzbot+237b5b985b78c1da9600@syzkaller.appspotmail.com
Subject: Re: [PATCH mm-hotfixes-stable] procfs: fix possible double mmput()
 in do_procmap_query()
Message-ID: <aYui6BgekgRplVka@linux.dev>
References: <20260210192738.3041609-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210192738.3041609-1-andrii@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 10, 2026 at 11:27:38AM -0800, Andrii Nakryiko wrote:
> When user provides incorrectly sized buffer for build ID for PROCMAP_QUERY we
> return with -ENAMETOOLONG error. After recent changes this condition happens
> later, after we unlocked mmap_lock/per-VMA lock and did mmput(), so original
> goto out is now wrong and will double-mmput() mm_struct. Fix by jumping
> further to clean up only vm_file and name_buf.
> 
> Fixes: b5cbacd7f86f ("procfs: avoid fetching build ID while holding VMA lock")

Why didn't the BPF AI review bot didn't trigger for b5cbacd7f86f?

> Reported-by: Ruikai Peng <ruikai@pwno.io>
> Reported-by: Thomas Gleixner <tglx@kernel.org>
> Reported-by: syzbot+237b5b985b78c1da9600@syzkaller.appspotmail.com
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
