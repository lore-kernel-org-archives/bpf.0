Received: from mta1.migadu.com (out-84.mta1.migadu.com [95.215.58.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958783EC804
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 09:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788342112; cv=none; b=oLUXJLJa9bKQeLdFaQPDUGdWaC8m2kX3Q/L7uvvQdslbRnKLrVREplWWXux7yTmI4qut3GK1vruqTflsKf2Sbtv6WV+scJtrhPh7VVK4wjpyC5WcKzSCbG7fqAc7DL6e3WpQCu2MWypERO/yS4T5dHasyQaJfBVZjVRo/IamXu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788342112; c=relaxed/simple;
	bh=mg29bpJ26CktmDxolbBxekjUlpi6RD+j0ko+bhDNLg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uBdLiaxxNKJYGTPgNPdA5U/VtEtS7LUA/50cKgvSFXNJG2lXQeLuwmvITkXfO9QU1+35UEzwFxNr4DZzejrLXiAGGMGHntmZSD8eYTBqv+0ci1RJ96V1+ARDiOSAUI7c0Gen3WLx434oQRSSU8+LTPiyqjJm2ARPhjJBfz/Wf8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hDes4nW7; arc=none smtp.client-ip=95.215.58.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hDes4nW7"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=mg29bpJ26CktmDxolbBxekjUlpi6RD+j0ko+bhDNLg8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788342108; v=1; x=1788946908;
 b=hDes4nW7kbwlBQePNnRQUR8KK8I4tHDVZGxlxDFPRVXaCc5hx/Vg69JT1h0BZz709z1+ubIN
 849iEtZfQXGjQM1MYWWj1PNcR7jTPZc7UUNQbVjd0WsrRWaRkgqZ+W0ClCDD68mRuftDe5PJBh+
 zD7NlsS/0pSGBjeUaBGlyVvM=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1e2dd54176a0ba95;
	Wed, 02 Sep 2026 09:41:48 +0000
X-Mizu-Trace-ID: 1e2dd54176a0ba95
X-Migadu-Flow: FLOW_OUT
Message-ID: <286de7d2-3750-4a44-a8e8-7054c8cf51d9@linux.dev>
Date: Wed, 2 Sep 2026 17:41:34 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: cgroup: fix null-ptr-deref in __cgroup_bpf_attach
To: Liu Jing <liujing@cmss.chinamobile.com>, ast@kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260902090220.16395-1-liujing@cmss.chinamobile.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260902090220.16395-1-liujing@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


on 9/2/26 5:02 PM, Liu Jing wrote:
> In __cgroup_bpf_attach(), the expression "prog ? : link->link.prog"
> dereferences link before validating that link is non-NULL. If both
> prog and link are NULL (a contract violation by the caller), this
> causes a null pointer dereference.


Both being NULL is unreachable, so the new check is dead code.

It's meaningless.


>
> Add a safe ternary fallback and a NULL check for new_prog before
> it is used further.
>
> Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
> ---
>   kernel/bpf/cgroup.c | 4 +++-
>   1 file changed, 3 insertion(+), 1 deletion(-)
>
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -814,7 +814,7 @@
>   	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
>   	struct bpf_cgroup_storage *new_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
>   	struct bpf_cgroup_storage *old_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
> -	struct bpf_prog *new_prog = prog ? : link->link.prog;
> +	struct bpf_prog *new_prog = prog ? : (link ? link->link.prog : NULL);
>   	enum cgroup_bpf_attach_type atype;
>   	u32 old_flags, old_pl_flags;
>   	struct bpf_prog_list *pl;
> @@ -833,6 +833,8 @@
>   		return -EINVAL;
>   	if (!!replace_prog != !!(flags & BPF_F_REPLACE))
>   		/* replace_prog implies BPF_F_REPLACE, and vice versa */
> +		return -EINVAL;
> +	if (!new_prog)
>   		return -EINVAL;
>   
>   	atype = bpf_cgroup_atype_find(type, new_prog->aux->attach_btf_id);
>
> --
> 2.43.0
