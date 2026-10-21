Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792608762;
	b=c0cL3rHerZYfeP5lzdcCjOH0mQJDhX64y1NSgiIqpX+mcyHc/CowKCPVynBy/qcPAtYH
	 pIMrk9mCZ/77hPoeQ8yKu12BX+YKnStHaD4FWFyOosb/lK69ZJ5Z7eluAzvD4vveNgN1B
	 JmJpLzqwQ+sghye9YxoCpMm83pDl+Jw2XWqWwqjg4PJDSVn2/BrR5iz1o/Drlad2d+rlS
	 s2osqtQojljpni57lEWQxi7XN3SBd5P2vdezhqJCsvBVX3vlaZrbHjt8sae60oGZfTNOi
	 9ZuwP3lCz6ui5iAFfgzbOUTxiS7+AZOQZb5SXLyMNIqjAPXSBnqIPd4M7HbLJJvxZZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792608762;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=9XNWFo/CYTANDrafjipXREwd0B+NLKGQLy/y5ee2/mU=;
	b=IsZQdVTMkc6fHcu4G7Oar1NzU2IjloCvIoFtrlfCxvPyVPwUPyMF/YxBkvhRlzC2hRrz
	 WCU2iFHrI23kfwqFmC+7+JVEzfWlxvEB8r2h2tMiO0eNPdn7tvRu9NcN6q1XEJRJxAq+l
	 es8Cmlttx3PJP4qF1wHdr+NTzovkbRw8O+H8jxHDPU5WbtK+se/4e3Ih/s1IYYC3qfFpT
	 zBVL9xpEUp+SRK6sxC//rylFSsQojFUDxXuk8OuDayIdREHoonRu/fGgxSK5QabSsYHnW
	 ymorGiY7GtIXhjz1fgcpttTT4cLzMIffuzJQ4N+IMJP2V/Xst+fjvRdjzzkg7/p6/Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=XVmYSRoE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0318606A319;
	Wed, 21 Oct 2026 18:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=XVmYSRoE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D5C1F000C1;
	Wed, 21 Oct 2026 18:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1792608761;
	bh=9XNWFo/CYTANDrafjipXREwd0B+NLKGQLy/y5ee2/mU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XVmYSRoE6euKHfFwnaiDhnpBmWGbT907C2lFpgaBfbpl4U+4ISxr9AqyT6pARcZaX
	 wJeE56M0QsINp8WXWmFS8zXuVk/sMuPJxGXhNzXXM+zGK/e+2KGPy0jMuID4x8Ke3P
	 C6pCbQm3HD1d/C4kmi/btMdNA8+N/HVKL7FgMmeU=
Date: Wed, 21 Oct 2026 11:52:40 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Zhen Ni <zhen.ni@easystack.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, vbabka@kernel.org, surenb@google.com,
 mhocko@suse.com, brendan.jackman@linux.dev, hannes@cmpxchg.org,
 ziy@nvidia.com, shuah@kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Zhen Ni
 <zhen.ni@easystack.cn>
Subject: Re: [PATCH v3 0/7] mm/page_owner: add bpf_iter and kfuncs
Message-Id: <20261021115240.f195a2a55364fe300cbb6983@linux-foundation.org>
In-Reply-To: <20261021112437.1799213-1-zhen.ni@easystack.cn>
References: <20261021112437.1799213-1-zhen.ni@easystack.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Oct 2026 19:24:30 +0800 Zhen Ni <zhen.ni@easystack.cn> wrote:

> page_owner records who allocated every page and is a core memory-debug
> facility, but it currently reaches userspace as the debugfs flat dump:
> slicing allocations by pid, comm, NUMA node, cgroup or stack, etc.,
> means streaming and parsing the entire file in userspace, which is
> expensive on large hosts and hard to query live.

Confused.  Your series 8570b65220e8 ("mm/page_owner: add print_mode
filter") addressed this significantly?

