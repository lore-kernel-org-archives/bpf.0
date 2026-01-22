Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C75717C69
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 05:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769059058; cv=none; b=EV6lVX0IOnWkTp/UMSD8uwqx/SAvpVdBka61r6t3tV9fy0ZbLx+RX3KbYLKDMTpg9LIscpkEiwzEjlsi5PlNe2y77otF5r7+CSqNmJsp2OA4auN6JR59O2GoSaEd+timAfkp99V3TZRYc0PpTjwh01FHNaYtZNPaVJOjXnIFzgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769059058; c=relaxed/simple;
	bh=BhB4nAFOOoWNWssfwaugQp4JcswXEqLGVnrYwczmRAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmoK/myU24x/ukvxYvRuh4WBzu+puV8Px1+ubVnvDwpUsETvwab5CF/t3Il0r9wFsN6qTil0ZLhdo3l2K83wOarhE10ndqILzlCCvLDawPH3J7IZSnDl9h//UnR7ZBgve+01if5yOQhDH+Tbno7wWM3rlwGRLckNydQjnKh7mu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uG2sPJdy; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uG2sPJdy"
Date: Thu, 22 Jan 2026 13:17:17 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769059051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FvXyJ4IjTH3psLgpa4Edg9bKy8go2O2C/kV6B2QSdmE=;
	b=uG2sPJdylL6tZnxLGvfyIAOf8RviT0HGsSIOb9JNKrQQFbzgVPw9qcoy+XCgkfEzMtfk4O
	4IB5NGfZtMn421udxUEyrceLzNPQkm4GHJGjRR2TlQimSabJbNyrAxTyQujDwPGE/ApLTK
	ChMn55qEW50lY6+mMjEAErQ3fJUNIk4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v3 20/21] mm/slub: remove DEACTIVATE_TO_* stat items
Message-ID: <onpv3vtvqrybt2ceuyyzv5dm7a3lt53vyr3cc5mlfirf2y3pti@vkpypvv62ijv>
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-20-5595cb000772@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116-sheaves-for-all-v3-20-5595cb000772@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Fri, Jan 16, 2026 at 03:40:40PM +0100, Vlastimil Babka wrote:
> The cpu slabs and their deactivations were removed, so remove the unused
> stat items. Weirdly enough the values were also used to control
> __add_partial() adding to head or tail of the list, so replace that with
> a new enum add_mode, which is cleaner.
> 
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
> 

Looks good to me.
Reviewed-by: Hao Li <hao.li@linux.dev>

-- 
Thanks,
Hao
