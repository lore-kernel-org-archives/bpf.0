Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793495043;
	b=eF1OQu9VPTR35Ch3Jmd5jSKSBOtHpp2aeA05a97lTelHGjmGULnnq4Ayw4JgCtdxJXSF
	 v8B7A15sJ/hH9b8ZYuWmnSD8AJ/vfcVTUBkNTiCkoYw1TbAysfFkNJj+J0700TqUJjoyZ
	 SDhi1Dwc4XS6R+etfFtwjy4oVDAhe6khJfJ01DQiJSgFmFX4BGbidSj/i5wqlNUfaVj10
	 CgQmCmR+Z0Z2Q7SAssPV/DTrWxK7agTWcZo+dZknfR23l4V0aVQXKRAmD9bPRAk9/kqAj
	 s/28O5zfR2SBfOVOv7DZ/eXQYJluz13P4un/UvWKEGEWSN6BqLmrz3NmiunCBsc/hdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793495043;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=VYTTSTczGEfRjwG36VgyHOdbxUJfLIKC4RqA43YT4FI=;
	b=T3+wrxOpIOhth9kdgbIyz4fMgAVM/5v0Gn+NgFXOnrCXJhUzZy97CQD5hj4C5eMib9EB
	 0ZNr85b4nbrb842MS0ehSgN8CK8yQMQKdVOuAj1dWDirHRA2l/jQGOkjmapuqQzgNhzX2
	 DO3m76TcVSUS5oWCJjuVXy5gUKE9NCkb9rOM670iu3RAL4wZbNKfsFSm6vEmHeepDENNF
	 Oy677l0PbYQwHvlB97why0rNFSSZpfSOmBVvNifKYemDZDO4pgBck1GUv5fAO0F2Gi5JV
	 kGnGVJG3rFm0M9jhB5Y7C9w50XwcACy0LrhWZnP5NeVkH8bLtkqNq5BJL9yxNhvAxIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dMaUfqfF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A277606A31A;
	Sun,  1 Nov 2026 01:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dMaUfqfF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CCF61F000C1;
	Sun,  1 Nov 2026 01:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793495042;
	bh=VYTTSTczGEfRjwG36VgyHOdbxUJfLIKC4RqA43YT4FI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=dMaUfqfFCmP2M/5asa9VfGfocDpvlcu6SRHwzVzXC/BL3wHIIK9hgIYeXm3GJDlbs
	 c0K9bYDs8skteMMZqjB2cdoaVGNOUxRIjTXG1syF3zZkjwZTV4HaPQ6zslX/CmdJHW
	 AJA9AkEhlxfRVwznhCnU4GgFT8zLcccntfgH0CFE0zdZNMjoZaZxTHHVAW8ydsMq4V
	 Kb2WLbEN2wbuPO09oS26AsJzF5r9RtsmfiTMPobH9QBcUU1T1PR3Cstk1/BLgnkruE
	 LKlyULpBXK7nNBvRkGEkZFZb1QOBWT+rDnc+QlnFqPSJ9aGAzyMondqeZri+E3VGr7
	 sm3ZllZ4g44JA==
Message-ID: <09db4d22-2836-4656-8c6a-a7e5377710fb@kernel.org>
Date: Sat, 31 Oct 2026 18:04:01 -0700
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARC: Strip libgcc debug information when generating BTF
To: Sasha Levin <sashal@kernel.org>, Vineet Gupta <vgupta@kernel.org>,
 linux-snps-arc@lists.infradead.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Ilya Leoshkevich
 <iii@linux.ibm.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>
References: <20261015154044.4058618-1-sashal@kernel.org>
From: Vineet Gupta <vgupta@kernel.org>
Content-Language: en-US
In-Reply-To: <20261015154044.4058618-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/15/26 08:40, Sasha Levin wrote:
> ARC links against the compiler's libgcc archive. The ARC GNU 2023.03
> toolchain ships this library with debug information, including complex
> floating-point types in integer arithmetic helpers such as __udivdi3.
> These types reach vmlinux even though the kernel does not use complex
> floating-point arithmetic.
>
> When floating-point BTF encoding is enabled, pahole rejects those types:
>
>    Complex, interval and imaginary float types are not supported
>    Error while encoding BTF.
>    FAILED: load BTF from .tmp_vmlinux1.BTF.1: No such file or directory
>
> KernelCI's upgrade to pahole 1.31 exposed this long-standing problem as
> failed ARC builds. As of 1.32, pahole still rejects these types, and
> older versions will stay in use, so the kernel build has to keep them
> out of vmlinux. Commit f122668ddcce ("ARC: Add eBPF JIT support")
> documented the same failure along with a workaround of disabling
> floating-point BTF encoding, but that also discards supported
> floating-point types from kernel BTF.
>
> For CONFIG_DEBUG_INFO_BTF, generate a debug-stripped copy of the selected
> libgcc archive in the output tree and link that copy. Preserve the archive
> structure so that only needed helpers are linked, and use the normal
> Kbuild objcopy rule to track input and command changes. The trade-off is
> that vmlinux in BTF-enabled builds no longer carries DWARF for the libgcc
> helpers. Debug information for kernel code, the installed toolchain and
> non-BTF builds stay unchanged.
>
> Reproduced and tested with ARC GCC 12.2.1 and pahole 1.31 and 1.32 using
> an ARCv2 tinyconfig with BPF_SYSCALL and DWARF4/BTF enabled. Before and
> after vmlinux.o files are identical after stripping debug information.
>
> Fixes: db16c1fe92d7 ("bpf: Generate BTF_KIND_FLOAT when linking vmlinux")
> Link: https://github.com/kernelci/kernelci-core/commit/e71b8c9f42253180596e734c18965a5aad80c8c5
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   arch/arc/Makefile     | 9 ++++++++-
>   arch/arc/lib/Makefile | 8 ++++++++
>   2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arc/Makefile b/arch/arc/Makefile
> index 868805ffcfeab..4ea705a331c7c 100644
> --- a/arch/arc/Makefile
> +++ b/arch/arc/Makefile
> @@ -86,7 +86,14 @@ core-$(CONFIG_ARC_PLAT_TB10X)	+= arch/arc/plat-tb10x/
>   core-$(CONFIG_ARC_PLAT_AXS10X)	+= arch/arc/plat-axs10x/
>   core-$(CONFIG_ARC_SOC_HSDK)	+= arch/arc/plat-hsdk/
>   
> -libs-y		+= arch/arc/lib/ $(LIBGCC)
> +libs-y		+= arch/arc/lib/
> +
> +ifdef CONFIG_DEBUG_INFO_BTF
> +export LIBGCC := $(LIBGCC)
> +libs-y		+= arch/arc/lib/libgcc.a
> +else
> +libs-y		+= $(LIBGCC)
> +endif
>   
>   boot		:= arch/arc/boot
>   
> diff --git a/arch/arc/lib/Makefile b/arch/arc/lib/Makefile
> index 30158ae69fd4a..2807ee24f27e6 100644
> --- a/arch/arc/lib/Makefile
> +++ b/arch/arc/lib/Makefile
> @@ -13,3 +13,11 @@ lib-$(CONFIG_ISA_ARCV2)		+=memcpy-archs-unaligned.o
>   else
>   lib-$(CONFIG_ISA_ARCV2)		+=memcpy-archs.o
>   endif
> +
> +# libgcc can contain complex floating-point debug types unsupported by BTF.
> +# Strip only the debug information from a local copy of the selected archive.
> +always-$(CONFIG_DEBUG_INFO_BTF) += libgcc.a
> +OBJCOPYFLAGS_libgcc.a := --strip-debug
> +
> +$(obj)/libgcc.a: $(LIBGCC) FORCE
> +	$(call if_changed,objcopy)

I'm working on getting rid of libgcc linking for ARC.
This requires adding some GENERIC_LIB_* routines, but as part of that 
series I'll propose a revert of this and then the dropping the first link.
Don't intend to revert this per se, but revert just makes it cleaner.

Just FYI.

Thx,
-Vineet
