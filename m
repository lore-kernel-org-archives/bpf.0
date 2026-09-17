Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DC844236C
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 21:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789680110; cv=pass; b=AcCbdtOtg0G/szH1ET0nqwD8TCn5qJsLUMDA1sCZhCZXgS/Cv9zYGXWT4vAS/T5Dbof3B4iwL+cyHyWmgQ/sFh+P84a+Uo8MFqpuM6ushEZH2IOnC10f2/G12GWN3jbZA3uQwTEVmW1GNWyJziBH4h86xJg/M40EhPmeoWu3L8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789680110; c=relaxed/simple;
	bh=02PP0CkoW8Vg7q2IB/9SjjOsCOC3B35ZDboJwPDZKCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AO8Cm6U/CMmRvUJIla5wVzmconPXb2oo0Q6wJlvZhUegO1LWVVwSb3eJ/JD9AjiyY1xQ3Y3ii6nrld4KWa8uoovWXGVTCM7VSvWRuoRZzKKns3OJYfwDZfwjCi3jTNOxrtF8oh5vgtKtOKLZ6Ybc2GbKxYKh603iRTgwr8wyMsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WfANd8zA; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfANd8zA"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747f0135fso871745ad.0
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 14:21:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789680108; cv=none;
        d=google.com; s=arc-20260327;
        b=Q6J3AbcO9xgTjybGBBty+ccERApP58csjG6F8OYxv0rT10SvQET1NH/5QhJz/7dFz8
         LFOY+eA0BadjADFQ64fOR3zOU1/PUrLk4UW8eZij9dxfoLFTaMT+zAZF0UkMf+FWhk+k
         EgEIT+VlhVKcnpYzZDWTjnheJJOSouP0uOanWpYbnFY31cNiSyOXLTVD5Yq1y24CCSsf
         4EBKLDCmGNXOdoeQ2NkcjfK/4EgaPXo7OPpTnms6q4RJPqs/5xXUJCqr1ZjcoeqjQFJ7
         06T6UhkC2ZsTrDoTMBYaxL7oWuINAu/DEaeqlZFg2pYFj2cRZj1odmNTg2YnkVC62cBP
         t3hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bWnEwFk919foJIBK358W6lEoeaXM1cyk6wKt0KOZnuY=;
        fh=/sg4XCnqt0cTu7dsM6wInrPctcty6wKc7zuuRuOvjEI=;
        b=VpvZWYx5PxNQIBy3/iRNGhsBtwzETbPDXMjw72cpQbpiWSaSOJfD1bSdg1syulMw47
         dJP9Heg8Udhh+EN/ZHEDQZ+KgVrle0qLC5cDzvD34l8d3YBO6vPMTpoeIxwy+8xQZAfR
         u2bpBdPD0ZsW/RvxUqP/zU3iufjgaTSxOFJKM/3RRqp7xQY5flG/r90Kz1JUI5s5Oanp
         rSQgnJY3/NmdASm83vFjheHgklAaNtbsSbQQ75p2THq11bvICsWj7ZHGx1O0PDy6OchP
         YonTUjuXDrnr7sM2K4lO3OKrg+3+P04YA6gvWnpmJuySpcQasjdqFDAzf6O1giXj2jfQ
         Mp+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789680108; x=1790284908; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bWnEwFk919foJIBK358W6lEoeaXM1cyk6wKt0KOZnuY=;
        b=WfANd8zAh+dzcqSC0Qp+7NfcWLttswSWw1JCR2fiSxRkG7Vex6aNiVUf6rKAIhhAt6
         WgAKW6GLZUb4giFM8nKSXUExQ+KD2sY9JRzoI/XoFa5INMyAAnknywvYB98AfOG6U1Wu
         zqwHaUoYiWU5fQQdneIgN7h78JEXpa8na8yufTUibwhcmCX4Lnfwb+ypGDVvj16KXzRf
         AwsmSHURq/95BprPthLUaSwUOh/7N/cRdV4IIchnLllx3ocjJA0pONVNHhtYqhXtYAiT
         FxxHoQD4QVNfw/qe3CbKAzXaMUkVlwZ3PqRtIyqKVbeioSxlMRwuytFcBDGWSdXEL8jm
         s/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789680108; x=1790284908;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bWnEwFk919foJIBK358W6lEoeaXM1cyk6wKt0KOZnuY=;
        b=t9wGhzl69Ht2p6uS42DtwBgzQ+WCM42bJqiauknwEh39WF05S+4CN2lcq1/oxZ6hVP
         +9Wd7DBu3SXExCN0bCi36rv6dNMf+J0kXI1HY+3DYy8WVRHrxw1bjEriDNYq0p877bB+
         h/4cApDYe31WSOZcwmE9etbtsqikt0yytvqKN6PBC1DdM1GKJpwjDycgHUUsdnaukQnB
         CjElvIxXoAedH3LpjfZ8UaPmXCxyNdxt7JphYVF0dOx4vWIu88f9qfALXoFN9VcH1sMS
         DfYZVTO68JwX4MNAyXgCIt+or8jjKia9Eu6io5l1638FISrHXzODg4/GKinTdCo+JIG6
         WNBw==
X-Forwarded-Encrypted: i=1; AKwUvBwHw/HarrDlqd4ricDDgjzHEN/iBY/2j68y70XbjYwT4UtFbgjNqKUcDfpufX83BgT8o1E=@vger.kernel.org
X-Gm-Message-State: AFuF++mc3FKdYQiXdZZM2NkY2btZmRekZBVxiMh8CsG8/7NVPj4bj+QU
	6N5J6YFZxB2/7lVLQP4f0u0ebQmMKVSJynrSr7pII2pGYwP1WaWhWJqpVbfYQf6hn679G/hSgCo
	rdSlJssUFBMfFoKlH1iuXZGxw3k3Bul4=
X-Gm-Gg: AYBFou3ZEXgm8xmH9+utl68VEYGjER2amKibRuEoo1AbIZ3EmU/A5P27s94YeMe1MeH
	85Q7pn8BHIWs4Xgh+zvSnoiehxBDsHNIYuwmYS/u2Cm3x+XaSQgSGRLengR9O+e4vzpsW7Zc+1z
	pO/suuD1452SJhmtyuKhVELEXwxviyPMWZ5s1l57NFhXeeQnfsflj7JwU6p/o6wZPHOPrcDg37Z
	fHrHAv+ZsCOyHzW9T4hbm8gSSyp2U4e2QG0bFgDiwImdPZFIafqiD361y6A7IwrQN3EVlfv/qkG
	o/pukRh1GaJp7Gl2LFYAySiWSnmJebabjf2dGC6LCbERVnySmvsr+vXmPubJX72SRUfSH7mO9sj
	UvE15oI8LgaglreoLPyFwUTiNLk1mKsZquSAai3xy8SAdyNJZX53wwFq425g2gM8=
X-Received: by 2002:a17:90a:d64f:b0:39e:4c80:44b9 with SMTP id
 98e67ed59e1d1-39e54dccbb8mr836963a91.28.1789680107805; Thu, 17 Sep 2026
 14:21:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812231905.2956588-1-tjmercier@google.com>
 <15342d9c-d823-427d-9ce8-04cf48c6854b@gmail.com> <CABdmKX1kM+ZRoj6R9R61kQv3dGQ=5ar8YPX=YdqtdJ1DO_-ZOQ@mail.gmail.com>
In-Reply-To: <CABdmKX1kM+ZRoj6R9R61kQv3dGQ=5ar8YPX=YdqtdJ1DO_-ZOQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 17 Sep 2026 14:21:33 -0700
X-Gm-Features: AcwNN1V3I1xWQb6TFk3pHAqlXXe3pfdIC01EqR_ZHg5NL8DctvHahF1KKgLRD8M
Message-ID: <CAEf4BzbWRBDF8XaV-TAwyWFyko6JuquSbEJfztE_1sRKauXBqQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/2] bpf: htab: Reduce memory use of hash maps
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, 
	emil@etsalapatis.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 9:31=E2=80=AFAM T.J. Mercier <tjmercier@google.com>=
 wrote:
>
> On Thu, Sep 17, 2026 at 9:10=E2=80=AFAM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
> >
> > On 8/13/26 12:19 AM, T.J. Mercier wrote:
> > > Memory is expensive and scarce these days. This series reduces the
> > > memory use of BPF hash maps by eliminating the per-element overheads
> > > below. This saves up to 50% of per-element memory use for standard an=
d
> > > PCPU hash maps. The memory use of LRU hash maps is unaffected.
> > >
> > > Map Type & Configuration            | Old size | New size | Savings
> > > ------------------------------------|----------|----------|--------
> > > Standard (key <=3D 8 B, val <=3D 8 B)   |   64 B   |   32 B   | 50.0%
> > > Per-CPU (prealloc) (key <=3D 8 B)     |   64 B   |   32 B   | 50.0%
> > > Per-CPU (non-prealloc) (key <=3D 8 B) |   64 B   |   40 B   | 37.5%
> > > LRU (Any key/value size)            |    -     |    -     | 00.0%
> > >
> >
> > T.J. are you still interested landing this? Maybe respin the series?
> > Alexei was away back when you sent this.
>
> Hi Mykyta, thanks for following up. Yes, I'd still like to land it. I
> took a break during the merge window which coincided with a vacation,
> where I broke my collarbone on a mountain bike jump gone wrong. Then
> surgery and recovery, and I'm still catching up on everything from

oh, wow, hope you'll heal fast and well!

> while I was out. I plan to rebase this and send it out again before I
> head out for pre-LPC travel next week.

have you considered splitting lru and non-lru flavors of hashtable
before doing this optimization? I'm wondering if it will allow to
clean up some parts of it, while also making map struct itself smaller
for non-lru map (there is that LRU-specific piece in the union which
artificially blows up the size of any hash map).

I am a bit concerned about that key offset, even if the microbenchmark
doesn't show much difference. What if we put hash itself before
per-element header, so that key/value are always at the same offset.
For cases where key size > 8 we'll just access hash at
addrof(htab_elem) - 8, while smaller key sizes will just directly
compare keys.

Just some high level thoughts, haven't really coded any of that, so
hard to tell upfront if it's worth doing.

>
>
> > > 1) Unused LRU / PCPU fields in standard and PCPU hash maps (patch 1)
> > > struct htab_elem is used for all hash map types, and includes fields
> > > that are not always used (bpf_lru_node, ptr_to_pptr). For standard
> > > (non-LRU, non-PCPU) hash maps the 24 bytes for the bpf_lru_node (unio=
n)
> > > are entirely overhead and can be eliminated. Non-preallocated PCPU ma=
ps
> > > only need the 8 byte ptr_to_pptr which is currently unioned with the
> > > unneeded 24 byte bpf_lru_node, so 16 bytes of overhead can be
> > > eliminated. Preallocated PCPU maps don't need ptr_to_pptr, so 24 byte=
s
> > > of overhead can be saved.
> > >
> > > 2) Hash caching for small keys (patch 2)
> > > For hash maps with small key sizes (<=3D word size), comparing keys o=
nly
> > > requires a single instruction. Currently the 4 byte hash value (8 byt=
e
> > > aligned and padded) is used for this, but offers no performance
> > > advantage in this case and can be eliminated.
> > >
> > > The implementation splits htab_elem into dedicated structures for the
> > > different map types (htab_elem_lru, htab_elem_pcpu, htab_elem) which
> > > share a common initial sequence (struct htab_node), but contain
> > > additional map-type specific fields where necessary. This means the
> > > placement of the key for each element varies with the map type, and
> > > key_offset is added to bpf_htab for this purpose.
> > >
> > > While using key_offset and conditional hash checks adds new pointer
> > > dereferences and branching during element traversal,
> > > run_bench_htab_mem.sh shows no significant performance regression acr=
oss
> > > 10 runs on my 3995WX.
> > >
> > > Benchmark (all in kops/sec)  | Avg. Before | StDev | Avg. After | StD=
ev
> > > -----------------------------|-------------|-------|------------|----=
--
> > > prealloc overwrite           | 115.11      | 4.10  | 115.45     | 5.2=
4
> > > prealloc batch_add_batch_del | 127.14      | 4.32  | 127.06     | 2.3=
2
> > > prealloc add_del_on_diff_cpu | 23.22       | 0.93  | 22.91      | 1.6=
0
> > > normal overwrite             | 78.52       | 3.05  | 80.40      | 3.2=
5
> > > normal batch_add_batch_del   | 45.37       | 0.69  | 47.71      | 0.6=
6
> > > normal add_del_on_diff_cpu   | 12.02       | 0.73  | 12.48      | 0.7=
0
> > >
> > > ---
> > > Changes in v4:
> > > Removed inline from new functions per BPF CI (netdev/source_inline).
> > >
> > > From Mykyta Yatsenko:
> > > Factor out duplicate lookup_elem code into __lookup_elem_raw.
> > > Use offsetof instead of sizeof for key_offset assignments in
> > > htab_map_alloc (patch 1).
> > > Eliminate branching and htab_elem casting in htab_elem_hash /
> > > htab_elem_set_hash.
> > >
> > > Changes in v3:
> > > From Sashiko on torn reads/writes:
> > > Use a local unsigned long and READ_ONCE / WRITE_ONCE instead of memcm=
p /
> > > memcpy for atomic key comparisons for hashless elements.
> > >
> > > Changes in v2:
> > > Make maximum key_size for !has_hash depend on word size for atomicity
> > > on 32-bit.
> > >
> > > From Mykyta Yatsenko:
> > > Put the htab_elem* common initial sequence in its own struct (htab_no=
de)
> > > and reuse it across all element types that share it. Eliminate
> > > associated BUILD_BUG_ON additions.
> > > Replace both the hash and key fields with data[].
> > > Store has_hash in struct bpf_htab, and avoid per-element reads of it.=
# Please edit the description for the branch
> > >
> > > T.J. Mercier (2):
> > >   bpf: htab: Split htab_elem_lru and htab_elem_pcpu off of htab_elem
> > >   bpf: htab: Reduce elem_size by 8 bytes for small key sizes
> > >
> > >  kernel/bpf/hashtab.c                          | 418 ++++++++++++----=
--
> > >  kernel/bpf/map_in_map.c                       |  13 +
> > >  kernel/bpf/map_in_map.h                       |   2 +
> > >  .../selftests/bpf/progs/map_ptr_kern.c        |   2 +-
> > >  4 files changed, 289 insertions(+), 146 deletions(-)
> > >
> > >
> > > base-commit: cfce77b63375dac81d53f2f85593c548415206b7
> >
