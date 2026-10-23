Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792771104;
	b=z4kcr4hbm8P9a/SFTAdNCPt5sHGBuij+1FMegLBOVbvdt/YRDVwWqpeZpsGLIyL1gPBx
	 HNcCr7Ph1DQVXa2+iHjI3UEqAx2WhiUWMFXXg5/3EzrE/DUuCBb2yNuzu81LdIoF/GsVI
	 0/yjQk8fn5Y6PbO+UDbrx1r0WeTZ6pObUzXbYANRzpjS03suXfGHwPTD5lNBjvn85ktLU
	 BNT6fMdw2Z+pNW0kQ2NDTPv1+wkY3BvHMsIO8FVmk98e7Hbm+BVX5ZZxOf9kiSJn6LD47
	 7LHJEnTn3UI99mvDLTKbzEgRF218jyJaZKTGl5FVB8DXcJc6PNSR/7R1O5pb8objbnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792771104;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:X-Mailer:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oR8WsW0STYE/yZ/T3jtIUfWqW3IPmySlmYoCN5YBLrk=;
	b=VQOLgiBu/I9UVe5TtFcR0M5LsWNbC82lrN7Bwyw+/AJbVY4fL0zErER6zPPAG95t+izX
	 EnE6gTbpYeFv+tSMdsissOy//Va0hRPZ3UPoTS8HRAbsqyLvD/f929vtRnVUBM40P5zP/
	 kjyy3crQSa7bsjcphAU3KJcMjz/rrXfzyrbAflFsuzjuoAvcWgBK9Ae330Ek3nyONrZIh
	 z2dhwdHBYX4DL/JDKHO4BYrT1i0rSxSkPhsZXzZQrogF6g2IH7jW9dg+cvtj2JlB1uPf1
	 sKxCIq//OXIXhsyvbKw/iddKoJSl2wzmixR4xEKWf/poZECvWmRAFCKyT6BJBT0mAFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PTx3+SOh;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5487F606A31D
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 15:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5487F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PTx3+SOh
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3a7cfe8f761so1230935a91.1
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 08:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792771104; x=1793375904; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oR8WsW0STYE/yZ/T3jtIUfWqW3IPmySlmYoCN5YBLrk=;
        b=PTx3+SOhTdnUC4l9QD39mzvDBiRvCJt5QG2Znwe0srIuIEhUJHRM3FUgALlOCZC4gu
         qpjaRZxY+Guwr4ugPHVqYeuGevQv2QafXFhobLSduTUFHskSQzQ2hlSFUDxJ+eptKuF4
         YDTaHS7NriA0WBIKczxLaKmqwZbbT87SHmNHaynZsHX6Abe8Cce1Ql2PMn9xh8fb8Jtn
         0auAl2nnXl1i5R+mQBN9JENdebgSsgGyZNa3VoSLY7iGHKd650/imzOW4DjDdAX+VwLK
         SeNV0+1330zbD00mA7a9LhynPip0JZpa/XPPChke4zCXYZZGlJPAAmwUhP9X5BtyHBi8
         kx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792771104; x=1793375904;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oR8WsW0STYE/yZ/T3jtIUfWqW3IPmySlmYoCN5YBLrk=;
        b=A1PSw4UzWu89K+nqwSyTKZ6sGsH+x7GmlVrkOYmkHUGMZac3Ag+JzA2emyp0ogspVi
         OODY2FzmY+EuW5Sw5VFoiOby07jQPYb5UeEULR/ZVQNRQjMmWg2FBk+P15h4rTokqII7
         qLfuPlG6vqYcNewjwnl89OIES5tjYqy2328pnhriZ735rK4HwUprgrrZbjn03GM8mUFh
         x/CoXGqSKx+lOl854IqwpkVZUMkMRwRTJBrGw3rHBTXAba/TtxVEUmWofmdesilRtsRO
         nWGQ0GpUT4Al2nJy8alXgwbJn+z1TNGW4uTLXheA6wPmHlJHkmSQs//eHyA/y3Filqj1
         wKIw==
X-Gm-Message-State: AFq9FYKiErFWFZLe5pXdVPNRaU6AglztSW5BxYoYktaW4XtywsjHnbVh
	U5VnwCNeqcvg4ynLFTqDX/xpP8FIZhV7ftoAgUFCEiKZbjTr2HUPYRnA
X-Gm-Gg: AYBFou0qWVGuK772uqGNVeK8rJuwr128wKXPXQYUeHVF/Zs0u+RX08YcbaACxUr4rhf
	Y/tByEaeRmP9kKjag9sigcFyzX+TJnJsWdm1JXSGRgWVTrvfn/U7w16QpqBgyYcJp4iac1E42Dp
	nFHi6hxcmdjcLvIGs2p0OaUVfY3UKW/+0QF3et8vwqw2Y+p2kpEZNB3ojx9kFRC0prE2rpvPtQM
	0cq2t37yf2m9SzUg3ruo8fYSZoAn80xr/AT1x/u6bY4Kw3mEjClGHC3ZZhUc1DVrADtJ1wNgd26
	KYiJjpti8j9YVKyKipTzJqP8ELSsUK75uJynNfbTfbhVbQqDnKUZTCj8VOGHhbhiv6ag+7phzWh
	ODag9skg5XriUwbvQdtee1+m2JCqFjwrRHr9yj04Ctta+i26iKhIXWTlS2rfeBfGn5JQSYxY7a7
	Gk5he830q2tWd4pQyN00eAQvh8jmpgCAbQzfhHUV714JNrXpP+hWIZHKP7aFlX1G860Osjc4npk
	MuNOIT6lX3j+c8Y7uR0g+lJZN68SESifgcOHwaHStgtLMnU7U04mJkN3+1RXtap3ZUjxJhIxYPS
	bCDS2pZkDCaOSeu18iFlGryaR+X3V2M2VzSFlX3RhWgxQxX7uwCGxn0EFRcN
X-Received: by 2002:a17:90b:3e48:b0:3ab:8288:b8ce with SMTP id 98e67ed59e1d1-3adce7398c5mr1635912a91.24.1792771103440;
        Fri, 23 Oct 2026 08:58:23 -0700 (PDT)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3addd84b1basm707058a91.14.2026.10.23.08.58.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 08:58:23 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 23 Oct 2026 15:58:22 +0000
Message-Id: <DMCCBEPCIWH0.2JEDKE64WPJRQ@gmail.com>
Cc: <bpf@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/7] mm/page_owner: add bpf_iter and kfuncs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "zhen.ni" <zhen.ni@easystack.cn>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <emil@etsalapatis.com>, <ihor.solodrai@linux.dev>,
 <akpm@linux-foundation.org>, <vbabka@kernel.org>, <surenb@google.com>,
 <mhocko@suse.com>, <brendan.jackman@linux.dev>, <hannes@cmpxchg.org>,
 <ziy@nvidia.com>, <shuah@kernel.org>
In-Reply-To: <d39db4fb-e511-440e-9065-72c34a1a295a@easystack.cn>
References: <20261021112437.1799213-1-zhen.ni@easystack.cn> <DMAURQCKK6CG.10CZ7MFXGJO3V@gmail.com> <d39db4fb-e511-440e-9065-72c34a1a295a@easystack.cn>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, Oct 23, 2026 at 07:51 AM zhen.ni <zhen.ni@easystack.cn> wrote:

tldr: it's still nack

> underlying iteration logic. This shape is also what Documentation/bpf/
> bpf_iterators.rst prescribes:
>
> When adding a new BPF iterator program, it is expected that similar
> functionality will be added as open-coded iterator for maximum
> flexibility.

It says what to do when an iterator is added. It doesn't say that
one is needed.
Iterators are for kernel data structures that a prog cannot walk
on its own: tasks, cgroups, kmem_caches.
pfn is a number. bpf_for() is the iterator.

> 1. What range to scan. Where do ctx->start and ctx->nr come from? No
> in-tree iterator context provides them, and a prog cannot derive them:
> min_low_pfn..max_pfn, memblock holes, and offline sections are all
> kernel state. The loop bounds alone require either another kfunc or a
> kernel-side walk — which is exactly what the iter target already is.

From user space. It's a syscall prog, like scan_open_coded() in your
patch 7. Its ctx is what user space passes in ctx_in.
/proc/zoneinfo has start_pfn and spanned for every zone.
In holes and offline sections pfn_to_online_page() returns NULL
and bpf_page_owner_read() returns -ENOENT.

> 2. What makes a page eligible. The alignment test in the sketch is the
> only part the kernel agrees is expressible in a prog. Everything before
> it reads state a prog doesn’t have a handle to: pfn_valid() over
> MAX_ORDER_NR_PAGES areas, pfn_to_online_page() under get_online_mems(),
> skip_buddy_pages(), the PAGE_EXT_OWNER / PAGE_EXT_OWNER_ALLOCATED flags
> in page_ext, and taking the record snapshot inside the RCU window so the
> checked value and the reported value are the same copy.

bpf_page_owner_read() in the diff does all of that:
pfn_to_online_page(), page_ext_get(), PAGE_EXT_OWNER_ALLOCATED check
and the copy of the record before page_ext_put().
PAGE_EXT_OWNER is set together with PAGE_EXT_OWNER_ALLOCATED and it's
never cleared. No need to check both.
__reset_page_owner() clears PAGE_EXT_OWNER_ALLOCATED, so
skip_buddy_pages() and MAX_ORDER_NR_PAGES steps only make the walk
faster. They don't change what is eligible.

> 3. The walk is deliberately lockless, so exposing struct page to the
> prog is not safe. The pfn validity check and the page_ext dereference
> must happen under the same kernel-controlled RCU window. Otherwise the

The prog doesn't see struct page or page_ext. It passes a pfn and gets
a copy of the record. The lookup, the check and the copy are in one RCU
section inside the kfunc. offline_page_ext() does synchronize_rcu()
before freeing page_ext.
page_ext_from_phys() does the same lookup from any context.

> 4. One record doesn’t give the prog the useful data. The record holds
> only opaque handle/free_handle tokens; stack-depot resolution exists
> solely in the kernel. The memcg is neither in the record nor trivially
> reachable — the path is built by cgroup_path() walking the kernfs parent
> chain. The NUMA node comes from page_owner_get_nid(), which bypasses
> page_to_nid()’s poison check. And so on.

The handle is the key to filter and aggregate by.
page_owner_stacks/show_stacks_handles maps handles to stacks.
Same for memcg. bpf_page_cgroup_ino() in the diff returns the id.
st_ino of the cgroup directory is that id.
