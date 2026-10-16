Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C2743E9FB;
	Fri, 16 Oct 2026 09:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143263; cv=none; b=lV2sRzvZ3Gg0xMMp7ACkQwhXaksrwpXoZcBxuSZgNBQqwBLyHybVLjBJYdWK4RBJ3XkqImLrOqK8LB+bduOi4azeJ03vrFWaBIqL8Fq3yQD6KRS44YV4EFEtGp6xt5pX8iAKWiyAXReBXt/WGJUM52qpujE8eTeBD88F1UKumkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143263; c=relaxed/simple;
	bh=x3e7JFL7g+Lboyfi5AfNETW+d7AigUz1qAmmDRhaCig=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=lZDql+GMVYApph/1nLKHAL+UD6JokxIwJ/+0ia/bGlT7XICfT+4njawx11ty+5dvhs6dgXnKYHmvtC6rhTWsGGTTpTXeFaNYt+wtoc1/H8YD+N/TDKavE9+0DMefktE+jwimDkmiO4t7LUuR8ynk4XtRs7N73yve4Yu30q1JZe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcFeJeHh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcFeJeHh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939B21F000C4;
	Fri, 16 Oct 2026 09:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792143262;
	bh=I0t6Wvt7LkXoLJn6wAMqnAnbwTwxXW+PnWR1YWVNFEE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=CcFeJeHhxkoA9ZjTXaJ2+vpvCR8HXD7k/lvNGco18zVac58DNgb/gTVHJqZegAHET
	 LSTYZ/y5uZdknuQlnJ0jnQdtYybYtJtkJ/WO1YRQirWbZVmsqPnroaagANHkjaQU13
	 Y3J7U7I6QuSgTBvoDIwaPK/3BN7JSH/Q4bVXZcKgyRwc5Qh+j2uFbu+58Xrj9+5ko5
	 zGT2HBhf0zVrp/Vs0Rsmp3sFVosRZByz2obRAbNMX0ykZhjHJzNEhtoh+61QdJoS1r
	 TDzUmSUB5lntsJOwyHX3/YcUwS2xAZGc3TDXjAE2cnlCHiHsiPRVQRaebl+ZyWrNlI
	 37XqoqDakb2qw==
Content-Type: multipart/mixed; boundary="===============1992164897828636348=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6b87bbbbc031c06f1b95355aa6f5df72b4d598885ad5d219d9cc30b75a475566@mail.kernel.org>
In-Reply-To: <20261016085353.9512-1-mahe.tardy@gmail.com>
References: <20261016085353.9512-1-mahe.tardy@gmail.com>
Subject: Re: [PATCH bpf-next v6] bpf: allow ksock connect/send calls from wq
From: bot+bpf-ci@kernel.org
To: mahe.tardy@gmail.com,bpf@vger.kernel.org
Cc: andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,davem@davemloft.net,eddyz87@gmail.com,edumazet@google.com,john.fastabend@gmail.com,kuba@kernel.org,liamwisehart@meta.com,martin.lau@linux.dev,pabeni@redhat.com,song@kernel.org,netdev@vger.kernel.org,sdf.kernel@gmail.com,ameryhung@gmail.com,kuniyu@google.com,memxor@gmail.com,jiayuan.chen@linux.dev,almagui@kernel.org,mahe.tardy@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 16 Oct 2026 09:34:19 +0000 (UTC)

--===============1992164897828636348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: allow ksock connect/send calls from wq

TL;DR: Nits only, all in the ksock_wq selftest: a possibly unneeded bpf_misc.h
include, an unneeded "err = 0" initializer, and a stray extra blank line.

> diff --git a/tools/testing/selftests/bpf/progs/ksock_wq.c b/tools/testing/selftests/bpf/progs/ksock_wq.c
> index 16a1873d132e..24246bf2c748 100644
> --- a/tools/testing/selftests/bpf/progs/ksock_wq.c
> +++ b/tools/testing/selftests/bpf/progs/ksock_wq.c
> @@ -2,9 +2,11 @@
>  /* Copyright (c) 2026 Isovalent */
>  
>  #include "vmlinux.h"
> +#include <bpf/bpf_endian.h>
>  #include <bpf/bpf_helpers.h>
>  #include "bpf_experimental.h"
>  #include "bpf_tracing_net.h"
> +#include "bpf_misc.h"

this isn't a bug, but is the new #include "bpf_misc.h" needed by this
program?

None of the macros defined in progs/bpf_misc.h seem to be used in
ksock_wq.c (bpf_htonl() comes from the bpf_endian.h include added just
above), so could this include be left over from an earlier version?

[ ... ]

> @@ -35,28 +41,86 @@ static int ksock_wq_callback(void *map, int *key, void *value)

[ ... ]

> +static int wq_set_callback_start(int (*callback_fn)(void *, int *, void *), u32 key)
>  {
>  	struct ksock_wq_value *value;
> -	u32 key = 0;
> -	int err;
> +	int err = 0;
>  

this isn't a bug, but is the 'int err = 0;' initializer needed here?  err
is always assigned by bpf_wq_init() before it is read.

[ ... ]

>  	if (err)
>  		return err;
> -	return bpf_wq_start(&value->work, 0);
> +
> +	return 0;
> +}
> +
> +
> +SEC("syscall")
> +int ksock_wq_start(void *ctx)
> +{

this isn't a bug, but is the second blank line before SEC("syscall")
intended?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38878629001
--===============1992164897828636348==--
