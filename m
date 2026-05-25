Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343BF1E7C18
	for <bpf@vger.kernel.org>; Mon, 25 May 2026 20:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779742268; cv=pass; b=ko7yoLf2uhmUvsfvGbC0q5X30WNMXrQo6v6yvLY7DhAyHl/j0rOmKAQq0fBrxTV4ViDMGa0ZDJZVF7yVwzuvcX2wrLZVcPKIvS+MhWsn9eGx61tWyGziym3p/yY+xqHAardZjMf2G3sV7rTMN3svm48yCDV8WCnp8ajcE8oKMCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779742268; c=relaxed/simple;
	bh=WWngLv4MavZXnYmNKf9lpxobybQ4pgICbiHfLoyUUzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S/z9gzXy+UQ0XnmLHEs3Osr179GogZXOioM8gYxS6X4phYRg9NR6AYTmlGQ5qPHzSS6pljv4UtZ43T+cVIn8tMlqHJbaiVk2BlAOUxK+94Mu6PYgQVzIGSijtxcOH7LfRu4OEniqIGrn5U1dvafMp8l+B/KIB0ppELFhic9orY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MM328cXa; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MM328cXa"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-44dd5cb0f81so7160178f8f.0
        for <bpf@vger.kernel.org>; Mon, 25 May 2026 13:51:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779742264; cv=none;
        d=google.com; s=arc-20240605;
        b=hU4r1EBj7kMb1jkjmGN7kKHSqWFHPlHUHo3NzbxJpANfuLFbMhAX2demsFVPxlnu0b
         ejYfZ3yu1OOAninA4KcrkRXqmBZwq+zVFqANpE3s+GhZvoknt7yWNVy7zO9ORIjMmevn
         n1O+OqqBQNAW6PjCQfOn7OZUTlNweqOummiggFf2tef4xaUOemYaEwofvGcOtk7MiuWO
         1RWLdT1A4S9D0IG+mFUnCdxu37jJv2xMhLj1GHNrlzy1GRb4OfOObPLeKhyQxGZZ05ep
         qsiFqvPdUnAzd3svsSWNudKJr4pXdJ8zP9O0Wub8sKjbHlqrKBagcO5zDy6hl1r3C18F
         pyKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UxGeLvY6pgtc2KFXXfcJKUkyT7Ubu4HdJhHQKMTm7uM=;
        fh=fkuFOXmdgSi8rqdM2SKszk+e43b65rj/7GlSu6AK6TQ=;
        b=LQp4Bypm5ELY9nPNfhEmJqq6VsPjbDvcD3w2LpDmssH8xzgGDl/2/mkQHZrWDF1J+/
         0P1/CP0+T8BGB2YHOJmxgdgQXBx0Ykw9sUm93EqYCVLLAgYvgEBdf7uB/95bzkXKWQ3/
         2WnC3MaG69/0dEDeDNr+BwhkB5VF3u/5OYEdWEaegC3Be9Xy7AEenLReLm9LzeG53cow
         Fu0cYjG9fFqBrySqnjMrrPa6Hk8+Rm6zPkYD6CLqzKzO9d/34DK1Qogx1somFWhmymby
         QVHhFfwmHZFCPH4zhYqB/oIXUUQHclBIQRNKSKr4o9o3Vt/+2s93y8Y4EAMVHKW91R7B
         jE6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779742264; x=1780347064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxGeLvY6pgtc2KFXXfcJKUkyT7Ubu4HdJhHQKMTm7uM=;
        b=MM328cXa8fusQwuuUSD/UGDaEC1FF+xlKY8ug4TQ1iM83xhY9iNx0f+f0DS3w2c/Ec
         K1waG7p0Nj7xjLUnjYlGgTuvINJnDsx8AEz8YaoGlUF0abbeU0M8dqPdrF3TnKhiV0uE
         YzsOyrRlnXupM7BOtcYGZ6YyQdO5VpUG2gBl+Dqv7igXyX2PKuSNWEvAgEV6F2iY8pVn
         xLmBMUFM2QMBYjYRZOoNpVRaJzmNxeZPMt8CpYzwE1aUbRYtSR8WeLG+2V/WxGZYyCH/
         YCMi0+1bEL1WTmaEJjaB0MtwvfV+hqOQZjkv/cyiIf3LQLE2LzMjxvorLE9obtEi3GRM
         14Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779742264; x=1780347064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UxGeLvY6pgtc2KFXXfcJKUkyT7Ubu4HdJhHQKMTm7uM=;
        b=bqFGquoeK+D3INhipkL7CpK4l+BDUhqcpI2G/DaM8HGzS6Wc5cBC6PC1RrdzamOgbc
         1JqzAWz56Znih6qLLJvnZ8Bo7XStbUXiq2ujqeJrEbSpj900lSb/j84XqBKzOIQicfUj
         Eck22Ltn890lecglhlhH12xRPrPhA09ZMLctnAJeiYm3nEbOuj/15w4NCtazfTk8mlOR
         l62yApb8kS6rP4BmOF1IgE5IzvGBsJhZ1T22bfWcdghJoP2nGCxs4eMPDLPyoWgUN3fG
         J4/hbbJpSRRbLnK3OTDuURGtEztVF2ryfPrbNXjI2iDaUG3DocDF31UWNsYeo4/He7k/
         EICw==
X-Gm-Message-State: AOJu0YwNg6xVVxIsBRbwnfJzDbaTplYs7zRt8SyES6OGE+exUhNw9KN4
	nygs79qtKUnWveMYPA5auC+rCjpTBUmATvjfWrINjSZ3zYixfiuCbWTysTtSjFlzbYZ1koBbSPS
	ZalvxnBNHQ1vNSRGRcPmYNiBAxfojrVE=
X-Gm-Gg: Acq92OFG06eAZh/s7x0QEi1P1l1Vfhq/8rXBBzIY11RdVx1QLbxGVkmlhVApeH6WAhk
	3lnWOj7hyE70TM+OdhhIFvjF+qNrgWd75eGltawDmIx5ui5KJf1lmIfXWR1vaM3b/LMcWKLHJFt
	XuD0vXcru9Bd4AKMfsNpowetE0kKp4zyliaL6tTC89EkAxnIfK6cCLiPrrO924Q6ERR3hHgmN54
	Mw9VZpg4kk9K9i9gWLF1zKasw3pT91LnLZzIE3D1qT3NVBygeNMv8dDnGiTejZUDqv3+WNV03LY
	IeUIdcmL6SBg3AYr0s8kLsE8OE5qmT404Cp8bgd9Iz7jRCBSu5w/ZPS8uxCfxKDZq2B5x84bl6q
	FYq0/iXbP6bLx5sJdA90Iz+HaEQ==
X-Received: by 2002:a05:6000:4a0c:b0:45d:2efc:dc6e with SMTP id
 ffacd0b85a97d-45eb334073fmr22128697f8f.20.1779742264282; Mon, 25 May 2026
 13:51:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521043553.199781-1-find.dhiraj@gmail.com> <20260524114243.259916-1-find.dhiraj@gmail.com>
In-Reply-To: <20260524114243.259916-1-find.dhiraj@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 25 May 2026 13:50:52 -0700
X-Gm-Features: AVHnY4JBT1AzkICv2LKezu5U8wt5CRXhPf6Zx83X7jZR0URDdEPMaEFu-7OVInw
Message-ID: <CAADnVQ+pozzPukjF5nRa6u0VMNYXz-4C3xp1RVwzVDojsi_4rw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Add kernel-doc for arena page kfuncs
To: Dhiraj Shah <find.dhiraj@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 24, 2026 at 4:43=E2=80=AFAM Dhiraj Shah <find.dhiraj@gmail.com>=
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
>  Changes in v2:
>   - Fix the return-value description for bpf_arena_alloc_pages(): the kfu=
nc
>     returns a user-space virtual address (translated by the BPF JIT for
>     accesses from the BPF program), not a kernel pointer. Thanks to Alexe=
i
>     Starovoitov, Emil Tsalapatis and the AI reviewers for catching this.
>   - Drop the "callable only from sleepable BPF programs" claims for
>     bpf_arena_alloc_pages() and bpf_arena_free_pages(): the verifier
>     rewrites these calls to their _non_sleepable variants when the callin=
g
>     program is non-sleepable, so callers do not need to care about this
>     distinction. Thanks to Emil Tsalapatis.
>   - Tighten the prose in Documentation/bpf/kfuncs.rst accordingly.
>
>  v1: https://lore.kernel.org/bpf/20260521043553.199781-1-find.dhiraj@gmai=
l.com/
>
>  Documentation/bpf/kfuncs.rst | 26 ++++++++++++++++
>  kernel/bpf/arena.c           | 59 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 85 insertions(+)
>
> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index 75e6c078e0e7..28b6b477012a 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst
> @@ -732,3 +732,29 @@ the verifier. bpf_cgroup_ancestor() can be used as f=
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
> +following kfuncs allow a BPF program to allocate, free, and reserve page=
s
> +within an arena:
> +
> +.. kernel-doc:: kernel/bpf/arena.c
> +   :identifiers: bpf_arena_alloc_pages bpf_arena_free_pages bpf_arena_re=
serve_pages
> +
> +A typical pattern is to allocate one or more pages, write to them from B=
PF,

'write to them from BPF' is not a requirement.

> +and let user space access the same pages through its mapping of the aren=
a:
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

This part is missing key detail about what __arena is underneath
and how it affects compilation.

> +
> +       bpf_arena_free_pages(&arena, page, 1);
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 49a8f7b1beef..948a43159106 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -870,6 +870,31 @@ static void arena_free_irq(struct irq_work *iw)
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
> + * Allocates @page_cnt pages and inserts them into the arena at the offs=
et
> + * corresponding to @addr__ign (or at an arbitrary free offset when
> + * @addr__ign is %NULL). The pages become accessible to the BPF program
> + * immediately and to user space through the arena's mmap()ed region.
> + *
> + * Return:
> + * * The user-space virtual address of the start of the allocated region=
 on
> + *   success. The BPF JIT translates this address for accesses from the =
BPF
> + *   program.
> + * * %NULL if @p__map is not an arena, @flags is non-zero, @page_cnt is =
zero
> + *   or exceeds the arena size, @addr__ign is misaligned or outside the
> + *   arena, @node_id is invalid, or the kernel is out of memory.
> + */

wait too many low level details that are not interesting to humans or agent=
s.

pls don't respin anymore.
I don't want to review AI slop.
People who add documentation need to understand what they're adding.

pw-bot: cr
