Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224043B0586
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 18:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787942787; cv=none; b=giqzOeV2YsZskf2Hr306S02WrQvgYr5tFJH3BgJLDtta8JSb0pP8PL5Gv6FbqHW0yVVkkCHS1OZgvmuoFoLs6uT7311PKnoabDSA6bPG2IT5nBapth2EjUYkiT/VUsqZ4ROPb2unLo7rrCF9s0+9Zm4gswNGwdap6sy8rQfgiwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787942787; c=relaxed/simple;
	bh=EEV/IPsl8mDROGoGCEFzxfvlRp2YIHNeqe0ZSz7RXgk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=b0bx+LEMWnx7jRKIoprY0vrQUNtw1rKZmSdRT7YI87QJGxAPg2pF1cd5/SZpVoFO3sYT6eQVLptqrCjFMUN9CgZOttEpFYxw5dipwGAk4sUTK/AchUjGqv3IFzB5tvzEWVIGymuBYOGnbuYmyoelBqlIFTAi3hD7/oF13a4AyvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3BO73s6; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3BO73s6"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc1c8d4a959so1091749a12.3
        for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 11:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787942785; x=1788547585; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aB4Z3NFd3eVXYWWAFx2AB1yt45KqFOX9Ko3ers1QHDM=;
        b=b3BO73s66UGqMy5IwtHcCvc5ruBMu923Exvx1oobVnn/uTFDvxfxEOzwWMbT5xhLC5
         qOnNxE2cQ8K7qrG4NdYpRjdv5ImZJ1Ki7YUVZ0M7K3xJmdplh045REI6sdJ52Iz1o6bj
         ybN3UBqbg1GLbcffTQgsBJOgvDGiD7k84mZ91H8ILMZRRsG6NcOyU2EkMPC+VFzH7259
         vX8sYxWju1Dyf6t3DBR7yVLmbcssVkCHWRPcZh0CU5t4ND42mJN9gVJrGjZeQ0tXMpTE
         yHEMlcDINdP+tsZ/iVJBediBVDJTFcvvVRISOjORgXxjgbpw84PDrKVzTXrGaOtmbGEB
         pJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787942785; x=1788547585;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aB4Z3NFd3eVXYWWAFx2AB1yt45KqFOX9Ko3ers1QHDM=;
        b=XGk2uK5F98jEVKMNbOWs9IVMYxdGBze822pwZQnohT5uP4kx6GTeKl1HGcXrrlXchD
         XxJ+/wKQ97xwf64tFikpj6RHhrR2vIs9OvkAnTxOaxKKNBq1J1IAaj7IGFRcri1TcwYa
         5qs8iv9avJESkh5TdEW0rwCrvlur6DC8Are1ZGp8PkoyRRsm27Z1vdAm05RqIkBl24Jx
         Zvwu/xsXzXyuDE51zO6sd67conOgS2D/k+/E7MC7gb4UvzM19xotbXc5GoESJMpukQQG
         /6QJsrfDT4gpkqCtGkz7w0X9uPNAeDRXUt8k0N3936fUlPXbgS1nmXAXLEHmmW1LuyBD
         PGSA==
X-Forwarded-Encrypted: i=1; AKwUvBwDA4MxIpxHhzPetQ7/sG8KBtSG9kIe6LOqLYfCBNDaydx/bpR9Fx1luUwfLAZOPAKE3es=@vger.kernel.org
X-Gm-Message-State: AFuF++k5Z8BdxGV6L/i69hSBPUnDoAlDAGNs932JyZibx58kKrkY/DKr
	gaUF6Ax7XHqijNdKLuT5WVDyNvK9B9pBN69gW8G+Nlc0z4DOfoDgKfat
X-Gm-Gg: AYBFou3n9kNFH0B4ywJdeltP+CtcfdcKeiBOxJiKcwJj9s9UYmeB7weACQOkaq4SK/2
	ju2i2vRR7Rdom+dknfInMsBr6ovyqPchppTVuK1kKmEYe6XkktXEoUZJgf7jE1p7qfAFQT1bSPn
	JTuc/L0WXhnroN6WnjLkE5nWed48U+JgF9jdYrDShpL27K+EOFyZBtyJmYZOwGbnXFmduc1gQMr
	sCZOnJ/y0IAQYPmPU4/Up/mYn4LK56C/3CkDKmg+CtmBoquOm/ZgKIi+6l2V7OpOpZkRinl1lrv
	oLoNCy1pM+hzcqsKpuGcWJ9IHrbGslDve1Odn6UbBzjFfyIqVUBs6IZyEcIp5zTEQkvtCU3+iWD
	443ADFhySC1rPjT700e1XTZYRy6TY9ywn//XMPXLx7LxUuFexr/9RTB9zUVgW5CIRT2TEtjIkBZ
	j6I15OhAX10f1TzTMCUy5vJovvilQUhBihl8IRM1y9pT2gs5L4pgbjPaZEb2A5HwIL8msETfqcI
	zFB
X-Received: by 2002:a17:90b:4ac4:b0:37f:e1b6:4c7d with SMTP id 98e67ed59e1d1-396d0e20f0bmr14884547a91.6.1787942785275;
        Fri, 28 Aug 2026 11:46:25 -0700 (PDT)
Received: from [192.168.2.112] ([205.254.163.27])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f552473sm8449424eec.0.2026.08.28.11.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2026 11:46:24 -0700 (PDT)
From: Suchit Karunakaran <magneto712003@gmail.com>
X-Google-Original-From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Message-ID: <3258a85d-3578-4982-bd4b-bd516d9bc8b5@gmail.com>
Date: Sat, 29 Aug 2026 00:16:18 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpftool: Print average cycles per program run in
 profiler
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 kernel-team@meta.com, eddyz87@gmail.com, memxor@gmail.com, qmo@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20260827-bpftool_cyles_per_run-v1-1-77d7bfc3c065@meta.com>
Content-Language: en-US
In-Reply-To: <20260827-bpftool_cyles_per_run-v1-1-77d7bfc3c065@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 8/27/26 8:59 PM, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Total cycle counts are difficult to compare across workloads with
> different run counts. Report cycles per run to expose the per-invocation
> cost directly.
>
> Example:
> sudo ./bpftool prog profile name mprog duration 15 cycles instructions
>
>              423256 run_cnt
>           947413975 cycles              #  2238.39 cycles per run
>           333965846 instructions        #     0.35 insns per cycle
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>   tools/bpf/bpftool/Documentation/bpftool-prog.rst |  6 ++++--
>   tools/bpf/bpftool/prog.c                         | 18 +++++++++++-------
>   2 files changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> index 90fa2a48cc26..2280dc4492c0 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> @@ -217,7 +217,9 @@ bpftool prog run *PROG* data_in *FILE* [data_out *FILE* [data_size_out *L*]] [ct
>   bpftool prog profile *PROG* [duration *DURATION*] *METRICs*
>       Profile *METRICs* for bpf program *PROG* for *DURATION* seconds or until
>       user hits <Ctrl+C>. *DURATION* is optional. If *DURATION* is not specified,
> -    the profiling will run up to **UINT_MAX** seconds.
> +    the profiling will run up to **UINT_MAX** seconds. When **cycles** is
> +    selected, plain output also reports the average number of cycles per
> +    program run.
>   
>   bpftool prog help
>       Print short help message.
> @@ -360,7 +362,7 @@ EXAMPLES
>   ::
>   
>            51397 run_cnt
> -      40176203 cycles                                                 (83.05%)
> +      40176203 cycles          # 781.68 cycles per run                (83.05%)
>         42518139 instructions    #   1.06 insns per cycle               (83.39%)
>              123 llc_misses      #   2.89 LLC misses per million insns  (83.15%)
>   
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index a9f730d407a9..8935508f955b 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -2069,9 +2069,9 @@ struct profile_metric {
>   	bool selected;
>   
>   	/* calculate ratios like instructions per cycle */
> -	const int ratio_metric; /* 0 for N/A, 1 for index 0 (cycles) */
> +	const int ratio_metric; /* 0 for run_cnt, 1 for index 0 (cycles) */
>   	const char *ratio_desc;
> -	const float ratio_mul;
> +	const double ratio_mul;
>   } metrics[] = {
>   	{
>   		.name = "cycles",
> @@ -2080,6 +2080,9 @@ struct profile_metric {
>   			.config = PERF_COUNT_HW_CPU_CYCLES,
>   			.exclude_user = 1,
>   		},
> +		.ratio_metric = 0,
> +		.ratio_desc = "cycles per run",
> +		.ratio_mul = 1.0,
>   	},
>   	{
>   		.name = "instructions",
> @@ -2256,17 +2259,18 @@ static void profile_print_readings_plain(void)
>   	for (m = 0; m < ARRAY_SIZE(metrics); m++) {
>   		struct bpf_perf_event_value *val = &metrics[m].val;
>   		int r;
> +		__u64 ratio;
>   
>   		if (!metrics[m].selected)
>   			continue;
>   		printf("%18llu %-20s", val->counter, metrics[m].name);
>   
> -		r = metrics[m].ratio_metric - 1;
> -		if (r >= 0 && metrics[r].selected &&
> -		    metrics[r].val.counter > 0) {
> +		r = metrics[m].ratio_metric;
> +		/* r == 0 is a special case for run_cnt */
> +		ratio = r ? metrics[r - 1].val.counter : profile_total_count;
> +		if (metrics[m].ratio_desc && ratio) {
>   			printf("# %8.2f %-30s",
> -			       val->counter * metrics[m].ratio_mul /
> -			       metrics[r].val.counter,
> +			       val->counter * metrics[m].ratio_mul / ratio,
>   			       metrics[m].ratio_desc);
>   		} else {
>   			printf("%-41s", "");
>
> ---
> base-commit: 23ff631b3b8b1452dfe933ee21f96321a9c5e209
> change-id: 20260827-bpftool_cyles_per_run-93169fcb30b7
>
> Best regards,
> --
> Mykyta Yatsenko <yatsenko@meta.com>
>
I think val->counter be normalized for counter multiplexing before 
dividing by profile_total_count? val->counter contains only the cycles 
observed while the event was actively scheduled on the PMU, whereas 
profile_total_count reflects all program invocations across the full 
duration. When val->running < val->enabled, dividing raw val->counter by 
profile_total_count undercounts the true cycles per run. Should we apply 
scaling before computing the ratio like below?
if (val->running > 0) {
     double scaled = (double)val->counter * val->enabled / val->running;
     double cycles_per_run = scaled / profile_total_count;
}

We can actually see this in the example:

51397 run_cnt
40176203 cycles          # 781.68 cycles per run (83.05%)
Here, 781.68 uses the raw unscaled count during the 83.05% runtime 
window. If we scale it to 100% estimated coverage, the true cost is 
closer to ~941.22 cycles per run.

