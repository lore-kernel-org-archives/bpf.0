Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.64
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792544278;
	b=R1jBr9S0s2rp4RhUnmmAWq9xHic07MSEDze+VS9W9+AFpiKHGDTcMYhWAHJyERAT2u6f
	 aDY94MrLQhc8BAIjPNE1HGxgTdoR9SpVEKApYXcAbp7UBFkJoqMOHWb/IGHmHcZS83Gbv
	 Rb9JxfoT4u6je2aAXgtWcgRQUUEF05wvLKxvdM7AnV62RJefBBhXB6/un47F0ur6vg9UC
	 sN0LaKTsaYULejPDbzoGWCN3ZKypu5UxsubP3O3sdUsfCsWb4QjBII5LTaJI6kSZdI7fT
	 nvKloCmCqQRMSvFWLKchNEZsA+p/QJaKZ2CcmpkkPnv6i3EJ8d3fHN0KDAlxZhMPFlw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792544278;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=r53tKek5XAro3XIPieY7v1q8VJjq7ariTBY7WuS3XWU=;
	b=UaCNZUrvsfEs6tVqjax9voXPdCM005pvwRDf3kj3nkrytr/nJy9aX0PEBqY18cysvddF
	 dPWxa0prwpSgJnwUbu7e3c5WXcHWnD1dvsXJQE6mccwxJH6tF75oPxOV7sMQdw6IS7km0
	 UEczFi7wu/71XtymSDjsJZp2ZP8WxWdDOxmNqYY+mDiweRwsHKG7YyP6OXPeCQOZtLyGv
	 OY+icH/bzZZ2yOYtWUaWqpGrOo44QYhddWMQgsoQSVmJJd0r0BOzpLPzMoYkp6NNptanC
	 O149l+9SdDJ2dCm+5gDoZYBBoQ+Fr9R9VXRNkqZD6myLzMC9lVpEShvpqaua4ryb8Bg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ruMg7oBd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.64
Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AF1606A31B
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 00:57:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43AF1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ruMg7oBd
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-48db76d98a1so82306f8f.1
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 17:57:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792544276; cv=none;
        d=google.com; s=arc-20260327;
        b=Fdj1zGeY+UfuLUXE9ZlukoCUoKWY4DgWQW5OpUg8pxD2pK7aXlmzxE/RjKX2zxPFMl
         JDZSG002qhRK7t1YhximxZzXaIl1m0km4mTifumXr7zLFGcSCCh+cPSuoj8F+hgbzJc6
         CmLtFvpJj0lb5V7nWnT8F+t6uVbYI1lVB8N7tqQaBFcaALo1il/VGeZfTtigQjz/pUIE
         RlXMOJVmuK8PP5LgSxCWjvwIIw4uJFHtrNCN6+lGNmenGokHmPKO5/3YVALZ6BLuVp0Z
         gp/coQfE5o7B7ZW8pP/xrD59uEcmufzC03k9wB953kADHokkWhoRJFCXuh9MtVhUYyeO
         PBGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=r53tKek5XAro3XIPieY7v1q8VJjq7ariTBY7WuS3XWU=;
        fh=EezWC+bAn8ZGlp6Ks+yBOM8g/VBOzzQSTmZ5XcfsI9o=;
        b=UgBxwDYbEltH6pqrHH4zIQvpKzqbCFLZnQ17htoR3m67auhKGmZHybbmtbyuWeOiB0
         er9Bcjd5iV1qkb2Ts5Maayo9MhBV+YIE4hh7hpdk2Ls9d/04v2/8rclIqrQ/Y1P26iz7
         ghXA9c0sRj0Bm+tiguJDCdIh5du02iFF9xMrgMHDBdLtKiVuGa/mQ9AfDWFCGhxrjZGv
         45S5fUlcbbw6GeMSmn0/qmfeG2JlUoDGkuMJcahMG3XXmLzWGTip7Kl4enRirZjjpZow
         MvSj3wSk1uNXs+qSuXrBrLqoeBXuRFddCp8wVysokgGZw7XWyT41EdsNB7CHXEJidwjs
         32DA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792544276; x=1793149076; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r53tKek5XAro3XIPieY7v1q8VJjq7ariTBY7WuS3XWU=;
        b=ruMg7oBd+QKJNGrS4eRdzeKTniD9dJVtBuaItZbF4rUuFEoXrxGAjtnHWFCXLsjoju
         OT2skSftBX37yM9TdWsJw9WGoa65S0wVXYSSuYdh4+dTT1dL371QxzxmlXEzMjEDOPk2
         bUtKsui6j1UiOk7pfbCNC87LL3P5rv0H6R5aGLFn29/DlKaTcgUTIC5FbwBwWNjjPk/Y
         VSLwaxHPTfQ1HI/uJHVSSFUETRCwRb5DK+A1ipKrxoHjIpTtGgrUKy4b3+JMUou2oxmJ
         CpXUtlOf5ohsuRqUHfnu0LorA4+pKYTVI1Q8qpLwG8szRs9E+q2P9d6YGURiJCbRvCFd
         BYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792544276; x=1793149076;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=r53tKek5XAro3XIPieY7v1q8VJjq7ariTBY7WuS3XWU=;
        b=rwlZbdcQ91XR57pkKRPNnp2RTeSq6U5123+aNKRzoc8EwTuPlFWAjLxceQF9AkZ+dg
         flMupBizyXYHH2gJ8Nw3icw9pl9ODxyT3h1JQ9r/DN2czvKA9rgdukG5xn8BDslHzKHn
         HHSjSIiGC9dT5dWG5YB4trkHdfBl41KJet14Z+eVKdqp5VMCXBTMOmKjtq2FXW6Y9XEB
         6VeIK7kObFV6kkHDyAHz8BPqhjwbfckpwGCKiv2pktl+P6P3vVMyYe7M7GrO4PU+FGMt
         bPX0cNsLmqu3s2VOzHJljplN7UO7lNE4biINv962nxI1oPIVTjSGZCzidUAGJUsWc2jk
         2RuA==
X-Forwarded-Encrypted: i=1; AKwUvBx/ngnzNiPNHMDcFGm6/vdTH2eJAjj7YQQEYpmpB40Vclp2S40Alen3XSU82AQb0CPQOuw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLi1D6vnzoemWdNi8BG3nmg2alr900xMUD3uf3kPO6i95Ogv+i1
	Kq13c7PP/wzoJrJgpaAWQp+B9UY/Z+JQWzeoSGfqmHM1J3TGTo8SDu1o2fvEZCWVWfSXQQR5Pfa
	9z7DVOAhNw/Exp6+cSEy3VOPe9Nz9Vn4=
X-Gm-Gg: AYBFou3I/FCwTJQ1uG3XCecCiNsFnF6T7HWRMGHuAzRxKjiqAv55oHjVOje8gPsbmpm
	sNecSFSzpvvZIeC77/L57W+vDF3SBnTOkNExf0JCZxu0+xBER8fLwvQ0c/PJi7jF5gLZK7yH5bU
	ngpW4mw+9IkcEtNR1XzoNjbVxG5Q/9XIMI2BcV66+0SlQ0Lj72oJNtUIClVbsEbPaWID0tVu5U5
	rkhDOc2c/IvnBaE/pXi7mNvUHCOOfHCdhJfIiZ3QMbm9S6NmuMANLBlCZYXqDR+e8+/gLNs+Lpd
	fd5byPk8K124BFWneS1pfWYy9vxkSl6kpbvOwZS1rhHs94cLkMtUnLmQikFOKjJtW63p9C5hH/7
	lTvSZsJO9EXQ0I5GhOrD//lFHsUhx4H6e3ZfW4IAaLlnFjcYXsdoGvFvYs1whjkFKGVJW6XUod/
	CzqDU/LC5YEc2Nqi2cpqeTOysdGJkEqUk4N6Yhf5NyBa/qEMnRNbC5revO4OVfdCuAq/g/ig8iK
	HZSkbnK9CjY9M4=
X-Received: by 2002:a05:600c:5252:b0:4a1:9661:14b7 with SMTP id
 5b1f17b1804b1-4a1fdd641ccmr6945075e9.32.1792544276298; Tue, 20 Oct 2026
 17:57:56 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020145059.2146170-1-utilityemal77@gmail.com> <20261020145059.2146170-6-utilityemal77@gmail.com>
In-Reply-To: <20261020145059.2146170-6-utilityemal77@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 21 Oct 2026 02:57:18 +0200
X-Gm-Features: AclHuK8Qw2bebhlFOxjthcAlLXFgpCgvnWRDwHYFLx-O3tPMva1ZTXx8_Gt9sHo
Message-ID: <CAP01T75VJXS6EnYbMguicH9vDbeYxzkAJMEYiBYZ5Cv8mkDJ=A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 5/6] bpf: Bind iterator elements to their iterator
To: Justin Suess <utilityemal77@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Oct 2026 at 16:56, Justin Suess <utilityemal77@gmail.com> wrote:
>
> An element returned by an iterator's next() kfunc is kept alive by the
> iterator alone. bpf_iter_task_vma_next() returns a snapshot that lives
> in the iterator's own allocation and holds the vma's vm_file reference
> only until the next step or destroy; bpf_iter_kmem_cache_next() and
> bpf_iter_dmabuf_next() hand out objects whose reference the iterator
> drops the same way. The verifier marks every such element PTR_TRUSTED
> with nothing tying it to the iterator, so a pointer saved across
> bpf_iter_<type>_destroy() stays fully trusted after the memory or the
> reference behind it is gone:
>
>         bpf_iter_task_vma_new(&it, task, 0);
>         vma = bpf_iter_task_vma_next(&it);
>         file = vma->vm_file;                    /* __safe_trusted_or_null */
>         bpf_iter_task_vma_destroy(&it);         /* frees snapshot, fput() */
>         start = vma->vm_start;                  /* vma, file still trusted */
>
> Set the element's parent_id to the iterator's reference id, as is
> already done for the PTR_TO_MEM elements of bpf_iter_num_next(), so
> that destroying the iterator invalidates the element together with
> every trusted field acquired from it. Elements of an RCU-protected
> iterator keep MEM_RCU and stay bounded by the critical section instead:
> they point at RCU-managed objects rather than iterator state.
>
> Fixes: 4ac454682158 ("bpf: Introduce task_vma open-coded iterator kfuncs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> ---

I would drop this one. Xu is trying to fix it here, which is probably
the more proper fix:
https://lore.kernel.org/bpf/20260927120406.1041915-1-xyx2021@mail.ustc.edu.cn
