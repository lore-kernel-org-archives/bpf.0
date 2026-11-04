Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826594;
	b=MiTKsRjiOjb7xhVcyENqdiHfYENaIVyKdqExiy0Xt+6Q4GP1WPsManKzIecv7Y6EJke2
	 nxbBPEIl5RpbJlNmcp/67HX+IoXePYXVoCZ/aEhLSNLtLCOfdNsnMbQB7wgXXBQO2Ha6y
	 AYw9z2QiUz6i/E8HsLfm3UFzA/RyRArtzAFx8q6z81VDmVgFeffSYBFXPj6Qi+tPSzaTE
	 G4SHOdrRv3YBAjsko8P5wDRKorUxH7EBKs2U/06NCIeYFjcaxMCTTd/PpIEZui3xOXyy1
	 EzDOTs9cugqOXHThsLHiu2SP6ZzIi8eWFVxUAGL1gy1IChGrxCC388i6E7pTZNwHMMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826594;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=y6brttOSyQfuPbUsj1XLHAAdWANxJRJocz3zzeqBxf4=;
	b=UBBpwILAIf4JuGSRBDR5244W71otBjy8wOSmX1lz4HWv72sVlgXFwFMs7zd56Bd1r9MD
	 a4coLCP7kqFe05SIpgup6hCsQZjKhtfvxib/rTA0aPUWsa2v9qVnKpwsU8n/QwnY2XzuS
	 VtWUYjj3Zb/7Y8umZs0TutQTpodsy/VPWg6KbAmsH36WOXif/4OzxzhqW0VrcbMhymur1
	 HeTHKlZcn7+PJZQRglPsIFvLoC8agtTz0ZEja6j/SMDbiStPARalpZynOSWy2RuRskl1D
	 caNPMJBdjijpoiR0QJksbhZJw43vY+3Dsa+lM3UfIQJ2PCf+i7uL4Cza7uubhFM900A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cP9kgqqu;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA518607D640
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 21:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA518607D640
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cP9kgqqu
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a59100fa83so11043945e9.0
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2026 13:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793826592; x=1794431392; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y6brttOSyQfuPbUsj1XLHAAdWANxJRJocz3zzeqBxf4=;
        b=cP9kgqquZGf6yvqJogwHq4tLQuRHtZPK040gjHnMkq8f+jT6ukTBQFrToluoaU5FH3
         hXnlsHhIQeEpWCidDt6b1CMzjIbU2Qm99z1HeI01B6LCbUMBJEayZfA77pK1ZW2YC/Dc
         gzVh6NXMF/FRfabhaNYP7onPoCn0K6L4Sy/FuE6JX11UT2E1CjbAmCNhQdNsDN166RfR
         YFhGCuNkcokiEzihbkjvvNv7wSesQhTA71qEGgktblgsu7paTVDStxmB0w/1YxZc7mcM
         RBOwCb20jo8sIToA9g56+yAZbPlwGgOVdTJ4GtK9xLsshbt3DIPYXsi8BhNwI4Y+tZrj
         nyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793826592; x=1794431392;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y6brttOSyQfuPbUsj1XLHAAdWANxJRJocz3zzeqBxf4=;
        b=EEzFoZpgKz+qPvXVylKzRhnDMn0tR2+8iyfBs2zD4UkSfERSXHHYLUGp7LFKOK3oJK
         yAYJe1FduWtqWsIBtu3mPX26qRWTybiO2OXQG3hfF0sSN4kn2x5CxYc8am78R0+tzQ7B
         BR5d7b9XG+En7PY0HLGUp6b9KbdCj+SDJTnM4QJHs7bbPekNZc4VxXL8NBaQpYQzpfBV
         qc7G+xBULkdIzSE74us0ozChDpDkzKFKYCpfzBEVBiczToN7M/ZpmcrL6XDYDCStXF95
         vC9yZWDrhmCT7bSS3gt3jqrb6RGDbOIfFQH8xkuw7u4PQ7Mkki54ALxCA3kZiUAAJ4xS
         aCuw==
X-Forwarded-Encrypted: i=1; AKwUvBzqWqYmTxp70woG6Zk/omF+ClCeUT/qPPmjP+9NyIdIdIcmTqQuN54aImskUvhQ7wFXb40=@vger.kernel.org
X-Gm-Message-State: APuU4Z+W95cAggHBhnyFjYq8AYyzNIypupQJIpDBgCcguG3HrKKkOlSk
	yKmNvxbjR/3oQsJy+vMO2d9zuZzZ3ChA9oUDVQ9XVkVhIOU2Yb2OmYTX
X-Gm-Gg: AYBFou3lqEwX5pd+zVgeA85iM86i4cgKnyM8NN9pa07CRj+/wHJFvPv7mgu4g+NFdv8
	7WKf0FDEnxAi61Gp9G7EWB8nrPpFXMrbNq2GfXTMSjMxjE0M/9/4qTH0oz6yR66eLc2tr61P2pd
	kz+9QymXBCaLKVlx/ujjz5h5rsg6OR2O3HRMFpMtAhtWgwSNzEY9GvLetS3QJiIGfLSzUAfXobJ
	E+90+ssfW7xSLnkHXNckgTFxn485Ag27UpGuYfwGAPLWhDwl0HUA21zwVF2J/OnKdnFj9IZ40JT
	0OS1/5wDhnoZZDhC1X8TNs96q9WAXQk9PsK5b1zWfXNEEOoeQSWhpvqEd2LgzAjZstYvYwZc+9K
	PK7DMOkZGm/xBm7sVv4ykoHuo1MUFufTui3PnkPkgCl2BARdAou6+UgHYSHOrjMzc3U7AYaRUbY
	hp1jOLTZAlGFWydzYCEePx5ElrrhchiQ5k8dm47L5HsMwsoQhxmymldiueECw0BBGzfutw3WQnX
	RSFQFeKx+6KEgAlb287jFoVdrmkpsATpowmQDvvdsCuzrxdGzrfntVZ6qIuZQZW2+79G70xYdMg
	+II2SBufz0wg74g=
X-Received: by 2002:a05:600c:83c3:b0:4a9:18f4:925e with SMTP id 5b1f17b1804b1-4ac174711afmr372871705e9.18.1793826591951;
        Wed, 04 Nov 2026 13:09:51 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56ea592fbsm9904705e9.4.2026.11.04.13.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:09:51 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 4 Nov 2026 22:09:49 +0100
To: sashiko-reviews@lists.linux.dev
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
	linux-mm@kvack.org, Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Federico Di Pierro <nierro92@gmail.com>
Subject: Re: [PATCHv2 bpf-next 5/8] selftests/bpf: Test user memory mmap
 kfuncs
Message-ID: <auufHZQ_hFUvH3w0@krava>
References: <20261103075916.100050-1-jolsa@kernel.org>
 <20261103075916.100050-6-jolsa@kernel.org>
 <sashiko-outbox-194794@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-194794@kernel.org>

On Tue, Nov 03, 2026 at 08:05:35AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] selftests/bpf: call to undefined get_procmap_info() in user_mem.c
> - [Medium] selftests/bpf: unresolved kfunc externs in progs/user_mem.c
> --
> 
> commit c7cc5f98b3a4b4d8d168ef0934e6c41fe197849d
> Author: Jiri Olsa <jolsa@kernel.org>
> 
> selftests/bpf: Test user memory mmap kfuncs
> 
> This commit adds BPF selftests for bpf_user_anon_mmap and bpf_user_munmap
> invoked from a sleepable uprobe, verifying mapping permissions and
> unmapping behavior.
> 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/user_mem.c b/tools/testing/selftests/bpf/prog_tests/user_mem.c
> > new file mode 100644
> > index 0000000000000..f301a18437062
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/user_mem.c
> > @@ -0,0 +1,112 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <test_progs.h>
> > +#include <sys/mman.h>
> > +#include <sys/personality.h>
> > +#include <unistd.h>
> > +
> > +#include "user_mem.skel.h"
> > +#include "trace_helpers.h"
> > +
> > +enum {
> > +	USER_MEM_MMAP = 1,
> > +	USER_MEM_UNMAP,
> > +};
> > +
> > +static noinline void user_mem_trigger(void)
> > +{
> > +	asm volatile ("" ::: "memory");
> > +}
> > +
> > +static bool check_user_mem_vma(void *addr, unsigned long size, const char *perms)
> > +{
> > +	size_t start, end;
> > +	char vma_perms[5];
> > +	int err;
> > +
> > +	err = get_procmap_info(addr, &start, &end, vma_perms);
> > +	if (!ASSERT_OK(err, "user_mem_vma"))
> > +		return false;
> > +
> > +	/* VMA can be merged, so ensure it covers at least the requested range. */
> > +	if (!ASSERT_GE(end - (size_t)addr, size, "vma_size"))
> > +		return false;
> > +
> > +	return !perms || ASSERT_STREQ(vma_perms, perms, "vma_perms");
> > +}
> > +
> > +static bool check_user_mem_unmapped(void *addr)
> > +{
> > +	size_t start, end;
> > +	int err;
> > +
> > +	err = get_procmap_info(addr, &start, &end, NULL);
> 
> [Severity: Medium]
> Where is get_procmap_info() defined? Both check_user_mem_vma() and
> check_user_mem_unmapped() call get_procmap_info(), and this file includes
> trace_helpers.h, but neither tools/testing/selftests/bpf/trace_helpers.h nor
> tools/testing/selftests/bpf/trace_helpers.c declares or defines
> get_procmap_info().

in previous patch:
  selftests/bpf: Add get_procmap_info helper

> 
> Because test_progs objects are compiled with -Wall -Werror, won't calling an
> undeclared and undefined get_procmap_info() cause compiling and linking
> tools/testing/selftests/bpf to fail?
> 
> > diff --git a/tools/testing/selftests/bpf/progs/user_mem.c b/tools/testing/selftests/bpf/progs/user_mem.c
> > new file mode 100644
> > index 0000000000000..e3b0689f5f2a5
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/user_mem.c
> > @@ -0,0 +1,43 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <vmlinux.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +
> > +#include "bpf_misc.h"
> > +
> > +char _license[] SEC("license") = "GPL";
> > +
> > +extern unsigned long bpf_user_anon_mmap(unsigned long len, unsigned long prot) __ksym;
> > +extern int bpf_user_munmap(unsigned long addr, unsigned long len) __ksym;
> 
> [ ... ]
> 
> > +SEC("uprobe.s//proc/self/exe:user_mem_trigger")
> > +int user_mem_test(struct pt_regs *ctx)
> > +{
> > +	if ((bpf_get_current_pid_tgid() >> 32) != monitored_pid)
> > +		return 0;
> > +
> > +	switch (action) {
> > +	case USER_MEM_MMAP:
> > +		user_addr = bpf_user_anon_mmap(map_len, map_prot);
> > +		break;
> > +	case USER_MEM_UNMAP:
> > +		ret = bpf_user_munmap(user_addr, map_len);
> > +		break;
> > +	}
> 
> [Severity: Medium]
> Can user_mem__open_and_load() in test_user_mem() succeed when loading this
> program?
> 
> user_mem_test() calls bpf_user_anon_mmap() and bpf_user_munmap(), which are
> declared as required __ksym externs, but neither symbol is defined or
> registered as a BPF kfunc in the kernel or bpf_testmod. Won't libbpf fail to
> resolve these kfunc BTF IDs during user_mem__open_and_load(), causing
> test_user_mem() to fail unconditionally?

defined in:
  bpf: Add user memory kfuncs

jirka
