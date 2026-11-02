Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793624094;
	b=sgDkvzjtJCLgdclrvaCNymYKbnVsGP8EFGXn1D4DAAVF1SPlTCV1g/c6xhtj+qlStC7S
	 cu7yEMVRX1ndmh2I6JGana/40iMbhUoC9IQYVhrNAC5Se+hv/6hrsBdAnQTE5pMxamb90
	 ObvhuioRZ14sjHE2MP73qrV6pwniei741AnzD3wqp9NjzzColpsh1V8XjEo6NDd7iCVC9
	 +6kyIleKVbwF+FHgyJh+PLW2XvJXy7GmXfC6GITKAlHvQ3LIjl6Vkk9fUOsDlpQVb3TpB
	 TIYJRxfb9+lmqj9r7laNguE93UQ7F2gpEPsOMQ/9f6yjrCNWQPEQs4p2eXHilB7UaWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793624094;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rhCR3GMcoFaPhbJWeqssm+oshTEDc/Z1DTzgGJ6PpLc=;
	b=FWZmgVYNW088zEzosZNKP/EkELgQdc3/9Vy3kRe0NATNvaoYhEw1aPb4p0Oho8aAYCD1
	 yMY2f4O9j+I3Dc2qiHXe85Z9LvUkD5RPCJxLM0iEisI93tXfwv+jK956ioMDTyQiSRvdT
	 +hkZM6FXYKQ2LdHvCe6I09Ley6QAE/xJI3cK2DZz9G4ggussCwg2lGhPUpvhAqyAea7Al
	 vR3S3IGmau1t1xsUNdaM8o6MwP16J5UEPndhXrs00flwCMaUsxBV9zDHPuO8DKjDerJe2
	 suDaRzV6O6UhUFYec7fa2t7VBtN3/KAeKZM2b0yGMMwWTxd7vgR1xqSr7CkIFSE4TYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SCtL+5y+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C88606A32D
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 12:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SCtL+5y+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20AE91F00A16;
	Mon,  2 Nov 2026 12:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793624093;
	bh=rhCR3GMcoFaPhbJWeqssm+oshTEDc/Z1DTzgGJ6PpLc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SCtL+5y+2tnT4d6vfGdqbn1deSagDHuucmwjYl8o9FXv91AaaO56RKOwhUD1x7PB2
	 I2pjIsZMuZb2Y3jGFL/RhwI4O+181TCW3dT62e1EjiDcg7YYrBDMqZtRS3xhzkpwhX
	 yHViVXN/VRq1nKwi0Rxzpd2DYVJH9ENrVLgGBJSOZ0nBEgm05yxjtFArDU50/Zvf5D
	 +53iMwZ7bDPJ81AYW4fgWyP2dB8zdAGzTspWDMUwBBG3ypbAJ3fCLw6utatBZb4AXw
	 /ui6+x2joPulOJyrB4cPnqOW9eg1EaNcH0aDsBfwdn/+d/8XlTmZeqH//zc9gVygnQ
	 nsYbkyQPl7dAw==
Message-ID: <sashiko-outbox-193449@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 2/2] bpftool: Make the LLVM disassembler an
 optional runtime dependency
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mark Korenberg" <socketpair@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261102-bpftool-plugin-v4-2-5a853e973db9@gmail.com>
References: <20261102-bpftool-plugin-v4-0-5a853e973db9@gmail.com>
 <20261102-bpftool-plugin-v4-2-5a853e973db9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 12:54:52 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpftool: resolving LIBLLVM_SO with realpath breaks dlopen() in d=
isasm_init()
--

commit 97021edb72f7e0a08dad16e3c0be0bb0e347592d
Author: Mark Korenberg <socketpair@gmail.com>

bpftool: Make the LLVM disassembler an optional runtime dependency

This commit avoids linking bpftool directly against shared libLLVM.so at
build time and instead loads it dynamically with dlopen() and dlsym() in
disasm_init() when running "bpftool prog dump jited".

Link: https://github.com/libbpf/bpftool/issues/262

> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index b0f7168e79432..876bf3cf93e3b 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -186,10 +186,18 @@ ifeq ($(HAS_LLVM),1)
>    # Makefile includes lib.mk which sets -D_GNU_SOURCE) which would cause
>    # compilation error due to redefinition. Let's filter it out here.
>    CFLAGS  +=3D $(filter-out -D_GNU_SOURCE,$(shell $(LLVM_CONFIG) --cflag=
s))
> -  LIBS    +=3D $(shell $(LLVM_CONFIG) --libs $(LLVM_CONFIG_LIB_COMPONENT=
S))
> +  LIBLLVM_SO :=3D $(shell $(LLVM_CONFIG) --libfiles $(LLVM_CONFIG_LIB_CO=
MPONENTS))
>    ifeq ($(shell $(LLVM_CONFIG) --shared-mode),static)
> +    LIBS +=3D $(shell $(LLVM_CONFIG) --libs $(LLVM_CONFIG_LIB_COMPONENTS=
))
>      LIBS +=3D $(shell $(LLVM_CONFIG) --system-libs $(LLVM_CONFIG_LIB_COM=
PONENTS))
>      LIBS +=3D -lstdc++
> +  else ifeq ($(words $(LIBLLVM_SO)),1)
> +    # Don't link with libLLVM.so. "prog dump jited" loads it with dlopen=
().
> +    CFLAGS +=3D -DLIBLLVM_SO=3D'"$(notdir $(realpath $(LIBLLVM_SO)))"'

[Severity: Medium]
Will resolving LIBLLVM_SO with $(notdir $(realpath $(LIBLLVM_SO))) cause
dlopen(LIBLLVM_SO, RTLD_NOW) in disasm_init() to fail on distributions such
as Debian and Ubuntu, or across point-release upgrades?

Because $(notdir ...) strips the directory path and LDFLAGS only receives
llvm-config --ldflags without an rpath, dlopen() in
do_dump()->disasm_init() searches only the default runtime dynamic loader
paths:

tools/bpf/bpftool/jit_disasm.c:disasm_init() {
	...
	lib =3D dlopen(LIBLLVM_SO, RTLD_NOW);
	if (!lib) {
		p_err("failed to load %s: %s", LIBLLVM_SO,
		      dlerror() ?: "unknown error");
		return -1;
	}
	...
}

On Debian and Ubuntu, the runtime package installs the actual shared object
at /usr/lib/llvm-X/lib/libLLVM.so.1 (a private directory not in the default
ld.so search path) and exposes it in /usr/lib/<multiarch>/ only through
symlinks named after the ELF soname (such as libLLVM.so.19.1 or
libLLVM-19.so.1). Applying realpath resolves the symlink back to
/usr/lib/llvm-X/lib/libLLVM.so.1, and notdir turns that into "libLLVM.so.1",
which does not exist in /usr/lib/<multiarch>/.

Similarly, on builds where libLLVM.so is a symlink chain through the soname
(for example libLLVM.so.20.1) to a full point-release filename (for example
libLLVM.so.20.1.8), realpath bypasses the soname symlink and embeds the
exact point-release filename, which breaks dlopen() after a point-release
update of the runtime package.

Would it be better to extract the ELF soname from $(LIBLLVM_SO) (for example
with readelf or objdump) instead of using realpath?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-bpftool-pl=
ugin-v4-0-5a853e973db9@gmail.com?part=3D2
