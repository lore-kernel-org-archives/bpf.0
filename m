Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C837B26B756
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 11:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772105928; cv=none; b=CK8VS4jYMR0LIjFrXlX/ZFRpc0zPxkk4SfhrmMh/5Pio3U0uAVJIa+8QQpI3f2+qxtTTHGPAsTMLA9GUtamnFPr63r2d9T6EG3su8OkA8hnQ6XmGzmmQxpqlBDCJW8UJgQmwhml0rXWGUVZSdhVMtcDHlNRiQF2iXoinm9CRt/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772105928; c=relaxed/simple;
	bh=lmm0kAkf0h8ZY4eipiBn7r5LB7jDBcy0Mq1HuFsTVJ0=;
	h=Message-ID:Date:MIME-Version:To:CC:References:Subject:From:
	 In-Reply-To:Content-Type; b=HVDI8NSu3BmOdScaWq/Bn+r4UlH8pjFqE1SuKIVI7TJXQbRNpPMd0biU4R4GLoMFwvoCaRmwUalnYM+8w8DUDcP50UR1g5nz1fP/4W0aqJzlrFulgyjHU8W19uqIMVW7d5WbFt2pPxQkdEQSUzxa3sg3AcoUlK11jxFGN0Mc6cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fM8bS6gPgzJ46bl;
	Thu, 26 Feb 2026 19:38:12 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id B00C74056A;
	Thu, 26 Feb 2026 19:38:37 +0800 (CST)
Received: from [10.123.123.226] (10.123.123.226) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 26 Feb 2026 14:38:37 +0300
Message-ID: <738a358c-e695-44f9-8288-a20d917dc26c@huawei.com>
Date: Thu, 26 Feb 2026 14:38:36 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: <alexei.starovoitov@gmail.com>, <gladyshev.ilya1@h-partners.com>
CC: <bpf@vger.kernel.org>, <lsf-pc@lists.linux-foundation.org>
References: <CAADnVQK=j45QiJTRN2Z43tztkjqGcO+ZwEidrWcfv-d7xoJJKw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Userspace JIT for eBPF
Content-Language: en-US
From: Stepanov Anatoly <stepanov.anatoly@huawei.com>
In-Reply-To: <CAADnVQK=j45QiJTRN2Z43tztkjqGcO+ZwEidrWcfv-d7xoJJKw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500003.china.huawei.com (7.188.49.51)

Hi,

Looks interesting, in terms of getting latest available machine-code optimizations into eBPF quickly, w/o kernel update.
We have several production scenarios, that might get benefit from that.

It’s clear that Linux kernel can eventually get these optimizations in future, but now we have lots of machines with some older LTS kernels
which are going to be upgraded in 1-2 years.

I have several questions here:
To Ilya:
1. Do you have any performance results apart from sched-ext?
2. Is it published in some way, so we can try?

To Alexei:
As far as i see, concurrency is one of the major concerns.

We have 90% of kprobe/uprobe/tracepoint eBPF hooks and 10% other types, 
so for the majority cases it seems like only issue is
concurrent accesses to shared eBPF-maps, which could be supported by LLVM via fetch_add/etc., 
what are your thoughts on this?

Another question: can we have some mechanism in BPF-verifier (in theory at least) to detect concurrent-related
behavior (control-flow dependencies on shared data for example) and if so, just fallback to default approach?

-- 
Anatoly Stepanov, Huawei

