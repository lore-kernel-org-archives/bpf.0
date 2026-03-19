Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE2D382296
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 09:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773914302; cv=pass; b=ufXJSD+fXqjixyVgsAof73B8KsD5Prge+/FWJat1qHCwOk/JW1aUL2tC494zxxZe1tf3iIFaj4n+5POEaM3+EtKHzLZvxU/JB+iYUKjJ7byO+SE8ajfoVv2LAKpg9zy3QNQnvmG2MiVg5cSv/0b9K8oIZIfvX2Tn0U0xHjqP7jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773914302; c=relaxed/simple;
	bh=RdcyDwFedRwGBiSQz876ReW4rzxY/yJG8zzpS6teUUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IE/JXFAWuuiKfDo/CtdSC/guysqJMh5w4AYdA2P0DYEO4EV1kN4u6eQf3yzXSSPhwpwjvapxRt7FrQ7J6QMw/d8F1U7YZb+h0SY2xqnH6Qobk7Pbf3hIk/zTcTGpTebXRsMFVinfhQofsnBkFR1CWS9rNyIEgU4UTIbWT4KLQ6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCew88sS; arc=pass smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCew88sS"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-439d8df7620so315767f8f.0
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 02:58:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773914294; cv=none;
        d=google.com; s=arc-20240605;
        b=Ohe3rHVUdfnECkZf/ZuEDfNfaywXBL6ocJHBLnDTPtZnvGdrj40itUs4ZKd7rmMwDG
         E9JSjkjdX5dTjMjq+b6eec8Z7sScYZDDGWAFI9dS+HuCwe4cRl8BRxpYlUnBrJXFBDbJ
         Yf8W+5ElYPOp0zVDiKd6Jtb0gHAutcOPaAJqHUUKYd5Pu7wmPpsxOX3wtoPBGupc3dUW
         w6NHnml37nz1NX3wNg2Kp98VN9Jbe2mtYGcOjrzixQlhgEPdDnMAjSQxbzystl42eGXk
         o7oQpS5HBYc6Tib3SVj8WS0U7kzeQtC4Oc6WjmbtLyCAwJwlJ+3/V6e7E2qZ1AMHL2re
         V3KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RdcyDwFedRwGBiSQz876ReW4rzxY/yJG8zzpS6teUUs=;
        fh=9rZEFXSj+Sx7COWuTKX+eSx5GFGRjzIRjZ8kA+rKfks=;
        b=MgfVcyP7ucVPHzX6roWvKXmBgzhOuzHnCCOa7ByvUDQmx+FSbuqJeBwrxb+H0cwgwJ
         wwt5fDupJeKjQcdie48fAKN88PD9FXJWfQlt3+EdYYjy80g2hSDXx8PLHGPg/xHhXLte
         VR2Yqgyyn3eLIQlY1df+zKXnWZnXlHJVdqCdqHcyt4cS5Wver+6off5IAH+2O3pmWGFR
         HUo8pVi7IwU4tjgUQj4VhAxhgmpI81TqBKYCXGrzA/9Kfvj2/ahrhyvu/fdAWkLeiCoB
         KUfS24+OMtTZD/VRrT9hhNx+vXeF0+Y0MFQvn2hjKiqWTT6lvrbPrg6ssC/kZaK1guQ7
         LF/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773914294; x=1774519094; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RdcyDwFedRwGBiSQz876ReW4rzxY/yJG8zzpS6teUUs=;
        b=jCew88sSrcSmBsu3PfIP0bdggYYRYzeMD7fDFScZAGJomMCT7kWIiNbuMMHxnNLQnF
         MsbyRGz/NXty4eb4BQ9lRmtPYUrOSHZD0ZqDnjAckAgJR5M+/tEMNmBkOz50W0Mdw60R
         yAfeQDvywiYwW7960YTVLtjy9oUVcHFNHyJ5hkslRmsc09Dj3E+NJibIhao61J1f4SWf
         bXkUN5jq/RKJUEmY4oh4xPgveruHcfI/LcRm8DvNCNe6H2/5oLE2jSaPzkmud4INm4h0
         rNN4fqzAlyYTQiWjBR0WS5wzwkO4STmjk0qfqmqY4e14kfVOM7MuoW9msYqn3n7nSjEn
         fxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773914294; x=1774519094;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdcyDwFedRwGBiSQz876ReW4rzxY/yJG8zzpS6teUUs=;
        b=IZSytduFjy6FpD3QFblBCXrU8qk4QxeMrtcLwHvM1pC9HUeOYPeQEMzOUamqPxmzgv
         bUfjv5RPDMDmUnisL3VNZvFPaWXv7PDaujqLa+xKVnk5gZc5+j5Qgch0BR+asHCw0/2+
         AAVaCU8UowwveH7MaFTcfhSfeCMKC9u6l7PNplf4h4pqEDvsmfD4Okw3o4u0OP6huhat
         pIAvGYV/oQiUNFiPD8CB/xudW8xR2cELCsI8G/kxBfqULY6UYPuaYVWQXNtbaQiaJngC
         N9rxAGwNht2262WkRp4cJznpI3GaRibe1VXFQnMdABGbKpEVEUteD4i/vqpv8niahMBI
         kYrQ==
X-Gm-Message-State: AOJu0YzEqb2tKspjmniQMwTsoGv/MxvXslo5MYrQs3M7UnRu4xUndrRE
	eVP3UMByK1Yv4SoXIxowdX3XmGlXgJ7arZkq8ZZqr1wR4YOgLUNL2sZp38RgV1LowOqbpwwYQGf
	Ft9vUc5OkMpek5MaFlKTkpLZMjyE7RN4=
X-Gm-Gg: ATEYQzxq/p3dCo9BImI6nnamyUzOsc8mq+Pw+WSRJ6pycO1qflhIFf8+wofIZEbzIFR
	n2oC1Hv6ui90p7s5vUiu7JRwWWcjuf4/PuPZu+z6fFNSYpGLzUnEwBOkWCEGpGZ3WRIbRdwo8bG
	9mq3HoZ2hJnC81jI2Fres/ZQtZ9GUxBQRtZmUicAOBLhZZ7jSjZc4p2J9eH9K/xr+NgvMf9A3L2
	nM+xZ0UsUMF1lofKKt3MZMmOJlhZEg3EaTS95d1VUfi+vkDtp6dG2Qe1r0EdwquFxddIgVXNIlz
	LKBC743ju5lRZUswrsI98OeNg5Iz+J/Hk6MTgJPo1C9lQFjCn9GBoAtRnlM=
X-Received: by 2002:a05:6000:22c8:b0:439:ac98:751a with SMTP id
 ffacd0b85a97d-43b527c1fbdmr10800081f8f.34.1773914293266; Thu, 19 Mar 2026
 02:58:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318174327.3151925-1-puranjay@kernel.org> <20260318174327.3151925-4-puranjay@kernel.org>
In-Reply-To: <20260318174327.3151925-4-puranjay@kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 19 Mar 2026 10:57:37 +0100
X-Gm-Features: AaiRm52If6jbfzqmAHRnualZj2AHDEeCFUimm4kZYQBNwP2aTm9rqDosE11jDq4
Message-ID: <CAP01T74mcBrzusT-RtzFQdhrbkw+k=es4MCF6aS14mBux37_vA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] bpf: Consolidate sleepable checks in check_func_call()
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay12@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Mar 2026 at 18:43, Puranjay Mohan <puranjay@kernel.org> wrote:
>
> The sleepable context check for global function calls in
> check_func_call() open-codes the same checks that in_sleepable_context()
> already performs. Replace the open-coded check with a call to
> in_sleepable_context() and use non_sleepable_context_description() for
> the error message, consistent with check_helper_call() and
> check_kfunc_call().
>
> Note that in_sleepable_context() also checks active_locks, which
> overlaps with the existing active_locks check above it. However, the two
> checks serve different purposes: the active_locks check rejects all
> global function calls while holding a lock (not just sleepable ones), so
> it must remain as a separate guard.
>
> Update the expected error messages in the irq and preempt_lock selftests
> to match.
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]
