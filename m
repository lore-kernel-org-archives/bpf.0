Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDB8277CA5
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 15:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779375869; cv=none; b=h7zw4u3vrgbj0qp0+qgqLRZcPITdC6MMW9s6te/LqwsVAEvkoFUlEwV71aeGgdRbUe3o5RkpMb+mFgOCyBHIU/2MJBxkJ8TOofKS1wkdcLjyt6+JcZ6k3Wmiio1Cu/jb5G4G2C/UvQUwSAvOCj/yq6geb6bNutpPWiUp01C/KBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779375869; c=relaxed/simple;
	bh=+qpyPPTXwzG0yuPHGTAN8mhzBpw7cdOyQNAeMQDU6PY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qC0QwmpcTiiq1VGzBpXRltg0CqFmkz1DCCMJr3la/REXQHiSlnLFRVuuJIVXGOaxnmHPHAmrnyCSa61Lqoi4z60GgKxXPs+0xSzdd1YUsbt+cl+iHc74gLV2/Q/VOglpVWb1H6SH2g1UXR+NY6mJlz+wYTdHwlsqpsubeKtCNQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjelfDS3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjelfDS3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE671F000E9;
	Thu, 21 May 2026 15:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779375867;
	bh=q474yqf5ruHIcAoM7DgOAtxUq1iTneITqobQgyYS5pY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BjelfDS3phIiUCHGkz3O04rzNK4WJAHJy3++EIPQmSBb01RlUek79vvb3D9VbniGt
	 RhRP59mvPhEnv0pOcInxksTtoDb0isagLWMPoQFTSJ+sTLU5+nbxOhLX+IxOGtjlGp
	 KYADlPVh1isTuFA+XBHTN+d1IxiDe6m4MRSjwOEacQJHwzphSFx5310AzJMo3SnsFA
	 rglPwGhE4fC2pX+2MyYj7jrDHIg7KFk4mOmepKY/JsyT9U5k6kDiyZj4rBcCrnMUzY
	 op55MiOEkt2wBdFYqmcLcdWC+lD7uGW2LtTDzUFBtL/b/l7vMUucPQVrEi2oEnk1BW
	 urLmyRoj2dQjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 03/20] unwind_user/sframe: Store .sframe section
 data in per-mm maple tree
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260521142546.3908498-4-jremus@linux.ibm.com>
References: <20260521142546.3908498-4-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 15:04:26 +0000
Message-Id: <20260521150427.8BE671F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Concurrent `sframe_remove_section` calls lead to a TOCTOU race cau=
sing SRCU double-queueing and memory leaks.
- [High] The `sframe_mt` maple tree is initialized without `MT_FLAGS_USE_RC=
U`, causing use-after-free during lockless traversal.
- [High] `sframe_free_mm()` bypasses SRCU and synchronously frees objects, =
racing with concurrent SRCU readers.
- [Low] Mixing `scoped_guard()` with goto-based error handling violates sub=
system cleanup rules.
- [Low] `current_has_sframe()` dereferences `current->mm` without including=
 `<linux/sched.h>`, causing incomplete type errors.
--

commit 4b0aee91d63748e3221127b74ad789be7e3d2c6b
Author: Josh Poimboeuf <jpoimboe@kernel.org>
Subject: unwind_user/sframe: Store .sframe section data in per-mm maple tree

Associate an .sframe section with its mm by adding it to a per-mm maple
tree which is indexed by the corresponding text address range.  A single
.sframe section can be associated with multiple text ranges.

> diff --git a/include/linux/sframe.h b/include/linux/sframe.h
> index 0642595534f95..38047760e252e 100644
> --- a/include/linux/sframe.h
> +++ b/include/linux/sframe.h
> @@ -19,18 +24,31 @@ struct sframe_section {
>  	signed char	fp_off;
>  };
> =20
> +#define INIT_MM_SFRAME .sframe_mt =3D MTREE_INIT(sframe_mt, 0),

[Severity: High]
Does this maple tree initialization need the MT_FLAGS_USE_RCU flag?

Since sframe_remove_section() traverses the tree locklessly using
mt_for_each(), omitting the RCU flag means internal tree nodes split or
merged by concurrent updates could be freed immediately via
kmem_cache_free(), potentially causing a use-after-free for the
lockless readers.

> +extern void sframe_free_mm(struct mm_struct *mm);
> +
>  extern int sframe_add_section(unsigned long sframe_start, unsigned long =
sframe_end,
>  			      unsigned long text_start, unsigned long text_end);
>  extern int sframe_remove_section(unsigned long sframe_addr);
> =20
> +static inline bool current_has_sframe(void)
> +{
> +	struct mm_struct *mm =3D current->mm;
> +
> +	return mm && !mtree_empty(&mm->sframe_mt);
> +}

[Severity: Low]
Will this compile cleanly in all contexts?

The header dereferences current->mm, but <linux/sched.h> doesn't appear
to be included here. Files including <linux/sframe.h> without also
including sched.h might fail to compile with incomplete type errors.

> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
> index d24e9d4f8bef7..46dba3cb016df 100644
> --- a/kernel/unwind/sframe.c
> +++ b/kernel/unwind/sframe.c
[ ... ]
> @@ -122,15 +125,74 @@ int sframe_add_section(unsigned long sframe_start, =
unsigned long sframe_end,
>  	if (ret)
>  		goto err_free;
> =20
> -	/* TODO nowhere to store it yet - just free it and return an error */
> -	ret =3D -ENOSYS;
> +	ret =3D mtree_insert_range(sframe_mt, sec->text_start, sec->text_end - =
1,
> +				 sec, GFP_KERNEL_ACCOUNT);
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

[Severity: Low]
This isn't a bug, but does mixing goto-based error handling (err_free)
with the scoped_guard() used earlier in this function violate the
cleanup subsystem guidelines?

The standard suggests managing the sec pointer via __free(kfree) instead
of using goto labels to avoid confusing ownership semantics.

> +static int __sframe_remove_section(struct mm_struct *mm,
> +				   struct sframe_section *sec)
> +{
> +	if (!mtree_erase(&mm->sframe_mt, sec->text_start)) {
> +		dbg("mtree_erase failed: text=3D%lx\n", sec->text_start);
> +		return -EINVAL;
> +	}
> +
> +	call_srcu(&sframe_srcu, &sec->rcu, sframe_free_srcu);
> +
> +	return 0;
> +}

[Severity: High]
Could this lockless tree access result in corrupting the SRCU callback
list and leaking memory?

If a concurrent thread inserts a new section at the same text_start
address before mtree_erase() is called, mtree_erase() will successfully
remove and return the new section.

Because the return value of mtree_erase() is not checked against sec,
the code proceeds to call call_srcu() on the original sec pointer. This
could double-queue the old section's RCU head and permanently leak the
newly inserted section.

[ ... ]
> +void sframe_free_mm(struct mm_struct *mm)
> +{
> +	struct sframe_section *sec;
> +	unsigned long index =3D 0;
> +
> +	if (!mm)
> +		return;
> +
> +	mt_for_each(&mm->sframe_mt, sec, index, ULONG_MAX)
> +		free_section(sec);
> +
> +	mtree_destroy(&mm->sframe_mt);
>  }

[Severity: High]
Does bypassing the SRCU grace period here cause a use-after-free for
concurrent readers?

If an unwinder accesses a section under sframe_srcu and then drops its
mm reference, triggering teardown, the synchronous free_section()
(which calls kfree directly) will free the section while the unwinder
is still relying on SRCU to keep it alive. Should this teardown path
use call_srcu() as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521142546.3908=
498-1-jremus@linux.ibm.com?part=3D3
