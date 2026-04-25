Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAACD2BEFEF
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 03:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777087047; cv=none; b=SvhAhl4G6OlMjPLolomoE0hZspDzRyPDuFx4fL8+/RJLf2TzPDqkspHXaomSnlCXFPJm+HywGndpacGltdw7Itl5dcBCspGiO5mTf7f1wvZVR9YDTalivrN1PyAGCWYCg0aO7GZTiCR/Df6Tz7omK/SlMm+kk3nlLELMzWzTYLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777087047; c=relaxed/simple;
	bh=P/jCRwI+vb3hmgLl3TD2Y/H7nGJHvOWxFGiCx+eUJTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KgzvrHfVAjuSDTVnZPH0e0oE23Pe7GJWiGnD2mStr3Mz+G8BHBIKsF74xDKQ6Abq4K3lvG5Ukflz0e8OXetDu8i8tIf7ex/qYU2nvW3LAODZ7eZCjLsLlShpNeT3CrCFSFQu+Zz/sCYt/CPPtAs67CXl0Z5tOPLldAIxjSpRzik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xDopzlCF; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xDopzlCF"
Message-ID: <c4a9412d-b6ad-4b80-9580-865575f4152c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777087042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QvFrmnSTSSnKofZYD+adzsXaKTvHU//GdzJAoINgsm4=;
	b=xDopzlCFZJqDsrVe1A5POf9VnZxVWhEBxIvuyDA8pHtvOzoQFcKfl2DurcfgIzS3HWNEjT
	u+v4eyupBGPg3VFEeltYj4teLoXabacwa96nSUyg406cILXaaXE9ofROuoqRCDd+SLhM1U
	RBA2OEbSRGYJFOwhAXhaBiQqVU7W8QA=
Date: Sat, 25 Apr 2026 11:17:03 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf, sockmap: zero-initialize pages allocated in
 bpf_msg_push_data
To: Weiming Shi <bestswngs@gmail.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Simon Horman <horms@kernel.org>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Xiang Mei <xmei5@asu.edu>,
 Xinyu Ma <mmmxny@gmail.com>
References: <20260424190310.1520555-2-bestswngs@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260424190310.1520555-2-bestswngs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 4/25/26 3:03 AM, Weiming Shi wrote:
> bpf_msg_push_data() allocates pages via alloc_pages() without
> __GFP_ZERO. In the non-copy path, the entire page of uninitialized
> heap content is added directly to the sk_msg scatterlist, which is
> then transmitted over TCP to userspace via tcp_bpf_push(). In the
> copy path, a gap of len bytes between the front and back memcpy
> regions is similarly left uninitialized.
>
> This leads to a kernel heap information leak: stale page content
> including kernel pointers from the direct-map and vmemmap regions
> is transmitted to userspace, which can be used to defeat KASLR.
>
> Add __GFP_ZERO to the alloc_pages() call to ensure the allocated
> page is always zeroed before it enters the scatterlist.



As the helper's own documentation says:

     If a program of type BPF_PROG_TYPE_SK_MSG is run on a msg it may
     want to insert metadata or options into the msg. This can later be
     read and used by any of the lower layer BPF hooks.

The inserted region is meant to be written by the BPF program — that's 
the entire point of calling push.

If the program doesn't fill it,  the push has no purpose to begin with.


Isn't the uninitialized content a bug in the BPF program rather than 
something the kernel helper should paper over?


> Link: https://lore.kernel.org/all/20260424155913.A19FDC19425@smtp.kernel.org
> Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
> Tested-by: Xiang Mei <xmei5@asu.edu>
> Tested-by: Xinyu Ma <mmmxny@gmail.com>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>   net/core/filter.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index bc96c18df4e0..ea02239892fd 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2820,7 +2820,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
>   	if (!space || (space == 1 && start != offset))
>   		copy = msg->sg.data[i].length;
>   
> -	page = alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP,
> +	page = alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP | __GFP_ZERO,
>   			   get_order(copy + len));
>   	if (unlikely(!page))
>   		return -ENOMEM;
