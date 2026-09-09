Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1452D9EED
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 05:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788932100; cv=none; b=b6Qx57DbJ5L1C6RFSxa4OMXmEh3Gfjofp/kZ22bLItr4mD5EKiWSLedWnb/K5Y74h+TubSwUMo5zLmC33jksyCaRHk+1agVV5VvYSoCTx1Wqol7D7PcczUeBpzHEC43VWkeeZjwn026aBdMkDtVzc2YAUthNkonYt0VOQcpbKYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788932100; c=relaxed/simple;
	bh=1vgi6jpvPLi8A7PEglW1p0mH6ezu6IHra8QdquTsqwo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=FRTngJkcmyXqpfFvINruFs+cx6QCPBKQKrRDwRGOKnSwCdwBmmwuNHgvNks/pNFxx5VY3zqPjv5avvA3PBhEPOvgHEykAsH0fc9OsJLkOMshBHbTXI3u1RNYJpQwHw8q328fRwTh49u0nCTwfv2IT5X+1FARX8bnKa5btDP6Aaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDLlXzD/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDLlXzD/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E181F00A3A;
	Wed,  9 Sep 2026 05:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788932098;
	bh=FscWNqIx3usrUbkZjvmAN+PVwrrhJx2MuVNJwk0WENU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=GDLlXzD/3MgNQDghqBEC1h7sPNgevcRfM7pu+I3Vbx/xcGpO2h2EeGJ41/DyOH0gF
	 1BhGIRB0JUhhjpqW8uUG5HOOdTy+RcuMEkbqxp+CrbtomgbiyPasNxHrVs8Zaok3a6
	 DnT2vANDDLjsfD5oKjYhwL5niRU5lAp3p+1+Dt9v/pCn/a6yZIEX8px8wIAZx8opNl
	 qMACsseGQjWJxjZuFNMxz4rDYK/L7nBEP2gVwX5RZk2r+T9VnBxQg3nxw6Zyc/wvVh
	 5fYf9s/nASNtGZsNylFXWPKXvkDQChuC0W3H8JikikoHUUvF/IlQ+xZcZfnVkpU0IJ
	 rSGBubzw89i0Q==
Content-Type: multipart/mixed; boundary="===============8940476328996985755=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <73a24be8aa01ad29b7697d58b6a6f0e150d1cc27ffe0b7484f6d842c5e508491@mail.kernel.org>
In-Reply-To: <20260909042907.1734153-2-xyx2021@mail.ustc.edu.cn>
References: <20260909042907.1734153-2-xyx2021@mail.ustc.edu.cn>
Subject: Re: [PATCH bpf 1/2] bpf: Invalidate iterator-owned BTF pointers on destroy
From: bot+bpf-ci@kernel.org
To: xyx2021@mail.ustc.edu.cn,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,yonghong.song@linux.dev,puranjay@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  9 Sep 2026 05:34:57 +0000 (UTC)

--===============8940476328996985755==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 72a3f5998dd2..be4978629ae5 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14105,6 +14105,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  			regs[BPF_REG_0].btf = desc_btf;
>  			regs[BPF_REG_0].type = type;
>  			regs[BPF_REG_0].btf_id = ptr_type_id;
> +
> +			if (bpf_is_iter_next_kfunc(&meta) && !(type & MEM_RCU))
> +				regs[BPF_REG_0].parent_id = meta.ref_obj.id;
>  		}
>
>  		if (is_kfunc_ret_null(&meta)) {

Does this fix the complete issue? The new parent_id link invalidates the
register returned by the iterator's next kfunc, but what about trusted
pointers loaded from it?

For the task_vma iterator specifically, bpf_iter_task_vma_next() returns
a pointer to the VMA snapshot that lives in kit->data. The verifier sees
this as PTR_TO_BTF_ID | PTR_TRUSTED with the new parent_id set to the
iterator's reference ID.

When a program loads a field like vma->vm_file, check_ptr_to_btf_access()
qualifies it as trusted (is_trusted_reg() returns true), and the result
gets PTR_TRUSTED | PTR_MAYBE_NULL because vm_file is on the allowlist:

kernel/bpf/verifier.c:
    BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct) {
        struct mm_struct *vm_mm;
        struct file *vm_file;
    };

Then mark_btf_ld_reg() writes the result register by calling
mark_reg_known_zero() -> __mark_reg_known(), which clears the parent_id:

kernel/bpf/verifier.c:__mark_reg_known() {
    ...
    reg->parent_id = 0;
}

mark_btf_ld_reg() never restores it - it only sets type, btf, and btf_id
(plus id when PTR_MAYBE_NULL). So release_reference() won't invalidate
the derived register because it only invalidates when
'reg->id != id && reg->parent_id != id' fails.

Can a program reach the freed object through this path?

    vma = bpf_iter_task_vma_next(&it);
    if (!vma) goto out;
    f = vma->vm_file;               /* PTR_TRUSTED, parent_id == 0 */
    bpf_iter_task_vma_destroy(&it); /* fput(f); mmput_async(mm) */
    if (f)
        bpf_get_file_xattr(f, name, &dynptr);

bpf_iter_task_vma_destroy() calls bpf_iter_task_vma_snapshot_reset(),
which does fput(snap->vm_file) and drops the mm reference. After that,
the program tries to use the freed struct file pointer.

The verifier accepts the bpf_get_file_xattr() call because
check_kfunc_args() only requires is_trusted_reg() for KF_ARG_PTR_TO_BTF_ID,
and 'f' still has PTR_TRUSTED set. bpf_get_file_xattr() immediately does
file_dentry(file) on the freed struct file.

This is reachable: the iterator kfuncs are registered on common_kfunc_set
for BPF_PROG_TYPE_UNSPEC (all program types), and bpf_fs_kfunc_set is
registered for BPF_PROG_TYPE_LSM, so a single sleepable LSM program has
access to both.

The companion selftest added by ad1220255655 ("selftests/bpf: Reject task
VMA snapshot use after destroy") only exercises the direct register
('return vma_ptr->vm_start'), so it passes while the vm_file/vm_mm path
stays open.

I should note that the underlying gap - BTF field walks never inherit
parent_id - is pre-existing and verifier-wide (parent_id is written only
by the dynptr paths and by kfunc return values). The same shape exists for
other KF_ACQUIRE/KF_RELEASE pairs, like BTF_TYPE_SAFE_TRUSTED(struct file)
{ struct inode *f_inode; } with bpf_get_task_exe_file()/bpf_put_file().
So this isn't a defect newly introduced by the hunk.

It is reported because this patch's stated purpose is to close exactly
this UAF for exactly this object, and the two fields left trusted
(vm_mm/vm_file) are the only two fields whose lifetime the destructor
releases.

Would it make sense to either propagate the source register's parent_id in
mark_btf_ld_reg() for the PTR_TO_BTF_ID case, or drop vm_mm/vm_file from
BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct) while the pointer is
iterator-owned? A selftest reading vma->vm_file after
bpf_iter_task_vma_destroy() would pin the behaviour.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34312299210
--===============8940476328996985755==--
