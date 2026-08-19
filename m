Received: from mta1.migadu.com (out-72.mta1.migadu.com [95.215.58.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584EE38A72B
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 00:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787101041; cv=none; b=f8sliLDSGivgpHSr05yvDBH3rne24s7ZyjarJEvRqbb3IHnTvgd5Knx34H1D6ulb5zh5XdnC/NkAXLb9AkgvbdAbmR8utDzF3G/iuN7kYqlVWezyaLfdRgifwfOyeEfhAAYjNpuR+/Psm904IS8GHgA9m2+ViNTG+yIMfnNTHVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787101041; c=relaxed/simple;
	bh=DawAylS0sQ//zw07aB+iq8n9z07w0KhAJLwQZUMzs0E=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=d/55e31LioFldOwt1CtQNcaljtCriGVwtcMLGk10QWx7bDEtDR9QuzQsCF3bFCguPkf8gJK7hsxYO/a6mQEt7etkSgNHUCSJbRj8XuXHrN7HKXzi3qpyLLKNKxqqlsDq5iWqiIgtd6pYkBjklSstnF8GFlUvzGlg7GepxCHsaw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xEiFxova; arc=none smtp.client-ip=95.215.58.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xEiFxova"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DawAylS0sQ//zw07aB+iq8n9z07w0KhAJLwQZUMzs0E=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787101037; v=1; x=1787705837;
 b=xEiFxovaigNLrmUiMgsO78sOVZH+fz7Utzr/LEbCdr8F5UZIZWQaLN4jgNMfmDMDOMZ0Fn+c
 XacZl1AGTYMsm4VFaoquooTVIf+W4zSO6LREw5QxxpNi4HsNJY7UznavF2u2A9CYqve7CQsmQNr
 Cs5Co3Qx7fs5YKRKKMq4k9i8=
X-Envelope-To: bpf@vger.kernel.org
Received: from [192.168.110.173] (223.70.159.239)
	by smtp.migadu.com with ESMTPS id 30f13174d05e6ebd;
	Wed, 19 Aug 2026 00:57:06 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <593de517-8835-42ce-9d1a-0362f9066e95@linux.dev>
Date: Wed, 19 Aug 2026 08:57:03 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, void@manifault.com, arighi@nvidia.com,
 changwoo@igalia.com, suzhidao@xiaomi.com, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH RFC] sched_ext: warn when cpu.max is set but the BPF
 scheduler doesn't implement bandwidth control
To: Tejun Heo <tj@kernel.org>
References: <20260818135328.174152-1-cui.tao@linux.dev>
 <aoR7ngyE44epfzXO@slm.duckdns.org>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <aoR7ngyE44epfzXO@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Hello,
在 2026/8/18 23:34, Tejun Heo 写道:
> Hello,
> 
> On Tue, Aug 18, 2026 at 09:53:28PM +0800, Tao Cui wrote:
>> From: Tao Cui <cuitao@kylinos.cn>
>>
>> The kernel stores cpu.max bandwidth parameters in the task_group and
>> passes them to the BPF scheduler via ops.cgroup_set_bandwidth() and
>> scx_cgroup_init_args, but does not enforce the quota itself. If the
>> loaded BPF scheduler doesn't implement the callback, cpu.max is
>> silently ignored -- the cgroup gets unlimited CPU regardless of the
>> configured quota.
>>
>> Of the example schedulers, only scx_qmap implements the callback --
>> and only to bpf_printk() the parameters, so no in-tree scheduler
>> actually enforces the quota. Measured with scx_simple: a
>> cgroup with cpu.max = "50000 100000" (50% of one CPU) and one
>> busy task used 9946ms of CPU in 10 seconds with nr_throttled
>> remaining 0.
>>
>> Print a one-time warning when a finite quota is configured on a
>> cgroup while the active scheduler lacks the callback, so users and
>> container orchestrators know the quota is not enforced.
> 
> We had something similar with cpu.weight and it created more annoaynces than
> helping anything. cgroup bw control isn't the only thing the BPF scheduler
> may skip to implement. It can also choose to ignore e.g. nice levels
> completely too and there's no way to detect things like that. Documentation
> is probably the right way to handle this.
> 

Understood, the cpu.weight precedent makes sense: the scheduler may
ignore a whole set of knobs, and warning on just one of them would be
arbitrary.

I'll follow up with a patch to sched-ext.rst instead: a note that
cgroup CPU knobs like cpu.max only take effect if the loaded scheduler
implements the corresponding callbacks, and that schedulers may also
ignore things like nice levels.

Thanks,
Tao

> Thanks.
> 

