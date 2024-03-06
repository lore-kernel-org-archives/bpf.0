Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EC912FB31
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 14:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709734768; cv=none; b=GcCnIEfSOg5Ln9rkoiMEMTQmyyR54Z8gcmLnLdyWcjYP4RG9Kxnh+pqvmADUV91SD8pBpL0AJiSoSUiWf2I1UNxEVxj6DF0QWHnKu9yGokdxiuyPRIkbOmGJjBH+XPjLhVj85M4ZgQCWGFKh/JAZ5mrfWt2IbaTd+Br7LSCN6dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709734768; c=relaxed/simple;
	bh=73xuAghPC4Z/eUTJDoMRemAMxFESv8bJnB9ykB4M4q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0W1+iLw9ayo1UFiqJ9C7tFOU3nlFURS2P7ZwPdrp+bL9nQ3M1/3jD+JZi3MLloiOFrK7A3KGr9c1ZbaZAlzdkUOFJyk3+LBWjtg9LthHFQM30+Tq5eyuKb+eSGbSjDty3Xb9vQUeXMMPVDBBzcYBmu3ex+A0ozfVrcXwWmfxXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=adopzwfB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="adopzwfB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=73xuAghPC4Z/eUTJDoMRemAMxFESv8bJnB9ykB4M4q8=; b=adopzwfBlGv617jauRQSoInnIu
	77opbIWOak6y+04Xy2Y+F3QGbNIIWgltPv1B3jfbmx0HGPNz1pPSQdk34qAEikc9ZvCJvZjJoAI5B
	J4B9N0OiI1gO/gZkRS8eqoTXwkvK5flEYDWKMk8iOeR4ragVa+2o09nY0Fql5EcW8hJ9kKVa8Gpmz
	QP2y2KXeWWFZWt4gymcCvxvWLgBqb2YC3ayBuRfUiR3TZl9RojL1a66pRokOSd6hA3YJwNirtwtxh
	3h/D2g5+Bf0LqD+oCBVJ7oBzR43QY2QZvd61YK611orrUfX1y5/GWIe5czjMd83jpt2hhCVgnjz5K
	kRK3aR8g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhs7B-00000000Xnv-0zmt;
	Wed, 06 Mar 2024 14:19:25 +0000
Date: Wed, 6 Mar 2024 06:19:25 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	torvalds@linux-foundation.org, brho@google.com, hannes@cmpxchg.org,
	lstoakes@gmail.com, akpm@linux-foundation.org, urezki@gmail.com,
	hch@infradead.org, rppt@kernel.org, boris.ostrovsky@oracle.com,
	sstabellini@kernel.org, jgross@suse.com, linux-mm@kvack.org,
	xen-devel@lists.xenproject.org, kernel-team@fb.com
Subject: Re: [PATCH v4 bpf-next 2/2] mm: Introduce VM_SPARSE kind and
 vm_area_[un]map_pages().
Message-ID: <Zeh7bTYotfaKoCVD@infradead.org>
References: <20240305030516.41519-1-alexei.starovoitov@gmail.com>
 <20240305030516.41519-3-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305030516.41519-3-alexei.starovoitov@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

I'd still prefer to hide the vm_area, but for now:

Reviewed-by: Christoph Hellwig <hch@lst.de>
