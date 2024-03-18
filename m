Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C62B52F86
	for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 16:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710778085; cv=none; b=O8MF3UoySawz5woyzZEXQLyeujXJgCkk6svmog/x7/chC6a2FLKnYZ4GQW2xSl8aEw6mnDxRgSaTm2VWYoWAPSIGx4ut7TFSQ0IBoyVic3LMyuWVzqSz70R8vbDoq7k7LDuZ7BBsGwmCV8VjAskO7H+O2CkXBP62coye2raGgqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710778085; c=relaxed/simple;
	bh=XftcC/cufe2hINAjtjXcT+EDnMGkcOcgTjiPHmt1bdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TtPf3l/ROUEyi9U5MW6vJbG2ppwXMGBzQ5EJsqBxErDgOoT6HBIKodSlrEammvfyn77EeqmhuiElkrShtRcPzzji+TaEVfjGL/Q96pj84C1IN+WYyTq8HX9YFVq9IBguhSkQV7WSScu7CH4wX3f+aIph1bwLZyhPOpcxY92Ozyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oJTRsKNq; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oJTRsKNq"
Message-ID: <b849aa68-0f7e-455f-ba09-ff1c811db771@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710778080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fwQPOjQn9KdVqbATUorSxLxTcDNlvestQijqzOe8SZs=;
	b=oJTRsKNqqrV1j8KZgt32XH+1pFyT52699CiQPGgQObTaFqP2snDQkONaqHQowRki3F02UT
	Ot7SfvR0evdgnzE9g6SieZbM/2LB+WWHiDQHEYMQB6c/0rjMAEDcjN345VbRKCPLUWkAZm
	SSoTLg4fBa37DH+apsl7WP7A/2CObTM=
Date: Mon, 18 Mar 2024 09:07:54 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next V2] bpf/lpm_trie: inline longest_prefix_match for
 fastpath
Content-Language: en-GB
To: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 Daniel Borkmann <borkmann@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>, martin.lau@kernel.org,
 netdev@vger.kernel.org, bp@alien8.de, kernel-team@cloudflare.com
References: <171076828575.2141737.18370644069389889027.stgit@firesoul>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <171076828575.2141737.18370644069389889027.stgit@firesoul>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 3/18/24 6:25 AM, Jesper Dangaard Brouer wrote:
> The BPF map type LPM (Longest Prefix Match) is used heavily
> in production by multiple products that have BPF components.
> Perf data shows trie_lookup_elem() and longest_prefix_match()
> being part of kernels perf top.
>
> For every level in the LPM tree trie_lookup_elem() calls out
> to longest_prefix_match().  The compiler is free to inline this
> call, but chooses not to inline, because other slowpath callers
> (that can be invoked via syscall) exists like trie_update_elem(),
> trie_delete_elem() or trie_get_next_key().
>
>   bcc/tools/funccount -Ti 1 'trie_lookup_elem|longest_prefix_match.isra.0'
>   FUNC                                    COUNT
>   trie_lookup_elem                       664945
>   longest_prefix_match.isra.0           8101507
>
> Observation on a single random machine shows a factor 12 between
> the two functions. Given an average of 12 levels in the trie being
> searched.
>
> This patch force inlining longest_prefix_match(), but only for
> the lookup fastpath to balance object instruction size.
>
> In production with AMD CPUs, measuring the function latency of
> 'trie_lookup_elem' (bcc/tools/funclatency) we are seeing an improvement
> function latency reduction 7-8% with this patch applied (to production
> kernels 6.6 and 6.1). Analyzing perf data, we can explain this rather
> large improvement due to reducing the overhead for AMD side-channel
> mitigation SRSO (Speculative Return Stack Overflow).
>
> Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>

I checked out internal PGO (Profile-Guided Optimization) kernel and
it did exactly like the above described: longest_prefix_match() is inlined
to trie_lookup_elem(), but not others.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   kernel/bpf/lpm_trie.c |   18 +++++++++++++-----
>   1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
> index 050fe1ebf0f7..939620b91c0e 100644
> --- a/kernel/bpf/lpm_trie.c
> +++ b/kernel/bpf/lpm_trie.c
> @@ -155,16 +155,17 @@ static inline int extract_bit(const u8 *data, size_t index)
>   }
>   
>   /**
> - * longest_prefix_match() - determine the longest prefix
> + * __longest_prefix_match() - determine the longest prefix
>    * @trie:	The trie to get internal sizes from
>    * @node:	The node to operate on
>    * @key:	The key to compare to @node
>    *
>    * Determine the longest prefix of @node that matches the bits in @key.
>    */
> -static size_t longest_prefix_match(const struct lpm_trie *trie,
> -				   const struct lpm_trie_node *node,
> -				   const struct bpf_lpm_trie_key_u8 *key)
> +static __always_inline
> +size_t __longest_prefix_match(const struct lpm_trie *trie,
> +			      const struct lpm_trie_node *node,
> +			      const struct bpf_lpm_trie_key_u8 *key)
>   {
>   	u32 limit = min(node->prefixlen, key->prefixlen);
>   	u32 prefixlen = 0, i = 0;
> @@ -224,6 +225,13 @@ static size_t longest_prefix_match(const struct lpm_trie *trie,
>   	return prefixlen;
>   }
>   
> +static size_t longest_prefix_match(const struct lpm_trie *trie,
> +				   const struct lpm_trie_node *node,
> +				   const struct bpf_lpm_trie_key_u8 *key)
> +{
> +	return __longest_prefix_match(trie, node, key);
> +}
> +
>   /* Called from syscall or from eBPF program */
>   static void *trie_lookup_elem(struct bpf_map *map, void *_key)
>   {
> @@ -245,7 +253,7 @@ static void *trie_lookup_elem(struct bpf_map *map, void *_key)
>   		 * If it's the maximum possible prefix for this trie, we have
>   		 * an exact match and can return it directly.
>   		 */
> -		matchlen = longest_prefix_match(trie, node, key);
> +		matchlen = __longest_prefix_match(trie, node, key);
>   		if (matchlen == trie->max_prefixlen) {
>   			found = node;
>   			break;
>
>
>
