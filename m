Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBD734AB1E
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 19:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770231670; cv=pass; b=CGa+ULl/UbW5OlMv3HEvrruTrdXLERhc1sw8q6ps1hLea2iomD1G3TlOCgsszb2ytd1POLgofgnjtBCiMU4BdJjosU/5wDvsvgZM5lKsEM5c5CvZT3tDz2eGfYXp28bdoMt+X7plmU2x/6rE9LMPSafJjjJtBx2ohaD2plWMGFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770231670; c=relaxed/simple;
	bh=BGi0Yq7FGB09vO++UvrSVTmi8x/nIgPrGYAF2sfkBe0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hw7+xOCm7OAl+h8ti+zCbEXDdzDGY+jlu/jnDBfGi4t8tK8Y8zH/PaBgSHPJzec3hn5/21FzXe4d5QRVQDMRQWvoGpqay5jNqiM4FkoNXkDFakVjdxBQQ+dH5MVEbq6yWI3K+ywl5/gfNvtf9IoM1IH+GTC9Xs+AWxBvL8LtfNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GF0W7ty5; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GF0W7ty5"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3543b9f60e3so6717a91.3
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 11:01:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770231670; cv=none;
        d=google.com; s=arc-20240605;
        b=VdSehVNG/jL4bc6Ecq7VxoBIOuQyPONMjWSVUalU3/zCCXkB3sfwDq4R1iAZZlt8RJ
         pFJPp9atWkAaG1Q6i1B8aR3kLA1ZS9c8J49GkgdJGALLvr95utQ0/T5mGKrBztAU8lB+
         sfYjFi7c+5mg+aKPmNSA/Fw+s9cxthQc+ldv3Sfy8BuoN+ZPKiKRQi2fnbHx227NANg0
         akIX9QfCjMOC3XeLpXqbdtPJQTQNWdCq4dzKaXRgPsTLn2NJbEB6JDh76bW1CwzbpEsa
         kS6dl19s9nYlmRuJhO3ujU3aphipryIqj8VpbDKXn3ous/z+CRdxFAEbcWEgSX1GOcTc
         0Idg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C2BK5Aa7hHHjWrICfccw38JR+McJYiRKZW3QJ3JFoIw=;
        fh=x5/6nDfExsaJZklRHInpm+A/0glWt9Gx6VwogbYW0xk=;
        b=jzKjhMIR1if5cB6kcYH9CzFuz07ExBzzX7vPKQKm4SU+Br5O4xZdh+5MuL8PAMzOGz
         g9ZTjWy8OhQCl7Jj8clpNIHbWhipr/36pAhuDdRVd4EKQmZhQ1HC4jvIlUkAjZaeMMuj
         iDuCNHXbziyW6uCxYAbX2WLHs8fBqomIAFIdNmXUWs/Wwt62mNRObPrekRxUO4E54YHk
         emIkF81y8Duu78No7Rmco0lay+icKnNNVXjde1zU2nI2esY3wKpThdL26P1nE2lpLmVD
         oMZQHxk3UCsYXqXatcg68yY4E9OXUSH9PvezPvnJTUNMBC53BPa6vp5qz4KZPrGfv/+C
         U/kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770231670; x=1770836470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2BK5Aa7hHHjWrICfccw38JR+McJYiRKZW3QJ3JFoIw=;
        b=GF0W7ty53tGUSX3xvqY7OrknceEj6N1sh9+b9mxpYnLQ3/rFZcXngKhL+PC6QA4Cdc
         Qjz1+AX+vMqE4S/Z2KZwpGNW9E+fJ6j7PJPMdoL+D9goww8tvtjGLr7FRUnrX/fwX/Q+
         7MZH92RHeZhemBYtguCKfVo6RxjYbulDbRJE42DuTwkOdfzi/wVXUCrxq0lF1d+sp+dh
         OVVFb4SiVu0G402myHV0voAYicG2uJ8t/GxKyGxS9B4DmmbW6rbXHdi8OvgfM5wj40Ry
         40FRfks0xzbx9RnvBtevkysz3MOb20xg92PtiO3Xx6cFtbxTfbRxD6R6cA4DJeX56DVx
         JT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770231670; x=1770836470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C2BK5Aa7hHHjWrICfccw38JR+McJYiRKZW3QJ3JFoIw=;
        b=VK7cr5kqrycSGhl6nAZMDzziLaMMYsXuLghUIEGoNtSNmDqBy7BqBEw6ayFmAWwm83
         miuf6RGxKuTvL0pCRXUlA8ZDApWQUBKnm16yOStBkqkfLD3gZTrToWNaN2V4XZTrxtrq
         4vtJQHLYsHVNPFRJ4YC9Zpk3tPPFqS7cHBt1GGqOBTqcwhOQjke428aqhFvSUi9/jjtX
         TmR71uExFxQd0xbHYVuZ5doW7EbAbsrgW+cHQYCO2mUNHCoAZM6wPCgSSqUf/tPLgYgt
         jDY0mokL59mob9EVs0+uyNUzVVp/jPD162WvG4ce9yuLwWQ13bSdr+NE/sEajRmO2DBa
         12XA==
X-Forwarded-Encrypted: i=1; AJvYcCX8NFtF/3HeHZn74x66caLwbqIcxPMe32JYBSbBRGgZdaTEOQhELp9htpULoN5RTp9KMlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzlErgwmKoOK+xpYjbFmSXrMZLrpqh9jGEM3e0FpEEw55xkrmk
	PEdmv/P6aKTMMlW4OAjTWeSEP3dHMCuCwq/aDrEu83fMSUyv0Lls+da+iAsP7nOf60qQBnQWrPW
	naWyx2mX9FlY+YxdSboDh3iIe7XXCiQc=
X-Gm-Gg: AZuq6aJgT/2GYW1PRdaSB7zRdIZubZWp1dUgzTo5cXYMTNJsgL0O/7NNw6oAYokAPET
	tqXfg3xrKbHeVAsA7gP8kK5iixKUdGbVL43EylEKGxKx2W42MVfvNFvgyW8t62drzAIKUZPv1XF
	FEyy2thrTI/T6ZbuF4KYG0f+QjwRxWmFnn1zFYDON3EuzG+S+9jYj5VdvqLF4aS6EG8DbAB68u1
	S6anGp7C/l+r3nlf6uccc21By7XqW0pOYEGsZxQy/vuI0NF3SLk8GI1dEz/KTLQnc78409dePey
	cZEeduywf8w=
X-Received: by 2002:a17:90b:4b8a:b0:341:2150:4856 with SMTP id
 98e67ed59e1d1-354871a9754mr3802441a91.17.1770231669749; Wed, 04 Feb 2026
 11:01:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203093819.2105105-1-jolsa@kernel.org> <20260203093819.2105105-5-jolsa@kernel.org>
In-Reply-To: <20260203093819.2105105-5-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 4 Feb 2026 11:00:57 -0800
X-Gm-Features: AZwV_QiCLzPwkIuJ-8jnTLe2OoaWDrr2vUS4Xps7rzpcaANa-ajJlfEoQJps2IM
Message-ID: <CAEf4BzYWxmg7YO_ewENt1rr4R1YT=iL0fc5yJqanfQZJk6u1nQ@mail.gmail.com>
Subject: Re: [RFC bpf-next 04/12] bpf: Add struct bpf_tramp_node object
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, Menglong Dong <menglong8.dong@gmail.com>, 
	Steven Rostedt <rostedt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 1:39=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding struct bpf_tramp_node to decouple the link out of the trampoline
> attachment info.
>
> At the moment the object for attaching bpf program to the trampoline is
> 'struct bpf_tramp_link':
>
>   struct bpf_tramp_link {
>        struct bpf_link link;
>        struct hlist_node tramp_hlist;
>        u64 cookie;
>   }
>
> The link holds the bpf_prog pointer and forces one link - one program
> binding logic. In following changes we want to attach program to multiple
> trampolines but have just one bpf_link object.
>
> Splitting struct bpf_tramp_link into:
>
>   struct bpf_tramp_link {
>        struct bpf_link link;
>        struct bpf_tramp_node node;
>   };
>
>   struct bpf_tramp_node {
>        struct hlist_node tramp_hlist;
>        struct bpf_prog *prog;
>        u64 cookie;
>   };

I'm a bit confused here. For singular fentry/fexit attachment we have
one trampoline and one program, right? For multi-fentry, we have
multiple trampoline, but still one program pointer, no? So why put a
prog pointer into tramp_node?.. You do want cookie in tramp_node, yes,
but not the program. Because then there is also a question what is
bpf_link's prog pointing to?...


>
> where 'struct bpf_tramp_link' defines standard single trampoline link,
> and 'struct bpf_tramp_node' is the attachment trampoline object. This
> will allow us to define link for multiple trampolines, like:
>
>   struct bpf_tracing_multi_link {
>        struct bpf_link link;
>        ...
>        int nodes_cnt;
>        struct bpf_tracing_multi_node nodes[] __counted_by(nodes_cnt);
>   };
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/arm64/net/bpf_jit_comp.c  |  58 +++++++++----------
>  arch/s390/net/bpf_jit_comp.c   |  42 +++++++-------
>  arch/x86/net/bpf_jit_comp.c    |  54 ++++++++---------
>  include/linux/bpf.h            |  47 ++++++++-------
>  kernel/bpf/bpf_struct_ops.c    |  24 ++++----
>  kernel/bpf/syscall.c           |  25 ++++----
>  kernel/bpf/trampoline.c        | 102 ++++++++++++++++-----------------
>  net/bpf/bpf_dummy_struct_ops.c |  11 ++--
>  8 files changed, 185 insertions(+), 178 deletions(-)
>

[...]
