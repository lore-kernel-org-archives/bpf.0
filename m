Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F381332EC8
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 06:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775196994; cv=pass; b=iHB1hCGCeDSh9d6ppUIuSfkgz7EBs4QeRNjDHieiLJ0Wwfc75kHeEiKe2UXSYhVYJUAYaJZRpuQbkEJexGBqAqtezxh6b4w97H97QSDbVRdonw29UvT7Rxsr+QZqs4UId0Cs8Yj6sfaEB1FfsxK0JQkpZieqo3bqvEhZoy6wifQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775196994; c=relaxed/simple;
	bh=B9BBapPkK7q0+rTMkDt8pdFpp2Gl6RKrLrGR9Jyd4/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mAm8+CIoIQeeuwIk43Z6a0vHzVFhAImxcXaHE6jvkjiDnvDChwmcTbDDPnX5NWSq8fL/8eC28jzgzKEg5a74X3VLaj3sAilyVapWXuSwGZSf65Q2avgUO4nPbdvjdUDjjmWM8k4nIysZn95g9XpbsG+Dt8LWrpsPsyHliuIaAxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmRtRAfu; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmRtRAfu"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7982c3b7da9so14869777b3.1
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 23:16:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775196984; cv=none;
        d=google.com; s=arc-20240605;
        b=FSy71zMmPUSVs44WFGLXBLd9iVE4vp0lTB+yIiA1FlhBFd3aNtS8sPCX4VzjXLA9Cy
         qL+lXn69etACQqQ9ysRtwDZDxyqCIxiOP8zDai4T3g/7kUE9QVz7eDQTv8WlUAhvEaRS
         1kJ+ToPQQTVUjy05xkXmxc+fiyw7GT5rwzWfpe8TPT5Ym7RQ/r6bDEuakTdEQasGWnYv
         B+oWhI5ZKFeMklRgwBuBvoWgPdi5lO4mfCKL+AQ0wdEIYkjwRrkXWFPnoxx+zkXRp3j/
         hF5WkMHMV6yHvMxq3Cm3tnVHRKAsXbomG/HuaYZ3OzEjZpmL1TRxdqRxqszGkYbtS/IT
         E18Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xps4tkn7ECEWtN7tObOijX8uiYjtuFmF54bG3q387JE=;
        fh=DKYSdQLkv9e9r2x+/6tJ23L2z/KCWNs6W3ZbOOc0quY=;
        b=RiuuXwMgJEJzX4JnQmH2duE7Qipv+7rR7ruIb0GaNS+VpAqkf3P0q7qReaO0XS1JY4
         39b5AymuzdxpYMIIJbaySuF6LpzKVBXxiCH9GEAUEcPMRlkZh8976OA1SB/wEGBZpMQU
         hSLPsza3stCLnHBp++UpfI69gD1nneC5loEEMh9qDMTJ1nZ6xFAvolg1dteDLnm7DYz2
         qP53A+9N1h87ynvUW+4kkAcDG5fQ3idp90fymn9j6PjtVUDkritWqid2oKhr+PlKsVk0
         Jy8upuSf04P/KdH/tdm+5vGzHYjWrlEMiqINSavkT65X4Wt+VfbiOWLAU6uXIc9bBnSP
         gh8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775196984; x=1775801784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xps4tkn7ECEWtN7tObOijX8uiYjtuFmF54bG3q387JE=;
        b=ZmRtRAfunytD2F5DKaJnDsjmxm3LkpHueUA/Pq2ivmsNST2JMWHCEmsuIle5OPi7dN
         CEFHih65gDW/YI3WCSybe4e9IohhaTuk1rPw6EanvqJma6aM9ZSvbbEHdfCx/1CIPgRC
         0HW4TZgEBcI5ARqXvzHz1asd5f+vtd2Xu/H7AG9CdpiSzMp3GLIQV5FjK0bsRHFqnRuS
         rYm5it8t6ZKddkqQuY3N4DpQbdj36PtKKY7k0y0g1UxAL2cMwpmnugV8bCwzoYO7NDui
         ojtAJOoUFH4UUVPV5ZlwZLlj/6u3czXIZq9st+4Jn4Zfj9LPSh2AeSVLgMTzNUCv8qdm
         HCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775196984; x=1775801784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xps4tkn7ECEWtN7tObOijX8uiYjtuFmF54bG3q387JE=;
        b=eehwrQYDIjcCTozfQb251CIXO83zNJ5YD8vn41tcBl5MbYazJQvmdV3ed5Tj23TNxP
         +rYdT17/1rlWpX5Y+SNKqCg8VETDU+KtRVooolkD4VtPD10pIWSFIlJaJBEBYHb/zImT
         ecbOsHZL+VQnXfjLiR4Snvq7CBlTvakqms2KjnjUqNL7u9nVlz3xHwE694im0U2IQwzB
         kCHA32TdeQwHrAVg51VFYkXmyzu+I77f0Ja2GobFPdcn3KOJriFr1IPAgSWf67idvt2a
         mr9o1dH1rDWZ1bYv+1+IWbCwsyk0UOFqggR4qQqU4015J0rIHX+ni3FwN6k5dErxEbOk
         6Nkw==
X-Forwarded-Encrypted: i=1; AJvYcCWU/PjGyRilnVoQ5XlVn+HfBg4E6sp06WQ6g/6dxms3wKrvVU1MECApKN0g8iOQIzx+wtg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3r6/xntwGIzbVgK8VTdWrakrfFTC7eJUxVx+RfhwyQ6ht0zQN
	OcgUf2SCZY05ufW+Y6hWjDv9CYaB6TQwoEm9neOnUIMox7PqCFKwv6pLRH7EHMwVtIjj2OEKf4O
	XNCLD8CdnrGE5hSbjjS1cA5JD8WSiDxY=
X-Gm-Gg: AeBDieu/3poQKIl87/ivKS4TmF5EU377JYfET31NrmWtf4bPsgvRubmuiqxyKEjyh2e
	1LeaxjNFkJLmdOzZhdXRlPl5V3K8/eHuQdLjwfKtgW2/x440hWsLVHc5E8NTdacfEg7/NoIkWiw
	Fw/2657mpPKyoTDZMaoJJfRjWLW2d6lKIAIWb0FTZMWdOAbsfK8pO8hG8AD0I6he9VIBbtX+wdu
	6hQ7Q4Jyr1TNQBDP/sFDdOLDiSuDMDTMx8MhJx7iRdmCq7kYqS8FnUGd5rY4IvGovJvbZThvSjV
	o3TE9Bk=
X-Received: by 2002:a05:690c:25c1:b0:7a1:523e:93f6 with SMTP id
 00721157ae682-7a4d5d5d817mr20134517b3.46.1775196984177; Thu, 02 Apr 2026
 23:16:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403033828.18529-1-tpluszz77@gmail.com> <20260403033828.18529-3-tpluszz77@gmail.com>
In-Reply-To: <20260403033828.18529-3-tpluszz77@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 2 Apr 2026 23:16:13 -0700
X-Gm-Features: AQROBzD2p06zpd2eXJPiD7ciPal-CovtblRquQIWjCFORgukUiYOiX1-241jVmA
Message-ID: <CAMB2axM92J40zq2VejrMYMs-6vPcPEBkJ8WCuh_9ymT0ozhyUA@mail.gmail.com>
Subject: Re: [PATCH bpf v4 2/2] selftests/bpf: add test for nullable
 PTR_TO_BUF access
To: Qi Tang <tpluszz77@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 8:39=E2=80=AFPM Qi Tang <tpluszz77@gmail.com> wrote:
>
> Add iter_buf_null_fail with two tests and a test runner:
>   - iter_buf_null_deref: verifier must reject direct dereference of
>     ctx->key (PTR_TO_BUF | PTR_MAYBE_NULL) without a null check
>   - iter_buf_null_check_ok: verifier must accept dereference after
>     an explicit null check
>
> Signed-off-by: Qi Tang <tpluszz77@gmail.com>
> ---
>  .../bpf/prog_tests/iter_buf_null_fail.c       |  9 ++++
>  .../selftests/bpf/progs/iter_buf_null_fail.c  | 51 +++++++++++++++++++
>  2 files changed, 60 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/iter_buf_null_=
fail.c
>  create mode 100644 tools/testing/selftests/bpf/progs/iter_buf_null_fail.=
c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/iter_buf_null_fail.c =
b/tools/testing/selftests/bpf/prog_tests/iter_buf_null_fail.c
> new file mode 100644
> index 000000000000..ea97787b870d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/iter_buf_null_fail.c
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +#include "iter_buf_null_fail.skel.h"
> +
> +void test_iter_buf_null_fail(void)
> +{
> +       RUN_TESTS(iter_buf_null_fail);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/iter_buf_null_fail.c b/too=
ls/testing/selftests/bpf/progs/iter_buf_null_fail.c
> new file mode 100644
> index 000000000000..963a4cfc33f3
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/iter_buf_null_fail.c
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Qi Tang */
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_HASH);
> +       __uint(max_entries, 1);
> +       __type(key, __u32);
> +       __type(value, __u64);
> +} hashmap SEC(".maps");
> +

hashmap is not used and can be removed.

> +/*
> + * Verify that the verifier rejects direct access to nullable PTR_TO_BUF
> + * (ctx->key) without a null check.  On the iterator stop callback,
> + * ctx->key is NULL, so unconditional access would be a NULL deref.
> + */
> +SEC("iter/bpf_map_elem")
> +__failure __msg("invalid mem access")
> +int iter_buf_null_deref(struct bpf_iter__bpf_map_elem *ctx)
> +{
> +       /* ctx->key is PTR_TO_BUF | PTR_MAYBE_NULL | MEM_RDONLY.
> +        * Direct access without null check must be rejected.
> +        */

nit: consider kernel-style comment instead of netdev

> +       volatile __u32 v =3D *(__u32 *)ctx->key;
> +
> +       (void)v;
> +       return 0;
> +}
> +
> +/*
> + * Verify that access after a null check is still accepted.
> + */

nit: maybe just one line /* ... */ ?

Reviewed-by: Amery Hung <ameryhung@gmail.com>

> +SEC("iter/bpf_map_elem")
> +__success
> +int iter_buf_null_check_ok(struct bpf_iter__bpf_map_elem *ctx)
> +{
> +       __u32 *key =3D ctx->key;
> +
> +       if (!key)
> +               return 0;
> +
> +       volatile __u32 v =3D *key;
> +
> +       (void)v;
> +       return 0;
> +}
> --
> 2.43.0
>
>
