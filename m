Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE767456DE0
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267422; cv=none; b=mWTDR/2l6oszws/YWWAoLZBc5+EYgUnJJ9Za57OntvCRKGQPLWRhMGn4vzwbeAKSuvdrFs6N57cho98G8ocZNCz5aFM1ljsLplgLcnDFgDFMvG/Msx+NQsRi2biAU7kj9Iaizl7oxFGxUzrGBo9sbhPF01sZrJqI4osReB3JPF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267422; c=relaxed/simple;
	bh=73k6FJTz+3Iw7WPeGZfV2lzEAXI++hDZctysXJS34no=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=KH6uF2Plwfp/ZJro7tzN31fw62MVjxfi6nO7TjfBuuk+Wg51UumaXMIGhQv7b67pdvL1KOScAeXSGfZw5B1KEgFL1OlLVEXQUsOeylsgn57Mh+McZFxuNTpeNazusQnK1wEANDFNweC0t8M8qE/QTGRncmiVKqD7FhJVXb3DnfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MyjlpmaS; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyjlpmaS"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-85d43ac608dso29171657b3.3
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790267419; x=1790872219; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=73k6FJTz+3Iw7WPeGZfV2lzEAXI++hDZctysXJS34no=;
        b=MyjlpmaSfVZQNAS1iQcwXWJPsfpy2RfjDhajWZDPEVNcGMM5nHvxpkQH+fFsArSnBp
         iFC3MkOblYPubslzR+pKVDfdV5lEgX8rW/Ui1mP/p05uvLpGVEzaBbF3e54RFed/DWBd
         Nf87EdGwAZWHSx8M5CvwIWphvlHir6FLbO+H5dfQGUwh78iFqvk3NlojqXskjlSTVBY1
         PZOq24ZXokix0yvD1tNDismBsxIlOIf5KbTu2V1bFIvkcZOlUjpHnKcHzkcCpAHVrMTY
         k+gJi2pJE4MbwkDSe+gHxSPtEiwtwIzi8qr8GywZ4CMRT3DOezpp/TnfZsBcBHl9S1fZ
         lTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790267419; x=1790872219;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=73k6FJTz+3Iw7WPeGZfV2lzEAXI++hDZctysXJS34no=;
        b=Tyo2eBavGRQErZ8RY0vpNHlly9xCf6d1hcJgoiYkmIXq9cez5CfO/m+OidrHmC4yvK
         vGq6vJz5LtJbDtjq/+AUCPRmJbfTFsZ1gFhRfKWV787bgAPPEfYTJrzBmUBRdR62oSua
         7XtzIIzTVKcHs91OIpNILZLJT2vjWWS18UEBXsRDBINt6wj+TliK+0UjUDW1oLwRRCGg
         b8Y5N4J6jTtK1P47BOFWNH7i+QqQAXliFBo+2bp/Hk8wVGWsycrqqFbgFQatCqZOrWgq
         POd0uzUn+6wRpYogXdBCNcPapacFpADcM/eaExGu1zcpZK1KaRTqzHjn/lR99D6zM9ot
         QVcw==
X-Forwarded-Encrypted: i=1; AKwUvBzk233etMW61Lr3hBC7RjiBGuha9cwySqBJXOrO5pjmuOYWZl9Pek66EjcSU5qYNKEyilI=@vger.kernel.org
X-Gm-Message-State: AFuF++kklcbJrYlyRAO25lglYVYeQSeVxvZ1vXwucpcwMaPuxByCoraM
	ci5VjgGHwAjBKcx3/WleTnKVERlOZO0r0EbTUyzOMIg9xtjPEjGHRcUL
X-Gm-Gg: AYBFou3c4i6hO9zSWLgq/Jn/M7UozWBh/Tf1xYJn85l5jVy6EffuBZo7/ugqOmKm6dj
	MD/uVT7C2+GQpkz4vuv8BEw6PlaQ900oj4h49FcyJQNVD8t1dK0z0zIANVCqH04pwhhFy6UoSwq
	XGucY7wzTTIw8KMt+5QkAdrx4UYV5PsneWzJyragrWIPwg7NWgqnfJjMguZJtu45OD9vofyUbyM
	J8SlDomMIfcwuN9R6e5KvOnAulVsJ7jK1NgamAbvN1TbJNEODMGZrQhK+TcnAdrVi8UWqHF5Hjc
	cszzUAzs9Y5Q7Pu9UJcenkapsfsmmmmDW8p2vsAFq5TdTyeVS+5hgRubjaIcSN5lO5Xd52ZQ+Oz
	82kGYlygJNDmsb7D3yjffdzYVQs6zfKvzMJe2n5xd+5X/yAuuqZLC/nmMTDyKLnXI4VvBzn0aZV
	MviDPWdgXxz4wUonJlWP5ET3TzxOCPPJbskHsdmM5nTqrEbmkCpIr5SbNCk/xuFP1OLo3UNIEra
	/el+dUar3wCIxvO+LoQvAR8ku6ATfOM2LIGiZ7b5Gvwo3SnDuqYAtJEJJW/MwJwvq4Pm6sw7U6q
	28B0
X-Received: by 2002:a05:690c:e3cb:b0:8a0:9ec0:e13b with SMTP id 00721157ae682-8a648ec5183mr21164237b3.17.1790267419358;
        Thu, 24 Sep 2026 09:30:19 -0700 (PDT)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a6525dc675sm10883477b3.34.2026.09.24.09.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 09:30:18 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 16:30:16 +0000
Message-Id: <DLNOU1DBG2W4.1SHS4ZHDHYUM3@gmail.com>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Tejun Heo" <tj@kernel.org>, "David Vernet"
 <void@manifault.com>, "Andrea Righi" <arighi@nvidia.com>, "Changwoo Min"
 <changwoo@igalia.com>, <sched-ext@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 3/3] sched_ext: Stop citing the x86 JIT for
 the cmask cmpxchg loop
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Puranjay Mohan" <puranjay@kernel.org>, <bpf@vger.kernel.org>
In-Reply-To: <20260924160354.531101-4-puranjay@kernel.org>
References: <20260924160354.531101-1-puranjay@kernel.org> <20260924160354.531101-4-puranjay@kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Sep 24, 2026 at 09:03 AM Puranjay Mohan <puranjay@kernel.org> wrote:
> - * x86 BPF JIT rejects BPF_OR | BPF_FETCH and BPF_AND | BPF_FETCH on arena
> - * pointers (see bpf_jit_supports_insn() in arch/x86/net/bpf_jit_comp.c). Only
> - * BPF_CMPXCHG / BPF_XCHG / BPF_ADD with FETCH are allowed. Implement
> - * test_and_{set,clear} and the atomic set/clear via a cmpxchg loop.
> + * Not every BPF JIT accepts BPF_OR | BPF_FETCH and BPF_AND | BPF_FETCH on
> + * arena pointers: arm64 without LSE rejects every arena read-modify-write
> + * atomic. Implement test_and_{set,clear} and the atomic set/clear via a
> + * cmpxchg loop so this works everywhere.

arm64 without LSE rejects BPF_CMPXCHG in arena too.
bpf_jit_supports_insn() there returns false for everything that
is not load_acq/store_rel, so the loop doesn't load on such cpu either.
riscv without Zacas is the other way around. It rejects arena cmpxchg
and accepts fetching and/or.
So the loop doesn't make it work everywhere.

After patch 1 can cmask_set/clear/test_and_set/test_and_clear
be __sync_fetch_and_or/and and CMASK_CAS_TRIES go away ?

pw-bot: cr
