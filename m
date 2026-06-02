Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3441939891F
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 13:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780405320; cv=none; b=f+M7PNkZgyX7j1dZh4r0NQ8ZLHyZpq06aV2OvtxC6dYY3xbNzyzP8NWiWTtQPOXXEs4B3N4vhCIAfEihfwKQ2vhMbvqX0Vha4XY1lcFwizGzEd3F9WM3J9ymyxnYulvek2pkUvO8zqopi27KULo6U2n1FoBVobekEhMd7b0yJYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780405320; c=relaxed/simple;
	bh=wy4gIOydRpO6s3iFU1d8SQh6mOIBTW0h92HSL4dWBEM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHLQh93xmNPXOM2pDpdeW/jHtGTzdWaJK9CM4cmOWKEBypxWNa8c6frqaYJbQgSN7Ox+9pjzr/wEfxEpTykULhlSIWKUakKbnWWqLVw1Y7+dq+KjeBbn/KtCiENO8lugwlw+hPD5aEcMKAY0mcdZw1ENiv8hoxXHb7FzvJJ9tRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QM2Jrtda; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QM2Jrtda"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4903997fcb5so115778615e9.2
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 06:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780405318; x=1781010118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W6PZomB4fY5kFt4EpZT9MLtSi3pU0QOKrZbirr7Htn4=;
        b=QM2JrtdaXhtUMLw41xvphSbgN5rnwiYLkL90LPtDET6S27m4aS7/yxkwJ2UOLderT2
         EGin63s+U0TfDGNe7bcInA3qmGgjaIzalh5sEuIl2NVGHc+fs4QO0uyptFnxwTgR9hMM
         BckKLCbif6DedQ4bIzCHtM2LE5Yk68GqksLDgbPnGUENsl2kC6auQo+l3XpE8hpCnctm
         paa7tx73WezO/MELpkA3RePWTF4F65e92jlFwni2A0aAf9mB2sn5L8KD5kaUpmmcp1E0
         qU+iWRM/UYnhX3aV0qeHq7gUP/+xfmA7Gt67yJtSXKcS3z98XP7r5apblCtVsOo55EG7
         tgsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780405318; x=1781010118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W6PZomB4fY5kFt4EpZT9MLtSi3pU0QOKrZbirr7Htn4=;
        b=IY8s2rf4b0d1WsOgxucTk5l3VqmID9AJhoGgjuLwnGKdfaJFlLt5lcQdna7TQcl1rL
         PQ5GpK0UuwhmVpMWClBEwXtQCUnfbkbYl01EKU7dcw0Tg7VCGctIPqpVMpZrVIybOBMz
         IP4pBxqmVQ8gytH5cjRL3bJwM89eMFQGFQS1UxjIJvbsbwD8/fujr6Yi9FHOFX80eIep
         GubLWTzFFPXFBPeQckGuImcZsU4REGGkbpBwN80vgc4so4638fxZ6Oc/Cac69MXSlCDg
         H+KafLbw9uVKVs4y8hXEyd4TNuTkGHCzgj1H+E+ueN4Vu7X/9RfCmiYlxquadR628dCh
         IUsA==
X-Forwarded-Encrypted: i=1; AFNElJ9HPUav0gm1Ikam1OczxZ/VZjspuhVhGXH2/W0e19xU0FE/yQbfU5GmSw8+TxLzx/FAGVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZTsdFCW/O+T/zbmfBEfSZsqL7W6Bp7EeEDUk+mEwpiEYuUIxo
	zGobludE66e3zflLwIAnI5lFpxWtKi/GJsqwye7du59SacwIZk0+g+NH
X-Gm-Gg: Acq92OEtgTR8W1ccCDKZ9ii5uJ91p3lQsz0Y3Ju7/HHKCIuRH+HRRzcRLcw2JilcFFo
	0w93EnbdwvMF8XEaa5kFNyYt2fPj9R4R9zDb+83NJ2Azyb6VMnxjlj7Bj2rxOveEBYQQwVhtZtg
	EVGenZZIiQULYjIASSuZs/nhGMjhXoswOBYWqoMerwyHQJ/aOFiCHtrfk6V1ZpRB4Az+6qYxafM
	N+UFqo6JJkEI5qsV5kAWuHq1ZcQpwD5r5Qq9uWIwfMe9lVkk+9akPgwk8Tu3zgH3m1jQ+OG5cxb
	2u+42iKuDV12hZJwf6/T8VxpX2TfzLM5OXwOd3tfHFoGNNtWRHNmHlW0zAC4fqcJyM3tIf0vX6q
	W/P6z6RVtdH2Jvc3OUed9/ugltJblzbC0orSlOYWpbpFTq1WIkSlZlual/PG8bP5rOChbMBFFXq
	iKSZTvGLPfFjH4Vaoj0CXilV8NYpo=
X-Received: by 2002:a05:600c:a305:b0:490:45bb:8dd9 with SMTP id 5b1f17b1804b1-490a29302c1mr223088765e9.8.1780405317292;
        Tue, 02 Jun 2026 06:01:57 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354bb62sm31719189f8f.19.2026.06.02.06.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 06:01:56 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 2 Jun 2026 15:01:54 +0200
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 05/14] resolve_btfids: Index BTF ID symbols
 by address
Message-ID: <ah7UQv87CmJ-LNMt@krava>
References: <20260601221805.821394-1-ihor.solodrai@linux.dev>
 <20260601221805.821394-6-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601221805.821394-6-ihor.solodrai@linux.dev>

On Mon, Jun 01, 2026 at 03:17:56PM -0700, Ihor Solodrai wrote:

SNIP

> +static int push_addr_sym(struct object *obj, Elf64_Addr addr, const char *name)
> +{
> +	struct addr_sym *arr = obj->addr_syms;
> +	int cap = obj->max_addr_syms;
> +
> +	if (obj->nr_addr_syms + 1 > cap) {
> +		cap = max(cap + 256, cap * 2);
> +		arr = realloc(arr, sizeof(*arr) * cap);
> +		if (!arr)
> +			return -ENOMEM;
> +		obj->max_addr_syms = cap;
> +		obj->addr_syms = arr;

could you use libbpf_ensure_mem instead?

> +	}
> +
> +	obj->addr_syms[obj->nr_addr_syms].addr = addr;
> +	obj->addr_syms[obj->nr_addr_syms].name = name;
> +	obj->nr_addr_syms++;
> +
> +	return 0;
> +}
> +
> +static int cmp_addr_sym(const void *a, const void *b)
> +{
> +	Elf64_Addr aa = ((const struct addr_sym *)a)->addr;
> +	Elf64_Addr ab = ((const struct addr_sym *)b)->addr;
> +
> +	if (aa < ab)
> +		return -1;
> +	if (aa > ab)
> +		return 1;
> +	return 0;

nit, I recently spot following pattern:

        return (aa > ab) - (aa < ab);

jirka

> +}
> +
> +static const char *find_name_by_addr(struct object *obj, Elf64_Addr addr)
> +{
> +	struct addr_sym key = { .addr = addr };
> +	struct addr_sym *res;
> +
> +	res = bsearch(&key, obj->addr_syms, obj->nr_addr_syms,
> +		      sizeof(*obj->addr_syms), cmp_addr_sym);
> +	return res ? res->name : NULL;
> +}

SNIP
