Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE054908D6
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 17:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786726958; cv=none; b=CTm33DnXvbn8SK4ahKHqA4EmOtkJxhpXK8TP3x1qR1iz3W9BPr/lJj14b7KK2JL/zzCQks78aJpPusZxr051mScb5cK/XUXvmryQkA/TCz9XcixOhmvVv/JMWneLKPiXRJjoZLHieHUJnWxzvTshtpjmVxjI2ApHQ6mXvSnQQ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786726958; c=relaxed/simple;
	bh=V3nvXf3+/CFfWZbw5zMeH8gJw9d23Xs5gUZiRrc+CtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXbA41Bd+1fmitHFMmRbVRyhvyyRqUENIXhQH2dlkFtVApHpTnHlaasV3epX3xReyVobZZZm0PiZDZcM16bbZyo6HvTNo/3743vUmUMD0tTxp+Wq95CtfYzyOim2C+VlYULudZhmVPVD2iSzTrdB2NF+8Al9pVMMJpJDX4NAsF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=be2E5FL4; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="be2E5FL4"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4998590d392so13200035e9.0
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 10:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786726955; x=1787331755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IF42ZuIW9yF9A7a9sUDgQVbQl7kYmWIXZAUKHoESs64=;
        b=be2E5FL422+5MsZjYpw2lonQOTFDa2GD7ETWm9FgaGjgqsQXgd9lZVOZlpFH9WYJf7
         tEdg20iQ0LCNyPHfyxv+6P/HODDd0EWRlXvdt5g9FhduCuOWW0NpQEG+Nh0s0fix2vWD
         nFFVV9fgLoY8GmO/XEq1m4nps9WrGKGTVmVI3izxCUCmvUkCx2kP4Zbdc+PQqxIY/uDR
         h+Roz5/K96FNJbUC0QWSskYXHolOlIrc/IqgbeK6Z7XUvjAF1L/KWeywBqHhWfg+NGMo
         mWnGXSLznhBVD4w0I/CLnuTYQwrMeZ93lDa/g3Y7Ja01WOXi+dY+JIyvUl8agXI/MjfB
         bNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786726955; x=1787331755;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IF42ZuIW9yF9A7a9sUDgQVbQl7kYmWIXZAUKHoESs64=;
        b=jeIRxvclTN4ER9+uxvRBFMdnENxB+Kn/A1UxAJ8qSpd9qox1hor9TLCcXiBGy+yFnb
         KfOfLmf1HSsepsYgXDCug69Cnb38VT7yRgUTK6OLDKp8erPO61F2ojoINqANLMwCwsRc
         3xacer8IzF2L3V43GcGBvUtUyggI69/SZWc9xbBUlQoM5EjkjnBrlR+EGyTZMQItV2YE
         vOr1yS0oQlEHmiR9sCij3ubdhVySsI2th2d1qaGPgX/nIEbBxC3hn2IBfjikkRRYj25m
         qWQ2Q0pw9VRFmNlYjH53XtUQMkbtdsLGFAB57ctirNv5TcHH6Ybua0sHQtKvHPOw15Og
         5oOw==
X-Gm-Message-State: AOJu0YzIHr2wBjzNueti7Kk5m+omNmWH7U3YwiveyXVmLMuzbhYwvm9k
	O4bQ4xf0EI6nk1fOHjDh73N3e9rMb8d5NzmFLwmrNPMR7vU1Xq+fCp1d
X-Gm-Gg: AR+sD13kuBXGaaIim+5mvcOASnGAOrqnS0oimVByGeac66LcBVmAySkgAar/L4dcofo
	IrEpXSRovLYO/fGCLr9JhhHcorA9yrrZpgaZgFdUEpW1vCbDcFMNioskobbB5QjR/VLVv/Npe5t
	vISBR+Ce7qrjS5fABam/7S0r1G/++B1Ve4Gih6YHp4+kJ7ZEbOUABwADKDBvrdcpjcJjl1/uVyc
	BEYHNrhGolK1cFRqM5UQ2UF2BcbtTtHxBRGy5taLa1DYDpPGLrnfcC9d+HXp4Wqp6f1dAaLAz8w
	dmTkqn8lsDbcwZdOgh7phHur5dxC2QK2Fi1dxJe6A4YPYx7NxOEGmkY6WYmxRmS2VJqYj0jc04p
	64J6TaTb3z70TKp4DZ+Qzb06wLKfiSn96oDzcG+px2M8qdJHvZj6PF83Om7gW4o8yxumDjUNeN+
	ko20EoGvHso2VELEtzPzf0GL4oGDhh6RQW9tic2CMcnpgiCKuErQfNMv+k/moMfci7cdIhRcM7W
	q980MI7vgDRdtg7+Y1/dsUYaWYXpB8=
X-Received: by 2002:a05:600c:8b05:b0:499:7a15:fcec with SMTP id 5b1f17b1804b1-499879923ecmr110696545e9.13.1786726954708;
        Fri, 14 Aug 2026 10:02:34 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2c18cbsm8431365f8f.29.2026.08.14.10.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 10:02:34 -0700 (PDT)
Date: Fri, 14 Aug 2026 19:02:32 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com,
	kuba@kernel.org, liamwisehart@meta.com, martin.lau@linux.dev,
	pabeni@redhat.com, song@kernel.org, netdev@vger.kernel.org,
	sdf.kernel@gmail.com, ameryhung@gmail.com, kuniyu@google.com,
	memxor@gmail.com, jiayuan.chen@linux.dev, sdf@fomichev.me,
	martin.lau@kernel.org, yonghong.song@linux.dev, clm@meta.com,
	ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v7 5/5] selftests/bpf: Add ksock test for async
 callback guard
Message-ID: <an9KKJtU5XrastyR@gmail.com>
References: <20260813110540.103550-6-mahe.tardy@gmail.com>
 <62274a8d6156015b945bc8e7b5b8c2962332b104e3484a5a2d0e0b0c95b531b1@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62274a8d6156015b945bc8e7b5b8c2962332b104e3484a5a2d0e0b0c95b531b1@mail.kernel.org>

On Thu, Aug 13, 2026 at 12:13:31PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/testing/selftests/bpf/prog_tests/ksock_wq.c b/tools/testing/selftests/bpf/prog_tests/ksock_wq.c
> > new file mode 100644
> > index 0000000000000..d6dc20b8f95bb
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/ksock_wq.c
> > @@ -0,0 +1,45 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2026 Isovalent */
> > +
> > +#include <unistd.h>
> > +
> > +#include "test_progs.h"
> > +#include "ksock_wq.skel.h"
> > +
> > +#define CALLBACK_WAIT_RETRIES 1000
> > +#define CALLBACK_WAIT_US 1000
> > +
> > +void test_ksock_wq(void)
> 
> This commit adds a new standalone test file for the workqueue guard check.
> The same directory already has prog_tests/ksock.c (from commit a529f8c4d088b
> two patches earlier in this series) which is the home of the ksock kfunc
> tests. Notably, the immediately preceding commit in this series
> (75ef545fdff15) added its negative test as a new function inside the
> existing prog_tests/ksock.c rather than creating a new file. A subsystem
> pattern flags this as potentially concerning: should test_ksock_wq() be
> another function/subtest in prog_tests/ksock.c, consistent with how patch
> 4 of this same series added its case? The split means the ksock feature's
> tests are now across two files with generated test names 'ksock_lsm',
> 'ksock_lsm_verifier' and 'ksock_wq' rather than grouped together.

Yes indeed this one was added in a separate file, not sure it's
important.

> 
> > +{
> > +	LIBBPF_OPTS(bpf_test_run_opts, opts);
> > +	struct ksock_wq *skel;
> > +	u32 callback_done;
> > +	int err, i;
> > +
> > +	skel = ksock_wq__open_and_load();
> > +	if (!ASSERT_OK_PTR(skel, "ksock_wq open and load"))
> > +		return;
> > +
> > +	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.ksock_wq_start),
> > +				     &opts);
> > +	if (!ASSERT_OK(err, "run ksock_wq_start"))
> > +		goto out;
> > +	if (!ASSERT_OK(opts.retval, "ksock_wq_start retval"))
> > +		goto out;
> > +
> > +	for (i = 0; i < CALLBACK_WAIT_RETRIES; i++) {
> > +		if (__atomic_load_n(&skel->bss->callback_done, __ATOMIC_ACQUIRE))
> > +			break;
> > +		usleep(CALLBACK_WAIT_US);
> > +	}
> > +	callback_done = __atomic_load_n(&skel->bss->callback_done,
> > +					__ATOMIC_ACQUIRE);
> > +	if (!ASSERT_EQ(callback_done, 1, "workqueue callback completed"))
> > +		goto out;
> > +
> > +	ASSERT_EQ(skel->bss->create_err, -EOPNOTSUPP,
> > +		  "workqueue create rejected");
> > +
> > +out:
> > +	ksock_wq__destroy(skel);
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/ksock_wq.c b/tools/testing/selftests/bpf/progs/ksock_wq.c
> > new file mode 100644
> > index 0000000000000..16a1873d132ed
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/ksock_wq.c
> > @@ -0,0 +1,62 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2026 Isovalent */
> > +
> > +#include "vmlinux.h"
> > +#include <bpf/bpf_helpers.h>
> > +#include "bpf_experimental.h"
> > +#include "bpf_tracing_net.h"
> > +#include "errno.h"
> > +#include "ksock_common.h"
> > +
> > +struct ksock_wq_value {
> > +	struct bpf_wq work;
> > +};
> > +
> > +struct {
> > +	__uint(type, BPF_MAP_TYPE_ARRAY);
> > +	__uint(max_entries, 1);
> > +	__type(key, u32);
> > +	__type(value, struct ksock_wq_value);
> > +} work_map SEC(".maps");
> > +
> > +int create_err;
> > +u32 callback_done;
> > +
> > +static int ksock_wq_callback(void *map, int *key, void *value)
> > +{
> > +	struct bpf_ksock_create_opts opts = {
> > +		.family = AF_INET,
> > +		.type = SOCK_DGRAM,
> > +		.protocol = IPPROTO_UDP,
> > +	};
> > +	struct bpf_ksock *ks;
> > +	int err = 0;
> > +
> > +	ks = bpf_ksock_create(&opts, sizeof(opts), &err);
> > +	if (ks)
> > +		bpf_ksock_release(ks);
> > +	create_err = err;
> > +	__sync_fetch_and_add(&callback_done, 1);
> > +	return 0;
> > +}
> 
> [ ... ]
> 
> >     selftests/bpf: Add ksock test for async callback guard
> >
> >     Because the kfuncs are going through LSM hooks, allowing their use via
> >     workqueue callbacks would expose the wrong credentials. This test
> >     ensures the kfunc are preventing any use from these contexts.
> 
> This isn't a bug, but the changelog says the test "ensures the kfunc are
> preventing any use from these contexts", which reads as covering the
> whole kfunc set. The added program exercises exactly one kfunc from the
> workqueue callback, bpf_ksock_create(). The other two kfuncs that carry
> the same runtime guard, bpf_ksock_connect() and bpf_ksock_send(), are not
> exercised from an async callback anywhere in the tree. Would it be worth
> either narrowing the changelog to say the test covers bpf_ksock_create(),
> or extending the callback to also call bpf_ksock_send() on a stashed kptr
> so all three guarded kfuncs are pinned?

Yeah, eventually they all call bpf_ksock_has_user_task_context() so the
runtime guard tested is the same.

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31694719067

