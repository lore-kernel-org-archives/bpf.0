Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795344866;
	b=r862xwXpX9cZ+fF9HNKU1VOLUnUjIkHkSCuzXMOKsnQZD6J0QJ6F2r4EcPqSkYsohdXh
	 B7qFWBrGXq4N0fZpZ7y0OO2KReMkM8SP9jNnHMSkECHQdlGcKybz3oo8IO3ZdhpzxpTPF
	 L3dR+WVn/qyEDSTOd68INj5rm8RF12T2SMb0axMCJJV67NtpxxGFZ5ScRooDdrTzo8Wec
	 yrlYf2JMY/bLCw0TXG6ksrniXd7HgCxcDk5j9+bG6vxQRiFLNnl7fLuRaZlZjMKk1+qDT
	 3Qk9dna5hnMkpyz3+2HSVU5b4TgiuQxWqw9oUgUs4HjckhG1ZmF+wE/JoL5v0cfT92A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795344866;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eQczruiU5yQMNTA09JDoZkufoLOYssWCkidURSJ5RUg=;
	b=q2Ph2eZpfZWuz7FSyBe1XPMbWi9Iks+l8nmVCm5TSycH2Bf9La9slCbmaKcGH/R1MHyn
	 FnrAt6zgv1mp7cpSpN6Zn5Q9BWf4oPBoh7RvgawoLB+iu5I6TdsS7moOOUJfz1L8j0FfW
	 ty+BJtXvn0pw1U93CNk/05epfBk0VjtWwiSKhhLqMLkOZpinW9Cvi5Qou2OPLBnHkHHLg
	 ZFaSpgkeF5BX2vnAzpcdIS67jPebxMGlTLfLcidzO94yLXdrLin+5kwXDX/RPWDV3nwDB
	 RkRktpSZqn9bGwpVbBGioDN1ukVpawZ5DSk/e3soDX5YDAUc9sdsbEpDMuqweuGMIOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hpNUllAI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469B3606A320
	for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 10:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hpNUllAI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BABD1F000C0;
	Sun, 22 Nov 2026 10:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795344866;
	bh=eQczruiU5yQMNTA09JDoZkufoLOYssWCkidURSJ5RUg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=hpNUllAIFo2K/zn91umIZ1jAkCa5uD1hQPfOMMHVcYvUd2xPGVT9vJ/rf0ZkyQ7VT
	 xvUeFKkK+fReuuvEEKTAnNOd1TiJYZR6THtULr7t7g9TcEtNZsaJIW3TJs3hNuHnso
	 hrgyNsSTUHutBPIczjm021yIWEvwaLmmFMwUCU12HQwfR7cYPooLJz+T13BlacKIz/
	 VDK8shc4pCe1oAdrAdwZed8Cw9OH7Qs+fXvrBHdt0oaxCUDivEI7lDfFFFYWPsx0RU
	 FehjFTBiCpFDdy7xQdRgy9XyMQRaLjVkeiycSs7FoDR6PgdL3tIEQHQUYPkOzPLuaN
	 o+TIiPkuGEmKQ==
Message-ID: <sashiko-outbox-227901@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 1/2] bpf: Add bpf_memmem and
 bpf_dynptr_memmem kfuncs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abhishek Khade" <abhishekkhade69@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261122103838.244974-2-abhishekkhade69@gmail.com>
References: <20261122103838.244974-1-abhishekkhade69@gmail.com>
 <20261122103838.244974-2-abhishekkhade69@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 10:54:25 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] bpf: bpf_memmem() and bpf_dynptr_memmem() defined inside
  CONFIG_CGROUPS
- [High] bpf: quadratic O(N*M) complexity in __bpf_memmem() with 2 MB
  buffer cap
- [Medium] bpf: u64 size truncated to u32 in bpf_dynptr_memmem() before
  bounds check
- [Medium] bpf: bpf_memmem() and bpf_dynptr_memmem() placed in
  generic_btf_ids
--

commit 8544ed400181be07e2f78fbba3ee242f2ebcc135
Author: Abhishek Khade <abhishekkhade69@gmail.com>

bpf: Add bpf_memmem and bpf_dynptr_memmem kfuncs

This commit adds the bpf_memmem() and bpf_dynptr_memmem() kfuncs to search
for binary byte sequences in flat memory buffers and BPF dynptrs.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 937a0d7d68390..2f3e349955466 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2994,6 +2994,119 @@ __bpf_kfunc long bpf_task_under_cgroup(struct tas=
k_struct *task,
>  	return ret;
>  }
> =20
> +#define BPF_MEMMEM_MAX_LEN (2 * 1024 * 1024) /* 2 MB max search buffer */
> +
> +/*
> + * In-kernel binary byte sequence search.
> + * Scans haystack for the first byte using optimized memchr(),
> + * then validates the remaining needle with memcmp().
> + */
> +static void *__bpf_memmem(const void *haystack, size_t haystack_sz,
> +			  const void *needle, size_t needle_sz)
> +{
> +	const char *h =3D haystack;
> +	const char *n =3D needle;
> +	const char *end;
> +
> +	if (needle_sz =3D=3D 0)
> +		return (void *)haystack;
> +	if (needle_sz > haystack_sz)
> +		return NULL;
> +	if (needle_sz =3D=3D 1)
> +		return memchr(haystack, n[0], haystack_sz);
> +
> +	end =3D h + haystack_sz - needle_sz + 1;
> +	while ((h =3D memchr(h, n[0], end - h)) !=3D NULL) {
> +		if (memcmp(h, n, needle_sz) =3D=3D 0)
> +			return (void *)h;
> +		h++;
> +	}
> +
> +	return NULL;
> +}

[Severity: High]
Can __bpf_memmem() trigger RCU CPU stalls and soft lockups on repetitive
inputs?

Both bpf_memmem() and bpf_dynptr_memmem() allow haystack_sz and needle_sz
up to BPF_MEMMEM_MAX_LEN (2 MB), and __bpf_memmem() advances h by one byte
whenever memcmp() fails.  A 2 MB haystack of repeated zero bytes searched
for a 1 MB needle of zeroes ending in a non-zero byte runs the loop over
10^6 times and compares 1 MB on each step (~1.1 * 10^12 byte comparisons)
in a non-preemptible BPF context.

Also, the commit message notes that memchr() uses 64-bit word-at-a-time
detection, but the generic memchr() in lib/string.c (used on x86_64 and
other architectures without __HAVE_ARCH_MEMCHR) scans byte-by-byte.

[ ... ]

> +__bpf_kfunc long bpf_memmem(const void *haystack, u32 haystack__sz,
> +			    const void *needle, u32 needle__sz,
> +			    u64 flags)
> +{

[Severity: High]
Are __bpf_memmem(), bpf_memmem(), and bpf_dynptr_memmem() unintentionally
placed inside the #ifdef CONFIG_CGROUPS block?

They are inserted between bpf_task_under_cgroup() and
bpf_current_task_under_cgroup(), inside the #ifdef CONFIG_CGROUPS guard
that opens before bpf_cgroup_acquire() and closes after
bpf_task_get_cgroup1(), while their BTF_ID_FLAGS entries in
generic_btf_ids are emitted outside #ifdef CONFIG_CGROUPS.  When
CONFIG_CGROUPS is disabled and CONFIG_DEBUG_INFO_BTF is enabled,
resolve_btfids fails the build on the missing symbols (under
CONFIG_WERROR=3Dy) or leaves zeroed BTF IDs that cause kfunc_init() to fail
registering generic_kfunc_set at boot.  Moving the definitions after the
#endif /* CONFIG_CGROUPS */ line avoids this.

[ ... ]

> +__bpf_kfunc long bpf_dynptr_memmem(const struct bpf_dynptr *haystack,
> +				   const void *needle, u32 needle__sz,
> +				   u64 flags)
> +{
> +	struct bpf_dynptr_kern *ptr =3D (struct bpf_dynptr_kern *)haystack;
> +	const void *data;
> +	const void *match;
> +	u32 size;
> +
> +	if (flags)
> +		return -EINVAL;
> +	if (!ptr || !ptr->data || !needle || needle__sz =3D=3D 0)
> +		return -EINVAL;
> +
> +	size =3D __bpf_dynptr_size(ptr);
> +	if (needle__sz > size)
> +		return -EINVAL;
> +	if (size > BPF_MEMMEM_MAX_LEN)
> +		return -E2BIG;

[Severity: Medium]
Does storing __bpf_dynptr_size(ptr) into u32 size truncate 64-bit dynptr
sizes before the bounds checks?

__bpf_dynptr_size() returns u64 because BPF_DYNPTR_TYPE_FILE stores a
64-bit size.  If a dynptr has a 64-bit size whose upper 32 bits are
non-zero and lower 32 bits are at most BPF_MEMMEM_MAX_LEN (for example, a
file dynptr adjusted to 4 GiB), truncating size to u32 bypasses the
size > BPF_MEMMEM_MAX_LEN (-E2BIG) check.  Declaring size as u64 avoids
the truncation.

[ ... ]

> @@ -5253,6 +5366,8 @@ BTF_ID_FLAGS(func, bpf_verify_pkcs7_signature, KF_S=
LEEPABLE)
>  #ifdef CONFIG_S390
>  BTF_ID_FLAGS(func, bpf_get_lowcore)
>  #endif
> +BTF_ID_FLAGS(func, bpf_memmem)
> +BTF_ID_FLAGS(func, bpf_dynptr_memmem)
>  BTF_KFUNCS_END(generic_btf_ids)

[Severity: Medium]
Should bpf_memmem and bpf_dynptr_memmem be registered in common_btf_ids
instead of generic_btf_ids?

kfunc_init() only registers generic_kfunc_set for TRACING, SCHED_CLS, XDP,
STRUCT_OPS, SYSCALL, and CGROUP_SKB, which prevents KPROBE, SOCKET_FILTER,
SK_SKB, SCHED_ACT, NETFILTER, and LWT programs from calling these kfuncs.
The other generic dynptr and string search kfuncs in kernel/bpf/helpers.c
are placed in common_btf_ids so they are registered for
BPF_PROG_TYPE_UNSPEC.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122103838.2449=
74-1-abhishekkhade69@gmail.com?part=3D1
