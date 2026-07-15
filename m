Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A869434EF0F
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 12:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784117485; cv=pass; b=YUI1S2+CG7l7djMvif/fnl9EHGuJJjbaJPLQFZPAOhXBFpjydsF+OfiAKNpXEq0B7BlwbjEVgo8zkflY+1ewomDXDjXoyHgquXKz50HV8K1QYmqVXtkzyysTlJFWjP2SyQVHZSoVtTpZFNzcIZKGEQZHEIfiQarw7825y9KOFBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784117485; c=relaxed/simple;
	bh=zBloJ0QtWk3A3H2AxFXNj4KSYQYICNBst/8FM7XPZQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C3s0AemveO6zlP6rEMTZ8nnH3jdkxxy9sFQ8nJFu2U/aL1+Tug/XswyqyopS8neoxCN9LFsc7anXeD3O2PocybiXc7VGbex1RpXhPkRxJYFZ1H4c49UF8kQ8jTziuZygT0MbgnbB7z+Bk/lpCKF665NR5WaNRGPdMjSzZR8+bXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRjDKDHn; arc=pass smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRjDKDHn"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-4784b41f3aeso554680f8f.1
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 05:11:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784117482; cv=none;
        d=google.com; s=arc-20260327;
        b=STALGHDFCnnHd1xlteRYyumfeB4b2vsErbl0qJqNlGgAPGTqY+oEwjdorWcbnaD7rY
         Z63S+jH/ECVCWIKktKmRnHzqyU4UN5uQB0ixc8ZQvpZzazMQ579iHUm6v/SqiL7Pj52+
         jwTR3ZHu+Cw2C+5TA+6FelS6t6Lw9uC5AAqQ/UvWvNBnI4JiaTgLcKkC2BpH3gI4AMx5
         NvISr4K4EKlcfJ3pxR3jkDHwsTBSrcO+xRotj8le5Bj4rrR9TqpC5qW6FZeOz9/fL+Ad
         gZfpvhTjjmJxJ8WNQAoTLZGhs2OJMgsqxwPJQYRH0ipBp6jwlUyrmhvsj9ZNZ3cTGFNY
         8xLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zBloJ0QtWk3A3H2AxFXNj4KSYQYICNBst/8FM7XPZQg=;
        fh=pjVKc/pKCFOyLA09CivykIFgP0WDg8PDOf/PS01M18A=;
        b=icEevPWz7AXtS6TNPuS2im+DJmlG89YgGZDWuQPTfQwVdGGA5aKBqHiw87nQUgEdcg
         1uqdZr/pQXv9rWuLoY6xh4883LwIKMmXjQAGkWbg5biIzaSYftBgD+/YD5ZypsFgL+JN
         CZIkmrx5IKr43+ydfboLJEZ86aKiF3Qo91Y9fky8zv28seIquJH8PfgTpCfi8s2otkjW
         HQc9d4lb5jyHsefnjTjWKJuQZlL5tss/VvBUqLAKBqQ5CuY1zMDeeDzP92nAMNQK5gPK
         bZ1jkW4wX6byvvW4nHEkrxrA0yABzzLCGfg8TX+i1KtdBe6VHbFKJlLSnC2Ewte+WK6z
         glAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784117482; x=1784722282; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zBloJ0QtWk3A3H2AxFXNj4KSYQYICNBst/8FM7XPZQg=;
        b=MRjDKDHnSgayCZRdcOOYJ3DFF05uJ9L43hxV1w1JToWwcO6VVurVKGccIYSYrwDsiB
         uXb2J2DF1ldFxfwyWc4nrOsp6zjB7ZIQ1AY7k7Q/UUi4b0mo5Pq4Wb/pdKEQ1AcecQY1
         dyD6bUxB/YZfphucEan3ikG/evw12TRTNg/v2PYEpNwSbJoVETspKEwLOHQJkL5kw5It
         HUEP+xyFOEL1jClRUFsqk7tqHdLjs8eMBaFsfbplfKwGzUddMpCgQHCcyYc7bvhilHHP
         Y3DUCgt6J0DbRGxwA5G6sK4hGzRIsI6xDCJTMNW+WMtHpKOmjWVm4/H7zQse02Q2YV/u
         3OFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784117482; x=1784722282;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zBloJ0QtWk3A3H2AxFXNj4KSYQYICNBst/8FM7XPZQg=;
        b=KOno2x3hwEW4Q4kNmBEPYEGNGvwDSzuIz7Z7BGfuGXYAvXMkE3sGPOyVB+Pz0wKYBr
         6WzD3zKlIG5DjV3k5mzPDwkSQRGaIa5uVVNkDLKftS3r3izNvL/R81uqHfCPnyZ3NAQZ
         NgwfyyL+PRJg8dqwniOEm0SFbTTUxXPBhmrUrcRH3eoPE7YsHUp9KhC98uCuPpxSeiTE
         ijlgBAUa8G7nHjwiEau5ky/ePJCJoAT73Z/yTvWb/ba6L8BnuMw/5gwQP21GmT/Hg+G9
         RunIofSjQpizqD10ZmySOTkAzqTh9T7sYD9M8ycdFlwoJ6Vz8jBrhKilzz2gyKUzWmvR
         IkvQ==
X-Gm-Message-State: AOJu0Yybmtz+OqqhQ7UIXNBAoyIgnwbuVi838JmCkIU59AXnHo7N/nJZ
	0z3LeumFpoM8hyL6lhTuw0Npoyw6vHd3vptBZb+XoRsmQIuoR2Te574yg4r7LqF07Q3u4MjWW6o
	2fAsJ4gRjy+I1SlXVWkb1wJMVogZ0aRW70lc7
X-Gm-Gg: AfdE7ckrcCZvCOo5LSsa1d64DBbRlowXYG4CkgTbBDi1Eqn9xXhNLB2jzVs+3vYwUnf
	tt78MHqEeanMESsf1orYJT/gDzckKwJH9xvgWQ60ZxGCJ/2FWvCIw26yoFH6VZdF04u3Ba+rTRf
	v8/4lvLhTVTtlEBObTSW5Nap0co+IU8W05HR18QzSBly5OIEL5g+6nMDV/l7rhQ2kNrIJFMamCe
	S3/XTT/8lggLdVB39170m7p1k2JgjcmfsXIPwgD9RM4Y1iCpajwNwhkA9iDO8/QQLkDjDdi7Q9+
	4L4U6Jd5InTIc3YZHUeHVWceHcTOeNQ2B3HKd8gKlyvM3QrsNuSftjAWZbjhjsfiZTR4OZOHuwO
	Q542xT1hWRSAtRa5oVlcmMhQyPGqjYjzsIJZmU9G19gZF71ougsPeakmVioY=
X-Received: by 2002:a05:6000:240e:b0:460:51f6:6248 with SMTP id
 ffacd0b85a97d-47f2dcae6c4mr19941358f8f.27.1784117481725; Wed, 15 Jul 2026
 05:11:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1784112948.git.vmalik@redhat.com>
In-Reply-To: <cover.1784112948.git.vmalik@redhat.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 15 Jul 2026 14:10:45 +0200
X-Gm-Features: AUfX_mwBp8IsitKVqdE5Spc2sI-xSVe-WEtOns2KAaFap1XVo5yvgNV62ggUsIc
Message-ID: <CAP01T74To6X_XPeM5L9wN52QuL8oSuoDA3jk3jhR_Y1bLXH2Lw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] selftests/bpf: Fix compilation with RELEASE=1
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
	Eric Biggers <ebiggers@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Jul 2026 at 13:22, Viktor Malik <vmalik@redhat.com> wrote:
>
> When compiling BPF selftests with RELEASE=1 (which most notably adds
> -O2), GCC reports several warnings. These are by default treated as
> errors and abort the compilation.
>
> This series fixes all of the issues such that selftests can be compiled
> with RELEASE=1.
>

Are these changes sufficient to fix all issues? I see more when I
compile with GCC 15 and RELEASE=1.
Also, is there no way to make ASSERT_OK_PTR work when we're testing
for non-NULL-ness? Having to change it to explicit != NULL is kinda
sad.
