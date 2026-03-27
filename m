Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A24D38A73B;
	Fri, 27 Mar 2026 19:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774640571; cv=none; b=T4gr3qC0jR3s6mJlAJG7kCxnVESVih0JUe4aT9QCb/F2WxZTZyZzkhWn7e+HbloXaQQy8Ws5O6XLiNof+8gZvtQvOp5ijQMflwFw+4Ub4uzzExRPnBaw0dAULBkh6WYBdQVJmfTHwB6sk8WIbLB9DzGB1Q+z4otXMic8lXyLP3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774640571; c=relaxed/simple;
	bh=5Cf1j8Aqd21BWFIFt8KcYU6fNdKQMFl4Tg4msm+5b/Q=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gFvrK5agXq+lnkc9LEgwxYY6RlrgIntAPrRPXh/rQY2algcHKzxhwAX7SySlTb5zyGGkaHjBR/O+QrZHWs2OEz6ebx7QOkQMgSzhxQ7UZ8uf35qKPVXSeVidZuQRI0YLSsg/nEbVFMgSr6Eo0sgcA2KfG/UDPXerv0KZsGVsBUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PkOvVF7w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PkOvVF7w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46674C19423;
	Fri, 27 Mar 2026 19:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774640570;
	bh=5Cf1j8Aqd21BWFIFt8KcYU6fNdKQMFl4Tg4msm+5b/Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PkOvVF7wyyUsOQ5zORNmVnU1qLxV5bvgMiidF4v6v0Wan5C7/xVcA2MjFxe3NJwjv
	 +PDurgOV0/+KiA9o74QEjfFlO9+AHvlRGp4N0f3CWFkJ+uqBPS9TdfSSXs+zbVzvXz
	 QKsjEGu30vz1DQHRt9ciUC9Yoq7VYSRIfNbBCkJ8=
Date: Fri, 27 Mar 2026 12:42:49 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Muhammad Usama Anjum <usama.anjum@arm.com>
Cc: David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Brendan Jackman
 <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan
 <ziy@nvidia.com>, Uladzislau Rezki <urezki@gmail.com>, Nick Terrell
 <terrelln@fb.com>, David Sterba <dsterba@suse.com>, Vishal Moola
 <vishal.moola@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Ryan.Roberts@arm.com, david.hildenbrand@arm.com
Subject: Re: [PATCH v4 0/3] mm: Free contiguous order-0 pages efficiently
Message-Id: <20260327124249.a8de2259cf3438c5f4216894@linux-foundation.org>
In-Reply-To: <20260327125720.2270651-1-usama.anjum@arm.com>
References: <20260327125720.2270651-1-usama.anjum@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Mar 2026 12:57:12 +0000 Muhammad Usama Anjum <usama.anjum@arm.com> wrote:

> A recent change to vmalloc caused some performance benchmark regressions (see
> [1]). I'm attempting to fix that (and at the same time significantly improve
> beyond the baseline) by freeing a contiguous set of order-0 pages as a batch.
> 
> At the same time I observed that free_contig_range() was essentially doing the
> same thing as vfree() so I've fixed it there too. While at it, optimize the
> __free_contig_frozen_range() as well.
> 
> Check that the contiguous range falls in the same section. If they aren't enabled,
> the if conditions get optimized out by the compiler as memdesc_section() returns 0.
> See num_pages_contiguous() for more details about it.

Thanks.  I'm seeing impressive speedups for microbenchmarks.  The
speedup in [3/3] may be a bit more real-worldy.

Do you have a feeling for how much difference these changes will make
for any real-world workload?

Also, AI review said things:
	https://sashiko.dev/#/patchset/20260327125720.2270651-1-usama.anjum@arm.com

The can_free one (at least) seems legit.  I suggest that can_free be
made local to that for() loop - this would clear things up a bit.
