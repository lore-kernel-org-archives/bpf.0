Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6D730499A
	for <bpf@vger.kernel.org>; Mon,  2 Mar 2026 18:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772476053; cv=none; b=M6Oa8anHnmhkAm+zzBJrmWYen+ojywDLbc5bIcilelZEbYD/Vovk/VAQCQLDsNocM65g0RKYNjYIbgQPnYobVd4ekThtlpgaNFGCuukmNJRxYWwd6fRwZ2+Qy39GarP+tXrrPbZzr30C0HLrq6KBlCkI0gxQYRHua4lvtDibjnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772476053; c=relaxed/simple;
	bh=BdFJzu5emJv9dTvAWLyKOoNL81Cc1hzE3KwrVS0bq4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qePCnCitXaxMBWn6UiZKB6aHtlyc5lhLPqInWBOeg1FaS2Hau6szaqJzonBLwdmJ6cIwO6v6pAqz6qsiOKbZYPH8inDN06k9irDXJGKd8LajSz59BGAtT3d19g/8OmvNbYeGNWbc/fzibMptBtUNr/E+4d+80hUEYvtub6jpbO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SP9WaUib; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SP9WaUib"
Message-ID: <ea103a43-7192-4c00-b837-c85ebba6f9b1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772476040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QZP30HVE2qfuNyrPBqZl8V1Ig0caHRkDPE55WWDj3+I=;
	b=SP9WaUibvCr02TxS/rYaqUAmYtel7Bg8K7GueawK5vazwc4m1yW8Ze5VyqiugKUyPoc8va
	GXjKmpgwlKdu3hSBm0VJwHz3SQcg92WAfI20+Jl8lbH8y3mTeKlVwQOy7hX6LSiU8wPsyB
	YiYhftgYUVb7bfpni3BucHxc9cnF7mQ=
Date: Mon, 2 Mar 2026 10:27:09 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 3/3] selftests/bpf: Check
 bpf_mem_cgroup_page_state return value
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
 <c6b0c44062f614ddeaae26b17e3a4f1876a9f9ed.1772270591.git.zhuhui@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "JP Kobryn (Meta)" <jp.kobryn@linux.dev>
In-Reply-To: <c6b0c44062f614ddeaae26b17e3a4f1876a9f9ed.1772270591.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/28/26 1:25 AM, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
> 
> When back-porting test_progs to different kernel versions, I encountered
> an issue where the test_cgroup_iter_memcg test would falsely pass even
> when bpf_mem_cgroup_page_state() failed.
> 
> This patch adds explicit checks to ensure bpf_mem_cgroup_page_state()
> doesn't return -1 before validating the actual statistics values.
> 
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> ---
>   .../selftests/bpf/prog_tests/cgroup_iter_memcg.c       | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c b/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
> index 88fc3e83d2b7..9eadfbd3fdb9 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
> @@ -53,6 +53,8 @@ static void test_anon(struct bpf_link *link, struct memcg_query *memcg_query)
>   	if (!ASSERT_OK(read_stats(link), "read stats"))
>   		goto cleanup;
>   
> +	ASSERT_NEQ(memcg_query->nr_anon_mapped, (unsigned long)-1,
> +		  "bpf_mem_cgroup_page_state NR_ANON_MAPPED");
>   	ASSERT_GT(memcg_query->nr_anon_mapped, 0, "final anon mapped val");
>   
>   cleanup:
> @@ -88,6 +90,10 @@ static void test_file(struct bpf_link *link, struct memcg_query *memcg_query)
>   	if (!ASSERT_OK(read_stats(link), "read stats"))
>   		goto cleanup_map;
>   
> +	ASSERT_NEQ(memcg_query->nr_file_pages, (unsigned long)-1,
> +		  "bpf_mem_cgroup_page_state NR_FILE_PAGES");
> +	ASSERT_NEQ(memcg_query->nr_file_mapped, (unsigned long)-1,
> +		  "bpf_mem_cgroup_page_state NR_FILE_MAPPED");
>   	ASSERT_GT(memcg_query->nr_file_pages, 0, "final file value");
>   	ASSERT_GT(memcg_query->nr_file_mapped, 0, "final file mapped value");
>   
> @@ -119,6 +125,8 @@ static void test_shmem(struct bpf_link *link, struct memcg_query *memcg_query)
>   	if (!ASSERT_OK(read_stats(link), "read stats"))
>   		goto cleanup;
>   
> +	ASSERT_NEQ(memcg_query->nr_shmem, (unsigned long)-1,
> +		  "bpf_mem_cgroup_page_state NR_SHMEM");
>   	ASSERT_GT(memcg_query->nr_shmem, 0, "final shmem value");
>   
>   cleanup:
> @@ -144,6 +152,8 @@ static void test_pgfault(struct bpf_link *link, struct memcg_query *memcg_query)
>   	if (!ASSERT_OK(read_stats(link), "read stats"))
>   		goto cleanup;
>   
> +	ASSERT_NEQ(memcg_query->pgfault, (unsigned long)-1,
> +		  "bpf_mem_cgroup_vm_events PGFAULT");
>   	ASSERT_GT(memcg_query->pgfault, 0, "final pgfault val");
>   
>   cleanup:

Emil mentioned in the v3 thread that we don't need these checks [0]. I
agree. Now that you're using the bpf co-re enum helpers, the stat
indexes won't become an issue in a cross-kernel secenario. This patch
can be dropped.

[0] 
https://lore.kernel.org/bpf/DGQXZVBSVEUP.35P5G9QOL9EAT@etsalapatis.com/T/#m7cb6edf90ed4daaeda38b746363317405f198f20
