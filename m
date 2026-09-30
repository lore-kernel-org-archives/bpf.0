Received: from mta0.migadu.com (out-138.mta0.migadu.com [91.218.175.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B922453A33
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 07:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751802; cv=none; b=EVoOLmcCBr8cn/yD4bntEIR4k79I2v2FZV1Z8kinVraU9k6QgqWTRDBgmqHDHgJLFEFzk5nOxTih/DDxM2MNoKfp24CgC7VmvrV4zUGs3c21fL8WTr0mHoiwNJ3jV4ra5g54QbhhtmK8H5Eakbuwd2wSKa9oGvD3PHX2e01HWNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751802; c=relaxed/simple;
	bh=jpNhQihWErbhM7Gx5asxcKZdL5Z4cuAycNPzwkcOVrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tUFn8SedYOuyHCwH57qxO8G5esS5Jn7USiWZksuebtXrdHf062cnlvT44KPjH/glFjjxxf2SBcWYibBBSVnqEtEgGwzijFyghhxEnJ2cZky6gpYCQbfARS8mV6tbvHNlIOTbMHw30CXh1R4xPeTZQ1eP3zDCwAHfA84OLO5pq1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qN2h9Itq; arc=none smtp.client-ip=91.218.175.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qN2h9Itq"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jpNhQihWErbhM7Gx5asxcKZdL5Z4cuAycNPzwkcOVrc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790751778; v=1; x=1791356578;
 b=qN2h9ItqgX0FYWsgdo/LdAF8U0iOK4I+EFSBFmWsXzXdRJ2JO30fIZbLEabR4QZ87P+0kgiy
 0edeLXt20C4pqMO4083BOY+X98W4Gh3zvnTzE4G+L3IhhWBGsaB04InQYcFGvUN0YegmoGpMZQM
 MWPTkfTvIiPiiOgg4vqsidCo=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id fec408de45ee17d1;
	Wed, 30 Sep 2026 07:02:58 +0000
X-Mizu-Trace-ID: fec408de45ee17d1
X-Migadu-Flow: FLOW_OUT
Message-ID: <72be1025-342c-4832-8371-64a9b73d605e@linux.dev>
Date: Wed, 30 Sep 2026 15:02:45 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG: using smp_processor_id() in preemptible code in
 bpf_mem_cache_free_rcu
To: =?UTF-8?B?5qKF5byA5b2m?= <kaiyanm@hust.edu.cn>,
 =?UTF-8?B?YnBm6YKu5Lu25YiX6KGo?= <bpf@vger.kernel.org>
Cc: "dzm91@hust.edu.cn" <dzm91@hust.edu.cn>, dddddd@hust.edu.cn
References: <7630c316.5cc7.1a0f0ca5f88.Coremail.kaiyanm@hust.edu.cn>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <7630c316.5cc7.1a0f0ca5f88.Coremail.kaiyanm@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/30/26 1:29 PM, 梅开彦 wrote:
> Our fuzzer tool discovered a preemption-safety vulnerability in the BPF
> subsystem (bpf-next 61c1e63c9b651a77b1e24208b9361965c69959e6).
> On a `BPF_MAP_LOOKUP_AND_DELETE_BATCH` over a
> `BPF_MAP_TYPE_RHASH` map, `rhtab_delete_elem()` calls
> `bpf_mem_cache_free_rcu()` in a preemptible (migratable) context,
> violating the "migration is disabled" contract of the BPF memory
> allocator, and `this_cpu_ptr()` triggers the
> `CONFIG_DEBUG_PREEMPT` check.
>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>


It duplicates the syzbot report [1]. You can follow the patch list inside.

[1]: https://syzkaller.appspot.com/bug?extid=fd7e415d891073b83e1f

