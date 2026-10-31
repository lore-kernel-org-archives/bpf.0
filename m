Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793453597;
	b=BMwRHq60SUJfdLjXNtxbCbUgIXcL9iQm7syG9buxRDhPv2EPDc1GFdC4zlZjA3TUsy4a
	 lyH+8wfBTitV9CYXsKXzeDM0Sml+JvVRNxeV+rY3j8EINFMUSa6QFfS3bAGU8krdvzC+k
	 h1LEKWjA8HfBiV9LfJtTziGLPuPan7YXpePPkiL+r6h+3ZQ9KieAknSeuhpw02oR9TaNU
	 yY0xLRaAhQKRrYDxOwFwkYXSQyWwqsUkYtzLL9LyrNbB8gb/2UWpEsFFXQusGBq901nXq
	 +9lJazmx9qkumwJ3QjTC1RlS/clwHTGJnFD/HSZpmzGGa+53ehmBV6asrkAWcg7+SDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793453597;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lQYqO0jtSJ1Lg8qOxAs/GI8FQqxgwI2WqZcooFV2bjQ=;
	b=lU/SkJYCiH26r3kmml0krsHf0lqquwFZ+bkovlNoFtSz5fZGaCtC6VwS2/vEFe6e6yis
	 N2GTxPITrrbnn6w1Gcp4d+3xnbbTplc10DEqKSF+NbdCjfDO6RYEd0ZMkijfhHnqQSXlZ
	 47hkymbSCoBgGnvFjZ74xEURTPGx/Xe6hTourqc2cshD90Pxr+gyMn+Kcm+Pooqq0Vi7j
	 bTdNQS3i0OBRSVY7XnId/5oLFUgpjSd/vFSzROx99QLVlF2thxWZkJ4NiAdvVlc0ud+vH
	 38ub8+6xtaFGIQdcPoFKA44CcNJ/w+ejWFBDD8CIUGZiPWo6IxcEZedI99tUaRp09pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FuHoVSUA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6C1606A31A;
	Sat, 31 Oct 2026 13:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FuHoVSUA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0112F1F00A02;
	Sat, 31 Oct 2026 13:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793453597;
	bh=lQYqO0jtSJ1Lg8qOxAs/GI8FQqxgwI2WqZcooFV2bjQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FuHoVSUAjLXDizMaNd+S3zLENXfKhdaOVhsDv4RKD/cAv8MKUIMzYgcdjlPU95sZw
	 gYFuKCyeKD+HSRFcfbaCaKtHOan8Ukb7+wKOrHKFv9IUq1YuiIK7gF2Z6+3xiujiw1
	 OvGY0c8WX9UzX+hQXe4y1XBh748ACb8AesF5Zh2nXDduleMxkuuNLS63r7he5Q7j8W
	 MYT2SPulvNkojbQgyBPivtuM1r381zGbhXiCmn6hiQg3Mz8+jIWnozz15f4Mn18yKU
	 FQEtazYk4lzDfNecxrVrHfvfcjEL9bCxBi2Oe+zD0Peet1IjGFMK3eq6juzehHuHuJ
	 emDMpO+pEcmDQ==
Message-ID: <sashiko-outbox-191977@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 09/13] bpf: keep the vmlinux BTF
 zstd-compressed in the kernel image
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jay Wang" <wanjay@amazon.com>, bpf@vger.kernel.org, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Alan Maguire" <almagui@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri
 Olsa" <jolsa@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org, "Nathan
 Chancellor" <nathan@kernel.org>, "Nicolas Schier" <nsc@kernel.org>, linux-kbuild@vger.kernel.org, "Arnd
 Bergmann" <arnd@arndb.de>, x86@kernel.org, "Hazem Mohamed Abuelfotoh" <abuehaze@amazon.com>, "Bjoern
 Doebel" <doebel@amazon.de>, "Martin Pohlack" <mpohlack@amazon.de>, jay.wang.upstream@gmail.com
In-Reply-To: <20261031130959.23472-10-wanjay@amazon.com>
References: <20261031130959.23472-1-wanjay@amazon.com>
 <20261031130959.23472-10-wanjay@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 13:33:15 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] bpf: non-standard multi-line comment style in btf_free()
- [Low] bpf: unresolved TODO-NEEDS-IHOR placeholder before Signed-off-by tag
--

commit 569512ffc44983e01a69cb1de127bbcd4ca67c62
Author: Jay Wang <wanjay@amazon.com>

bpf: keep the vmlinux BTF zstd-compressed in the kernel image

This commit adds CONFIG_DEBUG_INFO_BTF_LAZY to store the vmlinux BTF
zstd-compressed in the kernel image and decompress it on first access via
btf_vmlinux_data().

>     bpf: keep the vmlinux BTF zstd-compressed in the kernel image
>    =20
>     The vmlinux BTF is 5-7 MB of read-only data in every kernel built with
>     CONFIG_DEBUG_INFO_BTF=3Dy, resident whether or not anything on the sy=
stem
>     ever uses BTF.  Add CONFIG_DEBUG_INFO_BTF_LAZY to keep it compressed
>     with zstd in the image instead, at about a quarter of the size, and
>     decompress it in the kernel when it is first needed.  This is the
>     transport half of the option; the next two patches defer the
>     parsing.
>    =20
>     kbuild: gen_btf_o() in scripts/gen-btf.sh compresses the final
>     ${ELF}.BTF with zstd -19 and adds it as a second section, .init.BTF.z=
st,
>     of the same .btf.o, so neither an extra link pass nor a size
>     reservation is needed.  .BTF stays in the vmlinux ELF file as a
>     non-alloc section: pahole --btf_base, resolve_btfids for modules,
>     bpftool and libbpf's on-disk fallback find it by name and keep working
>     unchanged, and so do out-of-tree module builds.  The linker script
>     puts .init.BTF.zst in INIT_DATA, bounded by __start_BTF_zst and
>     __stop_BTF_zst, and .BTF in ELF_DETAILS at address 0.  The BTF macro
>     is renamed RO_BTF, because the token BTF in ".BTF 0 : { ... }" would
>     otherwise be macro-expanded.  x86 strips .BTF from the ELF it puts in
>     the compressed boot image, and arm64 makes its Image with objcopy
>     -O binary, which drops non-alloc sections.  The option is limited to
>     these two architectures for now: several others build their boot
>     image from a stripped ELF copy of vmlinux, which keeps non-alloc
>     sections and would carry the uncompressed BTF.  The inline BTF
>     (CONFIG_DEBUG_INFO_BTF_INLINE) is left as it is: built in, .BTF.inline
>     stays in the image; as a module it is not in memory anyway.
>    =20
>     kernel: btf_vmlinux_data() returns the raw BTF.  With the option it
>     decompresses the blob once, under a leaf mutex, into vmalloc_user()
>     memory that is never freed; the size comes from the zstd frame header,
>     so /sys/kernel/btf/vmlinux gets its size without decompressing.  A
>     late_initcall_sync copies the blob out of init memory before that is
>     freed, unless it is decompressed by then, and the copy is freed after
>     decompression, so a system that uses BTF ends up with the same
>     footprint as today.  The copy uses vmalloc(): kvmemdup() of the
>     ~1.4 MB blob would get a 2 MB kmalloc_large() allocation.  If the copy
>     fails, the BTF is unavailable for the rest of the boot: that is logged
>     once, and later fetches fail with -ENOMEM right away instead of
>     allocating the raw buffer for nothing each time.  A blob that does not
>     decompress is logged once and dropped, and fetches fail with -EINVAL
>     from then on.  btf_parse_vmlinux() and the read and mmap handlers of
>     /sys/kernel/btf/vmlinux use btf_vmlinux_data(); mmap of the
>     decompressed copy uses remap_vmalloc_range().  Without the option
>     btf_vmlinux_data() returns __start_BTF, and the sysfs file keeps its
>     current handlers.
>    =20
>     btf_vmlinux_data() lives in sysfs_btf.c, which is now built whenever
>     CONFIG_DEBUG_INFO_BTF is enabled, with the sysfs file itself still
>     under CONFIG_SYSFS: btf_parse_vmlinux() needs the data without sysfs
>     too, and with the option the blob has to be copied out of init memory
>     either way.
>    =20
>     Reading /sys/kernel/btf/vmlinux decompresses but never parses, and
>     only vmalloc and zstd run under btf_vmlinux_data_lock, so the sysfs
>     mmap path (mmap_lock -> kernfs -> btf_vmlinux_data_lock) cannot form
>     a cycle with module or cand_cache locks.
>    =20
>     On its own this patch only changes where the bytes come from: initcall
>     kfunc registrations still parse the vmlinux BTF at boot.
>    =20
>     Measured with a distribution config: the raw .BTF is 5.47 MB on x86_64
>     and 5.57 MB on arm64, and 1.44 and 1.46 MB with zstd -19.  xz -9e wou=
ld
>     save another 0.17 MB but decodes about 6 times slower (72 vs 12 ms in
>     user space).  Decompression in the kernel takes ~7 ms on x86_64.
>    =20
>     Trade-offs: the compressed blob stays resident on systems that never
>     use BTF (~1.4 MB), so with the next two patches they save about 80% of
>     what the BTF costs rather than all of it (~6 of ~7.5 MB, the raw BTF
>     plus what parsing it allocates); the x86 bzImage on disk is ~0.3 MB
>     smaller; building needs the zstd tool; __start_BTF/__stop_BTF do not
>     exist with the option (the ksyms and linked_vars selftests use them; a
>     later patch adapts them).
>    =20
>     Co-developed-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>     TODO-NEEDS-IHOR: Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.de=
v>
>     Signed-off-by: Jay Wang <wanjay@amazon.com>

[Severity: Low]
This isn't a bug in the code, but the commit message still has an
unresolved TODO-NEEDS-IHOR prefix on the Signed-off-by trailer pairing with
Co-developed-by. Should this placeholder be resolved to a clean
Signed-off-by tag?

[ ... ]

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 70adc52f5d7c7..a7bb780743fb2 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -1901,7 +1901,8 @@ static void btf_free(struct btf *btf)
>  	kvfree(btf->resolved_sizes);
>  	kvfree(btf->resolved_ids);
>  	/* vmlinux does not allocate btf->data, it simply points it at
> -	 * __start_BTF.
> +	 * __start_BTF, or at the decompressed copy with
> +	 * CONFIG_DEBUG_INFO_BTF_LAZY, which is never freed either.
>  	 */

[Severity: Low]
This isn't a bug, but when updating this multi-line comment in btf_free()
in kernel/bpf/btf.c, could the opening /* be placed on its own line to
follow the BPF coding style?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031130959.2347=
2-1-wanjay@amazon.com?part=3D9
