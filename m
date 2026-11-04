Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825789;
	b=eFl16kfymLrYd9OkRniSFMldvsCQaHemQUzap2X/nLw/CHTqsSQubEM9XKgDKmv/3doK
	 C64PiVWFFeA/9LWyIXcdWdqXHizVE2iM7PM7wfuGDS16wTUiBRl0OPh27So9cc86p4grH
	 gbYgTS+MTQCkfJYej96GhXzYMKmd/9ULuC2MZl0WUcxwpCwMv5YZ7HM0pnMu+iOHNzwga
	 IRPt2+b4tukI9HM5w6O+A0anfNRSwVELa1A/Rcl0Tlvk67vy7erpPie7JILnqWWf5F+Sy
	 LYqWz3cXDxxj7b2p0Yf58qmvBGQUqF0SjqI5QA2aOrBdf2IKNWJ6ijvRToCGn+THfeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825789;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=osWOTOTQBxibmdk7vYQvxdot4PKbfhI2tgBU79UNrUk=;
	b=zDQOPxtUkdlN5UlAs6w7MTxI9l6zXzXX7SF51ApczEykO/UeSmOLi4jIT5VENp52LrVw
	 VpICTFdHiRlVFMTZyOLaShLZ3Sl+d0mni4yqQdNNaRE7D6tB1FgUVgPGgUi1k8tSt2sj0
	 4ph9VznXfLQctFpr3fkZZ3tQmjIYJ8PyqTYW2nQcpPWImAhzgK1JNOgyZQakVL97fxp9J
	 7eV7Gk4XibeSuPes06GF3jrWXoBMoFK/bN0ASI1ZTqMw91DgkV7/AGSx1Rsqa68XrWMl7
	 xF76qniLn94Puf4KDPivMV/Cdd/sLpMYovZJcVmo0/6f/nD1S/kOAcE+McqMMx/UVPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KazNcZp6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBF4606B2C9
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 20:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KazNcZp6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DFEA1F00A23
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 20:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793825789;
	bh=osWOTOTQBxibmdk7vYQvxdot4PKbfhI2tgBU79UNrUk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KazNcZp6qfpRdpx0Oe5j+F8/M9LJGR2nQOeCHm5RYvPEKVOnFU9V9UfLJR1KMsW9B
	 bJvBnjkwNdj2C8cn/tLvyj7KgG3kxBlB5vj+bmXwEQ7TrHN8Myj4tDSEODHN6kEV6z
	 RZP1RffojHsRoeuIK4m6s85Vaw8N4qWOXCeeSBydy+CXMxnmJxxtnhokkSPrVawA0u
	 zULvzQrlmtRimkxL4Cxcdep7XIoTUK4+YtoP/PoJX1/E/eEsnrR1VAuUL19Bz8bped
	 Q4MiiD80HzVkRzPSl44k0WY/HWUP0E5kYcf3ARkXoastBoOSwUY0xhempTBPZstDJi
	 NNw3Jlt/v4jyw==
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5eae12762c9so421929e0c.1
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2026 12:56:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBy9/C0M0nG2eAQYG9U8oERwVH3qaUWsdDTiUBEMPUEwKOuAF0ZRXCbSMiCeyPqt4Uph93E=@vger.kernel.org
X-Gm-Message-State: APuU4Z+1GUVnXwTZ0IBpt5C8w5Kf1bWGRWXlQEJM9QeeVlQIBJbnEBQ7
	arLnsolztgyLlG5K1zslyPZ5upxYyFRgLesLpFdaP5bBkz5J6D7EgVgnOzEFwqV0NEZEaDq4lxV
	kTSeOIxxLYqYNbspzp6XmstRy5tbMWe0=
X-Received: by 2002:a05:6122:32d5:b0:5e9:6d96:a910 with SMTP id
 71dfb90a1353d-5ec6850f9a8mr7100215e0c.3.1793825788528; Wed, 04 Nov 2026
 12:56:28 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104130817.849089-1-ridong.chen@linux.dev> <20261104130817.849089-8-ridong.chen@linux.dev>
In-Reply-To: <20261104130817.849089-8-ridong.chen@linux.dev>
From: Barry Song <baohua@kernel.org>
Date: Thu, 5 Nov 2026 04:56:17 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4y_Ay0mYO3ic72oepjtW6KYf2sKRXEHb3Ff8uwKrOJZjQ@mail.gmail.com>
X-Gm-Features: AclHuK83pxTrPui2NSL2YizsStHa_eD5Qfiw1-w_RlgnlnIfhF0-PgLrUc5Gd7I
Message-ID: <CAGsJ_4y_Ay0mYO3ic72oepjtW6KYf2sKRXEHb3Ff8uwKrOJZjQ@mail.gmail.com>
Subject: Re: [PATCH v7 7/7] mm/mglru: add tracepoint for aging
To: Ridong Chen <ridong.chen@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Dave Chinner <david@fromorbit.com>, 
	David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Muchun Song <muchun.song@linux.dev>, 
	Kairui Song <kasong@tencent.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, 
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>, Ridong Chen <chenridong@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 9:10=E2=80=AFPM Ridong Chen <ridong.chen@linux.dev> =
wrote:
>
> From: Ridong Chen <chenridong@xiaomi.com>
>
> Aging in MGLRU advances max_seq to create a new youngest generation.
> It is triggered from try_to_shrink_lruvec() when should_run_aging()
> finds that eviction is no longer possible, or that it would be better
> to age first at the current priority. There is currently no tracepoint
> on this path, so it cannot be observed when and why aging is needed.
>
> Add mm_mglru_aging, emitted in try_to_shrink_lruvec() right before
> try_to_inc_max_seq(), with the node id, memcg id, sc->priority,
> swappiness, max_seq, the anon and file min_seq, and the number of pages
> in each generation for both types, as computed by lruvec_gen_size().
>
> The reason for aging is not reported explicitly, as the logic in
> should_run_aging() may change, e.g. for imbalance-based aging. It can
> be derived from the generation window and the per-generation sizes,
> which are taken before aging, so the youngest generation is populated
> as well.
>
> The nr_anon/nr_file arrays are ordered by seq rather than by generation
> slot: entry i holds the generation max_seq - MAX_NR_GENS + 1 + i, i.e.
> they go from the oldest generation to the newest, the same order as the
> debugfs lru_gen file, so the output can be read directly without mapping
> slots back to seqs. The arrays are printed with __print_array(), so the
> output is hex and its length follows MAX_NR_GENS automatically.
>
> Only the lruvec, sc and swappiness are passed in; everything else,
> including max_seq, is read in TP_fast_assign(), so try_to_shrink_lruvec()
> does no extra work when the event is disabled. Reading max_seq there
> rather than using the caller's copy keeps the window consistent with
> the per-generation sizes read right after it, should another reclaimer
> age the lruvec in between.
>
> The event marks the aging decision, not its result: the following
> try_to_inc_max_seq() may find that aging is already in progress or
> done by another reclaimer, so concurrent reclaimers can each emit it
> for the same max_seq. Whether max_seq was advanced can be seen from the
> following mm_mglru_scan_folios.
>
> Suggested-by: Barry Song <baohua@kernel.org>
> Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
> ---

Much better now:

~ # echo 1 > /sys/kernel/tracing/events/vmscan/mm_mglru_aging/enable
~ # ./a.out
Mapped 400 MB at 0xffff98a00000
^C
~ # cat /sys/kernel/tracing/trace | grep mglru_aging
         kswapd0-49      [001] .....   104.277689: mm_mglru_aging:
nid=3D0 memcg_id=3D1 priority=3D6 swappiness=3D60 max_seq=3D3 anon_min_seq=
=3D2
file_min_seq=3D1 nr_anon=3D{0x0,0x0,0xd360,0x0}
nr_file=3D{0x0,0x23e2,0x0,0x0}
         kswapd0-49      [001] .....   104.536448: mm_mglru_aging:
nid=3D0 memcg_id=3D1 priority=3D3 swappiness=3D60 max_seq=3D4 anon_min_seq=
=3D2
file_min_seq=3D2 nr_anon=3D{0x0,0x20,0xf8bc,0x0}
nr_file=3D{0x0,0x91a,0xbd,0x0}
           a.out-79      [000] .....   104.689518: mm_mglru_aging:
nid=3D0 memcg_id=3D1 priority=3D4 swappiness=3D60 max_seq=3D5 anon_min_seq=
=3D3
file_min_seq=3D4 nr_anon=3D{0x0,0xf8a0,0x1188,0x0}
nr_file=3D{0x0,0x0,0x2,0x7}
         kswapd0-49      [001] .....   107.282038: mm_mglru_aging:
nid=3D0 memcg_id=3D1 priority=3D2 swappiness=3D60 max_seq=3D6 anon_min_seq=
=3D4
file_min_seq=3D5 nr_anon=3D{0x0,0x6c50,0xa168,0x605}
nr_file=3D{0x0,0x0,0x98,0x18}
         kswapd0-49      [001] .....   107.812598: mm_mglru_aging:
nid=3D0 memcg_id=3D1 priority=3D1 swappiness=3D60 max_seq=3D7 anon_min_seq=
=3D5
file_min_seq=3D6 nr_anon=3D{0x0,0xfe10,0x1721,0x54}
nr_file=3D{0x0,0x0,0x1a,0x3}
           a.out-79      [000] .....   108.936872: mm_mglru_aging:
nid=3D0 memcg_id=3D1 priority=3D2 swappiness=3D60 max_seq=3D8 anon_min_seq=
=3D6
file_min_seq=3D7 nr_anon=3D{0x8,0x7d29,0x8c54,0xc90}
nr_file=3D{0x0,0x0,0x4,0x2}
         kswapd0-49      [001] .....   108.937115: mm_mglru_aging:
nid=3D0 memcg_id=3D1 priority=3D2 swappiness=3D60 max_seq=3D8 anon_min_seq=
=3D6
file_min_seq=3D7 nr_anon=3D{0x0,0x7d15,0x8c94,0xcac}
nr_file=3D{0x0,0x0,0x4,0x2}
         kswapd0-49      [001] .....   109.425258: mm_mglru_aging:
nid=3D0 memcg_id=3D1 priority=3D1 swappiness=3D60 max_seq=3D9 anon_min_seq=
=3D7
file_min_seq=3D8 nr_anon=3D{0x0,0xed69,0x24bc,0x488}
nr_file=3D{0x0,0x0,0x3,0x3}

One thing that looks a bit weird, though. For example:

max_seq=3D3 anon_min_seq=3D2

We have only two generations for anon, but we print four:

nr_anon=3D{0x0,0x0,0xd360,0x0}

The two oldest generations don't actually exist. Ideally,
we would print only the two existing generations:

nr_anon=3D{0xd360,0x0}

you should be able to fix it by:

__print_array(__entry->nr_anon, __entry->max_seq -
__entry->anon_min_seq + 1 , sizeof(unsigned long)),
__print_array(__entry->nr_file, __entry->max_seq -
__entry->file_min_seq + 1, sizeof(unsigned long)))

But I guess it's fine, since the two extra entries are both
zero.

And, I personally prefer the youngest-to-oldest order,
as we usually have:

head ---------- tail

where head is young and tail is old.

Your output uses:

tail ---------- head

But anyway, I guess this is just a matter of whether we
read it from left to right or right to left. Personally, I
find it more natural to read from youngest to oldest.

If you're not tired of working on this and would like to make
a few more improvements, you could address the two issues
above. But it is up to you.

For the patch,

Reviewed-by: Barry Song <baohua@kernel.org>
