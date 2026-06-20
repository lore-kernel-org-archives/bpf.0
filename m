Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D0933F591
	for <bpf@vger.kernel.org>; Sat, 20 Jun 2026 17:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781978022; cv=none; b=abHrb3Ed1xBJf5H/fr8O6TeEAlycnaz3+PwmnZecQgpRfpVsaD0kNb5ZncQN6HU5kw4r2wNNjvzaXVIou02oTdVdTsKxv/iuiKEOfAVevHm8vggdUx0e8lLcMGIBdLPoLhC0mAS+x/BELu8DHn9AvO2olA/yiGELxdrX8GeAJLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781978022; c=relaxed/simple;
	bh=OB+K36Bn91JFhcjMiwQQVfC1O3Jid3HjJTbNH9Ejm14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XJwdoiFwStXwR3qKyF+63k6De1d4+ME4/i/fRTQ25bfbumAHNRmbqUjErGvmG6HvdHKadXhmWF6tjVRbJZOrsEEG339wqCrC4VN6bN+xvrN+epDIMhlShNMXQRqEH5i7ejHFEn2LG+nmkrDedbueSlkfO63mKCnrJ16sZyyGIsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lRd0rsHB; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lRd0rsHB"
Message-ID: <173eddc1-22d3-4edc-8561-b4614bb13278@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781978017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MNKVQCh3T6Uw40yD3OB3B2LeMgBhIBxgFvI2mCEQ3us=;
	b=lRd0rsHBKeUX2mAMquiB4zRG7tESkz3SP7haa23CYqO4fjTeaoGPE36jkd6QbZ2hEaCS4h
	QQO1S018Mv0faWLi4GfRxzuYsab5GQYfXtHoITvkT8eDVsT5xXk674ntbDsY/NhZ1DXlUW
	1eTdGOjVz+VicXetMvuj5BcKmfjavio=
Date: Sat, 20 Jun 2026 10:53:32 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] bpf: Allow type tag BTF records to succeed
 other modifier records
Content-Language: en-GB
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, memxor@gmail.com,
 daniel@iogearbox.net, eddyz87@gmail.com, mattbobrowski@google.com,
 Vineet Gupta <vineet.gupta@linux.dev>,
 "Jose E. Marchesi" <jose.marchesi@oracle.com>,
 David Faust <david.faust@oracle.com>
References: <20260616061454.7869-1-emil@etsalapatis.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260616061454.7869-1-emil@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/15/26 11:14 PM, Emil Tsalapatis wrote:
> As of recently, Clang is able to attach type tag records to modifier BTF
> records. This is useful for using typedefs that encompass a base type

Please add the following link in the commit message:
     https://github.com/llvm/llvm-project/pull/203089

The above 'clang is able to attach type tag records to modifier BTF records'
is not precise. The context for this requires typedef.

> and a type tag, e.g.:
>
> typedef struct rbtree __arena rbtree_t;
>
> Modify btf_check_type_tags() so that it allows this sequence of records.
> The function now only checks for record loops in BTF modifier record
> chains. Rename to btf_check_modifier_chain_length to reflect this.

Currently, for clang, the typetag is always right after typedef, e.g.,

     typedef struct rbtree __arena const rbtree_t
        => typedef -> __arena -> const -> struct rbtree
     typedef const struct rbtree __arena rbtree_t
        => typedef -> __arena -> const -> struct rbtree
     typedef struct rbtree const __arena rbtree_t
        => typedef -> __arena -> const -> struct rbtree

gcc has not yet implemented this (typedef struct rbtree __arena rbtree_t).
Not sure whether gcc will follow the above clang pattern or
it may generate something like
     typedef -> const -> __arena -> struct rbbree
or not.

But considering gcc also follows pattern like
     ptr -> __arena -> const -> struct rbtree
likely in the future they may support like
     typedef -> __arena -> const -> struct rbtree

Maybe we should keep similar ordering ('ptr -> __arena' => 'typedef -> __arena')?

Jose, David, what do you think?

>
> Also expand the BTF modifier traversal code to take into account that
> type record can be interleaved with other modifier records. In effect
> this means traversing all modifiers to collect the type tags.
>
> Also modify existing selftests to now accept modifier records (const,
> typedef) that point to type tag records.
>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: Vineet Gupta <vineet.gupta@linux.dev>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>
> Changelog v1->v2:
>
> - Factor main type tag walk into a separate function (Eduard). The
>    change makes certain code paths now more permissive (unrecognized tags
>    do not cause an error for kptrs, and we can have multiple instances of
>    the same tag), but imo handling those edge cases was a grey area in the
>    first place and it is better to consistently scan type tags the same
>    way everywhere.
>
>   kernel/bpf/btf.c                             | 209 +++++++++++--------
>   tools/testing/selftests/bpf/prog_tests/btf.c |  12 +-
>   2 files changed, 125 insertions(+), 96 deletions(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index ef4402274786..4ba2ff132503 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -28,6 +28,7 @@
>   #include <linux/string.h>
>   #include <linux/sysfs.h>
>   #include <linux/overflow.h>
> +#include <linux/bitops.h>
>   
>   #include <net/netfilter/nf_bpf_link.h>
>   
> @@ -3472,12 +3473,69 @@ static int btf_find_struct(const struct btf *btf, const struct btf_type *t,
>   	return BTF_FIELD_FOUND;
>   }
>   
> +struct btf_type_tag_match {
> +	const char *name;
> +	u32 flag;
> +};
> +
> +struct btf_type_tag_walk_ctx {
> +	const struct btf_type *t;	/* Input/Output */
> +	u32 id;				/* Output */
> +	u32 res;			/* Output */
> +};
> +
> +static int btf_type_tag_walk(const struct btf *btf,
> +			     struct btf_type_tag_walk_ctx *ctx,
> +			     const struct btf_type_tag_match *matches,
> +			     u32 match_cnt)
> +{
> +	const struct btf_type *t = ctx->t;
> +	u32 res = 0;
> +	const char *tag;
> +	u32 id, i;
> +
> +	do {
> +		id = t->type;
> +		t = btf_type_by_id(btf, id);
> +
> +		if (!btf_type_is_modifier(t))
> +			break;
> +
> +		if (!btf_type_is_type_tag(t) || btf_type_kflag(t))
> +			continue;
> +
> +		tag = __btf_name_by_offset(btf, t->name_off);
> +		for (i = 0; i < match_cnt; i++) {
> +			if (strcmp(tag, matches[i].name))
> +				continue;
> +			res |= matches[i].flag;
> +			break;
> +		}
> +	} while (true);
> +
> +	/* We only support a single tag. */
> +	if (hweight32(res) > 1)
> +		return -EINVAL;
> +
> +	ctx->t = t;
> +	ctx->id = id;
> +	ctx->res = res;
> +
> +	return 0;
> +}
> +

[...]

