Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7584A2D038
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 18:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HX27OZrQ"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [IPv6:2001:41d0:203:375::ae])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EE1A2
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 10:35:50 -0800 (PST)
Message-ID: <0b1fe7ca-158a-4ec8-976e-aae090f3ad57@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699295748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zMzjJ4qx/y78ZAEeeGElDIqeo3WUOYbWIB4LzzBV//U=;
	b=HX27OZrQDr2eXLnU7DnvMbGepSP7oB5+j4+h94ke2BNnWkCsWxnmu5D8CePoqyPeDVV846
	l4cQ/wRaYL1VZuJt0uuJnkdz4LyLYflF8I9gJbnyPTLcDsR9uulfoPZARznJi4euodmMzF
	b/dI2Xd0K+y03XOYKsatbaHIq80oEiE=
Date: Mon, 6 Nov 2023 10:35:41 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 2/2] selftests/bpf: get trusted cgrp from
 bpf_iter__cgroup directly
Content-Language: en-GB
To: Chuyi Zhou <zhouchuyi@bytedance.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org
References: <20231105133458.1315620-1-zhouchuyi@bytedance.com>
 <20231105133458.1315620-3-zhouchuyi@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231105133458.1315620-3-zhouchuyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 11/5/23 5:34 AM, Chuyi Zhou wrote:
> Commit f49843afde (selftests/bpf: Add tests for css_task iter combining
> with cgroup iter) added a test which demonstrates how css_task iter can be
> combined with cgroup iter. That test used bpf_cgroup_from_id() to convert
> bpf_iter__cgroup->cgroup to a trusted ptr which is pointless now, since
> with the previous fix, we can get a trusted cgroup directly from
> bpf_iter__cgroup.
>
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
