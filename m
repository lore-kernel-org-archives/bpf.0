Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0684A42A82
	for <bpf@vger.kernel.org>; Sun, 26 Jul 2026 15:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785081032; cv=none; b=iwiBAmnJKTvJP3uyk4HAr1Kyh6XIIhZ+YSEu3D1QDJSYgdy/AsKLUh/3FQVFQ4+qPkDDUyfcY7TcE0AWIKl4lPfzMS0yJGtb/S0eKCIMfq9twXGufL6VbdX+pI+hDkbZeydD/bd8k81mCNWzlzXCbIwvoCiFnu1abidYDztQSXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785081032; c=relaxed/simple;
	bh=WxryvA2HakVuZd8ykAXTzypU5qJnX45HQzh2z9MOmTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qCcPkr6aj6b0mX1LK+aYuytgxeE3k2D14w789lkxqGe4SxPBUfNYPZv3esy+oTAn3sfIVD+LzZKDLohTHa3zquQSo28/Abs0yEjGlNjGQaS2N+ulpOk+cFn44NNw26YOW/unCqEWI+iQco1C50hbehKJO8O3U88cf1zx1UTRoNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n+ObyI7h; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n+ObyI7h"
Message-ID: <31dc8d80-83d6-43fa-8e49-b5b9b3a6c648@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785081018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bNd4NfXNcK/uMLM3n6UPnEgZFUXB7zaNVNBXT+1pwdg=;
	b=n+ObyI7h/+1C5A/BfLk0pUz01J/pgTJtCDhu8Y2IsdGHuHjt/62NGyJdGAevgRIXk2OXuc
	c8BP2UGElyT57t67jCUv76b7dRMni0WbxmSv13Ylr909YGj4bs/qd8TlMIqPu5xrHDwmfG
	eaOe6xcJw7s/8ZMSRauBlN9LsMKHBUw=
Date: Sun, 26 Jul 2026 23:50:05 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] bpf: Log error code on trampoline unlink
 failure
To: xu.xin16@zte.com.cn, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, leon.hwang@linux.dev
References: <20260726230724742Z4CDN9ntFInEofAf2YxME@zte.com.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260726230724742Z4CDN9ntFInEofAf2YxME@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026/7/26 23:07, xu.xin16@zte.com.cn wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> Replace silent WARN_ON_ONCE with WARN_ONCE that prints the actual error
> code from bpf_trampoline_unlink_prog(). This aids debugging of race
> conditions during link teardown, while keeping the warning rate limited
> to avoid log flooding.
> 
> This will be very helpful for speeding up trouble-shooting of some crash
> UAF due to bpf_trampoline_unlink_prog failures.
> 
> No functional change intended.

Is it "No change to unlink behavior"?

> 
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> ---
> v1->v2:
> 1) clean the subject name by remove 'syscall' suggested by Leon Hwang
> https://lore.kernel.org/all/20a444b2-aeed-4af8-ba76-e994e2c14087@linux.dev/
> 2) Add up the missed case in kernel/bpf/trampoline.c:bpf_shim_tramp_link_release()
> 
> kernel/bpf/syscall.c    | 9 ++++++---
>  kernel/bpf/trampoline.c | 5 ++++-
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 6db306d23b47..2348dc33abf4 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3626,10 +3626,13 @@ static void bpf_tracing_link_release(struct bpf_link *link)
>  {
>  	struct bpf_tracing_link *tr_link =
>  		container_of(link, struct bpf_tracing_link, link.link);
> +	int err;
> 
> -	WARN_ON_ONCE(bpf_trampoline_unlink_prog(&tr_link->link.node,
> -						tr_link->trampoline,
> -						tr_link->tgt_prog));
> +	err = bpf_trampoline_unlink_prog(&tr_link->link.node,
> +					tr_link->trampoline,
> +					tr_link->tgt_prog);
> +	if (err)
> +		WARN_ONCE(err, "bpf_trampoline_unlink_prog returns error: %d\n", err);

'if (err)' here is unnecessary.

> 
>  	bpf_trampoline_put(tr_link->trampoline);
> 
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 1a721fc4bef5..dae3c2104ed4 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -997,12 +997,15 @@ static void bpf_shim_tramp_link_release(struct bpf_link *link)
>  {
>  	struct bpf_shim_tramp_link *shim_link =
>  		container_of(link, struct bpf_shim_tramp_link, link.link);
> +	int err;
> 
>  	/* paired with 'shim_link->trampoline = tr' in bpf_trampoline_link_cgroup_shim */
>  	if (!shim_link->trampoline)
>  		return;
> 
> -	WARN_ON_ONCE(bpf_trampoline_unlink_prog(&shim_link->link.node, shim_link->trampoline, NULL));
> +	err = bpf_trampoline_unlink_prog(&shim_link->link.node, shim_link->trampoline, NULL);
> +	if (err)
> +		WARN_ONCE(err, "bpf_trampoline_unlink_prog returns error: %d\n", err);

Ditto.

>  	bpf_trampoline_put(shim_link->trampoline);
>  }
> 

Would it be better to include this multi_detach() one?

		WARN_ON_ONCE(__bpf_trampoline_unlink_prog(&mnode->node, mnode->trampoline,
					NULL, &trampoline_multi_ops, data));

Thanks,
Leon

