Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE46502D4F
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 23:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790119902; cv=none; b=siJ9lzdd27TQbW9VZfTojJ4A+USmsxy0tgYK6il74Xe3pED4zdO/UeeVn96x/flxk14KD4dxkJzXnJJaopOfjdCtd9bLgT8I/pvxit5sW1ykIJxKl7w9N5yHHDIj0f2Mic56HRs1WYMfgpg3GWBR/uqFoNrkMcjS3sUXhZL+zyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790119902; c=relaxed/simple;
	bh=QKkcDuKFoVkeEV8Mzw2XgsnqPtUpnZUooEs7DW0DMlE=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:MIME-Version; b=Xr1jkTG1SVLXIujxduRhj6WWa7eKoPQhFLpdVVpTvmnpw0812YnYkqnsechkvkbCXJtsfV8l9slTWEVTt2NxKzr40LsvbHUpN2ofoxYqYeCh60hP7k8ZKe+b+ol00eemEct8U9naZNwGXYzSw6nsVAuQCJIz2OPf1pDgcIUiQOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlMBBRv7; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlMBBRv7"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-398c066106cso250234a91.1
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 16:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790119894; x=1790724694; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hdMn+nGtFfR/OhS5yBOlM2+xO0Vy0vJtBOIb/2kIDxQ=;
        b=mlMBBRv7BJb006aciM8qR9v5nZCZqZK9nCJ+ASNWfdLujQs0BrjMYT+2P1br3YZ2Ou
         uV2WhMFwg8femtoUzDhV40q+FBf4dbuNNwaL1WfKwn3Zaj0idm+jCOZc7yJiCLso4hsK
         HNTUQXqMUhd+97Mk6blTgv+WFbNNFETSrYLfbd3gUv6r9jv3AuXOgbWoTN5JJiubR0Hq
         DRTt1a5CpS4fA4fPk1u7dQ/R64hwQIdu5t4QpbbrZRxOtuK07HqBvf5+NNUbG1pHlnZA
         01llcqPNonLn8WbXY56oz3iE971ZRMomQOXfn34eFdOFn/KBL2DsNhZ5U/Rn7IP87IA/
         /EhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790119894; x=1790724694;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hdMn+nGtFfR/OhS5yBOlM2+xO0Vy0vJtBOIb/2kIDxQ=;
        b=LOMHBlL4r2eixBS/AAEDMOrKf3pT0ciz80E2pl8ialSroR8PHs8S6bcVJ5YibZAl0+
         ZmOnSsbiIDgw206UTG34xxmNQgkzATX9hf6yZ8b8i9WMQsCYMxcQAyIYpoI1DwU+BDYc
         Oe1/7wDFYGfknO6fsJkm9pORrYgHxE+C/K8mnywynm1ppfU7iBKTMnMiS00vSSmko0To
         pAq85lqeX0XYT1x5bVmcYa7FEnNkSTluSJ6bAHpXKa1WcP6+VC9JkuPQui9xGl4QDTmP
         p04pFcliPLozEe/YSfE9Hz18s6O322DjSRLFhq9eLpoy81iHHcxS1Fom5ncwqe/tt4i4
         OBLQ==
X-Forwarded-Encrypted: i=1; AKwUvBwhdXIV9Ln+qmcwYKJdJWSywNb3Xuhs5qhhWzPoUaq8F7yBycAbsn0WCjo6k7PAyvOEBzE=@vger.kernel.org
X-Gm-Message-State: AFuF++nSynn5YdsHJapYR4borXrBFSGXGt3l3pRTAUZ4mzWxETzFoYrd
	2jcdGt2PFkf1Vv5OZwmPGOs4EXparj5l1pKXrKwdTt+niJMYFyrD0MiY
X-Gm-Gg: AYBFou3CkigBJUcm+PFCG/B1Hzeds73vi27+gE0NZLJp/CuOJGKpirOJjobLP3r4R8x
	pLqe6aSZ/v0BFLoDvO7aDtOzrQLYVfvafuXFdCGvgoElNhMsr1rGhES7fB8M2j4fgS2rjVaGC8m
	ywMOqSFTMn1yQNFq+6HIWlgSd2qgUwYeu7zxkhOx4y8SmIpCee+AKoIVm7b+IMj/sKSA8+1hDF7
	fnVjVqMikzkE5rlG+dmBXUoQVd+rpt2JQEjcrK+XIrUOB7boAdwsG9dEHsKVHpiQtvY9sMcCIU6
	H5aXNv9K3ZS7ceRPGxonfcN+wE9DCVstK5Zu00IKkS3FtzH48owltOe4Cu85mqcM3ojZ7xrc4Wb
	uDcbllMp6bZil0S04rqcJtwXDBUv9NSKN2b7mevidRxI+KOr9Lz79GJxuixVJX59vP6CuHSnTlu
	bn6gJraClbdAkcqXvub22Fgmoo12bp03WHjv+Dz2yui7VS2sK5MNI8awgIGvtCeT9ys6dxV5zjA
	7kAc9hxOgiw8IAgZpQxsXvqQeDMpz+pgYLcr31kd76V2N8Lp8NP0JITeGpfc+yTAQSYujQWPy+f
	o6Y=
X-Received: by 2002:a17:90b:1346:b0:398:a145:5d3d with SMTP id 98e67ed59e1d1-3a07e4ee828mr751894a91.6.1790119893982;
        Tue, 22 Sep 2026 16:31:33 -0700 (PDT)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07fa6489dsm311620a91.1.2026.09.22.16.31.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 16:31:33 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Sep 2026 23:31:33 +0000
Message-Id: <DLM8JHZUINUJ.3V54PKAS0QV9B@gmail.com>
Subject: Re: [PATCH bpf-next v5 1/2] bpf: Track iterator-owned BTF pointer
 lifetimes
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Xu Yunxiang" <xyx2021@mail.ustc.edu.cn>, <bpf@vger.kernel.org>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <ameryhung@gmail.com>, <yonghong.song@linux.dev>,
 <puranjay@kernel.org>
In-Reply-To: <20260920210432.345758-2-xyx2021@mail.ustc.edu.cn>
References: <20260920210432.345758-1-xyx2021@mail.ustc.edu.cn> <20260920210432.345758-2-xyx2021@mail.ustc.edu.cn>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, Sep 21, 2026 at 05:04 AM Xu Yunxiang <xyx2021@mail.ustc.edu.cn> wrote:
>  BTF_ID_FLAGS(func, bpf_iter_task_vma_new, KF_ITER_NEW | KF_RCU)
> -BTF_ID_FLAGS(func, bpf_iter_task_vma_next, KF_ITER_NEXT | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_iter_task_vma_next, KF_ITER_NEXT | KF_RET_NULL | KF_ITER_LIFETIME)
>  BTF_ID_FLAGS(func, bpf_iter_task_vma_destroy, KF_ITER_DESTROY)
>  #ifdef CONFIG_CGROUPS
>  BTF_ID_FLAGS(func, bpf_iter_css_task_new, KF_ITER_NEW)
> -BTF_ID_FLAGS(func, bpf_iter_css_task_next, KF_ITER_NEXT | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_iter_css_task_next, KF_ITER_NEXT | KF_RET_NULL | KF_ITER_LIFETIME)

[...]

> -BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next,
> +	     KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE | KF_ITER_LIFETIME)

[...]

> -BTF_ID_FLAGS(func, bpf_iter_dmabuf_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_iter_dmabuf_next,
> +	     KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE | KF_ITER_LIFETIME)

So all four iterators that return a non-rcu struct pointer got the
flag and the only one without it is the testmod iterator added in
patch 2. With opt-in a new iterator that forgets the flag gets the
same UAF.
I feel it's better to do opt-out.

pw-bot: cr
