Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1A53B3C19
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 08:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785226119; cv=none; b=fpwSNu7UTtWfO7aYsaxZ96KkCog2N7WOKaVa/EDoN7/pZ7tkV9Mw/5y8mw5cdCXVrVvuYbgR619/h+7qGDwOlZZ/kgjIDqx3NCXUn75M1RcB4ShFEWOGCoiyyPVEKx9u2suuxDU6npMYZKUeJYtyZJlHaNfqwV37QsZb0CCNWFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785226119; c=relaxed/simple;
	bh=uf1sV3DbNGicX1uUv4aiLaqoUjK69bIwbsUMTOHFd+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BH74ZiPz4496ivWAPeMEN448u6FLuJei81mzVfb6iMVP2R8xvtNv1+ovx9Pl0HXo0KZFzcm21aGzuhPxOhKNIbxilAGQGEMhqLfZ/SQptVMaubpPu9wMhyK1dBU2CS9C67oUy1Ffj6YGaph8ArUamNoQQ+PqWLGBn35Figlw6ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OLDOLYVl; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OLDOLYVl"
Message-ID: <82926caa-e16a-457a-8d75-61dfc8dac102@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785226105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Esr6Y1YeEUCv1OmPmWXL3ZZPZ7PWEqAiOVt5NEUdikw=;
	b=OLDOLYVlH9c/IIW4cvUGSc0wZTcBKU/bRBMd5ejyGOZyqePR72NPpAR7GxDR7n3PzsrrXu
	WRWiM2tU7634TVf9qUWw6JXCaOyJ9uyR5U+T6oJ5pD7jn39+oKuiBoxyUu2wWg+OjMonIp
	dciATzjS/HQ96qQtthV6Hml2lJi9nZ0=
Date: Tue, 28 Jul 2026 16:08:02 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3] bpf: log error code on trampoline unlink
 failure
To: xu.xin16@zte.com.cn, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 linux-kernel@vger.kernel.org
Cc: bpf@vger.kernel.org
References: <20260728142621001Ee2lrcnZpeNuxtxRES69Z@zte.com.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260728142621001Ee2lrcnZpeNuxtxRES69Z@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 28/7/26 14:26, xu.xin16@zte.com.cn wrote:
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
> No change to unlink behavior.
> 
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>


Better to use Xu Xin as your formal name.

> ---
> Change log
> V2->v3: 
> Add up the case in bpf_trampoline_multi_detach. And remove the unneeded 'if (err)'
> 
> v1->v2:
> 1) clean the subject name by remove 'syscall' suggested by Leon Hwang
> https://lore.kernel.org/all/20a444b2-aeed-4af8-ba76-e994e2c14087@linux.dev/
> 2) Add up the missed case in kernel/bpf/trampoline.c:bpf_shim_tramp_link_release()
> 
>  kernel/bpf/syscall.c    |  8 +++++---
>  kernel/bpf/trampoline.c | 12 ++++++++----
>  2 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 6db306d23b47..52c57f8beb37 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3626,10 +3626,12 @@ static void bpf_tracing_link_release(struct bpf_link *link)
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
> +	WARN_ONCE(err, "bpf_trampoline_unlink_prog returns error: %d\n", err);
> 
>  	bpf_trampoline_put(tr_link->trampoline);
> 
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 1a721fc4bef5..a34ddb97ff6b 100644
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
> +	WARN_ONCE(err, "bpf_trampoline_unlink_prog returns error: %d\n", err);
> +
>  	bpf_trampoline_put(shim_link->trampoline);
>  }
> 
> @@ -1712,15 +1715,16 @@ int bpf_trampoline_multi_detach(struct bpf_prog *prog, struct bpf_tracing_multi_
>  {
>  	struct bpf_tracing_multi_data *data = &link->data;
>  	struct bpf_tracing_multi_node *mnode;
> -	int i;
> +	int i, err;
> 
>  	trampoline_lock_all();
> 
>  	for_each_mnode(mnode, link) {
>  		data->entry = &mnode->entry;
>  		bpf_trampoline_multi_attach_init(mnode->trampoline);
> -		WARN_ON_ONCE(__bpf_trampoline_unlink_prog(&mnode->node, mnode->trampoline,
> -					NULL, &trampoline_multi_ops, data));
> +		err = __bpf_trampoline_unlink_prog(&mnode->node, mnode->trampoline,NULL,


NIT: a space is missing at the position between ',' and 'NULL'.

> +					&trampoline_multi_ops, data);

NIT: align '&' with previous line's '&'.

Other than that,

Acked-by: Leon Hwang <leon.hwang@linux.dev>

> +		WARN_ONCE(err, "__bpf_trampoline_unlink_prog returns error: %d\n", err);
>  	}
> 
>  	if (ftrace_hash_count(data->unreg))

