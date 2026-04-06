Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73A61F192E
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 01:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775437413; cv=none; b=g27Du3duwTwxhpvBXmPb68KM/fPIrWHEkHZ6FAhJI7zM976gkroqYKbndRNSxerdYemXBpZGY7zPJWwgfURgbnFproP/hoXVML6SRSF5TVfsBOejTEXU91Hq8iKBULonDC4Cm7TE32sBLmjj5ofuUzb/RoySkD1XKc1e+Pp3jSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775437413; c=relaxed/simple;
	bh=esr47UCkLxD1YtojkWPFbC3NCxJMts2md1AFUQhLVnE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Q05oVBUdE7LkJA+UMlL2zdiPGcshUJNm13mM9QP6jkUJE5XCs3zgqNARgHvOcKCgNHWkVaJ6EV9H+mnpIAK3uxoAyODihzWFq4y402zfN3oTFajfyycnz7Za42rkju7iBfLGgfRxrHZbojBHxkchor/MLLastI5Vf03DtWkS/iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=jD9SSy0c; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="jD9SSy0c"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a8fba3f769so12973165ad.2
        for <bpf@vger.kernel.org>; Sun, 05 Apr 2026 18:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775437411; x=1776042211; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCTxznMx+k7hfrBNHLnSvWpqoSsZmEm+dnPCVW7PAOA=;
        b=jD9SSy0cBsf/nJYrhXxJHJh993FLaCV9FbFCt8SZTV3lAFs+qOor4SLM1lP+bEXtSX
         WeLxV1IXL53caFkNvk1DgLST8gR+uOkeLiMzJj7X8ljCDjjK0d9gYS9Ie+RNuujkkMdF
         16jZDIUWLkk89FKJrP2uHWeTCj5bldeA5WTlqSZAmm78G9RTLO2E3TEI+9mi1jAyTK4z
         2e+uBoilcTxeg0kIkhjJTL4wtR/eIwtAqmhd6Fp/uP0VekcwWh0Bji6C4z2rLvarUWP0
         OjP9KdEaiPcIcyTUgJuWx9EBxLtUmF2fOwV4MSgbey6ndzlLTFMKjzq+biQdqQRmkSld
         zvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775437411; x=1776042211;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MCTxznMx+k7hfrBNHLnSvWpqoSsZmEm+dnPCVW7PAOA=;
        b=ZG6eMIzK4xHqIRN6zjT6za0/ztbysrIG8slaZdtajOIWrd13PNsTMpamojwmOqEnNB
         /LHB9wCoH6wBhSrPrsUHKkyBZTyJ4vCBy4/2hrJbcXa01UjK1B5vvHpOZfcnyUpnQf6C
         87Kn/dwZCuv4YCWEVK4BatfbMZOaOPxK6nMoPw03e+25k7m6A+RFbVubqMHemRKbti+j
         2chulnw7BPQt0nhJV2q0qRYHz6EtZBvymkOEFZ1T8AVp0xuGUK8kJV7kAjTVxUUeidS8
         Iu/DsjgcfHsfoaSmONqZE9eoAzCNZEkFcbixidVR/Euj9NB5lu1AZjkml1LxoPEEyBxU
         DL5g==
X-Forwarded-Encrypted: i=1; AJvYcCWhj0S9FJwQ+nLw28QyD+JEPiRXwMTEdwTGse7s1AngFr+LZ6o26eup6eKaqIkzTnZlwqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwelWrWIgLniS1CUOehvfwKuT/VJvCGhXajgURaE5KFW0WJENe3
	+Nc1KMN7gKJFAD9CrGMu5C9u7uEUZ72tWIvT4JerVTC5QZvekEvvUN7hIJDAUKzgSXH1mb+gGRW
	5HslZ1GjIkw==
X-Gm-Gg: AeBDievDEljuDa39vpNP4aJTueN8/pqABIa/GD3mwm7AaU18FeFarZYJ1AnIrc3J/0k
	posCQGeIIoNpO5hl7LrVQK74dcCP82IydbPJ2fv5RuvgsAJv3Tfa6LfDETGZPIPkU7q0rA2hstW
	2KZlbPtqDDFpj1vuu4ii1ijRT7yv2ZQHQKtSCPuqHlDa759M2BIRcOUmB1ynypVlDWLJ3mW98wl
	RccG95voshEnaZ19PO6eetCkZHbGrIWFOPSeRBBbKJeXbPDPYJidY9zcf1+xgPE5J4ILSZPkSLu
	vT/hXia4FQ/sPRs0DK6api0VUsDnq21RHIag2Bb6hghUhUZQeeTREJ7owUXCS2pMX0GOw2tyTKp
	9K6M1RIAbp1NtfxB+Riu5ID+bdT9Sup4YE9ua72di0mKQVhfQaGuY8G3SLXq6QHr1WQT2WTXjDk
	jqMWMGcJ8=
X-Received: by 2002:a17:903:2ed0:b0:2b2:5099:2f3e with SMTP id d9443c01a7336-2b281715591mr119245005ad.4.1775437410723;
        Sun, 05 Apr 2026 18:03:30 -0700 (PDT)
Received: from localhost ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749e2e97sm156337325ad.82.2026.04.05.18.03.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2026 18:03:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 05 Apr 2026 21:03:29 -0400
Message-Id: <DHLO1A0NS3Y4.RCC3HX5M5D68@etsalapatis.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>, "Stanislav Fomichev"
 <sdf@fomichev.me>, "David S. Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf v1 2/2] selftests/bpf: Add test for SOCK_OPS_GET_SK
 with same src/dst register
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260404141010.247536-1-jiayuan.chen@linux.dev>
 <20260404141010.247536-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260404141010.247536-2-jiayuan.chen@linux.dev>

On Sat Apr 4, 2026 at 10:09 AM EDT, Jiayuan Chen wrote:
> Add a selftest that verifies SOCK_OPS_GET_SK() correctly returns NULL
> when dst_reg =3D=3D src_reg and is_fullsock =3D=3D 0.
>
> The BPF program reads ctx->is_fullsock, then loads ctx->sk using the
> same register for source and destination. When is_fullsock =3D=3D 0, sk
> must be NULL. The test triggers this path via a TCP handshake (which
> causes TCP_NEW_SYN_RECV state) and checks:
>  - null_seen =3D=3D 1: the is_fullsock=3D=3D0 path was hit with correct N=
ULL sk
>  - bug_detected =3D=3D 0: sk was never non-NULL when is_fullsock=3D=3D0

Can you add a test for dst_reg !=3D src_reg, too?

>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  .../bpf/prog_tests/sock_ops_get_sk.c          | 62 +++++++++++++++++++
>  .../selftests/bpf/progs/sock_ops_get_sk.c     | 44 +++++++++++++
>  2 files changed, 106 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_ops_get_s=
k.c
>  create mode 100644 tools/testing/selftests/bpf/progs/sock_ops_get_sk.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sock_ops_get_sk.c b/t=
ools/testing/selftests/bpf/prog_tests/sock_ops_get_sk.c
> new file mode 100644
> index 0000000000000..9eaf97786c1d9
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/sock_ops_get_sk.c
> @@ -0,0 +1,62 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +#include "cgroup_helpers.h"
> +#include "network_helpers.h"
> +#include "sock_ops_get_sk.skel.h"
> +
> +/*
> + * Test that reading ctx->sk with dst_reg =3D=3D src_reg in a sock_ops p=
rogram
> + * correctly returns NULL when is_fullsock =3D=3D 0 (TCP_NEW_SYN_RECV st=
ate).
> + *
> + * The bug was in SOCK_OPS_GET_SK() macro which failed to zero the desti=
nation
> + * register when it was the same as the source register and the socket w=
as not
> + * a full socket. This left the ctx pointer in the register, which then =
passed
> + * the NULL check and could be used as a socket pointer, causing OOB acc=
ess.

The reader of this file will not have context on the original bug, and
the dst_reg =3D=3D src_reg condition is more obvious in the BPF file. Can
you move it there?

> + */
> +void test_sock_ops_get_sk(void)
> +{
> +	struct sock_ops_get_sk *skel;
> +	int cgroup_fd, server_fd, client_fd;
> +	int prog_fd, err;
> +
> +	cgroup_fd =3D test__join_cgroup("/sock_ops_get_sk");
> +	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
> +		return;
> +
> +	skel =3D sock_ops_get_sk__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open_load"))
> +		goto close_cgroup;
> +
> +	prog_fd =3D bpf_program__fd(skel->progs.sock_ops_get_sk_same_reg);
> +	err =3D bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_SOCK_OPS, 0);
> +	if (!ASSERT_OK(err, "prog_attach"))
> +		goto destroy_skel;
> +
> +	server_fd =3D start_server(AF_INET, SOCK_STREAM, NULL, 0, 0);
> +	if (!ASSERT_GE(server_fd, 0, "start_server"))
> +		goto detach;
> +
> +	/* Trigger TCP handshake which causes TCP_NEW_SYN_RECV state where
> +	 * is_fullsock =3D=3D 0. With the bug, ctx->sk loaded with same src/dst
> +	 * register would return a stale ctx pointer instead of NULL.
> +	 */
> +	client_fd =3D connect_to_fd(server_fd, 0);
> +	if (!ASSERT_GE(client_fd, 0, "connect_to_fd"))
> +		goto close_server;
> +
> +	close(client_fd);
> +
> +	/* Verify that the is_fullsock =3D=3D 0 path was hit and sk was NULL */
> +	ASSERT_EQ(skel->bss->null_seen, 1, "null_seen");
> +	ASSERT_EQ(skel->bss->bug_detected, 0, "bug_not_detected");
> +
> +close_server:
> +	close(server_fd);
> +detach:
> +	bpf_prog_detach(cgroup_fd, BPF_CGROUP_SOCK_OPS);
> +destroy_skel:
> +	sock_ops_get_sk__destroy(skel);
> +close_cgroup:
> +	close(cgroup_fd);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/sock_ops_get_sk.c b/tools/=
testing/selftests/bpf/progs/sock_ops_get_sk.c
> new file mode 100644
> index 0000000000000..4a75614b21eb5
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/sock_ops_get_sk.c
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +/*
> + * Test that SOCK_OPS_GET_SK() correctly returns NULL when dst_reg =3D=
=3D src_reg
> + * and is_fullsock =3D=3D 0 (e.g., during TCP_NEW_SYN_RECV). Before the =
fix, the

Again, writing "the fix" here is vague.

> + * macro failed to zero the destination register, leaving a stale ctx po=
inter
> + * that bypassed the NULL check.
> + */
> +
> +int bug_detected;
> +int null_seen;
> +
> +SEC("sockops")
> +__naked void sock_ops_get_sk_same_reg(void)
> +{
> +	asm volatile (
> +		"r7 =3D *(u32 *)(r1 + %[is_fullsock_off]);"
> +		"r1 =3D *(u64 *)(r1 + %[sk_off]);"
> +		"if r7 !=3D 0 goto 2f;"
> +		"if r1 =3D=3D 0 goto 1f;"
> +		"r1 =3D %[bug_detected] ll;"
> +		"r2 =3D 1;"
> +		"*(u32 *)(r1 + 0) =3D r2;"
> +		"goto 2f;"
> +	"1:"
> +		"r1 =3D %[null_seen] ll;"
> +		"r2 =3D 1;"
> +		"*(u32 *)(r1 + 0) =3D r2;"
> +	"2:"
> +		"r0 =3D 1;"
> +		"exit;"
> +		:
> +		: __imm_const(is_fullsock_off, offsetof(struct bpf_sock_ops, is_fullso=
ck)),
> +		  __imm_const(sk_off, offsetof(struct bpf_sock_ops, sk)),
> +		  __imm_addr(bug_detected),
> +		  __imm_addr(null_seen)
> +		: __clobber_all);
> +}
> +
> +char _license[] SEC("license") =3D "GPL";

