Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FEF43D515
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 19:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789588390; cv=pass; b=Z0RK57LMnCSbMYst/FyY+v3pkNR22GV4w04K0GgTZoXgbqxajVQrt4IaczCBHizs86MCXkrFwDozcaCQB39MACdHkk12xVj/lVlW8GjlZ38nfqMvpweDRm6gnwyO2wsTZ7PFsWSp6jPQLXvOE/0Iej2Yc2BCvC3PKWCyNJ1P0Kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789588390; c=relaxed/simple;
	bh=zTghGTdbyeydx8Wid5usNdwqytH+bR1O2o14u8bxj3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nzPbZOmwCQ1WhCYv6kT0ne6J8HGyx35Uk+pTQ/lyiwlG85pmQOK25V6HvnDjb7QJv3aYFuClGLCKCJwnghPyn8wPoIC1ZNuJ1ZXMB7nAeDpfm49kLLwLW90Scs+tbfole2RPlmcJLeUxECyEDJrtoDM2spQSNcK00evC5/FtTU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3+36bHa; arc=pass smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3+36bHa"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-46accbdfc20so6422fac.0
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 12:52:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789588374; cv=none;
        d=google.com; s=arc-20260327;
        b=pEVb11GItvPKDFuZWGYLM4wThhLvmK+tVhBKl6X5n0RuJxoWIQ2kH/VnQaZHR7Sv4k
         1GvObe93MxCitA6yHVve0238wp4PfV+EP20+Q9D7Bc+CtpPgaxIhThnweH14TpWP2bm2
         k6NL8tTSRHj/gctJBM4vsVzJ19b2xL1QCyHPyO91iV9gMYHLLWihy+E4Nqg3v7qjkBrp
         HWFPnq8ACdEphhXqGplp+r+3Bg4uuyLgBsEShB6OGZfIMEQNmxt4EroaA2DUYWD1TNTq
         e4jw+CmS96zU3Se/mVAXnTP8Ub2bRCZKRmnBfvRyffjjXl+QALid4kjdBaoEXwxPVJ68
         d+eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=faL/nQgAEI6ymcNvYqDJu8YvmnikycPXiUujSWHS1ZU=;
        fh=7K2qWJ3mUiPSelnihIFryY3l1DriTibHaNVcRL5iMOk=;
        b=WgueGKXoRURHAANCvvW1ao9dNklTdGk3GrO/VT6D+/vbV8BTM6sEdFBuYjT4OArR1V
         rM9xSgi18d0VjiciRQWhUdyQvdc+4Gq+Huiin8HvF1mneqVDqpJmwWGobMeCNI0XrJ82
         bFEklsZV+E41n4JgKat7ISSRPVRDJ58Fy1VVbgBE3zVZcFHZ6YDrF+dM3n7vIwk0GJHU
         qIViBOIgY0QuddaU6P9qN4IVi1L4uskRtGfoGpQA1AsD7b1/pVDQyi4+CNjagyz67yHk
         8arL2dGS2sdTqKQoarZE9paAkZa9hdkaPWCXBk5iSFK7fEAAN7jxC0O0xxLw8ISCowst
         +Nog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789588374; x=1790193174; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=faL/nQgAEI6ymcNvYqDJu8YvmnikycPXiUujSWHS1ZU=;
        b=W3+36bHaiOyBoVyO1lkFmrERYvIpIp+b2kRP2OAQr2WzjQka1B+Km50JwqJ9Ox8Myl
         2wV3UNKDTYR1fgfbyVvN1qA/srOxT4Wdz/jApy4B43QzitzJblZrUMu0383qbBBuIhUA
         1IPwyn+wb2A9fysK9vwIGonb7+jyWTdUzu2Rwrz4w4UV2x72LXWANlqjxzGr7J3cn7fV
         EAXGxOfUUvzPi62A+7gvZu9HgTNsmsvd7GFpkY7tsodo0zgtw+AqNxyNWq/OjgOHY06Z
         R+xTcLxaIoTJDFT9LhXrRBq7mssx8EdXeJJSqE1fdSwh5ZAwj4+NNCP3u+iG4qxPGp57
         GMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789588374; x=1790193174;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=faL/nQgAEI6ymcNvYqDJu8YvmnikycPXiUujSWHS1ZU=;
        b=Fr+rvvXXbOm9/q9+BOEE15dZ8L7qo1XTm8ERu8WFKYvB2Y0egawmJenAlPiKkO2Y6D
         xHwqx5Cnd5oX3V4kOgJvhNGVoS7MFwuORiYzCuDYIGFd4Tafq+NZDP51xxp00M8E114M
         6Oj8OC5P/ioIYSq0oXXQ8FGh7Ee0RWdvCJFW0CgP35XBlHXAc1mwADeG2EAn3AYJrQZn
         /rQX+GhLqrVKfmfqUeWvWz3uvWC2mImLuYx8bzxmXjw42pn9+3tp20jc2iOdZn3XYJY6
         1U9WddqJCp+E534bKKcgdtKiBZVkRKeYVBLBzMADdQwtlM0YLC6oLExqxTNxtHV5Ul2w
         DZCA==
X-Gm-Message-State: AFuF++lvn++Mwhxd/niCQxSilCiJBwM7fH+39VpbjrwUAbpaKc6du6r5
	bP4rcx9OoArME9KUvznPjYnNoC9PyQFbIoG5Enu9Yaa99SIFR40AY2yycQq83q/OjzkaduoQWCH
	EDaf5aMFaqx9ecNH5yqAzsGOI4CEIpJI=
X-Gm-Gg: AYBFou1HQor1wE3OcsxSvFSf2/f41hXgVzwyfR/KyPdlZaiY2U0Q/bhVv7UBJZkflP4
	M/XFJl5Wp20Oxr365JjSlhkc5YAwRdgM9/RfHSmOQDY9Wtfttcy+br7Fo/OcrMS+WiJU1C/A6h0
	fGZg9RJud82lPzh1UTTvjCDhrzfWFmRJPlUv+PuTFV7yb0wNPJs3s2J0h2mZZVTbfOqduRroaDS
	B8w5TfdHlvfHxSY8Z076fJlx8djbGCimDy7mliT7Ew1MrW15YFnshSwI90XJyZCOQ7D++4FBI38
	bEXc0rcpCWN4yfmN58rIGkwbHPdEzrKWFtNrcgDnLgooicxRAac6xiZrhNam7nQs/g==
X-Received: by 2002:a05:6808:14ce:b0:4cb:818f:d570 with SMTP id
 5614622812f47-4cb818fe21emr574967b6e.24.1789588373660; Wed, 16 Sep 2026
 12:52:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916192805.3991983-1-memxor@gmail.com> <20260916192805.3991983-3-memxor@gmail.com>
In-Reply-To: <20260916192805.3991983-3-memxor@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 16 Sep 2026 12:52:42 -0700
X-Gm-Features: AcwNN1WaGBAYFNJpwoIlEI8TGR2U2H1OEJlpuPZlrAWtB6XzFjr4rxw2eLDu7Ao
Message-ID: <CAMB2axNg4Gb-h4s+hJK7K0gYkdm+4RhKJ6Fdrp-=veuujE6fEg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/5] bpf: Fix generic __uninit kfunc output buffers
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Tejun Heo <tj@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

>  static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 prev_slot,
>                           struct bpf_call_arg_meta *meta,
>                           int insn_idx)
> @@ -9176,15 +9190,16 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
>                 enum bpf_access_type access_type;
>                 bool known_memory;
>
> +               if (meta->btf && (arg_type & MEM_UNINIT))
> +                       meta->arg_raw_mem.regno = slot + 1;
> +

Nit: Ideally check_raw_mode_ok should take slot instead of or with
regno and we don't need it here, but it is getting larger than what
the fix needs to be. I can do it as part of other func check
refactoring if you want to keep it as is.

Reviewed-by: Amery Hung <ameryhung@gmail.com>
