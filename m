Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA2A184524
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 23:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427839; cv=pass; b=VE4u85T3dYzVs5Bmclb57U7tznQYhSqmJKn0TmFttoCFuXKZ5/pia3b+1Uaw1beiKQUGNqAt7tgBsqIaVFPUpe2i5nQ2WzIkG+vT/NjACuCiTsWw2iFOl81Fy7UN71iQNIb7c4K41KoIBygQOX/PuFvK/bYyCm6Ev7g2A/bzZbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427839; c=relaxed/simple;
	bh=RZ7AYDpwif8OjK59BGFRZwWIVN2HIHDHT/0jIXTGwRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cmQACB8riftqv676OXtAQdIGDleILqcBwsr8Ay1fUw8coA3dDRhTd+vJztuuJj8u613KxYGZVbJsgMHj2rymtYypjFha55S26trafqBTMZXQflAdhvtqO2F4aXYL7lxtnEIUtVY5rdqHTlltud0qELTOT9LxtaQxLr638L/2IeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=l2kFqhsP; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="l2kFqhsP"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-67124ad72e4so3938766d50.3
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 16:17:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789427835; cv=none;
        d=google.com; s=arc-20260327;
        b=mHqPD4ferloqXtdF9MCkB/yRw3ZYX4ZVl93qG3sJxkElLGaL7EUwHAzYb/nBmtUvBk
         JdKwLQPt7STjfrb698t59bCsbfOGKJHXQInjGZ9XLrmG3r0E7w+6LC4RZ1cs1RVjks6H
         3vaZUwQ+9qphNLei+wYDUSbp4ZXv6hh6gQgWUF9o7pF64Nm/kBBzDl4o+Hmgu0YNYXKq
         WVVutsabLIkOaA0llN/zsnp/4kIXh8vs0eiLbOva0QaNwHCS5AdeXW+49/drQ1yPs3/M
         VwZsabR1af7FaEExFIivxBgEUuPwIJwMkM4Mi8bBLyfUof5iFY6rXqcXoH2Xcm2d55c4
         q7GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rPKM73fBOFsSjy59aqqxc7UWTKxXfj0ZC9NrA+w1XGc=;
        fh=EUwrLYYJNl/NclzXoI5zD+BQ8BgB8gfqbc3TOIYrkiE=;
        b=DvK+KDJochi5pg9YrbmLmqVvGTW3uiZwJ5H7hsPhRKrSmNLh0EyDtLo8PBBhf5dkNQ
         jfdXtY5+MHwTG86o/W0nEGI0HreZ2N8PDvbJ9nDy4lZGIwsaK/FF3e8z4AKXABCnheNH
         +wl958RR8+HkgpB629mhTXgviKvWUmHqMXYjdl0BN8+YTXEBEcrwRYzl9kJlDLXKazAc
         6ungAp2b/1ASke96VjtG+P7dcMXihTmHkctPsIx7r34hPZdtgThEjwqDpnw+UYaas6q/
         WGyGIJMR01Sxw71xk7rp5QCcaPvzYI5NL/PyXgi81qWuZs2ykaNx8frZH4G6MJYYSEyI
         XpIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1789427835; x=1790032635; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rPKM73fBOFsSjy59aqqxc7UWTKxXfj0ZC9NrA+w1XGc=;
        b=l2kFqhsPWgDIWu+XPDYhyJxexBhwOUk+x9rHFkIoAaA8mHrGKU427uoulyg8NDLaMB
         BHLxEbwk17ESJ/z84reeELq1wvXnKL+gBgCCyKy9tYaakKPIlNE6iO+2LG++SLP5cUTX
         DgHEDHSiWATwnLQ/yef+Q12ZSEhLs1nQIN0jypCW/glMf+4TsKnfnMiLf6Vmf1sw7f8h
         94aUOjf9o1lcb5B5JsLfVc9qV+WV7JyT7Mwr2Mp3DxYriHupK0PRV0UL7NN3mCoB6Y+W
         ofO3yqLep79rWzxEjzb+ZePijbMSnq8pJHUebmWtExeTBdh1Gei+zVjkPlatAR9r4PWv
         6xqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789427835; x=1790032635;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rPKM73fBOFsSjy59aqqxc7UWTKxXfj0ZC9NrA+w1XGc=;
        b=Ry30VBE+DVOUFFEtM1lUywsLqZ2DYqT4kRfuoIzCrHZQ8ybmeyyZerPLCVUQXfRDFE
         pesaMOF6s5fc7S6n7tezGCTsDei4Ijw7fqrQZ2EuhDGF5s4kKLu5BOVWYXcaNxNltp62
         y4XuXjHYb5O8Zar7KiCP4Ahku4s9802EP0bSGLAZdbeARal9CPvUxT1XxD5UOjrqBT0J
         kt2gqxF1/xFzrZHpXFE0/LEZ5aMCeUnbl9hiTtu6rd795KwaZAp34qnjefmMh+MKScWQ
         GpT0uHnjoQdwV4YfkZO7nRNIHFcgb0f+XN/fjIuY695tYheOFE8nQJnQZ07Scwx8lF/L
         cSHg==
X-Forwarded-Encrypted: i=1; AKwUvByMAu+Nz0ujvvF5TjFEmq/LExCglUQpghF2aC0z0ndu3yv9VYB2g2fKyML0n490CgnATdY=@vger.kernel.org
X-Gm-Message-State: AFuF++kOOoSDCIhJHwsHIRTQY4gOoBY9rjvmY0+0F1MRgxqCz5JQr4Bu
	mb43cCrVFPgs5gsQOnWorxneHB115R1TysecVIJSGgQ42hjyXf89KpwyNbed+vih3NSSkxpu+1f
	JR2WQAQKDob/67MqzYqc7uz3k5pL4T9tNiDRQSHxHdA==
X-Gm-Gg: AYBFou3i4ZUicTgosfFag9quH1HMsPz52LNcb3RsxOvLTVuaB1koLqRbFKA4+RRC/LB
	1TLZxmeU+W2VlMVR/i7EWfXa8ekKRG1UGqRAFKpO1tBxcoyriOFo20d6xUNHuF6UVvMR/UrfEuE
	bWKmvusC5qWFFf7lTm8FoVk56hFRgadhQwqrdbRCLZyen72HJ2EXpdoyZb8ijzY9Qev+qdarNuY
	nDHt9cQEAEpMS8RT/5juDIQI7ZVvAF/b5Uzhv6U3BB0KtQSunRom1M7h2HCo9xDZcxa8wxLHGJk
	IpJ2H19dJ9JVS7A1IhU190dXEhTLzqaY2+zSjmsPA9+RoEMxrxtC+kQ=
X-Received: by 2002:a05:690e:d0a:b0:671:2382:d57b with SMTP id
 956f58d0204a3-6714e00a7efmr1347187d50.44.1789427834988; Mon, 14 Sep 2026
 16:17:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org>
 <20260914-b4-mmap-prepare-vma-flag-sanify-v2-14-7d9781ed5361@kernel.org>
In-Reply-To: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-14-7d9781ed5361@kernel.org>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Mon, 14 Sep 2026 23:17:04 +0000
X-Gm-Features: AcwNN1UnQs5y9ap_T4Dsaa6llmYZN4_govFYy7UyV78s5E1rt3VhMagl8qfkC_o
Message-ID: <CABFh=a7Sa0zMKssts1TVZ+u_x3roWcYVSmJF34K-W++oHEsbEA@mail.gmail.com>
Subject: Re: [PATCH v2 14/40] bpf: arena: mark arena_map_mmap() mappings VM_MIXEDMAP
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Paul Moore <paul@paul-moore.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Doug Gilbert <dgilbert@interlog.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Peter Xu <peterx@redhat.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <pjw@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <baoquan.he@linux.dev>, Youngjun Park <youngjun.park@lge.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-arch@vger.kernel.org, 
	kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 3:21=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> The bpf_map->ops->map_mmap callback invoked by bpf_map_mmap() can be set =
to
> one of ringbuf_map_mmap_kern(), ringbuf_map_mmap_user(), array_map_mmap()
> or arena_map_mmap().
>
> It is convention in mm to mark mappings whose pages the kernel manages
> itself with VM_MIXEDMAP, so the core mm knows not to treat them as ordina=
ry
> page cache or anonymous memory.
>
> The map_mmap callbacks ringbuf_map_mmap_kern() and ringbuf_map_mmap_user(=
)
> use remap_vmalloc_range(), which ultimately invokes vm_insert_page() and =
so
> marks the ranges VM_MIXEDMAP, and array_map_mmap() sets VM_MIXEDMAP
> explicitly.
>
> However, the exception to this is arena_map_mmap(), which doesn't set the
> flag.
>
> This patch corrects this and updates the comment to reflect it.
>
> The pages are refcounted and vm_normal_page() finds them regardless of th=
e
> flag, and VM_DONTEXPAND remains set (marking the memory as VM_SPECIAL and
> thus unmergeable). The one effect is that NUMA balancing now skips these
> VMAs, as it already does for the other bpf map mappings, which is the
> reason array_map_mmap() gives for setting the flag.
>
> The intent of this patch is to be able to establish the invariant that on=
ly
> PFN-mapped or mixed map ranges may clear the VM_MAYWRITE flag, as is done
> in bpf_map_mmap().
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

Dropped some CC's as Gmail is refusing to retain them in the response.

>  kernel/bpf/arena.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 7b6847200b43..b69fe5e34339 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -620,8 +620,9 @@ static int arena_map_mmap(struct bpf_map *map, struct=
 vm_area_struct *vma)
>          * clears VM_MAYEXEC. Set VM_DONTEXPAND to avoid potential change
>          * of user_vm_start. Set VM_DONTCOPY to prevent arena VMA from
>          * being copied into the child process on fork.
> +        * This is a kernel page so set VM_MIXEDMAP.
>          */
> -       vm_flags_set(vma, VM_DONTEXPAND | VM_DONTCOPY);
> +       vm_flags_set(vma, VM_MIXEDMAP | VM_DONTEXPAND | VM_DONTCOPY);
>         vma->vm_ops =3D &arena_vm_ops;
>         return 0;
>  }
>
> --
> 2.55.0
>
>
