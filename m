Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6CC2D73AE
	for <bpf@vger.kernel.org>; Mon, 26 Jan 2026 20:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769459987; cv=none; b=M0AuSzH/UIcUlhARwdo28+qr62OkU7r/VDL+evDY91tbHwM7Paw/So2M6zPWCylFExbEAGTVxDA4+Qdq61mL/d2dnm0XxOD9vY+q7WWvbwHqET4Q1zezKo1xMeDX5el6iwYDDobotPY+CrghhWeDsiDp3+os/ry3kb2mckQ973g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769459987; c=relaxed/simple;
	bh=kkf7NqrkjU5TqFeW2lMIJ5TO7CcGz101l1cH1huc2G4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G178/S+y/n03y1uvwX0kR1Tl2DQwYEU2eX8sdj506qOQWf9+NKXUlJFYTAmRaFeQUPScOCoj4yaXTa7QvEYtAfk605mgET2oVCGHCJp2E6DawyDKJVNx3l6TwppAWCLs/JFeKG+vQb3ibuIqIfjJqboKlURfyFqF+T8Af4kPnRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N4v70e8w; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N4v70e8w"
Message-ID: <0575e8ab-7a70-48a4-b316-ef22fd8cece5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769459973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e79RITJIhc5qxeAFI/7Q2nKmsRKOeygwd2fSS3l+wYs=;
	b=N4v70e8wAa1xE9p+MYmVOYUx8y/9DRJZNscSuHvn7Mbcv0tIm/+jnB504vC80ZClRhxYUH
	jRQiJIEsmD9Pl4F4LMiDb2YFKY6fKwQHwpgqvBo2E0lfbQQtn0tywn8M6hV2FevDysLFcL
	DU0Qom1hL2Aopvvc1aKh0h/VLazJiGE=
Date: Mon, 26 Jan 2026 12:39:27 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Harden cpu flags test for
 lru_percpu_hash map
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-patches-bot@fb.com, bpf@vger.kernel.org
References: <20260119133417.19739-1-leon.hwang@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260119133417.19739-1-leon.hwang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/19/26 5:34 AM, Leon Hwang wrote:
> Harden the test against this behavior by provisioning sufficient spare
> elements. Set max_entries to 'nr_cpus * 2' and restrict the test to using
> the first nr_cpus entries, ensuring that updates do not spuriously trigger
> LRU eviction.

[ ... ]

@ -300,7 +307,7 @@ static void test_percpu_map_cpu_flag(enum 
bpf_map_type map_type)
>   	if (!ASSERT_GT(nr_cpus, 0, "libbpf_num_possible_cpus"))
>   		return;
>   
> -	max_entries = nr_cpus + 1;
> +	max_entries = nr_cpus * 2;
>   	keys = calloc(max_entries, key_sz);

Does it need to allocate "nr_cpus * 2" number of keys while only first 
nr_cpus entries are used? This can be a followup if it's needed. Applied 
to start getting signal from CI.
