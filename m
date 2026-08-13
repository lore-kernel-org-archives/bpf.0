Received: from mta0.migadu.com (out-129.mta0.migadu.com [91.218.175.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC04483BF7
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 15:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786633275; cv=none; b=dvbYA4B5yawGh9MC/KR+of5VIi8rMsjN3dL+RY0jp7ewvEIX/f4oyeook92IMGyRtq1uQvmAi8y35sphHxcmxpDusNraxDiHeZuMi3+BHdn4qmoFm3pKFueJcGAwK/9G84GgChsA3NYnDS0UNim2k+iMAM63ZXZp2yk7N5rn7Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786633275; c=relaxed/simple;
	bh=kjQCGgpsYPUeNoy8VC501KK4ntDE5I7q0H01tiCcS7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T+/1Dw53YVDjZPnlWr/z1V5/B5VfhhHdu8/WInZzl/LOc8izStKNFDwbUtJc3rTbXqiUVkQSTjRxfONQqzRIvwPDIk2+Td/yfCMYn4ex+HU6yMt4TD9tdXdcqibbq0MPlRzkVrgjYU/wX8GgbaJDSVP/weSKVudYCdsxCOKm+kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=niYvM0fh; arc=none smtp.client-ip=91.218.175.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="niYvM0fh"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=kjQCGgpsYPUeNoy8VC501KK4ntDE5I7q0H01tiCcS7k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786633268; v=1; x=1787238068;
 b=niYvM0fhq4QRfdtgz+RjiGqJYRRU+5JFvhnzTc4Rm2tvSKgYkDA9/e/5pr1HyoqzP0Ribk1m
 sUCRzcnvvusKSwC9jO54iB3b06f2f0SShCjS45JK814+mjMSRhbpK25rNdKfvxI0oFER/XwAgXg
 QiQOKVKi2javLicFmvodVLbM=
X-Envelope-To: bpf@vger.kernel.org
Received: from [172.20.10.7] (117.20.149.103)
	by smtp.migadu.com with ESMTPS id bb8ba90ab4d9734f;
	Thu, 13 Aug 2026 15:01:08 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <e3ff24e6-f0e0-415a-acfa-4f541796d109@linux.dev>
Date: Thu, 13 Aug 2026 23:00:56 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf: fix percpu map update indexing with sparse CPU
 IDs
To: Hui Su <sh_def@163.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, sashiko-bot@kernel.org
References: <20260813120250.796934-4-sh_def@163.com>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260813120250.796934-4-sh_def@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Hui,

Thanks for the further fixes.

On 2026/8/13 20:02, Hui Su wrote:
> Per-CPU array, hash, and cgroup storage map updates without BPF_F_CPU
> or BPF_F_ALL_CPUS use a value buffer whose per-CPU slots are packed in
> possible-CPU order. The buffer is sized as:
> 
>   round_up(value_size, 8) * num_possible_cpus()
> 
> The update paths iterate over possible CPUs, but use the logical CPU ID
> to calculate the source offset:
> 
>   value + size * cpu
> 
> This only works when possible CPU IDs are contiguous starting at zero.
> 
> For example, with a possible CPU mask of 0,2-3, the buffer contains
> three slots corresponding to CPUs 0, 2, and 3. CPU2 is therefore
> expected to use slot 1 and CPU3 slot 2. Instead, the current code uses
> slots 2 and 3 respectively, causing incorrect per-CPU values and an
> out-of-bounds read from the update buffer for CPU3.
> 
> The corresponding lookup paths already use a dense offset while
> iterating over possible CPUs. Do the same for the array, hash, and
> cgroup storage update paths, advancing the source offset once for each
> possible CPU. BPF_F_ALL_CPUS continues to use the same value for every
> CPU.
> 
> Fixes: 8eb76cb03f0f ("bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_array maps")

The ci bot got the point about the missing Fixes:

Fixes: c6936161fd55 ("bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags
support for percpu_hash and lru_percpu_hash maps")
Fixes: 47c79f05aa0d ("bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags
support for percpu_cgroup_storage maps")

> Reported-by: sashiko-bot@kernel.org

This Reported-by is unnecessary, because Sashiko would review most LKML
patches.

> Signed-off-by: Hui Su <sh_def@163.com>

Acked-by: Leon Hwang <leon.hwang@linux.dev>

Thanks,
Leon

> ---
