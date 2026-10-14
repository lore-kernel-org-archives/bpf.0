Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062E6481647
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 21:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792014200; cv=none; b=VLGvoFIB9gckalmUS/fGW0x+TgWDr+yM3jMQTmRio5eV8npQWaOtm9WuzFGe4Yel8XY6XpDHPeBP7pwfACDKxksiVyHxA2T+DDYtXSV7GKDVoXnHsVpdV9Ms9qkCeyFP7wM4ocgoCbUmtRigUFOpTL7/OQgvf1D+J0Sb0pem/js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792014200; c=relaxed/simple;
	bh=vN3QRsmAUS70n+XecR/F37adlA8EFACezZg+XFXg/RE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWeBqEwbBD2UUhgGYXPnS9Eq1YNZhteYOqBAKaRu1ELVX4LcyiD4ewLC2mJnS3LnFBiiNrIrGjcrNvfBj33VRKn4v6fpMlTmqnN0B7LMmFWFhXa3ZDQhOKVIqIWKY/R5tZBI3VB2c4S2mSGKu2DmETtq4TutrBMqQkcgzK/sZXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7Uaswds; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7Uaswds"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a02718da81so37110645e9.1
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 14:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792014197; x=1792618997; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PCWceIALROvD7GFJFqjW3lbx85nNdj6qe6chpWvRNQE=;
        b=W7Uaswds3m0JB0L74uwop7c3EG1uelvJOCEqveE37A9EJm2a3Ss2CWnuMO0qWI1YFr
         OM1nl9P+x0+cJWg2+z005ZKCwxw7vTM94epqG3s8xNYZvQofywE/IPm+hGhdx5Izq2oo
         9GFBZr+fZqxT7+rGP+6EnZtheMXnoL2xCN200uIMHxSMIrXeSacH76F3qImi460Rbt6G
         n5ofyjI5lawF+xj5tvNQwX3jqgFJI7qIQK2h3Pg2hbjN4dz9BxJIf02D2+V+U0/GISew
         A6P7Kw0h310n3HzWYtGwE0l6FoK5pCWgJvFTXhwmGP3fdqGybm6bSzXCMqOx6A7u54cb
         7E5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792014197; x=1792618997;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PCWceIALROvD7GFJFqjW3lbx85nNdj6qe6chpWvRNQE=;
        b=wDLsvKYZqW0bpasGEhnsRJSPyJEVGLSi51F0mxVWjyFXwug8/nrowZJQ+JUuriPCZo
         YDSR5ToXukElkd6ybxf49bo46mMzy0T8TZcOVrmuis2Mmf0v4nP89tDRYZzJI9moVrrq
         Vl/6+81HVxPMGht7DRTGs1JViDE5a+POxRZxqz/Eefo5GYE2TxMISpdfVUDWmK+4yfdR
         bbJUxUAtlMuis4apPcCu4xwDcjZcLdiapZFbxmgdsi6YnMsJl1c1sq7+i9l2bU/31Pvb
         QOv2wtgkhr4iu4bjXFLv+ZOLWN033wCFq4zz3Giw5/J8j/qEDlMdTfQWGM2QbexSp673
         2tmQ==
X-Gm-Message-State: AFq9FYIeZW/UuETDazv5RMk8COyQg/+yYcyqAgosFmtxMxDLJ21UPMM4
	74A9dTl8U0oMMKnKZqU/Fo3qnA9vZ/Ny29R/BYdJFLOHQd1sRC9A9WCt
X-Gm-Gg: AYBFou35Kg0xw1Vo7PL1oRI4eGES4N+aXdhpH+bBbm500SSqzcHI12IXMkQHzCnwP/k
	T+zC8MqqhPJaZ+ojqZEVSU0HqTGnPhVPIkTtKnBfNiTd5NJBcLe3ZA12wDBkd/7BKJ59jQdGB/o
	byeqFgWKdzit1OYMwnsT/abnCwfV85vMBjmXXUpFQh/dAFUFaQ+sf/Ek8Lwf5MFz5Djv1G/QcG1
	NGvVPao5pZpNXrG9z7v14ucWqjF9zE/bEM7PuTIJuB+YFnzaQGB0zKwAKuv2CqhwkOVTpuXbW1b
	lHrHdCxKXRvNAWgSc8vgHJNl8qP6KlGSFvxmu2Drlnj4gn8rCyyLBwA/1e/cBhEr46A2Pgqtxiq
	j7+/BtwjfuDnylmAFD4R9RJ/WAArKloH7Pbzbuc+240J5Kib311wDRPCNzre8br/yg/uW4Ere0a
	BbnhKCu0ose9/9KqbZ5WKhXjmkng+oBVv8nVz8M6+PlTcRm0k/sGItJsUh+9c=
X-Received: by 2002:a05:600c:19ca:b0:4a0:2484:2800 with SMTP id 5b1f17b1804b1-4a18e4464famr330783705e9.3.1792014196956;
        Wed, 14 Oct 2026 14:43:16 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd7319c6sm24456265e9.0.2026.10.14.14.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 14:43:16 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 14 Oct 2026 23:43:08 +0200
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Avinash Duduskar <avinash.duduskar@gmail.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>, Jordan Rife <jordan@jrife.io>,
	Rong Tao <rongtao@cestc.cn>, Eyal Birger <eyal.birger@gmail.com>,
	Pu Lehui <pulehui@huawei.com>, Jingguo Tan <tanjingguo@huawei.com>,
	Lin Ma <malin89@huawei.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 09/21] bpf: Add
 bpf_trampoline_multi_prog_attach/detach()
Message-ID: <as_3bEChFtcxbcYj@krava>
References: <20261012154024.29423-1-leon.hwang@linux.dev>
 <20261012154024.29423-10-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012154024.29423-10-leon.hwang@linux.dev>

On Mon, Oct 12, 2026 at 11:40:11PM +0800, Leon Hwang wrote:

SNIP

> @@ -2089,10 +2101,25 @@ struct bpf_tracing_link {
>  	struct bpf_prog *tgt_prog;
>  };
>  
> +enum bpf_text_poke_type {
> +	BPF_MOD_NOP,
> +	BPF_MOD_CALL,
> +	BPF_MOD_JUMP,
> +};
> +
> +struct bpf_text_poke {
> +	void *ip;
> +	void *old_addr;
> +	void *new_addr;
> +	enum bpf_text_poke_type old_t;
> +	enum bpf_text_poke_type new_t;
> +};
> +
>  struct bpf_tracing_multi_node {
>  	struct bpf_tramp_node node;
>  	struct bpf_trampoline *trampoline;
>  	struct ftrace_func_entry entry;
> +	struct bpf_text_poke poke;

could we have union of entry and poke ?

jirka
