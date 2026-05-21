Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249F831E859
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 05:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779341349; cv=pass; b=eeMcZ02v7doFwaZM4ZFK2kndIvGXmPkDQm8fk5aaTi0It+j9ypYtU8GjEO6Yz/v2N9Q2Ij+3b8p8q8yywsbYWStf2yHuLkY20JouRNcvvK3AGbHqYtBmDUSWhdV44cAaLBZapkiboUa2uTLn9cz6kxf0iz25hWS3j2EjSWH7thk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779341349; c=relaxed/simple;
	bh=b2U/lc55wl/BlR1AIw4hzD2b81g+6qnnNJJ0BmzR9k0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DzvoJbrSoxN6NLLrnej64tGyu+cnpOHpQDad5uatijm/a6Q6XXa6MfhfrhpFjvIk+TPUqfH8ZTAV68yCt6XP4Z1ZiCi+0OeM6hZDvUzD3Xl7CRumgYUmJ8eB+b33GGW6r8pSzx5Pt2GcdUA1F0VB5QR7zjMHPLKANbuuWKDTMUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0X6d9zT; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0X6d9zT"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-444826c16ffso5053908f8f.1
        for <bpf@vger.kernel.org>; Wed, 20 May 2026 22:29:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779341346; cv=none;
        d=google.com; s=arc-20240605;
        b=WAFgh0K8HODz4to7P/WvwIFlUBIZzzO3g9kXmp+3H1Ik00SVFPkiPfGxF1EqMba4A8
         8rK2lQPOq6kxTIpi/XxL5LtUHm1rxPBYyVcL2A/rr7ayOW41uchUo1/eTSY62Ho+N3o2
         UlPBcAQ6W8jccfINajncLXkRvHvu/5oJYdqj+y1oO3MbkVXRrxo+a7FrQlLTz1nZgv+v
         dvt8t0mTKc0629X3XT9uoVZM05ylfMsKsPfWxq1S8ro7WAhywJYY4sE1EYb7CIXPguJc
         RsrOsHqwfZg+U1sYHi/03pBZ4Jy27QXXhdR4IH7S0YgQZEI35YP4Uo1eI/6/ezdDykO9
         OTBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KatY4MrrW+s9oPPVFN47J49ZD0Ibx3q1UvU7Bqv7B1w=;
        fh=nCcUYW2tU6866jVdWqO5GzZ+upEh7ddt9Uq2dslaRYo=;
        b=U+aNUL55TfuYlQXKVtJQeXp5IICmqTnxkGXdOx3LgUUKGGYUe08K/0qjuAhosEBZ4U
         /rkrZKbvVHdQ4Mc6y4VteXgUHuswFxvJvf+iyi9Go34zd8FTHLwErxaNJGRPeGr23vKH
         x2qL1d/1CESoVMaYW++N1IPbjah4GtiaCf8bLegLBuvGutgZvh6oE8R4Qv1V/iX2OY98
         tMvcLDVlC79x4mA4SAbTUta+9qSDbsLF2P8WbOWmHN6VfsAUF7tgWUrdKYq+ptq9OMQB
         Sj3XevsHmd6c7vqKHSFGdYgQicmhtalfIU1AUGBqwsvvfJ+Y2zQ0WRNPEdalEBEkLi7W
         4Fxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779341346; x=1779946146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KatY4MrrW+s9oPPVFN47J49ZD0Ibx3q1UvU7Bqv7B1w=;
        b=H0X6d9zTHA3CYuLCgHJgHfa/XML1BukgW+yDc65v49fuJSrIWTiFuM/oTbwnfdfbLi
         9keAbUw520mj4jlzOL2xaR0ZkLQJsemoqjHF+ahlhPBqSgaW0blD+cg870N6O99BbIZ/
         qpLTibkN8mIU+0GtcWR+9cGBpwqQWATRMVCl1/um8/TTO68SYMNH9yfpl+aZ7tP2Ek3S
         v2m+feeUVXYuhFqqTQ04J69jjOoVwGnBfa1guIf/KpCoIo7O+t96liFflWsC5vrFe29G
         WVMUt+M2ORaMg6YKFcSEf0TQRIxzULWr140kgPM8B5UeXpu5Rqz2iYhpizklKxX78CXm
         imrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779341346; x=1779946146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KatY4MrrW+s9oPPVFN47J49ZD0Ibx3q1UvU7Bqv7B1w=;
        b=c144mFO0NJkIFe+o+JE9Jdq1OfiaptfmsOsrYxemMWuglXyz07Cfa9Dc5fGj+Z8Az0
         A4RR0kbL0+NHDkBhyvc2xJjwcjMRJFOJYjk8SC0NgJm6pM0ufO2nJ+LNGnR46ufESI1r
         7GQ1G3sZ/bdjff9by/T9WZXIGIEKO46lapkP26HvxR51fGw4DmguGU8OSBdW+FlyikZO
         dhLoIuOMRj9vuJqW1kPH5nRJUtNpkZIc5my8mLXRJYLSfJZMQuhyfYHxqcNMb/GGUVf8
         M5mqTVkwzLMyQWk4qZZQqZfbp5O9Ot2gX8+UG94ftC2V7zKYd4hb1z6hccPCUg3zWHV8
         181w==
X-Gm-Message-State: AOJu0YzydJld+ivZaMkB4iPCp+ejYigMP0q52zXAt/+E1cI1Yk6sacBx
	dqdsaYbFwLcmOo622YwF/CfbKul0b9JI0QxTcbpQ50YnvTylkk/CIjGC/8UDBcdHXCaA2lu66fE
	UD9I0Z5DAxlSSstIjl64lzX11yQJkXrc=
X-Gm-Gg: Acq92OH5aXRUGsqo3WEOIBYbHuehpmi+WDAfVPi6LnpEKjNhKIRyhr9ilqd1iG1/5ni
	E8wyMGnqI35M40us35zzTgQF2PmGM/H3B8rzxSuq+hFljPxpdf7gVrcuPZ3rSceEDXBaxuLqEvg
	Lsu+fimOvo3XYAOrzsrZNqzo3XIdw9neVeqZPAJFzVLmGcb06xeN8Wo8JGuUbd28wldzkBrPa59
	LTH++IGr2V9u1BOZ7GHhpYCfSWsN9abkARIE050oIfShxZCJonA6iWh/yRMXdhVgcKWFyR9k9Lv
	TJa9PlymYvdzUB7FJ1oZh2S0+EMY8RHJ2Vz3W8PCH4pWaU1ZdfE+eaJGHjo4MgLvi4D6
X-Received: by 2002:a5d:6f18:0:b0:449:c5e2:a8b7 with SMTP id
 ffacd0b85a97d-45ea38ea615mr1725141f8f.30.1779341346248; Wed, 20 May 2026
 22:29:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521043553.199781-1-find.dhiraj@gmail.com>
In-Reply-To: <20260521043553.199781-1-find.dhiraj@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 20 May 2026 22:28:55 -0700
X-Gm-Features: AVHnY4LGyFWFsjm9R3zFYMXek3cxBABL9M5qSD6O5YY2ST_emxxJt8II8Xp9c24
Message-ID: <CAADnVQL7EK49kzHX36Y=C5YErRH9ATfTNEdBc-fyqrDM-rexbQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add kernel-doc for arena page kfuncs
To: Dhiraj Shah <find.dhiraj@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 6:36=E2=80=AFAM Dhiraj Shah <find.dhiraj@gmail.com>=
 wrote:
>
> The page-management kfuncs exposed by BPF arena -
> bpf_arena_alloc_pages(), bpf_arena_free_pages() and
> bpf_arena_reserve_pages() - are part of the BPF kfunc ABI but lack
> rendered documentation. Their contracts (valid argument ranges,
> sleepable-only context, and the set of error returns) are today only
> discoverable by reading kernel/bpf/arena.c.
>
> Add a kernel-doc comment block above each of the three kfuncs and
> render them under a new "BPF arena kfuncs" subsection in
> Documentation/bpf/kfuncs.rst, alongside the existing core kfunc
> subsections.
>
> No functional change.
>
> Signed-off-by: Dhiraj Shah <find.dhiraj@gmail.com>
> ---
>  Documentation/bpf/kfuncs.rst | 27 +++++++++++++++
>  kernel/bpf/arena.c           | 64 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 91 insertions(+)
>
> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index 75e6c078e0e7..fe0df1e16453 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst
> @@ -732,3 +732,30 @@ the verifier. bpf_cgroup_ancestor() can be used as f=
ollows:
>  BPF provides a set of kfuncs that can be used to query, allocate, mutate=
, and
>  destroy struct cpumask * objects. Please refer to :ref:`cpumasks-header-=
label`
>  for more details.
> +
> +4.4 BPF arena kfuncs
> +--------------------
> +
> +A BPF arena (``BPF_MAP_TYPE_ARENA``) is a sparsely-populated shared memo=
ry
> +region that a BPF program and a user-space process can both address. The
> +following kfuncs allow a sleepable BPF program to allocate, free, and re=
serve
> +pages within an arena:
> +
> +.. kernel-doc:: kernel/bpf/arena.c
> +   :identifiers: bpf_arena_alloc_pages bpf_arena_free_pages bpf_arena_re=
serve_pages
> +
> +A typical pattern is to allocate one or more pages, write to them from B=
PF,
> +and let user space observe the same memory after a page fault populates =
its
> +VMA:
> +
> +.. code-block:: c
> +
> +       void __arena *page;
> +
> +       page =3D bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
> +       if (!page)
> +               return -ENOMEM;
> +
> +       /* ... use the page from BPF; user space sees the same bytes ... =
*/
> +
> +       bpf_arena_free_pages(&arena, page, 1);
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 49a8f7b1beef..b8ec2953dee6 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -870,6 +870,33 @@ static void arena_free_irq(struct irq_work *iw)
>
>  __bpf_kfunc_start_defs();
>
> +/**
> + * bpf_arena_alloc_pages() - Allocate pages within a BPF arena.
> + * @p__map: Pointer to a ``BPF_MAP_TYPE_ARENA`` map.
> + * @addr__ign: Page-aligned user-space address within the arena at which=
 to
> + *            place the allocation, or %NULL to let the kernel choose. W=
hen
> + *            non-NULL the address must fall inside the arena's user VMA
> + *            range; otherwise the allocation fails.
> + * @page_cnt: Number of pages to allocate. Must be non-zero and no great=
er
> + *           than the arena's configured size in pages.
> + * @node_id: NUMA node hint for the backing pages, or %NUMA_NO_NODE.
> + * @flags: Reserved for future use; must be 0.
> + *
> + * Allocates @page_cnt physically-backed pages and inserts them into the
> + * arena's kernel VMA at the offset corresponding to @addr__ign (or at a=
n
> + * arbitrary free offset when @addr__ign is %NULL). A subsequent user-sp=
ace
> + * page fault on the matching user address populates the user VMA with t=
he
> + * same pages, giving BPF and user space a shared view of the region.
> + *
> + * The underlying allocator may sleep, so this kfunc is only callable fr=
om
> + * sleepable BPF programs.

what?

> + * Return:
> + * * Kernel pointer to the start of the allocated region on success.

what?

so much slop nowadays :(

pw-bot: cr
