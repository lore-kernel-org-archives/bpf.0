Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9593E16F82C
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 16:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712334224; cv=none; b=Bao9nW7brOy3jKVe4zF/qUN7oaGFG4myn7FPlTyLO6ljBO6aQxUyepWZDDPK0Tn7INUz89i+kj7Dd3lWVFBLtS2kZQnYKYQu4y2U+PGbtgV22B/E0YroaCy4B7CSwDdkE6oe3C3d56nsUj82HH26aZ9WI6ovmH1Fjc8tjlhsJoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712334224; c=relaxed/simple;
	bh=n153wfDQ74Z0Rn0vefTD7AcUQmqSsmd933xd1EZ8jCg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=I68AZFxjXQZhkfUmazCSQUASLjNfJI3Gf5Jb0R6+nnYHZWJH3zxuuiJX8r1Duzl9XOeqBkanqXfj3i/xre0d7rEbNEXGCyQcVD42+J5JE3vnRWXyYKnD/q1ulqjNwI/0Br2T/owSbFY2kBN4M/UFNmgWxMfusKQLZnXUDgKlNdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btMZJ7zQ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btMZJ7zQ"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e703e0e5deso2115082b3a.3
        for <bpf@vger.kernel.org>; Fri, 05 Apr 2024 09:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712334222; x=1712939022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62HOYUcMsEfSNMd6D7XNzf+ImhMJlhPSbXFW6jY0YO4=;
        b=btMZJ7zQUAm9yAG7nhNfbxYN9mg+9AZbiE3DVPiVEQBbXziMjwkMiFw1+lGFtTJ3Xo
         I5MvLLI7lPjqNY0K3svTAcVIe4vzk1F0vWLl1aSEVJUT0fovXxqevPqmEz8M3xs2PIxj
         l5wE8LnnTFT/fGTY4LMph476x1CCLHAbf3cGEq7IYPda+VUHkOK/EdMWleWyG1yLpCwB
         t/s/tRTpZW+36uh4rU8ldeUwVNosyPsFhet0yckjG7nFdTN2eOpSy1l0B7mf2JDe0XCB
         2Pvf2F3hChndt68xj3NR5AQKfih8v1w6MXxUAegjhSBLaEI02RUnOy7RDRozX4mXV5T0
         kYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712334222; x=1712939022;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=62HOYUcMsEfSNMd6D7XNzf+ImhMJlhPSbXFW6jY0YO4=;
        b=W1ETyGkbED6SPf1tCqP5LQ6ntImIWjOti/IRib2dPMIio3oY0ospQNtgm6sGzvZiPC
         E5YLTKe1UMhoO5OmdYzaZenl4OKeqGA5a9C5foZWz8lnVM3LMTNIDL7xEslS+5ZBYkSG
         Pd6MQTJTRz4u4JvZHoeriqgyyTLZLEdUC0i+xG0Q2etZevRorG8VWomVnkIWTq8A/iBM
         OqTt3rsD0u+K4o+ZGw+AfR1+/WC6jgy2sxcXBYZg0u4I01aoF6727dWZI12quRKZmwBm
         G3f3PXTAqjJziz7Z91/5M/k7isNHbZrhVhpwx4kGZaN1khPj22oCQlpRNlmdUe1GidxC
         HoKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlxXL+pWeB6R+tzDUmJh/Qsz3OBOCRxkGdvc8hYSsu6ufo2whhRKVAHJYj5Gz+hYA61o1lrf6mgQq2w6yE6Z0ca6Q8
X-Gm-Message-State: AOJu0YzIa1fwzeHnt/sxqgkmyJwTZ0CUsVIPcJaqpqTxDRrsDaoGd65C
	MYz5Fcr++ws7MInthFH1TlhW3FaOTGaT2SRB3Ns/2NseQk81KYkc
X-Google-Smtp-Source: AGHT+IFXR7XEwPfU9k7MIau6Rce/pmiil3DgtrRQfdxHcG/ju5IEJDDfO/7mjHy7Q8FjScEd4A/4Ww==
X-Received: by 2002:a05:6a21:9184:b0:1a3:b155:1cd6 with SMTP id tp4-20020a056a21918400b001a3b1551cd6mr2495325pzb.8.1712334221894;
        Fri, 05 Apr 2024 09:23:41 -0700 (PDT)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id ka32-20020a056a0093a000b006e7324d32bbsm1682783pfb.122.2024.04.05.09.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 09:23:41 -0700 (PDT)
Date: Fri, 05 Apr 2024 09:23:40 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, 
 bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 kernel-team@fb.com, 
 Martin KaFai Lau <martin.lau@kernel.org>
Message-ID: <6610258cb977b_5a9cb20838@john.notmuch>
In-Reply-To: <c9db2abb-2391-415b-ba71-db80dc42cc54@linux.dev>
References: <20240404025305.2210999-1-yonghong.song@linux.dev>
 <20240404025310.2211688-1-yonghong.song@linux.dev>
 <66101695d69a7_5803020833@john.notmuch>
 <c9db2abb-2391-415b-ba71-db80dc42cc54@linux.dev>
Subject: Re: [PATCH bpf-next v4 1/5] bpf: Add bpf_link support for sk_msg and
 sk_skb progs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Yonghong Song wrote:
> 
> On 4/5/24 8:19 AM, John Fastabend wrote:
> > Yonghong Song wrote:
> >> Add bpf_link support for sk_msg and sk_skb programs. We have an
> >> internal request to support bpf_link for sk_msg programs so user
> >> space can have a uniform handling with bpf_link based libbpf
> >> APIs. Using bpf_link based libbpf API also has a benefit which
> >> makes system robust by decoupling prog life cycle and
> >> attachment life cycle.
> >>
> >> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> >> ---
> >>   include/linux/bpf.h            |   6 +
> >>   include/linux/skmsg.h          |   4 +
> >>   include/uapi/linux/bpf.h       |   5 +
> >>   kernel/bpf/syscall.c           |   4 +
> >>   net/core/sock_map.c            | 268 ++++++++++++++++++++++++++++++++-
> >>   tools/include/uapi/linux/bpf.h |   5 +
> >>   6 files changed, 284 insertions(+), 8 deletions(-)
> >>
> > LGTM one question below.
> >
> >> +/* Handle the following two cases:
> >> + * case 1: link != NULL, prog != NULL, old != NULL
> >> + * case 2: link != NULL, prog != NULL, old == NULL
> >> + */
> >> +static int sock_map_link_update_prog(struct bpf_link *link,
> >> +				     struct bpf_prog *prog,
> >> +				     struct bpf_prog *old)
> >> +{
> >> +	const struct sockmap_link *sockmap_link = container_of(link, struct sockmap_link, link);
> >> +	struct bpf_prog **pprog;
> >> +	struct bpf_link **plink;
> >> +	int ret = 0;
> >> +
> >> +	mutex_lock(&sockmap_mutex);
> >> +
> >> +	/* If old prog is not NULL, ensure old prog is the same as link->prog. */
> >> +	if (old && link->prog != old) {
> >> +		ret = -EINVAL;
> >> +		goto out;
> >> +	}
> >> +	/* Ensure link->prog has the same type/attach_type as the new prog. */
> >> +	if (link->prog->type != prog->type ||
> >> +	    link->prog->expected_attach_type != prog->expected_attach_type) {
> >> +		ret = -EINVAL;
> >> +		goto out;
> >> +	}
> >> +
> >> +	ret = sock_map_prog_lookup(sockmap_link->map, &pprog,
> >> +				   sockmap_link->attach_type);
> >> +	if (ret)
> >> +		goto out;
> >> +
> >> +	/* Ensure the same link between the one in map and the passed-in. */
> >> +	ret = sock_map_link_lookup(sockmap_link->map, &plink, link, false,
> >> +				   sockmap_link->attach_type);
> >> +	if (ret)
> >> +		goto out;
> >> +
> >> +	if (old) {
> >> +		ret = psock_replace_prog(pprog, prog, old);
> >> +		goto out;
> >> +	}
> >> +
> >> +	psock_set_prog(pprog, prog);
> >> +
> >> +out:
> >> +	if (!ret) {
> >> +		bpf_prog_inc(prog);
> >> +		old = xchg(&link->prog, prog);
> >> +		bpf_prog_put(old);
> > Need to check old? I don't think we can clal bpf_prog_put on null?
> >
> >    if (old)
> >       bpf_prog_put(old)
> 
> The 'old' here represents the *old* link->prog program and
> link->prog should not be NULL at this point.

Ah ok. Maybe instead of using the input old var make it
explicit?

    if (!ret) {
       struct bpf_prog *old_link;

       bpf_prog_inc(prog);
       old_link = xchg(&link->prog, prog);
       bpf_prog_put(old)
    }

Is a bit more obious to me at least. Up to you I have a slight preference
for the explicit more verbose above.

Otherwise for the series.

Reviewed-by: John Fastabend <john.fastabend@gmail.com>
