Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04068220F2A
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 16:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789662665; cv=pass; b=GhMP0Qymp6pe29fWc8poYwjvtAELggTea09lxMdyouSjdW0BCUNSL5UssEFgcuaZwFH9q3S2zEkfSBQczjJZy1t1p35W3ZJxGegE9H6blILsA+/rdbQ499aLvMC6Ba7oWfGOyYcyTCINNlh5nQJevJWJ9NcnmdU9we3ZvogE2Y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789662665; c=relaxed/simple;
	bh=ki8EP9bUSPkKjTAgwJvnAEPBiGsgX2hwq11+7AcUjrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iMM+c1A97LTUGaLq8vMyQO1D05fjXCz4BRuGRuQSo/5U+VrrjuPxssFfPFxwgt+QZI7XdvdWRrJTQyl3txlS4MiQaklUdGVadegjXybBMDQqFoXA2Gh9QSeoW4xa5HiDFGPfCGOcPV+nv1sODnbWOsmgczRtVblxV4h0VqN0HpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UD9ab8Hw; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UD9ab8Hw"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49e6425f96eso27655e9.1
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 09:31:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789662662; cv=none;
        d=google.com; s=arc-20260327;
        b=kR+sKeZ6HkfV8X4uiciLquWA5XqGDzvZ5+bVRtlBU8HV56Yum2tkjUMSh9sTmU9U9Q
         /mTaFOMI/Q1xW0rz5Lt53gPSntXXinGnbuQjtZKjm2fS7dJ6ZQ75tibx0tILUtmJ99tn
         9Z/96kVzGvJrLKtDPdGDXFPPnD1KnNd9ndF7u8fHx037u1n2OU7jt8jOmHukr0MZ4VcC
         ++LktiI53WvHxRv1lIExz/M3yXBeSnyMRl7xdlW2HsdQVdQDJRYw/rNoVeh5Lyq/2iqF
         /7Hu/vWm445izzsLp9T1ofDKlm8A6Ok6ELfvxAinoG+LJ+UaaB6wH3tNGUtZxcO6oQuJ
         mTnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tXwhH+XcURTEbCq1x81PCzjps805OYxsbA4JBXJM2WM=;
        fh=ilGrzuckMh2R0vaLM5P6DmqmMi8QK3yfqt/8FNRxqig=;
        b=apOD7+rlypN6oti4Yeeu5uy1bIutH3Ee7JA/y5ObBVUG1uWqmZkadwrtITxQJhS+Ug
         DQRJkjTteUJN5rkFtbzgHf/6hERuGJgA9n+EhiW6Zuyww9j8WAMdTCf2DugGkN2AofTC
         31WpV7zTMH/AtxLHkhDzFZHt/C7F/YWaZb0K8WNvW0128pokq0vTGjVEYu+zii1Kp4Dp
         EG+lUEnaZsN1qrlLwM+HQJqkBzuIpTMdCzCh+g0WvzEeIIUODxGk66FGUprZjwlYZfjj
         MUjwipMzwOsx6W7ApZwDSbV1aq+KNap5BDi92pwBlm+dREUfRz5dxgepnXctLWVe6s/I
         thJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789662662; x=1790267462; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tXwhH+XcURTEbCq1x81PCzjps805OYxsbA4JBXJM2WM=;
        b=UD9ab8HwqhFceapl4YioYnA0TSkXxUxcLA1hF5KT/HkfDJkWqOQY+WO7dlPeUQCVec
         Px7qs++nNiq+evR5WKHBP54/fnNXzhzGUMle/CqS2GTjjM5dSpM4CS9ntbmuyFtW5J3e
         4CuIU0nVvTF1y6uePMB0JIZlSGyxYp+Z/AVAXJX0Uer6QLVZc24fdiBifmCUS8UkbpWP
         3vB8bW08Uxdv0+xR2GkCrDPi2WYHXgCtwAPu7wJ9h2JLLqAMIO2vZ0N1SzusOXVHTIlz
         HsuU+dxl4Bt+GJBQRYhxg0va4izAUaaLbFmLbpSFVS7qwotULZRh+jZPlzIZxngUbRTf
         OLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789662662; x=1790267462;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tXwhH+XcURTEbCq1x81PCzjps805OYxsbA4JBXJM2WM=;
        b=CcRp/Kxnf5EXke7NMCrPu1u7mjIiP54kEBox/LF76lFPJ0k2gCl7ZHmlrsgoSX+Aiy
         OsAMnioS7JAzJocof4AkpRvMA7Lo+Mjpcj6Ocr1ufK0QGqnVkEcQy9cgMtFLommPXPMN
         QxILfU0tUCog3YO2LNmn9PGzdpCgYaHgKFffOc5hsLRn11NvYtOMBEBDQCluMk58tt9u
         /osbrcx4hjBYlIs+O/qtmSQj6hovp+oeao4laa4sKDu+pkCwMuTwuk1yCB7qCGcmzZvC
         xijMn8z548nwBOMnWbud9OZ9T0RJGl+z25R6P176MOHMAzLyzC4EmHBK1WrnWE9tb4Mb
         r9fQ==
X-Forwarded-Encrypted: i=1; AKwUvBxvET+jcZsQIuUyJZE3CZl18BHNJPrEhDZA+5OuawNL+UrxmDJgBkTvYTg2+vR+O8k5Yrw=@vger.kernel.org
X-Gm-Message-State: AFuF++mWAm801m7LGT+99o+QXzfL2GlZmieTAbfRTniJKa6VhhBIu7Nm
	a6AkZBjO2jibadF9JE0zJewXbdyi8Msl9WbTmdKgMcVv/MTGQmr7jAT6+pixp0K889hI+3f2P3A
	i0a7ezAh6aivSX+zhCQTNo8XlmYAPN/GqOyH6Rpby
X-Gm-Gg: AYBFou170UIplFqPQMQd7fuYrafJKAIy7trILS/IZ8hyJOugtXDY+DEqnBbPLEtoLWO
	B/Y8zgsmHedtHXV1QmY/PfcPqQqSwYA9M5ojnUtk02tfCFjbDuKP8zjJilYC8XZ3X2hOOdIwMNY
	4gw5j81VJiVFKUEXlZfnWr1u/L/XR6Ohryy6B84DA9tVSLYms76xxS+Ge5nX53hxTlDG0HQfhjU
	TAI4MqFPICEpKFoOQIjfknfEc6aKZUbogJ8LvW6FnO9VZyo28ZlRtFZaUcLcvGrcS58HD4vn7d8
	o5C9XSHNeC2NIpN2amwRzF5mPVFII6AKFDjm5r0fUkFOGtcSIPwE38X34m60E8GAhl7io+DBN6G
	IfiLTJt5iJsHiYKA3vC8zIkj5MVO8ZW2RuueC6uJJQQ==
X-Received: by 2002:a05:600c:4a27:b0:49e:7946:d8ce with SMTP id
 5b1f17b1804b1-49fc2c72b11mr220195e9.3.1789662661590; Thu, 17 Sep 2026
 09:31:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812231905.2956588-1-tjmercier@google.com> <15342d9c-d823-427d-9ce8-04cf48c6854b@gmail.com>
In-Reply-To: <15342d9c-d823-427d-9ce8-04cf48c6854b@gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Thu, 17 Sep 2026 09:30:48 -0700
X-Gm-Features: AcwNN1Uj5BaVPgPcxOdBtmVcsnbjqMoXReDNzWqGa1gtHNunRmMJCleRqYBXI-4
Message-ID: <CABdmKX1kM+ZRoj6R9R61kQv3dGQ=5ar8YPX=YdqtdJ1DO_-ZOQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/2] bpf: htab: Reduce memory use of hash maps
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 9:10=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 8/13/26 12:19 AM, T.J. Mercier wrote:
> > Memory is expensive and scarce these days. This series reduces the
> > memory use of BPF hash maps by eliminating the per-element overheads
> > below. This saves up to 50% of per-element memory use for standard and
> > PCPU hash maps. The memory use of LRU hash maps is unaffected.
> >
> > Map Type & Configuration            | Old size | New size | Savings
> > ------------------------------------|----------|----------|--------
> > Standard (key <=3D 8 B, val <=3D 8 B)   |   64 B   |   32 B   | 50.0%
> > Per-CPU (prealloc) (key <=3D 8 B)     |   64 B   |   32 B   | 50.0%
> > Per-CPU (non-prealloc) (key <=3D 8 B) |   64 B   |   40 B   | 37.5%
> > LRU (Any key/value size)            |    -     |    -     | 00.0%
> >
>
> T.J. are you still interested landing this? Maybe respin the series?
> Alexei was away back when you sent this.

Hi Mykyta, thanks for following up. Yes, I'd still like to land it. I
took a break during the merge window which coincided with a vacation,
where I broke my collarbone on a mountain bike jump gone wrong. Then
surgery and recovery, and I'm still catching up on everything from
while I was out. I plan to rebase this and send it out again before I
head out for pre-LPC travel next week.


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
> > For hash maps with small key sizes (<=3D word size), comparing keys onl=
y
> > requires a single instruction. Currently the 4 byte hash value (8 byte
> > aligned and padded) is used for this, but offers no performance
> > advantage in this case and can be eliminated.
> >
> > The implementation splits htab_elem into dedicated structures for the
> > different map types (htab_elem_lru, htab_elem_pcpu, htab_elem) which
> > share a common initial sequence (struct htab_node), but contain
> > additional map-type specific fields where necessary. This means the
> > placement of the key for each element varies with the map type, and
> > key_offset is added to bpf_htab for this purpose.
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
> > ---
> > Changes in v4:
> > Removed inline from new functions per BPF CI (netdev/source_inline).
> >
> > From Mykyta Yatsenko:
> > Factor out duplicate lookup_elem code into __lookup_elem_raw.
> > Use offsetof instead of sizeof for key_offset assignments in
> > htab_map_alloc (patch 1).
> > Eliminate branching and htab_elem casting in htab_elem_hash /
> > htab_elem_set_hash.
> >
> > Changes in v3:
> > From Sashiko on torn reads/writes:
> > Use a local unsigned long and READ_ONCE / WRITE_ONCE instead of memcmp =
/
> > memcpy for atomic key comparisons for hashless elements.
> >
> > Changes in v2:
> > Make maximum key_size for !has_hash depend on word size for atomicity
> > on 32-bit.
> >
> > From Mykyta Yatsenko:
> > Put the htab_elem* common initial sequence in its own struct (htab_node=
)
> > and reuse it across all element types that share it. Eliminate
> > associated BUILD_BUG_ON additions.
> > Replace both the hash and key fields with data[].
> > Store has_hash in struct bpf_htab, and avoid per-element reads of it.# =
Please edit the description for the branch
> >
> > T.J. Mercier (2):
> >   bpf: htab: Split htab_elem_lru and htab_elem_pcpu off of htab_elem
> >   bpf: htab: Reduce elem_size by 8 bytes for small key sizes
> >
> >  kernel/bpf/hashtab.c                          | 418 ++++++++++++------
> >  kernel/bpf/map_in_map.c                       |  13 +
> >  kernel/bpf/map_in_map.h                       |   2 +
> >  .../selftests/bpf/progs/map_ptr_kern.c        |   2 +-
> >  4 files changed, 289 insertions(+), 146 deletions(-)
> >
> >
> > base-commit: cfce77b63375dac81d53f2f85593c548415206b7
>
