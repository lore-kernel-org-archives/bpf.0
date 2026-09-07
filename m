Received: from mta1.migadu.com (out-160.mta1.migadu.com [95.215.58.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2573C872B
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 03:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788751917; cv=none; b=YAY5FKZX2L9VYqHxqFvYovN40LyuGfioWi1CBpGEnXSTGxHac2O2BcDRrjZ6nNCPN40XzT/2Pf+j/wy7JmvZC56j+QH8Uo2QWa4pzDT/Z45qhWch5PybiDqWYfYPFiFD/e7R2fT107VnwLB58rLoLVF71z1sU3wwiAIVEHNuans=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788751917; c=relaxed/simple;
	bh=VMIbqoBiQDeHLrphbYg5Mf+UsKXgH9fka3p1+aplsZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K47yKdxTRrTAeYqIyL6x4rga2nqKd47Vczp2CWVHe1+eg/1JylHMCiqD7dmIlemvGiW8rSgEO7Fs5adwvXnxvjMOWWKSB2e43kYnrKq8n2Jnyhk9ER42zJJ2ABgkDBlbzxz1KJzoSAQF23bvunr5F0VrcTOtu3R0BH1OBBsonxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u6OmzNGU; arc=none smtp.client-ip=95.215.58.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u6OmzNGU"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=VMIbqoBiQDeHLrphbYg5Mf+UsKXgH9fka3p1+aplsZE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788751912; v=1; x=1789356712;
 b=u6OmzNGU6htyuZB9kN7btaayVrma/AWzfBItwEpaUeH0V41C7JjCziCsc5jEP8DRP40gFMob
 zsCf0t0tNlPry5kBEzxBgbXn1sVrSo6Sbk+ycC1m02xzhhSl7BQQZrzbFlOcf5b2ILk6Q6cjvND
 AwoiubskkSQiExq+8lzrnfak=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e3763fd486958387;
	Mon, 07 Sep 2026 03:31:52 +0000
X-Mizu-Trace-ID: e3763fd486958387
X-Migadu-Flow: FLOW_OUT
Message-ID: <13813a74-1f1b-4fb5-a589-6eda1e99bd19@linux.dev>
Date: Mon, 7 Sep 2026 11:31:46 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (macOS/Intel)
Subject: Re: [PATCH bpf-next v7 0/2] bpf: BPF-driven proactive memcg reclaim
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, JP Kobryn
 <inwardvessel@gmail.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>,
 Barry Song <baohua@kernel.org>, Geliang Tang <geliang@kernel.org>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
Cc: Hui Zhu <zhuhui@kylinos.cn>
References: <cover.1788516769.git.zhuhui@kylinos.cn>
 <DL7CFVDSDV92.1VPGNHDCKVVIV@gmail.com>
Content-Language: en-US
From: Hui Zhu <hui.zhu@linux.dev>
In-Reply-To: <DL7CFVDSDV92.1VPGNHDCKVVIV@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> On Fri Sep 4, 2026 at 12:20 PM CEST, Hui Zhu wrote:
>> From: Hui Zhu <zhuhui@kylinos.cn>
>>
>> BPF programs can observe memory pressure on a cgroup (e.g. refault
>> stats via bpf_mem_cgroup_page_state()), but cannot act on it:
>> triggering reclaim on a chosen cgroup requires writing to
>> memory.reclaim, which BPF cannot do. This series adds
>> bpf_proactive_reclaim(), a sleepable kfunc performing one proactive
>> reclaim pass on a target memcg, so when and how hard to reclaim is
>> BPF policy rather than hard-coded thresholds.
>>
>> The kfunc is restricted to BPF_PROG_TYPE_SYSCALL so that reclaim
>> always runs in a clean process context: generic sleepable programs
>> may execute with filesystem locks held or in NOFS/NOIO contexts,
>> where the reclaim path could deadlock in filesystem shrinkers. The
>> bpf_wq and task_work callbacks of a SYSCALL program keep its program
>> type and run in process context, so reclaim work can still be queued
>> asynchronously through them, as the selftest does with bpf_wq.
>>
>> The use case we are looking at is protecting high-priority workloads:
>> a BPF program monitors the state of a high-priority cgroup and, when
>> it degrades (e.g. PSI rises or refaults increase, as in the
>> selftest), asynchronously reclaims memory from low-priority cgroups
>> via bpf_wq and bpf_proactive_reclaim(), giving the pressured cgroup
>> more free pages.
>>
>> Another use case: several vendor-maintained kernels carry private
>> implementations that trigger asynchronous reclaim when a memcg enters
>> a certain state. These exist for historical and partly psychological
>> reasons, but the underlying demand is real. We expect BPF-driven
>> proactive reclaim, combined with the BPF hooks for the memory
>> controller currently under discussion and development, to serve these
>> needs in mainline, reducing kernel fragmentation and improving kernel
>> maintainability.
>  From BPF perspective this looks ok to me. I saw you dropped the swappiness
> argument, what happened there? I thought we agreed to just include it in the
> kfunc now. Did something change?

Nothing changed. I misunderstood the earlier discussion and dropped the
swappiness argument by mistake. The plan to include it in the kfunc
still stands, and I will add it back in the next version.

Best,
Hui

