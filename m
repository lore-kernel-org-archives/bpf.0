Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1F34E9C20;
	Tue, 13 Oct 2026 23:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791935155; cv=none; b=JF/IyrvmwgyAf5vP7nSv8wQ30aj9TyoZv7ihiYhc7BCFzwVQ/E7Q0qm04yCBfOu4cTT/6yC7PoRx9Vz/Ic7GZkYJyJiKmLRNWUphsOgk+cVlHgsi6LD/mxSDof439FfJoDHZ3yWeNSoJiM7094UGqJo+g+Qq27VZIG8YERo97oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791935155; c=relaxed/simple;
	bh=rAfCW47pfRLJ9FoVEdHAC1LOYNyZQKKqvkkxd+o83j4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=laZDgGWwC6Q/zCSj43jTLGYGJocvOGO2M/Cmr12ux5TgPxuWYT0AuFZiQs4QAJqzpyLvBOIdzZuEvsfuAs5CDMKAiKw8HOmewjwaUzef5REHIlgx/RCm6RMlJSo22419UWgQ/8EfT6VX5+MdWDHgSizl9IjKRKWrglYi93P7NWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=W55OzyOF; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="W55OzyOF"
Received: from omf16.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 6AB6F1201DD;
	Tue, 13 Oct 2026 23:45:46 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 748A02000E;
	Tue, 13 Oct 2026 23:45:44 +0000 (UTC)
Date: Tue, 13 Oct 2026 19:45:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, sashiko-bot@kernel.org, "Vineet Gupta"
 <vineet.gupta@linux.dev>, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH v3 1/1] tracing: fgraph: allocate shadow stacks inline
 with GFP_NOWAIT
Message-ID: <20261013194542.7e036b03@226.227.38.69.naturalwireless.com>
In-Reply-To: <20261001203145.abaab4f85291cdec5e423184@kernel.org>
References: <20261001102909.1152572-1-vineet.gupta@linux.dev>
	<20261001102909.1152572-2-vineet.gupta@linux.dev>
	<20261001103752.653961F000FF@smtp.kernel.org>
	<20261001203145.abaab4f85291cdec5e423184@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Stat-Signature: 68qeuiecqng5119awtkpqey4dx6gf466
X-Rspamd-Queue-Id: 748A02000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1890ClREjmUcD88SPjl8Xj4QHVZp8+XqKc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=Jsa6IXuHcx3iN4ax3YwraOZR+Z1q1uImgnBPR9hpoxI=; b=W55OzyOFLiYC4jrQpdNVvXcbRbUET74J0tUyUu3DzwhEgohBAKWwj2h5M7hBW8Yvxo+RlKJX+KyEM46jbjwsvjpuBwThF76Gq4qJTfpS2xJv6aM7LeQWemTza94nJDMKXdI2/UDC0sd9AsWbJElWlPjWBQoa6Dj9zYl2SHg7MjI=
X-HE-Tag: 1791935144-558392
X-HE-Meta: U2FsdGVkX1+XC+jv00YjW02ZJ6ofmTqQ9/ocShgvC2K3u+wWvWYtXyHRTxOhvBvj3SB9m+rMS57+7BvqSRUT6S5uaqIKJPttn7gTwyU33abScF/zbd9/4Ws6WEzsEdculSSf2uEGM7MOVJDM1HBbzwJkQ6qXZdtmpbZhOC+OFQmSc/ez3myTOlUzGqtHUEgI8xsk2CCBSi1A/STQoGpPKSuHG4mPwC/sdmiNptDk0NVAFZ/6jjY6WxKighq+A02SzQMJ3V+RBw/YUsBG8bboxis4XUESHk/RzWWl9E95f49HbCSxnEusX+ijqALG25unOZrtnB7ZhG1B0ov+QKpi9oP9jhi/26Ok

On Thu, 1 Oct 2026 20:31:45 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > [Severity: Low]
> > Does this code mix goto-based error handling and scope-based cleanup in the
> > same function?
> > 
> > The alloc_retstack_tasklist() function still contains a goto free error
> > handling path earlier in its body, and a free: cleanup label at the end.
> > Adding scoped_guard() here violates the kernel cleanup subsystem guidelines,
> > which state that for a given routine, usage of goto and cleanup helpers
> > should never be mixed.
> > 
> > Since returning directly from within the scoped_guard() skips the free: loop
> > at the end of the function, it forces manual reasoning about whether that is
> > safe. This is noted in the new comment about keeping the start == end check
> > in step with the exhaustion logic.
> > 
> > Is it possible to convert the initial return stack array allocation to use
> > scope-based cleanup as well, or revert to open-coded RCU read locks, to
> > avoid mixing the two patterns?  
> 
> If this sends to stable kernel, I think it is better to keep using
> goto in this patch, and send another cleanup later. It is allow us
> to backport the patch easier.

Agreed. Care to send a v4?

-- Steve
