Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C28A329E5C
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 06:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769494377; cv=pass; b=ZVILThVILlDHZWB73eQxva3MbM+H5pDmVCxtLL5vYSuXgLHQxe9cROCgzO9s2j15DT6NVJ6B5FIKD4NWmq5hXpB39TpSn6uLplRLQPRcnRxC7vIwNGmETD9ecJwsMcbxIxv9bYtelxqG4kdXzvRr7UYRw5rLb1y7x53MdT9xDl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769494377; c=relaxed/simple;
	bh=8+QCA7YpZsl5+tNZ+NDEzzOV+PdOktMx+ZOD/sy7Fds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DMeDO3FYI4O9MEGeg7M2bD1NYRkG76AXIwrIrV/EiNL/F7iXtlw0abT2WMnCi1c1Xd7RDmX5RZsRuh8xzuiwYxDiiBGjIVfe+PHNdo5gLm8BZBiLMIWkRP36EdCaSlLmeZ/bBjDJdVF4pDsFuivSgt+hKsb+0I6kWdfUwwnz7/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AN5CHM5I; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AN5CHM5I"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-78fba1a1b1eso79549837b3.1
        for <bpf@vger.kernel.org>; Mon, 26 Jan 2026 22:12:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769494373; cv=none;
        d=google.com; s=arc-20240605;
        b=lweO7F81unZ8u7PhKxadcg84YilOQDyEY1gtqHv/4SrCm5xChwk/d5iVRbQEdI0Ax7
         3OmZIS3Y2tigtwncMYcWSxtFuGfGbwouZL1A5xckwKNhnGV/lMPta5SlYxV59QqxGJQq
         fX0Dx0SK7mLazJJiMVwTXeGF8lGEBkoRQgEUJM6XUbiFsGPjVqdFheu1e64hpprNWLie
         fjOE0re0I8NDI/GIdpsYzb5dAUnvcbeBRPGQLlr1QpX5nEU2PRd3ncYznfqz0V5ZVJjz
         yCQhskpMOtQa2W4uvIiKOb60d/yk5ua3sb9q64rskNTgd1nQvB9tCSxrwLyS2Y8/OaTE
         +3hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fw77OHCmQi/THnFtNAgXJIoS/IUJlX4GxEekn+APIKU=;
        fh=S28IKLljYO5ribukOX+7btu0mmxV7tW1bx2QZ2d+1I4=;
        b=MGwE0P14avFK7P+5p7gsrS0okVNWFSmiV8zOkVOz9RPqL98TMYuWyrJMbVgaVozZcj
         BXeKS253kWawiJ64X6gbI/7pN5872sJlJLlvKi37Gx5V5C5ib9nHdOnPvVedg7ancKjI
         Dk2zgxgurUAzPuyTL2ky1JhsxQIcNWOtz4L+oZf4r/PCL5G14jEHneQj5ABItfEPyi+Y
         pm0V/QAu5TE2C7R0ifd0oYRMme6Wloc2EPARI1ef9CSfwob+nKTHi9pRGIyTQJ5ZBMg2
         78b1/sW97N1KcLXPpz5a2rNLAwnh/92LorO/WplheNOrTR6JhUXQ1wPeWhYTvfcZsAe+
         IG3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769494373; x=1770099173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fw77OHCmQi/THnFtNAgXJIoS/IUJlX4GxEekn+APIKU=;
        b=AN5CHM5IILC0csgrmb7lGE+vHH5Z38wWM9PYFBFv0DUpwd0/vXPdOYWYAfmomE8SBW
         TDT9HFFR/V6egzT/vOLUmuUVY/LXgcHIgKGSgFrrHVgb9P5zEqg1QyJ2lHS2tL1Oz1by
         yAuWTL3F4EejfH/T69qBkLE54Pv1WsSQkCAWYuz3DmaD+a9sxwZENnc+j1r/yATUF6cP
         fKry647JYj5no0ePX+aW/l2CXtdNgoEDYzGM8/0xH/l9PFi6INjHg1/Bq8cTH49PR2GY
         Tm/tTsqn8ag3TkEBlAMoEtnbRYKqIUkB2hZ1PaAnYj6cpavm/DsLNqKx+0hEOe+cFnkp
         3uXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769494373; x=1770099173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fw77OHCmQi/THnFtNAgXJIoS/IUJlX4GxEekn+APIKU=;
        b=YmQ1EgCySTQXGPiz4GSQbKB/f+rge0OrP6c8IPfvcSC9CowqgT8ZCqrNuUSVpfp2rE
         DODtF7aGZzjYx4YBTTPR4MT9brZABIvv9UKYohGbB8TeCO+Yr+wZNYAhTgIpZoCjANVW
         OfGJwsYgTbruHcyYSj+FUrUq9jVbCu7+evewZqGzsC422saB97Yd2V6jXo2mExJvfVqk
         t1IwFdt6Ga7iJ3ni/KROGAoGNRA0K003SF/SjwNv0l3SFYUa+z3+uG9h08UyR7ATKO8p
         ooSaU7sV9ag5lez8tAWuowgImbtWAEb2uIf6v9J6ciUC0l2aVKGCsogkkpNTlKWSUY8Z
         YeIQ==
X-Gm-Message-State: AOJu0YzUKny+I6O63zspHJvelMRa6Mp6pg3zl2iIM/i6YsFnE2QEvKYi
	tTmK3k6DotBe2j6P8z/cJr7MM7OI4JXVLuKX3IUuabOFY/lY7U1jTFhqYaEqbgfV7U2Nj/ERZxt
	0SH/czXnjcQd+3Nn/N/n0K8YpUHwl69U=
X-Gm-Gg: AZuq6aKX544x3f4qa/G2KhPKzSr1on+xTvuPUxJ/TlY5aZHyj5QyLfk4gISNJUK1sGU
	9kjN9qkv+ohAEA2CkXhwdC4trleslfJP3ESsAImvc7rO6YbPRv8jDd9JSzb1Bape+lXP69xBVB7
	fC1SNZTCvTQk1fBskgrTOr5w4ci2cOpAnXvyG7FJZTF3asycneX+1ucvaQBlvHG1psbtJri4kWS
	mqLVHVpXnDzZrF/lCfSZrpJlO7IT4xupYNNrwZRo+hGwx/Gqg4pDw7L/o1Josl7I7yAROW7
X-Received: by 2002:a05:690c:62ca:b0:78c:7ed3:f71a with SMTP id
 00721157ae682-7947abd5bb2mr3471687b3.3.1769494373226; Mon, 26 Jan 2026
 22:12:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127024421.494929-1-roman.gushchin@linux.dev> <20260127024421.494929-7-roman.gushchin@linux.dev>
In-Reply-To: <20260127024421.494929-7-roman.gushchin@linux.dev>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 27 Jan 2026 14:12:17 +0800
X-Gm-Features: AZwV_Qjjzszi0Mx9DzI_P6xCYJ0ZjBXRqXPfR5mshB_NJEXLUa8A6Gcf5JTSmA8
Message-ID: <CALOAHbAkxp-wvXpk7uM+y6Q46U6g44Z+SauPtCpY_otL=a-vrQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 06/17] mm: define mem_cgroup_get_from_ino()
 outside of CONFIG_SHRINKER_DEBUG
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: bpf@vger.kernel.org, Michal Hocko <mhocko@suse.com>, 
	Alexei Starovoitov <ast@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, JP Kobryn <inwardvessel@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Suren Baghdasaryan <surenb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 10:49=E2=80=AFAM Roman Gushchin
<roman.gushchin@linux.dev> wrote:
>
> mem_cgroup_get_from_ino() can be reused by the BPF OOM implementation,
> but currently depends on CONFIG_SHRINKER_DEBUG. Remove this dependency.
>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Acked-by: Michal Hocko <mhocko@suse.com>
> ---
>  include/linux/memcontrol.h | 4 ++--
>  mm/memcontrol.c            | 2 --
>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 229ac9835adb..f3b8c71870d8 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -833,9 +833,9 @@ static inline unsigned long mem_cgroup_ino(struct mem=
_cgroup *memcg)
>  {
>         return memcg ? cgroup_ino(memcg->css.cgroup) : 0;
>  }
> +#endif
>
>  struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino);
> -#endif
>
>  static inline struct mem_cgroup *mem_cgroup_from_seq(struct seq_file *m)
>  {
> @@ -1298,12 +1298,12 @@ static inline unsigned long mem_cgroup_ino(struct=
 mem_cgroup *memcg)
>  {
>         return 0;
>  }
> +#endif

Given that mem_cgroup_ino() pairs with mem_cgroup_get_from_ino(),
should we also define mem_cgroup_ino() outside CONFIG_SHRINKER_DEBUG?

>
>  static inline struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long i=
no)
>  {
>         return NULL;
>  }
> -#endif

--=20
Regards
Yafang
