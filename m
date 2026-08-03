Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0F91E7C23
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 07:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785741721; cv=none; b=hygkgcWYLj6y8mE3Br96wQcB9Lz4ef+9eyiQP/eNSHFzQlMQjs7ZkZBwet3Yc9nLji4U5OJfPnxtR5Rk04dQEV7kwGjSH0khE4jw/Iw4nbsWuWsOjs9TeNkLHMy2YYWSbiViUsaRBpRD8z+WxnTBgoxjRyFsp8yGs5yJ3fdcfRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785741721; c=relaxed/simple;
	bh=be/mZNkQL+C9lM8B9kvWX+b8vj1wX1nOekJqxAYw65c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=kUNZnruMnvrNJykPdXzcxS/u+cVYXVF9GRd3lot9MyPllMsfTsiaefLGmx1cUal3paNmFW9Dq0YrmwbfZ0q33KAvqpOv7ziCNbtWxF6VQ5Q90xd2uVwtXTfHf+eghqL3TNS43k9NYQK/KmNqDbtr6ROoZqNTJoPfCCOsAfIvO3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQv6lsCs; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQv6lsCs"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-473913157edso1060237f8f.1
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 00:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785741717; x=1786346517; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=il18rGcPk+ZSsfswMbxUr7Bg2PaROYJ6WaJMJe/bAHo=;
        b=GQv6lsCsBK0WXNkcXthru7TqAW5g2PNV07tamQrfk6R7X1C5TJui3JZYQpzVuSAKt4
         aIiMzgqZ8ybOABcVetI3LctxEl7uR5fOd3ztFdSzdzW9SKeHCgvEMEszhpQVjHOfDzJ8
         GkGjZnBekokN9vAYAdf6pQKWWjGHoCEORhBXsLlNsb8PHGDOXBaUJI1cYsjhsFrr2Zms
         NaQ/JiPgKe8J0fHdYG0JRd8/hkXfr+q/3OchcDD8VsLkZxMixgDWbiaSFB7pt8u/4kGy
         y2i+RL7yfUS8XokdH7W95FrYvy8JLHFj/0bKKM2a07rA7YZAijMZEXA02y7ooxlh9Z8e
         Ei3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785741717; x=1786346517;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=il18rGcPk+ZSsfswMbxUr7Bg2PaROYJ6WaJMJe/bAHo=;
        b=i3wFxTFYHYBFIi1UDa+1v4jeLToSnmYzGZJkiPVMP/Cnr7JtvmBsm6NVcolF3OGbH1
         I030FPy6FPXWL/BDv5s79BvR8Sj2xrBNtTc/pEf5Nhp1saS9IXV+g+q6YT/rerw0HVWi
         2EgNhqYje6z7x2KLcXsBLWOR8pibfeM8iXN/N/AeK8O9cGpeVd1Gno9In38FL3o1fFIU
         B1jeyOUx2IfKVaMK2xz4ViQGGWGRcetArrCVSgjXRMlY1iY2S/PHpjfVF9C/iQ4tK/8I
         +NDGoeA7SYc6ujuLX5IzYKbrmzOWY1PCusSGzsCTN4/cgQh768uUc27DE41+M6Jd4WJp
         5sgA==
X-Gm-Message-State: AOJu0Yz2zjRdsAkQ111k2kH2Iv5PUqdVapONDvU7EHWZiVCeGVZU31gT
	3szsjmoxcFt+5eSnD1OS8rWI0Oi8gZcGAcKy9T2469YhtdiLNdX5rzxn
X-Gm-Gg: AR+sD13hpDWOX8b2h6v4ukYvRdb3wx1iTFYf7vel4HxfTCX9bu72aNRsmo9Tn2qs0rs
	HP5e/3F7KOYEpK1MAicN5U6ECWgp9tinyv1Ab4cvsymsAQh99g/4x8BsFUTw98tU4vuaGp+pXaF
	eQcmmYKhDNXuUeoYFhqvSXoDt5vPeJYfLBnLlO78ZYwJfR0qr1Kt2YhgISBThlD7LsFkkrnRxsy
	xDgq0rATR/POaFbqZzPRyQbJzZ9uvLH4ARaGCl6MSp4VUjD5Wm/TkkYW3m1udLZXMatvuVaU4cT
	53MSWnZ6ORgf4uKCZ23a1Ti6VPQpG8/4WSj2GzDhiJ7g4z0IWVuEiKAX5CbNXRRH8drTHWp/aU3
	hG2bw/8nw/fZWQ/bVCx7+QAlPBTlIPBthjF/zt2mpB+wzr/Y1/qnwHiwP2gnPWvKLt9FSmMcsrG
	3ai6scswwuhbdfcmOPKpkC91YWxGfqHfTEZgMfZZYsJavUCwSepqK3uwC1qtZ4EsptCOjLyChyN
	6IOd2EUPeq8E/YukDajf76XLwhLl/IexYhKY4wKE2yEcixwRWuHT1qK2bWoEA6cWiPFaoOJhPCR
	6qkdziio+i5ym35hThw20SD9E/rwhwXZSBqwrg==
X-Received: by 2002:a05:6000:22c5:b0:47f:97bf:d891 with SMTP id ffacd0b85a97d-47fd72a5b52mr19364695f8f.1.1785741717288;
        Mon, 03 Aug 2026 00:21:57 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41e296csm27862829f8f.12.2026.08.03.00.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 00:21:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 09:21:56 +0200
Message-Id: <DKF4LVGKEKE2.2LUROK1TAUGZ0@gmail.com>
Subject: Re: [PATCH bpf v2 2/2] bpf: Reject untrusted pointers in
 refcount_acquire
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Ning Ding" <dingning04@gmail.com>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <martin.lau@linux.dev>,
 <davem@davemloft.net>, <greg@kroah.com>
X-Mailer: aerc 0.21.0
References: <20260726235030.1152542-1-dingning04@gmail.com>
 <20260726235030.1152542-3-dingning04@gmail.com>
 <DKEUKIOKSY28.2XVQVGCKLI40C@gmail.com>
 <CAJP4iuuYfqFChH1P2=3Q6WxHbMTNnAkCagR2k+Lr4W155gCj3A@mail.gmail.com>
 <DKF31NEIMOOB.2CPM6KGVXD73K@gmail.com>
 <CAJP4iuuz0T694PnyZmcq9f9PaQLX2kV+Sd+veQN+uydsvZ=BFA@mail.gmail.com>
 <DKF3XPW4HDQK.FDJMYDLGXZ60@gmail.com>
 <CAJP4iuskVz4RUrXKcnNhcAwMwcNjCP-Pzpc6=HqfWoDpHKWgWA@mail.gmail.com>
In-Reply-To: <CAJP4iuskVz4RUrXKcnNhcAwMwcNjCP-Pzpc6=HqfWoDpHKWgWA@mail.gmail.com>

On Mon Aug 3, 2026 at 9:10 AM CEST, Ning Ding wrote:
>> It will work, you can test it yourself. Reads on PTR_UNTRUSTED is fine, =
it gets
>> handled by the BPF_PROBE_MEM loads, which handle use-after-free safely.
>
> But if we apply the one-line change to type_is_ptr_alloc_obj(), the
> read-only test I added will be rejected. SInce the read will hit that
> code block and trigger the allocated object must have a referenced
> id".
> if (type_is_alloc(reg->type) &&
>     !type_is_non_owning_ref(reg->type) &&
>     !(reg->type & MEM_RCU) &&
>     !reg_is_referenced(env, reg)) {
> verifier_bug(env, "allocated object must have a referenced id");
> return -EFAULT;
> }

We can make a specific exception in this case IMO. That is easier to reason
about than allowing it by default everywhere. We can even add a comment abo=
ut
it.

>
> There are 2 possible solutions:
> 1. Split the type_is_ptr_alloc_obj into 2 helpers, one is only
> checking whether the pointer has PTR_TO_BTF_ID | MEM_ALLOC, the other
> one checks if it is also trusted:
> static inline bool type_is_any_ptr_alloc_obj(u32 type)
> {
> return base_type(type) =3D=3D PTR_TO_BTF_ID &&
>        type_flag(type) & MEM_ALLOC;
> }
> static inline bool type_is_ptr_alloc_obj(u32 type)
> {
> return type_is_any_ptr_alloc_obj(type) &&
>        !(type_flag(type) & PTR_UNTRUSTED);
> }

I would just create another more specific type_is_untrusted_ptr_alloc_obj()=
.
Tighten existing type_is_ptr_alloc_obj() to exclude untrusted case.

Then just add "&& !type_is_untrusted_ptr_alloc_obj(...)" to the list of exi=
sting
checks before the error you pointed out above.

In addition, I would add a comment saying that the BPF_WRITE case for the
type_is_untrusted_ptr_alloc_obj() types was already rejected earlier, so th=
is
check only permits reads on them.

Then the test you mentioned should continue passing.

> reg_btf_record() will use type_is_any_ptr_alloc_obj since it only
> looks up metadata, while bpf_refcount_acquire should use
> type_is_ptr_alloc_obj.

Is reg_btf_record() going to ever get such a pointer as input? From my curs=
ory
look that doesn't seem so. It was happening before since such pointers coul=
d be
passed around to helpers or kfuncs. That should not be the case anymore.

>
> 3. Keep the untrusted pointer check on top like the current patch.

