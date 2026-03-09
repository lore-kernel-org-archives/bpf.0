Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADDF2EC0AE
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 06:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773038728; cv=none; b=n37n7B1+H1zBQKULjtvSq6Ky4/083VKl2EQfJRKRl22E2IlP3kUx1iJI5ayWMsPmbSmpm0mlQOQzq9ZJ7jzmbuPKm0Bo3jdTDpUaIPQhWX1PnB9NoW5ks1V7KaXwmDOp4VRjgtnYk02RksjURoKrtOteyZ6BEdAn74X+VE3o7AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773038728; c=relaxed/simple;
	bh=EVBvanOR4pX3PmZB7deQDoZMSaF1Swjic5mNpL8AKhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LIroMu7kSS5sGJ38X1gE0rVXmJGlRyoF2Jipn80bkUUz92mSLud8pNdrWmZnhO8ixoA+O/rn32FLx5YOY6hDiHwvakYcZucbAAgeuFBAE8ej/0HfS2sxTE6uzZQFE9NHua3BigwNQxSRAEixN6Ijg7LILYgLwGO6s9x+QfsHZEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DV/eeBMt; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DV/eeBMt"
Message-ID: <4f18c782-a09e-4584-8abb-0c81265840ad@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773038714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y8+7dw1Q6xB08djwq9098argilDRaDgeg+de/aqxFNM=;
	b=DV/eeBMtLOMVppUh3yGOzi1HIfSsd8AF/dlxAFVrMowSRyaY80WuSXp4OByzQktEDjkugu
	Y8OUvLYia9wFsvQ7TcT3PzRfPveJm/0ZeZrp7uuFhtzefS+c6CgBQp+G7X1JTqL/ILlZ2n
	mhGV2GLxXTvhsxkuYvcECizmpolS9uA=
Date: Mon, 9 Mar 2026 14:45:02 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 5/5] bpf: refactor kfunc checks using
 table-driven approach in verifier
Content-Language: en-US
To: Chengkaitao <pilgrimtao@gmail.com>, martin.lau@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 chengkaitao@kylinos.cn, linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260308134614.29711-1-pilgrimtao@gmail.com>
 <20260308134614.29711-6-pilgrimtao@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260308134614.29711-6-pilgrimtao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/3/26 21:46, Chengkaitao wrote:
> From: Kaitao Cheng <chengkaitao@kylinos.cn>
> 
> Replace per-kfunc btf_id chains in list/rbtree/res_lock and graph node
> checks with btf_id_in_kfunc_table() and static kfunc tables for easier
> maintenance.
> 

Such refactoring should be the first patch? Less churn. Then, update the
list only.

However, is_bpf_rbtree_api_kfunc(), is_bpf_res_spin_lock_kfunc(), and
BPF_RB_NODE should be excluded, because you didn't touch them in this
series.

Thanks,
Leon

> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> ---
>  kernel/bpf/verifier.c | 97 +++++++++++++++++++++++++++++--------------
>  1 file changed, 66 insertions(+), 31 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5e32e02429c4..853716f599ce 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12602,6 +12602,62 @@ BTF_ID(func, bpf_session_is_return)
>  BTF_ID(func, bpf_stream_vprintk)
>  BTF_ID(func, bpf_stream_print_stack)
>  
> +static const enum special_kfunc_type bpf_list_api_kfuncs[] = {
> +	KF_bpf_list_push_front_impl,
> +	KF_bpf_list_push_back_impl,
> +	KF_bpf_list_add_impl,
> +	KF_bpf_list_pop_front,
> +	KF_bpf_list_pop_back,
> +	KF_bpf_list_del,
> +	KF_bpf_list_front,
> +	KF_bpf_list_back,
> +	KF_bpf_list_is_first,
> +	KF_bpf_list_is_last,
> +	KF_bpf_list_empty,
> +};
> +
> +/* Kfuncs that take a list node argument (bpf_list_node *). */
> +static const enum special_kfunc_type bpf_list_node_api_kfuncs[] = {
> +	KF_bpf_list_push_front_impl,
> +	KF_bpf_list_push_back_impl,
> +	KF_bpf_list_add_impl,
> +	KF_bpf_list_del,
> +	KF_bpf_list_is_first,
> +	KF_bpf_list_is_last,
> +};
> +
> +/* Kfuncs that take an rbtree node argument (bpf_rb_node *). */
> +static const enum special_kfunc_type bpf_rbtree_node_api_kfuncs[] = {
> +	KF_bpf_rbtree_remove,
> +	KF_bpf_rbtree_add_impl,
> +	KF_bpf_rbtree_left,
> +	KF_bpf_rbtree_right,
> +};
> +
> +static const enum special_kfunc_type bpf_rbtree_api_kfuncs[] = {
> +	KF_bpf_rbtree_add_impl,
> +	KF_bpf_rbtree_remove,
> +	KF_bpf_rbtree_first,
> +	KF_bpf_rbtree_root,
> +	KF_bpf_rbtree_left,
> +	KF_bpf_rbtree_right,
> +};
> +
> +static const enum special_kfunc_type bpf_res_spin_lock_kfuncs[] = {
> +	KF_bpf_res_spin_lock,
> +	KF_bpf_res_spin_unlock,
> +	KF_bpf_res_spin_lock_irqsave,
> +	KF_bpf_res_spin_unlock_irqrestore,
> +};
> +
> +static bool btf_id_in_kfunc_table(u32 btf_id, const enum special_kfunc_type *kfuncs, int n)
> +{
> +	for (int i = 0; i < n; i++)
> +		if (btf_id == special_kfunc_list[kfuncs[i]])
> +			return true;
> +	return false;
> +}
> +
>  static bool is_task_work_add_kfunc(u32 func_id)
>  {
>  	return func_id == special_kfunc_list[KF_bpf_task_work_schedule_signal] ||
> @@ -13002,27 +13058,14 @@ static int check_reg_allocation_locked(struct bpf_verifier_env *env, struct bpf_
>  
>  static bool is_bpf_list_api_kfunc(u32 btf_id)
>  {
> -	return btf_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
> -	       btf_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
> -	       btf_id == special_kfunc_list[KF_bpf_list_add_impl] ||
> -	       btf_id == special_kfunc_list[KF_bpf_list_pop_front] ||
> -	       btf_id == special_kfunc_list[KF_bpf_list_pop_back] ||
> -	       btf_id == special_kfunc_list[KF_bpf_list_del] ||
> -	       btf_id == special_kfunc_list[KF_bpf_list_front] ||
> -	       btf_id == special_kfunc_list[KF_bpf_list_back] ||
> -	       btf_id == special_kfunc_list[KF_bpf_list_is_first] ||
> -	       btf_id == special_kfunc_list[KF_bpf_list_is_last] ||
> -	       btf_id == special_kfunc_list[KF_bpf_list_empty];
> +	return btf_id_in_kfunc_table(btf_id, bpf_list_api_kfuncs,
> +				     ARRAY_SIZE(bpf_list_api_kfuncs));
>  }
>  
>  static bool is_bpf_rbtree_api_kfunc(u32 btf_id)
>  {
> -	return btf_id == special_kfunc_list[KF_bpf_rbtree_add_impl] ||
> -	       btf_id == special_kfunc_list[KF_bpf_rbtree_remove] ||
> -	       btf_id == special_kfunc_list[KF_bpf_rbtree_first] ||
> -	       btf_id == special_kfunc_list[KF_bpf_rbtree_root] ||
> -	       btf_id == special_kfunc_list[KF_bpf_rbtree_left] ||
> -	       btf_id == special_kfunc_list[KF_bpf_rbtree_right];
> +	return btf_id_in_kfunc_table(btf_id, bpf_rbtree_api_kfuncs,
> +				     ARRAY_SIZE(bpf_rbtree_api_kfuncs));
>  }
>  
>  static bool is_bpf_iter_num_api_kfunc(u32 btf_id)
> @@ -13040,10 +13083,8 @@ static bool is_bpf_graph_api_kfunc(u32 btf_id)
>  
>  static bool is_bpf_res_spin_lock_kfunc(u32 btf_id)
>  {
> -	return btf_id == special_kfunc_list[KF_bpf_res_spin_lock] ||
> -	       btf_id == special_kfunc_list[KF_bpf_res_spin_unlock] ||
> -	       btf_id == special_kfunc_list[KF_bpf_res_spin_lock_irqsave] ||
> -	       btf_id == special_kfunc_list[KF_bpf_res_spin_unlock_irqrestore];
> +	return btf_id_in_kfunc_table(btf_id, bpf_res_spin_lock_kfuncs,
> +				     ARRAY_SIZE(bpf_res_spin_lock_kfuncs));
>  }
>  
>  static bool is_bpf_arena_kfunc(u32 btf_id)
> @@ -13132,18 +13173,12 @@ static bool check_kfunc_is_graph_node_api(struct bpf_verifier_env *env,
>  
>  	switch (node_field_type) {
>  	case BPF_LIST_NODE:
> -		ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
> -		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
> -		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_add_impl] ||
> -		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_del] ||
> -		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_is_first] ||
> -		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_is_last]);
> +		ret = btf_id_in_kfunc_table(kfunc_btf_id, bpf_list_node_api_kfuncs,
> +					    ARRAY_SIZE(bpf_list_node_api_kfuncs));
>  		break;
>  	case BPF_RB_NODE:
> -		ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_remove] ||
> -		       kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_add_impl] ||
> -		       kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_left] ||
> -		       kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_right]);
> +		ret = btf_id_in_kfunc_table(kfunc_btf_id, bpf_rbtree_node_api_kfuncs,
> +					    ARRAY_SIZE(bpf_rbtree_node_api_kfuncs));
>  		break;
>  	default:
>  		verbose(env, "verifier internal error: unexpected graph node argument type %s\n",

