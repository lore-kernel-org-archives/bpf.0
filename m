Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D24741C315;
	Mon,  2 Mar 2026 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772465304; cv=none; b=Pdli/3us2wAo3dpMq9MeOzlTuai9bR2CuxoOCoAcFnGbHThRIAVqXYnNMZCK1mqdr5K620J4aj3jFEUZ6N55kDn1dO9kBetpG3g0ntchvYswbCTG/aTLB3jC8PSus2HRQsch/ioCDDus3B4stNwxBmbRxuOHEIGB0S6icq6Hki0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772465304; c=relaxed/simple;
	bh=cnXkDmiK4nEkXfkpUw2O+7yQ+cbRQCkc1IuPQRsmliA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MlPy6Pw0dOHk91WzpDZ+aaxfKNjA0R9wIbwe4N0QrjKa5vYjCY6b0Ib9VM0Znm5ZuR3QgLLIWNrmpi6XLSQv77mKaUtQxtUPPtqzkK/5ZtBIfM/u+9zQE3CttIQaG53Px/6gqNS8FlNgOhhHgxCKlcmxBQfP5B/mKXwu1p0+ZbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id D85D772C8CC;
	Mon,  2 Mar 2026 18:22:12 +0300 (MSK)
Received: from pony.office.basealt.ru (unknown [193.43.10.9])
	by imap.altlinux.org (Postfix) with ESMTPSA id D141436D00D3;
	Mon,  2 Mar 2026 18:22:12 +0300 (MSK)
Received: by pony.office.basealt.ru (Postfix, from userid 500)
	id A1D68360D75C; Mon,  2 Mar 2026 18:22:12 +0300 (MSK)
Date: Mon, 2 Mar 2026 18:22:12 +0300
From: Vitaly Chikunov <vt@altlinux.org>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bot+bpf-ci@kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, olsajiri@gmail.com, yatsenko@meta.com, 
	alexis.lothore@bootlin.com, ameryhung@gmail.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, martin.lau@kernel.org, 
	yonghong.song@linux.dev, clm@meta.com
Subject: Re: [PATCH bpf v3 01/15] selftests/bpf: Pass through build flags to
 bpftool and resolve_btfids
Message-ID: <aaWqMcK-2AQw5dx8@altlinux.org>
References: <20260220222604.1155148-2-ihor.solodrai@linux.dev>
 <edac02ca77865be9cc18b013f5209a8fb0d8a4c443ce16dce8ad368a9ecefe05@mail.kernel.org>
 <789af3df-291c-410d-89d8-ee7b12479798@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <789af3df-291c-410d-89d8-ee7b12479798@linux.dev>

Ihor,

On Fri, Feb 20, 2026 at 08:23:51PM -0800, Ihor Solodrai wrote:
> 
> 
> On 2/20/26 2:57 PM, bot+bpf-ci@kernel.org wrote:
> >> diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
> >> index 1733a6e93a07..ef083602b73a 100644
> >> --- a/tools/bpf/resolve_btfids/Makefile
> >> +++ b/tools/bpf/resolve_btfids/Makefile
> >> @@ -65,6 +65,9 @@ $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OU
> >>  LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
> >>  LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
> >>
> >> +ZLIB_LIBS  := $(shell $(HOSTPKG_CONFIG) zlib --libs 2>/dev/null || echo -lz)
> >> +ZSTD_LIBS  := $(shell $(HOSTPKG_CONFIG) libzstd --libs 2>/dev/null || echo -lzstd)
> > 
> > The "|| echo -lzstd" fallback makes zstd an unconditional link
> > dependency. On systems where libzstd-dev is not installed, pkg-config
> > fails and the fallback provides -lzstd, but the linker cannot find the
> > library and the build fails.
> > 
> > bpftool handles the same transitive dependency conditionally via a
> > feature test:
> > 
> > tools/bpf/bpftool/Makefile:
> >     ifeq ($(feature-libelf-zstd),1)
> >     LIBS += -lzstd
> >     LIBS_BOOTSTRAP += -lzstd
> >     endif
> > 
> > Would it be safer to drop the fallback here so ZSTD_LIBS is empty
> > when zstd is not available?
> > 
> >     ZSTD_LIBS := $(shell $(HOSTPKG_CONFIG) libzstd --libs 2>/dev/null)
> > 
> > This would still link zstd when present (needed for the static linking
> > case where libelf.a pulls in ZSTD symbols from elf_compress.o), but
> > avoid breaking dynamic builds on systems without libzstd-dev.
> 
> I tried to reproduce the situation like follows:
> 
>   $ git remote -v
>   origin	git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git (fetch)
>   origin	git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git (push)
> 
>   $ git log --oneline -n1
>   8bf22c33e7a1 (HEAD -> master, origin/master, origin/HEAD) Merge tag 'net-7.0-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> 
>   $ b4 shazam 20260220182011.802116-1-ihor.solodrai@linux.dev   # apply strscpy series
>   $ b4 shazam 20260220222604.1155148-1-ihor.solodrai@linux.dev  # apply ASAN series
> 
>   $ podman pull debian:latest
>   $ podman run -it --rm -v $(pwd):/linux debian:latest /bin/bash
> 
>   # in the container
>   $ apt update -y && apt install -y make gcc python3 libelf-dev
>   # note: no libzstd-dev
> 
>   $ cd /linux/tools/bpf/resolve_btfids/
>   $ make -j8
>   # build is successful
> 
>   $ ldd resolve_btfids
> 	linux-vdso.so.1 (0x00007f3eecc81000)
> 	libelf.so.1 => /lib/x86_64-linux-gnu/libelf.so.1 (0x00007f3eecbe2000)
> 	libz.so.1 => /lib/x86_64-linux-gnu/libz.so.1 (0x00007f3eecbc2000)
> 	libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f3eec9cd000)
> 	libzstd.so.1 => /lib/x86_64-linux-gnu/libzstd.so.1 (0x00007f3eec903000)
> 	/lib64/ld-linux-x86-64.so.2 (0x00007f3eecc83000)
> 
> 
> So, while AI may be technically correct that the build will fail if
> libelf is installed and libzstd is not, it seems a far-fetched
> situation, given that libelf depends on libzstd.

This is not far-fetched, and we have build failure for v7.0-rc2 due to
this.

  ld: cannot find -lzstd: No such file or directory

Even though libelf is linked with libzstd, this does not imply
libzstd-devel (with headers and so library) is there when building.

Thanks,

> 
> I think we can leave the default -lzstd to have an explicit
> dependency in the Makefile.
> 
> 
> > 
> > [ ... ]
> > 
> > 
> > ---
> > AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> > See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> > 
> > CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22243753316
> > 
> > AI-authorship-score: low
> > AI-authorship-explanation: Human-characteristic typo in commit message, natural lore discussion with incremental debugging, and standard Makefile pattern reuse all indicate human authorship.
> > issues-found: 1
> > issue-severity-score: low
> > issue-severity-explanation: Unconditional zstd link fallback in resolve_btfids Makefile can break builds on systems without libzstd-dev, but the affected scenario is narrow and limited to the selftests build system.
> 
