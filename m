Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85943372EE4
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 15:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792076555; cv=none; b=Mdt/nMHPLH0MiGiIshSfGMCplmjW9Vbs1e73wEm+WN16DdgV3jtuiTK7djpP4SQz2FLy9M5fNap7fYH2qUVBYymVLruA3MlcWvmlspzGSe5vNHlvghYSBf1vQnM/MXJFeO5MdjqAHTS01TG0h8QfhHMmrbFBeHUkYDnhql7gGSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792076555; c=relaxed/simple;
	bh=RexoZ2W3zYYIpXj6B5gqB5RozQCgY3uk2PP5BCUj8Pg=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=VNT+42XQGYPqOl+SvdccLVhpWrCUsWfHyYbKAqWB39slhNvIAT97uPZAcNOWjJ/itNmV8yAb+/gl4s2QcyFukqgikNTRRxLBlag97ufab2UvAIzYiJgX3D8fMDY9oS+tv+obeVqeNArpKYPhjuIXHY8VhSsx6SZyTvjlCEtGCoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=GLOK87PC; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="GLOK87PC"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c3fd91337baso68628766b.3
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 08:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792076552; x=1792681352; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hti2u/G5tQ8rt+bK5uTIS3tAWn+DNeO1RqjOYiLx8aM=;
        b=GLOK87PCfegDKUx9nROpDao+WFZLr8ZMua9IdIYaHKQ01WkG54fbLrzTRRglIZv+Rf
         NY2DuuO3aXWE+1DcjiWKcB97NaDXKMvLcKrBbHy7KfNuX+THnt/SHXgmm+kY8W89ahfI
         Cn/zHMGuun4oh16jBt0QaIuwV4+QWuz+gAUytmJUk3L5+6IF3y5DXfV4BlWAWh04i9eL
         EazhyZZRUmmbwFqepXSVxcsIcAceNGSsr9Xg/rrk4zrQzUeEmS9ZEi3Ee2HoQhnY55/A
         Y3/WDuFXnIONiLRhFfmjfPQzBgqIb5qHKhs/A6JUOVnmjN/dbjFRMAvDCiJlOV+22MsM
         lARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792076552; x=1792681352;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hti2u/G5tQ8rt+bK5uTIS3tAWn+DNeO1RqjOYiLx8aM=;
        b=Nj7McnHj4jlO7wJo0W8f2KeEYIt43y+RVY4SFWRnfsAZiTNArjpkvTY7BA1VUGbZer
         RGLpuNHoDynwy3VoXvjNhS0118LwnzNhpoqd3j0BghauSVr3bH7d1EuCq4MFEEHDs8YB
         L6hK4qR2lurbMvUqF3TkgvMRpTZKWbd50iGY5NZwFp3V2PvpKpSUWYKo9W4qJDxbL9ej
         fMWzONJqjjzklTpA/Fk6uhOK7QpmSyfI2HWma8nk5XgQ75Xyxc/Wb7Aq/6ApberS3vKd
         LR3gfuXFICLnkjA9A6+eTSVr6P9hJHKdI0vjjCPgjNJ3OmK42Vb+q1cl29RhWYo76c/X
         LmXA==
X-Forwarded-Encrypted: i=1; AKwUvBy+z3DhAVSOBScdfrQecBZYslclARe/S4g3KPtfmuwokiiRfvTKf+87anXvFSyItOXjQTc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKgU66qslCYBsXTlm12Vcp35xSyHlzrOTCKC/GSO2uTR2UYcifA
	z4fz0jOvYO1qIQS9h/7+DZc1Q68kOGvB9TH+eGltwIo+TLswQIZuLpv7gBzYa1YAcjo=
X-Gm-Gg: AYBFou3YlI/VVMpV/rpf1A5LkP/U2FnR/pTHNCNQwK09NljjURMheuBGyV+s0kGJ8D1
	iqKwPFO3D7mtAn5UY+ypyWcxkxsrTkASUlYmZKuKCUTJMd7W5mcpmh0o7vKRrEklFFjcJrawP0B
	xjE8ekNAGmpDCIEAbz1UL7ogv2D2ilf+JdfKXyVVCsFJ9dX2pJlNgQzDBbqfb1enyjO4+xOrhiH
	WaJKvj1SVqwBmJjLj9LN5tIJW8pbTWF0uzGhVqw+6VzjmzXuGMq8G7u97S1wA+KLMFsS2whgNJh
	fdOJhR8cCUJPnBBo2NNijTXncvNpbTo0MEhbQ9rrqOWZddjMkZjK7bfWKk2flgjSpDG6W0b5l9T
	iEsq0G7kY3LZvW9/ZVH8kBp3dvbp6dRpoL+DM0ZvjNRzMIKjn7FMegxu4BD+/o/qJ9/PYcvQrBb
	lCotksleJ6Z413Qs+lYd+EQHuoq8cUqkFiEdFGI7gddH15YOIKM40FdmdPrV52twAx71M=
X-Received: by 2002:a17:906:7951:b0:c1c:4a80:30c4 with SMTP id a640c23a62f3a-c31a9fe8eb4mr1910779466b.11.1792076550049;
        Thu, 15 Oct 2026 08:02:30 -0700 (PDT)
Received: from localhost ([199.201.64.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3ed9b3af45sm138963766b.33.2026.10.15.08.02.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 08:02:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Oct 2026 15:02:24 +0000
Message-Id: <DM5I470NY9DR.1KSN57GVF1X18@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <bot+bpf-ci@kernel.org>, <emil@etsalapatis.com>, <bpf@vger.kernel.org>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <daniel@iogearbox.net>, <martin.lau@kernel.org>,
 <yonghong.song@linux.dev>, <mason@kernel.org>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v4 1/8] bpf: Use mapping tree to zap arena VMAs
X-Mailer: aerc 0.21.0
References: <20261014233442.8392-2-emil@etsalapatis.com>
 <7d5f77a9d307bc2cc1ae43aa3cf628757e2342a26b02ddc9daa0276ff2d6c094@mail.kernel.org>
In-Reply-To: <7d5f77a9d307bc2cc1ae43aa3cf628757e2342a26b02ddc9daa0276ff2d6c094@mail.kernel.org>

On Thu Oct 15, 2026 at 12:33 AM UTC, bot+bpf-ci wrote:
>> bpf: Use mapping tree to zap arena VMAs
>
> TL;DR: Per-arena anon inode is no longer S_PRIVATE, so under SELinux aren=
a
> creation, mmap and fd passing may now be denied for existing policies. Wa=
s
> this intended? Commit message doesn't mention it.

Yes, it is intended as it is the only way to add anonymous inodes per-arena=
. We
need those to properly close out in subsequent patches the races already pr=
esent
in the code. Specifically, it lets us add exclusion between frees and arena=
 VM
faults without introducing a deadlock caused by mmap_lock(). I will mention=
 this
in the description.

We can also make a shared arena anonymous inode at init time and marking it=
 as=20
private would avoid introducing additional checks on arena-related calls, a=
t the
cost of traversing all mapped arena VMAs in the system. I don't think that'=
s too
crazy a cost and it would keep existing semantics unchanged.

>
>> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
>> --- a/kernel/bpf/arena.c
>> +++ b/kernel/bpf/arena.c
>
> [ ... ]
>
>> @@ -326,12 +330,18 @@ static struct bpf_map *arena_map_alloc(union bpf_a=
ttr *attr)
>>  	if (err)
>>  		goto err_free_scratch;
>>  	mutex_init(&arena->lock);
>> -	mutex_init(&arena->zap_mutex);
>>  	raw_res_spin_lock_init(&arena->spinlock);
>>  	err =3D populate_pgtable_except_pte(arena);
>>  	if (err)
>>  		goto err_destroy_rt;
>>
>> +	arena->file =3D anon_inode_create_getfile("bpf-map", &arena_backing_fo=
ps,
>> +						NULL, O_RDWR, NULL);
>> +	if (IS_ERR(arena->file)) {
>> +		err =3D PTR_ERR(arena->file);
>> +		goto err_destroy_rt;
>> +	}
>> +
>>  	return &arena->map;
>
> Does switching arena fds from the shared S_PRIVATE anon inode to a
> per-arena inode from anon_inode_create_getfile() change LSM behavior in a=
 way
> the commit message doesn't mention?
>
> anon_inode_create_getfile() creates a !S_PRIVATE inode and calls the
> inode_init_security_anon() hook:
>
>     inode =3D alloc_anon_inode(sb);
>     inode->i_flags &=3D ~S_PRIVATE;
>     ...
>     error =3D security_inode_init_security_anon(inode, &QSTR(name), conte=
xt_inode);
>
> Under SELinux this looks like it has two new effects for
> BPF_MAP_TYPE_ARENA.
>
> First, map creation now runs the anon inode create check:
>
>     map_create() -> map_create_alloc() -> arena_map_alloc()
>       -> anon_inode_create_getfile()
>         -> selinux_inode_init_security_anon()
>
>     return avc_has_perm(sid, isec->sid, isec->sclass, FILE__CREATE, &ad);
>
> A policy that doesn't grant the caller's domain anon_inode { create } on =
the
> transitioned "bpf-map" type would now fail arena creation with -EACCES,
> which the PTR_ERR() above returns to userspace.
>
> Second, every arena fd built by arena_map_get_file() via alloc_file_clone=
()
> of arena->file has an inode without S_PRIVATE.  Previously
> inode_sid_has_perm() returned early for the shared anon inode:
>
>     if (unlikely(IS_PRIVATE(inode)))
>         return 0;
>
> That early return no longer applies.  mmap() of the arena
> (selinux_mmap_file() -> file_map_prot_check() -> __file_has_perm() ->
> inode_has_perm()) and passing the fd over SCM_RIGHTS or binder
> (selinux_file_receive() -> file_has_perm()) would now need anon_inode
> { read write map } permission on that label, including in the receiving
> domain.
>
> Other map types keep the old unlabeled behavior because they still use
> anon_inode_getfd(), so only arena fds get these checks.  Existing
> SELinux-enforcing setups whose policy was written for the old behavior, s=
uch
> as a loader daemon that creates maps and hands the fds to confined
> applications, could start seeing denials on arena creation or mmap.  The
> later patches in this series still call anon_inode_create_getfile(), so t=
his
> isn't changed there.
>
> Was the new LSM labeling intended?  If the goal is only a unique inode an=
d
> mapping, could the old S_PRIVATE, unlabeled semantics be kept instead, or
> could the commit message at least document the new policy requirements?
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/386576=
86181

