Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B05B17B425
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 03:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770004267; cv=none; b=WRxEglkct56KUl4eRAw5fyEhqShSmRT+D3zIs2XHPSihLpu1vBwuWK9/kKmtr/3TJPHwKHC3gU0A5bVBPyfQ4IZ3mjaeEKouuVsDxAXZPK/Wvs/2OSx+a7A0sYTI89bf0rvirOn7ruTn0Pm/Z/0xCT2toBxok1g2mv4XSFqSr6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770004267; c=relaxed/simple;
	bh=aYOQL5EQk1yr6CoZLb6V+j5aA1IqP4Ikgyh0/V96IUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQIDo3X1DWNuQA+d+udoX0zbkATBRT0VlolGlb2ejr95ueONBh7zc+b7Aezr0pcLhw4BW0L9U+FIpvTYJTQz++vH1TNl4wAMtXJiaNR70yyucmZU9t/muTQrXeTELEK1yTeeZpWyEYI+t/jWXAKDDTx+T+BYdkKqp2JpJfuI3/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SQQRCSOn; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SQQRCSOn"
Date: Sun, 1 Feb 2026 19:50:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770004253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o/nclWki/7xNBiIlkN5lOVwIekiG827g6kvt71oYAjY=;
	b=SQQRCSOnhRwyBJOGTKoC6hpkHmmhG9xPQf/BGFGZU5QS93z7dnK2JuOTM4uh6b2K6vOsB2
	vKlJ7azzBawiw2ZNaSlUuW6LfkngfvK8vfVulMeJ+dad6OPIMrCb7EulMaQfMvkednXjqA
	LwC8zYdx1iieZpj4bLmKk2/eqwkIiEA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: bpf@vger.kernel.org, Michal Hocko <mhocko@suse.com>, 
	Alexei Starovoitov <ast@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	JP Kobryn <inwardvessel@gmail.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Suren Baghdasaryan <surenb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH bpf-next v3 06/17] mm: define mem_cgroup_get_from_ino()
 outside of CONFIG_SHRINKER_DEBUG
Message-ID: <aYAeex9xM89Bj0jd@linux.dev>
References: <20260127024421.494929-1-roman.gushchin@linux.dev>
 <20260127024421.494929-7-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127024421.494929-7-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Mon, Jan 26, 2026 at 06:44:09PM -0800, Roman Gushchin wrote:
> mem_cgroup_get_from_ino() can be reused by the BPF OOM implementation,
> but currently depends on CONFIG_SHRINKER_DEBUG. Remove this dependency.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Acked-by: Michal Hocko <mhocko@suse.com>

This code has been changed in the mm-tree and you can directly use
mem_cgroup_get_from_id() after changes in the mm-tree.
