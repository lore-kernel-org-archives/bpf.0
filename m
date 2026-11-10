Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794339480;
	b=LgVkRmawVOiaaaAbi0m4BMmP+87utQaZtSzsFJYmnuDzWIBvHo/Onm9a9PcElmIjO4BE
	 waBt52AQ/9+DNwbTyTpNHH+YnwyGeVmAiB2TQdDvAcuJ0SOsUKTaXLPcB86LTzD9kRdBy
	 01etiMcxZYz7y197JO7KPxl9dAWU+ON6teaNxIU6Xx3T9XxiCkMvfVbbiZyb5I/W9jLyx
	 EKfKnCo0XznhD3za7vA6HaMhexvBPJ3u9C3IvOHNJNyTd4G/F07L7JQd7UaDri+fa/UHC
	 kCvLvjmQZG+E1+iWx8u+nFghZ8Vbw47VCWNKgM7CGtmF4FlGSOKvWnrlklwp0CgYU0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794339480;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=g8oRdUIPNrM19I+aRr6Xrjnpls3CINQLfjEu+H+Ojoc=;
	b=KtjJf/tV/dFKoLR1A0/HbYTm11dtLWzKH1pHfFZH7aYMEIiU+nfX2woia5ZJfkH9DiD9
	 /3aTt9pPgYpBYC6JPXaYAaA/lhlPHCGIMxUUs7nvSq0fDTDc3bBi5xKCsZqo4OlMnsJCp
	 aFMTlq0wLUu5+yFS8ctwHrCcOhZ9Pzp/2fKe9f3DhzPpVpqZILCpTjwLooHkG3hpwP2QS
	 V5VlNPeSn8dfFt5uhyO06nrwgXQ1RV975QEkPQLfP20j02dH89JUpLXmNQ/t1c0JzB5fS
	 kNGgD3w/lghNyawgAVeOx1NCqiXOhYnKEJdGUeNJRScctq0pc8gM1z11ywmWFoEfqPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d9RvgfLi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF615606A321;
	Tue, 10 Nov 2026 19:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d9RvgfLi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C131F0089F;
	Tue, 10 Nov 2026 19:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794339479;
	bh=g8oRdUIPNrM19I+aRr6Xrjnpls3CINQLfjEu+H+Ojoc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=d9RvgfLiwhMx2uoZTRk00iF9f2Tttz/2KNRZficsLgsK9BeK9joxkHvuIC08qPzh/
	 i1cbQyRUVoxJH9VVP800QJXCaeHfMzZdoIwIf/pcad2NsAAeRqyHqZg+q5JbDW9wE0
	 2pzP6p1fj0BYIkI0RmGsdjido0caXr7og3AyCZjfvomKN5obAxG7qeHss1H14Bi1gx
	 gvzzC17qzHxUeOLgzCIrOxqEvhrIUe3OjYTARttXVwgaP6dOLvwu3I4g2TdFLV/HgU
	 fJfWaixCRhxHMEW7BbMPu6rq0hF/NTPv48mYa1gq67KSZoSxpTMJ87XexFPY59l5lo
	 oJVPpU2OeFiBA==
Date: Tue, 10 Nov 2026 09:37:58 -1000
Message-ID: <9a45ee48b0984bd959becb01d1d11f1c@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Kang Chen <k.chen@smail.nju.edu.cn>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, sashiko-bot@kernel.org,
 sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH] sched_ext: make DSQ iterator stay drained after NULL
In-Reply-To: <20261110125113.2935742-1-k.chen@smail.nju.edu.cn>
References: <20261110125113.2935742-1-k.chen@smail.nju.edu.cn>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Applied to sched_ext/for-7.4-fixes.

Thanks.

--
tejun
