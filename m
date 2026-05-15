Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF09F191
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 00:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778803733; cv=none; b=huNsFHjHUyFwVLg4Iw29OwV+Sx6NVx6SRtsnoW73T73zeUIK9cfOPHVIu5nsrUe/DjO8d5hM6UOwXRlHzZ8In+1RJ0rhceWrPMdUDgsAGO42jmffIpoQSb2S4OoLcT9ft6i86ZFPF87pwW2yBfr9ffJ4wX3zBnA0vTCfBHFrT0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778803733; c=relaxed/simple;
	bh=qwzd7gYR3G9oqc36hD6UgmTtCPiWHheLj9P4fyjsQXY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=TYg+voRywA6Cz1lc3u7ZZFBl+8F7XnYQe6rg2aXZzbZmFrGEGmKw8Oxv7H9r97HQA9EGXoYeKccI6UqQOaf3VwUF84a7LPxMmqX6w2+bdNQsZBNyaAXBWK4jNMVWTSsoWPOrbLiwgPpwXZK6OfbhtytCrCz00TXtd+JpgHsVjdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZxDsYHs; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZxDsYHs"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-65318dafbcbso11043236d50.2
        for <bpf@vger.kernel.org>; Thu, 14 May 2026 17:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778803731; x=1779408531; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkzcpi6f3a5TQRwJpoc7JwokbKKG2Daka/0xM2ukt4w=;
        b=VZxDsYHschkElZbdhpxsj81rIzei7mCW1Tw9sixROBW3L9azJKxtpTHI7Mm7D3m5ho
         JbGYvf8v3ExghvPlG/2m2q/sA6jvUIablMijVcFM4lWarvFv8sSw73IVDoItxeFxyfgc
         U9JtVOdJNsR627mP4A0v/C0bmII50hR5xYZHZVxjt6XIE+ysfdjvIY3yaubVrJOeREgs
         Umhs0E4HxSnti/KvbEBlSwn+pLONyCipr0pYmW+KW4WqLv7w0c/CazsvBOVNstCdXJml
         nQ77WdYoyV/I6SzrmMZ9NT/nZa/vWIj9ymMrr0Q1TwA6PRywym8TNXkMxN/3pszUy0d6
         i3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778803731; x=1779408531;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mkzcpi6f3a5TQRwJpoc7JwokbKKG2Daka/0xM2ukt4w=;
        b=lOKIBOekfi+e3UiaMjNx8adZ3YfbscCwCumm32aAeLfCHTX4eRJZw2NCDb2jYk4D3i
         R5Qm0qQTbGeDdrvopcJU5gRX4P4O5vcoOVcQgnrb/EErzNpa0Hw33/Xps6erhIfqBrdL
         tpNhHuLV3z7Gx/fanbJZzZLEJj1Wfp6i9IzqmoIwYuv7XYGkSuQr1vnMEuLyyc1s00fZ
         hEkp63FCYDr6zezVSgSEjNTwzF2l2oEeD1hB3GBbu0qh0v7xV3HVBsXO8rhZxAKpbB+Y
         krxNmGCPT3PHW5FCwOb/bOumwSzc6mGw8rqAAFW4a469tWAhVmBSI5aUr/V1Kn1iIY0v
         rW8A==
X-Forwarded-Encrypted: i=1; AFNElJ91u7elUfW09nTPPaBwQa1MPgjR4fqxip8J/5wH6gOAnBLVWaLYVM7waaxq99QvuddJh6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyElSJ5JG1fqjH/RmwsEQ72c8hlIVthxuWBSTVW7hZS7BKvBBqb
	mAlKemO5rAK89J62Mvz1HILXwA5YOOalbaN4ynA7pJvLDWGVx20RjP+m
X-Gm-Gg: Acq92OHbt9kLfTDXO9FzENaUXLPbuYXAytR13JmIgTQuXfK2ySzSsN5zNT/530WxlJF
	NmM2nvXTsx16bQIY9kyvx29Xwvlz/S/J+GSUKZSHxmzMl2IC2vftetvHyYIjKbLYKbuOIkt0pph
	TgAj3GVSMMRRhuoJODHRzEPy8mTMjm/IVrAA8WS/vAB2drajHzqTHIPIK0D5Iz3G4kC8obeTUJc
	cz03X+AbmbAxQDeW3y3lcOTLId5R7or275FqHw3quAkr45lTx+ACmHEE479KywhXBW1ohL0AFiT
	KnJtNlL+Z9X422ucExi5Rr4PKf8cPdbiO5zXX7e6QCLnolJWgsZcJVwuMMNGwOB2jeKvPq1DhB4
	ILR0+JJee0iZxASuBacOsZDwNDJ/HhGCL6XHRoHvuL66ywUt/ttwwxw9LAJrRuubJatUaWD5jx5
	VbvC5EbovdGUXRJe23BVJHNoD6YMXXy2vOvZgj1FQFCcZanMLrk2SZUR0Ihzck0gybvplZl3p1w
	saYsxGCvP88+9OgSg==
X-Received: by 2002:a05:690c:6987:b0:7b8:9418:7605 with SMTP id 00721157ae682-7c95c201035mr17401737b3.38.1778803730660;
        Thu, 14 May 2026 17:08:50 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:45::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7c7f55bca95sm21073767b3.39.2026.05.14.17.08.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 17:08:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 14 May 2026 17:08:49 -0700
Message-Id: <DIITAO4S7XCK.2EUA3QLTEFGKM@gmail.com>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <memxor@gmail.com>,
 <daniel@iogearbox.net>, <eddyz87@gmail.com>, <song@kernel.org>,
 <mattbobrowski@google.com>
Subject: Re: [RESEND PATCH bpf-next 1/2] selftests/bpf: libarena: Add rbtree
 data structure
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260511214100.9487-1-emil@etsalapatis.com>
 <20260511214100.9487-2-emil@etsalapatis.com>
In-Reply-To: <20260511214100.9487-2-emil@etsalapatis.com>

On Mon May 11, 2026 at 2:40 PM PDT, Emil Tsalapatis wrote:
> Add a native red-black tree data structure to libarena.
> The data structure supports multiple APIs (key-value based,
> node based) with which users can query and modify it. The
> tree uses the libarena memory allocator to manage its data.
>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  .../bpf/libarena/include/libarena/rbtree.h    |   89 ++
>  .../bpf/libarena/selftests/st_rbtree.bpf.c    |  974 ++++++++++++++++

st_ is too obscure. Use test_ ?

> +SEC("syscall")
> +__weak int test_rbtree_insert_one(void)

None of these tests check parallel operations, right?
Let's add them and add the lock.
Not sure what's the point of lockless rbtree->freelist
when the whole thing still needs to be locked?

imo there is no point in single threaded primitives.
Only syscall prog can be single threaded. The rest run in parallel.

> +		arena_stderr("WARNING: Attempting to allocate a node "
> +				"for a NULL rbtree\n");

Don't split strings, since it's harder to grep for them.
It's ok that they're long and go over 80 or ever 100 chars.

> +__weak
> +int rb_print_pop_up(rbnode_t **rbnode, u8 *depthp, enum rb_print_state (=
*stack)[RB_MAXLVL_PRINT], enum rb_print_state *state)
> +{
> +	volatile u8 depth;
> +	int j;
> +
> +	if (unlikely(!rbnode || !depthp || !stack || !state))
> +		return -EINVAL;
> +
> +	WRITE_ONCE(depth, *depthp);

WRITE_ONCE? what for?

