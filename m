Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792880658;
	b=kD4zLWY1NL2Y91drso5UDuj/YSgRoRh1RhWGyPp/e9s2VVJXYb58wsWxIZl8vD3xZQ5d
	 83y1gXcuvGIHHxQH1Dn2KT9y8cmVgiFcE0+PwyHKqAPvhrEQuT16N4AwhD62fC3V4OK3V
	 SZhCO5JZdwzgNJCZ4gQu8VsRsD1AEAipHKZDFV9hvppImcV7/dkv3a/ihLhvaYMHO1K1r
	 vqddE1Z3C1p5qq8fM1E6Fe7QEZgZEeBYfNlvP0DvavtqyNG8qJ6tT7Yt8gYFFIneAPISH
	 oHqdpS5e9vaFw1uCf5AeA04aduafgQcCxI84NRhMaDufN1NbMZlBIPqtSuLElTzIelA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792880658;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ZO95lvl9Nqr2fnKfjhNvY3odHppkPAvE0sy9YV0MAyE=;
	b=5kF69BAgSsVZRsECZIDxo0wMxtMWEEdDcmH4Haw+Z+ueGbFLqxwSOAciLH91zpce50X+
	 3CwA1yheI+9GY/gJZGDJOpGrM+Fh2hLITvJAfwlGPUpTJJe77a6vrRrom0mHy3ktAoJcR
	 CmPcZPzy7od5ivK9YOevFbwlZf4FVgwbbYE4beiZ2KJAcuasC1ll6RT4hMMLF2diCL6br
	 e9yyj2Tx1IE4JfKpus8mHZXsVNaTmB7GHhIMrehsN2Z4JT1AWNDT62NfqvQG3U/lIe0W3
	 6MNP5XQvpJdD/6qotBVhE7dIGGzZ+mLRvHbK56wRwmG9T9OjCncpV2pEZsTV+onecYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DcwlgpnI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F273F606A31D
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 22:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DcwlgpnI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD77A1F031EA
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 22:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792880657;
	bh=ZO95lvl9Nqr2fnKfjhNvY3odHppkPAvE0sy9YV0MAyE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DcwlgpnI8DL+2mapwB28c0Uuo/uZkOQbIkpHc/v1SllyC8AnQiHsey8hJ4aUWdbT4
	 prMadH1kOhGswoIzNgX1P+u7U3KoTwqUBcWHh2XYWZ5bxDbPXCFaxmk+P2urzWr1Rm
	 tN/5ED+hsmoVE+0QG0XA0UDNI4BCf1ZefiXFb5Qd5/jU4/xxPiEDB4jLllmx0hbm3K
	 EN3bqey/NcRl3d0IV+S3TGGgleI5BqCIn+v74y01Z2wbeUWXGv7IvSemJyMiXrTytO
	 jmFrvEKOiSx/o2gKOwmTm2S066vyIZyZSIob0mQDj8qkp6Et+Vy3xhiiFLqwSXFeD6
	 V70By5SJLar2w==
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-917ad52d7b6so18811136d6.2
        for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 15:24:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByUlIwq+P2mNX0ylAmep2qzjzefDwx6AJQI7tOcpDGJkqZVCXG4tfSltc3uYJBnMnY3Xpg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIodpIm1735tC+KeWQj/UcQP7c1Pfpd3Y6vWyNN+oC44JIftGdw
	x4kqHAQqmIXeZ77mpEGGA2xM2rNU3R39f55DEnc9KtZGEfyCRyio4QF/pUySKZD0bH6L0oEf/nb
	Ltj4k8DJ6i4D3w/yeqtvmNxnhEK9vFPQ=
X-Received: by 2002:a05:620a:2616:b0:93e:c06a:7313 with SMTP id
 af79cd13be357-940ef914186mr385330485a.13.1792880657009; Sat, 24 Oct 2026
 15:24:17 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019034426.2354049-1-ridong.chen@linux.dev> <20261019042308.2372396-2-ridong.chen@linux.dev>
In-Reply-To: <20261019042308.2372396-2-ridong.chen@linux.dev>
From: Barry Song <baohua@kernel.org>
Date: Sun, 25 Oct 2026 06:24:06 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4z7u_PtSkjm+kH7JX_ZZDLSnGr1teHq6By0ovgB23O8_w@mail.gmail.com>
X-Gm-Features: AclHuK9i0KBXAHQuNAppLi1kJlXPAo77Un_nGJoXjbM4tmAAAAcT3v5pEG65SEY
Message-ID: <CAGsJ_4z7u_PtSkjm+kH7JX_ZZDLSnGr1teHq6By0ovgB23O8_w@mail.gmail.com>
Subject: Re: [PATCH v4 7/9] mm/vmscan: pass scan_control to mm_vmscan_balance_pgdat_end
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
	linux-mm@kvack.org, cgroups@vger.kernel.org, bpf@vger.kernel.org, 
	Ridong Chen <chenridong@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 12:24=E2=80=AFPM Ridong Chen <ridong.chen@linux.dev=
> wrote:
>
> From: Ridong Chen <chenridong@xiaomi.com>
>
> balance_pgdat() passes sc.order and sc.nr_reclaimed to
> mm_vmscan_balance_pgdat_end as bare arguments. Pass the enclosing
> struct scan_control instead and read the fields out in TP_fast_assign,
> consistent with the other reclaim tracepoints. highest_zoneidx stays a
> separate argument: it is a balance_pgdat() parameter, and
> sc.reclaim_idx may differ from it by the time the end event fires.
>
> No functional change. The tracefs event format (TP_STRUCT__entry and
> TP_printk) is unchanged, so tracefs-based consumers are unaffected.
> BPF programs attached via raw_tp/tp_btf see the new TP_PROTO and need
> to be adjusted; tracepoints are not a stable ABI (see
> Documentation/bpf/bpf_design_QA.rst).
>
> Assisted-by: LLM
> Signed-off-by: Ridong Chen <chenridong@xiaomi.com>

Could we combine patches 4=E2=80=937 into a single patch? The changes
seem a bit too scattered across separate patches.

Best Regards
Barry
