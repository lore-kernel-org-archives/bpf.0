Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62698F7D
	for <bpf@vger.kernel.org>; Sat, 21 Feb 2026 04:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771647851; cv=none; b=j0h3IvNTbVAXuz7/ILmsYnOckuq5LE3Fftdy/XOZgfD6521KhPOvrHM/F3Q5o4sd/JwBuMi0AI1Qd5egm4TOIspBNVnqmdf67YYHV3FRG9y/uU6QOJffiPY2bP/ScVKpRlwbmAjnjQLnE9iRkAphIhlWyMvdjsgqQQjOB9n3HEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771647851; c=relaxed/simple;
	bh=fzvA1vKq5iHhLKdRX7ndb8XL4XgjSN71oyex33+p4s4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ie9vIxqMT88VNhtMGzIDOOH65jdDi4caYDv2gG/3tlflt/983yQtI7Rcg+S0lTCZ/B67d2lI/NhnD/ek9zBGriNMk/dk2O127iafjLIRB9eaNMQfwXG1YEB6BZH3RFUcFCiPl2gqxX0lI5G1vn/peZuOWkjhULHhyRupv6x5vKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xjeMLG+X; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xjeMLG+X"
Message-ID: <789af3df-291c-410d-89d8-ee7b12479798@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771647837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3hs34mvxs9fP5bbBSGBm4PKIXI/s1KQRlBnPFlSWzFc=;
	b=xjeMLG+X9kpeHwy0aM+wbQm8vQirf57ybEgE2Mn56ddVZByl1ey7ZYa7u9826baFwbJg/W
	bN8ncAbkNrmGjECkJRGcRFe+FeKaKN75yisRk206KfHrQXSMLG1XykLICXOXxBsaU3dSAc
	VQLWxUP9YY1SFcoRXpaSLbapyGCp8T0=
Date: Fri, 20 Feb 2026 20:23:51 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v3 01/15] selftests/bpf: Pass through build flags to
 bpftool and resolve_btfids
To: bot+bpf-ci@kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, olsajiri@gmail.com,
 yatsenko@meta.com, alexis.lothore@bootlin.com
Cc: ameryhung@gmail.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, martin.lau@kernel.org, yonghong.song@linux.dev,
 clm@meta.com
References: <20260220222604.1155148-2-ihor.solodrai@linux.dev>
 <edac02ca77865be9cc18b013f5209a8fb0d8a4c443ce16dce8ad368a9ecefe05@mail.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <edac02ca77865be9cc18b013f5209a8fb0d8a4c443ce16dce8ad368a9ecefe05@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2/20/26 2:57 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
>> index 1733a6e93a07..ef083602b73a 100644
>> --- a/tools/bpf/resolve_btfids/Makefile
>> +++ b/tools/bpf/resolve_btfids/Makefile
>> @@ -65,6 +65,9 @@ $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OU
>>  LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
>>  LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
>>
>> +ZLIB_LIBS  := $(shell $(HOSTPKG_CONFIG) zlib --libs 2>/dev/null || echo -lz)
>> +ZSTD_LIBS  := $(shell $(HOSTPKG_CONFIG) libzstd --libs 2>/dev/null || echo -lzstd)
> 
> The "|| echo -lzstd" fallback makes zstd an unconditional link
> dependency. On systems where libzstd-dev is not installed, pkg-config
> fails and the fallback provides -lzstd, but the linker cannot find the
> library and the build fails.
> 
> bpftool handles the same transitive dependency conditionally via a
> feature test:
> 
> tools/bpf/bpftool/Makefile:
>     ifeq ($(feature-libelf-zstd),1)
>     LIBS += -lzstd
>     LIBS_BOOTSTRAP += -lzstd
>     endif
> 
> Would it be safer to drop the fallback here so ZSTD_LIBS is empty
> when zstd is not available?
> 
>     ZSTD_LIBS := $(shell $(HOSTPKG_CONFIG) libzstd --libs 2>/dev/null)
> 
> This would still link zstd when present (needed for the static linking
> case where libelf.a pulls in ZSTD symbols from elf_compress.o), but
> avoid breaking dynamic builds on systems without libzstd-dev.

I tried to reproduce the situation like follows:

  $ git remote -v
  origin	git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git (fetch)
  origin	git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git (push)

  $ git log --oneline -n1
  8bf22c33e7a1 (HEAD -> master, origin/master, origin/HEAD) Merge tag 'net-7.0-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net

  $ b4 shazam 20260220182011.802116-1-ihor.solodrai@linux.dev   # apply strscpy series
  $ b4 shazam 20260220222604.1155148-1-ihor.solodrai@linux.dev  # apply ASAN series

  $ podman pull debian:latest
  $ podman run -it --rm -v $(pwd):/linux debian:latest /bin/bash

  # in the container
  $ apt update -y && apt install -y make gcc python3 libelf-dev
  # note: no libzstd-dev

  $ cd /linux/tools/bpf/resolve_btfids/
  $ make -j8
  # build is successful

  $ ldd resolve_btfids
	linux-vdso.so.1 (0x00007f3eecc81000)
	libelf.so.1 => /lib/x86_64-linux-gnu/libelf.so.1 (0x00007f3eecbe2000)
	libz.so.1 => /lib/x86_64-linux-gnu/libz.so.1 (0x00007f3eecbc2000)
	libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f3eec9cd000)
	libzstd.so.1 => /lib/x86_64-linux-gnu/libzstd.so.1 (0x00007f3eec903000)
	/lib64/ld-linux-x86-64.so.2 (0x00007f3eecc83000)


So, while AI may be technically correct that the build will fail if
libelf is installed and libzstd is not, it seems a far-fetched
situation, given that libelf depends on libzstd.

I think we can leave the default -lzstd to have an explicit
dependency in the Makefile.


> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22243753316
> 
> AI-authorship-score: low
> AI-authorship-explanation: Human-characteristic typo in commit message, natural lore discussion with incremental debugging, and standard Makefile pattern reuse all indicate human authorship.
> issues-found: 1
> issue-severity-score: low
> issue-severity-explanation: Unconditional zstd link fallback in resolve_btfids Makefile can break builds on systems without libzstd-dev, but the affected scenario is narrow and limited to the selftests build system.

