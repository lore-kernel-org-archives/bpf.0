Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7F53D1A97;
	Fri,  3 Jul 2026 12:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783082710; cv=none; b=gZGEqBC9MAD54nhdvuMoz62WsNg18Xap7i1twNy1YjyFfcAiVBOS15/8qGSs1lJg/gkEZSb0U5abQkwTqrMp8C/N8zMR/glqzW4t6SUp/CJpt1UpmljvHQ4IjFY82pIzqgRvCYvcFQ4wRBsygG8ybSg8u+UhW6HkFv/vC26MzCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783082710; c=relaxed/simple;
	bh=SwU4aFqG6SLwp3Rx7eIm5MyWOYcFI0GvCVSGHjrnTXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6uUEOJKcEajn5mIjjVJWvKZg4Twb1uClKpAM6b3dLzXeCG2iTTaa/9t5qOCbmABgOcd6el8c4cig0x0gZtvgWnJWaY2TsGvSjXnG+D3gohxmoy9tNXLhIqrYgrvtqdqdf4//qDG6MvIkfzhx1jFd8TuU/bBGQ5WbhEIvYnCJTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JkPS8diF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JkPS8diF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HA4YQ+OERYRDsxgWBX7o87h2z1rSrQXVR5NxmKLrZNI=; b=JkPS8diFHhiVc5FHItcbWPHQvJ
	wQt3AYqZUe0dwzen6jp+LxPON7pbTb3z3FVnAqhEfv9ZQ/Y/inz6L4Fu9mIBxMCS+XhPsUq79+Y5R
	44WKYPTQdtq3dHsU7LdZDa6caJxXQMJnbc7gGgZnqAvdd/EeA0QxIspWMO+Qq+wrf7/demciH+7S+
	k+PQfTDPKtDOsSYofRRlmuftteACsXXAqA8WijAi/r/SfJ4bRcj9CIs0DDCI4eOj6613qJ+oRDapr
	dGhTJPwTSvM7njOVf5esIexOPvwXhqRhZrHAw/i1F065uyOyp9htkL/VnzQ2WXB7kZhADBa8Gdnex
	iUnBmTyw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfdGS-0000000AJpK-3V3i;
	Fri, 03 Jul 2026 12:45:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D0B1B300220; Fri, 03 Jul 2026 14:45:03 +0200 (CEST)
Date: Fri, 3 Jul 2026 14:45:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv6 03/13] uprobes/x86: Do not leak trampoline vma mapping
 on optimization failure
Message-ID: <20260703124503.GP751831@noisy.programming.kicks-ass.net>
References: <20260703114917.238144-1-jolsa@kernel.org>
 <20260703114917.238144-4-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703114917.238144-4-jolsa@kernel.org>

On Fri, Jul 03, 2026 at 01:49:07PM +0200, Jiri Olsa wrote:
> In case the optimization fails, we leak new-ly created trampoline
> vma mapping (in case we just created it), let's unmap it.
> 
> Fixes: ba2bfc97b462 ("uprobes/x86: Add support to optimize uprobes")
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

What is the intention here? That is, Patch 1 has a Fixes and is already
in tip/perf/urgent (from v5), patch 2 does not have Fixes, this patch
(3) has Fixes and appears to rely on patch 2.

So should I stick both 2,3 into perf/urgent or what?
