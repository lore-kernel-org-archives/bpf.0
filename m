Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30393BED66
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 09:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781170648; cv=none; b=HiYGbztMZPZoYJUvymMblUlryo4ucc/Hsor1ZPc2Pxntl08B3washwbiq/tv+tpYTPWyxyJCt43ICcKcKIxpBtFDiByJooDyMRYHm5ja6KAleBTgKxvqoUkkjyGPsgJ1y9EHifII1805qXGLUMHIW5xYE5WUlVBuujtstXRhsXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781170648; c=relaxed/simple;
	bh=AvLJ837o6aFpuSBrNftC0C9tXvgnUSWePVBKcwDdPDM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMEPr8/hR1WApr0/1OCTDPzrjxYR/d0h2QZP7itah86KqD+okCD5OVF6ZxEI/ZRTWPBgoCfR8CGekwK/1FF0ACXqqh0ChzRhND7y/vifekeR+fqPWp0PGkZmD4QbCkoU6G2DpjSHFbQrxbx47Qaa+9dOfoG2HqNC7yehDvbPamc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJWHEC9A; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJWHEC9A"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490af320e2aso86034595e9.2
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 02:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781170645; x=1781775445; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Oi59QYzjJTpaQKbI3rmZuInCWoY2kOoYQVRZZMK0fYI=;
        b=iJWHEC9AnXUt339wfJWZ76qHg8FA3/BG/RnPcs24xrpezcFgzv9PdQV9XsyOJzcqbG
         0x3AMKnNZ84NZw8R915+uwDQwCRteZtTzxv5/OuRBrOpqdEgu2CSTF5i8Mql9InxN6D3
         GpH6oL1702F5QGiHRSFcmctxxAp7CTUX22ZveuBBY7v5cFfFwSyai1nLjP3S/o/eeeA2
         DFx4o4Gai7jpRA8upDhzHMBi429eud9nyZUuGVe/OeKB48Cwvds6FadKMw4gnPlrfQ0T
         gGvSWs9AJtNL7iVI6IOQggo+b3HOg28n99BA2sWJDHUfMHXIgRleSCCuLXTBvi8jI+8e
         iFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781170645; x=1781775445;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oi59QYzjJTpaQKbI3rmZuInCWoY2kOoYQVRZZMK0fYI=;
        b=L/NlabNUPkwaXfFt/MKMZ61NnTTiJNZCyUCD4Ef3TRb1/HShHzdaRGlDsH9Nmj+wfG
         R7lukpLalkylA6/85ZGWjBD1rFBbFUDCDDnOSG16MG7GJ6hlhECjW1heh1RXDgZg3DcX
         n8S4+pNKiNMPupLuGgASI1uBxZetjVzXm198l/PjMt3iMdCxObRaTIPELYI2jDMsu1bx
         wzBVjPRqbQ3AtP9CwGdl+kz7kdtUed2AdUG1Kj1ZrS7TnRRWZ0bBqGIZC/2lB+A1JnuU
         c79jpmmUtdIj3KXdK9TrniORCuYpK8/xtP7NnIHTUkqafM0XEl15xL3xtkolJ96yynbZ
         DZHg==
X-Gm-Message-State: AOJu0Yzn9L/zqMkXog+RWiBpp6vfLN/ncREf+pGKtkJd719idkHj6ELz
	XjNAGU2MqAeK8VZFnPAR0FnHdgCJb2r5kACbR9cXm/izbanKuTkZk3mMDycEvQ==
X-Gm-Gg: Acq92OGUd7muqBhkMehfLLNMhDlBBPMH2JU7Si7uDqUC5m1b0eKTi2yRKOUcNK1GqIV
	4LCiIeYO0AkAxXHH++efyk6hj5c/pDrq6+yX4HFVzvRSNB0P8Po8hghopZqsy+vSXq07OP58vwc
	wo4zMQPu8t/MTZe920oCZyXMGR+wWFS1fJw5bob2/WvVj3OhYm4sw1d5erAm6Z/cS1ru6BbqYyZ
	DxH4rIw/8hleRabTDVQ++4I0dtsJIQNHrOshn65WKKg4uy1YGMSzbHNFzOabRJ7WVD6ITSKKzoY
	AuJfU+cetB8AwKNKdfvUOVuNLOVToOEl+3vqr+l5009J11LWQYp4wfM3KDMZKPjvwUXPixzfJEV
	H2ZyabfHiyUQCUW/Pkr8v11zUqhC39eijZNfLbKKIxY+NTE7taxMRYgB3Y1HArDs3dooZRdhPu8
	2+mCDCK5D2mw+thg9x1OezgRVdkiRt1hU0ajkh
X-Received: by 2002:a05:600c:c0c6:b0:490:958f:2a5e with SMTP id 5b1f17b1804b1-490e55fbd74mr23400285e9.13.1781170644815;
        Thu, 11 Jun 2026 02:37:24 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e532c778sm35669155e9.14.2026.06.11.02.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 02:37:24 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 11 Jun 2026 11:37:22 +0200
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCHv2 bpf-next 5/6] selftests/bpf: Add uprobe_multi path_fd
 fail tests
Message-ID: <aiqB0mSXsFTryaYz@krava>
References: <20260610143627.804790-6-jolsa@kernel.org>
 <20260610144822.32E831F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260610144822.32E831F00893@smtp.kernel.org>

On Wed, Jun 10, 2026 at 02:48:21PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The patch references an undefined struct member `path_fd` and an undeclared macro `BPF_F_UPROBE_MULTI_PATH_FD`, which will cause compilation to fail.
> --
> 
> commit 0e3f7d4f9ed46a64d02a1c29acb4f8e2215cb7c0
> Author: Jiri Olsa <jolsa@kernel.org>
> 
> selftests/bpf: Add uprobe_multi path_fd fail tests
> 
> This commit adds tests to the attach_api_fails suite to verify that
> invalid setups using the new path_fd feature in uprobe_multi fail as
> expected.
> 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > @@ -536,7 +536,37 @@ static void test_attach_api_fails(void)
> 
> [ ... ]
> 
> > -	ASSERT_EQ(link_fd, -EINVAL, "pid_is_wrong");
> > +	if (!ASSERT_EQ(link_fd, -EINVAL, "pid_is_wrong"))
> > +		goto cleanup;
> > +
> > +	/* wrong path_fd */
> > +	LIBBPF_OPTS_RESET(opts,
> > +		.uprobe_multi.path = NULL,
> > +		.uprobe_multi.path_fd = -1,
> > +		.uprobe_multi.flags = BPF_F_UPROBE_MULTI_PATH_FD,
> 
> [Severity: Low]
> Does this commit depend on a missing prerequisite patch? 
> 
> The path_fd member and BPF_F_UPROBE_MULTI_PATH_FD macro do not appear to be
> defined in the current tree's bpf_link_create_opts struct or UAPI headers,
> which will cause a compilation failure here.

it compiles fine, it was added in this commit:
  bpf: Add support to specify uprobe_multi target via file descriptor

jirka

> 
> > +		.uprobe_multi.offsets = (unsigned long *)&offset,
> > +		.uprobe_multi.cnt = 1,
> > +	);
> > +
> > +	link_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &opts);
> > +	if (!ASSERT_ERR(link_fd, "link_fd"))
> > +		goto cleanup;
> > +	if (!ASSERT_EQ(link_fd, -EBADF, "path_fd_is_wrong"))
> > +		goto cleanup;
> > +
> > +	/* path and path_fd both set with BPF_F_UPROBE_MULTI_PATH_FD flag */
> > +	LIBBPF_OPTS_RESET(opts,
> > +		.uprobe_multi.path = path,
> > +		.uprobe_multi.path_fd = 1,
> > +		.uprobe_multi.flags = BPF_F_UPROBE_MULTI_PATH_FD,
> > +		.uprobe_multi.offsets = (unsigned long *)&offset,
> > +		.uprobe_multi.cnt = 1,
> > +	);
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260610143627.804790-6-jolsa@kernel.org?part=1
