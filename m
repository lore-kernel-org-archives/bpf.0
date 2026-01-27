Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59601DE8AE
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 20:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769545271; cv=none; b=Kj7osjwaTjylABDCcBGcVX+kiPDcZQ3V20QjKsLcqbYdhzklA5aC5CR5VfgKY0luRpsmEztHsMylIPoRub/NXTMpLNS7zGVwXrXCUfgQtX+r7cyBf/OUaplPqWyJvMXzG+2+nXy/NzvK452AUmfO/G3+nGEvZIA1uuP1LMUY4qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769545271; c=relaxed/simple;
	bh=XFHULvI9Ru40wthBvjelLrasYy/5aArCPZEZW4a/JiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WVa4A+uFtGM4UE3e9Zg7zLFsuiSHoQJym1zLHgRj9IJawc5F/kaYaPe8s4K1wOvaiTCX/yUk67VZvW8oKVg4cglRpi2d4GXmMJKYOLXFlu+F9s47en8xf1gjTJ3DEnoxW2wrpLIBKg3PEzPCfIg8waejUwtlhHVbk5t7leKa/TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dq+jIiFi; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dq+jIiFi"
Message-ID: <9a2c5f29-b45c-4ff3-a8f4-51d207a82d38@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769545266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YUP+BUUh/kupPGgyR6A9Wup/rhNgbndAT0lTSWXG59k=;
	b=Dq+jIiFiFSLuZJ96MCgtUz37FFhowjkA6JRgG9tjp1VHCsmGbRbyaX2Sof35A0H7AwXK5n
	a+Ku4rb5MSPNs1Gm+aKO9/eTWRKzDUqsnnOQXwB3exWZxwJt5+f+vDK2gKhcpi3iEoCvmm
	k3OP4uXSsZ2Z1MADJO8Uq0laIp7aoFc=
Date: Tue, 27 Jan 2026 12:21:03 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 08/17] mm: introduce bpf_oom_kill_process()
 bpf kfunc
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Michal Hocko <mhocko@suse.com>, Alexei Starovoitov <ast@kernel.org>,
 Matt Bobrowski <mattbobrowski@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, JP Kobryn <inwardvessel@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Suren Baghdasaryan <surenb@google.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>,
 bpf@vger.kernel.org
References: <20260127024421.494929-1-roman.gushchin@linux.dev>
 <20260127024421.494929-9-roman.gushchin@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260127024421.494929-9-roman.gushchin@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/26/26 6:44 PM, Roman Gushchin wrote:
> +static int bpf_oom_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)

The filter callback is registered for BPF_PROG_TYPE_STRUCT_OPS. It is 
checking if a kfunc_id is allowed for other struct_ops progs also, e.g. 
the bpf-tcp-cc struct_ops progs.


> +{
> +	if (prog->type != BPF_PROG_TYPE_STRUCT_OPS ||
> +	    prog->aux->attach_btf_id != bpf_oom_ops_ids[0])
> +		return -EACCES;

The 'return -EACCES' should be the cause of the "calling kernel function 
XXX is not allowed" error reported by the CI. Take a look at 
btf_kfunc_is_allowed().

Take a look at bpf_qdisc_kfunc_filter(). I suspect it should be 
something like this, untested:

         if (btf_id_set8_contains(&bpf_oom_kfuncs, kfunc_id) &&
	    prog->aux->st_ops != &bpf_oom_bpf_ops)
                 return -EACCES;

         return 0;

> +
> +static const struct btf_kfunc_id_set bpf_oom_kfunc_set = {
> +	.owner          = THIS_MODULE,
> +	.set            = &bpf_oom_kfuncs,
> +	.filter         = bpf_oom_kfunc_filter,
> +};
> +
> +static int __init bpf_oom_init(void)
> +{
> +	int err;
> +
> +	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
> +					&bpf_oom_kfunc_set);

