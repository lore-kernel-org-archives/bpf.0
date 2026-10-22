Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=154.81.10.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792669253;
	b=y/TVrOCuZnp5EFWuOK4ucg9f83JAsvEcGTUttJ6tUseb+J/KvNNuX4NmMOD3+y+v/sTQ
	 OJKWC54ZBd4dMX8PZXiqQt3+YmpGblKwFeqNBvYCAmSLpUVB25cF35v5qxBkF+x/+j9tm
	 bctEJdQkJRrIjYKuZvhSntImlLx/xLYyUGblLFC5ionsuVUuH9WR1Zcaxx7rYvGj/mBf2
	 55EoX+CKE7xogk1Udy7H3E8W3Ya8+bTiwFAJHccPVn3STzKrKSfKcv8SvaZ7XUjX8bJuV
	 8KIMbbjXs+rHobfthyg/2KEYrFmwciWsrunh73E7cExan99dVLrZMW+oCRlrfGRZ0eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792669253;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status;
	bh=U0Xvu1qIA/L+bG5Y4RTEQS4ShKfxcS6BTZgoVihscQU=;
	b=Umcu5pYYtVAN/QN46x9yVPtw/6jJ7kE+/F9VjplRlvNEuxCCbEzgiayEHc4PWXKpNVHL
	 yU8+sE++1wKClBS/nB+fU7MWMiD3G2puBDkt2uVb7naGIiIKnFRT5BWbn1ijkb2SfoBnf
	 39UmezHlhQgheQF98VulLFRENs1cEHSwSWfqKXirLxFvoSAsduc8nvraZiE3QQ1bEI2uO
	 oazIFvmiFWGYvzlFmKmVNTNKaurg85DAfpdBtlcGbSxTbpWK58K3ekV6uA90OkAak1W9L
	 SpTcDTMxj040mmvqjzpT0kfflRglHjkxfW/p0M6HpyI80FCrpEUxFOJ35IYqc4kMw8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=easystack.cn;
	spf=pass smtp.mailfrom=easystack.cn;
	arc=none smtp.remote-ip=154.81.10.170
Received: from mail-m10170.netease.com (mail-m10170.netease.com [154.81.10.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E317606A319;
	Thu, 22 Oct 2026 11:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E317606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from [192.168.0.59] (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 205a7933a;
	Thu, 22 Oct 2026 19:40:40 +0800 (GMT+08:00)
Message-ID: <94d07572-0b9e-493f-98e4-c751e5838e7e@easystack.cn>
Date: Thu, 22 Oct 2026 19:40:39 +0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] mm/page_owner: add bpf_iter and kfuncs
To: Andrew Morton <akpm@linux-foundation.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, vbabka@kernel.org, surenb@google.com,
 mhocko@suse.com, brendan.jackman@linux.dev, hannes@cmpxchg.org,
 ziy@nvidia.com, shuah@kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261021112437.1799213-1-zhen.ni@easystack.cn>
 <20261021115240.f195a2a55364fe300cbb6983@linux-foundation.org>
From: "zhen.ni" <zhen.ni@easystack.cn>
In-Reply-To: <20261021115240.f195a2a55364fe300cbb6983@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa16369cb290229kunm3eba54192ba45d
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaH0JIVh8fSk1OGktLHh9IHVYVFA
	kWGhdVGRETFhoSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0
	lPT09IVUpLS1VKQktLWQY+



在 2026/10/22 02:52, Andrew Morton 写道:
> On Wed, 21 Oct 2026 19:24:30 +0800 Zhen Ni <zhen.ni@easystack.cn> wrote:
> 
>> page_owner records who allocated every page and is a core memory-debug
>> facility, but it currently reaches userspace as the debugfs flat dump:
>> slicing allocations by pid, comm, NUMA node, cgroup or stack, etc.,
>> means streaming and parsing the entire file in userspace, which is
>> expensive on large hosts and hard to query live.
> 
> Confused.  Your series 8570b65220e8 ("mm/page_owner: add print_mode
> filter") addressed this significantly?
> 
> 

Thank you. I'd like to share some background on how this new approach
came about.

After series 8570b65220e8 ("mm/page_owner: add print_mode filter"), I
attempted to further extend the filter capabilities so that userspace
could more selectively capture page owner results. This effort led to
the series [PATCH v3 0/8] mm/page_owner: Add PID/TGID/COMM and cgroup
filtering.

During that discussion, we gradually reached a consensus that "a BPF
iter" might be a better solution to this problem. The main concerns
with continuing to extend the kernel-side filter approach were:

  1. As filter capabilities grow, the kernel side needs to handle
  increasingly complex parameter parsing and various combinations of
  different filter attributes, which is not conducive to maintainability.

  2. More fundamentally, kernel-side filters cannot provide truly
  flexible filtering because the filtering logic is hardcoded in the
  kernel.

At that point, I did a POC to verify the BPF iter direction:

  
https://lore.kernel.org/linux-mm/99a94068-ab37-47c0-878c-7c1ada5204b2@easystack.cn/

It seems there is broad agreement on this direction. This new series is
the implementation of that approach.


Thanks,
Zhen


