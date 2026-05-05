Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA30017A300
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 18:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778007118; cv=none; b=kxISzWUBpZ9ngcWjDXhW2go/GZVz9VGH6XH05uKcb5VjTM4f1IDHxKuIMj0z2E8UOZ/vJEMLha/EPAHzgMGWS5LMuj94MIemkkJDOPY5U6Cx6b0dBdSJ+9atXbGEH3jjkldkjnOLWE9xgOH0//NQEKXgSWetD0yE3EIXDp5IhsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778007118; c=relaxed/simple;
	bh=r9qUVs/Nq5uwKhhdOVmDVzzEmSwcL8SKfjuYF4XAz5o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lzpC3VbDHLiUTYqNgJTZc/Ohogi/DYvRS7c66K3dg3f/RrImjTSTCtH9EmbL0bh/QhN101vS8PP2gjg24EpKsKcBbwuZOfX5PTZzYqnz6Y6xsHtBWEMUV7bLN20LI2aZNutXYZJnrS8KfjpzxTH1mvtH3ZLlvIsSHcFqCM0KWa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anjdmOt/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anjdmOt/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F35C2BCB4;
	Tue,  5 May 2026 18:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778007118;
	bh=r9qUVs/Nq5uwKhhdOVmDVzzEmSwcL8SKfjuYF4XAz5o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=anjdmOt/7+IgTKTnCIf4ma0tyYKdSrecDO3vvVxhdAiWzE+ldjaZDfhwFhwF1i/o+
	 VEgbt99nC77JeOeCuOGGUVNkID41mHB0g//ptGSFnR9ppf2s/3Nlw5cQoqZzUQUKqZ
	 JeTEKqBgm5yM//wLcNXm5XNxSVlsRFrvJeDy9aHey+VDslb9/7UqOvnFzCDMw5B0Gk
	 X/NE3eFgxzoFnh0jFJvsgdOqzX6pR6/zEqk18xU0HyEA7mzzWKYqjnN7hSaA/e+KGH
	 BYEkxObLrwOUrQVw29tYKRE9I6TATMrW5jTBYFnkbBpLMmBZVNEs0m2XSMEJY4GvNR
	 E74Vwalz6LplA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 03/19] unwind_user/sframe: Store .sframe section
 data in per-mm maple tree
Reply-To: sashiko@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260505121718.3572346-4-jremus@linux.ibm.com>
References: <20260505121718.3572346-4-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 18:51:57 +0000
Message-Id: <20260505185158.39F35C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Critical] Concurrency Use-After-Free and Double Free in sframe_remove_se=
ction
- [High] Unbounded memory leak of sframe_section allocations leading to Den=
ial of Service (OOM)
- [High] Missing MT_FLAGS_USE_RCU initialization breaks lockless NMI unwind=
ing
- [Medium] Child processes silently lose .sframe unwind data on fork()
- [Medium] Inclusive bound semantics in maple tree cause 1-byte overlap rej=
ections for contiguous sections
- [Low] Zero-address validation falsely rejects valid memory mappings
--

commit 3b41045a6b38a262cb32acf9ed118e4d667448dd
Author: Josh Poimboeuf <jpoimboe@kernel.org>

unwind_user/sframe: Store .sframe section data in per-mm maple tree

Associate an .sframe section with its mm by adding it to a per-mm maple
tree which is indexed by the corresponding text address range. A single
.sframe section can be associated with multiple text ranges.

> diff --git a/kernel/fork.c b/kernel/fork.c
> index f1ad69c6dc2d4..0d92fb1c61a99 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
[ ... ]
> @@ -1072,6 +1074,13 @@ static void mmap_init_lock(struct mm_struct *mm)
>  #endif
>  }
> =20
> +static void mm_init_sframe(struct mm_struct *mm)
> +{
> +#ifdef CONFIG_HAVE_UNWIND_USER_SFRAME
> +	mt_init(&mm->sframe_mt);
> +#endif
> +}
> +
>  static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struc=
t *p,

mt_init() initializes the maple tree with flags set to 0. Since stack
unwinding typically occurs in profiling interrupts (NMIs) which must
traverse the maple tree locklessly via RCU, does this missing
MT_FLAGS_USE_RCU flag allow concurrent modifications to perform in-place
updates instead of RCU-safe copy-on-write allocations? This could result in
the NMI unwinder observing corrupted tree states.

[ ... ]
> @@ -1100,6 +1109,7 @@ static struct mm_struct *mm_init(struct mm_struct *=
mm, struct task_struct *p,
>  	mm->pmd_huge_pte =3D NULL;
>  #endif
>  	mm_init_uprobes_state(mm);
> +	mm_init_sframe(mm);
>  	hugetlb_count_init(mm);
> =20
>  	mm_flags_clear_all(mm);

When a process forks, this initializes an empty sframe_mt for the child's
mm_struct. While dup_mmap() duplicates the parent's VMAs, it doesn't appear
that the registered .sframe entries are propagated to the child's maple tre=
e.
Will child processes silently lose their .sframe unwind data for shared
libraries registered prior to the fork?

> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
> index c128c1eeaca20..fdb2a49085638 100644
> --- a/kernel/unwind/sframe.c
> +++ b/kernel/unwind/sframe.c
[ ... ]
> @@ -81,6 +81,7 @@ static int sframe_read_header(struct sframe_section *se=
c)
>  int sframe_add_section(unsigned long sframe_start, unsigned long sframe_=
end,
>  		       unsigned long text_start, unsigned long text_end)
>  {
> +	struct maple_tree *sframe_mt =3D &current->mm->sframe_mt;
>  	struct vm_area_struct *sframe_vma, *text_vma;
>  	struct mm_struct *mm =3D current->mm;
>  	struct sframe_section *sec;
> @@ -88,10 +89,12 @@ int sframe_add_section(unsigned long sframe_start, un=
signed long sframe_end,
>  	if (!sframe_start || !sframe_end || !text_start || !text_end) {

Virtual addresses can legitimately be zero, such as when mmap_min_addr
permits it. Does checking !text_start falsely reject valid zero-address
VMAs? Checking the range bounds explicitly might be safer here.

[ ... ]
>  		}
>  	}
> =20
>  	sec =3D kzalloc(sizeof(*sec), GFP_KERNEL);

This allocates the section with GFP_KERNEL instead of GFP_KERNEL_ACCOUNT,
which bypasses memory cgroup limits.

Furthermore, is there a mechanism to clean up these allocated sections when
the corresponding VMA is torn down (e.g., via munmap)? Without cleanup hooks
in the VMA teardown paths, it looks like an application could repeatedly mm=
ap
an executable region, register it here, and munmap it, leaking kernel memory
and maple tree nodes indefinitely.

[ ... ]
> -	/* TODO nowhere to store it yet - just free it and return an error */
> -	ret =3D -ENOSYS;
> +	ret =3D mtree_insert_range(sframe_mt, sec->text_start, sec->text_end, s=
ec, GFP_KERNEL);

The Maple Tree API stores ranges inclusively as [first, last]. Since VMA
boundaries are exclusive, does passing sec->text_end directly cause the
maple tree range to incorrectly cover one extra byte?

If an application registers two perfectly contiguous .sframe sections, the
insertion of the second section could fail with -EEXIST because the first
section erroneously claims the first byte of the second section. Using
sec->text_end - 1 might prevent this overlap.

> +	if (ret) {
> +		dbg("mtree_insert_range failed: text=3D%lx-%lx\n",
> +		    sec->text_start, sec->text_end);
> +		goto err_free;
> +	}
> +
> +	return 0;
> =20
>  err_free:
>  	free_section(sec);
>  	return ret;
>  }
> =20
> +static int __sframe_remove_section(struct mm_struct *mm,
> +				   struct sframe_section *sec)
> +{
> +	if (!mtree_erase(&mm->sframe_mt, sec->text_start)) {
> +		dbg("mtree_erase failed: text=3D%lx\n", sec->text_start);
> +		return -EINVAL;
> +	}
> +
> +	free_section(sec);
> +
> +	return 0;
> +}
> +
>  int sframe_remove_section(unsigned long sframe_start)
>  {
> -	return -ENOSYS;
> +	struct mm_struct *mm =3D current->mm;
> +	struct sframe_section *sec;
> +	unsigned long index =3D 0;
> +	bool found =3D false;
> +	int ret =3D 0;
> +
> +	mt_for_each(&mm->sframe_mt, sec, index, ULONG_MAX) {
> +		if (sec->sframe_start =3D=3D sframe_start) {

Can concurrent calls to sframe_remove_section() cause a use-after-free and
subsequent double free?

mt_for_each() locklessly iterates mm->sframe_mt, and internally acquires and
drops the RCU read lock, meaning the returned sec pointer has no lifetime
protection in the loop body.

If two threads concurrently invoke sframe_remove_section(), both could
receive the exact same sec pointer from the tree. Thread A could then call
__sframe_remove_section(), erasing the entry and freeing sec via
free_section(). Thread B would then evaluate the if statement using the
freed sec pointer, causing a use-after-free read, and potentially proceeding
to free it again.

Additionally, does free_section() need to use kfree_rcu() instead of
kfree() to prevent lockless NMI unwinders from hitting a use-after-free
when reading payloads?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505121718.3572=
346-1-jremus@linux.ibm.com?part=3D3
