Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793281612;
	b=FH9rHjfsO8ZtnVKPl9zPLks/NHrO4qz4OyE3uPuFSfI6HPTj6O2bx2yYrraqd8w6Rsnv
	 ySq2u9fD0BxytoDB427GONZEUH9brDThzFBAVyVub1FOOlp2ySF+aMOiGT3q/JthbEuve
	 rgQvYaqvfzEtCVUiZABFBNpuweeaeHeg/Ajv6t4pECdDFbg4Ts1WNdY0WncTsIXVJ0p4D
	 Z+u3wLkjWi9SOnQ917wix2Z3dgGcQEfrbEuwDbjbuM3WKJD5den6sxfc1WzA2lDpaQwdA
	 1I6Shuk6hsy0Fz5HknAlF35Nrd48iavXDL2Be66JTifETonmr1zxo1cSMr5OFqIRZ3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793281612;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=gZNtzP6cs1GRwvoX88SXgu1Vv29qxW7oVI1eNbb/P/4=;
	b=nAWgQssHbJSeQpRBloF0EKtxoU1qrR2DlSue73UFYdYZ2OMOlHPLw3PKhmuXdPxoqu0d
	 R/cjT+ILCo1TYiDK9LJboqgu1rcrhN0A1/LkmQl2gX5z8ToUOIjgnf4ZEKWYHyp68tuGr
	 O5Irdtyr0/EmcyZmdxk6/YjLEju99I9eNH2Uwk0C98hdjgOjWLs2/98Z0wvWxRKbYRlrO
	 TkXIgvpC3VXQlw/Ma4UmXxFiTx9UqEBjMhoqNKwsVyNb11ELXQiKsN7HJ8bn5DF3LBEcn
	 hHm+HxVW+YxyySjBDZh1WV0gIb/4XBTreOWre+e4dtvPwtq9WPpp3mFH5UFVWDuiLfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DdooD9kw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CC2606A31F;
	Thu, 29 Oct 2026 13:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DdooD9kw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A919F1F031E2;
	Thu, 29 Oct 2026 13:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793281612;
	bh=gZNtzP6cs1GRwvoX88SXgu1Vv29qxW7oVI1eNbb/P/4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=DdooD9kwZKAUv2hnFqN4/UAT96adjHY5DQZxppOWhcafmfRbL2quhLzVByJ6nOdFT
	 Gsq+vGiT/s/2AYbgWxdXKl8KgGznlsW0eFilX+M2IwG581DZtbI/7TSK5Ua52utcKT
	 oP4g9pwLK/hikbek9t/Z45LXWY9WJRDZFyAKvFOi5iQLl4rZZbextSlPq5d2xSbVr1
	 SW5N/+cPADmNrpQyRI+ZnxNpaILr3oIjOfqa8j9o/6J7VvzPQMzsTW84gKn0TTwhHX
	 C0eoOCDeiu7hIkAJrdpEVgid4P2/yr5cARmnDPXqQ/mhssDWpFezoQ4kZmjzAvfab5
	 m6mXKZNKuqkWg==
Content-Type: multipart/mixed; boundary="===============3728746382167177240=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <6b3ba80a4fbae6a9b693979e47170a15ec5917f5fd5c92520077aa99b8614a5b@mail.kernel.org>
In-Reply-To: <20261029-bpftool-plugin-v3-2-87af799da40a@gmail.com>
References: <20261029-bpftool-plugin-v3-2-87af799da40a@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] bpftool: Make the LLVM disassembler an optional runtime dependency
From: bot+bpf-ci@kernel.org
To: socketpair@gmail.com,qmo@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,nathan@kernel.org,morbo@google.com,justinstitt@google.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,ndesaulniers@google.com
Cc: linux-kernel@vger.kernel.org,bpf@vger.kernel.org,llvm@lists.linux.dev,socketpair@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 29 Oct 2026 13:46:51 +0000 (UTC)

--===============3728746382167177240==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpftool: Make the LLVM disassembler an optional runtime dependency

TL;DR: Nits only: the new generated llvm-plugin-dir stamp file may need a
.gitignore entry, and the bpftool man page may need updating, since "llvm" in
version output now depends on the plugin loading at runtime.

> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index b0f7168e7943..dc8e4be86296 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile

[ ... ]

> @@ -290,6 +300,21 @@ $(BPFTOOL_BOOTSTRAP): $(BOOTSTRAP_OBJS) $(LIBBPF_BOOTSTRAP)
>  $(OUTPUT)bpftool: $(OBJS) $(LIBBPF)
>  	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $(OBJS) $(LIBS) -o $@
>
> +ifneq ($(LLVM_PLUGIN),)
> +all: $(LLVM_PLUGIN)
> +
> +$(LLVM_PLUGIN): CFLAGS += -fPIC
> +$(LLVM_PLUGIN): $(OUTPUT)llvm_disasm.o
> +	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) -shared $< $(LLVM_LIBS) -o $@
> +
> +# The plugin directory, $(libdir)/bpftool, is compiled into jit_disasm.o.
> +# Recompile it if libdir changes, e.g. on "make" then "make install libdir=...".
> +$(OUTPUT)llvm-plugin-dir: FORCE
> +	$(Q)echo '$(libdir)/bpftool' | cmp -s - $@ || echo '$(libdir)/bpftool' > $@
                                                          ^^^^

The new stamp file $(OUTPUT)llvm-plugin-dir is a generated build artifact,
but it does not look like any ignore pattern matches it.

bpftool-llvm.so is covered by '*.so' and llvm_disasm.o by '*.o', but
'git check-ignore' finds no pattern for tools/bpf/bpftool/llvm-plugin-dir.

On an in-tree build with a shared libLLVM (make -C tools/bpf/bpftool with
no OUTPUT), the stamp is written to tools/bpf/bpftool/llvm-plugin-dir and
shows up as an untracked file in 'git status'.

tools/bpf/bpftool/.gitignore already lists the similar generated file
FEATURE-DUMP.bpftool.  Should this patch add '/llvm-plugin-dir' there as
well?

> +
> +$(OUTPUT)jit_disasm.o: $(OUTPUT)llvm-plugin-dir
> +endif
> +

[ ... ]

> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
> index d15fec71b64e..321e928d651c 100644
> --- a/tools/bpf/bpftool/main.c
> +++ b/tools/bpf/bpftool/main.c
> @@ -124,7 +124,8 @@ static int do_version(int argc, char **argv)
>  	const bool has_libbfd = false;
>  #endif
>  #ifdef HAVE_LLVM_SUPPORT
> -	const bool has_llvm = true;
> +	/* The LLVM disassembler may be a plugin that is not installed */
> +	const bool has_llvm = disasm_llvm_available();
                              ^^^^

With a shared libLLVM, the "llvm" entry printed by "bpftool version" and
"-V" now depends on whether bpftool-llvm.so can be dlopen()ed at runtime
rather than on how bpftool was built.  The man page text was not updated
to match.

tools/bpf/bpftool/Documentation/common_options.rst, which every bpftool man
page includes, still says:

    Print bpftool's version number (similar to **bpftool version**), the
    number of the libbpf version in use, and optional features that were
    included when bpftool was compiled. Optional features include linking
    against LLVM or libbfd to provide the disassembler for JIT-ted programs
    (**bpftool prog dump jited**) ...

In this mode bpftool is no longer linked against LLVM at all, and
do_version() -> disasm_llvm_available() -> llvm_load(false) can fail in
llvm_plugin_find() or dlopen().  has_llvm then comes back false even though
bpftool was compiled with HAVE_LLVM_SUPPORT.

Should common_options.rst say that "llvm" is reported only when the
disassembler plugin is installed and loadable?

>  #else
>  	const bool has_llvm = false;
>  #endif


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40881490673
--===============3728746382167177240==--
