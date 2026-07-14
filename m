Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0C03624B2
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 02:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783997601; cv=none; b=SXLDNSQ+nHxv7gnq4nkT7NK9/350CtjOFctOhz193nPuBZq5lNb8CtHTD6b/ud5Vre9UpmT7pEwYuWWPVkoaEv0joBGusAapKnLEoxOyQZT8BhiABnJvqoOlolae4qjnt3lQG8IMiozyQwwGjl3G0ma/dzxPYnLaC/pPnM9sbMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783997601; c=relaxed/simple;
	bh=r6MhhHUMydWMGZAPupYulst8Gq443GA7hBgMyI/K5SA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BT/H9zOq07jgoPIscQCjxCuhcdXhSnngt0ZOaD+UvqHChEKm/w7T3YsNNlDzwHk0Bg5s/bv4/yQWl5rcz/0UDt69y8JIzsjgqd3UJU+KzR/OItkDgeMXkEO3hV5E1ESO641i4vITZoQxURFSq5Wr+DL7PBJ/T9ruPd0oTqlV+/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAnzyfcc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAnzyfcc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200C71F000E9;
	Tue, 14 Jul 2026 02:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783997600;
	bh=WHYniaFivQZgdujGNZmEfLO5nUJRfcYcGN4oDQ0Ebig=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cAnzyfcc5pE0U8+CDmTLQTsVz8xr5qOmmkGcPHRex/JGxzDQuq1Nl4D52JlA0jCSi
	 hI22FhXIstfuRpcFpS5jZiZe6GUl67PqVWX467g5sppV/NjVptrMb6gLIeRte0XbKv
	 kogSBUybCg3q8lDVnimHkHWm0UGJxsF+usPRwk/GCVIB8lFNRJX1DYVBhkS5a4dJVo
	 kmspNE7cO94uVg2pbNZv069fe5A7c16zWprmbeUrDjtOwVW51xIp6UI1zNOu4W/DNf
	 aqYkCmDgpOrx+im02Aj5fn5mHMhnmCeS7fiHKxQ5IuFKbqTk45d3rEmKAEfcNONzJi
	 qdQiUorbo7MFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add testcase for
 callback with tailcall
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260714024459.420075-3-pulehui@huaweicloud.com>
References: <20260714024459.420075-1-pulehui@huaweicloud.com>
 <20260714024459.420075-3-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 02:53:19 +0000
Message-Id: <20260714025320.200C71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Out-of-bounds map index used in bpf_tail_call_static in the test pr=
ogram.
--

--- Patch [2]: [PATCH bpf-next v2 2/2] selftests/bpf: Add testcase for call=
back with tailcall ---
commit 6b7ff517c87bc3ed869da7118100965c0668a781
Author: Pu Lehui <pulehui@huawei.com>

selftests/bpf: Add testcase for callback with tailcall

This commit adds a new BPF selftest to verify that a callback involving a
subprogram with a tail call is properly rejected by the verifier.

> diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_callback.=
c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_callback.c
> new file mode 100644
> index 0000000000000..dfe9c49cfeb1d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_callback.c
> @@ -0,0 +1,62 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +#include "bpf_test_utils.h"
> +
> +int classifier_0(struct __sk_buff *skb);
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
> +	__uint(max_entries, 1);
> +	__uint(key_size, sizeof(__u32));
> +	__array(values, void (void));
> +} jmp_table SEC(".maps") =3D {
> +	.values =3D {
> +		[0] =3D (void *) &classifier_0,
> +	},
> +};
> +
> +static __noinline
> +int subprog_tail0(struct __sk_buff *skb)
> +{
> +	int ret =3D 0;
> +
> +	bpf_tail_call_static(skb, &jmp_table, 1);

[Severity: Low]
Does this code use an out-of-bounds index for the tail call? The jmp_table
map has max_entries set to 1 and populates index 0 with classifier_0, but
this bpf_tail_call_static() invocation uses index 1.

Even though this test is designed to be rejected by the verifier, should
this pass index 0 to correctly match the intended tail call target?

> +	barrier_var(ret);
> +	return ret;
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714024459.4200=
75-1-pulehui@huaweicloud.com?part=3D2
