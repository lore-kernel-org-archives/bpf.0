Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711733;
	b=yKbHTQlOeWoF8QtYhoJ1XW1JA/kHOfrcz7iQe0/t1fpyEheiZPsOaU3Lis7bC7dr0mTp
	 4/wmdfjKboJhF1V0Sm6uWfF7j0LH0A/Wzs1lsiS/CVAkWAD5MeX+hLUpMprX7TqPCYmxg
	 /98St4HDii+lvjnS19dAsufhaK1Rsaj0Xz6lg2aN5gwiPy6EkNg7ysjR4gkQmd4eGgefx
	 uah0DfGIpYzUUAwPLaIIWYMDx2gCIFLvCbqG4S6EClr8ZXXaENXlDXVrNxTW/nYnFH6VO
	 W7HHuD8HzxynZN32dHi9agvzExsmRc0W5QKEBmFP40CyaQzH/dTYa12DU8uCPvkCo+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711733;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=iQyUbsIr1eaHQc2Hjl2d87Wsi2zieh9fyDAeTXMlsuY=;
	b=RytnIp68yYCZKYLhVU6oN/FJ5qpInrTn1N1bVo8xDfP3PDupgyNeilv5M8twNKwZeGr6
	 eX+ObV72GHXOwQ+PumMiBLEhn5EGrjnre8LlSeDWbOlOHwU/ytjw5M/rY1rKkJMramSkA
	 r6C9hWPrD3ofWE+LhVu31yjfleIt+1rDWvrpDZh26fSm13sCVMXo732n9feA0UKQJ72BH
	 66mxYPAYsutQrq9KpsWjm30Ldu8xBmwnjEIK5y3RG4TRZ7tb2bOiIhFxMieKnpPeYg0Hm
	 uiHYPvYfpKZ6koFcU8JIXkEo30fksBCmCuihowKwI9ywtNhTOyZQWamszZo5PC8KEoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=XLsQboEs;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8388606A326;
	Tue,  3 Nov 2026 13:15:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8388606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=XLsQboEs
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=iQyUbsIr1eaHQc2Hjl2d87Wsi2zieh9fyDAeTXMlsuY=; t=1793711731; x=2109071731; 
	b=XLsQboEsX5/FQQBVlTFM59rbOb69QRWC55e+jTWAXKxJqatwyVu9yWqZY6U61G9XmYKRKnvolIV
	Z2/hAwmq+ekvP7aPKecHnem6fLoaytDZVs84PN8bxGn4idLXyeIEJ0enFDMOMGDFdo68rhgI/bUyg
	+HgArplIxnj9GCzX87bTEPI8STIEQPmYDbDfbBhpcTBsoF71SxdHzgZ2VbBMzdXBjiMBrocFLzfT3
	TEfQ6uCX4W0OsfayANQU/GggH85fzOWwqipuTvwAmLjUI1HRJfpunRTM7qpJTr++inKVdedza1MRn
	evKjxxHROsGBGMPGYZmbZmBObrsYoiHV88Hw==;
Received: from [58.29.145.179] (helo=[192.168.8.237])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1xOEMF-001F7T-F9; Tue, 03 Nov 2026 14:15:23 +0100
Message-ID: <a82664f2-79a2-41c0-8dfe-4c7ccb1412e4@igalia.com>
Date: Tue, 3 Nov 2026 22:15:15 +0900
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: libarena: Add rb_next()
To: Emil Tsalapatis <emil@etsalapatis.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, david.dai@linux.dev,
 Gavin Guo <gavinguo@igalia.com>, bpf@vger.kernel.org,
 sched-ext@lists.linux.dev, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com
References: <20261028060046.549097-1-changwoo@igalia.com>
 <20261028060046.549097-4-changwoo@igalia.com>
 <DMKKK0ZLYSKU.3UZ614ZC9DH05@etsalapatis.com>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <DMKKK0ZLYSKU.3UZ614ZC9DH05@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/2/26 5:07 PM, Emil Tsalapatis wrote:
> On Wed Oct 28, 2026 at 6:00 AM UTC, Changwoo Min wrote:
>> Add rb_next(), the in-order successor through parent pointers.
>>
>> Add a selftest that walks a tree with repeated keys and checks the walk
>> against the order in which the head leaves the tree.
>>
>> Signed-off-by: Changwoo Min <changwoo@igalia.com>
>> ---
>>   .../bpf/libarena/include/libarena/rbtree.h    | 23 ++++++++
>>   .../bpf/libarena/selftests/test_rbtree.bpf.c  | 54 +++++++++++++++++++
>>   2 files changed, 77 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h b/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h
>> index a8dd8c2e7596..956b4a24b52a 100644
>> --- a/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h
>> +++ b/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h
>> @@ -103,6 +103,29 @@ void rb_node_free(struct rbnode __arena *rbnode);
>>   
>>   int rb_integrity_check(struct rbtree __arena *rbtree);
>>   
>> +/*
>> + * Return the in-order successor of @node, or NULL if @node is the last one.
>> + * Walking from rb_first() with it visits the tree in key order, equal keys in
>> + * insertion order. Call it under the writer's lock.
>> + */
> 
> Let's move this to the main *.bpf.c file, with the rest of the traversal functions.

Sure. Will do in v2.

Regards,
Changwoo Min

> 
>> +static __always_inline struct rbnode __arena *rb_next(struct rbnode __arena *node)
>> +{
>> +	struct rbnode __arena *parent;
>> +
>> +	if (node->right) {
>> +		node = node->right;
>> +		while (node->left && can_loop)
>> +			node = node->left;
>> +		return node;
>> +	}
>> +
>> +	/* Climb until we leave a left subtree; its parent comes next. */
>> +	while ((parent = node->parent) && node == parent->right && can_loop)
>> +		node = parent;
>> +
>> +	return parent;
>> +}
>> +
>>   /*
>>    * Lockless reads of the head and the node count. They need not be called
>>    * under the writer's lock, so they are advisory: the tree may change before
>> diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
>> index 57c4395c046a..784cc9edea17 100644
>> --- a/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
>> +++ b/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
>> @@ -425,6 +425,60 @@ __weak int test_rbtree_first_update(void)
>>   	return rb_destroy(rbtree);
>>   }
>>   
>> +#define NEXT_NR_NODES	64
>> +
>> +static struct rbnode __arena *next_nodes[NEXT_NR_NODES];
>> +
>> +SEC("syscall")
>> +__weak int test_rbtree_next(void)
>> +{
>> +	struct rbtree __arena *rbtree;
>> +	struct rbnode __arena *node;
>> +	u64 seed = 0xcafe;
>> +	int i;
>> +
>> +	rbtree = rb_create(RB_NOALLOC, RB_DUPLICATE);
>> +	if (!rbtree)
>> +		return 1;
>> +
>> +	/* Pseudo-random keys with repeats, so the walk crosses equal keys. */
>> +	for (i = 0; i < NEXT_NR_NODES && can_loop; i++) {
>> +		/* LCG using Knuth's MMIX constants for determinism. */
>> +		seed = seed * 6364136223846793005ULL + 1442695040888963407ULL;
>> +		node = rb_node_alloc((seed >> 33) % 16, i);
>> +		if (!node)
>> +			return 2;
>> +
>> +		if (rb_insert_node(rbtree, node))
>> +			return 3;
>> +	}
>> +
>> +	node = rb_first(rbtree);
>> +	for (i = 0; i < NEXT_NR_NODES && can_loop; i++) {
>> +		if (!node)
>> +			return 4;
>> +
>> +		next_nodes[i] = node;
>> +		node = rb_next(node);
>> +	}
>> +
>> +	if (node)
>> +		return 5;
>> +
>> +	for (i = 0; i < NEXT_NR_NODES && can_loop; i++) {
>> +		node = rb_first(rbtree);
>> +		if (node != next_nodes[i])
>> +			return 6;
>> +
>> +		if (rb_remove_node(rbtree, node))
>> +			return 7;
>> +
>> +		rb_node_free(node);
>> +	}
>> +
>> +	return rb_destroy(rbtree);
>> +}
>> +
>>   struct rb_embed {
>>   	u64 pad;
>>   	struct rbtree tree;
> 

