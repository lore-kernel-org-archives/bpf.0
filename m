Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1AA368293
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 02:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775702045; cv=pass; b=ngi+31WVOFbwwas3spDkS5c/hconDdLkAabeOpl8eOkEe+srM2vABV27ZoDo2VFn5dV6lNqjMYeBHgVzPDT/3xqlUfc5fw2UVZhN/zgPyqZEZIeNXONcrVtoa8VgkwJCuQt8YCcGhtTdiNSnO8ppIwdxra7zMzulxG4cxI8Xo90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775702045; c=relaxed/simple;
	bh=3iXYLL7ZTeLjfMXFk7O1ltQciT2rgkYob/DR9p00BOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uLT5TZvPp+C0e+9WM/mYc0GQHyDKEbIaa5X2WsHZ2CrsAtAevIv+2CJGb1H1QO5OYjJd9LsWn3M/Un9seJfDujugy7h0tE2ZVLjgwLVxDUmmfdUYchFQpiN+ItnTs4Wy3fh075FssJA0fvzH4vFu+8Bm5jXDCnA38jxGIo4OC78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWjORgsF; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWjORgsF"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488b0046078so3374405e9.1
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 19:34:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775702041; cv=none;
        d=google.com; s=arc-20240605;
        b=jC+bWwCNTkt3+uQT2UPVbzOcs4FcrcSR0A9l7Z7FlEpTJEZjgsQUk3d27rUFA+Q5s0
         MqpwnwGLZrc2nGOOBJwgE4uM+7ZfEOdwOfhfncF/2+D9dtVXZldcKPAnbXiQJTVhf6b1
         12N8KJlujqeQo4Huvk1je1p3QW3h9MnL7/fIyPeGGFAVx74Njglvx8rGb1oGMrAkwxqb
         VlUhP7C0gR2W94/lO8J9I8uI1jXzY6rUb78swMg+vySfv7023Q7UEoMGWBihrfJlxt+g
         gtdYv+2yoHerzJpwLMi77ZY1jvfqNlmZUwY13jsRSdDPt+WQ/yAdVC7sX/4DYUieQ7/D
         7omg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3iXYLL7ZTeLjfMXFk7O1ltQciT2rgkYob/DR9p00BOI=;
        fh=yJD8G2PFrJEJ5ou/PGuX+gCp7xaXtso+pr8M1o1C8rM=;
        b=D6qkJW1sctS56TMVIq/VsiuHvBLTr4KD1WJsUkb03EVuh2kN6UCd8sDiJYUwc+tSZm
         pTMJwOSrFHPEkVzvNawfbE4nWkIr97nL+CegJJ9y12jCSJgHXH7v7ITlkDkWxxUWlnbI
         9XrkSZ/vg/ZkgapUWIeRjvA+tAvJoZBWIZuh0N1oUs6XHFMvgDxiU0bEFraJ4SqjjKlV
         U3sg0Jnc9+C6XBckCqzLoFj0ISU1nHMN6/a1u89wZyqKUseKntZ8NLSQT/n90DheSDjA
         5qIg/ZwdyirgPJNdfhGZDgq98l7tDXpQP5w4RWk76cD7X0SbID3TC3jBxt9vQmhMKRDq
         NZjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775702041; x=1776306841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3iXYLL7ZTeLjfMXFk7O1ltQciT2rgkYob/DR9p00BOI=;
        b=JWjORgsFjjSYeZztVkh+aEO5pr+ZpV6o5CxQh1KjDMqwLUpX6q32kEtCD7ZCVf2RTV
         A3y2Uo4TQqhUMOBLHiZodDsMMUDh797scKlT2OKQIh7BvicPCp4vEIa19oAqiiYKt/vs
         apiR7S8WPoplgIg1J6JIhTu2T0eNCTa5lhq1pa11soiPQJKtxTcbF4MH50r9tgBLhxqg
         vQBjrutXF2mdgP0lX/9GnECvVEy9Fl75DnxVbhTc2TzyqNLDXjd4jYuJA9UAokUGs5n6
         c7Y9c4gabsAD7AwPmeH1w3rODL/kj9AJHhi0CSqtVdc3WKw9xV4poH6+iS/qWXJg4mmr
         vZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775702041; x=1776306841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3iXYLL7ZTeLjfMXFk7O1ltQciT2rgkYob/DR9p00BOI=;
        b=UmpkGptOyVud0PMHz98sUqYlJHgQ44xjRElFSQZV3+HhjOc0HWF7BuMk1XxaXZOxCn
         ZtgiyDXTVGWPJtpirmrNAllSG9r1oBaQIIrEX54S933wpI0LIwmwm2rByGLTiNb/T6i1
         ylt7GY3n+Ns0Atx1HxPPP9bchqiTyfO8mhpoSMXnfkxD47ZJmd52EtIcoUMRQ/mszqPK
         xnaodeBLQbjzYiwc0GxsvSO9sXn7CBVNo2/OCQ+G/USEcBAZBmboX8EGg1LYhiQTCQIe
         2LjDZoqQK9/0uMBu+TQ0R726PfXc1q+Ix87ruSzeT0Vzv1tBTw0BsRKQ/hcQyL2Qgie9
         BzEA==
X-Gm-Message-State: AOJu0YygJrONdLwF8xA+vvpSnGuJalGtHGjvG+8HcxjWa2m8mxx1y5yO
	rnC68ali5OPF9DWlrtzm3xfftbRwhXeTAYxRWy/Z/T3VfFROn0mC+x6E+OMcij588+4/5pSuZtE
	Ba9Ixsh9IP6p2m69ckNF467Je0vxBvuc=
X-Gm-Gg: AeBDieviICatpp1kOv5ZVwe2EMLjAxBj9ureVlm61bvmBbgFo/nNIaIrdNKEqAHZSgR
	khrM0ECnHfWnHqEuAByQLWci4Pq632il3Fr874fIGwPmivJk6hSqogc+kQbHnA1kEUGwBmOxKrg
	H83et4bQxAZQcscRIR30p534VeEXucqfUiXLuedl9GSer/BlZCwDliD2o6xW4bCiPsEEPXp8tVo
	nIbA4AA71Pj5uslkOfl6ajHljw8TcqRxTIsbkFjyxKl2nk4pvwYE0oG66p7WlkLxJXfZ+YupxUq
	1GTVdPlKsEy+ybPuu6Kc4mMTqRtYdSMYNqCh51PdvKPunUVrU1Awg/QN/4dXMxTZXiTaUuydsFQ
	4xMM2nWjsBhtmecerYlyMIZemyg==
X-Received: by 2002:a05:600c:358b:b0:485:4135:5c92 with SMTP id
 5b1f17b1804b1-488995cb858mr386413205e9.0.1775702041098; Wed, 08 Apr 2026
 19:34:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407045730.13359-1-emil@etsalapatis.com> <20260407045730.13359-9-emil@etsalapatis.com>
 <CAADnVQKnHXg0YnuLvzfXjszMaqugpMNWD5=ipffWS4GVNg6rFQ@mail.gmail.com> <DHO7PDYZAY17.1I9BCM8TQWIJP@etsalapatis.com>
In-Reply-To: <DHO7PDYZAY17.1I9BCM8TQWIJP@etsalapatis.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 8 Apr 2026 19:33:50 -0700
X-Gm-Features: AQROBzCoUquyCH9biDKGaMaTmdbsMh7297OH1fch0XoZ_tsBf_1KVQnNaBM-BLs
Message-ID: <CAADnVQLdhjd_owgNxxyP_ozk2R6NX_UR-ZgnpF=2PFnUJYNp9g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 8/9] selftests/bpf: Add buddy allocator for libarena
To: Emil Tsalapatis <emil@etsalapatis.com>, Puranjay Mohan <puranjay@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 5:53=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.co=
m> wrote:
>
> > BUDDY_CHUNK_ITEMS is used like NULL ?
> > The header is u32 + u32. Is it really worth saving 8 bytes?
> > Use two proper pointers?
> > How many headers are there?
> >
>
> This is to make memory corruption harder and keep ASAN effective.
> The headers are actually embedded only in free blocks, so they're
> not taking any extra space. However, turning them into pointers means
> that for 16 byte blocks they occupy the very beginning of the block.
>
> When the previous block has an off-by-one it immediately corrupts the
> allocator freelist. Worse, if the header is at the beginning of the
> block then we can't catch the corruption with ASAN: The header must
> stay unpoisoned since we have to read/write it while the block is free.
>
> Since these are arena pointers maybe we can store them by turning them
> back into address 0 scalars to both be able to do regular pointers and
> pack them into 8 bytes?

that probably will be even less readable.
Ok. let's keep them idx for now.

btw, please trim your replies.
gmail sucks in viewing/replying to long emails.

>
> By the way, we're calling bpf_arena_alloc_pages without the lock because
> allocations of the order of ~1MiB fail when we take the lock (which is
> fine imo, it makes sense that the nonsleeping path isn't able to satisfy
> large allocations).

That's weird.

Puranjay,
that shouldn't be happening. What's causing this 1m issue?
