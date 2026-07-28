Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425A21E832A
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 00:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785198294; cv=none; b=U8pcHUDhCLs9e4ctBeYt/6mDjaXz4qNL/HWg+GdefkgBK/a26BsFUP17JdjiHhGu+zhskpIQhMZ8eM9sWEuTeZ13d2A/Y48k31ouvhN80XN7AmMp93Sl6wU6MxggUGx2hFoInF9aMN645PL5dYTpTv86kx+vboMSIzddfteJIYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785198294; c=relaxed/simple;
	bh=bzSp/UKiM/bHQ4fPIyYdPi0AgKZhuSRo9/8+VJ/fMnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HA+WbVtUD+jb3NeoO990yYjtuqX6TLKDaWWrlg4W1g5H/Ed3cOdMkxK1HY0yxUSPdbLJMNhDFcqLzU+q5DP92GukmMTeeJcj9pUo1l/lqSFTOw9w/76U8kIUnPhbtqEi0mJzgiuGTOqqLEi+DYYnKcB/ftsytCw1O4AuBFH6kWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f15EH+zI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f15EH+zI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48D11F00A3A
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 00:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785198292;
	bh=MP3aaWkeb7cPo0VrDnrPMRGB8A7gswa4J5dcafg3MMg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=f15EH+zIB2T75FOJFXBsFVw7zQ5LVX1o11WgqTb0bjEIX0sxRiJddf94xisvkFxdp
	 B0g1Xs9ReaIjhhGX1SlfhcTrCUYZnqIPhOkzzcKaWCHHI0MutQiAdwS/BSq2F38RiM
	 MLgyBJcFIw2bmdvr+/KMcjyms9xWU8BjoDVKFu8oWnxhtD/h0pboTBOzS4OcHqQhdu
	 ZdxDazn7Fb8rQE4tX6qT9f2DzUgiBuFmll1lyCJVRfTeMZmNhnVtUndeC4V3osol4U
	 A8F1nO7zW9Yc4B3i3A/lomh2JcTOvNYr5divtcB33+E35HbZUsfyd72X9VtmsamvY4
	 wvGEpu+g47TNA==
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8ee6912d86dso23335526d6.1
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 17:24:52 -0700 (PDT)
X-Gm-Message-State: AOJu0YxCn/6rVzxa/bozMBhJq/zLvQfAB+WEX5Q7qFFpei3piLVKwzNb
	ZaYmzu90ida+l1oV7FGgWAy7mQ7IhSNkQbtHfHlohEk+/ByP6butYmdw7Wb/l1u8jVrfbOqG6ac
	t99BKevF/GGixEslRLQjhkSXLrQ6ZJNg=
X-Received: by 2002:a05:6214:4985:b0:907:b32f:9b79 with SMTP id
 6a1803df08f44-90816f63d78mr1975036d6.6.1785198291909; Mon, 27 Jul 2026
 17:24:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722205032.1245094-1-song@kernel.org> <CAEf4BzYjvcnJyC05b39vdoS6kQKQhomXa=fJbZkTTGYZ+g68Ww@mail.gmail.com>
In-Reply-To: <CAEf4BzYjvcnJyC05b39vdoS6kQKQhomXa=fJbZkTTGYZ+g68Ww@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Mon, 27 Jul 2026 17:24:39 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5w1A7LhupFxd6Va2dr=2E5cfvPsNRpYc6mdSWsQ3B0Lw@mail.gmail.com>
X-Gm-Features: AUfX_mwZIj_4Gve2zk0GbXNRPtKTqQa0fC91WQdLHL-Ai_tbF7tePZSDyvegnwo
Message-ID: <CAPhsuW5w1A7LhupFxd6Va2dr=2E5cfvPsNRpYc6mdSWsQ3B0Lw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/2] bpf: Populate mmap-able array maps lazily
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 5:10=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Jul 22, 2026 at 1:50=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> >
> > An mmap-able BPF array map (BPF_F_MMAPABLE) has its backing memory
> > vmalloc'ed up front at map creation time. array_map_mmap() then wires u=
p
> > the whole mapping eagerly via remap_vmalloc_range(), which calls
> > vm_insert_page() for every page of the map. This makes every mmap() cos=
t
> > O(number of pages): an 8MiB map inserts 2048 PTEs on each mmap() and
> > tears them all down again on munmap(), even when user space only touche=
s
> > a few pages (or none at all).
> >
> > This series makes the mapping populate lazily instead, the same way the
> > arena map already does, turning mmap()/munmap() of an mmap-able array
> > from O(map size) into O(1). The pages are inserted on demand by a new
> > map_mmap_fault() callback, dispatched from the shared
> > bpf_map_default_vmops so that the existing VMA open/close accounting
> > (VM_MAYWRITE write-active tracking, freeze handling) stays centralized.
> >
> > Callers that want the pages populated up front can still request that
> > explicitly with MAP_POPULATE, matching regular file semantics.
> > Kernel-side access to the map (via the vmalloc address) is unaffected.
> >
> > Patch 1 implements the lazy faulting. Patch 2 adds an "arraymap-mmap"
> > benchmark that mmap()s/munmap()s an mmap-able array map, useful to
> > observe how the cost scales with the mapping size.
> >
> > Changes in v2:
> > - Compute the mapping offset with 64-bit arithmetic in array_map_mmap()
> >   and the fault handler so that a large vm_pgoff cannot overflow the
> >   bounds check on 32-bit architectures. remap_vmalloc_range(), which is
> >   no longer used, used to guard against this.
> > - Benchmark: use the standard -p/--producers option for the thread coun=
t
> >   instead of a custom --nr-threads option. The v1 approach set
> >   env.producer_cnt from validate(), which runs after the framework has
> >   already sized the producers array, causing an out-of-bounds write.
> > (Both issues were pointed out by the Sashiko AI review.)
> >
> > v1: https://lore.kernel.org/bpf/20260722065308.4116186-1-song@kernel.or=
g/
> >
> > Benchmark results (single producer thread, ./bench -p1):
> >
> > Before the patch
> >   nr_threads: 1, map_size: 1048576
> > arraymap-mmap: throughput: 0.034 +/- 0.000 M ops/s, latency: 29187.164 =
ns/op
> >
> >   nr_threads: 1, map_size: 8388608
> > arraymap-mmap: throughput: 0.005 +/- 0.000 M ops/s, latency: 220910.150=
 ns/op
> >
> >   nr_threads: 1, map_size: 67108864
> > arraymap-mmap: throughput: 0.001 +/- 0.000 M ops/s, latency: 1765083.44=
0 ns/op
> >
> > After the patch
> >   nr_threads: 1, map_size: 1048576
> > arraymap-mmap: throughput: 0.838 +/- 0.001 M ops/s, latency: 1193.553 n=
s/op
> >
> >   nr_threads: 1, map_size: 8388608
> > arraymap-mmap: throughput: 0.811 +/- 0.002 M ops/s, latency: 1232.728 n=
s/op
> >
> >   nr_threads: 1, map_size: 67108864
> > arraymap-mmap: throughput: 0.747 +/- 0.004 M ops/s, latency: 1339.051 n=
s/op
> >
> > Song Liu (2):
> >   bpf: Populate mmap-able array map memory lazily
> >   selftests/bpf: Add mmap/munmap benchmark for array maps
> >
> >  include/linux/bpf.h                           |   1 +
> >  kernel/bpf/arraymap.c                         |  43 +++++-
> >  kernel/bpf/syscall.c                          |  17 +++
> >  tools/testing/selftests/bpf/Makefile          |   1 +
> >  tools/testing/selftests/bpf/bench.c           |   4 +
> >  .../bpf/benchs/bench_arraymap_mmap.c          | 127 ++++++++++++++++++
> >  .../bpf/benchs/run_bench_arraymap_mmap.sh     |  15 +++
> >  7 files changed, 204 insertions(+), 4 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/benchs/bench_arraymap_m=
map.c
> >  create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_arraym=
ap_mmap.sh
>
> do we really need these benchmarks? yes, it's obvious that not doing
> anything per-page will be faster :) (I mean, it's good to see that
> it's 30us for 1MB array, but I don't think we should carry benchmark
> in the kernel tree)

I am OK removing this in v3. AI wrote most of it,  so it is not
a lot of wasted effort.

Thanks,
Song
