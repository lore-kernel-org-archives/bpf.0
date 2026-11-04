Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.184
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793765778;
	b=HK2KhhEVca5WrhKrenzcHsM4KEjhsJIpNFKKehx2TJaD5+1kknh9iyNiI7aOsS8RiPOs
	 vuCehy92kmzAbPPRRL+Jam9ze0xyzWymfUNZR0/zB+I0OqtR6cKbh7LINotUSZj5CeOfk
	 dhqrTRElu/popTYFMVueVGutdQm8s2IAIHxIcxt4m1Q0Libpqbt3suQwqEhpC6meRhqzh
	 NRfrm4525KRW1AqYubVaMAm7q0I5exajilNkrmx0bzNV4fdQk8VVkRK6RLqTbY2wsHhJj
	 UHI4vHaLgdWxUQkPghtL8j1nGBzDO6ko8P5daTRoC9Pk4ogD5z7Fj5lBLwe/0gNsxAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793765778;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=K/cIC+iFmdevIAI+I2RKVd6I0g7XOiCzAkoSeW4/ahA=;
	b=VkzufpJznn/1Cjg4lBr8rPf3j1zrdx+rIg8PUj8E+74+3Lb196Yth79wDEgNIuRBAO0M
	 7jthWroaSxKPPvimVOnKvRmwUb0F1jaCraevKkB0ChJSa/b8zX3ZF3JAEgkg2YdV4AUTg
	 5M912p9Yw2jiY5LGAPJtOeBIp8rOcL9XJa9UoU5a2fCmDoFXI1k8DBJkxBxmf/OAp8+Jx
	 84GolHjixMsJ8QP+R5QV/yUSt7iJRRyk0jMboqgc3nKXXL+AnvcJ9B5dKsd1Oneq3iVyk
	 KO7/rrNkXXPo18W4gHXQbCM7cOdW40+14pYEkWdNJBuEZVrj3mrmHq72P/woty6DBUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Z7CawluL;
	arc=none smtp.remote-ip=95.215.58.184
Received: from mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58648606A329
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 04:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58648606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Z7CawluL
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=vOi5qQ0/DXnG4QFkyblinf0P8GKtrfv4uQiJ8Uvnh54=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793765774; v=1; x=1794370574;
 b=Z7CawluL2fAeDcWOMjTaSwZXO5rltRY3EmeRBJOdaLjKlQj/ClrRIakW7Ph6cMVOYJA2sH8H
 p6vmttNFNOJBb7jhf/TykWnsYTBhl1jKKBxnG6QQfb6oD3DtJYXkvfPLoCeYhJbejs/v8DBJbO9
 gnw6axvo809dSLfQDnqs/1og=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5164afd9a38a0a63;
	Wed, 04 Nov 2026 04:16:14 +0000
X-Mizu-Trace-ID: 5164afd9a38a0a63
X-Migadu-Flow: FLOW_OUT
Message-ID: <bb64096f-2c73-428b-ac74-881227539a2f@linux.dev>
Date: Wed, 4 Nov 2026 12:15:51 +0800
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
Subject: Re: [PATCH net-next v4 2/7] net: cap sockopt_expand_out() at
 MAX_RW_COUNT
To: Breno Leitao <leitao@debian.org>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>,
 Eric Dumazet <edumazet@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 david.laight.linux@gmail.com, kernel-team@meta.com
References: <20261103-sockopt_expand_out_v2-v4-0-2d36da923578@debian.org>
 <20261103-sockopt_expand_out_v2-v4-2-2d36da923578@debian.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261103-sockopt_expand_out_v2-v4-2-2d36da923578@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/3/26 7:01 PM, Breno Leitao wrote:
> sockopt_expand_out() grows the output iterator up to INT_MAX, but the
> MCAST_MSFILTER getters converted by the next two patches rewind it with
> iov_iter_revert() once they know the real reply size. iov_iter_revert()
> refuses to unroll past MAX_RW_COUNT:
>
> 	if (WARN_ON(unroll > MAX_RW_COUNT))
> 		return;
>
> MAX_RW_COUNT is INT_MAX rounded down to a page boundary, so a caller
> that expands into the (MAX_RW_COUNT, INT_MAX] range and then reverts
> hits that WARN_ON, and the iterator is left where it was instead of
> rewound. So does a caller whose optlen already covers such a size.
>
> Cap the size at MAX_RW_COUNT instead, before the early return for an
> optlen that already covers it, so a size that could never be reverted
> later is rejected up front.
>
> Sashiko found this while reviewing the conversions.
>
> Acked-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


> ---
>  include/linux/net.h | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/net.h b/include/linux/net.h
> index e2a866fbcfa5ea..de56f89d475ee2 100644
> --- a/include/linux/net.h
> +++ b/include/linux/net.h
> @@ -80,16 +80,21 @@ static inline int sockopt_init_user(sockopt_t *opt, char __user *optval,
>   *
>   * Call it before writing through opt->iter_out: it re-anchors the iterator at
>   * the head of optval. Only a user buffer can be longer than the optlen the
> - * caller declared, so a kernel-backed optval is refused with -EINVAL.
> + * caller declared, so a kernel-backed optval is refused with -EINVAL. So is a
> + * @size above MAX_RW_COUNT, which iov_iter_revert() could not unroll.
>   */
>  static inline int sockopt_expand_out(sockopt_t *opt, size_t size)
>  {
> +	/* iov_iter_revert() refuses to unroll past MAX_RW_COUNT, so a size
> +	 * beyond that could never be reverted back to the fixed part later,
> +	 * even when optlen already covers it.
> +	 */
> +	if (size > MAX_RW_COUNT)
> +		return -EINVAL;
> +
>  	if (size <= (size_t)opt->optlen)
>  		return 0;
>  
> -	if (size > INT_MAX)
> -		return -EINVAL;
> -
>  	/* Re-anchoring reads iter_out.ubuf, so the iterator has to be a user
>  	 * buffer that nothing has written through yet.
>  	 */
>
