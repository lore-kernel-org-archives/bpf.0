Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF98A3A1683;
	Tue, 15 Sep 2026 08:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789460031; cv=none; b=RwAvY0RndouUh1Ny1fETIYVBwUVg5eNJYNrqsaT7eXggUGDGxGdZNiTqguIU9FS6GpXtCnQ56w85FTgCcialf/+rAsJ7pPp9ZFo+U7lzr4qtKtWcDZ/oveAAsIvh0x/+wjZLlMWWelLXBRu49Y5WX8+FoTsB4bHJT7oPIRCrq7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789460031; c=relaxed/simple;
	bh=CQd5havz4xxgycr++VxXFcEsCtdQlKxCbdFKfwHX0ww=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=If7azE63YzevUe5RJMZwrEywgEQArY0wjJAC/NF9pU7KsmZ41Zfj1jzgxueme6XV4CY/TcmjoaZbRrhBtarW7cwOAMl4+XWFPhiGXGH/myDmOb8nyEaI3a+h9GFspq9MlhZxMxe7iUYNCtYHz84/ong+eWxqp2GOn5pgox+fM9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcDfKGKg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcDfKGKg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0581F000FF;
	Tue, 15 Sep 2026 08:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789460029;
	bh=ahHVIQUKCj3UqsamTwkNl7ydXLXTp+2VEfV/2bZTM+w=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=VcDfKGKgszCsvqVQiNtS6t4Jr3wJLK1aovcQLTgjzjYw/N4/ZaZbQoDBxf5oy6C0U
	 rHlIlc4OopLYai6IlOCSQxU/yL7wo48Rt31Hi4Q+iyFQUzMpgWaheutxjfPiuM3Y7U
	 kn6qDEglR+Rq6VSQCk1laEb3xg8D4xuiqzSjTsKN/gw7qWIdqcBgaT7R7sxqCgYakP
	 B72KawQtbOLpTlCuOAWPrbvtmMvJZe94vNzdawZ+sWg2S4XjlW6dKl3jYv5p6TQpkc
	 T2XO/BK1C3W0jBc6Z5mjMDGQ7kp0dxYSPAt69Ano1ndd+Nzev4E4jcsggi2P0aIfOf
	 qsZKLKIIQlfOw==
Content-Type: multipart/mixed; boundary="===============0798735520997638461=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dc4bd7fb4d98a0066958a4e1582b6a7a407079fd9a284318848909f9594a9295@mail.kernel.org>
In-Reply-To: <20260915071743.29394-1-zhaogongyi@bytedance.com>
References: <20260915071743.29394-1-zhaogongyi@bytedance.com>
Subject: Re: [PATCH bpf] bpf, sockmap: reject max_entries > INT_MAX in sock_map_alloc
From: bot+bpf-ci@kernel.org
To: zhaogongyi@bytedance.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,linux-kernel@vger.kernel.org,john.fastabend@gmail.com,jakub@cloudflare.com,jiayuan.chen@linux.dev,edumazet@google.com,kuniyu@google.com,pabeni@redhat.com,willemb@google.com,davem@davemloft.net,kuba@kernel.org,horms@kernel.org,zhaogongyi@BYTEDANCE.COM,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 15 Sep 2026 08:13:48 +0000 (UTC)

--===============0798735520997638461==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> sock_map_alloc() only rejects max_entries == 0 and never caps the upper
> bound.  sock_map_free() then walks the sks[] array with a signed int
> iterator:
>
> 	int i;
> 	for (i = 0; i < stab->map.max_entries; i++)
> 		struct sock **psk = &stab->sks[i];
>
> When a SOCKMAP is created with max_entries = 0xffffffff (UINT_MAX), the
> allocation of 32 GiB can succeed on large-memory hosts.  During free the
> counter reaches 0x80000000, wraps to INT_MIN, is sign-extended by movslq
> and turned into a ~16 GiB negative offset from stab->sks, pointing far
> below the allocation.  On a KASAN kernel the shadow check for that
> address hits an unmapped shadow page and oopses:

This description is technically accurate but narrower than the real bug.
Is the KASAN-unmapped-shadow scenario the primary failure mode?

The faulting access is an xchg() write in sock_map_free(), so on a
non-KASAN kernel the same iteration either faults on an unmapped vmalloc
page or, if that vmalloc address happens to be populated by an unrelated
allocation, silently writes NULL into someone else's memory. The
unmapped shadow page also requires CONFIG_KASAN_VMALLOC=y - with
KASAN_VMALLOC=n, x86 kasan_init() populates the whole vmalloc shadow
with the mapped kasan_early_shadow_page, so kasan_check_range() would
not fault.

Could the description mention it is an out-of-bounds write reachable
without KASAN, not just a KASAN-only oops?

>   BUG: unable to handle page fault for address: fffff521b59c5a00
>   RIP: 0010:kasan_check_range+0x107/0x190
>   Call Trace:
>    sock_map_free+0x93/0x190
>    map_create+0x68d/0xb30
>    __sys_bpf+0x21e/0x2e70
>
> Vmcore confirmed stab->map.max_entries == 0xffffffff, stab->sks ==
> 0xffffc911ace2d000, and the faulting address sks + (s64)INT_MIN * 8
> exactly at 0xffffc90dace2d000.  The same Oops triggers on the normal
> close()/bpf_map_free_deferred() path whenever such a map is destroyed.
>
> sock_hash_alloc() already bounds its allocation (buckets_num >
> U32_MAX / sizeof(bucket)).  Reject max_entries > INT_MAX at creation
> time so the signed iterator in sock_map_free() never sees a value that
> would overflow.
>
> Triggered by syzkaller and reproduced on both a 6.6-based KASAN kernel
> and the upstream v7.3-rc2 kernel.
>
> Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")

Is 604326b41a6f the commit that introduced this bug?

Looking at that commit, the version of sock_map_alloc() it created did
cap max_entries:

    /* Make sure page count doesn't overflow. */
    cost = (u64) stab->map.max_entries * sizeof(struct sock *);
    if (cost >= U32_MAX - PAGE_SIZE) {
            err = -EINVAL;
            goto free_stab;
    }

This bound limits max_entries to below (U32_MAX - PAGE_SIZE) / 8, about
536,870,400 entries, which is far under INT_MAX. With that bound the
signed iterator in sock_map_free() could not overflow.

The check later moved into bpf_map_charge_init() with the same limit.
The upper bound was actually removed by 0d2c4f964050 ("bpf: Eliminate
rlimit-based memory accounting for sockmap and sockhash maps", v5.11),
which deleted the bpf_map_charge_init() call without replacing the size
check.

Should the Fixes tag be:

    Fixes: 0d2c4f964050 ("bpf: Eliminate rlimit-based memory accounting for sockmap and sockhash maps")

With the current tag, automated stable backport tooling will target
kernels from v4.20 onward, but 5.4.y and 5.10.y are not affected since
sock_map_alloc() still had the bound there. The wrong tag also hides
that the regression came from the rlimit-to-memcg accounting
conversion.

> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index ca49bc7f8687c..38df842843289 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -41,6 +41,7 @@ static struct bpf_map *sock_map_alloc(union bpf_attr *attr)
>  	struct bpf_stab *stab;
>
>  	if (attr->max_entries == 0 ||
> +	    attr->max_entries > INT_MAX ||
>  	    attr->key_size    != 4 ||
>  	    (attr->value_size != sizeof(u32) &&
>  	     attr->value_size != sizeof(u64)) ||

The code change itself looks correct. With max_entries bounded to
INT_MAX, the signed iterator reaches at most i = INT_MAX at the final
test, which is representable in int, so no signed overflow remains.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34941876090
--===============0798735520997638461==--
