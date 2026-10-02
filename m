Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5247F4F96CB;
	Fri,  2 Oct 2026 17:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790960445; cv=none; b=iwdfL9olgfegQZWUgR7CN9nJdA1LiFgQnAq+XoxF7+0ehQyqjJbvsZLRFyOlmj3a3jWwJoQSsht5GlLrMpfhVkad6gpgkH9TDo7XPBHNNkJQ1FtgTlY1KiXlwWItuG474N/8qTn82uK0isvRNjO8P/BVYB4ZcEiZ2QAmYTccDHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790960445; c=relaxed/simple;
	bh=3OFHnT4VR2dGcE4Zq0VCx6J2k8w3082nBkdzW5DNax4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuSA8Ly9VH4ksK/0iEBdSWmczXVVmdrvdzYHwdLnd3bhLxoZyO2g5GpbGfAAoD8Tq9C0XJXm3sKB0VhT09VIvDeGQsXl8qj05S/a/bDcrk2hXbBbNckobUwE+LmW/GKNjmSLuXyMukAVo/NTeOImErYHJWtKKXkGaULpsaZSJT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Bx7Jh2Ui; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bx7Jh2Ui"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yJy1Qq9QXYhDTSQZfMIIfxPYnTxZfhbwrd6oubBqbQU=; b=Bx7Jh2UiCpzk3D2s8Y1YbPxdAC
	hI+0WBUKGE8EicUVoB/3D9bvWBdvCAhv0mHdr7tp7bA4ujyiYrIDoFMogmv6caxWTWkJHHpKPFfU0
	K9bkZUNxSiJoWqH3aB1T0+HtVzUM5cMlBIezJ1q66RGDmEt7JEaO3tcayp02sK1pUlrYV4vinOmq4
	m2iraajzLsueZXXYXZxY0WW3aGNW2hewOvoKmyneAbDorOQuI66/ojtgqUUaSZVOv2mXpTJxEWL+Y
	dpvqosIMP+PWigL80lN9ZsT5BQxQR2j8TEvOMESVtOsTtGCQStLHBEiSHMVq+XO1rjEbPpiYzZC5O
	IQPjpUlQ==;
Received: from [38.23.173.23] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCgcT-0000000C6BW-0a6i;
	Fri, 02 Oct 2026 17:00:25 +0000
Date: Fri, 2 Oct 2026 13:00:19 -0400
From: "Liam R. Howlett" <liam@infradead.org>
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: ljs@kernel.org, akpm@linux-foundation.org, axelrasmussen@google.com, 
	baohua@kernel.org, baolin.wang@linux.alibaba.com, baoquan.he@linux.dev, 
	brendan.jackman@linux.dev, david@kernel.org, hannes@cmpxchg.org, kasong@tencent.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, mhocko@suse.com, qi.zheng@linux.dev, 
	rostedt@goodmis.org, rppt@kernel.org, shakeel.butt@linux.dev, surenb@google.com, 
	vbabka@kernel.org, weixugc@google.com, yuanchu@google.com, ziy@nvidia.com, 
	bpf@vger.kernel.org
Subject: Re: [PATCH 0/2] mm/compaction: stop repeating failed async
 compaction on every THP fault
Message-ID: <n7lq44yl6imw454jrwcz52se7dt3qesdcnpzzlb3wf36ixa7js@oatar73m4g2s>
References: <ar-8Vkchzn4QobA6@gremlin>
 <20261002161744.859093-1-odys.yuan@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002161744.859093-1-odys.yuan@gmail.com>

On 26/10/03 12:17AM, Qiliang Yuan wrote:
> Hi Lorenzo,
> 
> Thanks for your review. I would like to respond to your points,
> quoting your mail below.
> 
> > NAK.
> 
> I understand your right to NAK as a maintainer. I am not asking
> you to withdraw it automatically. I am clarifying the facts.
> 

Nak
