Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDFD372EFF;
	Fri,  7 Aug 2026 18:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786128103; cv=none; b=b45kU/merjzMjp9HMImwd2jCOQK/HTiIj+sBMEA+q1KKgFShtBIlEm9xgqDjGXg4bx3MfOI0Lh2RmYn5GNj/6raDrsoS+5Zp+H49Oa5jT78EZ8lk46RLnQWkEDnzvSyl6BHq2KWwl2/HXjoVfPGM3U/uptrIadLogiux3CEevLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786128103; c=relaxed/simple;
	bh=XVV7hOgWnCFpL7U6Ae7wQrOvW1wHNIWKqGFVEsR5j5s=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ByD/TIiB/kp/vmtqZM2sURq0Mza+lrWCU9jVUzV6rvykCVayOXGna3X2hatTViSpQpEBZU4wxFq9MPj+dZ1eNs2QvvJmesLl20MgLQHQhuv5ghDhdF/lOy4pKLzvSNORjxRspdoGhcG65xZ3kNLu4KFMLB4aOfHewOjvLrdF2ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJbKhU3v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJbKhU3v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530401F000E9;
	Fri,  7 Aug 2026 18:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786128101;
	bh=1fvthPLXP6I2226nh/VOQy7w9V6Y86YRryAUsNAJq3w=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=eJbKhU3vqSQWAY2GWHI5EpXYesykkTX3A1JtFTg3+uy+R/XN1QjTEUmtmWSgo5ens
	 QcZaZ58NadmHiQUYAP6VtqVmHtNpn5HUZnprFxK4YqJ/HM4QYJp5tvufxQh3Ra2MeN
	 dW8OiTzMqwdkQdeo3yCWZpNbXhDSUqbsa3msFoKjMN7hPF0xO07RE3eiG7udt3Z2jd
	 42JVzswbT5ZB6UWZ9D8Bexe9IRf2IDlCaiGYKck8khh4kL/Ew/aCnTwm6PYXJgxMn9
	 DzHrfhj0sbi0PNhKs9ye5Jdc4ZrTt7jW6VPbmk0z33EPjdBvgR3g2SirbjIjmUsCmM
	 QfItMTgfAo+mg==
Content-Type: multipart/mixed; boundary="===============4596101357538191178=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b86b0f951182de8fd972fc8f1a7d138e98a95b1e3804335cfab89ba24b1dacca@mail.kernel.org>
In-Reply-To: <20260807171532.125149-5-mahe.tardy@gmail.com>
References: <20260807171532.125149-5-mahe.tardy@gmail.com>
Subject: Re: [PATCH bpf-next v5 4/5] selftests/bpf: Test forbidden bpf_ksock_send() LSM attach
From: bot+bpf-ci@kernel.org
To: mahe.tardy@gmail.com,bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch,andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,davem@davemloft.net,eddyz87@gmail.com,edumazet@google.com,john.fastabend@gmail.com,kuba@kernel.org,liamwisehart@meta.com,martin.lau@linux.dev,pabeni@redhat.com,song@kernel.org,netdev@vger.kernel.org,sdf.kernel@gmail.com,ameryhung@gmail.com,kuniyu@google.com,memxor@gmail.com,jiayuan.chen@linux.dev,mahe.tardy@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  7 Aug 2026 18:41:40 +0000 (UTC)

--===============4596101357538191178==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c b/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c
> new file mode 100644
> index 000000000000..5b969e03b6d6
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c
> @@ -0,0 +1,36 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Isovalent */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include "bpf_misc.h"
> +#include "bpf_tracing_net.h"

This isn't a bug, but does ksock_lsm_verifier.c still need bpf_tracing_net.h?
The AF_INET/SOCK_DGRAM constants it provides look like they're only used by
ksock_lsm.c, so the include could probably be dropped here.

> +#include "ksock_common.h"
> +
> +char send_data[11] = "dummy data";
> +
> +SEC("lsm.s/socket_sendmsg")
> +__description("bpf_ksock_send is rejected from socket_sendmsg LSM hook")
> +__failure __msg("calling kernel function bpf_ksock_send is not allowed")
> +int BPF_PROG(ksock_socket_sendmsg, struct socket *sock, struct msghdr *msg,
> +	     int size, int ret)
> +{
> +	struct __ksock_ctx_value *v;
> +	struct bpf_ksock *ks;
> +
> +	v = ksock_ctx_value_lookup();
> +	if (!v)
> +		return ret;
> +
> +	ks = bpf_kptr_xchg(&v->ctx, NULL);
> +	if (!ks)
> +		return ret;
> +
> +	bpf_ksock_send(ks, send_data, sizeof(send_data));
> +	bpf_ksock_release(ks);
> +
> +	return ret;
> +}
> +
> +char __license[] SEC("license") = "GPL";


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31202489240
--===============4596101357538191178==--
