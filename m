Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054D94A2A42
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 17:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789492872; cv=pass; b=WPupp/eYbESDj+p9HxBjttGJQrDdTcmBNBaM4dMLI7uCniANq94OA2Dk8OucUIQ0YLFezuo+HxVjN/SglVPbGOMLFKzzaDWqLwWVIP9jpGP2rd4ghHvrUSKqT2A/GGb9swrgg11IbIoHXq0NxlvYCq+bt5MZFros3pXpbpm9GfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789492872; c=relaxed/simple;
	bh=ANRdyzkiW2n46BZXS7RzLN4gyuuHv08frlEVtMqj+vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dqWqHjhzNoR/3vDBo6rlcbvA9amOY2n+UZxdd4oFoRZOsGnt8VpHOJg2kJESt3r5hR1A2a3w7yzTnJxORcWl3EIMdV75sxss+1Di069gJKYS6gZ+QPwRnWDeoyqfbyWsIJ4OTR4G6Pa54I/vLKIjwq9PgfDx3g9Gt9zCcannpdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6yTSnNx; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6yTSnNx"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a60590a85bso77471a12.3
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 10:21:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789492869; cv=none;
        d=google.com; s=arc-20260327;
        b=Z60k8DdvgYWlda2RSIAsMoLHUVj7dh44NGCtON0zYvI+YHRY32E1MGi6ssc/bwCwNK
         EfD+uVKDXcP7OdObbrTmcJOZgPEr+TpR1t2nouEEchL3U+XpkvV23aGxS3eoiMLTF+x4
         9qbdMAsfehsBIcVDfUXEfVN/k+uKaoIX26hvYKyzn9Xgf7eAsqUVditX5bDqdxZZVJiX
         RCYkQScHEeqIbBIRlkUbsMcjs97BsdUZe/TU+dBGHiyMBT+LeB/fL2wid6dtqfVXcQ3I
         Ff+1iQdw95PTqdZUv5JSQN8Vo1mka6qSgTVZhvaEJdzQRrhmydkFMUA3YNWKNoqMC3sq
         aSpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=GfANrDKyQQJG0cfj6OqPz60w32Xge59VKyIhU4wGT5k=;
        fh=7K2qWJ3mUiPSelnihIFryY3l1DriTibHaNVcRL5iMOk=;
        b=mYNrUvflY3avRv4heO3YJzR1tQabnSHO+d6snmtzSQU7MzruwG3K9Ljdt6mnnZ4ZTb
         rai4RjqbCO0D4tYsHNuLgIU2casL2f7u7U2EmXnG0QmZp8LkqqmROxZlp8bhWcW85Stf
         qVuFOYyG74eqHpyr05hRSCaJm5jXymWxrZQO7SYkVvSxkhXIBYULldgPYihopM0KjMkX
         1o1h5I15Y9p5Bf/X9ve1iBxj75A+wR4FDsMEzHg7/RMdeX3GXuNriJZgdSIUNfTsOzNO
         AlKV4TJ7hMXT7QaD0DqSDe0oLfTeFIYUwQow+JZkK3aDHCy1DZz1zgtn49sWnsbfTqIO
         w1yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789492869; x=1790097669; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GfANrDKyQQJG0cfj6OqPz60w32Xge59VKyIhU4wGT5k=;
        b=c6yTSnNx92TKiEQNUXjTyYy0UrMReZLxPdXxr4Bq7TDFwLSZCwjNiFNCAQuu0RX9iA
         LLUcO7LSYwm/eHm5E87FSuwVuMrj0kQAQWhLza8gRMKkVLiU8LSqMtnM9kAgNWQSAUmO
         fMpf2aGA2G/ZBJW7lT3nQMWe5Igkk//n669MF9edA6m+I0ctZaHZ8UbQa34Aqh/5My9Z
         3YHdMQ39GmwDBfmsP8kX4GofzXKjPKaeV89dLuoE2a4tcptIYY6rONokfPHQAtB5Ad2S
         8q1VXiOCiT1OtZVgG0JJB/g+mO4Wbb5eIoDP8Q28X2YFaZg+SuVhF2HSUIYZOCHp901z
         BcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789492869; x=1790097669;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GfANrDKyQQJG0cfj6OqPz60w32Xge59VKyIhU4wGT5k=;
        b=JqYrtgp0zE4b8QcxQAd+5YYP6Zlp5avrXkQXRF0l2HcHs9Pb8EY5vW+Nck36OcEmO4
         I7lE/JvVdTAKMLnVYOslmU0gvJk7fCfrfQpaul89ZdgNd634vPODl7F93LN4c32B0Tx8
         C3jTrbv7oGXPHkbVoYl52dDmpZkgGT+ouhJ+XWG945V9Fwj11wuM3jzwvhhDj0dNWsv6
         2yr0Bg/KbbQNGpBGdg0vVp0lyg7GjuPyaT8xCxlQEkjTQcl0MkxvOd8DkvPavdbfVqJk
         A4SPkaTGCfB4DILls0/sSDPvEP4jSxK9yUAb1OWMnf3apqtRAqNn8BqKXa7A8YK2mHDj
         3i3g==
X-Gm-Message-State: AFuF++neqf2RIfoqpIDDRkhU1d3o8hm6LbcPoI/CjquOaojpVEKcrTc5
	BZRfXh+/SE7XM0ObQ4YknvyuY1BTGNZOT75zAoK0VaECnDxXCxAepfz2g/0TIcQ5w+I2b2YSzZj
	6Fx5fMRIe7tq0pX9XCAe9uoBlF61rrco=
X-Gm-Gg: AYBFou1oq7T15bwfIGK6VFeA/PqIaodUL4sQLwig8gJFQnt5YHjZBFwibZpNj+8bYp9
	fPB6DXPg3wWOqhApK55ByL3uwbevrO8p4uNtJE46qeYN2cCK4UOtX60gH3DRNT+vSryQK9wbUZN
	wj8wyTgpdJqmKi4jQf15/ZwiXvsn4X+KMXPGsDvqaEaC3uS+uufnncOrv3+r1FeNOkCgKuRdg9H
	C1B/LcgVKfQpd1WdYHlv9Bg8ah6y3DNeEKPgo68ClfMdNpB5hFwtquUC3Yfa8DzODHPsqICGLEo
	j6HnBNEzGsIQua6N+LPqQ7PEWRXZZZ96I2YbKlcy4AkWEDhWamjg3YtqwAQHBINLcYk=
X-Received: by 2002:a17:907:724b:b0:c29:8c9:6fd with SMTP id
 a640c23a62f3a-c29d7792e17mr167097366b.11.1789492868911; Tue, 15 Sep 2026
 10:21:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915141004.1196460-1-memxor@gmail.com> <20260915141004.1196460-2-memxor@gmail.com>
In-Reply-To: <20260915141004.1196460-2-memxor@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 15 Sep 2026 10:20:52 -0700
X-Gm-Features: AcwNN1VK3c-zNOb1LRSYuEBC2KMEwk2pwWwMDYDxNz7RcFCDEF9FFnda1e8AOhI
Message-ID: <CAMB2axM2_fMUyPdS7ySuQiKAGW11hhCwTSX=PSxFZ1o2mZu6FQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Fix generic __uninit kfunc output buffers
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Tejun Heo <tj@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

[...]

> @@ -9232,7 +9237,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
>
>                 access_type = fn->arg_type[arg - 1] & MEM_WRITE ? BPF_WRITE : BPF_READ;
>                 if (meta->btf)
> -                       access_type = BPF_READ | BPF_WRITE;
> +                       access_type = fn->arg_type[arg - 1] & MEM_UNINIT ?
> +                                     BPF_WRITE : BPF_READ | BPF_WRITE;

This looks a bit convoluted. Consider doing this when generating the
kfunc proto or at least something like below?

  if (arg_type & MEM_UNINIT)
        access_type = BPF_WRITE;
  else if (meta->btf)
        access_type = BPF_READ | BPF_WRITE;
  else
        access_type = arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ;

>
>                 zero_size_allowed = meta->btf || base_type(arg_type) == ARG_MEM_SIZE_OR_ZERO;
>
> @@ -9550,6 +9556,33 @@ static int check_func_args(struct bpf_verifier_env *env, struct bpf_call_arg_met
>         return 0;
>  }
>
> +static int mark_raw_stack(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
> +                         int insn_idx)
> +{
> +       struct bpf_func_state *caller = cur_func(env);
> +       u32 slot;
> +       int i, err;
> +
> +       /*
> +        * Validate every argument before initializing outputs: an input argument
> +        * may alias an output buffer. Use the normal stack-write checks to discard
> +        * stale spills and preserve the rules for special stack objects.
> +        */
> +       for (slot = 0; slot < MAX_BPF_FUNC_ARGS; slot++) {
> +               struct bpf_reg_state *reg = get_func_arg_reg(caller, cur_regs(env), slot);

The bot has pointed out the need to skip inactive slots, but the rest
of the patch looks good to me,

> +               argno_t argno = argno_from_arg(slot + 1);
> +
> +               for (i = 0; i < meta->arg_raw_mem.size[slot]; i++) {
> +                       err = check_mem_access(env, insn_idx, reg, argno, i, BPF_B,
> +                                              BPF_WRITE, -1, false, false);
> +                       if (err)
> +                               return err;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
