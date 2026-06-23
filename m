Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1F43911C9
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 04:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782187456; cv=none; b=s6cYkdA374s/YAF8RUYJHeE3k9HTDDxQwkIthrFipeqsdULe100I+TcOuIbOtuNQwHfp4GW59e8MPErxOQOl5YLiKnFOx6JqQN6N0NIhswbVGCfRsvjVHnJQlknQOkFP5Kl3q5xG6H24DDgvpoEn2lRIePeLKbeXRAnIfeNkYfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782187456; c=relaxed/simple;
	bh=XERz1UHjgNjBqQ6T8Dbot+hJmy/bNOImrf6pcgK8a8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jMAhuZnKKtizhkpdi7QE+Ebh8I0ZoTaDLR4dELEFG6ctoEWb4mmLwPludyuC1szWMVDQGZ0pzuuNkXkcBSiGlLwJs/xfKvZVGGPiXhlEVSjSO8Jx6UgzzneN0VgzsmlGTpJs6dQo7p5yTX2Dz1j/63g1+86Dm4AeTY2ASa7HjfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eoflhPeI; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eoflhPeI"
Message-ID: <6c0bc7ef-90b9-450d-969d-b7e0bc5932f8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782187453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FXgqgcLUNk30tsOF9zOvFJ97I+Q8sltRYGN6ogC6q6k=;
	b=eoflhPeIvwbsnaKhB2VgIcw69wqgNkcbxQJSgVmvbx1voUK9riEKJzqPB9bYTqFZI5+lXK
	kc2/9Z2Z+nieitEwG/e+cO+xBKmJT4kOmoDnVZu7JvcK2ghLHdJqrdE2eAgyfVaueqOL5M
	K05pL3Ik03gLyjpJuZ6u8CV8L50sA+s=
Date: Tue, 23 Jun 2026 12:04:07 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 08/11] selftests/bpf: Add tests to verify
 global percpu data
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260622143557.22955-1-leon.hwang@linux.dev>
 <20260622143557.22955-9-leon.hwang@linux.dev>
 <20260622145733.A049A1F000E9@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260622145733.A049A1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 22/6/26 22:57, sashiko-bot@kernel.org wrote:
[...]
>> diff --git a/tools/testing/selftests/bpf/prog_tests/global_percpu_subskel.c b/tools/testing/selftests/bpf/prog_tests/global_percpu_subskel.c
>> new file mode 100644
>> index 0000000000000..8aebd533d86b5
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/global_percpu_subskel.c
> [ ... ]
>> +void test_global_percpu_data_subskel(void)
>> +{
>> +	struct test_global_percpu_data *subskel = NULL;
>> +	struct bpf_object *obj;
>> +	int i;
> [ ... ]
>> +	if (!ASSERT_OK_PTR(subskel->subskel, "subskel"))
>> +		goto out;
>> +	if (!ASSERT_OK_PTR(subskel->maps.percpu, "maps.percpu"))
>> +		goto out;
>> +	ASSERT_EQ(bpf_map__type(subskel->maps.percpu), BPF_MAP_TYPE_PERCPU_ARRAY,
>> +		  "percpu_map_type");
>> +	ASSERT_GT(subskel->subskel->var_cnt, 0, "var_cnt");
> 
> [Severity: Medium]
> Will this assertion cause the test to unconditionally fail?
> 

Luckily, no.

> Looking at test_global_percpu_data.c, all defined variables are placed
> in the .percpu section. Since bpftool explicitly skips .percpu maps when
> generating subskeletons, there appear to be no non-percpu maps with BTF
> variables present.
> 
> If that is the case, subskel->subskel->var_cnt will be exactly 0, causing
> this check to evaluate to ASSERT_GT(0, 0) and reliably fail the test.
> 

Looking at test_global_percpu_data.c, there are 5 non-percpu global
variables, which were added in patch #11.

volatile const __u32 num_cpus = 0;
volatile const int offsetof_num;
volatile const int elem_sz;
__u32 percpu_data_sum = 0;
bool run_iter = false;

So, subskel->subskel->var_cnt will be 5.

In the generated test_global_percpu_data.subskel.h:
        /* vars */
        s->var_cnt = 5;


Thanks,
Leon

>> +
>> +	for (i = 0; i < subskel->subskel->var_cnt; i++) {
>> +		const struct bpf_var_skeleton *var;
> [ ... ]
> 

