Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793127092;
	b=GMZsrMk7RximtSt5pLkOKFNe2KDl/tyAfqhWnSm7H/f7iMgAbdeIgXHjJQY2mi5RXiRI
	 4x0K7IRAprCELQXNSjwl51DjSEpIXRUfeSlvG1tYm0MEsTVimgEjToFU6H5d9pJY8z8a+
	 7IfdHRGhJX8IlXiCjBCyWBFUMu9f4Xe24pVp/TT2zydLUn2ouwfcsIXYtBxNdIoU111Rj
	 F/XkV2Vd3Piyg4ZXkeUVFyw48E1sXDo3Jjh22k+tJoknJneJjbD2Ygearpj1cykkg2iU0
	 RuuDm0rj7NZtpVeKpdemObos/UhUclKMjHnyGNnrtGdv5l2PPM2OAP9SD8vEJqAjEyw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793127092;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=UJlLnl+V5fVkcEdrgjKFPN24Q/fJ++IZ4ZhlDmWxnT0=;
	b=fGtGhb2u0SLSd0RpngDlCOXT3D67MNKqD8XWYSE2HQQyXYKg7aUMkcyEp9Z+KPKcX8e8
	 M5gJSbD9uYyMo6m/lpd8wS543g/8XgToyFYFwQGvBlJfVCwlvruQ6nLD81b5ItloByQ6O
	 S0RRVBhrP7ansFzetHcGHPOFcXs8oaNcJU6oSis+zAfP0sebUoDJSBPwXLOsKV8S9ACfv
	 zf5cc13tIGYRK8w6RIV71gqWjXRAqnMuegWn1I/XQSQujs9dobjwJqCgIJXQGqnHSJfXL
	 BXyQZuBVhtb2WSC3Po9XMuAm9OP63T7xixX03pT10/yCG5cm+HA8DKMm5yH2evCHzMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HFK9DQOj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939E0606A31D
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 18:51:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 939E0606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HFK9DQOj
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c49b431f022so22144566b.1
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 11:51:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793127090; cv=none;
        d=google.com; s=arc-20260327;
        b=dGAXPDHEzKl6dAZY09Lp+0N7f8WNk/PTYCgkleMyxbXOmUH50Edulwai4FwlbfrCqF
         dZCbJtr2/j7Kts8qEJDoCxxopCNZq6KiyGDWy+s/RmZlzHPZwdEDnFi6qAWbP2ZXQnSu
         D2SsN5wVjLTRvfiOoM4pOtE8sVbuvOILub3Al7JPw+K3FwCtRUqoYWpp1gqogh+i7TMD
         iWKlfnqNrmKqmvFrdXKC/jBGzvnkhCvpAYd4ZqD4AAgOWfGUV7nER7oOG1EZsWdBsAW8
         2d9bcc6T6C1qU+Ur1wQOSAsHfy2aF9WmNLYdfv1buV45pOJ04EaduvjfWjIx3QS8vTGE
         gDgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UJlLnl+V5fVkcEdrgjKFPN24Q/fJ++IZ4ZhlDmWxnT0=;
        fh=FCJkmsDOgCygDXPxgVgj6U4n3sEsayfNlJVx97ZjQWg=;
        b=VPSyRqwDPWu9DBxcXVbbKsoZ3HyA4G9rNGXHjp5VPQq08l7SjgWsoeKrVU9twTQzXy
         Ga4xNS7W71L24Dff02EHtlEgn3gvD3PgrhB+rbv5oisuAEfNsWLKQ36OirB7Myzz+WfM
         Ifyeon5ZBF3MnRI8pxTzq0jEOT5EisvV8+KLgT5TDud5g4o4bzV7u8jXOn6XmR5fgV3p
         p3UzMKQM/tU3qiQ+NI90EVXh1wtnhXkCMj3lTYvbFpn6mjcDfrbuPrUQpDuf7LUMO46y
         7BLFTPglskcBiZxu4ZOJaLQBD7Omkq/5OmrR33KvH7A4M2bZf7M0ZHwZB6ptsNAVX39Z
         QWCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793127090; x=1793731890; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UJlLnl+V5fVkcEdrgjKFPN24Q/fJ++IZ4ZhlDmWxnT0=;
        b=HFK9DQOjx55GzwyinowY3WKQr1IsXRiJeV+D7Z8hkiYPym2ZUBwoZvUifqN/FnkNGU
         pfa1ZewvhEMvZLoaCIPFZp4tA/umOO4oOn0eM3xlRhU2sdWIJfNsPw9HVJXR4LYjiytX
         dUAGwL90rw0Q5w+OWsW5iboZVP9RCytMSNYKe3ji15diP1zhAfgrHC9FvXhRMxxUMt35
         TQ2tHe1FHlUZ2NICIb0rhXxsSpvA5sFGf5zLgnOgSw/RZnKbxxQN9s376gQ8m4D1+J80
         lvL/AJdZ7uKnroRkKZncUslhbEYHXR8yj6xbpQX2rU8tK9ueLcaFgAw4VAp3h++AYDrG
         cmtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793127090; x=1793731890;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UJlLnl+V5fVkcEdrgjKFPN24Q/fJ++IZ4ZhlDmWxnT0=;
        b=n1Oe0UQyOPN6lk9z8u0OvjWeVyM6OrJQuri5qy3wo0+JLtWp9PQbhlzUHLMhufFrUM
         I8rnLN481fPM1sj/mC7h1pkGAAX/KzjmfyHQrXZWc92cvKL7rGXO4uWuwZjhijv//MSe
         SrSjwt/wyXp05cRVqqffYNH+msa0CITT01fIFX9m1rcDoCtqVKTUb+bcg/8hjWGQbNhN
         hOfKyJRrTE9+ulbgiirokb9zV4prXrkiCznn0eY2MxBL3aIAnXBUyZseTfnY7A+c2Rvl
         9g3Y2WqBYhU0NjtFDsxlJ02Is3OUiBWzSEhyyLg7bYM7lqNzdaj89kFzjoXrbBu/nf3z
         4znA==
X-Forwarded-Encrypted: i=1; AKwUvByHfrf90L85oT9XzkMaaX3NKRBZE1IPAXf+JbjmY0H92IMWxT+JcGHfKpRGrX7+Chw5q6Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYKv+f5TstDgTppEcgUYmQS3VZ69fX1WTiUBObtkEA7tyEPhHvwx
	L6pNkr8maxREwFfEcTyjfjnNkn855whoAn1IVXI/AkorW+Rv4XltCe2VJxuF622+TDOBwZ4Z2R9
	eURV+U+Qgjiyx6TVRC4uTJTFRz9Sdrfeq36y4ZqrJ
X-Gm-Gg: AYBFou1ZiBqnuzotlivKf77TOeppC3dVXBnHZMqZOvIvMbF/3G9piVKRzOujKXm+ujD
	yhGPGNzKM0nD1FXPWE4xKiW3m2IGeoYBe6mY7Rh2KXAuWRde+mdqm92aJiUexp/Oi/b1AwL7jMB
	j+WEGSq54pPRwBnyUgXrDjbzFbHzLke4BrlLPSF2+8PObBVSc5VX7J6PFfK7wwfguFg+dpXK1OX
	wNJIW079rJ5WAPoDFlzidZBD6UxkIo0VL9UYtKQFfGwHI6etFaQL4O5aXgxOSART8J3AKoRuVS/
	YfOMCUVfSIi6xpiV4ewWb+RHSw0wU5wPpvuEo5WSZxzuRwCalHUpMBSfDYTYyxCIYmbhM6rz1eH
	/tCFUUJjpCJEx+AJRW1b1C5qICqj8UUQPovU+jHSS5pbpYSYGqu1oz7pXrBMh4CMM+jKEIw035y
	M0oIUDlKDEEW5TBSHgsMWZb+IdqvvYBfVgs1fjRr0angmNooBNW5UQaVleefbuu4APOfhIenbPk
	8755fVNDuv+Pz6drgxGVfIWMqz423+xsw==
X-Received: by 2002:a17:907:a08a:b0:c41:8e21:4d5a with SMTP id
 a640c23a62f3a-c49bdb68d78mr15531766b.5.1793127089381; Tue, 27 Oct 2026
 11:51:29 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026215226.3713941-4-jthoughton@google.com> <10ab2f3b005f0df2c0a88e93e6917826d928bb1f82c6a645f942c099e48f8b6e@mail.kernel.org>
In-Reply-To: <10ab2f3b005f0df2c0a88e93e6917826d928bb1f82c6a645f942c099e48f8b6e@mail.kernel.org>
From: James Houghton <jthoughton@google.com>
Date: Tue, 27 Oct 2026 11:50:52 -0700
X-Gm-Features: AclHuK8M0uftDAMQJptfiH_zotg0NLNK0vqcV1a8EUqq1l3N0gBPNm3WO8H3TD0
Message-ID: <CADrL8HVHCVoh3AToNzFCe7KP=yC8byCGCzGYzzBEGYtYNC4fJw@mail.gmail.com>
Subject: Re: [RFC PATCH 03/10] bpf: Fail sleepable user copy helpers when
 current->mm is NULL
To: bot+bpf-ci@kernel.org
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, tglx@kernel.org, 
	peterz@infradead.org, kees@kernel.org, arnd@arndb.de, david@kernel.org, 
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, seanjc@google.com, pbonzini@redhat.com, 
	jmattson@google.com, axboe@kernel.dk, asml.silence@gmail.com, 
	James.Bottomley@hansenpartnership.com, mkp@kernel.org, dsterba@suse.com, 
	mason@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, jpoimboe@kernel.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, andrii@kernel.org, martin.lau@kernel.org, 
	eddyz87@gmail.com, yonghong.song@linux.dev, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 3:30=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > bpf: Fail sleepable user copy helpers when current->mm is NULL
>
> TL;DR: Commit message only: the security_file_release() example of a slee=
pable
> program running from a kworker looks inaccurate, since such a program app=
ears
> not to be attachable there. The fix itself looks justified.
>
> > bpf: Fail sleepable user copy helpers when current->mm is NULL
> >
> > Sleepable BPF programs can run on behalf of a kernel thread, or of a
> > task that has already gone through exit_mm(). For example, bpf_wq
> > callbacks always run from a kworker, bpf_task_work callbacks queued
> > late enough run from exit_task_work(), and lsm.s or fentry.s programs
> > may be attached to functions called during exit_files(),
> > exit_task_work() or from kernel threads (e.g. security_file_release()
> > from a kworker running delayed_fput()).
> > In such contexts, bpf_copy_from_user(), bpf_copy_from_user_str() and
> > bpf_copy_from_user{,_str}_dynptr() (when reading from the current task)
> > call copy_from_user() or strncpy_from_user() without an mm. That access
> > does not reliably fail: the user half of the address space belongs to
> > whatever mm happens to be lazily loaded, if any, so the program may rea=
d
> > another task's memory.
> > As there is no user memory to read from in this case, fail with -EFAULT
> > without attempting the access.
> > Fixes: 07be4c4a3e7a ("bpf: Add bpf_copy_from_user() helper.")
> > Fixes: 65ab5ac4df01 ("bpf: Add bpf_copy_from_user_str kfunc")
> > Fixes: a498ee7576de ("bpf: Implement dynptr copy kfuncs")
> > Signed-off-by: James Houghton <jthoughton@google.com>
>
> The commit message gives security_file_release() as an example of a place
> where an lsm.s or fentry.s program can run from a kworker:
>
> > (e.g. security_file_release() from a kworker running delayed_fput())
>
> Is this example accurate for the tree being patched?
>
> bpf_lsm_file_release is not in the sleepable_lsm_hooks set in
> kernel/bpf/bpf_lsm.c, so btf_id_allow_sleepable() rejects a sleepable
> BPF_PROG_TYPE_LSM program there.  bpf_lsm_file_free_security, the other h=
ook
> reached from __fput() through file_free(), is in untrusted_lsm_hooks rath=
er
> than the sleepable set.
>
> For a BPF_PROG_TYPE_TRACING program, check_attach_sleepable() requires
> within_error_injection_list(addr) (or a syscall prefix when
> CONFIG_FUNCTION_ERROR_INJECTION is off), or an fmodret set with
> KF_SLEEPABLE.  Neither security_file_release() nor bpf_lsm_file_release()
> has ALLOW_ERROR_INJECTION, and the only fmodret sets are in
> net/bpf/test_run.c, net/mptcp/bpf.c and bpf_testmod.
>
> That suggests a program attached to security_file_release() is never
> sleepable and cannot call bpf_copy_from_user() or the KF_SLEEPABLE copy
> kfuncs.

Great catch. Yeah, the examples aren't right (but the fix is still correct)=
.

> The fix itself still looks justified, since bpf_wq callbacks run from a
> kworker and is_async_cb_sleepable() is true for them.  Only the example
> appears to be off.
>
> Would an example that is actually reachable keep the changelog accurate?
> For instance, bpf_lsm_task_alloc() when kthreadd forks a kernel thread
> (current is kthreadd), or bpf_lsm_kernel_read_file() and bpf_lsm_file_ope=
n()
> when a kworker loads firmware with kernel_read_file().  All three hooks a=
re
> in sleepable_lsm_hooks.

I've adjusted the first paragraph of the changelog to:

  Sleepable BPF programs can run on behalf of a kernel thread, or of a
  task that has already gone through exit_mm(). For example, bpf_wq
  callbacks always run from a kworker, bpf_task_work callbacks queued late
  enough run from exit_task_work(), lsm.s programs may be attached to
  hooks reached from kernel threads or from exit_task_work() (e.g.
  bpf_lsm_inode_free_security() when the final __fput() of an unlinked
  file runs from delayed_fput() or from exit_task_work(), or
  bpf_lsm_bprm_check_security() during a usermode helper's
  kernel_execve()), and fentry.s programs may be attached to
  error-injectable functions called from kernel threads (e.g.
  btrfs_should_cancel_balance() from the btrfs-balance kthread).

I think all the Fixes are still accurate. The first Fixes isn't very
obvious; re-checking it with Claude provided a pretty clear
explanation for why it's accurate:

    This is the subtle one. In 07be4c4a3e7a (v5.10) the sleepable LSM
    set was just bpf_lsm_file_mprotect and bpf_lsm_bprm_committed_creds,
    and both always run with an mm. The LSM examples above only became
    sleepable later, in 423f16108c9d ("bpf: Augment the set of sleepable
    LSM hooks", v5.11), and bpf_wq only arrived in 81f1d7a583fa ("bpf:
    wq: add bpf_wq_set_callback_impl", v6.10).

    However, fentry.s was already allowed on any ALLOW_ERROR_INJECTION
    function other than __add_to_page_cache_locked, should_fail_alloc_page
    and should_failslab, and that list already included
    btrfs_should_cancel_balance() (called from the btrfs-balance kthread
    via balance_kthread() -> btrfs_balance() -> __btrfs_balance()), as
    well as btrfs_check_node() and btrfs_check_leaf_full() (called from
    the btrfs end-io workers). So bpf_copy_from_user() could be called
    without an mm from the moment it existed, and 07be4c4a3e7a is the
    right commit to blame rather than 423f16108c9d.
