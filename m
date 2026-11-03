Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793688523;
	b=0uBIJZYccbZ0wuPGM3smRfC0vSCA27WkGeQ+M3/nvmQgQmk4cXpVFyhHYDEx8xh/r36Y
	 slt8tCY/Qo83YeiA5xd0l4mRbXti1bsIqQ+BgRcGVaWKzz8exD3EHIFfSUpM6mmkqG56C
	 bQuRzH05AoucplpSymWwvfpSHb9ahmaeXiPhTOrzHUuo4yu4AGdnQTMwpmvQMhrdbyVzQ
	 2X1qdf6ta0QzJYDmPPcM33CDOyxR+nBdFENwSxtlM/Ev65oupEZ2uTrbOA8sFgRz9o4xj
	 nez0JSPUzmlah+PpZwrWhAkgTyRugJoEjBUz/swOP+AtQrI3hY+v976USUD5ws6lT/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793688523;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=47gVMNE2szA456na8yleBIvHosW+wgwadu3yBUGMAhw=;
	b=S2XNgOEHnIc5Ks17sCzUIPcCWkdM8nCex+egXdz2pB9kwMj10vg4Vkl6iKCqERpyIE7X
	 MvoQf12YdUquul5eE0puG1sZ+d3WXox+UCs9F/qjtBQ2oeQ+ODkyMznQxUg2+qMXAyJRq
	 kI3pvCeDLCexEzcbPOqvR+KFY7NqYa91qlEV+1Fc6jRVkB7LYWPD0YW1+N0nCIKc1aIJ3
	 +CEBrlt84OPET+H/KDGuQsfd7IIOERvnlRTsx8MJNd/VIsmLfoStvXgNV503pXMdxGCM0
	 e4dyDTskLw5+tOnY313Y4cjTp9MaSUFnlz2n8i6pK3e+TCXQAulivwLbapRKwzhPAWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PCXHJlLx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C66606A32C
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 06:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PCXHJlLx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3EE31F00919
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 06:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793688522;
	bh=47gVMNE2szA456na8yleBIvHosW+wgwadu3yBUGMAhw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PCXHJlLx5uT56I3g2/299SMhwphQgkeJYW0rwrP1IMJM6akhAulBEQfoHh3VWV4xt
	 U0ZcdcUBR3fic8CzRDhJOCn42qoqXRkoYBFAPjvFubsywIy1mQJJYPhR+2QMWhX3H/
	 NcT8Kn1k86ZutxegRMnWH1vTBbHmilczKGpffIL282zNGISD/Qe+Uy5f1dEoVD4oky
	 X/kkT2+y3+vWiKRmlMJ3TE3QZ8R5gBDYl2jAh7abWtOFU1ecZkW801ThldTB8Xijze
	 CxdEYu4adfyo+TwF3Vc5QNP4FZF/YppvW+3ZF9+SPuqdS2liHpz41EMnWURyK5t0Un
	 EqqwDUsXvhPrQ==
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-945ae2daa68so47924685a.1
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 22:48:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzFSxkqnEerlSQ0hAD1HRWUUqD9S3SRKt/GiEhcKEx+JDTeZZUkAVaA3Pmnet/FfnWKg68=@vger.kernel.org
X-Gm-Message-State: APuU4Z+LG2FMjKrp1QQmLf9sdrP3UK5cGsC7kDXrbqdQW8AvTJ4QSkLN
	2UflZOVsKy++YxZGiaCU3RYJoRqy7edEItDIBDx6y3jkaYexMtu8VMKUhX+nNhHYAl1YLlO4OJP
	LeaeCHveAiuCmDXWepgx148EehJL5L4I=
X-Received: by 2002:a05:620a:6013:b0:93e:5de7:fd45 with SMTP id
 af79cd13be357-94413382637mr2049169685a.18.1793688522192; Mon, 02 Nov 2026
 22:48:42 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103025610.3738894-1-ridong.chen@linux.dev> <20261103025610.3738894-8-ridong.chen@linux.dev>
In-Reply-To: <20261103025610.3738894-8-ridong.chen@linux.dev>
From: Barry Song <baohua@kernel.org>
Date: Tue, 3 Nov 2026 14:48:30 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4xCTSctcPcC7X6Dx4zYaOycaPqs0DG7AaxB55wx1Afwpg@mail.gmail.com>
X-Gm-Features: AclHuK9iw40Xx1JKG7xg0GhepEe64uIgtchPvP4-nxYEY5aIoWWOik_yiFOewsU
Message-ID: <CAGsJ_4xCTSctcPcC7X6Dx4zYaOycaPqs0DG7AaxB55wx1Afwpg@mail.gmail.com>
Subject: Re: [PATCH v6 7/7] mm/mglru: add tracepoint for inc_max_seq()
To: Ridong Chen <ridong.chen@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Dave Chinner <david@fromorbit.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Muchun Song <muchun.song@linux.dev>, 
	Qi Zheng <qi.zheng@linux.dev>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>, Ridong Chen <chenridong@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 10:58=E2=80=AFAM Ridong Chen <ridong.chen@linux.dev>=
 wrote:
>
> From: Ridong Chen <chenridong@xiaomi.com>
>
> Aging in MGLRU advances max_seq via inc_max_seq(), creating a new
> youngest generation. There is currently no tracepoint on this path, so
> the moment a new generation is created, and how the min_seq of each type
> trails behind it, cannot be observed as it happens.

We might be more interested in why aging is triggered rather
than the exact moment when max_seq is advanced.

With your patch, we get:

~ # cat /sys/kernel/tracing/trace | grep mglru_inc_max_seq
           a.out-93      [001] d..1.   278.276539:
mm_mglru_inc_max_seq: nid=3D0 memcg_id=3D1 max_seq=3D4 anon_min_seq=3D2
file_min_seq=3D1 nr_anon=3D{0x0,0xf016,0x12,0x0}
nr_file=3D{0x1886,0xb,0x4c,0x0}
         kswapd0-50      [000] d..1.   278.422400:
mm_mglru_inc_max_seq: nid=3D0 memcg_id=3D1 max_seq=3D5 anon_min_seq=3D2
file_min_seq=3D2 nr_anon=3D{0x5,0xccb6,0x3439,0x0}
nr_file=3D{0x4ae,0x4f,0x55,0x0}
         kswapd0-50      [000] d..1.   278.508003:
mm_mglru_inc_max_seq: nid=3D0 memcg_id=3D1 max_seq=3D6 anon_min_seq=3D3
file_min_seq=3D4 nr_anon=3D{0xccb6,0x3d29,0x1,0x0}
nr_file=3D{0x0,0x59,0x7,0x0}
         kswapd0-50      [000] d..1.   280.046056:
mm_mglru_inc_max_seq: nid=3D0 memcg_id=3D1 max_seq=3D7 anon_min_seq=3D4
file_min_seq=3D5 nr_anon=3D{0x3bf3,0xcbbd,0x23e,0x0}
nr_file=3D{0x0,0xb,0x1,0x0}
         kswapd0-50      [000] d..1.   280.124876:
mm_mglru_inc_max_seq: nid=3D0 memcg_id=3D1 max_seq=3D8 anon_min_seq=3D5
file_min_seq=3D6 nr_anon=3D{0xcafd,0x3e31,0x0,0x0}
nr_file=3D{0x0,0x5,0x7,0x0}
           a.out-96      [001] d..1.   290.629014:
mm_mglru_inc_max_seq: nid=3D0 memcg_id=3D1 max_seq=3D9 anon_min_seq=3D7
file_min_seq=3D6 nr_anon=3D{0x0,0x10615,0xb,0x0}
nr_file=3D{0x331,0xb,0x9a,0x0}
         kswapd0-50      [000] d..1.   290.653098:
mm_mglru_inc_max_seq: nid=3D0 memcg_id=3D1 max_seq=3D10 anon_min_seq=3D7
file_min_seq=3D7 nr_anon=3D{0x15,0xef23,0x18c4,0x0}
nr_file=3D{0xb,0xb8,0x55,0x0}
           a.out-96      [001] d..1.   290.684875:
mm_mglru_inc_max_seq: nid=3D0 memcg_id=3D1 max_seq=3D11 anon_min_seq=3D8
file_min_seq=3D9 nr_anon=3D{0xeee3,0x1afb,0x2,0x0}
nr_file=3D{0x0,0x76,0x4,0x0}

You can see that the youngest generation is always zero,
because you're just getting the newly added youngest
generation :-)

This somehow suggests that the information is redundant, as
there is always a zero there.

I suspect we'll need an additional tracepoint to show why
aging is triggered and at what sc->priority it happens.

But do you know why you trace the moment just after aging
is completed, rather than the reason why aging is needed?

Best,
Regards
