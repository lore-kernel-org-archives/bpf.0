Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E122DE6E3
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 01:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780104988; cv=pass; b=tZjR8xPWvuA7ucaEGEfLgvVLptMFP4eNIvt1Vvn3WtGi+CKejSgWBhEYRBJPfynjmiAoqh8T5djHStzktDtSvjVsxEddh4OlPTcC92so+MjDlAsk6lxyWYi8823AV+wmRInXCBDHc3UGi3isxr5st+Pc+L3h8eix7ZZ9psAzzzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780104988; c=relaxed/simple;
	bh=r/R1G+fHN5VMQcgjBHd6EVs04fcrss/12vcflfTDVD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=swCZc6eIGRXwB/sFDVsAbXDYlTLOzuO8PpEv/ohFJlXjnSeYSuhBQ09T6/iajA++9t5LnMiPfQnNIIP44+2WeCi7THxodE6oXfVXVSCfYrl2loEJ80RTYKC3KsrQtOaCb4o31kPLHvly8lwMQdOvs8kL4llubdBLPyP5gINHFe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjluBJg+; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjluBJg+"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aa0cf8bca3so13445725e87.0
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 18:36:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780104986; cv=none;
        d=google.com; s=arc-20240605;
        b=cpIHAYrnMi8st0UR2gmFPQOB28HC7LBg9/1s0/2RuNbiLw66y1gRVI4XJKVZeH20S8
         eCH2xWiWOnm/pW0zqvxQRB2LErPStKlIc9aJmG9Uh/UGrlSigv51cVceKjH5roCDWp2e
         r7XIaMi5Ax3Cy3InR5+JAFYKOYPOg86JqS8vUy3WV+AmoA9ORrxcPqB92VzrzZRpe99V
         ssYqSFeGoyso5lDMJTDZHD/o0+qY+401R/CWiJ3aX77jS/5BTEErkRx3az4cudokUmnD
         A4Hw1Z1+nfAouIkGOYd4qznF7kG36f29lc5XrsBLYduZIk/1wtpqzMniQDdo7soeG3LG
         sTBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KWnyetP7MZ39LMBXAoJoQG5yyZXRa6UY4jUXq0RcKTE=;
        fh=bM1ZShno1FpteT9SU8swELP2wILEdW/uUTsAkAAnb/0=;
        b=h4MK/m1UOpJWAY0FuKoxGsinygmdX0arpL/KejFh2vFAmr1rdX3DGufm7ubJedeWuI
         D/0AOVIk+5EPoNu+QXt+cXOL1A6WtF9rKmQJLIPMpuZHhtVVXMXHC/GlaG46AI+gW2IF
         SWzNYX/gqnjV02oMtIr9kzW2NOLfMBQEkyMf6x4BCCMRCnpj5IQXN5FIWBwjNN61biyT
         JR05cGLVakT1xEKYU4K6bTHSqaRjClpsVjg+zlf9q2TWEY7S+XV7jgAY0cEfmZaYbyJH
         XbGiiR/qTJqa0tGAvzCeHUdEAGFRDXCuv+A1cY81hnS74bm9thCnehUrQO9dBg83V6gf
         LO+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780104986; x=1780709786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWnyetP7MZ39LMBXAoJoQG5yyZXRa6UY4jUXq0RcKTE=;
        b=fjluBJg+m03Emjr4esnI2XxvwRkcpP2ZETyYzaCLKb1vRJdMiCmPZ2pBZ54dzHH4UT
         9O/K7bYauX3+GYzo886oIBIRu/A8bfsT9DSCOruoAN6gbgMD0KhEaF4UmjI00N8XknsR
         VObX893ixbub5mwDnGmB/oBxZmLRYp5bF6y8ExEGFi2Z/sB6L2SU6wP070C0Yn/TxzC5
         1Z2xX7qqOt8Dc+t0mSimjewl08WoN7qdFSs2PG2eRnJxahqwlkMy9lUO4ek4tyePi9AU
         eeZit9AiOKZsmyzvHvPWG4j4UuquT0UvfU4hUavi8xgoSLV9eZw0/WO6B5a6IG5jzHJ5
         Yacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780104986; x=1780709786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KWnyetP7MZ39LMBXAoJoQG5yyZXRa6UY4jUXq0RcKTE=;
        b=tAW062DjkIAZlUdOYchPE5KLve14uMUrWJtsIU+8X/iYOdiirs5tSbDIESismYQcSb
         6+PVBjouSQjfkeO04nibFocQbUEOnKy/XeaYsGiCvCCoanaO6CZQpOX1V81l+v6Cs+Rj
         9Cqqi8Ox4aLyPK4j2rG8mVH8zxUEPSuXcWNSBC0IFhOIG4P5ssQvnMSw4Gr5lf5FtsSZ
         cd3YmeXkFR9i/tNYoeOmvfWjHhlGAsVsP2ajoDdF9ia64yZSx6ez2K8k1miRv6KBZssK
         NirNGVVLcWGGiQz5Z94/5/wm4qbdLUN6gvG9mLH90MpQtt6d4mxvorl8e0Ioqm1w0+kW
         5BMA==
X-Gm-Message-State: AOJu0YzxuyQ7hUC0jHs027oiwNRgtYQm0PFy99B0UVgATiLk4IrJdcjw
	zCrfdmCJ/zniYQNCoUzkm1Rul9Wk196iSsL1DjrTE58JypFe9FlD9h7uHcA4j5l17/ahopcPe7F
	7baevgMu0sLtsYEF2useOZ+sV07z+pPY=
X-Gm-Gg: Acq92OFoLyuxg4kJa970mT8seCKmsLrdlz1Zeng2ai8+EqpWew2dj+WMEEHZmD/zT2V
	ii68W/N9xyy36H9lHsNB9F63H/Fni674fP7mJDDs8FDtwPH3Czzgx8LCgom/DN7wbnVRPUrnED6
	G+Oc97J5mc/m9KJSKVgOgIq87M7eQD4QSB9K55C8feQFpWjvG8QGcnz/RaHvqSlN9GGtZKQ97Fv
	KiBYnCW9Lby/92yvQsUyXnbh8KsCUXZ6TmcMpP5VjljJdvSsNSp0TvGDMU+s8vTnh63h4kHn8vj
	4lsXw8ML+ot9QGBVICsrksbeSAWer6xih9wrjL6wdb3oFkr/9A==
X-Received: by 2002:a05:6512:acc:b0:5a3:ffed:8443 with SMTP id
 2adb3069b0e04-5aa608f7df8mr646683e87.23.1780104985295; Fri, 29 May 2026
 18:36:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529203909.1222164-1-martin.lau@linux.dev>
In-Reply-To: <20260529203909.1222164-1-martin.lau@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 30 May 2026 09:35:47 +0800
X-Gm-Features: AVHnY4Jac9PeH7AVgS8XGDe3QDii5Y6RCWB-lmAVnMkSOyKNEZIpJmtMNuxDkQQ
Message-ID: <CAL+tcoCtph-RS2sASvPtYpiLrmLjNgxp0GfvapzWfQods4owHg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: MAINTAINERS: Update bpf maintainers
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 4:40=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> I am making a life change and will take a long break
> from my current work, so I will step down from the "M:" responsibility.

Thanks Martin for your great effort! I always appreciate your awesome
involvement in BPF timestamping!

>
> I am currently a "R:" in "BPF [GENERAL]", this part stays unchanged.
> I am folding most of the parts into "BPF [GENERAL]".
>
> For "BPF [BTF]", it is long overdue as I am no longer involved.
> It is folded into the "BPF [GENERAL]".
>
> The "BPF [STORAGE & CGROUPS]" will also be covered by "BPF [GENERAL]".
>
> For struct_ops, its usage is no longer limited to networking,
> so this naturally should move back to "BPF [GENERAL]".

Maybe it's not an appropriate timing to ask this, but considering the
further development I really want to know if you'll continue with the
latest series around struct_ops? Or you will delegate someone to take
over your work?

Thanks,
Jason

>
> For the reuseport, it will continue to be maintained together
> by "BPF [GENERAL]" and the "NETWORKING [SOCKETS]".
>
> For other "BPF [NETWORKING]...", I am moving myself to "R:".
>
> Thanks!
>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---
>  MAINTAINERS | 24 +-----------------------
>  1 file changed, 1 insertion(+), 23 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dfc621ff629d..d9caa2d980f1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4766,13 +4766,6 @@ S:       Supported
>  F:     arch/x86/net/
>  X:     arch/x86/net/bpf_jit_comp32.c
>
> -BPF [BTF]
> -M:     Martin KaFai Lau <martin.lau@linux.dev>
> -L:     bpf@vger.kernel.org
> -S:     Maintained
> -F:     include/linux/btf*
> -F:     kernel/bpf/btf.c
> -
>  BPF [CORE]
>  M:     Alexei Starovoitov <ast@kernel.org>
>  M:     Daniel Borkmann <daniel@iogearbox.net>
> @@ -4905,18 +4898,11 @@ F:      tools/testing/selftests/bpf/prog_tests/tc=
_netkit.c
>  F:     tools/testing/selftests/drivers/net/hw/nk_qlease.py
>  F:     tools/testing/selftests/net/nk_qlease.py
>
> -BPF [NETWORKING] (struct_ops, reuseport)
> -M:     Martin KaFai Lau <martin.lau@linux.dev>
> -L:     bpf@vger.kernel.org
> -L:     netdev@vger.kernel.org
> -S:     Maintained
> -F:     kernel/bpf/bpf_struct*
> -
>  BPF [NETWORKING] (tcx & tc BPF, sock_addr)
> -M:     Martin KaFai Lau <martin.lau@linux.dev>
>  M:     Daniel Borkmann <daniel@iogearbox.net>
>  R:     John Fastabend <john.fastabend@gmail.com>
>  R:     Stanislav Fomichev <sdf@fomichev.me>
> +R:     Martin KaFai Lau <martin.lau@linux.dev>
>  L:     bpf@vger.kernel.org
>  L:     netdev@vger.kernel.org
>  S:     Maintained
> @@ -4951,14 +4937,6 @@ L:       bpf@vger.kernel.org
>  S:     Maintained
>  F:     tools/testing/selftests/bpf/
>
> -BPF [STORAGE & CGROUPS]
> -M:     Martin KaFai Lau <martin.lau@linux.dev>
> -L:     bpf@vger.kernel.org
> -S:     Maintained
> -F:     kernel/bpf/*storage.c
> -F:     kernel/bpf/bpf_lru*
> -F:     kernel/bpf/cgroup.c
> -
>  BPF [TOOLING] (bpftool)
>  M:     Quentin Monnet <qmo@kernel.org>
>  L:     bpf@vger.kernel.org
> --
> 2.53.0-Meta
>
>
