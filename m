Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E0E3438A7;
	Sun, 31 May 2026 01:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780190928; cv=none; b=M58gCweXIEFSCw3K5nSwqnbtlHE4LNgijZ04BTSrdXkDATDuAD2XRie/FEFK/1LTn9Sn3EJi4oWnEjmUwRHvwUIWEV8lEsY8p3ycOHaqStDOd7UiX+6fgaGNoU84h6cIw0VfAv4m1evsDW9+BaGsxcOb3aF8pZ/a+Ja5ypxg5QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780190928; c=relaxed/simple;
	bh=OAzN3seHohf2BTo65MsaHTpFXdEGGsanaTwCTvt08o0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=KHhZqbBcOUpqljeZ30q3d/tDe/y5FJErbg/3dZmFYTd3eEG6/+d5pnCcYliwschXOzGz9HFRZs4oQF5h+F4oc+N0NCjjry4e7fDHhK+N8oxuDuphTm2C8iwq95GVPi0VmhHOA3MDRuAscPXbWotHKbwPmgjudHipHyox4oLyWus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n55PjfID; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n55PjfID"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574001F00893;
	Sun, 31 May 2026 01:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780190926;
	bh=X+BaGJHz8uZETrQTdbTxbXnOm7f0ecn7Si9q2XGqq1o=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=n55PjfIDrn90/cbu7xhUBXTfql035EL1zqn6tswCuuKWr0uelCpTDuitSZvEMeK//
	 qV1WAfjnzzog7xhY05GuBcCs++xivczObXyAkehNI2NoF7bKjGAB0tsQeelvBElcCZ
	 bXE78tjO706Rf/zWY1ERSMeob+tofmS/gcZBDYZjNoq8TWbU3bmvjkYqhqEJpSEoBW
	 PpAVHrw6cyiER9gypwWNQnmMDJbUIJDpgGR4gRiZ9MwZrdmPtGCGvyOeoM1qOX96bv
	 SRrynnLq1Gnd7KVBSSoc3Kaw1H67Vvv+dnqe0QdfOy5dIGcuW6VTlRUuQIWG0tS8bx
	 nq8sPoxzkz5ow==
Content-Type: multipart/mixed; boundary="===============2073181152847420204=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2024c87ec926ea4a4c7c5c811d649d0c9c23f0f40144fe33ca38e90a3b2c86b9@mail.kernel.org>
In-Reply-To: <20260531004748.3567875-3-yuyanghuang@google.com>
References: <20260531004748.3567875-3-yuyanghuang@google.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: add verification for BPF_PROG_QUERY attr size boundaries
From: bot+bpf-ci@kernel.org
To: yuyanghuang@google.com,yuyanghuang@google.com
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,jolsa@kernel.org,john.fastabend@gmail.com,memxor@gmail.com,martin.lau@linux.dev,shuah@kernel.org,song@kernel.org,yonghong.song@linux.dev,leon.hwang@linux.dev,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,maze@google.com,lorenzo@google.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 31 May 2026 01:28:46 +0000 (UTC)

--===============2073181152847420204==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_attr_size.c b/tools/testing/selftests/bpf/prog_tests/bpf_attr_size.c
> new file mode 100644
> index 000000000000..4fbe56cb29d4
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_attr_size.c
> @@ -0,0 +1,65 @@

[ ... ]

> +	err = syscall(__NR_bpf, BPF_PROG_QUERY, &attr, OLD_QUERY_SIZE);
> +	ASSERT_EQ(err, -1, "query_old_size_fails");
> +	ASSERT_EQ(errno, EFAULT, "query_old_size_efault");

This test asserts errno == EFAULT for a short query size. A v2 review
comment on the companion kernel patch (bpf: reject BPF_PROG_QUERY with
short uattr size) questioned whether -EFAULT is the right error code for
a structure size mismatch, noting that -EINVAL or -E2BIG is the more
conventional return code and that -EFAULT usually indicates an invalid
memory address during a copy.

That comment was not answered on the v2 thread. If the kernel patch's
error code changes to -EINVAL or -E2BIG, would this assertion need to
change too?

  https://lore.kernel.org/all/20260531004748.3567875-2-yuyanghuang@google.com/

[ ... ]

This selftest verifies the fix for an out-of-bounds write to userspace in
BPF_PROG_QUERY, where __cgroup_bpf_query() unconditionally wrote
uattr->query.revision even when userspace passed a smaller bpf_attr. The
companion kernel fix carries a Fixes: tag, but this selftest commit does
not.

Should this include:

  Fixes: 120933984460 ("bpf: Implement mprog API on top of existing cgroup progs")

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26699503418
--===============2073181152847420204==--
