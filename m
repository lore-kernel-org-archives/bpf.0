Received: from mta1.migadu.com (out-248.mta1.migadu.com [95.215.58.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFBB483802
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786632258; cv=none; b=HskFl8U7tJ6uKo0eZa+URIGz3lFySuyfjt5htZ8B/UchR1JiyTHr+1ouut2ZvQBQqwf5AHIdXKotO7LWiYF4MIcpSydB6FtayG5LwnFYLE8JvIzSMJsIgqfmh1sTbSg80p3sbnHplWJlD7n9B3uK8nKdiEVJWllsRCF/iGIBwFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786632258; c=relaxed/simple;
	bh=8fVIx7G6mHExdyJvBnMZanXKXlszThoCe1xwtW73Qyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SCQRgzecHf1YzcXNDsx9+PVXE6KaMeH+bEdReHgj6K0p6wyTSqz4Ck6dr/EPjU/w/x00SJTlxrmViJPnbk6C1slXBHstPMD/kCrld34z+LoDhlXO6dFQsAy068tJmxjvQPEtKTsEN18C3WVit3/JYrASIcy5bHsqC+XZM4GRSms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lkxYwXZj; arc=none smtp.client-ip=95.215.58.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lkxYwXZj"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=8fVIx7G6mHExdyJvBnMZanXKXlszThoCe1xwtW73Qyw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786632253; v=1; x=1787237053;
 b=lkxYwXZjET8OnFj479lYLdwfbKpsp51ep/i6lQq1G9PuU+0d3kyGwBmKX9e3FsWsDtojoyX2
 VHAMdVxA5YcQNDcirsUaT0OVeUJ0mAl+mAS/ELKK3Wfzx9YiWlx22ZDKEsN4FqjWnactSrypWse
 gb3bs2yYU6ypGcbQUmaWvqCY=
X-Envelope-To: bpf@vger.kernel.org
Received: from [172.20.10.7] (117.20.149.103)
	by smtp.migadu.com with ESMTPS id 44444fa5db3f0b38;
	Thu, 13 Aug 2026 14:44:13 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <56ff2d90-5943-4e9b-afc8-18dcaef2f893@linux.dev>
Date: Thu, 13 Aug 2026 22:44:04 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf: fix BPF_F_CPU validation for sparse CPU IDs
To: Hui Su <sh_def@163.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260813101229.680523-3-sh_def@163.com>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260813101229.680523-3-sh_def@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Hui,

On 2026/8/13 18:12, Hui Su wrote:
> BPF_F_CPU stores the target CPU ID in the upper 32 bits of the map
> operation flags. bpf_map_check_op_flags() currently compares that ID
> with num_possible_cpus(), which is the number of possible CPUs rather
> than a bound on CPU IDs.
> 
> On an arm64 QEMU guest with a CPU device-tree hole, the possible CPU

TIL about the possible CPU hole.

> mask was 0,2-3. A userspace program using raw bpf() syscalls creates
> a BPF_MAP_TYPE_PERCPU_ARRAY and performs update and lookup operations
> for each CPU by setting BPF_F_CPU and the CPU ID in the flags.
> 
> With the old check, CPU 1 is incorrectly accepted while valid CPU 3 is
> rejected with -ERANGE. The CPU 1 update then reaches the per-CPU map
> access path and triggers:
> 
>   Unable to handle kernel paging request at virtual address ...
>   pc : __pi_memcpy_generic+0x5c/0x22c
>   lr : bpf_percpu_array_update+0x2dc/0x2e8
>   Call trace:
>     __pi_memcpy_generic
>     bpf_map_update_value
>     map_update_elem
>     __sys_bpf
> 
> Check the CPU ID against nr_cpu_ids and cpu_possible() instead. This
> rejects CPU IDs outside the valid range and CPUs absent from the
> possible mask, while allowing valid sparse CPU IDs.
> 
> Fixes: 2b421662c788 ("bpf: Introduce BPF_F_CPU and BPF_F_ALL_CPUS flags")
> Signed-off-by: Hui Su <sh_def@163.com>
> ---
>  include/linux/bpf.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 7719f6528445..282f7022d984 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -4202,7 +4202,8 @@ static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 all
>  			return -EINVAL;
>  
>  		cpu = flags >> 32;
> -		if ((flags & BPF_F_CPU) && cpu >= num_possible_cpus())
> +		if ((flags & BPF_F_CPU) &&
> +		    (cpu >= nr_cpu_ids || !cpu_possible(cpu)))

NIT: no need to put the cpu check on a new line, as 100 chars per line
are allowed.

Other than the NIT,

Acked-by: Leon Hwang <leon.hwang@linux.dev>

>  			return -ERANGE;
>  	}
>  

