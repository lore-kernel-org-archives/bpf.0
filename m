Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793124224;
	b=pSY952dp4lLxgHT1DacRvamEsipM85RbtrRI9Z3MBP8qNBEkOccm/V7SUC9/sHcLvjTR
	 JIyRb3uMdGAJBByNM9hX/4IUhJ0CAJlkYkgrXvcxdrnfRcgc2UyJo/vOJdEEbDg8OQ5hc
	 744hIy6ULBJ19s5F649RlD9appTgW7h3k/t6jI2BB7LM1X4T+fhjj5W/g3SBJzzNJSFX5
	 B3v1hD0beSYu5OaKqoktJCwBv/remh7+fCVr/Sqj6doPjYw5/Kh858Lpslw/IlkMR02UB
	 YWynleXVe94INglK4D37YZ9ZdCpexL4dXrux4JMbtYup8APqy1rdqyAPGAhy8PnD1TA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793124224;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=JXW9Ju2RkKIXXA9p0LpxSjn7fv3ezYS7dP4uo6hyl+o=;
	b=FsAqYsTmdck2x/dUdkLcmoJgPGBROucF2CGcboJiiLmE5BltFC5N3svnK0s1hQKR5BrH
	 a3yrMWblEI+S7gnEfHne1LiIhtpOubYnNGbKIVotQlLzAoQ+d9OxXD0YyWgwVQHFCuf3M
	 A0oygWIywkxLfPNlDIh0BHE0tqOGtFdJ0M2H8mK6henhA67qLPZwgZ8hURZY9aLaYAEDg
	 VmWh90nm3Bt3mBWJvBsWnzfQwtlh+r1MZfB6jfnRPnmUuWlj0RYHR55Uvq+3ekMxVPU23
	 PQWKr02Va7D96iIJNFH/ices5CNGOJFBJ4PBJr6oswLTSJWbdl1ZnDGkwlvHX31DK1w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=raYQLhVQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C41606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 18:03:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0C41606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=raYQLhVQ
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cd69954c755so150780a12.3
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 11:03:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793124223; cv=none;
        d=google.com; s=arc-20260327;
        b=HRS6QMq/3JzEkQ4joQ6lVlXO97sIEiWLFqhYO5FbJN/Aq20e4S7NrFdbNhXHAC+DY4
         fKLNHNg+AqMbwMf7wG0odgUAuTF3kFIHNVLIrFNtoe30r33nSku/i45QIvhwP+c/g3al
         YXa2l+1XCBLOQruAlDMOeKRFevWkFfUfwW331FigZg471Saf8QIpbBp/LBAhJHdhM1vJ
         d2iKLvwD5d3IypcH+3nunS+Ubm7jvPc5M+ufcmowSp+/YtRabhMM1d2NSY+FeGHL7SN3
         PTFCeX3k8FAKm5L17c/YzgmLJt5w/O9l2frJ/LiA2sGqZFhp3G4reeakVm2wZSY14xig
         ln0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JXW9Ju2RkKIXXA9p0LpxSjn7fv3ezYS7dP4uo6hyl+o=;
        fh=93juHyOGdgEeEu446eMZHu466h5HdxeU3jaZq/qR9pE=;
        b=bWb4OlwLOStdiBOPna0gzPvv11eh7jTJdnUrC3wcS4JdI8qJ0OgLORLOedXU9yHm6P
         IbCOrXsEcl0VMWuFWPASkieG3QSBC49HnD6PX226kZs2J+RsqjWxXzFONyZgiKP9/AVP
         d+7HQCgODePBmlz5Dv4QK3KVznJoLQljsf3SBKl2ArgfezpjE7xHIeKHYPCsM4/YuhkG
         cCEbcTF5EcTZ509KkVPGJ5k4g48jgXAqLt8017brEauLUMN4EMw7erWX0rRyPfFgz8BA
         I5732PjcxptJWrTvCmRRaiTTJ6bgDLBmHqnj5yjxpN1TT/G36GN7uIqdshP0ozCMQqxA
         qS/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793124223; x=1793729023; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JXW9Ju2RkKIXXA9p0LpxSjn7fv3ezYS7dP4uo6hyl+o=;
        b=raYQLhVQg3/XsgS7PEVjWhO9JkaLPmaTyQT3JNT2228GMH4K5Ie4OIuoRTIkLKyyFf
         FOUUb7v16UZQdDNluARo69lzxDVzZsyb+eK29h1HYKxnbFnQUGKT7qRTcc6FG6U2QqBx
         bVgDR6Iz7XRkrfvGFIscgloEXIpu1cVW0mQT170o7s5bHGS+idxYP7msfl/GpHpnrtTT
         lRVNXTb+LQBSHIuEI9iEhjP521RAvtvQ6m6oKJNEFK5blcJtnkYWAfJEBa8SvlAf4gpy
         K4RyrShrWMCB6s3h15Pwu1HiCvEuYAjgxjLdn5Hj6RUuqrXsUX0X70egxVyTwxwMVHJ9
         5rMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793124223; x=1793729023;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JXW9Ju2RkKIXXA9p0LpxSjn7fv3ezYS7dP4uo6hyl+o=;
        b=GCPKMdfwazwBC80N6KccIf+Acoh8OHqzuRaNRjW1+/roJC8merAad/4onXBJoAjok/
         FrdeJC4Fb36QcQ7DAJ9V5+905X6MBJhQi9oqN2q/YwdePmXGWik5p3W7bswETgzH/CFf
         PSj/bMj6JN5+0I9fTsSTZwKdFHcranWgCZbfbm0t0+6qNVYI5oFB5WBO/tfC9lLsQJZG
         09r3JqumhoNSedyB4PS3jLnOCdFTgo5IdxSGSLSbOowmmlI+fcwWs4cpMqqPZLXUzGEH
         mH5mVvGzw9jcfecQ51XcfeR9i7H8M4/7gZbQK7qgdXiGgltswE2PyR0kbGw9c04JsTpm
         WrsQ==
X-Forwarded-Encrypted: i=1; AKwUvBwn9WVJdDtG/DrrFOuxDXRHeLqghPKUDPlmI51qJ4GQ+YMKkGj2xxJZWKIdB8n76bMj6TU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLFZleFpSEseSSwcfoiW3VWgvZIK41knUhM7IAh1iOpq8CjEDQp
	PU31HLYi9U0QPUrf4GaXa9KK2RWzy05g+0k+MDKXv3bg1oUDvnLgAwPqDMwbG1nh4LNwLaC8omx
	aCO2Qq7PZDRLaIt6DTUaElX8y4p8AXd0=
X-Gm-Gg: AYBFou0nIfCnumnmehOhSveWsDwO6A7Zlm7/jUzfhCnwK8Wt32vnx8bjeJjOXnJQ4jI
	yVrAtCR80hm6x51Bac1PwuT+6HEa/RwqFvMZmxAdwffiOAzFWumyqZllEAsVql8I2sGm/zZVvAe
	NXXBVDzn4pmzfbjJsUFQwJe7aj5tw9rtz0jv8EmT7pMBSs0JHFDquRe9DYQhUYUePWt9SjEpZ5F
	9YqYV+h4hz1NN6QpDtMwnFqiI/cCZd54/Eoe+G4BpqC0Or9XclOR6Xkx9Gjsll5CD20nhuUVeB/
	q6UALSfWxI/acCCiMI8HPCQiQKvumuMnc6pqSNRb03lkfnUymCmA73KjF1tYxXfnQGh1RglkcBb
	pD+etYDSWxCA+ZtAamx9eRrN0H83gpD6jKEmuZ1EwX2+OcQJifB+S36DX07OrSmFVI+3Kj9mY/w
	SYtfPVYTKRkHP74/rDEWkd4hItU+qH0wbunw==
X-Received: by 2002:a17:90b:58e8:b0:3ac:9706:7739 with SMTP id
 98e67ed59e1d1-3adead57cf0mr9040823a91.17.1793124223013; Tue, 27 Oct 2026
 11:03:43 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023222652.3927736-1-ihor.solodrai@linux.dev> <20261023222652.3927736-4-ihor.solodrai@linux.dev>
In-Reply-To: <20261023222652.3927736-4-ihor.solodrai@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 27 Oct 2026 11:03:30 -0700
X-Gm-Features: AclHuK8sxkU9XZ64X4nL--nqkW0LxYI88meogFhBuG-ssFszgQiTtJIIIjGFqz4
Message-ID: <CAEf4BzYuEetnwDnm38J_MEG4-ZcQHfZwg=L1FcFtgXvAn7NSAA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/8] bpftool: Apply __bpf_relocatable per
 record on BTF dump
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Quentin Monnet <qmo@kernel.org>, bpf@vger.kernel.org, 
	Alan Maguire <alan.maguire@oracle.com>, Cupertino Miranda <cupertino.miranda@oracle.com>, 
	David Faust <david.faust@oracle.com>, Ian Rogers <irogers@google.com>, 
	"Jose E . Marchesi" <jose.marchesi@oracle.com>, Vineet Gupta <vineet.gupta@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 3:27=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> bpftool wraps the C dump in a clang attribute pragma that applies
> preserve_access_index to every struct and union, so field accesses
> through vmlinux.h types get CO-RE relocations. GCC-BPF supports the
> attribute but not the pragma, so it gets no CO-RE from the header.
>
> Jose proposed replacing the Clang pragmas with per-record attributes
> in May 2024 [1]. The declaration attribute support in btf_dump [2] now
> provides the per-type control discussed in that thread.
>
> Apply the attribute to each struct and union definition instead, as
> kflagged decl tags rendered by btf_dump. Add the tags to a split BTF
> over the input, so the input stays read-only. The tags use the
> __bpf_relocatable macro, which by default expands to
> preserve_access_index if compiler supports it.
>
> Clang output is unchanged.
>
> GCC-BPF programs now can get CO-RE relocations from vmlinux.h, however
> the selftests GCC-BPF build defines BPF_NO_PRESERVE_ACCESS_INDEX and
> is unaffected yet.
>
> [1]: https://lore.kernel.org/bpf/20240503111836.25275-1-jose.marchesi@ora=
cle.com/
> [2]: https://lore.kernel.org/bpf/20260929234608.48503-1-ihor.solodrai@lin=
ux.dev/
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  tools/bpf/bpftool/btf.c                       | 62 +++++++++++++++----
>  .../bpf/bpftool_btf_dump_sorted.expected      | 16 ++---
>  .../bpf/bpftool_btf_dump_unsorted.expected    | 16 ++---
>  3 files changed, 65 insertions(+), 29 deletions(-)
>

[...]

>         printf("#ifndef __VMLINUX_H__\n");
>         printf("#define __VMLINUX_H__\n");
>         printf("\n");
> -       printf("#ifndef BPF_NO_PRESERVE_ACCESS_INDEX\n");
> -       printf("#pragma clang attribute push (__attribute__((preserve_acc=
ess_index)), apply_to =3D record)\n");
> +       printf("#ifndef __bpf_relocatable\n");
> +       printf("#if !defined(BPF_NO_PRESERVE_ACCESS_INDEX) && __has_attri=
bute(preserve_access_index)\n");
> +       printf("#define __bpf_relocatable preserve_access_index\n");

why not define __bpf_relocatable as
__attribute__((preserve_access_index))? then type definitions will be
a bit cleaner and we can basically drop BPF_NO_PRESERVE_ACCESS_INDEX
eventually, and instead you'll be able to just `#define
__bpf_relocatable` to disable relocations (or if some GCC version
requires some quirk, you'll define it wholesale)

> +       printf("#else\n");
> +       printf("#define __bpf_relocatable\n");
> +       printf("#endif\n");
>         printf("#endif\n\n");
>         printf("#ifndef __ksym\n");
>         printf("#define __ksym __attribute__((section(\".ksyms\")))\n");

[...]

> -#ifndef BPF_NO_PRESERVE_ACCESS_INDEX
> -#pragma clang attribute push (__attribute__((preserve_access_index)), ap=
ply_to =3D record)
> +#ifndef __bpf_relocatable
> +#if !defined(BPF_NO_PRESERVE_ACCESS_INDEX) && __has_attribute(preserve_a=
ccess_index)
> +#define __bpf_relocatable preserve_access_index
> +#else
> +#define __bpf_relocatable
> +#endif
>  #endif
>
>  #ifndef __ksym
> @@ -30,19 +34,15 @@ struct holey {
>         long: 32;
>         long: 32;
>         int tail;
> -};
> +} __attribute__((__bpf_relocatable));

e.g., I was expecting to see just __bpf_relocatable here, without
__attribute__(()) wrapper

are there any downsides to that? that seems how attributes are
typically hidden in kernel, for instance

pw-bot: cr


[...]
