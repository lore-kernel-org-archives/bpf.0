Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA7543B6F0
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 10:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786616007; cv=none; b=bvRXtCfmXuMLxRIVANbTOUyIzKABtYXG28rgiZSiCqF0d/pQJeWgHSD/dL26S4WQSLpD80N7r7Tfa37gbrdAssIhNxaEbP1zQyQ25PLLm918eIAa0UWiNjYLeYktlc89ue3/5OMUZcj9RnCLvphkNqJVaDiTdCfIOEci4PdQg5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786616007; c=relaxed/simple;
	bh=VNqAjouGl0DgXdxFLP6U0GGMMmgOOvcbRsPlNLCe8ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhbMk7/M3OBG+vWV5JYR5TyNsnT02TgIGbkckwmQHgzrl+uUShuE84iJIrjwyde2+dca0npewpDkqB7F/TdHFqOyxYL13cxlg+mtRjwv//wZ/jG66eSXyNY14L+/gaBeyrZ2ZjrGLQY0d1c1Fz9Qt/yyUYA4c9WwSBve4sLkpkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jtbo/9XV; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtbo/9XV"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47f59f25ec4so744934f8f.2
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 03:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786616003; x=1787220803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NrOZueBhFN0ZmDbFx88d1p3GnP8LNGEUfoQ4yi+QHNY=;
        b=jtbo/9XV2tH0QR5G2RUxH9hE4YKvpr72lCsbmYeqgAH1nwWjhzyPBkoPmJLJpTTxhU
         oBKrtsdvgtnlvywZgCf2Y1Xo/jPXfWMV/Q0k/pksbfd3L5NnJjAsUmVRGbpG71wOUX1q
         Gzcx0ayx6pcFfpTbYuZNRrYiV+DInCvxOsikgbsTK21DTmwPXphSqmnmEa7Udbhk7PXc
         3HU2I7AvZEC3Vhbn1WWtAkrxhdHQAYF8UVSOKJ1N2kbqqZfoij+D1uGxs52zP1TzWMXe
         5MSi3M7uEsruXoNjhWzLNtPICbyh0eCbQkcS+Z5+E81Tq1s00W2oHtgaCE3r4S1y944+
         rhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786616003; x=1787220803;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NrOZueBhFN0ZmDbFx88d1p3GnP8LNGEUfoQ4yi+QHNY=;
        b=JsAvf2D4aVPJboRwdr0exHzymFQzkarvCoMIYH0igphd67Z0U9xdd1ml5UQOre5PiQ
         IMi6hRxwJxVPBI8Sw8rmb4cUMu1ksyKRstM297+O/z36+iQlcB8hkvYNZPAfBJSFWidO
         OihZalHdPubQSwCO0lrSfx65NZxAsDM+Yp4hcevAy+MUsxVr79pCRIkfKaaR24dATBVs
         GS0YE23UzS+AtOEMA0SxzV9BIGyCdei0Y59FpMsu12YoswKuz2dz5qNm68teOu7tt6bN
         uWFajkUMUtXqIOFm3GCPuSddZrlLpSOaSR5CVdFuWqUo2aDyHKflBYHBjLH2ioLGVi19
         VPbw==
X-Gm-Message-State: AOJu0YzaRIQQ2G7UzvR6FTimsGv8sCmA76gtWU6LaDooz/SWt7W00Zk3
	wDNgmVXFkxBvrACiVzl5mEdegJEqwv6G2/ovsbaupE9GQM3XdejymL/mNPNDT9dAsNyIsg==
X-Gm-Gg: AR+sD13jWOzOtD7A58a+nN2FerWdrmAVoJ3Axuv5PxXa3HrB7W7o/ZKx8/H/GD920/f
	KiUthX5U1ldKNsR1/3tT/9j8j2obBQPoxdwGhwvKcIU3wu5CUml7I12XfZKcrygqkjSKaMDbA4q
	6JhVtkrnCRanqqsEix6bsRmYWnFYVbDnry6I7NkDjvoHq+GZ5UgrgMb8xFFtGOx01KmIBRmbEah
	D3ShXzwaepxc5Aj6M97uHjSHP8EhPF56fT+Z1thnp37Jkult4hb9MK+mhWSoeSfDBEETL/W1X02
	aWpn1hfM2+uUKBiIf65xnuY5bM+nQmX+dC6kjIvKCS3S7mEqh8Zi7vf3gHDWcc99Tn7ruP6c0WO
	6ngCjuGIbFjIVlXwM7s56GOHcFLk/qVb3GlzUkuPCxSzX9dSFawogM24xSP34hNEZSNwJrDxZC+
	695T9XxnUzax+OiUEHdBagm0Q5hoLTZkiz52brqm16wGFb9Cw4H++pCutHvsgzuPL8zppk3IzNZ
	4A/HW9vQNKvVYUd/2tU
X-Received: by 2002:a05:6000:1a8d:b0:481:5ba5:9927 with SMTP id ffacd0b85a97d-4815ba5a034mr4000236f8f.9.1786616002724;
        Thu, 13 Aug 2026 03:13:22 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a56981csm5227397f8f.10.2026.08.13.03.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 03:13:22 -0700 (PDT)
Date: Thu, 13 Aug 2026 12:13:20 +0200
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
Subject: Re: [PATCH bpf-next v6 5/5] selftests/bpf: Add ksock test for async
 callback guard
Message-ID: <an2YwKV8qx1wXkcA@gmail.com>
References: <20260812154328.72834-6-mahe.tardy@gmail.com>
 <427cd292151a90f499819620700c9c582f1b63348d91d8727eee4200c268200e@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <427cd292151a90f499819620700c9c582f1b63348d91d8727eee4200c268200e@mail.kernel.org>

On Wed, Aug 12, 2026 at 05:25:40PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/testing/selftests/bpf/prog_tests/ksock_wq.c b/tools/testing/selftests/bpf/prog_tests/ksock_wq.c
> > new file mode 100644
> > index 0000000000000..5b9c6cc303922
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/ksock_wq.c
> > @@ -0,0 +1,34 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2026 Isovalent */
> > +
> > +#include <unistd.h>
> > +
> > +#include "test_progs.h"
> > +#include "ksock_wq.skel.h"
> > +
> > +void test_ksock_wq(void)
> > +{
> > +	LIBBPF_OPTS(bpf_test_run_opts, opts);
> > +	struct ksock_wq *skel;
> > +	int err;
> > +
> > +	skel = ksock_wq__open_and_load();
> > +	if (!ASSERT_OK_PTR(skel, "ksock_wq open and load"))
> > +		return;
> > +
> > +	err = bpf_prog_test_run_opts(
> > +		bpf_program__fd(skel->progs.ksock_wq_start), &opts);
> > +	if (!ASSERT_OK(err, "run ksock_wq_start"))
> > +		goto out;
> > +	if (!ASSERT_OK(opts.retval, "ksock_wq_start retval"))
> > +		goto out;
> > +
> > +	while (!__atomic_load_n(&skel->bss->callback_done, __ATOMIC_ACQUIRE))
> > +		usleep(1000);
> 
> What happens if the workqueue callback never runs or blocks? This loop is
> unbounded, so the test would hang forever rather than failing. test_progs
> has no per-test timeout, so a hang here would block the entire test run.
> 
> Adding an iteration cap (e.g. a bounded retry count followed by an ASSERT
> on callback_done) would turn a CI hang into a normal test failure. For
> comparison, prog_tests/wq.c uses a bounded usleep(50) before asserting.

Unsure how likely it is but it could be indeed improved in this way.

> 
> > +
> > +	ASSERT_EQ(skel->bss->create_err, -EOPNOTSUPP,
> > +		  "workqueue create rejected");
> > +
> > +out:
> > +	ksock_wq__destroy(skel);
> > +}
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31618864886

