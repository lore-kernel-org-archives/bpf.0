Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668F64964F
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 00:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785197443; cv=pass; b=rbYqLHbSxXbmfH92xFGv6BLBVGdKdUbc7t8/rKmKKTB5CFiCWcqwgejqgFazpoeZbIg/ckpVxoEyNV3Jb8r9yo6EsIJoisnCzwf8pFszsd1LS81ILZz3B55fwgUMePTUOaJ4aDKy+ZbKp0gFGD1ZzRKztqOkXN7HOAxU7U9qzR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785197443; c=relaxed/simple;
	bh=PoKFX94DyLMEkVr1398/VaQ/m1Cl1X0TLqQKCv0oa1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KGrp4sJg0OhxWOFpRGohjWAyG3tbOiiNaR1fZzkFLsuDm7TbzlnlJ7P2wjD7xEOp7iU1qf/L39F4Y5dE0+ZOb7gr1gU/PsFeQHjuuRUNIXwaouk6UGnPGY5LwuiodUWSdWkj/i3UTXhl39MEt9vQufMHgy8oIhORg2IQZGbCTjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJjoMwve; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJjoMwve"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-848595b338cso3584442b3a.0
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 17:10:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785197442; cv=none;
        d=google.com; s=arc-20260327;
        b=V6Rmru4025dxlq1fjfLfka31Eizq8LOvdIOqilfevvXDPy3mijx8qAwH2hIeDYy+A9
         rzTPStOhiwLGSElSZTHI9TtUPSgmigph2jHS7DGBdgFyuk3+XLPtD7QWAapXEiWv+BTi
         lTEU5KCaWKsjFKxS447/o1/j/UqS5vBh8KVajCel80WiJgrZzNqNqAavYOUkGBuEj8sH
         r5MWei+ba/Ae9rgrStgxfSxvWdiyZLoDuGGmgOHfyObnOXJnYDkPbbyw8JWfv8NrCDTI
         LmLyIDRHzJaHxAZIxRwjnrpg907fQKx9NUUjkNOKvdyJbif5eCSWCA/8qR4SeomTh9f8
         fXAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R4HypMcs8BYBOoxEtRN7dFAtSAXaZPdyvpkHA78JaaI=;
        fh=qVtT5G4755aEjqfiI9ibJkCwPSxkeQqFp/HyF6+NL2U=;
        b=EWIe4dwV+QiqU/g7sd5sFOtcI3LaZ+m+SLS2H06q7E8Y9ZTI/JJA5b11dqyCwAmwZo
         SptatbAzep4sdDszFgCZkck3TOVGkPpw/kl4j7UO7YuL3L4QjTWllcsX9Dp0f/8ggdMh
         2o5EEVgu16c/7h0pSumHAHgNpy2WCgn3JkxdYNMH7nZMzDsAQyVMIFxnPr9UrVpMGj6y
         zS1/FH6OegQWuoXPQKYu/mwcYlVlErVKiisatJXcBacpO97++wzjR0pMyCu/sn7dU9Bt
         mMgpu3gRnpAmOidzNUWomWbkm0yweM4w+JgJwaRa7j8QyqEWgOkBFb22rCJGt/ZJxJFz
         tZlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785197442; x=1785802242; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R4HypMcs8BYBOoxEtRN7dFAtSAXaZPdyvpkHA78JaaI=;
        b=EJjoMwveOpiJupjjm3S+z62z9m8xHlyWPnoRg103P8tmOr9bgcJ4eohNuaw3SQbOAs
         AC5xkzRCBIUIC3cIPZWsqLM5EemsVON53jJK4OCwRvouRfkv3LNUZ58seRvlF9RzNvyX
         DsMGe1vR838Ta/PaiLNeXCAD/44kWAXRAxDuGnyajFuGlvA6XVGty0TM/ADySKJk5DtK
         fgdUDeRoKtNxC79mDQDhf3mFo+mN6GLdbESW2M1YtWkR6h3DIwJGR3sH+bpNye0Nmyw3
         R4mqgVoyDD+YeMBogcFh6lZqHqLCWXRQqysG/kejWA1+uul/3h9Y0pTZ4wGU6pymvCQK
         zXIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785197442; x=1785802242;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R4HypMcs8BYBOoxEtRN7dFAtSAXaZPdyvpkHA78JaaI=;
        b=j9B2dwP2KeHTtq9w0pAG/16vCJm3HjbQc4G4vGdx7tH3nfuaz1I0WueYsnW1rX8L9q
         6sbCVChDW5mHjqDDZMWSqXSLeoJVMkqcof19EOtMoyQWZaCkmIFQ71Plr2Gmd+yTKR06
         r2A9rjjD8HEcDuC0XtUDTQXyIH6C9uwF0G91WdikG7Vc0p+s+nL3jCXZTYtpzYsZF+l5
         1Za/0+6nSt1OoDOeIjHin8gr22uu9WFdHZEOUuuFqV+9H4nMb3kOhjR2l2OGlFy1kdAO
         XTYmuoKnw5flt0LzpZ04syrHkD4oxPTNnrQZ4WhkHQVHYfQHGh77K+xDIXhbxfqQ4bWS
         I6aA==
X-Gm-Message-State: AOJu0Yx4FydSsT6vvCjCbRnufsx30TpmfQCbbYPPpdbRg2NQun3DouIX
	Y/CAe6NUZdG3A9wkF5w0D+PFCKkvgj7qkNQtA3pdB5Wfic4E+Fs52JRuWDYKIFH+25D4N27RmcS
	LZN+uNN7VbTCiswRL1Dvjry1VoJ31uBM=
X-Gm-Gg: AR+sD126FHqIx/bOVTmc4gT23fYdQpG3OV3RF7bqmhkFgF0xK7dHUkfuCmcPel5asod
	2MkcXltDRnCg3232rhcpzm88vzh4b43IoY3gH/fWCjx04XWyzBBwROx+vsr0db0Iu2wj1Px8/S9
	UAZOv1inAZ2BWLKOL6Ll0BwTsVMhSdE6xPA/E145G4Ap2kAgsH4kWYBV2b9lwclL47VD/TDrDYJ
	l3kqpzCEwTK8czAuP+JhqtkeXtPWuhVBrecGTvtxj/nCAXxhm1t+Tw8S++TJFjT7ZAqAkuCFncj
	3cHUQbgCycanO+UyYWIS+uNmDrspl97aiTeruw06yFJ0fBGKf2Cooehcyw==
X-Received: by 2002:a05:6a00:1f08:b0:84c:5b65:ef86 with SMTP id
 d2e1a72fcca58-84e93235d72mr83715b3a.17.1785197441644; Mon, 27 Jul 2026
 17:10:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722205032.1245094-1-song@kernel.org>
In-Reply-To: <20260722205032.1245094-1-song@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 27 Jul 2026 17:10:26 -0700
X-Gm-Features: AUfX_mzFBOUKVBJnAG0DlX8AgwT7unGbH3y9CjGj7MMXX8Crsorvv5vlco2EnLU
Message-ID: <CAEf4BzYjvcnJyC05b39vdoS6kQKQhomXa=fJbZkTTGYZ+g68Ww@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/2] bpf: Populate mmap-able array maps lazily
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 1:50=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> An mmap-able BPF array map (BPF_F_MMAPABLE) has its backing memory
> vmalloc'ed up front at map creation time. array_map_mmap() then wires up
> the whole mapping eagerly via remap_vmalloc_range(), which calls
> vm_insert_page() for every page of the map. This makes every mmap() cost
> O(number of pages): an 8MiB map inserts 2048 PTEs on each mmap() and
> tears them all down again on munmap(), even when user space only touches
> a few pages (or none at all).
>
> This series makes the mapping populate lazily instead, the same way the
> arena map already does, turning mmap()/munmap() of an mmap-able array
> from O(map size) into O(1). The pages are inserted on demand by a new
> map_mmap_fault() callback, dispatched from the shared
> bpf_map_default_vmops so that the existing VMA open/close accounting
> (VM_MAYWRITE write-active tracking, freeze handling) stays centralized.
>
> Callers that want the pages populated up front can still request that
> explicitly with MAP_POPULATE, matching regular file semantics.
> Kernel-side access to the map (via the vmalloc address) is unaffected.
>
> Patch 1 implements the lazy faulting. Patch 2 adds an "arraymap-mmap"
> benchmark that mmap()s/munmap()s an mmap-able array map, useful to
> observe how the cost scales with the mapping size.
>
> Changes in v2:
> - Compute the mapping offset with 64-bit arithmetic in array_map_mmap()
>   and the fault handler so that a large vm_pgoff cannot overflow the
>   bounds check on 32-bit architectures. remap_vmalloc_range(), which is
>   no longer used, used to guard against this.
> - Benchmark: use the standard -p/--producers option for the thread count
>   instead of a custom --nr-threads option. The v1 approach set
>   env.producer_cnt from validate(), which runs after the framework has
>   already sized the producers array, causing an out-of-bounds write.
> (Both issues were pointed out by the Sashiko AI review.)
>
> v1: https://lore.kernel.org/bpf/20260722065308.4116186-1-song@kernel.org/
>
> Benchmark results (single producer thread, ./bench -p1):
>
> Before the patch
>   nr_threads: 1, map_size: 1048576
> arraymap-mmap: throughput: 0.034 +/- 0.000 M ops/s, latency: 29187.164 ns=
/op
>
>   nr_threads: 1, map_size: 8388608
> arraymap-mmap: throughput: 0.005 +/- 0.000 M ops/s, latency: 220910.150 n=
s/op
>
>   nr_threads: 1, map_size: 67108864
> arraymap-mmap: throughput: 0.001 +/- 0.000 M ops/s, latency: 1765083.440 =
ns/op
>
> After the patch
>   nr_threads: 1, map_size: 1048576
> arraymap-mmap: throughput: 0.838 +/- 0.001 M ops/s, latency: 1193.553 ns/=
op
>
>   nr_threads: 1, map_size: 8388608
> arraymap-mmap: throughput: 0.811 +/- 0.002 M ops/s, latency: 1232.728 ns/=
op
>
>   nr_threads: 1, map_size: 67108864
> arraymap-mmap: throughput: 0.747 +/- 0.004 M ops/s, latency: 1339.051 ns/=
op
>
> Song Liu (2):
>   bpf: Populate mmap-able array map memory lazily
>   selftests/bpf: Add mmap/munmap benchmark for array maps
>
>  include/linux/bpf.h                           |   1 +
>  kernel/bpf/arraymap.c                         |  43 +++++-
>  kernel/bpf/syscall.c                          |  17 +++
>  tools/testing/selftests/bpf/Makefile          |   1 +
>  tools/testing/selftests/bpf/bench.c           |   4 +
>  .../bpf/benchs/bench_arraymap_mmap.c          | 127 ++++++++++++++++++
>  .../bpf/benchs/run_bench_arraymap_mmap.sh     |  15 +++
>  7 files changed, 204 insertions(+), 4 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/benchs/bench_arraymap_mma=
p.c
>  create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_arraymap=
_mmap.sh

do we really need these benchmarks? yes, it's obvious that not doing
anything per-page will be faster :) (I mean, it's good to see that
it's 30us for 1MB array, but I don't think we should carry benchmark
in the kernel tree)

>
> --
> 2.53.0-Meta
