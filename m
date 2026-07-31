Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC34314B8C
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 21:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785533751; cv=none; b=SxmeUfI9vKqs/llmy3tkYp4SsdlnPJsx6hh5QHuKRW/p8FdVkUjOGtPFzM4oW6sh0xTqJnNCPJ4C2oqBALhMnlLTlnPEyxQC7QP0klE9ZppwqxYVZleLrLOvRyLQ9XO47wE6hJ8n30bgDY3QdNVKMHgXHKahtjMNjLTpoE+BPZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785533751; c=relaxed/simple;
	bh=QxnrePqaPLoSzRz+sqDQz2BYvvlCf6ACUIN+hKN7IuI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=oW95bLwOWzp+PlWMk5GRg6pfYu9VO5/oXN89SzBCkMVMrVgqXnYlsBqybpBprhFzp0MZB9soM3Bsn2BI3GZBElgiFNbpyHjzg4lCdt0DR4H69+LwOs/vs6UzNxpXljzGbuf6+Y8PFIuLPw17tmhToE9dMAVgP4/z4ixfahUfsIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=D/Jv7fkG; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="D/Jv7fkG"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso1262522a91.3
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 14:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1785533749; x=1786138549; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6U5jpj+pi4ERiis5pW2+yfhfCouzTAUf2UdZm6UKK08=;
        b=D/Jv7fkGnkCFCCgCTkd990Zt1MjqXCdKuFIToRCacdsBjWPsFauX7UaSUvhuP/qXyS
         oNXsBJbfp3R3sdY5DbElF2oXdFvaiqYTRdzHwOknBvVar3b4fidl3BREQNo3uwzYQJbJ
         oHAfgZWD/y2WNuIr5Eu9Bd3uT0wyKAGTiRlte/qRG+UMoxAc1TiHQZVKaIt8CpyLizxK
         A4rAjve92QB9G4t8eJ7aDJetVht2W74AyOdwmvy+ZED1nWE6Q0kDtd8Ut0yee1h+3tNy
         Xp6eam9NMwNxpO7yzkxMTUJgsS6as/Q42c/kpgr9BdoLe18Mt2kGnv6fbodpUjsJUqiB
         uvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785533749; x=1786138549;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6U5jpj+pi4ERiis5pW2+yfhfCouzTAUf2UdZm6UKK08=;
        b=a01h2bjLqxFlmGbjNSmyvYAXYBNcyS5tVzQBSzVzGbVztTWsmUBsy9JTMdUTvUVX5o
         7lx1fHlW6BvProN2EjV8BeBew4A4Nmq72XF3Etnd8mM98/wFB12JTJ4WLrSIgzcbL0pc
         tRV5dEJ7AQeWcjQHPduEAcfEl0LUxlTivOPVUh5pIrmnDXvkmaqW948uBoqQW0mupPBM
         uJzJ4U2xQectBflOw69FiyLpbEIDr1apWlDj1gywr+NWeUGV+ZhaLZ/eVxDUCGOPlHAy
         nvWtO7sroCvKyQlyppW+R8JY9RNWn4GW6N87MoVPKPfCBpNSYi3y4TlI9z/621lxp/bu
         Hoow==
X-Forwarded-Encrypted: i=1; AHgh+Ro5RKuPZlrAvhpccKrcJcegFel9lnJKK5bre0BPPvOhyQgMJuw9d64XL9jmLNgZbx+q/aQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJU7C9HvYECYIdzbvLXGsdax4W123hm9b4eFPrD46ZavHehItS
	sbrusuHKjIzVODLLKCV05VKUed82DYR8/8JhFOt+Ge9uQufVd8jV/Iw7ptf/9YG/0+s=
X-Gm-Gg: AR+sD11dI4T6yWH/Yl1dMFDhfUgQRsh1Q385dTO0M0r9rqvtCUpFvd3EpFffVHNA3IR
	FnTvUthBA5czqlsolh+Zxp+4YxugfSe1JFJna/mSR1JULz8rqajqiWYebwxmJ69NRQ88Fluuisp
	45+30an4199ZfkFl3Ox5YGUsIDsxQcp0YClVs8rqZJYTZ80UqMeofPJ7HIjGrhGWST595UPoVM+
	jk6z5+RFyZjZqzPIljts+tMOICzjNN46Z5VuC6fkcVBkSgd88u6kCxrCA756BuBt+GEwGjXWC91
	lbOirGwqfUIOOH7IbN54jH0ebI+i25v3QHY/Uody57LRHqKfqQr89GtWR4uX0Eu5q8HbS34gpEi
	PX+QZSf5yngWxydZlvUbL/5Z1/PPIifepeDKUH7IrD3bSHLCGXOF/VjUB2kVcFaVM2EKMNoQSvM
	Wzn6HgM6dxZ+V9P1jiQ3Rnc6CV69/6tgczCc9kpRZPc1MlMiCG7FkqXPMkxKbtdO6TIcLX9GH5x
	e8mhWdE+ddwOoOnOg==
X-Received: by 2002:a17:90b:1c91:b0:387:e0db:bc26 with SMTP id 98e67ed59e1d1-38fbc538106mr1144713a91.38.1785533749059;
        Fri, 31 Jul 2026 14:35:49 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb2b0f82csm654807a91.2.2026.07.31.14.35.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 14:35:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 31 Jul 2026 17:35:47 -0400
Message-Id: <DKD2VZQTPK2Y.33KWWQRYL8UTV@etsalapatis.com>
Subject: Re: [PATCH bpf-next v3 14/15] selftests/bpf: Test attaching
 struct_ops to a cgroup
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Amery Hung" <ameryhung@gmail.com>, <bpf@vger.kernel.org>
Cc: <netdev@vger.kernel.org>, <alexei.starovoitov@gmail.com>,
 <andrii@kernel.org>, <daniel@iogearbox.net>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@kernel.org>, <shakeel.butt@linux.dev>,
 <roman.gushchin@linux.dev>, <kuniyu@google.com>,
 <kerneljasonxing@gmail.com>, <kernel-team@meta.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260706171918.317102-1-ameryhung@gmail.com>
 <20260706171918.317102-15-ameryhung@gmail.com>
In-Reply-To: <20260706171918.317102-15-ameryhung@gmail.com>

On Mon Jul 6, 2026 at 1:19 PM EDT, Amery Hung wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> Exercise attaching the bpf_tcp_ops struct_ops to cgroups via the generic
> cgroup link infrastructure. The struct_ops instances record their
> execution order and the previous return value to validate correctness.
>
> Subtests:
> - query:        BPF_F_QUERY_EFFECTIVE and attached query return the maps
> - order:        BPF_F_PREORDER vs attach order within a cgroup
> - before_after: BPF_F_BEFORE/BPF_F_AFTER relative positioning
> - update:       bpf_link__update_map swaps a link's map, keeping its slot
> - retval:       int return value chained across timeout_init progs of
>                 multiple bpf_tcp_ops attached to a cgroup
> - hierarchy:    parent and child attachments merge in the child's
>                 effective array (descendant before ancestor)
> - inherit:      a child created after the attach inherits the parent's
>                 prog
>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  .../selftests/bpf/prog_tests/bpf_tcp_ops.c    | 560 ++++++++++++++++++
>  .../testing/selftests/bpf/progs/bpf_tcp_ops.c | 141 +++++
>  2 files changed, 701 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops.c
>  create mode 100644 tools/testing/selftests/bpf/progs/bpf_tcp_ops.c
>

<SNIP>

> +static void test_query(int cgroup_fd, struct bpf_tcp_ops *skel)
> +{
> +	struct bpf_map_info info =3D {};
> +	__u32 info_len =3D sizeof(info);
> +	LIBBPF_OPTS(bpf_prog_query_opts, query_opts);
> +	struct bpf_link *link1 =3D NULL, *link2 =3D NULL;
> +	__u32 map1_id, map2_id, map_ids[2] =3D {};
> +	__s32 type_id;
> +
> +	type_id =3D get_bpf_tcp_ops_type_id();
> +	if (type_id <=3D 0)
> +		return;
> +
> +	bpf_map_get_info_by_fd(bpf_map__fd(skel->maps.tcp_ops1), &info, &info_l=
en);
> +	map1_id =3D info.id;
> +
> +	bpf_map_get_info_by_fd(bpf_map__fd(skel->maps.tcp_ops2), &info, &info_l=
en);
> +	map2_id =3D info.id;
> +

Maybe attach with BPF_F_BEFORE to make sure queries for attachment and effe=
tive order
are different?


> +	link1 =3D bpf_map__attach_cgroup_opts(skel->maps.tcp_ops1, cgroup_fd, N=
ULL);
> +	if (!ASSERT_OK_PTR(link1, "attach_ops1"))
> +		goto done;
> +
> +	link2 =3D bpf_map__attach_cgroup_opts(skel->maps.tcp_ops2, cgroup_fd, N=
ULL);
> +	if (!ASSERT_OK_PTR(link2, "attach_ops2"))
> +		goto done;

<SNIP>
