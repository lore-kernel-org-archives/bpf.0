Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB051CD2C
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 00:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786063921; cv=none; b=FfwPEFlEFR6ojeFh9DZcohgr8Fg/YSuGjr6XE721anAg8x1A/ku1RRCHtvIfYsU5i/hMIW/EfQTnV9MXQoESzn5fi+uP3x+dARod4KCVYzNu2Qu2QTmV7Xfs3GwDu3Jg7rtCxpiDS7yrHoYrJxystF4p9cn7B2PJgpzcmoK1z/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786063921; c=relaxed/simple;
	bh=ToPjXTb+xwaJ2FJQl/IhOm9Pkn4bHamYn52qtcTg1gI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sr58IuQaSTWPjKpGF/+9QaX2OrIkG76GwBWMBi+4QHDPTRexIOYHHXWUedfG+EEEXRiSWVqTwLJFrH10+UbZHVrXNT/jOfCjFxpujyN9dUb9yPJp5E2PhcvCBstizBkUtV1NLBeSeCfR4D4hrDL63dPTEKS+QfDPHL8fj9jaOLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBkSwC+r; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBkSwC+r"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38e58034d05so2620592a91.2
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 17:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786063919; x=1786668719; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ToPjXTb+xwaJ2FJQl/IhOm9Pkn4bHamYn52qtcTg1gI=;
        b=nBkSwC+rLMS2BLowsnMKUuw4Ls6z/rS8EtoNFNRqr6WI5NTIcWApkkubrWZknGfjLP
         FjkGpDETU2IIpZKMZ7T6MnZUrhutqDaM4YAXkCIbQ8oIAa4d99sGojYVc+Ko3kq1v7RB
         By0vMyMuuNhZIjReSneBJQnXotv4buo2qaWS5i43vaRjlnNmim6cxOlT89n0ivjTy7rS
         ZEmIZdKbpYpiJ8tr/wy0eWj2A41vziQnd7uxuen990DClxHhL4UPj5LQQi8Rma9WuFFa
         KnjqxG5rCOrGXbt8WMJNbE77eR2HWIx8ATLhVJ7DWq3Y8Lll+8Snb93TZv8wAp6+lvJS
         dsEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786063919; x=1786668719;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ToPjXTb+xwaJ2FJQl/IhOm9Pkn4bHamYn52qtcTg1gI=;
        b=KPCSMA0OID9Z8ddwV6uy+rLVyGB5hqNjrWRhdGxJaltVau1+ERFNeEdgiC/YlNE+mT
         4QFzVdLGQOltMZe7vqRoNfA/POY/0LLW4MmOXYM/C2vl+Lx6GmGco6oI409OZlRV7yuZ
         vGf+hamP1/dukItEF4AkgRJtP369vKiNTlAYcsvsGxRNn8n+5NxXXdg6nG0Anlly1Ixt
         6DH0XSVvsXWek4aWL00ZS52v1nZ1QIUH6mxZOBk5tdEAtNI3m1HikGQHkiKP4tRmo9MG
         rCXVBV4se55UDWYDsDGMvfF/W2iVTLyn9JX2awZzJCeEcOXgOCWrPZISj9EDM7XYT9Qa
         52XA==
X-Forwarded-Encrypted: i=1; AHgh+RrfV2TqNeTQe3U6NjJf6LlE8GcIrvMeW4i9SgzFeTvPnp1eFraRQnHnSDxniEwcI6ec92o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZcar6MNiXgnFR7t4aLY1+GIHV5oXTmukmMUGJ3Uk5FrNK68+Z
	z/tyDyYCk8SvvqI54KKXiYjczLxbzhO7GAs6QMGwLFU/Chs6T1XlKWFiNSl91A==
X-Gm-Gg: AR+sD10uT4G9Lut4ETKjIeB3KSCnJ+g0ENDbmQk7NzdIEIP66yvsqrqf1Eg6FmRt/qi
	Wdtmepu0O2GAoHaqTW4CEc/B827Z0QwiSI8s3nkWkmweLRzaAv/iKGzb4GWEjE5clp2R1mSZ0XF
	jkdPxxBN6zBeXnwDakyE2opFvVeCtIiOI0RXaEO7R6gvIH7ht6FmA/nDZGZXlLF2i1NX/44Pz4Q
	yFLCpWp9pi8skTZ6BhQwPdxE4JddHRT1ko1k3JKBQvQxuIujeRbKRBNu733XKG7UjmXDqUzNd+v
	Ac1LcxdLPadIQra27IfjZdSID/CIdoFAaUEK0pdLkPFVu4fdIOJd2jgx1RQSw6Q7qJ3VLIhHybO
	wCuyBslJ2ezNb+XfhZbCJR8olAPcIY+umxUTZTgNlSRTJvxhmcP6vVDx5HGpLccA3rsRudIJxWT
	pzUicQ7I6j4aOdxzUYmEhohg3BHed5t61nh6rAhEsuyJgH5KPamG+nk5+KIeCngM/lukA5KWqXJ
	JwJYZBm0pR2MkVW
X-Received: by 2002:a17:90b:4a8b:b0:37f:fb1d:63fa with SMTP id 98e67ed59e1d1-3903c5d317fmr14578168a91.15.1786063919346;
        Thu, 06 Aug 2026 17:51:59 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925ff7ee35sm145092a91.16.2026.08.06.17.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 17:51:58 -0700 (PDT)
Message-ID: <baa42b02c74c226bfab6a2e085fb3063a2fc23a7.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 04/13] bpf: Support __arena and
 __arena__nullable kfunc argument suffixes
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis	 <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Thu, 06 Aug 2026 17:51:56 -0700
In-Reply-To: <20260805210427.3218326-5-memxor@gmail.com>
References: <20260805210427.3218326-1-memxor@gmail.com>
	 <20260805210427.3218326-5-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-08-05 at 23:04 +0200, Kumar Kartikeya Dwivedi wrote:
> From: Tejun Heo <tj@kernel.org>
>=20
> Passing an arena pointer to a kfunc takes two steps today. There is no
> arena pointer argument type, so the pointer crosses the boundary as a
> bare scalar, and the kfunc then offsets it by the arena base and casts
> it before it can touch the memory. Every such kfunc open-codes the same
> translation.
>=20
> Add the __arena and __arena__nullable argument suffixes to make this more
> convenient. The kfunc declares the parameter by its real pointer type
> and dereferences it directly, with the JIT rebasing the value at the
> call site, rN =3D kern_vm_start + (u32)rN. No bounds check is needed: the
> u32 offset stays within the guard-padded arena kernel mapping, and a
> fault on an unpopulated page recovers through the per-arena scratch
> page. A suffixed argument accepts a PTR_TO_ARENA or scalar register,
> matching global subprog arena arguments.
>=20
> __arena rebases unconditionally, so the kfunc never sees NULL and a
> value with zero in the low 32 bits arrives as the arena base.
> __arena__nullable preserves NULL for optional arguments by skipping the
> rebase when the truncated value, arena offset 0, is zero. Keeping the
> plain form NULL-free saves the NULL test on every call.
>=20
> The double separator makes the annotations composable:
> __arena__nullable also ends in __nullable. Match the composite suffix
> first when classifying kfunc arguments and function-model flags so it
> retains arena semantics while carrying the nullable flag.
>=20
> This patch adds the verifier side: the suffixes are recognized in
> check_kfunc_args() and distilled into argument flags in the function
> model stored in the kfunc descriptor. JITs retrieve the model while
> emitting the call, avoiding per-call state in insn_aux_data.
>=20
> JITs declare support with bpf_jit_supports_arena_args() and verification
> fails with -ENOTSUPP elsewhere.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Co-developed-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
