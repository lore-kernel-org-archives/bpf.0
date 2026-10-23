Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792792694;
	b=H8YT+/ZOOGjjmcljbq/SxErAHtH5FFU/l7APlvTnOuym+tt5PtJR7YfG4axRNmUG/kTJ
	 /VbNLMa5zCVkb4uyHgaGGX0QtHUFso4KGZpeVCydY7aGdPWDlaxkCR8JHQjJMAZI3XGpw
	 vZ9UzLibIANWRNn9LHXJHmP7Oojjr8oea1m1BCeUGHFr2FEtQr5ljDd3oAzTP+HuY2jsN
	 k6+wXVB91rpiNm0E4ho3IKgBWeyPd4gLqMZjw11TkLEbV2QD0DNGghMENojCqM04P1YZr
	 3P1fYtaH/Dohvz+zSGWmy96jug3n6JU3ygTOh30JFzXjN9XwGJvM895xCtyfqDoUIDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792792694;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=z7h3Otz7HDW1QBSJKc4+8lgmVdgQEJTtSf6gl2bBADc=;
	b=QegrXC3ZZkSW3H/bTXlveK1WM/mlNxoLk6VEYSRGHCnx/nbWOlNSBmwN3jhCKblTeX/e
	 GcylxvArNubi51MPGmf9NMCiEMY+pPgnG7kYbqKP6iMtgNeLDJG9D1Nwdee/q7qhl7Tst
	 jDBBJlmXE28w02FzuAPi7dRw+7zW9Ww5CDXI+HW4Sj8F97nLfqtMXAlTox5LebN8KD4uf
	 aJVywQYCEW5//L4fHy3pbAbSYnZZjTAx25QJXBdCrTfTvWsd/donhzOMyxnq22NSVmyb+
	 EEwbdf95XTHlHyQI8NolpVaHIs8INNPL3pIVV2tSuypqhgYEAN7miL6cKHedz9WObtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tb+8eFdO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3BD606A31B
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 21:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tb+8eFdO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E789B1F01825;
	Fri, 23 Oct 2026 21:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792792694;
	bh=z7h3Otz7HDW1QBSJKc4+8lgmVdgQEJTtSf6gl2bBADc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Tb+8eFdO0RelFSDZ+D4/mdwYY6D4Pf3/Oo6IK/JlnRzSA4IBvYS2CtpXg9jqTpoue
	 4vLaDcArLUpK47hueQEdV+nmoduI70L93rOqZ9S1MGXaAxkz7EHFw16HlOXbZsYA01
	 fx6NAgSXHsqozxwNICxE2RoKmkI22lPoIYxbo2+bdwjr7OIS+KIh/P4BpUsORTi67i
	 eVL498fyQBwJdDsjVLHLLIRquf03T++s/dQJDuDbWvb+n5iVn22heRK1kbyE1X9AIk
	 Xu/wjSXZOrtBJW9yKReCwtDhvQZ75BI2SV6qzOUplXPkuzx/YaIZMROzAHaJFIUM15
	 kc7R4kvcPzaEg==
Message-ID: <sashiko-outbox-183266@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 1/5] bpf: Don't apply the trusted field
 lists to an RCU-protected parent
Reply-To: sashiko-reviews@lists.linux.dev
To: "Justin Suess" <utilityemal77@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261023212041.884996-2-utilityemal77@gmail.com>
References: <20261023212041.884996-1-utilityemal77@gmail.com>
 <20261023212041.884996-2-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 21:58:13 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] bpf: unsafe RCU trust for file->f_inode in type_is_rcu_or_null()
- [High] bpf: bpf_inode_storage_get() accepts unreferenced RCU f_inode
- [High] bpf: check_ptr_to_btf_access() leaves RCU parent fields as plain P=
TR_TO_BTF_ID
--

commit 07389cd2696e6821d95557c4e45fb257d164b7dd
Author: Justin Suess <utilityemal77@gmail.com>

bpf: Don't apply the trusted field lists to an RCU-protected parent

This commit restricts the __safe_trusted and __safe_trusted_or_null BTF
field lists in check_ptr_to_btf_access() to trusted parent registers so
that fields walked from an RCU-protected parent do not gain PTR_TRUSTED.
It also adds struct file's f_inode field to BTF_TYPE_SAFE_RCU_OR_NULL and
type_is_rcu_or_null().

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5601d20562186..4a32875d70778 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6517,6 +6517,11 @@ BTF_TYPE_SAFE_RCU_OR_NULL(struct request_sock) {
>  	struct sock *sk;
>  };
> =20
> +/* struct file is SLAB_TYPESAFE_BY_RCU. A reused file has f_inode =3D=3D=
 NULL. */
> +BTF_TYPE_SAFE_RCU_OR_NULL(struct file) {
> +	struct inode *f_inode;
> +};

[Severity: High]
Is it always safe to treat file->f_inode walked from an RCU-protected
struct file as MEM_RCU after a NULL check?

When a BPF program inside an RCU read-side critical section reads
file->f_inode from a PTR_TO_BTF_ID | MEM_RCU struct file (such as
mm->exe_file or files->fd_array[i]) and checks it for non-NULL, the
verifier marks the resulting struct inode pointer as PTR_TO_BTF_ID |
MEM_RCU. Because bpf_may_fault_on_deref() is false for that type,
bpf_convert_ctx_accesses() emits raw BPF_LDX | BPF_MEM loads without
BPF_PROBE_MEM.

However, not all inodes reachable through file->f_inode are freed after an
RCU grace period. For example, pipefs uses free_inode_nonrcu():

fs/pipe.c:
static const struct super_operations pipefs_ops =3D {
	.destroy_inode =3D free_inode_nonrcu,
	.statfs =3D simple_statfs,
};

In destroy_inode(), when ops->destroy_inode is set and ops->free_inode is
NULL, the inode is freed synchronously via kmem_cache_free(inode_cachep,
inode) without call_rcu():

fs/inode.c:destroy_inode() {
	...
	if (ops->destroy_inode) {
		ops->destroy_inode(inode);
		if (!ops->free_inode)
			return;
	}
	inode->free_inode =3D ops->free_inode;
	call_rcu(&inode->i_rcu, i_callback);
}

In addition, because filp_cache uses SLAB_TYPESAFE_BY_RCU and file_free()
frees struct file immediately without an RCU grace period, a struct file
closed during the RCU critical section only transiently has f_inode set to
NULL in init_file() before file_init_path() or do_dentry_open() populates
file->f_inode with the newly opened file's inode:

fs/file_table.c:file_init_path() {
	file->__f_path =3D *path;
	file->f_inode =3D path->dentry->d_inode;
	file->f_mapping =3D path->dentry->d_inode->i_mapping;
}

If a SLAB_TYPESAFE_BY_RCU struct file (including one read from
mm->exe_file) is closed, reallocated for a pipe via create_pipe_files() ->
alloc_file_pseudo(), and closed again within the BPF program's RCU
critical section, can the BPF program dereference a freed pipefs struct
inode without BPF_PROBE_MEM?

> =20
>  /* full trusted: these fields are trusted even outside of RCU CS and nev=
er NULL */
>  BTF_TYPE_SAFE_TRUSTED(struct bpf_iter_meta) {
>  	struct seq_file *seq;
> @@ -6593,6 +6598,7 @@ static bool type_is_rcu_or_null(struct bpf_verifier=
_env *env,
>  	BTF_TYPE_EMIT(BTF_TYPE_SAFE_RCU_OR_NULL(struct mm_struct));
>  	BTF_TYPE_EMIT(BTF_TYPE_SAFE_RCU_OR_NULL(struct sk_buff));
>  	BTF_TYPE_EMIT(BTF_TYPE_SAFE_RCU_OR_NULL(struct request_sock));
> +	BTF_TYPE_EMIT(BTF_TYPE_SAFE_RCU_OR_NULL(struct file));
> =20
>  	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id, "=
__safe_rcu_or_null");
>  }

[Severity: High]
Can exposing file->f_inode as PTR_TO_BTF_ID | MEM_RCU here also allow
bpf_inode_storage_get() to allocate local storage on an inode that is
already being destroyed, leading to a memory leak and use-after-free on
inode->i_security?

bpf_inode_storage_get_proto takes ARG_PTR_TO_BTF_ID_OR_NULL for its inode
argument, which check_reg_type() matches against btf_ptr_types:

kernel/bpf/verifier.c:
static const struct bpf_reg_types btf_ptr_types =3D {
	.types =3D {
		PTR_TO_BTF_ID,
		PTR_TO_BTF_ID | PTR_TRUSTED,
		PTR_TO_BTF_ID | MEM_RCU,
	},
};

Unlike bpf_task_storage_get(), bpf_cgrp_storage_get(), and
bpf_sk_storage_get(), bpf_inode_storage_get() does not verify that the
inode still has a non-zero reference count before creating storage:

kernel/bpf/bpf_inode_storage.c:bpf_inode_storage_get() {
	...
	/* This helper must only called from where the inode is guaranteed
	 * to have a refcount and cannot be freed.
	 */
	if (flags & BPF_LOCAL_STORAGE_GET_F_CREATE) {
		sdata =3D bpf_local_storage_update(
			inode, (struct bpf_local_storage_map *)map, value,
			BPF_NOEXIST, false);
		return IS_ERR(sdata) ? NULL : sdata->data;
	}
	...
}

When the last reference to an unlinked file (such as mm->exe_file) is
dropped, __fput() -> dput() -> iput_final() -> evict() -> destroy_inode()
-> __destroy_inode() calls security_inode_free(inode) before the RCU grace
period starts:

security/security.c:security_inode_free() {
	call_void_hook(inode_free_security, inode);
	if (!inode->i_security)
		return;
	call_rcu((struct rcu_head *)inode->i_security, inode_free_by_rcu);
}

This runs bpf_inode_storage_free(inode) synchronously while leaving
inode->i_security non-NULL until inode_free_by_rcu() runs after the grace
period.

If a BPF LSM program inside bpf_rcu_read_lock() walks file =3D mm->exe_file
and inode =3D file->f_inode and calls bpf_inode_storage_get() with
BPF_LOCAL_STORAGE_GET_F_CREATE after bpf_inode_storage_free() has already
run, bpf_local_storage_update() will attach a new bpf_local_storage with
storage->owner =3D inode to bpf_inode(inode)->storage. Once the RCU grace
period finishes, inode and inode->i_security are freed without
bpf_inode_storage_free() running again, and subsequent map teardown or
element deletion in bpf_selem_unlink_storage_nolock_misc() will read from
the freed inode and write NULL into the freed inode->i_security blob:

kernel/bpf/bpf_local_storage.c:bpf_selem_unlink_storage_nolock_misc() {
	...
	if (free_local_storage) {
		local_storage->owner =3D NULL;

		/* After this RCU_INIT, owner may be freed and cannot be used */
		RCU_INIT_POINTER(*owner_storage(smap, owner), NULL);
	}
	...
}

> @@ -6798,10 +6804,14 @@ static int check_ptr_to_btf_access(struct bpf_ver=
ifier_env *env,
>  		 *
>  		 * A regular RCU-protected pointer with __rcu tag can also be deemed
>  		 * trusted if we are in an RCU CS. Such pointer can be NULL.
> +		 *
> +		 * If the parent is not trusted, the field can't regain trusted status.
>  		 */
> -		if (type_is_trusted(env, reg, field_name, btf_id)) {
> +		bool trusted =3D is_trusted_reg(env, reg);
> +
> +		if (trusted && type_is_trusted(env, reg, field_name, btf_id)) {
>  			flag |=3D PTR_TRUSTED;
> -		} else if (type_is_trusted_or_null(env, reg, field_name, btf_id)) {
> +		} else if (trusted && type_is_trusted_or_null(env, reg, field_name, bt=
f_id)) {
>  			flag |=3D PTR_TRUSTED | PTR_MAYBE_NULL;
>  		} else if (in_rcu_cs(env) && !type_may_be_null(reg->type)) {
>  			if (type_is_rcu(env, reg, field_name, btf_id)) {

[Severity: High]
When reg is an RCU-protected pointer (is_rcu_reg(reg) is true and trusted
is false) and we are in an RCU critical section, what happens to fields in
type_is_trusted() or type_is_trusted_or_null() (such as vma->vm_file,
vma->vm_mm, dentry->d_inode, socket->sk, or bprm->file) or untagged
fields (such as exe_file->f_path.dentry or exe_file->f_mapping->host)?

Looking at the rest of this if/else chain in check_ptr_to_btf_access():

		} else if (in_rcu_cs(env) && !type_may_be_null(reg->type)) {
			if (type_is_rcu(env, reg, field_name, btf_id)) {
				/* ignore __rcu tag and mark it MEM_RCU */
				flag |=3D MEM_RCU;
			} else if (flag & MEM_RCU ||
				   type_is_rcu_or_null(env, reg, field_name, btf_id)) {
				...
			} else if (flag & (MEM_PERCPU | MEM_USER)) {
				/* keep as-is */
			} else {
				/* walking unknown pointers yields old deprecated PTR_TO_BTF_ID */
				clear_trusted_flags(&flag);
			}
		}

Rather than being marked PTR_UNTRUSTED as described in the commit message,
those fields fall into the else branch and call clear_trusted_flags(&flag)
(and any __nullable PTR_MAYBE_NULL bit is stripped afterwards because
bpf_may_fault_on_deref(PTR_TO_BTF_ID) is true). That leaves the child
register as a plain PTR_TO_BTF_ID with neither MEM_RCU nor PTR_UNTRUSTED.

When the program calls bpf_rcu_read_unlock(),
invalidate_rcu_protected_refs() only clears registers with MEM_RCU:

kernel/bpf/verifier.c:invalidate_rcu_protected_refs() {
	bpf_for_each_reg_in_vstate_mask(env->cur_state, state, reg, stack, clear_m=
ask, ({
		if (reg->type & MEM_RCU) {
			bpf_diag_mod_begin(env, reg, NULL, BPF_DIAG_MOD_WRITE);
			reg->type &=3D ~(MEM_RCU | PTR_MAYBE_NULL | NON_OWN_REF);
			reg->type |=3D PTR_UNTRUSTED;
			bpf_diag_mod_end(env);
		}
	}));
}

Because plain PTR_TO_BTF_ID registers survive bpf_rcu_read_unlock() and
are accepted by btf_ptr_types and btf_id_sock_common_types, doesn't this
allow a sleepable BPF program to walk a field like exe_file->f_path.dentry
->d_inode or vma->vm_file under bpf_rcu_read_lock() and pass it to helpers
such as bpf_ima_inode_hash(), bpf_ima_file_hash(), bpf_inode_storage_get(),
or bpf_sk_storage_get() after bpf_rcu_read_unlock() without RCU protection
or a NULL check?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023212041.8849=
96-1-utilityemal77@gmail.com?part=3D1
