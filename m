Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A822013DDA4
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 21:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776200555; cv=none; b=LuU3P5eSUw1TS3Je7MSqFHheJ9hDitEjMKERqKC3MLHZeZeMZVcAF6AX1I3COkzbSxXUYW45D6B8CeuEHisiGsqnzXiLjfqv5571kJ2XdXL4s/9l+VzzkrFllip51X5dXbVYBOmOPV7NKiYXdZXEVOSGDz+Y2k3CYN7lD9WfS44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776200555; c=relaxed/simple;
	bh=gkMp0JvEEAhv+Oe6iz2+czHZdRbwUE+6Ym4ue+9OlpM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JvfWpakzFObT7eQfqQxRNiuU1g++DrRY2TVSu+61gGImWK2DbWbZejZORYS5LHr+j0erQQRyVJS5E5bNhU8/oWsIXkzj7vpT6wHx6qzqPTXK5doGupXfY4gijJUzz7c7Nd+esQJS0mcf8xmYAXyDvvckbZZpjRrp4tRBkxU6Qfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSAj/XYo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSAj/XYo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2262BC19425;
	Tue, 14 Apr 2026 21:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776200555;
	bh=gkMp0JvEEAhv+Oe6iz2+czHZdRbwUE+6Ym4ue+9OlpM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=LSAj/XYoXQFg4DKK9G2hlOx0A9eg2qkHtMMNDo8KkXMp824OYAxh12fn9PKbHnXuu
	 RuLQWHJXmRKintl29NCKpXy7zp7PMUKmu4b1NAnMNl4YaDteJksmoqo6xZK1pSavZX
	 KircznJUbXeD0EV3K5XEna9npv0NseSW+cOJOnVGIsFTNfvY3hNR1EBT2GOxPyasxj
	 ZLpjHEBlfK7V0yIChsSRsftHeFsjSP8f3hGlSPPdhghun2cgne60r9iaumS/KQ7/IR
	 pKetFOKk43q/rLAXTLs4fW8AN/jz78cDBY6yxDoSBLO1gI6a7u0yqOIht2ntxCiENz
	 YFhPHKAOUUOxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 5/8] bpf: Update per-CPU maps using
 BPF_F_ALL_CPUS flag
Reply-To: sashiko@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260414132421.63409-6-leon.hwang@linux.dev>
References: <20260414132421.63409-6-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Apr 2026 21:02:34 +0000
Message-Id: <20260414210235.2262BC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] The patch unconditionally forces the BPF_F_ALL_CPUS flag for any k=
ernel-originated per-CPU map update that omits CPU flags, breaking the bpf_=
sys_bpf() helper API for BPF_PROG_TYPE_SYSCALL programs.
--

commit 357a4fab1d0fc8586bb52bd3aab10e26fd39a2a6
Author: Leon Hwang <leon.hwang@linux.dev>

bpf: Update per-CPU maps using BPF_F_ALL_CPUS flag

This commit modifies map_update_elem() to automatically apply the
BPF_F_ALL_CPUS flag for kernel-originated updates to per-CPU maps when no
CPU flags are specified. This is intended to fix potential out-of-bounds
reads when updating maps via the lightweight skeleton loader on systems whe=
re
the number of cached slots is less than the number of CPUs.

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index b73b25c630734..f0f3785ef57d0 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1785,6 +1785,21 @@ static int map_update_elem(union bpf_attr *attr, b=
pfptr_t uattr)
>  		goto err_put;
>  	}
> =20
> +	/*
> +	 * When updating per-CPU maps via the lightweight skeleton
> +	 * loader, use a single value slot across all CPUs. This avoids
> +	 * two potential issues when updating on an M-CPU kernel with
> +	 * N cached slots (N < M), especially when N is much smaller
> +	 * than M:
> +	 * 1) The update may trigger a page fault when copying data from
> +	 *    the last slot, as the read may go beyond the allocated
> +	 *    buffer.
> +	 * 2) The update may copy unexpected data from slots [N, M-1].
> +	 */
> +	if (bpfptr_is_kernel(uattr) && bpf_map_supports_cpu_flags(map->map_type=
) &&
> +	    !(attr->flags & (BPF_F_CPU | BPF_F_ALL_CPUS)))
> +		attr->flags |=3D BPF_F_ALL_CPUS;

Does this unintentionally break the bpf_sys_bpf() helper API for
BPF_PROG_TYPE_SYSCALL programs?

Because bpf_sys_bpf() also wraps the pointer with KERNEL_BPFPTR,
bpfptr_is_kernel(uattr) will evaluate to true for any eBPF program calling =
it.

Prior to this patch, a BPF_PROG_TYPE_SYSCALL program could legitimately
update a per-CPU map with distinct values for each CPU by providing an array
of num_possible_cpus() elements and omitting any CPU flags, which mirrors
standard user-space API semantics.

With this change, it appears the kernel silently overrides attr->flags by
setting BPF_F_ALL_CPUS. This truncates the internal value_size calculation
down to a single element (map->value_size), reads only the first element
of the BPF program's provided buffer, and incorrectly replicates it across
all CPUs.

Should this workaround for the skeleton loader be constrained to
bpftool gen skeleton instead of mutating the core syscall handler?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260414132421.6340=
9-1-leon.hwang@linux.dev?part=3D5
