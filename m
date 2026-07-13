Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4382D24B7
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783956789; cv=none; b=qPg+7gLRnLutG08MUtWtOOnPJZLRHDHkf9ilTSZv8pXdQrmrOGwpPOhuHfgfmzup8LPZ9tcHOGK0SZv7ypkLhP/Yyw4d+ghFiIF0F4fP7HFa6bxae1Ze4cdtXA+2qQgFfGeIbFKoA3cGFw6WImy2TCKnpWWe2E+g9IsLLzbh9SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783956789; c=relaxed/simple;
	bh=mM2m2Iv09FCmXKxsnnnY41Pvn6pTqfbZKQfmUKONGPc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=pSLK2dR83OLjZhmECC6Q9whqxGnalive5TWItNanIIjTIJM9I44fpxCesghPsbs4T8t2hVpxMwrGk8DCSvPqVSlO93+oZZjYiXUFXJlAINYumURjl51HiHQjfYcoGwVCWeu0mNiQZpaMl3q/K8typdtTeTh8UT5sWcGfrqUjbC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0n2JaYlb; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0n2JaYlb"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 6E24C1A0FA0;
	Mon, 13 Jul 2026 15:33:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3944860345;
	Mon, 13 Jul 2026 15:33:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0E71011BD21E7;
	Mon, 13 Jul 2026 17:32:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783956783; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=MA6mxJIo1x+dTMvwPcn/qU2Jkn4kB67D529MAoNiIY8=;
	b=0n2JaYlbMk4CsI/36ows0HBYeEMraw7UfRAXjY3dHZDJn56Z8Ol+hPp2YpRA7t461YNjFY
	+h5mfHAMYio4orHWwO0D6uXbxa7R5JA+C852N/KcYZXwGs1xc26rdIToRvEq7ndxbXoqE6
	9bbYMk3NkW3XOalvTdWnGDaB1C0W2XmxLTzanRqGLgdyB8NuDRQLF1V53a62w9GojyhPDY
	5FFapEVx/+D5tl7Vi8t+QWvFOfiSFnW1VNXAb8xVzlmwAcWNSE0YrYL1jxd0uVbfkvITgy
	TTfxw0Eb7XYHmSwKKpdwuO+yRqnLf7i3kOKnZBJtXVFmcgC+2l7Q6cTTLILMOg==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Jul 2026 17:32:58 +0200
Message-Id: <DJXJWE3X286K.16LM4LUS201ZP@bootlin.com>
Subject: Re: [PATCH 1/4] selftests/bpf: Install bpftool where test_progs
 expects to find it
Cc: <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan" <shuah@kernel.org>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>, "Ihor Solodrai" <ihor.solodrai@linux.dev>,
 "Christian Brauner" <brauner@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260710-selftests-bpf_fixes-v1-0-aa24dfd6f4f9@suse.com>
 <20260710-selftests-bpf_fixes-v1-1-aa24dfd6f4f9@suse.com>
In-Reply-To: <20260710-selftests-bpf_fixes-v1-1-aa24dfd6f4f9@suse.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On Sat Jul 11, 2026 at 12:09 AM CEST, Ricardo B. Marli=C3=A8re wrote:
> bpftool_helpers.c looks for bpftool at "tools/sbin/bpftool" or
> "../tools/sbin/bpftool" relative to the running test_progs binary, matchi=
ng
> the build directory layout where bpftool sits at
> $(OUTPUT)/tools/sbin/bpftool.
>
> INSTALL_RULE installs bpftool through the generic TEST_GEN_PROGS_EXTENDED
> mechanism, which flattens it straight into $(INSTALL_PATH) and loses the
> tools/sbin/ prefix. After "make install", every flavor of test_progs,
> including the default one, fails to locate bpftool, and bpftool_maps_acce=
ss
> and bpftool_metadata error out with "Failed to detect bpftool path", even
> though bpftool itself built and installed fine.
>
> Explicitly install bpftool under tools/sbin/ in the installed tree
> so its relative location matches what detect_bpftool_path() already
> expects, restoring the pre-install layout instead of introducing a
> new one.
>
> Fixes: f21fae577446 ("selftests/bpf: Add a few helpers for bpftool testin=
g")
> Signed-off-by: Ricardo B. Marli=C3=A8re <rbm@suse.com>

I did not face the issue because I am running the selftests in-tree, and
the CI seems to do the same, but for users using selftests after running
`make install`, I guess the change makes sense.

That's not the first fix aiming to improve bpftool
detection/installation (eg the BPFTOOL env variable, see [1]), so it
makes me wonder if we shouldn't just make bpftool part of
TRUNNER_EXTRA_FILES for all flavours of test_progs, similarly to other
binaries needed during tests (eg: urandom_read), instead of just adding
some bpftool-specific details in this generic install rule, and just
make the test runners assume that the needed binary is in the same
directory.

Alexis

[1] https://lore.kernel.org/all/20260223191118.655185-2-ihor.solodrai@linux=
.dev/

> ---
>  tools/testing/selftests/bpf/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index b642ee489ea6..47911c9b4977 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -1055,6 +1055,8 @@ endif
>  DEFAULT_INSTALL_RULE :=3D $(INSTALL_RULE)
>  override define INSTALL_RULE
>  	$(DEFAULT_INSTALL_RULE)
> +	@mkdir -p $(INSTALL_PATH)/tools/sbin
> +	@rsync -a $(if $(PERMISSIVE),--ignore-missing-args) $(TRUNNER_BPFTOOL) =
$(INSTALL_PATH)/tools/sbin/
>  	@for DIR in $(TEST_INST_SUBDIRS); do				  \
>  		mkdir -p $(INSTALL_PATH)/$$DIR;				  \
>  		rsync -a $(if $(PERMISSIVE),--ignore-missing-args)	  \




--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

