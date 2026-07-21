Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C6D415F1A
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 19:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784662573; cv=none; b=Fuvjv6bO8mNPFYlXOk62k1E2rccK1eJqan8gFr5QvTSUdLaJH9/T2El2XhFkOXipfplx+qroPRYLYZQyhZumcM13Qv/uccdsmjJZpJz+DTL+J54PoCBOZz7xvSvBpN1HCfCQSt9TyV1okGqAxF5K1fy0P8rrhO4hBMl8MhDkLnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784662573; c=relaxed/simple;
	bh=BWC8c22UHleyRyD/yXsrwfjKbp+TGQNcyjVRljujR1o=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=QXXq76w+aSQ3TUWQRyKuUBZ3UWwiJkOECBEVamUy7bw1PpyG0SbeT8utSU/iAyRNvhf3gGhYV3T8VKbNyB8DKQWsxYC272hXKLq+KDUbd50LMR4F47LP1C7tNXuMJiaMQcdoYWKMlzMQXz+zA8AHQwboQpzjxHYpZkRJOg/f6aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyTj0SlC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyTj0SlC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB051F00A3A;
	Tue, 21 Jul 2026 19:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784662571;
	bh=ZecRTLqdTNG8UoQang0q8KvRu1IyS3JUvtytovhcjOA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=EyTj0SlCWInOk/P8ZB3CpbFg0VfXufHHDKt2WQ/H3p2zTkC+SpCgvFbagBy8cn5db
	 oBKIpOgdukWPRyoSmUzTJfHjqMHNErgPbykJa9gg5cXVzAc1/I0DH7FfQRklE7VSZr
	 ONxFbAdPJ/zpv07gAo/XVgqwf5Vr9hjN7aYHOTjB6D4EvL2RCT8Ex9yFNP+7Xb+VY4
	 gaGEdMu/pRypsSb5BEEgjwNG6ph5kNqvSwadYCfRbw/x2cm3FWKOZ4zG7GBQ7rC6+O
	 cvoyrcBZQyfMg9MZIzitai+0j2SdfIM7Dpk8Q0UYJBpmEIMNsDZCkuYxKSBbvqQ7pv
	 frHJECfzo7SqQ==
Content-Type: multipart/mixed; boundary="===============3737622020390923340=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <abe2224f7327a21cc821cbe34c233800ba7015afa2683adb2d4bbbf927567c0a@mail.kernel.org>
In-Reply-To: <20260721185705.1365329-1-memxor@gmail.com>
References: <20260721185705.1365329-1-memxor@gmail.com>
Subject: Re: [PATCH bpf-next] libarena: Use compiler load-acquire/store-release in bpf_atomic.h
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 21 Jul 2026 19:36:11 +0000 (UTC)

--===============3737622020390923340==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/libarena/include/bpf_atomic.h b/tools/testing/selftests/bpf/libarena/include/bpf_atomic.h
> index b7b230431929..ec8d606e7ce3 100644
> --- a/tools/testing/selftests/bpf/libarena/include/bpf_atomic.h
> +++ b/tools/testing/selftests/bpf/libarena/include/bpf_atomic.h
> @@ -86,6 +86,21 @@ extern bool CONFIG_X86_64 __kconfig __weak;
>  /* Control dependency provides LOAD->STORE, provide LOAD->LOAD */
>  #define smp_acquire__after_ctrl_dep() ({ smp_rmb(); })
>
> +#if defined(__BPF_FEATURE_LOAD_ACQ_STORE_REL)
> +#define __BPF_HAVE_LOAD_ACQUIRE_STORE_RELEASE 1
> +#endif
> +
> +#ifdef __BPF_HAVE_LOAD_ACQUIRE_STORE_RELEASE
> +/*
> + * Clang advertises this feature when it can lower acquire/release atomic
> + * builtins to BPF_LOAD_ACQ/BPF_STORE_REL. Older compilers keep using the
> + * barrier-based fallback below. The generated instructions require kernel
> + * verifier/JIT support added in Linux 6.15; compile for an older BPF CPU to
> + * keep using the fallback when targeting older kernels.
> + */
> +#define smp_load_acquire(p) __atomic_load_n((p), __ATOMIC_ACQUIRE)
> +#define smp_store_release(p, val) __atomic_store_n((p), (val), __ATOMIC_RELEASE)

Can the __atomic_load_n / __atomic_store_n form here handle a pointer to
a struct?

__atomic_load_n(&some_struct, ...) is a compile error when p points to an
aggregate type, since these builtins only accept scalar-typed pointers.

Would the more generic builtin form work for both scalar and struct
pointers, for example:

  #define smp_load_acquire(p) ({                     \
          __unqual_scalar_typeof(*p) __val;          \
          __atomic_load(p, &__val, __ATOMIC_ACQUIRE); \
          __val;                                     \
  })
  #define smp_store_release(p, v) ({                 \
          __unqual_scalar_typeof(*p) __val = (v);    \
          __atomic_store(p, &__val, __ATOMIC_RELEASE); \
  })

> +#else
>  #define smp_load_acquire(p)                                  \
>  	({                                                   \
>  		__unqual_typeof(*(p)) __v = READ_ONCE(*(p)); \
> @@ -102,6 +117,7 @@ extern bool CONFIG_X86_64 __kconfig __weak;
>  		barrier();             \
>  		WRITE_ONCE(*(p), val); \
>  	})
> +#endif


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29860654839
--===============3737622020390923340==--
