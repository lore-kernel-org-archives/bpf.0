Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3D734E762
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 16:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783613955; cv=pass; b=KVktzKHw/Ru5x5OBBvgXiXq8DW54SsdF52r0dD2YyrmxjZJL1wkZCO4VEGVmNhTXht7MXHhdA4Fv52jbZEeF0UWISimJ1ysb18bbDvU49hHdvO6i1pgRIDkTGc0cX8cv5TyqzM0ruzjEZSX7k4MIyhINSHGr+q0P62epqe49n0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783613955; c=relaxed/simple;
	bh=gQxGM2eu5u2Vm8H9Ywp6lE94Xvf3IuH3yqG9rxlZuY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YcewEn2PrYNTgnvTTezYhjAkGonBJ5/9h4Xdvh9grgiBrUONytARHKgEjY4cwlXxrevEYqnzuQB4kTwaJxc/QYi/vPifw7Zd93fLt/1tTFxFlly/g51IPTcNGlZPMagBTG2Sx3c0b2fqBeHdegexOwXarIPYe+uPrzVMgxWalpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wnB6nh1Q; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wnB6nh1Q"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84347ad88edso2850365b3a.1
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 09:19:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783613951; cv=none;
        d=google.com; s=arc-20260327;
        b=C1KrwbvZ1A1lJFGO3kqfYL5jdmqUONnGNDDVErumG/P2Yvg8nsk+NMy5Bax0P0JDTV
         Qvqtt1XMwuMa/RyuOpW/sFPNj8DHFpNH2NKy+BYFJ1QRm2G58Qau6SgBxN0nKyjdPsTi
         Pk6SrorITN9U1UIYvpo/QG+GKoMlgEX3+qE4dI7WDOHLuMxh/gDfPxI0VR/4dgKu1hAi
         3uyFSDrnTe/7bcsW/QVNwZD2WfWyQ039rgEQ5QQNO7BrXmuS089IdkaCCajIJBkb2CcY
         RK837LcOVlfQRUHTrbY+qPbdRJqBLcTyFsEjDkOnA+LER78XwKeSQmVV4tbwqmVPm1aT
         0oJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gQxGM2eu5u2Vm8H9Ywp6lE94Xvf3IuH3yqG9rxlZuY0=;
        fh=N7uNg1MOTwLqze8c2SQ9myCLxUwPb7rv4TlUj2bZA1Y=;
        b=m+pR8+AXo5fr8e0EIk/8WGcGl721bS6t+jhwrjT7qQzdkxWoIyva3D98W6YjvCmwDr
         CHWIuFJ2Wt1PW6VSDq0BkbGnC3xLi+Ock1mhvOst/vTK1Q9XdVUmDBb1+2eOCKqZW8+b
         4HCbSMKht42ln0QUZm4qooypSi9rMhawXZ/4aEFc4pHpr6O9luXdTZyUTgB1b5RyvIjw
         9D4q/4Ln+iuz8i/B3KS3K32njpl8V0ohJiZdmaBam4Pon7c3RDhN54QT3tpkICRvz9mA
         LA/rXuNifn7PhOdhy0zF533okTDRvO+L4z7Egu5YeAihrM9oy8jjbu0Lj9rn68GafxIU
         NWAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783613951; x=1784218751; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gQxGM2eu5u2Vm8H9Ywp6lE94Xvf3IuH3yqG9rxlZuY0=;
        b=wnB6nh1Qh8DREGyiH/uQvoaatPVZf6PA+eqqcViY5Gb0PYpjxcjZZ9+Jry7Z0DugGD
         muEgATZXsFapR6LhJR+cn7mjd7jNzCoDi/liIbSLSWFV6qaKFByHC9wOeHml5WY3vJOZ
         6KG3O2uaJ9l114O/kDeDivyQDekIVjyDPhmQn4Slt50XNL+TkmnAKzqlcvNxUpnj2yMF
         OVuiXoK8dCnZGmYS1dlKiyae+k6paxDlNs7JMXOoeVgbHqmB+cb4hV6OPpF5l/O9xjYv
         4ky63tQ3LRvEQMOIiw+mIEAro/KtcbZS2QGLDzhEJ3sjR0FafoO8xmuuyCiEUIIu2v+3
         SDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783613951; x=1784218751;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gQxGM2eu5u2Vm8H9Ywp6lE94Xvf3IuH3yqG9rxlZuY0=;
        b=ZYz064Sws/3Q2h85IGcNEzgZVDSb+vtBDlKbDWNEXDT4qdqeYvCsAvk4ZhPQfmPSnJ
         pnrISMCjtfxWW08HN/+A+/9BWI+BZl7Vci1Ct9uBDI8qyAwUF31IvpehN3itwaKAKOc9
         Qwnj8n7Qk/a5Zeg6DV6vSZPiQxFyUCnVutB+aidKowHSXpZ5KJV9Gg0FZTCX686SG+V0
         v2rlv4q0DG3Lb4vTtBlxcj1weLErfOcYDMFpeqlK25oJSaiDnI+/f+pCoKHgcZWC6Xkq
         El6WqnFDgH2iTnXPLM+A35O5ITACXtLLISko4FIPnvvMo498f3DZrNfsQkpM1SUanji7
         VOBA==
X-Forwarded-Encrypted: i=1; AHgh+Rqk1zZZduZayhknjAWz3W8j2Lkyu8r4Iymf+pCwKU8NR3PrVSrBHGxBN+2AprBJT2/+Nj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY0RWAWBaLQa3uqwog/VUgIqmrbywLz1J7v1VJjml1FqCYqKE1
	E2uQbJ3cfCtHJybUuEDR5Mx0LbhBS3LnLNY9Py7yQcnYyX8NW8GT48fv/yQdrELB7pKle42TCam
	fcUEOcvtf1lH3syhNym/4CDMh0sUu6nz5zEdjNLJG
X-Gm-Gg: AfdE7ckUX1EERsjS4L0qKURpFhDSDzc2qcuFpckruMWK019nQF+RlTRBRa5WoFZnOzB
	YqgBcSiQB73m1g6Ji2AWJ9AGFnP460VSZadwMKrDoOEwZoEiz+oAL542etH/+tr6605ryYj1Dy/
	ZmD3FIkmPsd6iqFxmtktF8UC6+uoeFxzoRONBFrbxAP4FTjR3xhRbMcr3LFpuDq335gmd52Gly1
	PkKGaIxhe69yyNcoVk34iZm8LPZjrEdtYlee4V2AcmZLHrLiV6dxi1X4zkfXlBcyv0bhjvHxFN7
	UtEENrNqUVul4q6Tvy/aUYuCJnNgxqTypiybhSRIjpqgHcqULD/25T3b3cjEJNKE7+zNNLIZYai
	R2xLq6AfSHN8tuuW5/9uYl1HWQIzJY7lo/r6LGRMOsA==
X-Received: by 2002:a05:6a21:681:b0:3c0:9c1b:d0bb with SMTP id
 adf61e73a8af0-3c0bd31f12amr9478849637.70.1783613950892; Thu, 09 Jul 2026
 09:19:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709025316.999913-1-mattbobrowski@google.com> <e30f1c25-bc81-4a2a-a997-9b7007890b03@iogearbox.net>
In-Reply-To: <e30f1c25-bc81-4a2a-a997-9b7007890b03@iogearbox.net>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 9 Jul 2026 09:18:59 -0700
X-Gm-Features: AVVi8Cdf2N_xKO2DUBcyOo5bx6SqShDIF7paay7Ksht1saLiq2ja-PfJ_1i66nU
Message-ID: <CAAVpQUDh7bNkLyQWzXmu-=V4KEV_t9-9ubaj3AjjYwJFivbNLA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: fix UAF in sock clone early bailouts
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Matt Bobrowski <mattbobrowski@google.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, jannh@google.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 4:53=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
>
> [ +Kuniyuki ]
>
> On 7/9/26 4:53 AM, Matt Bobrowski wrote:
> > Similar to recent commit 9b51a6155d14 ("bpf,fork: wipe ->bpf_storage
> > before bailouts that access it"), sk_clone() performs an initial
> > shallow copy of the socket field ->sk_bpf_storage via sock_copy() for
> > the cloned socket newsk.
> >
> > If sk_clone() bails out early (e.g. if sk_filter_charge() fails) prior
> > to calling bpf_sk_storage_clone(), newsk->sk_bpf_storage still points
> > to the parent socket's BPF local storage. When newsk is subsequently
> > freed via sk_free(), the deallocation path (__sk_destruct() ->
> > bpf_sk_storage_free()) destroys the parent socket's BPF local storage,
> > leading to a use-after-free (UAF) on the parent socket.
> >
> > Fix this by resetting newsk->sk_bpf_storage to NULL immediately after
> > sock_copy() in sk_clone(), and remove the now redundant initialization
> > from bpf_sk_storage_clone().
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 6ac99e8f23d4 ("bpf: Introduce bpf sk local storage")
> > Fixes: f12dd75959b0 ("bpf: net: Set sk_bpf_storage back to NULL for clo=
ned sk")
> > Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
>
> LGTM, thanks!
>
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
