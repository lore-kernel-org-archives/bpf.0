Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E88279DB
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 06:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qh1tmK5G"
Message-ID: <1448ac2f-8d5c-4cf4-9990-5e82029f7823@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702620176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sg+pgFp61z7wfJyelU0+rABANUSfNWf3hsDiUcR7HFE=;
	b=qh1tmK5G254MJ8cp1e2gSGmAaHjFRjPfK9jH4/JvD6F5pe+IR8prkwPbVClVSm2ACx757v
	ISru3RVx9dPT/8evjncxFk5zWZbcw6AssOJfcjFFxaDR6AIlEkfzp1Oa7GeFabRYHVI8ag
	aJ+tSKFGb9++u4tuyMwD7OLZOw8cwzo=
Date: Thu, 14 Dec 2023 22:02:52 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v13 09/14] bpf: validate value_type
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 drosen@google.com
References: <20231209002709.535966-1-thinker.li@gmail.com>
 <20231209002709.535966-10-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231209002709.535966-10-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/8/23 4:27 PM, thinker.li@gmail.com wrote:
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index c5c7cc4552f5..7384806ee74e 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3321,4 +3321,16 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
>   	return prog->aux->func_idx != 0;
>   }
>   
> +enum bpf_struct_ops_state {
> +	BPF_STRUCT_OPS_STATE_INIT,
> +	BPF_STRUCT_OPS_STATE_INUSE,
> +	BPF_STRUCT_OPS_STATE_TOBEFREE,
> +	BPF_STRUCT_OPS_STATE_READY,
> +};
> +
> +struct bpf_struct_ops_common_value {
> +	refcount_t refcnt;
> +	enum bpf_struct_ops_state state;
> +};

nit. Move these up closer to the existing 'struct bpf_struct_ops' and related 
functions. Probably under 'struct bpf_struct_ops'.

