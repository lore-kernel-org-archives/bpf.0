Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9BB4A4828
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789054923; cv=none; b=M7ew13K1Ywn0rTknhtWBEM+yaaOzNNlQt53UrsIrYYEBk4a633+fWMLrziwknvJV4gD78lVEVwauzvDhBWo6SiMEundjDg2INJM9TpcEF54zFVE29DiBLrD4xHh+WzWYXMLvXbaUPxD19XmWi0XUtpXeiWNwD7X+YTNGA9Hg3h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789054923; c=relaxed/simple;
	bh=gEWjIyP23zKOlG/fhdA01oSG85S2cPvjWdCJqXMoQ/s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=hY7r30VIx/sUrkn8lg4d4062Wwmm19Ahq7ce5E2Nm1pC5U7/r7oBXlM3Wh8EIAiMp4K6Z5M6lbvRjaIyJyji9lFgxeDdhBSIKbbcTFpODLkZ5yndNO7N4YqVrW3s2TBDYDU1lE6U/Iube7xLYT+mnNgxW9eXhZzlZsRsWmXOKoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkmNjG7s; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkmNjG7s"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7f4f824de5dso3310694a34.2
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 08:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789054920; x=1789659720; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gEWjIyP23zKOlG/fhdA01oSG85S2cPvjWdCJqXMoQ/s=;
        b=YkmNjG7sFFdNJdWkOeybOC5mPao/pkoQTKjb3Dqlgp6T4+D7us3GY2TrhOVpVjjvPf
         pQdYyrcnYlolxO2xk4yd4qg8l247ItxNAcNLPpokvYL2hSGuUGxDUt+xW1A1Z/+LHh+S
         teABER7Cug+3DG2nRSnbF0a90o/2/Ru/1LAlmob0sOMeXWXUM5Ab2lt8C0eCpNvUbO5f
         GK2FWBb9SGHFpEE/Ob9L9fwg8CR4aaxE/yoNB0m5z9ZOy1IWX3xCZjGE4fTtQVVRosvp
         BHSdlTNIrEyIngHekhhnsD5vwipNuZEbBhXL4ecgvRTF8t2eMyk2DsVKWzFOjU5jwLOo
         w2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789054920; x=1789659720;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gEWjIyP23zKOlG/fhdA01oSG85S2cPvjWdCJqXMoQ/s=;
        b=EyNekmJHxIIf3TCnEVYIxs/rnBUMtrsCtivq2qvQ2uGNOGIcnp6dbUJw2R5vK3YhqR
         HsUAfO4Xo3xJ7+7vSd8jwuUjIZey0BVyIHac9KPsNN0N0062RTsULUycRmW/Nz4JFm+L
         pqjwUta11hKBTsoWWiE1uZcsIieeajdljQutGMaRrXkehUtQ6csTYjctUjYxYQY2v/Kj
         hP5Vyqb0N/rG4SCnVKRV9SYKY0vRpWQfKzIH2P+ssfRlRkyRaeXNve7VL3aPZ0r5Kdjx
         NsNuUHLD1d2WyvnwxeRpp3gecSAEKcAQA1uPLqZGXYEfhcR0dPA3Q31bCYHdGBbq7fCt
         uoWQ==
X-Forwarded-Encrypted: i=1; AKwUvBzXOTuZgM8nZNoLw1udovfNJW6zfv/ex88qoMF550t88jgU/7NKf2cQYi5EG60GwBeBQHw=@vger.kernel.org
X-Gm-Message-State: AFuF++k/Rw3pZ+By7ngodm13Hcupq5cDCIR1GBY4W+y0J9xobVOSRqLg
	1V0t4bT1nn1BE12l1eOOwHFkdyS2hS95pZ1s87XGSYjKmq/h0+x5S8tSLvMN7Q==
X-Gm-Gg: AYBFou2Dy8DUWBwQIiWppxZXsMnlGVDi2HpIuMPAQQljHJdpspNmEQGX+1BoQWkTrpk
	BaMwWtu3f/6mxvvWvwYkKe+0RK00k2VSnIeZ1dGQqPqzcE4x8L2fGZKAeg5gqYGZUWv6YwiBcnD
	MFG8dLZVZQtbU+hJsWiYFjkj5goV9NdW1bmksF1zH9PM022WHgebbH4ul6mD4iW5jzcirbtKrBC
	u3i0DsElY+wiLPcr8GmqlL6WpEAskgGdU3NlBheq6dy3yI+6M8Fb5gM1lBGpVqz/fqTsoxDZrgn
	JSkj8+7RlKHfM+56f2whDGTJuIdSmGR9/jxC/htpYMxz6lFeb1Mgy2oyuuq9n6nXTFDYEByWH/d
	osfOG21TvHFkwcUAjcLfZqsWkmLkDHyyyndllhfQmN5SgQymQtu6XicG6BjAcRaFqR3K7txM1aB
	JXbR/elNIGKNp0XAdTevXL8QtTTDBhzKSmoY6+rrGR42Vbjte6EUKjWyRxeZvx19YONyhKkSq8r
	w8RPv3Zv8+ASS+NrJHGewB92ojQhHi8FcpQ+g0LqiRRURcWvn0O9X5fKK8TAxN+M72qhJehsd75
X-Received: by 2002:a05:6820:2208:b0:6b1:c841:f8e1 with SMTP id 006d021491bc7-6b6fbfcd2d6mr26002076eaf.14.1789054919990;
        Thu, 10 Sep 2026 08:41:59 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:45::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c0990cc05fsm145311eaf.3.2026.09.10.08.41.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 08:41:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Sep 2026 08:41:58 -0700
Message-Id: <DLBR1FDW787I.2PNNYKF8PP4MY@gmail.com>
Subject: Re: [PATCH bpf 2/4] bpf: Require CAP_PERFMON for kfuncs reading
 memory
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Daniel Borkmann" <daniel@iogearbox.net>, <ast@kernel.org>
Cc: <memxor@gmail.com>, <eddyz87@gmail.com>, <info@starlabs.sg>,
 <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260910142107.40582-1-daniel@iogearbox.net>
 <20260910142107.40582-2-daniel@iogearbox.net>
In-Reply-To: <20260910142107.40582-2-daniel@iogearbox.net>

On Thu Sep 10, 2026 at 7:21 AM PDT, Daniel Borkmann wrote:
> Mark fault-safe probe reading kfuncs as KF_PERFMON, similarly as we do fo=
r
> the old-style BPF helper equivalents. bpf_rdonly_cast() is included in th=
is
> list as well as it returns PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED for an
> unchecked object and is using fault-safe BPF_PROBE_MEM.
>
> Note that only the void form of bpf_rdonly_cast() produced a register tha=
t
> was readable without CAP_PERFMON. For a struct type id the kfunc returns
> PTR_TO_BTF_ID | PTR_UNTRUSTED, whose dereference has always been gated in
> check_ptr_to_btf_access(). The flag is not conditional on the type id, so
> for the latter it only moves the rejection from the dereference to the ca=
ll
> itself, which is the better place to report it anyway.
>
> The bpf_stream_vprintk() and bpf_stream_print_stack() kfuncs are marked
> as well. The former ends up in the same bpf_bprintf_prepare() as the
> bpf_snprintf() helper, where %pks, %pus and %pI4 read through a program-
> supplied address and %pB resolves one into a symbol. The latter walks the
> stack and prints each instruction pointer via %pS.
>
> Fixes: 4665415975b0 ("bpf: Add bits iterator")
> Fixes: 65ab5ac4df01 ("bpf: Add bpf_copy_from_user_str kfunc")
> Fixes: f0f8a5b58f78 ("bpf: Add bpf_copy_from_user_task_str() kfunc")
> Fixes: a498ee7576de ("bpf: Implement dynptr copy kfuncs")
> Fixes: f2362a57aeff ("bpf: allow void* cast using bpf_rdonly_cast()")
> Fixes: e91370550f1f ("bpf: Add kfuncs for read-only string operations")
> Fixes: 5ab154f1463a ("bpf: Introduce BPF standard streams")
> Fixes: 19559e844184 ("bpf: add bpf_strcasecmp kfunc")
> Fixes: b5b693f73589 ("bpf: add bpf_strcasestr,bpf_strncasestr kfuncs")
> Fixes: 1dc669646762 ("bpf: add bpf_strncasecmp kfunc")
> Fixes: 63328bb23f26 ("bpf: Add bpf_stream_print_stack stack dumping kfunc=
")

Let's drop this Fixes list altogether, since it will only cause
headaches to stable folks. We don't need to backport this everywhere.
Not really an issue.
CAP_BPF alone can leak memory via HW speculation,
so this patch isn't strictly necessary, but I don't mind closing the hole
since AI keeps reporting it.

Also pls add bpf_get_kmem_cache() as AI suggested.

