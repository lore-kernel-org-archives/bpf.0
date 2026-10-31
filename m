Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793481700;
	b=KNoqdP3HA4EC4BNWDvfbf6vu5SqJb/8MeEkLq+46Qz9rg0MNvPPxf+RTfNKdlT6KHrbx
	 TfG7/G4r8j9CBehZutnSMMvVWxh9DgtZb8jxNCvj90dqCVDZjBIsfxzWfLN+6NYaXoeEJ
	 p9ofR1UFewNsAvIEvxGZud0Xo1WMGNEunIi72pDKsNPwLuBtMmAY8ri13d/4DDTNut1Hb
	 F8w5igEBGYNd90nTo8VH999U95oq+/fSsGcnxbNIxy+3z/oNH0PQO6cBBEOfTmdgPJOHE
	 Pwuf9M2sFO85xymt9PjjBShS9vdBnKL5hlefzFxJHdrqT0g+zFCiDIvDYHOlG4CcDyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793481700;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ty94gSbhmDD5BIMgrsH4AK83dBi7LvnXvW0bmqOEn6Q=;
	b=vEpmOt/TbO9ZSTbVvTw3bZn1pt+dOnZxKyzE65Fzxi8DqCQJIoN2Vk6mdHHL49ttxVW7
	 4BvL9StJO5juaWJhVeHX/hAcLf5iHe6SDUUapMznFFVGr70IVUB5sDFvWzUvGMJ0F2U2n
	 +NGHS3d9wuf9Hn0CLAc51JX/JyzGMECx8xgyig+hf2NHRft7XOrhB0EeUnR5jjl2ztQzN
	 08ryFVtb/MZvhE8KvCHpJB87yPjXf9n8fkx5brBcgPeBaLp2vySoxrMQOXl/uTtoWbDqW
	 4xrEfWC5UDAPHlegcywXlUB74EQqdeQyUonJhG3Z4eoDMaBqLpFfFzgov9UqyBxL7GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nv0K1geW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8DD606A31C
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 21:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nv0K1geW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D439C1F00A1A
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 21:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793481699;
	bh=ty94gSbhmDD5BIMgrsH4AK83dBi7LvnXvW0bmqOEn6Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Nv0K1geWEW21EP+164tZ9ZkJwnFe5As405lOGWO05ZYOg7Lx1i0lmjU6Jao8qCyQN
	 6kkf86pcNxo+ywvYPj/rGZsWRf2MvqsJhX0nC5iDudHzpU5LqtDe5A1F3HPiGUNfuA
	 JaYI205jkw6gNuzTRwyhonMiz41vd3QmhBZRPfMkgoPHlFN6SKGKDPF9Y28Se0elkA
	 8bFMZB5SOE/Ny2FWsDfPWdDLl5BjKKJilm6NBMqz966pnvFjTio5w0uqC2dtoMPEWT
	 ott9wyW7S7gZPTyupY7DCxiVQVwg6XHctY5+AOUqjVKUb+QGQwCNA7hxm5IKr/ulxd
	 zjgRTUm2h8X+w==
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93f3c89594cso122279085a.2
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 14:21:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxHWco4/vwig1Y0C8YM+KPmhu9nPmWkPGbkFc86iZBNGD6Cy6wILh72Ohd5wC7dIW/LSsg=@vger.kernel.org
X-Gm-Message-State: AFq9FYI9kWJ4RDuESuhz3ikATiYlTzCNytB4seKx5vpt3V857CTM7aO5
	5LAOAigKndxu+T0wNxOl0saw51NMnmDTdYb4MDLOTtzQOCgKf2iq+SdRcwRd+gV+AI1/oBYh2bO
	q+RDcRQM3TCZIMN4CKMWYUyjnwjHMEjk=
X-Received: by 2002:a05:620a:1a04:b0:93e:7939:acd0 with SMTP id
 af79cd13be357-944216bd289mr1066244785a.37.1793481699158; Sat, 31 Oct 2026
 14:21:39 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031090041.58574-1-ridong.chen@linux.dev> <20261031090041.58574-7-ridong.chen@linux.dev>
In-Reply-To: <20261031090041.58574-7-ridong.chen@linux.dev>
From: Barry Song <baohua@kernel.org>
Date: Sun, 1 Nov 2026 05:21:27 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zUbkFXBhAesVV74-Ndga5f6xEbestK7Qinqddip8xBrw@mail.gmail.com>
X-Gm-Features: AclHuK9WNH9aLICSgSeVZV5too_5MSDmgtyvPVk6Q01fvL_ZF8MPvPlJAdKgm4w
Message-ID: <CAGsJ_4zUbkFXBhAesVV74-Ndga5f6xEbestK7Qinqddip8xBrw@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] mm/mglru: add tracepoint for inc_max_seq()
To: Ridong Chen <ridong.chen@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Dave Chinner <david@fromorbit.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Muchun Song <muchun.song@linux.dev>, 
	Qi Zheng <qi.zheng@linux.dev>, Kairui Song <kasong@tencent.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, 
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>, Ridong Chen <chenridong@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 5:02=E2=80=AFPM Ridong Chen <ridong.chen@linux.dev>=
 wrote:
>
> From: Ridong Chen <chenridong@xiaomi.com>
>
> Aging in MGLRU advances max_seq via inc_max_seq(), creating a new
> youngest generation. There is currently no tracepoint on this path, so
> the moment a new generation is created, and how the min_seq of each type
> trails behind it, cannot be observed as it happens.
>
> Add mm_mglru_inc_max_seq, emitted right after max_seq is bumped while
> the lruvec lock is still held, with the node id, memcg id, the new
> max_seq, the anon and file min_seq, and the number of pages in each
> generation for both types, summed over zones and clamped to >=3D 0 the
> same way the debugfs lru_gen file reports them. The nr_anon/nr_file
> arrays are indexed by generation slot, so the emitted max_seq/min_seq
> say which slot holds which seq. They are printed with __print_array(),
> so the output is hex and its length follows MAX_NR_GENS automatically.
>
> Only the lruvec is passed in; all of the above is collected in
> TP_fast_assign(), so inc_max_seq() does no extra work when the event is
> disabled. Paired with mm_mglru_scan_folios it makes the full
> aging-to-eviction window observable per memcg.
>
> Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
> ---
>  mm/trace_vmscan.h | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  mm/vmscan.c       |  2 ++
>  2 files changed, 49 insertions(+)
>
> diff --git a/mm/trace_vmscan.h b/mm/trace_vmscan.h
> index 8148b8224422..cddf42b5849a 100644
> --- a/mm/trace_vmscan.h
> +++ b/mm/trace_vmscan.h
> @@ -456,6 +456,53 @@ TRACE_EVENT(mm_mglru_scan_folios,
>                 __entry->min_seq)
>  );
>
> +TRACE_EVENT(mm_mglru_inc_max_seq,
> +
> +       TP_PROTO(struct lruvec *lruvec),
> +
> +       TP_ARGS(lruvec),
> +
> +       TP_STRUCT__entry(
> +               __field(u64, memcg_id)
> +               __field(unsigned long, max_seq)
> +               __field(unsigned long, anon_min_seq)
> +               __field(unsigned long, file_min_seq)
> +               __array(unsigned long, nr_anon, MAX_NR_GENS)
> +               __array(unsigned long, nr_file, MAX_NR_GENS)
> +               __field(int, nid)
> +       ),
> +
> +       TP_fast_assign(
> +               struct lru_gen_folio *lrugen =3D &lruvec->lrugen;
> +               int gen, zone;
> +
> +               __entry->memcg_id =3D mem_cgroup_id(lruvec_memcg(lruvec))=
;
> +               __entry->max_seq =3D lrugen->max_seq;
> +               __entry->anon_min_seq =3D lrugen->min_seq[LRU_GEN_ANON];
> +               __entry->file_min_seq =3D lrugen->min_seq[LRU_GEN_FILE];
> +               /* summed over zones and clamped to >=3D 0, as debugfs lr=
u_gen does */
> +               for (gen =3D 0; gen < MAX_NR_GENS; gen++) {
> +                       __entry->nr_anon[gen] =3D 0;
> +                       __entry->nr_file[gen] =3D 0;
> +                       for (zone =3D 0; zone < MAX_NR_ZONES; zone++) {
> +                               __entry->nr_anon[gen] +=3D
> +                                       max(lrugen->nr_pages[gen][LRU_GEN=
_ANON][zone], 0L);
> +                               __entry->nr_file[gen] +=3D
> +                                       max(lrugen->nr_pages[gen][LRU_GEN=
_FILE][zone], 0L);
> +                       }
> +               }

I feel this is wrong. Can we calculate the newest and
oldest generations from seq, then print them in order
from newest to oldest?

The nr_pages[] array isn't ordered from newest to
oldest or vice versa, as we have:

static inline int lru_gen_from_seq(unsigned long seq)
{
        return seq % MAX_NR_GENS;
}

And I added a helper here:
https://lore.kernel.org/linux-mm/20261022220203.91911-11-baohua@kernel.org/

+static inline unsigned long lruvec_gen_size(struct lru_gen_folio *lrugen,
+ int type, unsigned long seq)
+{
+     int gen =3D lru_gen_from_seq(seq);
+     unsigned long size =3D 0;
+
+     for (int zone =3D 0; zone < MAX_NR_ZONES; zone++)
+          size +=3D max(READ_ONCE(lrugen->nr_pages[gen][type][zone]), 0L);
+     return size;
+}

Maybe you could port it here as a separate patch so it
can land earlier as part of your tracepoints series. We
could then use it in the next version of the swappiness
series.

Best,
Barry
