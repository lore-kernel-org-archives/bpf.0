Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA7834A795
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 11:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785411460; cv=none; b=MjKdIlMmNWEeZy4bO1+uXg62CEb55sNce2yKhNyO5J6W0zJ+esNc/WWBIIYXyrj8STpKjlAVi/SiC8ZZxiadURYQQLekzIOKX+Pl+E2goEHoNxtQ3sRBIvxNDFypeum0FmMe1THBhJQY2c1q2Yy83AOr3edVs8gXM/APsIMHv6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785411460; c=relaxed/simple;
	bh=O0OtPeUSWRYiN6CFTiFeczSMniCFap2N+yqNH9ypFFc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SZ+q8Ppugb5dokDiBziWBviZ6Px5lHIRsqLSURUPAg53XG7Fhm3P9FSyHXsA5WT7JklWtN72Oiaqxz14APxzU7p7/BFYr3Ii7Ph0axg8p8TmQHRtLg2YIn9PcIgNcjvQyf24m8gmqucvGdEQkmr6uf/B32Vudta49upchYbIP5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6kQ3z8p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6kQ3z8p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C901F000E9;
	Thu, 30 Jul 2026 11:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785411458;
	bh=S++E3S5MtPQ6gFN6N00vgRX0sQr7pXu2+KjqN5rdTpQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D6kQ3z8plfHsON1NoTtY30kB5sR6U/n3OYASpE332IK59qpCDKVU+SO6zi8Sea4LG
	 0WgcBBTEx3wY8shNlOup5hLLK5LPSZ+Ti9184Bwawv+sdXFW0JtGCUYmIg/Q4SxXQs
	 uCoThS6u6nEkNfGhFAoCJBuaDGQ0vVq6M/7zEFFTQm0VYfbVHP79lz7+1y5UVkqIlW
	 khkYgRlfVnqK8xoA2up8XSEaZkT4Kqtyo9wrM7xEyZvF88E40KRllpOI4OiZGiuQRd
	 qx5ythPO9sfN6vP4HbHK2ZANFO3QQb5mMBxeELHe8G8KefuD/R0AmB+fI+D42zktXb
	 rmd4tZm0EIvlg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selftests: net: reuseport_bpf_numa: consider cpuless
 numa node
Reply-To: sashiko-reviews@lists.linux.dev
To: "Feng Tang" <feng.tang@linux.alibaba.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260730113040.75718-1-feng.tang@linux.alibaba.com>
References: <20260730113040.75718-1-feng.tang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 11:37:37 +0000
Message-Id: <20260730113738.41C901F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Missing NULL check for cpumask allocation in is_cpuless_node()
- [Medium] Missing return value check for numa_node_to_cpus() leading to ma=
sked errors
--

--- Patch [1]: [PATCH] selftests: net: reuseport_bpf_numa: consider cpuless=
 numa node ---
commit 806931cbf2ad9438843e4d30f69b4887e641f7d2
Author: Feng Tang <feng.tang@linux.alibaba.com>

selftests: net: reuseport_bpf_numa: consider cpuless numa node

This patch addresses a failure in the 'reuseport_bpf_numa' selftest on
platforms with CXL memory where one node is cpuless. It introduces an
is_cpuless_node() check to skip memory-only NUMA nodes during the binding
test.

> diff --git a/tools/testing/selftests/net/reuseport_bpf_numa.c b/tools/tes=
ting/selftests/net/reuseport_bpf_numa.c
> index 8ec52fc5ef41b..197dbfc475f65 100644
> --- a/tools/testing/selftests/net/reuseport_bpf_numa.c
> +++ b/tools/testing/selftests/net/reuseport_bpf_numa.c
[ ... ]
> @@ -104,13 +104,35 @@ static void attach_bpf(int fd)
>  	close(bpf_fd);
>  }
> =20
> -static void send_from_node(int node_id, int family, int proto)
> +static inline bool is_cpuless_node(int node_id)
> +{
> +	struct bitmask *cpumask;
> +	bool ret =3D false;
> +
> +	cpumask =3D numa_allocate_cpumask();
> +
> +	numa_node_to_cpus(node_id, cpumask);

[Severity: Medium]
Will this crash if numa_allocate_cpumask() fails to allocate memory?

It looks like cpumask could be NULL here, which is passed directly to
numa_node_to_cpus() and numa_bitmask_weight() without validation.

> +	if (!numa_bitmask_weight(cpumask))
> +		ret =3D true;

[Severity: Medium]
What happens if numa_node_to_cpus() fails?

It can return a negative error value, leaving the cpumask unmodified with
zero bits set. Because the return value is not checked,
numa_bitmask_weight(cpumask) will evaluate to 0. Does this cause the functi=
on
to return true and silently skip testing on nodes where an error occurs,
rather than reporting the infrastructure issue?

> +
> +	numa_bitmask_free(cpumask);
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730113040.7571=
8-1-feng.tang@linux.alibaba.com?part=3D1
