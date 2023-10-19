Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2505D4667C
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 00:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="erdOzA9Q"
Received: from out-201.mta1.migadu.com (out-201.mta1.migadu.com [IPv6:2001:41d0:203:375::c9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA8D114
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 17:00:20 -0700 (PDT)
Message-ID: <f96c93dc-efde-5ec7-6a0e-3a9d166c844f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1697673618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gn85Q3PhKILM36CUB27+uJx4yC7uVMuoFjgDgAEckFM=;
	b=erdOzA9QtkNhtn1RNmpA5HlvE1i4vb5A8uyLnMBGjelEYLfzA7MQV18GB6ekJV2utGh1TK
	NucFMYPMu6jJ7UZrfUMHXLXbWRoLDxWFxxrK62NfkTa/rjs1KaWFogRlmMzFszJFXG6EZ8
	8uWRY4zkOU4F5urGc7WBAuYVhBGxaP0=
Date: Wed, 18 Oct 2023 17:00:11 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 2/9] bpf: add struct_ops_tab to btf.
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 drosen@google.com
References: <20231017162306.176586-1-thinker.li@gmail.com>
 <20231017162306.176586-3-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231017162306.176586-3-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/17/23 9:22 AM, thinker.li@gmail.com wrote:
>   static const struct bpf_struct_ops *
> -bpf_struct_ops_find_value(u32 value_id)
> +bpf_struct_ops_find_value(struct btf *btf, u32 value_id)
>   {
>   	unsigned int i;
>   

[ ... ]

> @@ -671,7 +672,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>   	struct bpf_map *map;
>   	int ret;
>   
> -	st_ops = bpf_struct_ops_find_value(attr->btf_vmlinux_value_type_id);
> +	st_ops = bpf_struct_ops_find_value(attr->btf_vmlinux_value_type_id, btf_vmlinux);

This patch does not compile because of the argument ordering.


