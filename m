Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A543BF695;
	Thu,  1 Oct 2026 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790870241; cv=none; b=Y9JQ4LAAkGwly0JMtSlddDo/yJcaMbpxCeZ8Mvb5NX/oHHCc2bByidMNBYP6AGXHM89+YE6ZW4afcAZgknRrscMrcKlNu+KiBmitPEfkb9hJe2N/VanJ2MeQavBeXrbCP1IwDHBaK2i7fbQAasDYXIXeUy3q08IfXTeENtO+2oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790870241; c=relaxed/simple;
	bh=+WhVESneHWi1O49FjS1s+kGEkLJb8PZBEUKToWFXo74=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GILpPJyCKgNJtz0Dnf7T0Houj/kmO2iWwYHzsVpH00zmYT6YlBpGUCxsz1uRkhrCjxFrsLev+MZsCwOpT4ZFz7BAd+h2dpeqp1LAeKxxd/2BSkpNIToGlJ/ux+FiB0+Sb2jpbcmP526ZRXEWlygIUqSfFqZSKHEx/GhcbFJOl8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4+JX9aY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4+JX9aY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB41A1F000FF;
	Thu,  1 Oct 2026 15:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790870238;
	bh=QC6L2lj0u2kbGH+DClsbnkRlQ7Qn3jGavgf787UBf+4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L4+JX9aYMX8nFh0pDJSSOCZEJMaiHRrsHiPepIhk0Yu+9UMvoRKIZSCFxQSX0K/tD
	 qRIoEnYsXr01cWgktgg1xRMA3PFlit6nEsaXEnC0jpS9pFj3UXPwqNEuoyltm5uwLD
	 znkgT71bRIvc69j1XWdTW9os6ggIqjmdZlFkm6FO/hr3/n0XqWCiEWS1UMWSDNM5kx
	 ilGvrSdjUbLIA4Qi0ORRyWUSFfglLoeNfUm2mZ8IuOmPWJvd9qY+XvZDAKmNIUVELn
	 m8ujvpBfLVQUqGF2dlyjbWSC9XpEuUL286ZJNTkMyGuJtoo6x4Z29Xz3oEbWUAVhvF
	 /+WBEPhLf7ufw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/15] tools/rv: Add reactors support to BPF monitors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gabriele Monaco" <gmonaco@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261001152042.124445-13-gmonaco@redhat.com>
References: <20261001152042.124445-1-gmonaco@redhat.com>
 <20261001152042.124445-13-gmonaco@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 15:57:18 +0000
Message-Id: <20261001155718.AB41A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] bpf: panic reactor BPF program rejected due to PTR_TO_STACK argu=
ment
- [Medium] rv: NULL pointer dereference in list_reactor_action on missing B=
TF
--

commit fed00056d145e6ae07ec2d9b2b99084fea10c012
Author: Gabriele Monaco <gmonaco@redhat.com>

tools/rv: Add reactors support to BPF monitors

The commit adds reactors support to BPF monitors in the rv tool. It impleme=
nts
rv_react to format and pass messages to a BPF function, which can be overri=
dden
at load time by dynamically linking reactor object files like panic.o and
printk.o.

> diff --git a/tools/verification/rv/bpf_reactors/panic.c b/tools/verificat=
ion/rv/bpf_reactors/panic.c
> new file mode 100644
> index 0000000000000..775f91a300f01
> --- /dev/null
> +++ b/tools/verification/rv/bpf_reactors/panic.c
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +
> +void bpf_rv_react(char *msg)
> +{
> +	struct pt_regs regs =3D { 0 };
> +
> +	crash_kexec(&regs);

[Severity: Medium]
Will the BPF verifier reject this program? The &regs argument evaluates to a
PTR_TO_STACK register type, but crash_kexec expects a tracked PTR_TO_BTF_ID.

The verifier's check_kfunc_args strictly requires KF_ARG_PTR_TO_BTF_ID for
regular struct pointers unless explicitly tagged, so it may reject PTR_TO_S=
TACK.

> +}

[ ... ]

> diff --git a/tools/verification/rv/src/bpf_monitor.c b/tools/verification=
/rv/src/bpf_monitor.c
> index d43ee75d3904f..35bd1f40a109c 100644
> --- a/tools/verification/rv/src/bpf_monitor.c
> +++ b/tools/verification/rv/src/bpf_monitor.c
> @@ -676,12 +679,31 @@ static struct ring_buffer *bpf_setup_ring_buffer(st=
ruct bpf_object *obj,
>  	return rb;
>  }
> =20
> +static void list_reactor_action(const char *name, struct bpf_object *obj)
> +{
> +	const struct btf *btf =3D bpf_object__btf(obj);
> +
> +	if (btf__find_by_name_kind(btf, BPF_REACTOR, BTF_KIND_FUNC) >=3D 0)

[Severity: Medium]
Can this cause a NULL pointer dereference? If the object file lacks BTF
information (e.g., if it was stripped or compiled without -g), bpf_object__=
btf()
returns NULL.

btf__find_by_name_kind() then directly dereferences this NULL pointer in
libbpf's btf__type_cnt() without validation.

> +		fprintf(stderr, "%s ", name);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001152042.1244=
45-1-gmonaco@redhat.com?part=3D12
