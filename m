Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70489396579
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 09:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779875904; cv=none; b=U9eah1EUmMwCgc26QF6ShmTPNxJ9XpL0v87yo3cd9Ze9m2EaYtvGpACAUQgRjchBFuimMMzqW43Cgfrvuo7tJMo6+aI+DRIlDRTNFD402Q9ZeaTin3yGfrj2VT0IZscvNJ1qs9sBLLHcex0If9MCOGuerChXUDHHbqTMTnUswJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779875904; c=relaxed/simple;
	bh=RZBmb/HkDW7Oy/X6gZO+I2XelRRa/7kXnKWxiTpxHv8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jti4i4KPkrZ6S5UhESqKV+QVxTSPUeq9gyC+Mxe7YuFLDe85VXXxAHbln7uV1xBY6E+RPbGmXEdDkEg/mqfq3bMgVnFFouOsu4Mj8VROZ7bTq7X+6+3R0cRmjlTQ3vWM3SUWhcwzRkgUSTbfDJkknmzlBlOQgKh98Affmt7j+LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVzl9FrU; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVzl9FrU"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43eb05b1875so6103660f8f.3
        for <bpf@vger.kernel.org>; Wed, 27 May 2026 02:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779875902; x=1780480702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B1tyU2uydFHOb+Dk+vd6ZsdbLeHHkFq8Fgb/EaBviEA=;
        b=IVzl9FrUFZZK58/iCMmyKTQjjVgaDprUsZ9lqqDTQbY68mgON1PcAgbUR6/D1UtQtc
         13pqkWT4zTIC7lwTT0QHol5T3+EE2fEjuCZlj/OK+94RsK3AQaX0RCH0chGZWDbXOGRb
         sju+ztpkhxKBqaP8eOug9k943UIF/9AAu6VZnKHVufJiuOjLsyvYTGZl3ILvuFBTXlrI
         /xOt1pef0ThMi0RW4qtFOSgIIrJtCfbTfjRzp+cuFZeCuEpeZYpUiNAvtkSE8eZHFo/X
         xgpSgdHdd61LzfKwXzPoErdUjugzYNqD6dcTSqwq45mF+SWGUGSUFpZCtl+L7qjep88k
         eQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779875902; x=1780480702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B1tyU2uydFHOb+Dk+vd6ZsdbLeHHkFq8Fgb/EaBviEA=;
        b=ZCCSDnoJ2ec3TTD7/5xSU2NZaf1m0kK+yr2JMydv6nHqB3wiDWls5yf9poP/dG6R2p
         hxk1886v8lJHm5qaA+afJbxSzR6RRXQJIIS/GvzqqL1MbiYoIvZM1HMD2zsZG1C1bnt6
         0PICw8WpCaHu9zV0hOrhNDW7z0O5ozAQRRFjCikw9GCaVo3F4iSvNWI6thDbAHWbs8Xv
         lMQsJIGVF3jiVa28OU1IT3cAygQSaOov5AbVIiLUfep6tHG2PWC5NYL4P+1zqvaiuypF
         gElEHw+uawJrkeZ12qIqCmaVgHz4dbBiMQA93pQXGBqOh+OfDbTuAIyDPDE0LdrYhXEE
         FVPA==
X-Forwarded-Encrypted: i=1; AFNElJ9/dAckEdsZGs/jsTv+d4PGcpCwggdwild2OA40nyDG2wO3FxkGl1JmbVsYXH+xVGF1VME=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw1yPUNimal7peKaj95ioS7CSfbqmzP5T8bE01VRnahG0aCRPw
	gFpwnOrxwjlHtHy/hCLAypIdwwvw2RvAb3X+Z/1Upjrs9bwWYYwYayla
X-Gm-Gg: Acq92OGHblX2GJdVPcAD4l2dVZ9yeZiTzBQlUHpTuN+5+zfTAXZd9ZYdcaWHpDJZQ53
	4M7U8OZ2KYtpIhsJBw9iVLiarsCE9YWBwmkSvcIUz3UAfpyJaT8mwXeJm5Qv9UPF5wlTo6GLt6j
	HVhXfxJg3plwk3ZCNxkZNJrHHsnz+kCG9q7RIjPQbU891aehRJ2iGAU6ow/KYHvQ1yF7Ec0T/x0
	RXIX/KMgyg3/0HJfjS3D5FL2k3i0yPKR/U/g2vjg52DM0ZWFD3XfNNmanKEvn636biDFkpvCUyZ
	vf1B2Uo4w5LUXmxnL5O4XeMmtpwbilwqs87fxgCrX1PqITXTjJESXI5LfMN9vE3OGdtIG74VkWW
	AbHqleZBvuRemLxbtc1uNAzyWO3Cxegnfoym/Atgd0JLeNlN68mf4oY4Zl+Tx4xf1gVobD4k3xd
	7NLcw6JlevBIAb/ZQ=
X-Received: by 2002:a05:6000:2408:b0:45e:941e:77b3 with SMTP id ffacd0b85a97d-45eb38c9299mr39465897f8f.41.1779875901635;
        Wed, 27 May 2026 02:58:21 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5b28absm4908881f8f.27.2026.05.27.02.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 02:58:21 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 27 May 2026 11:58:19 +0200
To: bot+bpf-ci@kernel.org
Cc: oleg@redhat.com, peterz@infradead.org, mingo@kernel.org,
	mhiramat@kernel.org, andrii@kernel.org, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv4 09/13] selftests/bpf: Change uprobe syscall tests to
 use nop10
Message-ID: <ahbAOwmPl2KJDPbb@krava>
References: <20260526205840.173790-10-jolsa@kernel.org>
 <3bec8cfe67b2e52b7316d77f6907373a99ee0443a27c15ad26b90d6c5539ecdf@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bec8cfe67b2e52b7316d77f6907373a99ee0443a27c15ad26b90d6c5539ecdf@mail.kernel.org>

On Tue, May 26, 2026 at 09:46:38PM +0000, bot+bpf-ci@kernel.org wrote:

SNIP

> > diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
> > index 69759b27794d..fda3a298ccfc 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
> > @@ -252,7 +252,7 @@ extern void usdt_1(void);
> >  extern void usdt_2(void);
> >
> >  static unsigned char nop1[1] = { 0x90 };
> > -static unsigned char nop1_nop5_combo[6] = { 0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00 };
> > +static unsigned char nop1_nop10_combo[11] = { 0x90, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 };
> >
> >  static void *find_instr(void *fn, unsigned char *instr, size_t cnt)
> >  {
> 
> Is the loop in find_instr() adequate to find the updated instruction
> sequence? In uprobe_syscall.c, find_nop10() was updated to search up
> to 128 bytes to account for compiler-generated prologues:
> 
> tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c:find_nop10() {
> 	for (i = 0; i < 128; i++) {
> 		if (!memcmp(nop10, fn + i, 10))
> 			return fn + i;
> 	}
> }
> 
> But find_instr() in usdt.c only searches the first 10 bytes:
> 
> tools/testing/selftests/bpf/prog_tests/usdt.c:find_instr() {
> 	for (i = 0; i < 10; i++) {
> 		if (!memcmp(instr, fn + i, cnt))
> 			return fn + i;
> 	}
> }
> 
> If a modern compiler generates a prologue longer than 9 bytes for
> usdt_2(), find_instr() will prematurely terminate and cause
> subtest_optimized_attach() to fail. This concern was raised by
> reviewers in v2 and v3 of the patch series:

find_instr is ok for its usage in subtest_optimized_attach,
we first use it to verify the combo was not generated in usdt_1,
and having 128 bytes search we'd find combo from usdt_2 function

modern compilers seems to be smart emough not to generate long
prologue for usdt_2 function

jirka
