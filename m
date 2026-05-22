Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B31940C5A3
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 15:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779463203; cv=none; b=EA9RkWhyD/8kS+/7buRnqgbm0ziybTJXI+DI8ifpeC2rqwtIMS2Ys+MwG1C5Nh3LrWMZWldM2jCZg0zGZGx4KtwImALD2KB3kp0E96j4Ak4r4Og2j6Z5sEW2jjOtA8yNK1Xc4zoDl4oRej2hkvA3RuZT4OjmPAdwyIXySB0fpeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779463203; c=relaxed/simple;
	bh=ajc0POUyhC6K9p10TvhwBYaQ7hboHG7OMjYa7+UPFfM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F5pLW7jL3g9BfZAKRbETv10h4MZ0gueXND9VcaCVsnqRzIrYkxJBakLnqRoHvoV4mB3hE60mAiL0WNXtytlufMbDuHHjJtSSjiWi95hJThslWzAWGW0jp2ykS2YDkT4Ilom2Esebs0snXLtnGDCgXf8GlQmQghnKTwGykjRZfm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZZobGyu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZZobGyu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F2F1F000E9;
	Fri, 22 May 2026 15:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779463198;
	bh=L4i2LepVvfrji0nnb3EMJpLE97nf4xqT6FvTaWIL4/k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MZZobGyus3u7lfzK0DFagtmY2iQmIYyTfpKAdcIVZKL8Nd81iJXqlgBWbQdEJknS7
	 Rt4w6GMqNSY1kD5JGAXw0ipIenemyRdia6JDwQH1RzVHJRfGJbhbdkf3b1YuBa+tjk
	 7i9posQ68us3JqCwfnMeDHaeOmWB2nkwpjnjDMaMh5aSNeDYUhNhTe3gMS7fkASyXV
	 gvdrUnw6chul6nFPlozrjoZI37OEUQOwaUsdKei29vhgApl6mNUmjDg0CGaQgMGYka
	 45TbFS5fBgvw4lzz9yP7tY+KSZYAzRg/If+9OvNZID5lqRQl6Ue3n22NmOJnC+tn+F
	 OR6zkhNGp3xdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Add xattr label test with
 BPF LSM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260522135626.120732-3-daniel@iogearbox.net>
References: <20260522135626.120732-3-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 15:19:57 +0000
Message-Id: <20260522151958.00F2F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] The `label_rename` LSM hook fails to validate `new_dentry`, allo=
wing bypass of the lock-down policy by renaming over a labeled file.
- [Medium] The `has_label` helper fails open on read errors, such as `-ERAN=
GE`, allowing an oversized label to bypass immutability protections.
- [Medium] The BPF LSM program uses global variables for scratch buffers, l=
eading to data races under concurrent execution.
- [Medium] The BPF program incorrectly uses `bpf_probe_read_kernel()` inste=
ad of `bpf_probe_read_kernel_str()` to read null-terminated strings, riskin=
g page faults.
--

commit b09844def8309ef8ad642a29ec66fa9162a327a3
Author: Daniel Borkmann <daniel@iogearbox.net>

selftests/bpf: Add xattr label test with BPF LSM

This patch adds a selftest exercising bpffs extended attribute support
together with a BPF LSM example. The LSM restricts modifications and
lifecycle operations on BPF objects pinned in bpffs that are labeled
with "security.bpf.foo".

> diff --git a/tools/testing/selftests/bpf/progs/bpffs_xattr_label.c b/tool=
s/testing/selftests/bpf/progs/bpffs_xattr_label.c
> new file mode 100644
> index 0000000000000..3891611c3b1c1
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpffs_xattr_label.c
> @@ -0,0 +1,102 @@
[ ... ]
> +__u32 monitored_pid;
> +
> +char read_value[64];
> +int read_value_len;
> +
> +char label_check_buf[64];
> +char name_buf[64];

[Severity: Medium]
Since these buffers are shared globally, couldn't a multi-threaded
application trigger a data race when concurrently performing filesystem
operations? The buffers are small enough (64 bytes) that they might be
allocated safely on the BPF program's stack instead.

> +
> +static __always_inline bool name_is_foo(const char *name)
> +{
> +	bpf_probe_read_kernel(name_buf, sizeof(name_buf), name);

[Severity: Medium]
Could unconditionally reading 64 bytes cause a page fault if the
null-terminated name string is near the end of a page and the subsequent
page is unmapped? Using bpf_probe_read_kernel_str() might be safer here.

> +	return !bpf_strncmp(name_buf, sizeof(xattr_foo), xattr_foo);
> +}
> +
> +static __always_inline bool has_label(struct dentry *dentry)
> +{
> +	struct bpf_dynptr ptr;
> +
> +	bpf_dynptr_from_mem(label_check_buf, sizeof(label_check_buf), 0, &ptr);
> +	return bpf_get_dentry_xattr(dentry, xattr_foo, &ptr) >=3D 0;

[Severity: Medium]
If an attacker creates a label larger than the 64-byte label_check_buf,
bpf_get_dentry_xattr() will return -ERANGE. This causes the function to
return false, failing open and bypassing the immutability protections.
Should this explicitly handle errors like -ERANGE?

> +}
[ ... ]
> +SEC("lsm.s/inode_rename")
> +int BPF_PROG(label_rename, struct inode *old_dir, struct dentry *old_den=
try,
> +	     struct inode *new_dir, struct dentry *new_dentry,
> +	     unsigned int flags)
> +{
> +	if ((bpf_get_current_pid_tgid() >> 32) !=3D monitored_pid)
> +		return 0;
> +	return has_label(old_dentry) ? -EPERM : 0;

[Severity: Medium]
Because this doesn't check new_dentry, could an attacker rename an unlabeled
file over a labeled file? This would effectively delete the protected object
without triggering the label_unlink or label_rmdir hooks, bypassing the
immutability policy.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522135626.1207=
32-1-daniel@iogearbox.net?part=3D3
