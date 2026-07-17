Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4A33DDDCE
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 23:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784331189; cv=none; b=HNF/vYvkHgTklTODESSyboPBrz9dOiAIsF2rrxJzACtXiUuScaEha+A8DaiBvD5JcwSDWCo6pbNVrlHudpOs+6U/ynk9pJjmAlHXcBfnyHLRKjTalZPGbOx6pXnzMk1alJ+KqvJfT4kM19XmnE6jREmXBA+f0NfuEpQRz46zf6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784331189; c=relaxed/simple;
	bh=TEMdKZg4KEifG3GYYRMv7C2bXIPR7Kfr8gDF+3F+4So=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=XPpO5iaFc+m9NvRVNT6UhdXSHCdsz+wzk1EFrVbt4NXeDR3AZQBnP4nFtEer4ksbp7v24Xt+iEZlS0YsVToD0WS3sd6xonK293omrRBn7h6FSK+jhFaK6Dc0844nJd7ChDc9V0Kwi3qRzzXRkHYIAjGv2t1ga9QB+HRNL8hwFmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=USfJSyRc; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="USfJSyRc"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ced3386430so47944195ad.1
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 16:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1784331186; x=1784935986; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=84V6BymvtCbFj4DfL8xP1DyPKjZR0+mssoiC4CaKJs8=;
        b=USfJSyRcTFRqO6uNklw3ypC6WVQYyHwlwUC7TjBuAZagoA1aD5QGVt26A1Tq/PVnIJ
         gFOxgrT7koqhQHue919xUaCuaLntg6jJV/duclNOxcpFr1fq1saEuVS2NGkUCtAfl/E2
         26Ypii8vjMCgJYqA3kVBIITKv5vFX+MVwh5c+nGIUDShoUtdatPVqgpzus1xTEq0WGoT
         WkmJYy/pVqou7Pn3kxXvOevni3kPME7XuUVOjYAMz8ACgIynIBU1gc1Ezpg2obdMSsvz
         pQQmCGciYvEre4pXw4phSVchV2h/U5JBm3x9pjOHcFr+aLCzjyG700ImejdPmAbctBkH
         HBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784331186; x=1784935986;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=84V6BymvtCbFj4DfL8xP1DyPKjZR0+mssoiC4CaKJs8=;
        b=LDCVqq0iOPd1P5QnEx+3UT7kl5+SMbhn803f0rmAVp/pz4kTaOSKM2jH5OEVq1Hx25
         jSCEcDGhUWkkGdEKE4QacGQITfFxDlYPQitjsvAufje+7SAjlLcz2JW7cS+cLSxGpk27
         fP6LSXvbdBeEZxazmMKLX44VUjPU+V89aamW5201HKqYTkWW+zHtGPsMILEfQnuSX9XM
         a30paupJZAigI94fE2Zfet4s+ABPlc4XQEuUd4izL+BebtMtF/2a+Y0vNzV+db87UECR
         CIjKsi3SYNz+d83Pw0uHpR/jgbublKozoOmqKTtxxwkNuff36FBF8sQNzI4XR055pJLQ
         CPRg==
X-Forwarded-Encrypted: i=1; AHgh+RrWD16Md9HtGLCYhJBPkw7QnDpM691ej+ci9nLfic6xGLFleWk7U+5nd9qtm95YZ3GHI5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqdzjHC3mFJE6CDiVIJRjxQA4scmnceN3l9w6TBw0jNEA/ARBI
	ceIcjGv0dEejFYrKg87gwOR8P6ygI1WrVNi0jk4I/WFGLfbdt9hcOpVrKCAntT+7M2E=
X-Gm-Gg: AfdE7cl8HsSNr1Nm+Jpr55aYpBJoh64DpfZXhtNXTogXGQxOjfQTycdByZIMKmUetii
	2tqgpF0/SpdUGsSCbWSByFSYMZLDIWeUnzOrsrP6LTFAb6b9YetrhFWq3fYoKWeiGVSiT2NIdXW
	sPtvRFarwl9IGaZ6QKYN7TwvTa1d+p02zLGZ6HlFi246kHthlb6160lJjQqvIZY+Ut3IrcHOMtr
	iXpPAzZOQD7PCCIKrUv61uRkvnsk7yCNHa/PLq1Mf/yLFHROhTCkYt6VyvlaUWLkB9MgrTd256f
	blI4ZOo64+pM4fKwj8apLd0J4n/BZVVvQtMJIdKtyyPAWfkLvNyOk7Ov6QKvTsn+yTvFar3OdnV
	OIVkmRmvDiokIoG+VHJ6LJApr0Omw//m0lfaQFRrKGNeOMQ2h+vmhGPeEr9U=
X-Received: by 2002:a17:903:2287:b0:2ca:b8fd:1a8f with SMTP id d9443c01a7336-2cf349c2497mr53405745ad.39.1784331185827;
        Fri, 17 Jul 2026 16:33:05 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::f5f9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce2ddfb35sm9069068c88.14.2026.07.17.16.33.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 16:33:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Jul 2026 19:33:03 -0400
Message-Id: <DK18M5FD69A2.2U0WEYWFGIBC0@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan"
 <shuah@kernel.org>, "Woojin Ji" <random6.xyz@gmail.com>, "Puranjay Mohan"
 <puranjay@kernel.org>, "Saket Kumar Bhaskar" <skb99@linux.ibm.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 2/4] bpf: Add memory usage for arena
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260717114117.350851-1-jiayuan.chen@linux.dev>
 <20260717114117.350851-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260717114117.350851-3-jiayuan.chen@linux.dev>

On Fri Jul 17, 2026 at 7:37 AM EDT, Jiayuan Chen wrote:
> arena is the only map type whose map_mem_usage() still returns 0, so
> "bpftool map show" and fdinfo always showed 0 memlock for an arena no
> matter how many pages it had.
>
> Count the pages that are actually mapped into the arena: bump a counter i=
n
> apply_range_set_cb() when a page goes in and drop it in
> apply_range_clear_cb() when a page goes out, both under the arena spinloc=
k.
> map_mem_usage() then just returns nr_pages << PAGE_SHIFT.
>
> Only real data pages are counted, not the scratch page.
>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>
> ---
> To sashiko:
> 1. __bpf_alloc_page::can_alloc_pages already check whether we are under l=
ock.
> 2. apply_to_page_range() does not allocate page tables here. arena_map_al=
loc() already did it.
> ---
>  kernel/bpf/arena.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 8dbc24460890..f046e878f7ae 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -55,8 +55,10 @@ struct bpf_arena {
>  	struct vm_struct *kern_vm;
>  	struct page *scratch_page;
>  	struct range_tree rt;
> -	/* protects rt */
> +	/* protects rt and nr_pages */
>  	rqspinlock_t spinlock;
> +	/* number of pages currently populated in the arena */
> +	u64 nr_pages;
>  	struct list_head vma_list;
>  	/* protects vma_list */
>  	struct mutex lock;
> @@ -196,6 +198,7 @@ static int apply_range_set_cb(pte_t *pte, unsigned lo=
ng addr, void *data)
>  	set_pte_at(&init_mm, addr, pte, pteval);
>  #endif
>  	d->i++;
> +	WRITE_ONCE(d->arena->nr_pages, d->arena->nr_pages + 1);
>  	return 0;
>  }
> =20
> @@ -231,6 +234,7 @@ static int apply_range_clear_cb(pte_t *pte, unsigned =
long addr, void *data)
>  		return 0;
> =20
>  	__llist_add(&page->pcp_llist, d->free_pages);
> +	WRITE_ONCE(d->arena->nr_pages, d->arena->nr_pages - 1);
>  	return 0;
>  }
> =20
> @@ -413,7 +417,9 @@ static int arena_map_check_btf(struct bpf_map *map, c=
onst struct btf *btf,
> =20
>  static u64 arena_map_mem_usage(const struct bpf_map *map)
>  {
> -	return 0;
> +	struct bpf_arena *arena =3D container_of(map, struct bpf_arena, map);
> +
> +	return (u64)READ_ONCE(arena->nr_pages) << PAGE_SHIFT;
>  }
> =20
>  struct vma_list {

