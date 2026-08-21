Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C0C418A37
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 22:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787352633; cv=none; b=LisMmdlCbAuzGD9B47c53sS/KjA1n7E3Rk0mDOuo+xvknXMnpbLkCSG+1anbSZuDOflCGotdQj6nmVdsdr5EBYSGAhLrvuKj/bPC2M0ejONgI6/9i4vJW18oIOvgbzcIWReY1ySFtpDXISDOKU/flBCeGHlJW1jOdDpR4ofTvrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787352633; c=relaxed/simple;
	bh=7iUvy0Mk5WKjuf6It/0wn8nWODIKozvkQ4cpoCrsI4k=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=iclo46Hnp4e3HuDKrqv6vJRw2YGHMNO8Ans2+JT6n3VtpYgpd/LR/hxGkXqqNWKI0soiHgzgoSjl3JImN08rX7R9VbipH53GBThdnXYlU9ZEsl4LDPup5N8EWZujN/L1cCyDctbjIvtMHHaxhBqgbAJnf2WPAa0lMyfSHgTQPLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5I6TOes; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5I6TOes"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA5D1F00A3A;
	Fri, 21 Aug 2026 22:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787352630;
	bh=LnZm85zvCMcHHgLxOt9fOGAejF5gNMh3AiPtB8sILaY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=I5I6TOes9Q1iwlbQRuynjfaHTx4uoC3pYQGKh81Ut4i0L3T3ZwN+DTmvxe9Xp5OQg
	 2UytRZCIguB33Lw3NQHYDx4N3LvhfWCOXqULVPRMk9j23gBa4NO9ATtRHfyetJ+CVi
	 bVm0mH93vHpwlhZ30T58FxNzfjXsj2Ekzr5hR75Nu1B5dtt9NkuGvMbG3M6LzquY2w
	 4k4vWl/9PA5ETOo9gJ0HLIl5KSxJLgqfzYS3AM00m4+RDMU2o/U/I3x93/oQStaEzn
	 SxBbYg7XESGb1GkuvjVt7HkTcWQMQhUGkUd+zG/hN/Fya55Isq/GjSY6yBuqR9GZFe
	 Xvw47FVBOwjyQ==
Content-Type: multipart/mixed; boundary="===============8130096225877346780=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <23f6cfb8c5a34bdeed065d9ffea6a3e63cc15cc0863b916cd8031cf56486a9bc@mail.kernel.org>
In-Reply-To: <20260821214111.1120748-11-daniel@iogearbox.net>
References: <20260821214111.1120748-11-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 10/11] selftests/bpf: Add tests for bpf keyring in signed loader
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,memxor@gmail.com
Cc: brauner@kernel.org,kpsingh@kernel.org,ast@kernel.org,john.fastabend@gmail.com,a.s.protopopov@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 21 Aug 2026 22:50:29 +0000 (UTC)

--===============8130096225877346780==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/signed_loader.c b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
> index a1fa1c37815bf..9d2384071a42d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/signed_loader.c
> +++ b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
> @@ -69,6 +69,33 @@ static int load_loader(const void *insns, __u32 insns_sz, int map_fd,
>  	return fd < 0 ? -errno : fd;
>  }
>
> +static int load_loader_log(const void *insns, __u32 insns_sz, int map_fd,
> +			   const void *sig, __u32 sig_sz, __s32 keyring_id,
> +			   __u32 fd_array_cnt, char *log_buf, __u32 log_sz)
> +{
> +	union bpf_attr attr;
> +	int fd;
> +
> +	memset(&attr, 0, sizeof(attr));
> +	attr.prog_type = BPF_PROG_TYPE_SYSCALL;
> +	attr.insns = ptr_to_u64(insns);
> +	attr.insn_cnt = insns_sz / sizeof(struct bpf_insn);
> +	attr.license = ptr_to_u64("Dual BSD/GPL");
> +	attr.prog_flags = BPF_F_SLEEPABLE;
> +	attr.fd_array = ptr_to_u64(&map_fd);
> +	attr.fd_array_cnt = fd_array_cnt;
> +	attr.signature = ptr_to_u64(sig);
> +	attr.signature_size = sig_sz;
> +	attr.keyring_id = keyring_id;
> +	attr.log_level = 1;
> +	attr.log_buf = ptr_to_u64(log_buf);
> +	attr.log_size = log_sz;
> +	memcpy(attr.prog_name, "__loader.prog", sizeof("__loader.prog"));
> +	fd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr,
> +		     offsetofend(union bpf_attr, keyring_id));
> +	return fd < 0 ? -errno : fd;
> +}

This isn't a bug, but could load_loader() just forward to load_loader_log()
with a NULL log buffer, the way sign_buf() forwards to sign_buf_digest()?
That would also let signature_failure_logs() drop its open-coded bpf_attr
block.

[ ... ]

> @@ -665,6 +770,246 @@ static void bpf_keyring_sealed(void)
>  	gen_loader_fixture_fini(&f);
>  }
>
> +/*
> + * This needs bpf.keyring_unsealed=1 on the guest kernel command line, which
> + * vmtest.sh can pass via KERNEL_CMDLINE_EXTRA. There is no way to unseal the
> + * keyring from here, so without it the test skips. It also only works once
> + * per boot, as restricting a keyring cannot be undone.
> + */
> +static void bpf_keyring_provisioned(void)
> +{

[ ... ]

> +	buf = malloc((size_t)f.gopts.insns_sz + f.data_sz);
> +	if (!ASSERT_OK_PTR(buf, "signbuf"))
> +		goto out;
> +	memcpy(buf, f.gopts.insns, f.gopts.insns_sz);
> +	memcpy(buf + f.gopts.insns_sz, f.blob, f.data_sz);
> +	if (!ASSERT_OK(sign_buf(dir, buf, f.gopts.insns_sz + f.data_sz, sig,
> +				&sig_sz), "sign insns||metadata"))
> +		goto out;
> +
> +	map_fd = setup_meta_map(&f);
> +	if (!ASSERT_OK_FD(map_fd, "meta_map_unrestricted"))
> +		goto out;
> +	prog_fd = load_loader(f.gopts.insns, f.gopts.insns_sz, map_fd, sig,
> +			      sig_sz, BPF_KEYRING_BPF, 1);
> +	close(map_fd);
> +	map_fd = -1;
> +	ASSERT_EQ(prog_fd, -ENOKEY, "unrestricted keyring still not consulted");
> +	if (prog_fd >= 0)
> +		close(prog_fd);
> +	prog_fd = -1;

This isn't a bug, but would a small local helper - something like try_load()
returning the load result - let these seven blocks collapse to one line each
and keep the keyring lifecycle the subtest is actually documenting in view?
This eleven-line create-map / load / close / reset block is repeated verbatim
seven times inside the one function.

[ ... ]

> +	/* Dropping the bits it no longer needs is what makes the set final. */
> +	err = keyctl_ret(KEYCTL_SETPERM, serial, BPF_KEYRING_PERM_LOCKED);
> +	if (!ASSERT_OK(err, "drop the user bits on the bpf keyring"))
> +		goto out;
> +
> +	/* Verification runs on KEY_POS_SEARCH, so a load is unaffected. */
> +	map_fd = setup_meta_map(&f);
> +	if (!ASSERT_OK_FD(map_fd, "meta_map_locked"))
> +		goto out;
> +	prog_fd = load_loader(f.gopts.insns, f.gopts.insns_sz, map_fd, sig,
> +			      sig_sz, BPF_KEYRING_BPF, 1);
> +	close(map_fd);
> +	map_fd = -1;
> +	ASSERT_OK_FD(prog_fd, "load still verified against the locked keyring");
> +	if (prog_fd >= 0)
> +		close(prog_fd);
> +	prog_fd = -1;
> +
> +	err = keyctl_ret(KEYCTL_UNLINK, KEY_SPEC_SESSION_KEYRING, serial);
> +	ASSERT_EQ(err, -EACCES, "unlink refused");
> +	err = keyctl_ret(KEYCTL_CLEAR, serial, 0);
> +	ASSERT_EQ(err, -EACCES, "clear refused");
> +	err = keyctl_ret(KEYCTL_REVOKE, serial, 0);
> +	ASSERT_EQ(err, -EACCES, "revoke refused");
> +	err = keyctl_ret(KEYCTL_INVALIDATE, serial, 0);
> +	ASSERT_EQ(err, -EACCES, "invalidate refused");
> +	err = keyctl_ret(KEYCTL_SET_TIMEOUT, serial, 1);
> +	ASSERT_EQ(err, -EACCES, "timeout refused");
> +	err = keyctl_ret(KEYCTL_SETPERM, serial, 0x082f0000);
> +	ASSERT_EQ(err, -EACCES, "the bits cannot be granted back");

This isn't a bug, but since 0x082f0000 is the keyring's boot-time permission
set from bpf_keyring_init(), would a companion macro next to
BPF_KEYRING_PERM_LOCKED (say BPF_KEYRING_PERM_INITIAL) make the "the bits
cannot be granted back" assertion read for itself?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32530917987
--===============8130096225877346780==--
