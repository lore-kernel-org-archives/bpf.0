Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795560797;
	b=XaEqjMjnnrhMGESYjBFEdOa/9z7vPX2qCHwN4BC8q6wgvdGxUrINUqBf7+F09nl8QAfJ
	 Zm4nKAP92BlapO7zjbkxJnBAvRqHg5kpSGaF7j0faNjQI9nAnO17gTOUbcPROU8e01zeP
	 tGlxai694UyVG1byJQdzTAbrwpI4aPruUn7zXirAmwQlrrNqUP9Q5ExlachiUOFZNJv2B
	 IJFGBoIjybM/5q94qQJ203+8VX9bDnQapf3Q4MTcQOWYY+c+U6R2wwJ9UrQPwgyoD122V
	 xJjtJzcDnE2NAhIN1nQG/lBN9TXRLi4MkUtorrnj138dtTTiz1LSUKtoasUWuaFWRxA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795560797;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=62HWMZceS0oj2mWZkMmwxpsPh7opOIuDf/S593U+xIc=;
	b=q0+rVKqZKr3JEfT7J0utTSoesrUDpSt+4VFnHFX8eJsiT/hbJ+iz9ln3Acv58LbSmWCb
	 XUwCn78pVcHassJdeTxiedul+A9qlEbb6NHWxT/pDCC7hkUVyPwL4VBpqC4Os87GEfQAq
	 MneqF8Hgnk3GNegyNTMsF6Bm/o6DDj3DiaNx4mrJwkSmtROEnZE9w9+S00J84QNAU0ujM
	 GLixDIjrKzSlwvL9e5Xw0hEKa1y0uswhlpv2MMwPTwolgDPLPV+IqDp5HV+7wKObKSp5I
	 nMAcVQRNvHWe9mSlELp9TCs1ISQJXQRUS/6zxSxL3iIr4EqH4D5OLWbQK3KaCWMJQxg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="eg/IgmbO";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E00B606A323
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 22:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E00B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eg/IgmbO
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4a357b1c649so2982285f8f.3
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 14:53:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795560795; cv=none;
        d=google.com; s=arc-20260327;
        b=cAtex6C8FWeZxnHoACgsg6+ZU+DNqSnK6L/RiAq9+WlJcVaseg0SZfMPMPybCDToH2
         UfUcIvAR91svTP4FLufc0qs7dKQGe5t+2D0JP1ZQOkOIARWHchJ5MJEXNlrPtVTBXMSk
         4RzIvFghFJy4pM1CmH7jjX6VD4dxqo9Jd2sFBTxAknoim5FrfHghjl0dFwNWNXa9ySsu
         PExTHciIjykOhLxB2ISoigaCgaLE3L0i+uB6d5+njmnLHyl9IOlUzDcqErzYTWBYQS69
         z+YLBxOt9GJn3dw5lXKWmArXrhpfzv58Ua+vr5iEiseG7y5gKD4kOpNf9uin7UpdhE0W
         HPvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=62HWMZceS0oj2mWZkMmwxpsPh7opOIuDf/S593U+xIc=;
        fh=pBZbmPu/eys1xD/H153vvenhDishTojuUTq7JvehYwE=;
        b=FaVYLMv9vOlEbCYd3KM5rf6tJfK6jp8f+rCmi9Twg5vKDpBBKeU/6zc9ZvZLxwJMcy
         kcl4bJODHfBSCTf//OkQFtHObkXUvUGoQkxizg9sz/ULVIaVtdNXQYHACIR2F9aeclpj
         IDtSe11bvdCljktyJNxjqv3T4ArFPqSHP4hTv139/+EhpCxF43+KVVjwM7sCDrd1WDBO
         1dGUuvvpwVXiBnuGdVCjzKeHudg3uVEGpoOC3t4kcRM3kwmzimt0S50QinX1ihMJnqYy
         s/1ao7WMXCrGubB66UGCJTktBVdXfCP8y/eBCPHOZbzWg5LJq9SPbHD3WCX4ind7RDyl
         vL5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795560795; x=1796165595; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=62HWMZceS0oj2mWZkMmwxpsPh7opOIuDf/S593U+xIc=;
        b=eg/IgmbOUIL5XFulzKaucwNquvnAFFcfhp7IZRMcZKafqJp/N4iOqBDcNsT9awfSh5
         zq8qtXnDuUxTduI+jySzh7O5jdYNXeZIBVqkwsjm2fWuzsVX9vobAUtyGJ+w4b5USJkt
         TAqoppZAsgGdRbwnk+jNh0S0tBCySM55U6uU7FCDXTW3xw9pM1x+/7VaohrXX8sAYOm7
         dRIz7XmWM5I+V0rYPZdpGKZlajpimaX9sOZKOQ2xf7bxnIf5/EhOYN/gCg2lOVswLfQM
         seA6eES0PUy5Jpp72JEsY/2PrmRLI2up+fDvfGqpmsp7rhOxLqOXIdhHm42Vo74TAqgj
         2jkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795560795; x=1796165595;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=62HWMZceS0oj2mWZkMmwxpsPh7opOIuDf/S593U+xIc=;
        b=fQc9HRRN/F2fd36huQ11gPiRw0CQ83rB7jxG+VIt6IJHhcQPqpapXNkqPSUSgvnlmF
         vDyOVIYcHso7rj0duHMNP1E8eRYoMsYQcQ+Gj+R/eSiCWXX66U/nfrUPp4SvtBXzHy89
         yUo4+SVxsP4453LRk3JVZPc4b+xPLCUZSgl2tyqsOhYmsxjaewuRELqs+t7jUl7QllHz
         C2Va9xbW7Sku+24tuc4+nG41ybf7WaWutTH6mpr4yJfqBq/UQNtP/y6qo2piFJ8t6mj0
         uUCDFdBSaRJ8HnXda5jXT2Ern+M5LJVThe4GkmMMV1rJC7wwJesyT3wkc370RA9e3aHp
         NxHA==
X-Forwarded-Encrypted: i=1; AL+hErFv/PQ6k1CdEjQUR3K0hpBz+ZPt/zGxIHKi7AWv9t1o0ilYcG0hxuaTzxyvHcwl+pW8nmE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/mihaTR8c1BIsua91BEm5IdFZf02xFnXshhbxgcjxCEnHWecV+
	KwZpqybyWe0wramrLwIk5BaKBW997aoKKgAS7BWO2rFQ9aU935gEZuacQDz7rZEOqC320lkaQpx
	s+06+1s/xnuctggnaYd6L71yG/4QK6MU=
X-Gm-Gg: AZFdTZf59eb7urZpQNZlO7R7DjGM2QN8pT5jUxEjqf8NW4NaalQ4ARo2+0K4Yk4Tf54
	1RVKcvy1pa0ClHPAvNoJhGSSLc2aPyouahjBeP9SU3odeGlDGspxMi0TfRRE6VV9DruG6aWZrzI
	ibfBATM33btMQMF75bnAH7+d/Vat+adq6KoO6SgErEPEhDBR2/Orh0SzANqP6Tm6qW37WmcZI08
	cVyQYnoS22lCKAes6t6B9zskTaN9W/1AAvsWj2rnMD7CfgebdPM9dzKKHfIvPdKb6I06HeeUKrF
	Zkw+Fn5nzf1+UYTVniR8cdQy5lbk1ipxh4qcz2qB6KCOCaILCXGNcq7PwXEilafVIS049Tke5bm
	FiqYc3qxGpFMS0vOE9NyDhqvVCymq0lust3lWq2VDsLgpGsg/HJCYR5syr+wB9oQp5bef98Ghn6
	qh0J3Pvo3GdyzOljqspZ0osjmfOLvZDeb0tIzeA1k=
X-Received: by 2002:a05:6000:491b:b0:490:9fe2:6a2d with SMTP id
 ffacd0b85a97d-4abb0a710c2mr29944554f8f.26.1795560795520; Tue, 24 Nov 2026
 14:53:15 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124224811.16134-1-ihor.solodrai@linux.dev>
 <20261124224811.16134-2-ihor.solodrai@linux.dev> <10ad779b-708b-4b0b-b6af-54f3d7414f82@linux.dev>
In-Reply-To: <10ad779b-708b-4b0b-b6af-54f3d7414f82@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 24 Nov 2026 14:53:03 -0800
X-Gm-Features: Aa3M54rYfCcMSZKLBapkSyA5aPNL8Tahfm5y46F16UVYrsj2TNZk7O-pDyWMN8o
Message-ID: <CAEf4Bzbn5Wk6q3MWpryLSZtFaPq3tGh+kfuWQGTSv8joE996vQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/6] libbpf: Separate interfaces shared with
 in-tree tools
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>, Song Liu <song@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 2:50=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> On 2026-11-24 3:48 p.m., Ihor Solodrai wrote:
> > resolve_btfids and bpftool link libbpf statically and use some of its
> > internal helpers from libbpf_internal.h. That header also defines
> > logging macros and poisons kernel integer typedefs, so resolve_btfids
> > wraps the SHA-256 helper in a separate source file.
> >
> > Move the declarations these tools use to libbpf_tools.h and include it
> > instead of libbpf_internal.h. The header is for in-tree tools and stays
> > uninstalled. No shared-library symbols change.
> >
> > No functional change.
>
> I posted v3 with the refactoring as described in my comment [1].
>
> However now I'm thinking it might be an overkill. With the re-design
> vs v1, resolve_btfids now only needs btf_kfunc_proto_match(), if it
> includes relo_core.h, so the new libbpf_tools.h is not as appealing.
>
> Speaking of "API levels", libbpf_internal.h has already been
> functioning as the "in-tree users only", and there is another special
> user among those: the selftests (see paste below). So if v3 is landed
> as posted, we now have two "levels" of in-tree users.
>
> It's... fine, but not exciting. Adding libbpf_tools.h doesn't help
> that much, and dropping it doesn't hurt. It's all bikeshedding, not
> directly relevant to the series, ultimately caused by name collisions
> between resolve_btfids and libbpf (u32 poisoning and pr_* macros).
>
> Quentin, Andrii, Eduard, please let me know if anyone has a strong
> preference here, I'm happy to respin. Thanks!
>

heh, we raced to the minute. I don't like libbpf_tools.h approach, if
GCC poison is a problem I'd rather guard that.

don't respin just yet, let Eduard do a pass at least


> [1]
> https://lore.kernel.org/bpf/faecfef3-ac9f-41be-8bc3-83a66572066a@linux.de=
v/
>
> $ grep -rl --include=3D"*.[ch]" 'include.*libbpf_internal.h'
> tools/testing/selftests/bpf
> tools/testing/selftests/bpf/prog_tests/bpf_obj_pinning.c
> tools/testing/selftests/bpf/prog_tests/btf_field_iter.c
> tools/testing/selftests/bpf/prog_tests/btf_sanitize.c
> tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
> tools/testing/selftests/bpf/prog_tests/cpu_mask.c
> tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> tools/testing/selftests/bpf/prog_tests/get_smp_processor_id.c
> tools/testing/selftests/bpf/prog_tests/global_data_init.c
> tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> tools/testing/selftests/bpf/prog_tests/kprobe_multi_testmod_test.c
> tools/testing/selftests/bpf/prog_tests/module_fentry_shadow.c
> tools/testing/selftests/bpf/prog_tests/perf_branches.c
> tools/testing/selftests/bpf/prog_tests/perf_buffer.c
> tools/testing/selftests/bpf/prog_tests/raw_tp_test_run.c
> tools/testing/selftests/bpf/prog_tests/recursive_attach.c
> tools/testing/selftests/bpf/prog_tests/sha256.c
> tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
> tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> tools/testing/selftests/bpf/prog_tests/signed_loader.c
> tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> tools/testing/selftests/bpf/urandom_read.c
> tools/testing/selftests/bpf/urandom_read_lib1.c
> tools/testing/selftests/bpf/trace_helpers.c
>
>
> >
> > Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> > ---
> >   tools/bpf/bpftool/Makefile            |   6 +-
> >   tools/bpf/bpftool/common.c            |   2 +-
> >   tools/bpf/bpftool/gen.c               |   3 +-
> >   tools/bpf/bpftool/prog.c              |   2 +-
> >   tools/bpf/bpftool/xlated_dumper.c     |   2 +-
> >   tools/bpf/resolve_btfids/btf_colors.c |  15 +--
> >   tools/bpf/resolve_btfids/btf_colors.h |   4 -
> >   tools/bpf/resolve_btfids/main.c       |   5 +-
> >   tools/lib/bpf/libbpf_internal.h       | 162 +----------------------
> >   tools/lib/bpf/libbpf_tools.h          | 184 +++++++++++++++++++++++++=
+
> >   10 files changed, 199 insertions(+), 186 deletions(-)
> >   create mode 100644 tools/lib/bpf/libbpf_tools.h
> >
> > [...]
