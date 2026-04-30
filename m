Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330283B95FF
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 14:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777558161; cv=none; b=BRV+oLmGZL/oscYaxCfniOQKNpD/6zzUdGda7i1igmMJCInJ7FZ5Hsulc8XSIYQl50l69OULUXbd4n2vkg2PAn+Cr0MVPm+T0V5cnRtf8oC1xa5FAVzoYxt3zoz0hbfjKDNuXiyvq/DwRzvcWJPjYwVXGK5jRmWuZcdflDY1ej4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777558161; c=relaxed/simple;
	bh=1qjZmmrF3I85CBh0a1JI7hHwk45mME8Vo8LYhHDlh9E=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=LKNSxI9osr43Lscqcv7YvjMNR6+1SNsQH60v6rop5O3g03Ai+C6+Mu3p47r+pNMqpVZc5/FWZM030/PokuRNC1eB1DjAYn2SHTWz1dcCs6CdaJru2xNcfY1mL46a0Xt7a/CuRABzu6VrzlpfDM7pIBpO+6tDCUqoSm51/EmXcEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UXyVrVnn; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UXyVrVnn"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48a7fe4f40bso10047685e9.0
        for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 07:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777558159; x=1778162959; darn=vger.kernel.org;
        h=in-reply-to:references:to:cc:subject:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9EL5be0hYDO4pBoXs2Ff2eHS7rc0zYolDGqpnGuRlY=;
        b=UXyVrVnncE8QNLzp9VL/vLZwsewI6gKBwFRNrow35ZaxLdtajYxZ1f8CYLX6ut+YDR
         2YuzJBOofJfhSM9AbhJp6ovkdFnN7dA51YS5Ig/3cLC2Pi3j3PJq6VTsTSfXD+ZDkK/R
         vD8d1eO/zeHvUh7wLjYfgJl1uP/XU1+Qe/06vI3lPgH0q4UNk7R5925V32wHz8ea/tkq
         6gRY/4e4uL6MnUph2VzXS3+j/ACQe8AMPSCuNTKEElyr1gizBAh5Vb2DgKLw/FjCzn2c
         QV0syrnlFJI2dFx1onRKapzQ+UVL6mz2ksh5Fut3bsplzBo9674Jqp4A0rrbSLUtaUrS
         rHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777558159; x=1778162959;
        h=in-reply-to:references:to:cc:subject:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z9EL5be0hYDO4pBoXs2Ff2eHS7rc0zYolDGqpnGuRlY=;
        b=GlhhE1XtByspi0p/naha7HX9/UzPElRdOMguzUuq4cZGa2/1ZskhlNgtN/0JUDg3Nu
         hIv9uhGxvnbzwXyL+tas/EKIyhf8hgwP4feNuITD4FNnB3PHGrj/MLRfjAzEBWfHHa3F
         f5kX2YIr+SKEj240fveO4ZTktqkvAYrwYm7sAtwX1Pv1E19NpIyFTlx4Jm3ITGWOmvs0
         FWXbSmw3YFYyptqxmWSyamrkteiAPcdGSZGO2S0cnHjlR8qhJlB26fByYwGBhtECB9Xp
         1fQtBpgAo5KWoIZyFF4CJRdUG/ljdX8NEazBMT5jCf1QuOV0EUYdNtsZks/bNxKnPHZn
         uRfw==
X-Gm-Message-State: AOJu0Yz5m82XFjLVmHl/Bk1Rw7f9lKPoSN+8EBshayrQbSxVUs2y8moW
	laSIB1tL3vcsb2jMmvWKXe0krJTOcJ5kuFUB5mLAEEZAaP70cLzO4T0JuIJljXKzNOE=
X-Gm-Gg: AeBDieuW2qm+1PFzV6hAuTHC0SIXh151DHDZIwj1c1aOA7Ezs2gcYBsJqmzEAE7d1/l
	I4P3aK+hk29FWxdVbwi4SwILaIlqb21RnvtUrUmzOXdUvGE/QzC6N8xBzZjuhy5lKkKHprqKpUP
	SPEK0tRV79konk0gi9eKSB5TksVocrfT5yatF0Nhcj/PSiJahwR/uoMECG3evObz1V1wJHSMwnT
	zUys0SBVyqInq4an7297fFMXEpWFfDMh+AJvvNuSdZjdbnPQ/D8q0bGUfpTyKgHLfOAqopx15Fk
	wkO4Pa+/sGv2f5jHeG9Uvw5CNGyqGVIhKiIIqQt48ibw7MZ0kIwaIMfbFAFEtKq0xbPUQkp2Pxg
	CoV5fe/rvokodveHwIiCXGcl2wl5OLSMO3CZAX+2t23s+HYae4SiEs6Du+hY4muQ0CELwirFqyq
	sbcK6MOIHznJJ9YHxlJt9zsGE=
X-Received: by 2002:a05:600c:8b22:b0:485:3a03:ceca with SMTP id 5b1f17b1804b1-48a844582c3mr54963025e9.23.1777558158451;
        Thu, 30 Apr 2026 07:09:18 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:105d:2ecf:67ff:fe81:9da0])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12de31ab65fsm7755291c88.0.2026.04.30.07.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 07:09:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Apr 2026 11:09:14 -0300
Message-Id: <DI6JRYWASEYN.3I8Q81ZPUE1VE@suse.com>
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Subject: Re: [PATCH bpf-next v10 02/11] selftests/bpf: Fix test_kmods KDIR
 to honor O= and distro kernels
Cc: <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
 <alan.maguire@oracle.com>, <martin.lau@kernel.org>, <clm@meta.com>,
 <ihor.solodrai@linux.dev>
To: <bot+bpf-ci@kernel.org>, <rbm@suse.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>,
 <eddyz87@gmail.com>, <memxor@gmail.com>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <shuah@kernel.org>,
 <nathan@kernel.org>, <nick.desaulniers+lkml@gmail.com>, <morbo@google.com>,
 <justinstitt@google.com>
X-Mailer: aerc 0.21.0-120-g22b95d38161f
References: <20260430-selftests-bpf_misconfig-v10-2-cd302a31af16@suse.com>
 <d1297f1c857e5430af42dcb3e4d05c7ddaff08470a43893cac0fbcb83ec51666@mail.kernel.org>
In-Reply-To: <d1297f1c857e5430af42dcb3e4d05c7ddaff08470a43893cac0fbcb83ec51666@mail.kernel.org>

On Thu Apr 30, 2026 at 10:30 AM -03, bot+bpf-ci wrote:
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selfte=
sts/bpf/Makefile
>> index 6094fe99b5f6..cc6ee7a2df93 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>
> [ ... ]
>
>> diff --git a/tools/testing/selftests/bpf/test_kmods/Makefile b/tools/tes=
ting/selftests/bpf/test_kmods/Makefile
>> index 63c4d3f6a12f..031c7454ce65 100644
>> --- a/tools/testing/selftests/bpf/test_kmods/Makefile
>> +++ b/tools/testing/selftests/bpf/test_kmods/Makefile
>> @@ -1,5 +1,16 @@
>>  TEST_KMOD_DIR :=3D $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIS=
T)))))
>> -KDIR ?=3D $(abspath $(TEST_KMOD_DIR)/../../../../..)
>> +SRCTREE_KDIR :=3D $(abspath $(TEST_KMOD_DIR)/../../../../..)
>> +# Honor O=3D/KBUILD_OUTPUT only if they point at a prepared kernel buil=
d
>> +# directory (one containing Module.symvers); otherwise treat the value =
as a
>> +# selftests-only output directory and fall back to in-tree or distro he=
aders.
>> +# The parent bpf/Makefile resolves O=3D/KBUILD_OUTPUT to absolute paths=
 before
>> +# invoking this sub-make so relative paths still anchor to the user's
>> +# invocation directory.
>> +KMOD_O :=3D $(or $(O),$(KBUILD_OUTPUT))
>> +KMOD_O_VALID :=3D $(if $(KMOD_O),$(if $(wildcard $(KMOD_O)/Module.symve=
rs),$(KMOD_O)))
>> +KDIR ?=3D $(if $(KMOD_O_VALID),$(SRCTREE_KDIR), \
>> +	    $(if $(wildcard $(SRCTREE_KDIR)/Module.symvers),$(SRCTREE_KDIR), \
>> +		/lib/modules/$(shell uname -r)/build))
>
> Will falling back to the host kernel headers cause compilation errors
> when building in-tree test modules like bpf_testmod?
>
> Since bpf_testmod relies heavily on internal BPF structures,
> experimental macros, and kfuncs that change frequently between kernel
> releases, compiling it against /lib/modules/$(uname -r)/build on a
> system where the running kernel does not exactly match the upstream
> source tree will likely fail.

This is only the fallback case (inspired by livepatch collection which uses
this KDIR as default), the targeted invocation for this series is
something like:

  make -C /lib/modules/$(uname -r)/source/tools/testing/selftests \
       O=3D/lib/modules/$(uname -r)/build SKIP_TARGETS=3D TARGETS=3Dbpf \
       BPF_STRICT_BUILD=3D0

The usual in-tree way of building vmlinux and then the selftests strictly
would keep the same current behavior.

>
> If the host headers are present, the permissive skip check further down
> in the file will pass since the directory exists. Because the
> compilation failure is not ignored by the parent bpf/Makefile, won't
> this abort the entire BPF selftests build with confusing C compilation
> errors instead of silently skipping the unconfigured kernel tree?
>
> Should in-tree test modules avoid falling back to host distro headers to
> prevent these version mismatches?

Without the fallback, a user running from a tree matched to their installed
kernel but without a prior in-tree build would lose bpf_testmod. Small
niche, but the workaround (O=3D/lib/modules/$(uname -r)/build) might not be
obvious. The fallback covers them at zero cost to everyone else, so I think
it should stay.

>
> This was raised by Sashiko AI reviewer in v9:
>
>     https://lore.kernel.org/bpf/20260429194107.806B7C19425@smtp.kernel.or=
g/
>
> The issue was acknowledged in v9 but has not been addressed in v10.
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/251670=
06036
