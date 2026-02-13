Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40B72F85B
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 00:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770943301; cv=none; b=WIVDlKQFss3cThQb4UF3Holnnea2NeujjXpg1Ymmfb+apzHaun7b4esU9ligJcchc0TXa6RJn3358sSBSP2Z/7b0LwMr8CtB0FPLE+XkQ8wQnnltjigzCDORWWhRIocdIEuITTbf83G0GG6pKxgRPVePXbOh4a8oCXZDEcI2Reo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770943301; c=relaxed/simple;
	bh=6D8tgjI9PBm1BFXqhi50JPEsbcI0pqJf1KyyVtXlYsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bx8+OkFeUld3k9tfuDG8Zt+LOWcVUIxfrsCWF5Tkl+xauNm9SPs/LbSXe7ubfZmHNN5DVx25Dwx0Mrozmy8fLBOoSjaK3u3r9EIuDZ2n0/cyz04yFkgx0f/U7x8EE1LCd62J3nqodPvQInsKgq/uaAeushLANnVvXdgsf1yXDcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqMmRtrL; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqMmRtrL"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2baab3137bcso415705eec.0
        for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 16:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770943299; x=1771548099; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DwqSI1RFCMIyBtnekhVRj3/LtP3LLhrY9w2W+ftU2B8=;
        b=SqMmRtrLf2GRx7c0nMR9aamB/ORqM+JwkEn5N0Gq0gj50anx15gDCgRsACcacevOwP
         A8XcZuQFq9vdldl5KasK3szj4GJM1PWw5jr+UwVnHcIPniP46syn5WaKbKS9nqeD/u8a
         amL5UK1zMnv8/rLiuS6B+VPVlK5rOPvvt8Qy3SDF9YgfMkhbEJnXcO5W4Iy1PsL8zBRL
         ERlXAeGv472zt9Uwepr7y87W9eP5sMzPEjLFvo1Cy3f/OpdFQILX2VxJ7PqfHkWMyAtt
         hsgi31GcqGToy8ZPsbM1LQjpSwQ9w0Fmq2nEhx4kv3vFB5MhvxU8Ll591mFlsmSqzfBU
         VLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770943299; x=1771548099;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DwqSI1RFCMIyBtnekhVRj3/LtP3LLhrY9w2W+ftU2B8=;
        b=YNz9GvGMB/msxES7jqVrifm7l0IeGw/O9OwUBeNjMYAlSzh/De7/hsMt3EKyqRGwgW
         hbAufbeIw9655WNDVW1oCB4JdcGtlODBLDf7iyYHPoRZfoGtbCEAJBpOQ/mfQDEU9j0+
         ZKUe0Qfo7eQ22z6YlqGEUghlL6Gks+6+x8sRYD1zXbBVMIQS1HXzG7dMXAwTl6BuAOJa
         Y6ks2gGhvmFJgVQ5IEl/gh++XkN7j2ER7ASdwMGJN40B4P4IB+ULxFKl68VQ8i0AlbVA
         BZiFC37OZZCmMQtVJcvNGpA1vZETiOLcJmMrhYTufBfqlth+WIBnlJ8JZBHoXQtqw4Aj
         6rNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmOdIkxvetAnXlEXg3LsiyJ5B4Op7XtPuAAYSYv3hfdnvcT2/SBipvEfyGZOaNwVPm7js=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN4sfLq/XZIajzMVaejzGa7thHfXert+EtFY2VpMxOU0wgp7RG
	VcEzYsYyc40TDROKzO0xaCc0T3iEg0cg/NqYvHUJpiDiH/F8WdFGD/rN
X-Gm-Gg: AZuq6aK/4VQ32uN6kg94tq//6YbcHgf2KLondgF2ID0oS6J6qT5iNveFX18duPxedXk
	h4R0uKjnVrxohJ6ZpoQKYN+zRi0obQS8aZ9WzIe1iB+m6FzAgrdwm6S5chbaUv3umWGDXTmoUiB
	cu1bzCee/jTD2vZtw1pumqpOtz7JuSdzfMHejBuq/hsVBmWuUFqsUfhhUdj7mQcpOD7GTEq/9UR
	8PGXTDpkss8IvGxrEnnohgp+K0Bm1VCfDPCY144pd6KEqsqxizPZ0uK63+tcRRIiVTI5YYdHbkR
	7Ew3SBxKUwrx5WtfGIvLSMAwi4buBURsWPFkDu2N8Iv/bNbmQhcRU+MxhFjDRoMu58VF4FLpQVQ
	EACuIpoNhX/Q7Dxfc8x24tGsrVp4A/ZPhebGX2ZbSj0JAoeTNYN8ZYoWK+JY7NQsqlUny7KY2Z8
	u0dOCNRlfIUn+M8FqZp2GghFl9Sle01I6R
X-Received: by 2002:a05:7300:ca4:b0:2b7:857:db6a with SMTP id 5a478bee46e88-2babc47cb8amr28835eec.21.1770943298947;
        Thu, 12 Feb 2026 16:41:38 -0800 (PST)
Received: from [192.168.4.196] ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dcd0609sm5409175eec.16.2026.02.12.16.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 16:41:38 -0800 (PST)
Message-ID: <f587b319-fc6c-44f5-94b0-350c1aadaa3c@gmail.com>
Date: Thu, 12 Feb 2026 16:41:37 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Skip test_kmem when
 cgroup.memory=nokmem
To: Hui Zhu <hui.zhu@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Hui Zhu <zhuhui@kylinos.cn>, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <cover.1770883926.git.zhuhui@kylinos.cn>
 <2f6ee1db173b67a636b2caa85744cb4ce8114e64.1770883926.git.zhuhui@kylinos.cn>
Content-Language: en-US
From: "JP Kobryn (Meta)" <inwardvessel@gmail.com>
In-Reply-To: <2f6ee1db173b67a636b2caa85744cb4ce8114e64.1770883926.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/12/26 12:23 AM, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
> 
> When cgroup.memory=nokmem is set in kernel command line, kmem
> accounting is disabled and the test_kmem subtest will fail.
> 
> Add a check to skip this test when the parameter is present.
> 
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> ---
>   .../bpf/prog_tests/cgroup_iter_memcg.c        | 28 +++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c b/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
> index 13b299512429..203e6b091a21 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
> @@ -134,11 +134,39 @@ static void test_shmem(struct bpf_link *link, struct memcg_query *memcg_query)
>   	shm_unlink("/tmp_shmem");
>   }
>   
> +static bool cmdline_has(const char *arg)
> +{
> +	char cmdline[4096];
> +	int fd;
> +	ssize_t len;
> +	bool ret = false;
> +
> +	fd = open("/proc/cmdline", O_RDONLY);
> +	if (fd < 0)
> +		return false;
> +
> +	len = read(fd, cmdline, sizeof(cmdline) - 1);
> +	close(fd);
> +	if (len < 0)
> +		return false;
> +
> +	cmdline[len] = '\0';
> +	if (strstr(cmdline, arg))
> +		ret = true;
> +
> +	return ret;
> +}
> +
>   #define NR_PIPES 64
>   static void test_kmem(struct bpf_link *link, struct memcg_query *memcg_query)
>   {
>   	int fds[NR_PIPES][2], i;
>   
> +	if (cmdline_has("cgroup.memory=nokmem")) {
> +		test__skip();
> +		return;
> +	}

Instead of just skipping what if we proceed and then confirm we get a
zero value after the allocations?
