Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238DC3537D0
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 20:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775679220; cv=none; b=I5NG25qGSZGh9zd4uubS9JP6JnWIXqluv0SJsEhYZ/etpn7M0Xrhb9CK0kRDqepzjdguIXttSLJK6nxdmWt0xSJOsyQDS2MjI7JWAVgy2mW58M0hVE/8Xml4iQJrmBxsf91ow5XNtsg2sunjRxLotJ9HSDoIlgKqYfcAXioOfAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775679220; c=relaxed/simple;
	bh=GvgmhP0zXh+kqAev56iRmVwSt6NW9FF19MvHlqntkxA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhbbGZ6YonS8/MUuaQd6M1FTRV9jw8syuOsdJcpLtEGO+vUueSAESv3mNR+8CM0ATuMVHqHbHTNcKJS/CM2hmzQe2jUBHTg5Tka6KuLVxWBXaceQJZLW1itZuHKENg+52AQpMny1ZmwENTadmaJDhz/rt9lg5QisGJyV9RMiMbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=omVtNE1O; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="omVtNE1O"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d02a71526so64908f8f.3
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 13:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775679216; x=1776284016; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rcC0ByEFy9h43wSPxh/dSOWCQS4PMAnAG7iuN00tuA4=;
        b=omVtNE1OO2baBnW01+1vSgjyDYJfcH4u1wGW3Y6pOR/Y0bpJ2Kp7cWvkRxrpShl5c0
         ESWv72si1ObMVud4hj5KSZRX8XA+jJkFAiMTivmkTd+GIW1nRyCkxQPHDmObnh7I+6L0
         WR2q2xIFO1BzVYMiuoswhB0idd/b7Fv4+7PXZp7wd3MTk2mBJzkfIE/VNzNQDluDBYJP
         2D7aSsgAnbp9GnoMrXUQMFimETDx3rd1XpAh+KevE2MpFgEr1UTqwYM6YlJtUpH23wJ3
         LDOFDDMF0fvpB9E/NpPK/nEmUtxGh1d5RaqxKhClTpFMaeEX2Ay3JF8oSTp0BMeilJk7
         ghQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775679216; x=1776284016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rcC0ByEFy9h43wSPxh/dSOWCQS4PMAnAG7iuN00tuA4=;
        b=lALDI4eNrfjNO6ApdRPs6XbQlr6Q8ZuO2OVdFssD/omYniGd8ZDRfP6q58v/p2fcY7
         9wNRkWpgLGvOC4IQoMss4UyeU3FDfC6XLKB8Ub8D5uq+x6pbDitulNbp4m4BAzjlmJnC
         u56CdYz/UfgXLt4U4qjniul9d5fq4LQHkXACN/EUhgDuTI2b41PxZII70dbz8rn6WUah
         x/rHKz07HtzY1Iqc2JRWHKChIYxM3VSrX59gEzpl0wBtJSjAgxLMVAvGReSn/7Rpu/w1
         cqwL5Z3MPm3fM8JMXCKsG17TtcY+UZck5g1Qx/b/Zb8t2AWb3uARkyj/2n1izDaTt1m2
         sy1w==
X-Gm-Message-State: AOJu0YycZlvlGJ/SZ287t8w47BFDLkQMAK7nn6HA5HH1ApNWuJ+TFV5R
	rtmKGfwVnDyNlfx7A5fop40dMdoY9coeBljLdFXD7JaInPpytRw5qFqz
X-Gm-Gg: AeBDievcNNc/3tSFlyX183OB9xm8YbggMtnlYoyW0zxpGMqI1s+nEGw1Vx7bJo+32s1
	mn/NqkzuSR9v3WSWLWc7dy5SxY2vwbOo7KuqTxBL6Plk1Ow6OJ6yY5+OVWm3izkWMeQb/NjtzZE
	6pSDl5jt880wuD153tz/RIuNJ9bDPGKSFuXDRNKmpqwkYu8asHcsLhvRbG+i3fwApiTsjCZjK3D
	WM+PiSd62exKVMMfSqEaX0dNHJoD5e2YrhFCV8oRxWzWwR1WcAByvd90R3Y1KDH9xmhGfp5zVx8
	bPYfNybdfLIix4StKvSAA4Gt6hbkD+9f7mFGYDC16zXRGJ28Jt0HAcLmoe/Oa0MDYR+7LJeAWd/
	5QKL36Dwm8z2GI7JDdAYEp1zQpMrTV0V9ozG38pbpnRSae7WuYuPLP1Oh1wSycGE5aBs/uB26D9
	41MqJ6Rsy7oO4JcbZs1bk8Yg==
X-Received: by 2002:a05:6000:288a:b0:439:c1ca:82be with SMTP id ffacd0b85a97d-43d5a18bdbbmr836151f8f.28.1775679216325;
        Wed, 08 Apr 2026 13:13:36 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c5253sm54698406f8f.9.2026.04.08.13.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 13:13:35 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 8 Apr 2026 22:13:33 +0200
To: Varun R Mallya <varunrmallya@gmail.com>
Cc: bpf@vger.kernel.org, leon.hwang@linux.dev, memxor@gmail.com,
	ast@kernel.org, daniel@iogearbox.net, yonghong.song@linux.dev,
	rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Add test to ensure
 kprobe_multi is not sleepable
Message-ID: <ada27R-ai8FvnPu0@krava>
References: <20260408183549.92990-1-varunrmallya@gmail.com>
 <20260408183549.92990-3-varunrmallya@gmail.com>
 <adai2mXaRGpf1Kvb@computer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adai2mXaRGpf1Kvb@computer>

On Thu, Apr 09, 2026 at 12:17:54AM +0530, Varun R Mallya wrote:
> On Thu, Apr 09, 2026 at 12:05:49AM +0530, Varun R Mallya wrote:
> > @@ -676,5 +750,7 @@ void test_kprobe_multi_test(void)
> >  		test_unique_match();
> >  	if (test__start_subtest("attach_write_ctx"))
> >  		test_attach_write_ctx();
> > +	if (test__start_subtest("attach_multi_sleepable"))
> > +		test_attach_multi_sleepable();
> >  	RUN_TESTS(kprobe_multi_verifier);
> Please ignore this patch. I will send a v5 in a few minutes. I forgot to
> remove the selftest from the previous location after moving it into
> attach_api_fails.

also no need to send patch#1 it's already in:
  eb7024bfcc5f bpf: Reject sleepable kprobe_multi programs at attach time

jirka


> > +}
> > +
> > +char _license[] SEC("license") = "GPL";
> > -- 
> > 2.53.0
> > 
