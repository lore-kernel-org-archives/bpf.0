Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BFB304BA3
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 17:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784827368; cv=pass; b=hJSxOsqi2Rhp96nodaOX7ZzjHH46us8B2LlgW8z+4WQ6S0NSQFGiXSdK4IJzVB1NAFIeO+E8cAXDzKfDokbSeGM5KoPitLyF8HoGwmGdVWFkjPLnpqlXpZKTLQqp76d34p/KL39iRHA7jy5ypqgyGiJ+ctnfF9cpLKJDmORaXu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784827368; c=relaxed/simple;
	bh=XcnQUKlZ/kCg5463h87ts/aPm6x1I/s1vYmfqIZOBRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FF0RuagpAHOvcDHBGA9dXLVuaeS8RB1bkcQ5/fMAjeMXg2xG9bgH64DZZ05gvv0y84g5dDmVZ+ALLGwbJ/uqT/8VRbd3UQ+fbKM6bNElmAA9Ku5GDuBQ4LjsRbC/7lt4EOwWuJOppGKf5rU8jw8tOFqkzPzGYsoaNY1DujYmCgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E4mP5x8H; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E4mP5x8H"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4954d5d814fso2985e9.0
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 10:22:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784827365; cv=none;
        d=google.com; s=arc-20260327;
        b=bfg2KoV0Z7HJlFvE4u0vS7VvFZrtPSNs/gQFnFB74TENF7ke4FXSm4McKaVK+ndmvI
         G2AHSxm19hs5o/HLqShGrgs5vcXP3OXEvfgB20epCj69ZwgwqZ7zYY1+vI5dHsEgbimq
         gnqMh8xhXo+tf1Whmfs+egeMPVWSTZ4qHgKV3UpkztedV6jIHTU/TUR/d1tfdTeKBNrL
         o4R5GGzjhI0dSabTqi+Tj9X2yOnRLt2oAPNlRi8LeLFDLq7LG3OTvduYZtxoD6A1FRvy
         D9XKgs2SAqPeGvXKlL9t3CBbC2+zccPDANmWJX0iHhH3dQiQt+7LRy7yonF5tLINCCSV
         1DhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iVPu7LqA+ftOUUwDiXRHcxv3i6x+tkX8W/lNHMvjhTQ=;
        fh=uH2F9q5LutW4Gd5QWt3cbhYR7cwFzOA0sreQr8h4jB4=;
        b=JZ+z9U63yBZ9NhYRDbSOciOKX+aEcAjS0lhgkn9B1BrCcH1juAoYM3LIt03HwKBgOs
         31lcmF8izKjoNsPdky+ztEu/DrUsH1ay1b8UwfbjfGPlsfdtufUggbkV9vEPWCbiTYVc
         Y/W1o5DfCe4zCg94oVaqvoPLPMXKxHQCnZ+reafCMtz1UBQGah5AmCjocsgKIR8/UXNt
         khYO2k1qVf8V70vaJFVrehVplH+suEFypQQyF5PLNh3I8J3T+HCD3r+xA+B36nMWKBwq
         pG/uDLrOEW2idHEr5tTDuRvnkcX2AjM+XdvU+JJN3KwRuI23zVKTuAs+XMEEQyKPs0/E
         1Xcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784827365; x=1785432165; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iVPu7LqA+ftOUUwDiXRHcxv3i6x+tkX8W/lNHMvjhTQ=;
        b=E4mP5x8HTPgTL3bQA8YmEpHl1rED3FQ9HqIpISh+2de3hh4YPuui3t6kAuMy0M4TGn
         AcrlGqqaGT2ZXZ2dEKYW/9KqXbnM9Tugx0B2RlHlHT1Lu7ZTOrmOaz40lhTYukonoUux
         GEQRUVIuKi3eWAii5E6lXprtFhf9c2ys7n+yPtIZMwye7tuafNmx2tdhSIJygXZJNdOX
         NCuDW4u54+5RL9wXlhlSmxIEdU6pxu/WqbQ6UFyUhfpC5BoFVrkDhSZclZzKVzwNQE+6
         E4FScvvSZxP//NVvdHXI5Dq8eXUZOCvn52dkKwgsfSEQkcs4ofKtZBhuAJJU5t8mgG6k
         u64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784827365; x=1785432165;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iVPu7LqA+ftOUUwDiXRHcxv3i6x+tkX8W/lNHMvjhTQ=;
        b=GF0FFnV1k7Ln0otyOpT1WuU/vAcsShM5dpk+/wfE/f0Cu37Ne0ROp6OUxyNqTBK06K
         jWUMyydHv6m5eqAhHwwQdqSdLgNPNf89tPT+QlwDhW5nXJgTK+7BP42qUFCYGGq6P5bw
         /z5SkUemrryG3KEbaLTjVAWSErVzuaLWQNNy0BH3Hbod8S/XXWmQ/2g/XnIKcWV1w2/l
         Wi0xocrV9G07hT7bStzHUHem59HxZyGF7FOkGXyl+Cn9+WfPperB5KpZ6vgUAEoFZ4PS
         gpiOE+qgVtxAx5CBsqDvalOzvF6Oc5wd+dH59EY1G0bQX1etMee05cYDHMlVSyHWdq5v
         8MGw==
X-Forwarded-Encrypted: i=1; AHgh+RqiaMTkqWwDvK0I0Bw5v8V5/9+R/hxatmUax417HmlmXkEfQoH2KSt2loJf0kg2puqccJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE0ZXKKw49gcftbAiXBcAFEVOqtIqLFsSQ5Ix5wowf2zju6sLZ
	GJw/xXd5W8UYwcOCRj3GdAWt9aEiWCf4kXdvO7qYdpIk4I5BnJbj//h5n3E4NcwyF/dLAFYoRsM
	WUK+TglLid0IPiTTytwO1lktqRvHo17CoHSw2hrEDkRzT4HpHGo8qMH/F
X-Gm-Gg: AR+sD12BlxXtvwA4lrmTMjAmywrA9krVibfHAr74ackgGnCXNGt91wV7MeoQsuuZwX8
	7i3LucX/iSKa9gdwmPUzPL4xYm9gr/xQjhVIyM5WfV5v5vzFQcD+38XlCIWca1GfsEZcxCiH7cI
	P1FTebPOsIfjA02+Trd8DKFj2Fipd9WPbDtQk2F6GzSiuJOm7lqjn9zlx8O1/DJYUSnlj2gm7Ze
	eg3XBp7Dkzl41cKzQktRW55fRpQmrFu0N0KOkjtMLAHu3ULOViAEgwiYasyFZq1TBR3OGyotafH
	8/sdiQsctRHQh+5cCHx6GyUMv/UKKXibgr72JbSwmvrTyDrt
X-Received: by 2002:a05:600c:2256:b0:493:b47f:a24 with SMTP id
 5b1f17b1804b1-4957bce2865mr39615e9.6.1784827364616; Thu, 23 Jul 2026 10:22:44
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722203801.1854941-1-tjmercier@google.com> <b8541508-5046-448c-b32d-40c7ad79b1e9@gmail.com>
In-Reply-To: <b8541508-5046-448c-b32d-40c7ad79b1e9@gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Thu, 23 Jul 2026 10:22:31 -0700
X-Gm-Features: AUfX_mxWL3X7MyV994x-_ctz7wx7pSCf1Rt_MUQjDIAlZn7hhrvxBNSG_yZAi08
Message-ID: <CABdmKX3Jhrb3G3_25CN+TAG8oSgOqJwr0xi8XUC8c7RsCS=h-A@mail.gmail.com>
Subject: Re: [PATCH 0/2] bpf: htab: Reduce memory use of hash maps
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 7:11=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 7/22/26 9:37 PM, T.J. Mercier wrote:
> > Memory is expensive and scarce these days. This series reduces the
> > memory use of BPF hash maps by eliminating the per-element overheads
> > below. This saves up to 50% of per-element memory use for standard and
> > PCPU hash maps. The memory use of LRU hash maps is unaffected.
> >
>
> I understand that these savings calculations do not account for the eleme=
nt
> value overhead of per-CPU maps, which make up most of the map memory
> consumption. Realistically we won't see any memory savings for per-CPU ma=
ps.

Yes, I did not look at BPF_MAP_TYPE_PERCPU_ARRAY at all. 95% of the
memory used by all of our BPF maps comes from hashmaps affected by
these changes. We only have 7 BPF_MAP_TYPE_PERCPU_ARRAY maps and they
consume only about 12 KiB. (I know a few of those PCPU arrays are just
to avoid 128 / 256 byte BPF stack allocations.)





> > Map Type & Configuration            | Old size | New size | Savings
> > ------------------------------------|----------|----------|--------
> > Standard (key <=3D 8 B, val <=3D 8 B)   |   64 B   |   32 B   | 50.0%
> > Per-CPU (prealloc) (key <=3D 8 B)     |   64 B   |   32 B   | 50.0%
> > Per-CPU (non-prealloc) (key <=3D 8 B) |   64 B   |   40 B   | 37.5%
> > LRU (Any key/value size)            |    -     |    -     | 00.0%
> >
> > 1) Unused LRU / PCPU fields in standard and PCPU hash maps (patch 1)
> > struct htab_elem is used for all hash map types, and includes fields
> > that are not always used (bpf_lru_node, ptr_to_pptr). For standard
> > (non-LRU, non-PCPU) hash maps the 24 bytes for the bpf_lru_node (union)
> > are entirely overhead and can be eliminated. Non-preallocated PCPU maps
> > only need the 8 byte ptr_to_pptr which is currently unioned with the
> > unneeded 24 byte bpf_lru_node, so 16 bytes of overhead can be
> > eliminated. Preallocated PCPU maps don't need ptr_to_pptr, so 24 bytes
> > of overhead can be saved.
> >
> > 2) Hash caching for small keys (patch 2)
> > For hash maps with small key sizes (<=3D 8 bytes), comparing keys only
> > requires a single instruction (64 bit), or a few (32 bit). Currently th=
e
> > 4 byte hash value (8 byte aligned) is used for this, but offers no
> > performance advantage in this case and can be eliminated.
> >
> > The implementation splits htab_elem into dedicated structures for the
> > different map types (htab_elem_lru, htab_elem_pcpu, htab_elem) which
> > share a common initial sequence, but contain additional map-type
> > specific fields where necessary. This means the placement of the key fo=
r
> > each element varies with the map type, and key_offset is added to
> > bpf_htab for this purpose.
> >
> > While using key_offset and conditional hash checks adds new pointer
> > dereferences and branching during element traversal,
> > run_bench_htab_mem.sh shows no significant performance regression acros=
s
> > 10 runs on my 3995WX.
> >
> > Benchmark (all in kops/sec)  | Avg. Before | StDev | Avg. After | StDev
> > -----------------------------|-------------|-------|------------|------
> > prealloc overwrite           | 115.11      | 4.10  | 115.45     | 5.24
> > prealloc batch_add_batch_del | 127.14      | 4.32  | 127.06     | 2.32
> > prealloc add_del_on_diff_cpu | 23.22       | 0.93  | 22.91      | 1.60
> > normal overwrite             | 78.52       | 3.05  | 80.40      | 3.25
> > normal batch_add_batch_del   | 45.37       | 0.69  | 47.71      | 0.66
> > normal add_del_on_diff_cpu   | 12.02       | 0.73  | 12.48      | 0.70
> >
> > T.J. Mercier (2):
> >   bpf: htab: Split htab_elem_lru and htab_elem_pcpu off of htab_elem
> >   bpf: htab: Reduce elem_size by 8 bytes for small key sizes
> >
> >  kernel/bpf/hashtab.c                          | 339 ++++++++++++------
> >  kernel/bpf/map_in_map.c                       |  13 +
> >  kernel/bpf/map_in_map.h                       |   2 +
> >  .../selftests/bpf/progs/map_ptr_kern.c        |   2 +-
> >  4 files changed, 252 insertions(+), 104 deletions(-)
> >
> >
> > base-commit: cfce77b63375dac81d53f2f85593c548415206b7
>
