Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3816280A5B
	for <bpf@vger.kernel.org>; Mon,  2 Mar 2026 18:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772475062; cv=none; b=UZ8OmpiEzBImEWfO7oTcmuB2MXWh51KXDnwU5niJtaL3KrcF/bUg0rVlJxwITKl9kGlhWFTnixy8G50gRTL6U1Me3ktjMAqg+DAZIWBYYC3UsuPdCgkB1vcarL2gFj7W3bVPss6/02GB9HgPmWkIuT+vR7n25Xul3Mh3gvrIXnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772475062; c=relaxed/simple;
	bh=+Xsz1mtT+7gpi4ZCH98u1OF3gWGH/IpP1iueiSyq2Tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XqftKB4R3loFOt1gMteWr2G/9m9SATReCcAB2q0MqP9s8HQFRnoTf1LHc+214PR1Y309U7yiWk0nVCUkwVjkEDq6/eeIDhZGLDh6phzpUr+3V7/m1MpPGWLzrYPNcYbzXP2g1qfPN1U7ql9Mh67jrI1De6VXbold+pjLSOYnYdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hLmRj9Kp; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hLmRj9Kp"
Message-ID: <ff97e783-96f5-42ce-a036-0084b18f5b5f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772475059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKnzwKm4x4lqecMGxvXjd7RplmXjd6tG05AaIisUCBY=;
	b=hLmRj9KpuhYnKrt/Cv9tf9VOTUAFtNquUGD3Ma8qh7tXbNQwPwEFZ4Zf28NEHpkOWhCkFg
	bavUS4AfAYxgCVaoMB6dckgB9LgEVXym4xdMpTvEd1DCGsfmIqC/Fg8vAAvxQUb2AJOsvh
	JcE0wpPGQnKLeOp8vLH3ppqgwG7w0VI=
Date: Mon, 2 Mar 2026 10:10:50 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/3] bpf: Use bpf_core_enum_value for stats in
 cgroup_iter_memcg
To: Hui Zhu <hui.zhu@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Hui Zhu <zhuhui@kylinos.cn>
References: <cover.1772270591.git.zhuhui@kylinos.cn>
 <0831b50f85b4b00e698ef0b5fff6acd196dd1265.1772270591.git.zhuhui@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "JP Kobryn (Meta)" <jp.kobryn@linux.dev>
In-Reply-To: <0831b50f85b4b00e698ef0b5fff6acd196dd1265.1772270591.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/28/26 1:25 AM, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
> 
> Replace hardcoded enum values with bpf_core_enum_value() calls in
> cgroup_iter_memcg test to improve portability across different
> kernel versions.
> 
> The change adds runtime enum value resolution for:
> - node_stat_item: NR_ANON_MAPPED, NR_SHMEM, NR_FILE_PAGES,
>    NR_FILE_MAPPED
> - vm_event_item: PGFAULT
> 
> This ensures the BPF program can adapt to enum value changes
> between kernel versions.
> 
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> ---
>   .../selftests/bpf/progs/cgroup_iter_memcg.c     | 17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/cgroup_iter_memcg.c b/tools/testing/selftests/bpf/progs/cgroup_iter_memcg.c
> index 12f79a44133e..06a385c9d85b 100644
> --- a/tools/testing/selftests/bpf/progs/cgroup_iter_memcg.c
> +++ b/tools/testing/selftests/bpf/progs/cgroup_iter_memcg.c
> @@ -26,11 +26,18 @@ int cgroup_memcg_query(struct bpf_iter__cgroup *ctx)
>   
>   	bpf_mem_cgroup_flush_stats(memcg);
>   
> -	memcg_query.nr_anon_mapped = bpf_mem_cgroup_page_state(memcg, NR_ANON_MAPPED);
> -	memcg_query.nr_shmem = bpf_mem_cgroup_page_state(memcg, NR_SHMEM);
> -	memcg_query.nr_file_pages = bpf_mem_cgroup_page_state(memcg, NR_FILE_PAGES);
> -	memcg_query.nr_file_mapped = bpf_mem_cgroup_page_state(memcg, NR_FILE_MAPPED);
> -	memcg_query.pgfault = bpf_mem_cgroup_vm_events(memcg, PGFAULT);
> +	memcg_query.nr_anon_mapped = bpf_mem_cgroup_page_state(
> +		memcg,
> +		bpf_core_enum_value(enum node_stat_item, NR_ANON_MAPPED));
> +	memcg_query.nr_shmem = bpf_mem_cgroup_page_state(
> +		memcg, bpf_core_enum_value(enum node_stat_item, NR_SHMEM));
> +	memcg_query.nr_file_pages = bpf_mem_cgroup_page_state(
> +		memcg, bpf_core_enum_value(enum node_stat_item, NR_FILE_PAGES));
> +	memcg_query.nr_file_mapped = bpf_mem_cgroup_page_state(
> +		memcg,
> +		bpf_core_enum_value(enum node_stat_item, NR_FILE_MAPPED));
> +	memcg_query.pgfault = bpf_mem_cgroup_vm_events(
> +		memcg, bpf_core_enum_value(enum vm_event_item, PGFAULT));
>   
>   	bpf_put_mem_cgroup(memcg);
>   

Reviewed-by: JP Kobryn <jp.kobryn@linux.dev>
