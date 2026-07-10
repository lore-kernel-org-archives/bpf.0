Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8BA3B4EB3
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 21:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783719893; cv=pass; b=t6inV9TaoeVrqwtx8pHw1YYUPlPgcUq+nM0z+HNyEnf/yNXqMKy8Sq8OkvU4+OJ2ZyuytVXSOlb1p+J9sgK0TkC0aO1/UtmoqJOoZiXwVCdUJreMTatSN3t9/32rD+zf1sn8OxkXQCf5EisQFuHdPZuvHj61RVL/u71VArI9XLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783719893; c=relaxed/simple;
	bh=6JwpDtiP5lWk2HyCdZWziynZDzhadtq7h2q1KexfBb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D6OwhGRjPia/M6G45dnTb+bFPDKfoLcu44y+FseN8gj4f1vN/6QAftxMs6Jc4r6scE+0zs+evZt5SAvOiiafV0EFUk/1cO2a2hTAWrefEDi2OuZTm98pD486VuziIfXsiijSpDQtsLfqkIA2IKr21gzo4Ce8kWjUtBwTkx82e7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/mK9CaO; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/mK9CaO"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3817f800c8bso1275128a91.1
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 14:44:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783719891; cv=none;
        d=google.com; s=arc-20260327;
        b=omObhglpMTToUOQ8RNtY+Zc2NjZ8eE51vlxm2zy1Iw1LriOaVb4puG6gDTEeGq+qRi
         ocjRiY4XMTfXo/ePsXfAFqcyBOHhlsKpQ9gatRC5LLQVO1hmVAkflNwcyQu3weiUb5Xb
         mNVjmbHZKm3n/Jwyrae3/HU5loctWufjIRvNdTic38rfigDJlF5wHNm9p+HCZpib4bkN
         Jp5Dp8eN9WWRIvR9cjjSAbljeCYxVQ39ay5svurDuUdERalNF2Yll7PQQ2NlC0hydagV
         rodODk0K0TQGAsq6OSMfrIPUjbkyEddoYmS8xdR2rkOn/zRm9C1/ztrcM5SOfyR7PBCw
         2FzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gOpPI7YcO+DIQhHPYShATl6XVIWuImfrdEloB2zFr8U=;
        fh=RsjPANiLgsSCHrT8J1CaTGl4A/Be/5EGMv1XQChm8yc=;
        b=ehhSJpy8PGYSq/7PwdSnZY5RYUTH4YIBvXI1IOoC5XXpoAAcrRDGWWnZV+YsPXS2Ms
         qsv0Wq53VUkaImUw8tOynEPDghQ43F5Wvz62ARwjEZwV43AF/OE0/b9dn1aSJjGBIFSu
         CdgZhBjmIHqdiUV5gS2aeoZbIjZIzYj1sZMzgFRJwr5wv/tUFVnIo5W4fSUlnwbfs2bk
         +sV+exMXsHyC+H1UMViUfnya3/2ElnLFM2wEUQ26FwgOA4tmevtM2wrdAM4QSS32fSKN
         l8WwnE6vUkJzAzKtdburRWY5DWESIEpgrBWp1Jf7UCMgoD9+tsEE/AGj0BGpOMr4PEBQ
         +OEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783719891; x=1784324691; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gOpPI7YcO+DIQhHPYShATl6XVIWuImfrdEloB2zFr8U=;
        b=T/mK9CaOUls73BrZGk4aJj/OTPJnZVMnjvDC3p813YFPIjBxavPJorvg4VmySNo8P8
         19eaPkt7JclSkq60uhaSr4z8gpMJct+1PYbb31CKfetkL3fj0UKwByDE44NorXvAQC1T
         blToOUdylFHq47dxLMzKg7x8cFSgHCFvQCiJ4YwQYCL4omo0ruOtYI+q0vXi2wQoAsfn
         IJyFkZdFDv//8d51TLxGqyqLKP9V2GzQLk0Iy3NkySmL1x+znByHpGmvWe/x77Nz8kvh
         WymfqZnBYMNv1jcOqMzIFJM0MEeW1ocX3kWuJj4zptDPw0OdTC3anI/PzUcEJWpGWug6
         nQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783719891; x=1784324691;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gOpPI7YcO+DIQhHPYShATl6XVIWuImfrdEloB2zFr8U=;
        b=mp/NJrr9Zj5AglI89vNWSSE/gwmaa54qPNQn9B9mqOgol3sCNlm38dgU9g7w+1tLre
         aGYPtDg3FpIIjlTPuehVBh1uScpd0GsHTM3jjjUMSfLJWDWHdvhp03QbDTGQBSNlT2eJ
         5/r4beOvHIcZv4++o9l8oY3hFEBN/h6pQFk0il0SeQmjISEAz8tWs5WYFfTr/jB2Tmcl
         jw9a3jQGR/ic1rzDn3lp0jiUtsuoECecFfnZycLmMj9eYis+kRxPFfR1Crv0vCLwyDLq
         e2deCQR49Sy4JE1zZIkAFxAX2JiXdQMPOgxObl8jjEXN69LGX6mUUpmnC7H1+EE00A0h
         xY+Q==
X-Gm-Message-State: AOJu0YzMIMqSdldIJ8ynHyal/ZW6bmtXW8CEA7tR2z7yV3IR5maYHcx0
	dUMWFB0nlyP049B92lm0PcHruvNEFGI7fq0oJXN73gQqrR6e7vC5F9Rh9BONtJPA73OxBOmxSJo
	ZReSYOBloQ5GUGjKx1TWKONJ6oBIzEkgySjAxZ+Q=
X-Gm-Gg: AfdE7cnj7ezFNkaQZfj6CKJtjpC0OBWPwXXDIPzGkRDcnyLev9Oo6RV14cfrImpZgMf
	hvIHwOS2MZDbe6QnbmnjFGsL+69RaBMKueruiqp7AHvvbkTEhPhsM4YOW4W66iRLRCswjJb4ncx
	l/U54BEtF61Md6uSbOCdTm4fLhy53eT5KvxrW6imO3OGzyXZY5lO2v4uro2hDNfVA7rU8shOdI0
	ADhPjk1KQcrxxrLMFkR1RqZf+S9T0bgZ2X3Bg/54v4ySkFwSu/eqqZQgWmT9PPW6nxhFpCYP4WY
	FJFDJAscxAuiHMKL7xIZwTxfzvS1bHFYMPJq7LmB/znoYCEBaMaEAA==
X-Received: by 2002:a17:90b:3bc7:b0:37f:9cdf:f0ab with SMTP id
 98e67ed59e1d1-38dc77ee692mr651360a91.26.1783719891088; Fri, 10 Jul 2026
 14:44:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708193239.5063-1-emil@etsalapatis.com>
In-Reply-To: <20260708193239.5063-1-emil@etsalapatis.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 10 Jul 2026 14:44:38 -0700
X-Gm-Features: AVVi8CeUx3WxmGBczLYns2fxE7-g2gULa4j1gRY4UCmR7RQFZcoDM87oF30Ec0o
Message-ID: <CAEf4Bzarum7QXKT+BuvBa9kSrjMX=BzknWFKQBQuROKOWFeuZQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] selftests/bpf: veristat: Minimize map size
 during verification
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, memxor@gmail.com, 
	daniel@iogearbox.net, eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 12:32=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.c=
om> wrote:
>
> The veristat tool verifies that BPF objects along with their
> maps pass verification for a given kernel version. To do so,
> veristat loads the objects and maps into the kernel in order
> to pass them through the verifier.
>
> Currently, veristat sizes the maps according to the max_entries
> field provided by the program author. Depending on the map type
> this field may be irrelevant to the verification process. However,
> loading a large map can fail because of -ENOMEM errors.
>
> This is a problem when the map is supposed to run on large machines,
> but veristat tests it machines with significantly less RAM (e.g.,
> CI). In that case veristat fails even if the program verifies.
>
> Expand veristat to resize maps whose max_entries are not relevant
> to verification. Set the max_entries value as low as possible to
> avoid -ENOMEM errors.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>
> CHANGELOG
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>

for individual patches we normally don't commit changelog, so next
time put it under `---` below so it will be stripped out during
applying (I cleaned this up manually)

> v2->v3
>
> - Do not resize HASH_OF_MAPS because it can be declaratively populated
> from BPF at compile time (Sashiko)
>
> v1->v2
>
> - Removed unnecessary ARENA, LPM_TRIE, and RHASH handling (Sashiko)
> ---
>  tools/testing/selftests/bpf/veristat.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selft=
ests/bpf/veristat.c
> index a7db6f04f7e1..c9c257784ee3 100644
> --- a/tools/testing/selftests/bpf/veristat.c
> +++ b/tools/testing/selftests/bpf/veristat.c
> @@ -1248,6 +1248,29 @@ static void fixup_obj_maps(struct bpf_object *obj)
>
>                 /* fix up map size, if necessary */
>                 switch (bpf_map__type(map)) {
> +               /*
> +                * if the verifier doesn't use max_entries
> +                * then set to 1 to avoid -ENOMEM
> +                */
> +               case BPF_MAP_TYPE_HASH:


I'm wondering if we should add ARRAY here as that one is actually with
high likelihood will be large, though there are some corner cases
where size might matter (e.g., existing code omits error checking
knowing that verifier will prove it can never fail; resizing to 1
might pessimize such check, probably, if index is larger than 1). Can
you actually try the latter scenario with some small program, I'm
curious how the verifier will behave?

anyways, applied to bpf-next, thanks!

> +               case BPF_MAP_TYPE_PERCPU_HASH:
> +               case BPF_MAP_TYPE_LRU_HASH:
> +               case BPF_MAP_TYPE_LRU_PERCPU_HASH:
> +               case BPF_MAP_TYPE_SOCKHASH:
> +               case BPF_MAP_TYPE_DEVMAP_HASH:
> +               case BPF_MAP_TYPE_QUEUE:
> +               case BPF_MAP_TYPE_STACK:
> +               case BPF_MAP_TYPE_BLOOM_FILTER:
> +               case BPF_MAP_TYPE_STACK_TRACE:
> +                       bpf_map__set_max_entries(map, 1);
> +                       break;
> +
> +               /* ringbufs must be page-aligned */
> +               case BPF_MAP_TYPE_RINGBUF:
> +               case BPF_MAP_TYPE_USER_RINGBUF:
> +                       bpf_map__set_max_entries(map, sysconf(_SC_PAGESIZ=
E));
> +                       break;
> +
>                 case BPF_MAP_TYPE_SK_STORAGE:
>                 case BPF_MAP_TYPE_TASK_STORAGE:
>                 case BPF_MAP_TYPE_INODE_STORAGE:
> --
> 2.54.0
>
