Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559D78479
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 23:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772839983; cv=pass; b=UXPzwQRWuu589WJnCRkkGzR+jD77baTPRwPj46GGRfYawE81YFjjT17N52EkSjFljpOlysrMIGCJRMo4R1uf5wR6kUdD8IVvt6GJmXUKn+4BONuhXCeDdMD/WKGsthMsQ4AUC6pDzGq0ZSBYjA0PY+iiX6GBn0e7jx4w3lGpWNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772839983; c=relaxed/simple;
	bh=GAG42XAwyHGbbWGTzA1MHefwif1IVyaW4uhT2QNu1WQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hFfRJP3KHLq64zxheODwHEhlfSja2lmnOAb5UMl6XmyTECFW9BMipM/akKacCEFiZhtB/J210zI4/gEIdlusOKREVSH4GJjMeSbVhOI7+XWDtntbBiHvzojMETUXQnXpfTq062CF6cU4CiT8RHoDbvRpPVzPp/ksPTGvKV6xBa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDAbVRni; arc=pass smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDAbVRni"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-439d8dc4ae4so20172f8f.2
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 15:33:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772839981; cv=none;
        d=google.com; s=arc-20240605;
        b=inpXJ+hg6+rZvyBlkgpfHKwcGNdXz4XGAbm1p4TKGGIaZuxERtpX6t74oDFjHZ9v2u
         DEgTBJ3noLIbFQ8+2UxQz4Kv3snSP2CdQeA4juTXx5SUegqHo4UrsdIC6AsUJLcZeKXj
         Rp8sA95NtpMASMjwKJ8Rkd5z7JOpUsgubG7aqWF7PbtxPxjcYeqh1E/3Avhf5JEjeoBn
         RHpylMJR1lB7Q5Ot/l8u6JjD5vqp6nS/I7WtJhLQ/5+7OArgr5bSeYwZI2MHNPnpgl/t
         Y6RkqiOzezxxCVRLQUDReP8hKE6WeRlohU5jXFDF8HC/aeeN1fQKLd+pDM4YEqP0Ynbb
         TQ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HdPKnZ08rn8Otek8NqTQZGuarmmT38zrgns5XcPHT2E=;
        fh=MEct/d8NKpm6pt/9Obyk0MQL/GaXXCuHWz7GYStOj7g=;
        b=NuWgBDvH91AT3MxxkcgWQHbI5vF6fmHctupeHAQaorQxASvmD+JrVhhrx/3BHZVkMw
         L62qt0kI4GHkl7Po0A0d0DHEAnEUlxR0kIY2I+6MLuu6UK+goTubRgf02lhNEvb5QTTn
         +Fa6O3GeNOMTyDxb6eCB7nLKWn9526/xnVkpvF7xxNSdGqBgZnTiYTXhVKNXpB3j74lE
         PA6QzgGQOHkrEOiUonXcekBL1lRsmoiqhCOR/Y4eLkooF5ADnWHe5Wvkj1bP+ZaHmk/b
         5z/POY/BsqgKSRHzOwPDJ9/rb886T98YAxlOjFaLzTIJWVhi5CKDzO2lRrDwYiPyXwLD
         0Rvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772839981; x=1773444781; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HdPKnZ08rn8Otek8NqTQZGuarmmT38zrgns5XcPHT2E=;
        b=LDAbVRniouFY38cdReYeJdLMplYTi2R3TfLciahiqbRj0Dequysga5M4dwvWp8lm2B
         7jvh7OEpHIoWdac2BjIpzYMdl7tzcr3pO4HycTBssgfc3mKhmX3x3W4tJ45iMympAaC+
         WeQu4QerSauR7ZYBy9OaJup6eoQliU3SuA8G5FxDCN5M58KHdI5++4N9sZ5BFimeDaWg
         aaDr0GtZ4RCVeM4UDRye/2xKjGLdAsrofRXF5eMRAuuZ+0hpHdO1R/2wjcxNvbEejiB8
         XXsjEr/tcaq70rC87HzHb9Y+P23IBIOFoCtU/6j1tJhYiRarHGKn0k7Js4J6YbDyW+cE
         SEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772839981; x=1773444781;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HdPKnZ08rn8Otek8NqTQZGuarmmT38zrgns5XcPHT2E=;
        b=rZJIIwi/eE18x+xtnuxSOBON0cB8Gj82wkv05eSfPd82SI+6hgwovPqH2fXpt1r5dA
         dC7cCSpsoN2LlbAMx/mItoyFjhNEkx/yDRBzc90vbqqCQE9ORDSymkvII7FW4f2yFqcU
         fE5He32awazDifPCOBnNSlEJKRmlbBQcqUPNFUZ1EsacjY9wka0pga+SlYYajW8BGnf1
         yhPyKG4ZdTjllHw/TYggItae7rQAUwZ3PKxjrCEwxWgIGlTwGqF42UzEYmz6wwKumbyM
         MAWZsW646GGyW70+zl6qkqRC3kWS6e9i0R8fm76wBwDZ6Lq6Xx8qfqLIDv/h18d7Mb7H
         MUFQ==
X-Gm-Message-State: AOJu0YzSAAtvSk5QhTnFCbYrH3fqFGgOgtJWnHMl5fAZntkqpg04oIxx
	7+eLb+/jDZiyt/2H6/dDn/R7c/gH7mFj1DosifPNjNWdr78zDhLhPjZFAIe4iQmHfdDJVtbNM06
	SGvMFgiAjegUgx1JAuZPzk6tZaF2/97w=
X-Gm-Gg: ATEYQzyYZP2qxgt2KhkpXsSKCCxK4qqSwarOhMkudn2i92TeE0SfjUE+P8XDFhYa7BR
	5oEDrEF//2Pwsmpk4IGPZh1rTXmzPSfYnicLjIL02qcqJ7GTa9KjKQSW0iidLQj5PsWNT4MhwrO
	5U0XpjuubYmFUeIOlY+VL42Z/v3AsywMPfyfEFnCYGS8ko61INN3SoFHCmva2D1LtvG3AIl4+WI
	MXo+TxSwfOkDIkL3un38cpZ9nvZQuUm54qf5wt/C27fupk2/GN4prVY41dtk5cL7YamXeLjb+Hr
	JoGGPbuDazjpAM22p2ruqdPEQl9wXhF0dA24XsjcFbRil/EjxDHKwMQlAMc=
X-Received: by 2002:a05:6000:310a:b0:439:bfbe:da2d with SMTP id
 ffacd0b85a97d-439da86f6b6mr7465526f8f.39.1772839980534; Fri, 06 Mar 2026
 15:33:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306101628.3822284-1-vmalik@redhat.com>
In-Reply-To: <20260306101628.3822284-1-vmalik@redhat.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 7 Mar 2026 00:32:00 +0100
X-Gm-Features: AaiRm511qSTl6z6C8A5g_TNRlopZ6f00yEzVmziU5pIIWZPUtK9gmZ0OPGC6p5s
Message-ID: <CAP01T77DVjQCJ_=CC-Ffi1UK4bTXCONTJ0D1Qv8SdOzONA01uw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Speed up module_attach test
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Shubham Sharma <slopixelz@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Mar 2026 at 11:21, Viktor Malik <vmalik@redhat.com> wrote:
>
> The module_attach test contains subtests which check that unloading a
> module while there are BPF programs attached to its functions is not
> possible because the module is still referenced.
>
> The problem is that the test calls the generic unload_module() helper
> function which is used for module cleanup after test_progs terminate and
> tries to wait until all module references are released. This
> unnecessarily slows down the module_attach subtests since each
> unsuccessful call to unload_module() takes about 1 second.
>
> Introduce try_unload_module() which takes the number of retries as a
> parameter. Make unload_module() call it with the currently used amount
> of 10000 retries but call it with just 1 retry from module_attach tests
> as it is always expected to fail. This speeds up the module_attach()
> test significantly.
>
> Before:
>
>     # time ./test_progs -t module_attach
>     [...]
>     Summary: 1/14 PASSED, 0 SKIPPED, 0 FAILED
>
>     real        0m5.011s
>     user        0m0.293s
>     sys         0m0.108s
>
> After:
>
>     # time ./test_progs -t module_attach
>     [...]
>     Summary: 1/14 PASSED, 0 SKIPPED, 0 FAILED
>
>     real        0m0.350s
>     user        0m0.197s
>     sys         0m0.063s
>
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]
