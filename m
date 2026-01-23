Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C727B23A98D
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 08:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769155564; cv=none; b=LQwfntUFnoiQUTt1aQitlieYsdxjq7CN6WpGJ5VbxfamIObQzntr2cQXaf51f8krq8gjgfpXxaM+Lz7V+BD4uQNRL79TD8UuSi8Chy1yoiMi+u7NocYbfB/YcgJj6YMs7Hab+zyRQNaijBNSKcsT2PcCyLnp/s0pjxZiXgmSzYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769155564; c=relaxed/simple;
	bh=NoNHTmDRI4VDQCjM6SBpQBy5k+KRzJXkF8/1Rwg9VeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XRRXlEtFa4fh6i1aDeQ0E4NC4xPmOD896shGLOBVKzFrZ9kCFigcdfyoHJN7V/DssQBiMAtLxMyNTNEH37MMBqhHVsQTC2VUbIlPHjTjhqDQgl1WJ4UZD6uLX14pY5w4MOAWI/yr47H6OhwqIk9ogirNKdc5KEyKv3Ycp/Db8RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jXcqbV9i; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jXcqbV9i"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769155559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZpLS1xvNWvaqlDj8byf7/WXIXjI0jG8CHvPr3U0nJuQ=;
	b=jXcqbV9i4Yacw4nRzEs5u9F48ku5UcoUdZg+ffNtjbPmh7xReTG9ZMDRMWxfquG1fGDSR2
	C7jzPYzYxOaw3YHVvJKEYzIo5fYXB5uGEYxLZ1iT7ihDFF7Xh6i/0oWcfAnkvmNi8xBDgf
	044joIq2RqsaGuGc44FjeT0S7JzNM+E=
From: Menglong Dong <menglong.dong@linux.dev>
To: menglong8.dong@gmail.com, andrii@kernel.org, bot+bpf-ci@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 davem@davemloft.net, dsahern@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, jiang.biao@linux.dev, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
 clm@meta.com, ihor.solodrai@linux.dev
Subject:
 Re: [PATCH bpf-next v11 10/12] selftests/bpf: add testcases for fsession
Date: Fri, 23 Jan 2026 16:05:43 +0800
Message-ID: <12822324.O9o76ZdvQC@7940hx>
In-Reply-To:
 <28d092553ad40300324a21ccbc1dfd89f06283ca4801a5196e993f11e1522e71@mail.kernel.org>
References:
 <20260123073532.238985-11-dongml2@chinatelecom.cn>
 <28d092553ad40300324a21ccbc1dfd89f06283ca4801a5196e993f11e1522e71@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/23 15:57 bot+bpf-ci@kernel.org write:
> > diff --git a/tools/testing/selftests/bpf/progs/fsession_test.c b/tools/testing/selftests/bpf/progs/fsession_test.c
> > new file mode 100644
> > index 000000000000..f504984d42f2
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/fsession_test.c
> > @@ -0,0 +1,110 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2025 ChinaTelecom */
> > +#include <vmlinux.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +
> > +char _license[] SEC("license") = "GPL";
> 
> [ ... ]
> 
> > +__u64 test6_entry_result = 0;
> > +__u64 test6_exit_result = 0;
> > +SEC("fsession/bpf_fentry_test1")
> > +int BPF_PROG(test6, int a)
> > +{
> > +	__u64 addr = bpf_get_func_ip(ctx);
> > +
> > +	if (bpf_session_is_return(ctx))
> > +		test6_exit_result = (const void *) addr == &bpf_fentry_test1;
> > +	else
> > +		test6_entry_result = (const void *) addr == &bpf_fentry_test1;
>                                                           ^^^^^^^^^^^^^^^^^^
> 
> Is the bpf_fentry_test1 symbol declared somewhere? The code references
> &bpf_fentry_test1 but there is no extern declaration with __ksym in this
> file.

The symbol "bpf_fentry_test1" will be declared in vmlinux.h, which is
generated automatically.

> 
> Other BPF selftests that take addresses of kernel symbols declare them
> explicitly, for example get_func_ip_test.c has:
> 
>     extern int bpf_fentry_test1(int a) __ksym;
> 
> And kprobe_multi_session.c has:
> 
>     extern const void bpf_fentry_test1 __ksym;
> 
> Without a similar declaration, will this BPF program compile and load
> correctly?

As I said above, it won't cause compile problem.

Thanks!
Menglong Dong

> 
> > +	return 0;
> > +}
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21278745581
> 




