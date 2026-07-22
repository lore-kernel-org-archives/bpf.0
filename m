Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D86940D565
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 11:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784719224; cv=none; b=NZPnDDqs5o3LdMfp9IjcYn5zc+z92hV1BoNhSmscMh+BnuaqA2/hkcvbil7Qdzu1kHbXotI/RdO4F6TwL+AbkohYCaOFvshVLl+JpENQzNaL6lZvFI0khS/LL3JEnncxMVlzzS0w4HenT7zEEYCiKFCcIs+J1hxyB63vul4xxCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784719224; c=relaxed/simple;
	bh=DNfsK3Qc4wnPZsEh1/qi+3R4oMemw6sshSP1AuLudMY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMwdelR0JLweqKbcppp/SN82WQVQ+5sSxG7crtOqz09ipDESADbqGyHBYDJH+y7iE2ow3fJBPQY/c7msffIuQnzpNoXX1OYWQ9LYD74GyDiRAeCyIATG+QagZhnFsMI5lT+enA45BY4egUINc8YlYeVzDrJ6CFYaXi02A0dSYBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtQgnd2l; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtQgnd2l"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49548e01d02so24848655e9.0
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 04:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784719221; x=1785324021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RmjmwaU2oCm5qiT++FhifaZEeDp06wO3d7kV+FIvU1k=;
        b=HtQgnd2lzOxrH6bJXgwO6RyLgAcBS/oQ0sz+wNY1JOrmFTg4EctIX0d0oOiZI5g72+
         5Qh4fdmnxkhVrxVu0OOXCYKp9XkCTrmaA9XEk6Xc0mPoRHxKZ0Encouf7IGeY7TiNqxR
         +cSvgl29bJY1+cb4MvYtjxq0Pgz/lghvAqXM3FLx2es4pxxjK3WEdMWTiamwdWijA+Eo
         5jYTWb+hH2jm/F6ZASNasua0QLyxAFAwe+1/8WZ3LPec+gUOVgna07bbGlhCLiisg3rq
         yB4+0UGXzwuIf6gJK7lHJPLwqQ7LXm+BW4LoeDXhpaTgURe7gCjpLKiF9ZoBYO3NfbOI
         GfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784719221; x=1785324021;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RmjmwaU2oCm5qiT++FhifaZEeDp06wO3d7kV+FIvU1k=;
        b=MVIEIbtdzwESLDnW/2qxOK9hsaVX/FtcX8YFrvwfeOzpfozXd0OeJufNYX/B5bNuuB
         6XhUNwoj5rSdX/rOmet1PryVqWK/BJChmyWUSerTpeNdv2ARrZy2J+27WK/ZTamlYO1P
         7ewWPwfFlmiM5c0Ga6wU/sZLlgS4QCOy+CtGE7nMyG9KvE+zr6X7+BdGRLXO4F2sRSRd
         wkZXAeFXDLWLruU0vOmbJmXnWBO2rBrJUc1Sc/upG6auSnTDfQWHZRj2rvSHVNkACHou
         36W/i8TDbo4s5W7lkJ/+fkruQ+/peI88RCMggkiNdBUk2CFBUKu3csyFmR6eTAgAc7ti
         Ng6w==
X-Gm-Message-State: AOJu0Yxbt2wRNNK86SVsoEyoQcU47Gg9GfUtmWhO4pgaj7jl2EGyAB6B
	KXP+szN+5dW6rA2798gnpWixQfmnKXPaNOAbTBuj8BLzt4LkQxfKNGV/7q3riw==
X-Gm-Gg: AR+sD13s0MwBdV5daxswsM04N+Ehj5LiARgOYvsh9HSnkfMrniyTZjaqoJ9Qqxvi1hZ
	eRYE0RqyNyxvVNzZm/QGslZoBGjOFO43A5Hx99o1opZ3hGgfQeeN5V6TacvZGpG/JzlAA1bC0p/
	eAbJXMvZMHcXLyVc582ma9ZG/jr2G9p4lu7sFojhjLrrK3jszGxw/f2vdL68IJai35RmHtIWLbC
	0rFTezLQhVvDdh3Ea0SDDasRNEb+/FNQJ9pRIl9i5yFrNT4k4VqL8Xr2LSVJMNMiK2NEh05bWyF
	7MVdmRtVOLPwKp5gJUWhR5e8UoLhl+Z6rVJptds0abkmbYKiI81X36bLDo1VzrUCSomOT87E05T
	ThcjzpifC3zjPZMCCmDWJINwOgDqfzd7P+PdMlvn2F/xLTd27DuU=
X-Received: by 2002:a05:600c:190b:b0:493:c77c:108a with SMTP id 5b1f17b1804b1-4954aa1a10amr243092245e9.36.1784719221270;
        Wed, 22 Jul 2026 04:20:21 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::86b6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb57cfsm5095686f8f.11.2026.07.22.04.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 04:20:20 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 22 Jul 2026 13:20:18 +0200
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>, Jingguo Tan <tanjingguo@huawei.com>,
	Pu Lehui <pulehui@huawei.com>, Lin Ma <malin89@huawei.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Verify no warning when close
 fexit link
Message-ID: <amCncpSCkLLJfCvR@krava>
References: <20260721133036.49265-1-leon.hwang@linux.dev>
 <20260721133036.49265-3-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721133036.49265-3-leon.hwang@linux.dev>

On Tue, Jul 21, 2026 at 09:30:35PM +0800, Leon Hwang wrote:
> Add a test to verify that there's no WARNING when detaching fexit link by
> following the repro steps of previous commit.
> 
> Without the fix, the WARNING could be triggered by this test.
> 
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>

left 2 nits below

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  .../selftests/bpf/prog_tests/tailcalls.c      | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> index c66037162da5..86d87d5817cf 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> @@ -13,6 +13,8 @@
>  #include "tailcall_cgrp_storage.skel.h"
>  #include "tailcall_sleepable.skel.h"
>  #include "tailcall_callback.skel.h"
> +#include "tailcall_bpf2bpf2.skel.h"
> +#include "tailcall_bpf2bpf_fexit.skel.h"
>  
>  /* test_tailcall_1 checks basic functionality by patching multiple locations
>   * in a single program for a single tail call slot with nop->jmp, jmp->nop
> @@ -1907,6 +1909,53 @@ static void test_tailcall_callback(void)
>  	RUN_TESTS(tailcall_callback);
>  }
>  
> +static void test_tailcall_bpf2bpf_fexit_links(void)
> +{
> +	struct tailcall_bpf2bpf_fexit *skel1 = NULL, *skel2 = NULL;
> +	struct tailcall_bpf2bpf2 *skel_tc;
> +	struct bpf_link *link;
> +	int err, prog_fd;
> +
> +	skel_tc = tailcall_bpf2bpf2__open_and_load();
> +	if (!ASSERT_OK_PTR(skel_tc, "tailcall_bpf2bpf2__open_and_load"))
> +		return;
> +
> +	skel1 = tailcall_bpf2bpf_fexit__open();
> +	if (!ASSERT_OK_PTR(skel1, "tailcall_bpf2bpf_fexit__open"))
> +		goto out;
> +
> +	prog_fd = bpf_program__fd(skel_tc->progs.classifier_0);
> +	err = bpf_program__set_attach_target(skel1->progs.fexit, prog_fd, "subprog_tail");
> +	if (!ASSERT_OK(err, "bpf_program__set_attach_target"))
> +		goto out;
> +
> +	err = tailcall_bpf2bpf_fexit__load(skel1);
> +	if (!ASSERT_OK(err, "tailcall_bpf2bpf_fexit__load"))
> +		goto out;
> +
> +	link = bpf_program__attach_trace(skel1->progs.fexit);
> +	if (!ASSERT_OK_PTR(link, "bpf_program__attach_trace"))
> +		goto out;
> +	skel1->links.fexit = link;

nit, you could use skel1->links.fexit directly and remove link

> +
> +	skel2 = tailcall_bpf2bpf_fexit__open();
> +	if (!ASSERT_OK_PTR(skel2, "tailcall_bpf2bpf_fexit__open"))
> +		goto out;
> +
> +	err = bpf_program__set_attach_target(skel2->progs.fexit, prog_fd, "subprog_tail");
> +	if (!ASSERT_OK(err, "bpf_program__set_attach_target"))
> +		goto out;
> +
> +	err = tailcall_bpf2bpf_fexit__load(skel2);
> +	if (!ASSERT_OK(err, "tailcall_bpf2bpf_fexit__load"))
> +		goto out;

nit, no need to if/goto, just ASSERT_OK would be enough

> +
> +out:
> +	tailcall_bpf2bpf_fexit__destroy(skel1);
> +	tailcall_bpf2bpf_fexit__destroy(skel2);
> +	tailcall_bpf2bpf2__destroy(skel_tc);
> +}
> +
>  void test_tailcalls(void)
>  {
>  	if (test__start_subtest("tailcall_1"))
> @@ -1974,4 +2023,6 @@ void test_tailcalls(void)
>  	if (test__start_subtest("tailcall_cgrp_storage_no_storage_bridge"))
>  		test_tailcall_cgrp_storage_no_storage_bridge();
>  	test_tailcall_callback();
> +	if (test__start_subtest("tailcall_bpf2bpf_fexit_links"))
> +		test_tailcall_bpf2bpf_fexit_links();
>  }
> -- 
> 2.55.0
> 
