Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711695;
	b=420IbvTO+551JfWy0HDvuFJCnZpYoGB1QTw4wCOtyZGeSbYN4V2+YXU9UrSI7Hy3MyKf
	 yL2vS66z0A9HbZdgX89t90VcvZL+pib0AXmTRqPfekC+bfRE3cIsbGMzHMjPed5+Wyz1M
	 PjnoLDJnkKlJnXuw5p568SmnY7A7S/z3BoTYc8X5GP8VpRTo8eqQm3v1ap1CFKBVeBrAB
	 ZaSGzGT4XjQA6vAe7V9GkwYn9nii/sbqemfUnNIG1KuBezrRk24p3Y07RvAMSjs5OFUB0
	 46HnnF8pL1MlkfNaWxIZTZMutsPM35/uadgKvOOQRzrIoTQx3LCboEhWkGpi2EBaB1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711695;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=OfIZX0zVNkUweF251bj/CyePsa3O8Tj5vZPXXxbgpT4=;
	b=Eo9er7C+zOdbKycKixMxaut5bgH1PKTcnblRyN5hqxtOAk/6bhXgr8dxxTSJ/PLpv0Kv
	 7JvKjKTPVrx4AlBVH7fE+4YtHT0buswmkmYSdmmK5GiC0mAs3x0vBbueFEQ8ZHtKg3saY
	 VFdXjzHNtZCd9eSGctoDR/G7iP5vbgJcP5hi3je72z91slA9pQPfhtq6EY57tTjaDaMmF
	 jEXtCqHnlZ+TjhC+qA53gYa17zSTkHSpyoOZqqlgXvqvjc3LhHBVfvXRDPVSMZH0yfHNO
	 ZK2q9ngg9XuXnQug2L5MAkf1hxfR1fjQOeMbE2+MQytX2tU2OWg2+Yy17VUdRU/Mnig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=aPyANorZ;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD2F606A32E;
	Tue,  3 Nov 2026 13:14:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DD2F606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=aPyANorZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=OfIZX0zVNkUweF251bj/CyePsa3O8Tj5vZPXXxbgpT4=; t=1793711693; x=2109071693; 
	b=aPyANorZh63yM/FrwdVoSsfpqVGJR7ln3r1YWP1WFuM9JZ1Bb1FKHk2hS8xE9N218c6bpZVMqJP
	m7ij8wzZ/NnXNcJaJoXQ38JewZtADbJ5ClxSQnBADLKRkJv+iAMMnRex7PVgQcxjHr/7blIrFpNPM
	/jOu9kNbRxMz74Fel5zHD9s4XyG9x3HOt62dni+AihnVuhimTRGDP6uaEFp/ZtV6AIpxzF1LBMl99
	Cyb4Ic+gN5Oc787xgH3vXVdEDJQggmKXzSP9EWph/OmuxhcLEGDHB0cMnmAKc+lpYJCm8b/D6JFDz
	CPqeyka2y+2aWXsk33ve5LMHmqL6uZnMdoug==;
Received: from [58.29.145.179] (helo=[192.168.8.237])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1xOELd-001F3u-LJ; Tue, 03 Nov 2026 14:14:45 +0100
Message-ID: <07681b2b-3960-4866-affd-43ec7190a14e@igalia.com>
Date: Tue, 3 Nov 2026 22:14:37 +0900
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
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: libarena: Order equal rbtree
 keys FIFO
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
 <20261028060046.549097-2-changwoo@igalia.com>
 <DMKK7WGBASS7.2VBQTIIX6YEGS@etsalapatis.com>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <DMKK7WGBASS7.2VBQTIIX6YEGS@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Emil,

Thanks for the review.

On 11/2/26 4:51 PM, Emil Tsalapatis wrote:
> On Wed Oct 28, 2026 at 6:00 AM UTC, Changwoo Min wrote:
>> An RB_DUPLICATE tree links a new key to the left of an equal one, so
>> rb_least() and rb_pop() return the newest of several equal keys. A
>> queue of tasks keyed by vtime should instead serve equal keys in
>> arrival order, as sched_ext's vtime-ordered DSQs do.
>>
>> Send equal keys right on insert, as the kernel's rb_add() does. A new
>> node then lands after every node with an equal key. Rotations and
>> removals preserve the in-order sequence, so equal keys stay in
>> insertion order without a tie-break field.
>>
>> Add a selftest that interleaves equal keys while the tree grows and
>> checks the pop order.
>>
>> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> 
> Hi Changwoo,
> 
>    Patch looks fine to me, one nit below.
> 
>> ---
>>   .../bpf/libarena/include/libarena/rbtree.h    |  6 +--
>>   .../bpf/libarena/selftests/test_rbtree.bpf.c  | 37 +++++++++++++++++++
>>   .../selftests/bpf/libarena/src/rbtree.bpf.c   | 16 +++++---
>>   3 files changed, 51 insertions(+), 8 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h b/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h
>> index 486428911d96..00e63b12d82e 100644
>> --- a/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h
>> +++ b/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h
>> @@ -45,9 +45,9 @@ enum rbtree_alloc {
>>    * the existing node.
>>    *
>>    * RB_DUPLICATE: Allow nodes with identical keys in the rbtree.
>> - * Finding/popping/removing a key acts on any of the nodes
>> - * with the appropriate key - there is no ordering by time
>> - * of insertion.
>> + * Nodes with identical keys are kept in insertion order, so
>> + * rb_least() and rb_pop() return the oldest of them. Finding
>> + * or removing by key acts on any of them.
>>    */
>>   enum rbtree_insert_mode {
>>   	RB_DEFAULT,
>> diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
>> index 856c484a009a..1e2a0fac1e4f 100644
>> --- a/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
>> +++ b/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
>> @@ -248,6 +248,43 @@ __weak int test_rbtree_duplicate(void)
>>   	return rb_destroy(rbtree);
>>   }
>>   
>> +#define FIFO_NR_NODES	64
>> +#define FIFO_NR_KEYS	4
>> +
>> +SEC("syscall")
>> +__weak int test_rbtree_duplicate_fifo(void)
>> +{
>> +	const u64 per_key = FIFO_NR_NODES / FIFO_NR_KEYS;
>> +	struct rbtree __arena *rbtree;
>> +	u64 key, value;
>> +	int ret, i;
>> +
>> +	rbtree = rb_create(RB_ALLOC, RB_DUPLICATE);
>> +	if (!rbtree)
>> +		return 1;
>> +
>> +	for (i = 0; i < FIFO_NR_NODES && can_loop; i++) {
>> +		ret = rb_insert(rbtree, i % FIFO_NR_KEYS, i);
>> +		if (ret)
>> +			return 2;
>> +	}
>> +
>> +	for (i = 0; i < FIFO_NR_NODES && can_loop; i++) {
>> +		ret = rb_pop(rbtree, &key, &value);
>> +		if (ret)
>> +			return 3;
>> +
>> +		/* All of key 0 in insertion order, then all of key 1, ... */
>> +		if (key != i / per_key)
>> +			return 4;
>> +
>> +		if (value != key + FIFO_NR_KEYS * (i % per_key))
>> +			return 5;
>> +	}
>> +
>> +	return rb_destroy(rbtree);
>> +}
>> +
>>   static inline int
>>   clean_up_noalloc_tree(struct rbtree __arena *rbtree)
>>   {
>> diff --git a/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c b/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c
>> index 7f0f6dc3e17d..e6c9430f734b 100644
>> --- a/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c
>> +++ b/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c
>> @@ -161,8 +161,14 @@ struct rbnode __arena *rbnode_find(struct rbnode __arena *subtree, u64 key)
>>   	return node;
>>   }
>>   
>> +/*
>> + * Find the node to link @key under. Smaller keys go left and everything else
>> + * right, so a new key lands after every node with an equal key and equal keys
>> + * stay in insertion order. Rotations and removals preserve the in-order
>> + * sequence, so they keep that order too.
>> + */
> 
> I think this description is more harm than good let's remove it. Can we also keep the
> old name? The new one sounds like we're inserting a parent.

Sure, I will drop the comment and keep the original name in v2 as you
suggested.

Regards,
Changwoo Min
> 
>>   static
>> -struct rbnode __arena *rbnode_least_upper_bound(struct rbnode __arena *subtree, uint64_t key)
>> +struct rbnode __arena *rbnode_insert_parent(struct rbnode __arena *subtree, uint64_t key)
>>   {
>>   	struct rbnode __arena *node = subtree;
>>   	int dir;
>> @@ -171,7 +177,7 @@ struct rbnode __arena *rbnode_least_upper_bound(struct rbnode __arena *subtree,
>>   		return NULL;
>>   
>>   	while (can_loop) {
>> -		dir = (key <= node->key) ? 0 : 1;
>> +		dir = (key < node->key) ? 0 : 1;
>>   
>>   		if (!node->child[dir])
>>   			break;
>> @@ -255,7 +261,7 @@ int rb_node_insert(struct rbtree __arena *rbtree,
>>   	if (rbtree->insert != RB_DUPLICATE)
>>   		parent = rbnode_find(parent, key);
>>   	else
>> -		parent = rbnode_least_upper_bound(parent, key);
>> +		parent = rbnode_insert_parent(parent, key);
>>   
>>   	if (key == parent->key && rbtree->insert != RB_DUPLICATE) {
>>   		if (rbtree->insert == RB_UPDATE) {
>> @@ -278,8 +284,8 @@ int rb_node_insert(struct rbtree __arena *rbtree,
>>   	}
>>   
>>   	node->parent = parent;
>> -	/* Also works if key == parent->key. */
>> -	if (key <= parent->key)
>> +	/* An equal key goes right, after the existing ones. */
>> +	if (key < parent->key)
>>   		parent->left = node;
>>   	else
>>   		parent->right = node;
> 

