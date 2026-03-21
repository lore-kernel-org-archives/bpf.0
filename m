Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F39311C32
	for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 17:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774114619; cv=pass; b=lPm1Lv4N7eYbnI9mB+XpYtBO1VSjLSp8f0tVnhGQqguIBTK7i0mNKxNienLIf719tWzaBFw7nnqcbAfovTE+QKpXbGT1nmeBXBRkG247h8BX0s91POM3u6RWDH9BgiOR9Ost+CnOVu2u2+ClQLd/jyPgLGWMouPOCPm8oduXF7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774114619; c=relaxed/simple;
	bh=Afy2UaHCzp8XbNPdfyoHRGs0Ua8F5RHvj4lYcWDPFuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ia2mMqp7gMrWZIuCakAbctGS2OfjVsmywaf/sjHxEz34SWRAsXP8D77sk+buhtiIMo1Fr/+F50jS5I6u+12kE/7MHGXRsp718M/oBGqDLDYcSXPrOIKwdPVEY/KIjhyFrpmiVk4dI88Rm8os+/YjMxk/9sN2sWW5VuekSTqkTmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3zh/tzj; arc=pass smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3zh/tzj"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-486fe655187so21613985e9.2
        for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 10:36:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774114617; cv=none;
        d=google.com; s=arc-20240605;
        b=U59Tm+0wM8WvnCgyxrF0kXjkxQ6NKYhtHrOOX6DlzG0H8cExfN+nNN/edTpSDbATu0
         T59TASmxb4PG3OBneMx6a4nD3V2Kb/jkkS/3pcMrwAsywfMN38BZ/RWHe2/B24tepX5u
         JNbXX4L7GrfZxhusVIL3iCY/5LrCA5TIJ2S/OZm91lnNNdJ5UFYM/hsULiAWAB1ivbFd
         IgTw0lk5FmMWx7/xzkk8gtSZGXc+0M4sPrhvZNry79iThd7pxnC1AByxZydSbzkDXxxK
         iZidj+0RXwNaESemchHr3IWllRDrpDzYOUKoU4hA51/8FaTdRqbfXV6L5FasNu5cjl96
         5mUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Y+9PfnTKizgvLcMJqc0FUiyfAk3mg4TyGnA00SE2rCw=;
        fh=5FxvmQiDNmuU4bCsd+ps8T1L/Su+gIxd0BuZiQ9xwrs=;
        b=hVPSfv1nYYOz/KqXVgOz2PgwYiiFSmJHSqZpK5pWpUSVF/aE0FmHFzEi34sJuufDsy
         M3SVWRhX/nhZJkct+J2qULT0gbRYNx9AcjiSr1RFcrfjOngRTKSZdaSTde6tBODw8w6A
         gWirc2lDOfpF0SfZBcozPeMphTtGY9cyTAJd8L+qqazIaS5w0zZb1AICk3IAK2fITKpT
         HJn9CAYEsubwM+azjom0av0U60J1kNuYUbBYKsNcHHWhAdEOkdUGqLF9pL3fK3lUlWzR
         tIGJInwIBjcIeK7WDWEQH6pzxEJhDOcs4P5D/uYdHAaszUEBHbBpIn3nk5qdScpvNvas
         s7rQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774114617; x=1774719417; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+9PfnTKizgvLcMJqc0FUiyfAk3mg4TyGnA00SE2rCw=;
        b=R3zh/tzjvQZw9wX0pNFCgm2zQ1jQ6oQ8m6AmvB/m2tJ872XVr8N++mihhFaEVExsUP
         HgqwooXwmL214iHsNcwVISemdV/2Zt4N/xYDFZmVF70pf8deNz1HGAWWvLfMyvEPSPf/
         +HtRuRa+h7n6ztscZ0E1/6dssVTMOrnSMfV1QIO7pFjxeabeBUZBdq9NA+tfnOOBYozi
         djmhGML82j6mAuwMJtAx4TumLNVPCOnNSeLKKyA5BcfbYU8+Z9fpZhYDWeEdIyeiUR/O
         JkyU1wob9qvvU2bFdDlj5m4KDCu3vxZY0XcPF/6Pe5XGToVJ4pu5jZPlPNve9A3gcMK9
         +new==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774114617; x=1774719417;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+9PfnTKizgvLcMJqc0FUiyfAk3mg4TyGnA00SE2rCw=;
        b=QVlTsHaJwqOQDxYyvlrzYZCn/5WQyW1ZTe//DUVdJ0I28Q6xrlGLSUcbGRx3RXBovH
         gOnlA8mJ2ygbTlV0EwxazhCQO+chPRTd/eXZ6sHaRnH1fmrX7JIC/HVTXK/Xs5hAbopu
         hxTxbF9FcqRe8uG85hlMJC+UXc6w4zJaFZtU5cQVdoM3XwKhZhtKvtd0sHBfttDJ8bEt
         Xz/6EuSYjxMCs+6DnuTq25S/OLn0BMUUfm39WKr0Qz4d3JMd76nrdRW+Jz6m9fHD4vxU
         FPhZKFOI0ksURshCKS4PDcR3/5fPtte5mGVwLltvOAmiGR3HxXzWrA/+AULlhiTZspwt
         rTGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmG7amaelxjYpJIH5kpAUOOmcpM1kgeFah7kRVHfjep0T7OLFJpy5x0z3teEf8Fb3LS+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmrhcKula6QvBBf2kBC4sYMekRFD4JDKEUlHAOwTnti/PTE3LB
	KvAbMbc5ebP4YrY8OQxO3lQRXUqonjpR3fLlo6gdltLwCF2s203QNlYJs2+O/+9SzGPNZn0f/iz
	NnYVtEeJ5yOC2RKkUy/srIALb+ePB2rU=
X-Gm-Gg: ATEYQzx6XYIApAEmZo8xa9TEFi01Ln3yvyo2+2WvLtOBCpj5cQ3JFJqLac6r32UWytD
	6dbg+b508IY53oUs9Zn5gfRy7xPvrPhZNDUZlbHLp+y1uOHOz1WB4UWSDnOsceY1pGYK11i3aMk
	ia/8ztR5yfSN52QFLvhQfl5OheXyIO35ewmdAzoozY0JiVouhoGF5v2Ai+e2Zl0iVPSBcgEIcm/
	bK3L06g1v6D4OKc/39NDENaYEYbDCuyO956p4C89RnmuThiOFqOo9pA5m0Lv1sob9846OFCRrL4
	y3AOeVPPq3c/ieoApVR++qKf0RZ9BzqALQhZeT9HpaVDwZzG+nBF1KP+YLI=
X-Received: by 2002:a05:600c:35c4:b0:485:3f1c:d8a4 with SMTP id
 5b1f17b1804b1-486fedb2551mr116656825e9.9.1774114616507; Sat, 21 Mar 2026
 10:36:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321024446.692008-1-irogers@google.com> <20d77c80-6538-4dec-804c-156402c26534@linux.dev>
In-Reply-To: <20d77c80-6538-4dec-804c-156402c26534@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 21 Mar 2026 18:36:20 +0100
X-Gm-Features: AaiRm51T8R4umn3vhNl3zRLi8Rm9QE0qMzoTWcSVi9M_Kw4MtIygviLgrZ2b8JA
Message-ID: <CAP01T76kB8BHSQXp_1+tScrHhQayVm+BhAiDqnq4NeNOS_cMQg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] libbpf: Fix strict aliasing violations in hashmap
To: Yonghong Song <yonghong.song@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Ian Rogers <irogers@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 21 Mar 2026 at 16:42, Yonghong Song <yonghong.song@linux.dev> wrote:
>
>
>
> On 3/20/26 7:44 PM, Ian Rogers wrote:
> > The hashmap implementation contained strict aliasing violations.
> > Specifically, the hashmap_cast_ptr(p) macro was casting pointers (such
> > as void **) to long *, and these were subsequently dereferenced in
> > functions like hashmap_insert(), hashmap_find(), and hashmap_delete().
> >
> > C's strict aliasing rules (C11 6.5/7) prohibit accessing an object
> > through an lvalue of an incompatible type. Dereferencing a long * to
> > write to a void * object is a violation, even if they share the same
> > size, as they are not compatible types. This can lead to undefined
> > behavior, especially with aggressive compiler optimizations.
>
> Potentially this could be a concern. Did you actually find an issue
> with it?
>
> The linux kernel build has
>     KBUILD_CFLAGS += -fno-strict-aliasing
>
> The libbpf does not have this flag. Maybe we should add '-fno-strict-aliasing'
> for libbpf as well? This way, we can avoid any future potential
> 'strict aliasing' issues.
>
> Note that bpf program (tools/testing/selftests/bpf/Makefile)
> also has '-fno-strict-alaising' flag.
>

The change itself looks correct to me, fwiw, but as Yonghong said, we
can add -fno-strict-aliasing to CFLAGS and move on. I also doubt the
compiler can cause issues here, since the usage happens in hashmap.c
which wouldn't be visible in other CUs where the call is made and
pointers are passed in (unless compilers also do aliasing-based opts
during LTO). I guess libbpf maintainers can decide what they prefer.

> [...]
