Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92E8547071;
	Sat,  3 Oct 2026 20:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791060123; cv=none; b=bboncs3DihH7Jii/c3Rhj60ULH6X2Pt7UkrPNmH+vh7vV4rQg99da/kQn3xwjLKx3+/7DA33xX5txh7vQmYSoGWBG+zA795V1J+DEeCW+o8KiI6JhYB0txz0+yFdIbM5ln1FhxmdOdsB8D0JQQasJsq9iux+rvKZ14rCRiGarv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791060123; c=relaxed/simple;
	bh=LxvFZFlNOEgX1oxiEQ1vT1nLthMuWiPUEF31iAeRdDU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=bUl/e63NPNC2AGEzm3lsilxJol3EK0xdkOeDkQs+hAZlHEQGfOqCCK241z4xzRPaqD5PkiBgRfp8vo8kkqreoMfseVOJf43UxsKQ5SiMJ+lAxgPhGnDt8E86DyevszZZklxneGfFh6lfEaGk/gZzPIqDarWEhOYKERgq76xLGrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oakwtlXJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oakwtlXJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC601F0089B;
	Sat,  3 Oct 2026 20:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791060121;
	bh=qxDz7L6MBfjIz7h7pDjVBsFAKxwqnTJRLvd8MOgdizA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=oakwtlXJumTBRgjcI68Q8zQ1dTjfWzcKAcW/BuuykF6BRvKivmd0PTGqScacEA8Qv
	 lMNUqY4JaGOkFLcAncQNWkc9i+FICAN/Nq2FPK4nImrXbb3gYpX/WH2/lDp7okz0Nf
	 aClM2+7zqUT8yaSAHZZ0ribfIHwc/udwaWIZdOFYszBidwak02xm+Pg2a/ycuAsobX
	 uChvlGSj01cz+ZgTkzjvIIzIb8ODpmpjaM5clMuwi/vdB/D8+CWRZxrDzt9d3/Ov0G
	 id4yKICCWbw9hsVa6HY++aldVcInXFVSCxEdreURpAXFj6R26ZxfAdi4fpTMm76Gu+
	 NJTCvren0AFrw==
Content-Type: multipart/mixed; boundary="===============7786763177781177600=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <970e7d2486a44d57b0bc68b9ac39c74e21e13df8957c952ec310c55a171115d9@mail.kernel.org>
In-Reply-To: <20261003194323.817885-4-alan.maguire@oracle.com>
References: <20261003194323.817885-4-alan.maguire@oracle.com>
Subject: Re: [PATCH v3 bpf-next 3/7] kbuild, btf: Expose vmlinux inline BTF through sysfs
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com
Cc: jolsa@kernel.org,ihor.solodrai@linux.dev,yonghong.song@linux.dev,song@kernel.org,qmo@kernel.org,martin.lau@linux.dev,memxor@gmail.com,emil@etsalapatis.com,mcgrof@kernel.org,petr.pavlu@suse.com,tj@kernel.org,kees@kernel.org,nathan@kernel.org,arnd@arndb.de,puranjay@kernel.org,yatsenko@meta.com,atenart@kernel.org,ojeda@kernel.org,linux-modules@vger.kernel.org,arnaldo.melo@gmail.com,bpf@vger.kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  3 Oct 2026 20:41:58 +0000 (UTC)

--===============7786763177781177600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> kbuild, btf: Expose vmlinux inline BTF through sysfs

TL;DR:
- Module load may fail with -ENOENT for modules without .BTF or with BTF
  mismatch allowed
- mmap of /sys/kernel/btf/vmlinux may return -EINVAL on arm64
- __SIZEOF_LONG__ may break 32-bit builds
- Nits: .gitignore, NULL return

> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index b2988aa12f66..863f02660bc3 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h

[ ... ]

> @@ -675,12 +675,39 @@
> +#ifdef CONFIG_DEBUG_INFO_BTF_INLINE_MODULE
> +/* __MODULE_NAME_LEN + SHA-256 digest + u32 BTF size */
> +#define BTF_LINK_SIZE	(64 - __SIZEOF_LONG__ + 32 + 4)
> +#define BTF_INLINE_LINK						\
> +	. = ALIGN(PAGE_SIZE);					\
> +	.BTF.inline.link : AT(ADDR(.BTF.inline.link) - LOAD_OFFSET) { \
> +		__start_BTF_inline_link = .;				\
> +		BYTE(0)						\
> +		. += BTF_LINK_SIZE - 1;					\

Is __SIZEOF_LONG__ reliable in a linker script?

The lds is preprocessed with KBUILD_CPPFLAGS only.  On x86, -m32 is added
only to KBUILD_CFLAGS and KBUILD_AFLAGS, and with clang KBUILD_CPPFLAGS
carries --target=x86_64-linux-gnu for all of SRCARCH=x86.  So for a 32-bit
x86 build with clang, or with a gcc whose default target is x86_64,
__SIZEOF_LONG__ is 8 while the lds is preprocessed, and BTF_LINK_SIZE
becomes 64 - 8 + 32 + 4 = 92.

On a 32-bit kernel __MODULE_NAME_LEN is 64 - sizeof(unsigned long) = 60, so
sizeof(struct btf_link) is 96.

With CONFIG_DEBUG_INFO_BTF_INLINE=m, link-vmlinux.sh runs:

  resolve_btfids --btf_link .BTF.inline:btf_vmlinux_inline:vmlinux.BTF.inline

patch_btf_link() uses module_name_len = BTF_LINK_MODULE_NAME_MAX - 4 for
ELFCLASS32 and rejects the section if

  data->d_size != module_name_len + BTF_SHA256_DIGEST_LENGTH + sizeof(u32)

Since 92 != 96, it prints "FAILED: section .BTF.inline.link is not a
writable BTF link", returns -1, and the vmlinux link fails.  Even if the
build got past that, btf_parse_link() checks size != sizeof(*link) and would
reject the record.

riscv32 looks the same: -mabi=ilp32 is only in KBUILD_CFLAGS and
KBUILD_AFLAGS, and the clang target is riscv64-linux-gnu.

Could this use something tied to Kconfig instead, such as #ifdef
CONFIG_64BIT, or BITS_PER_LONG / 8 from asm/bitsperlong.h, rather than the
compiler's default ABI macro?

[ ... ]

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 0630675377aa..732ba0684667 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[ ... ]

> @@ -9015,21 +9016,122 @@ static DEFINE_MUTEX(btf_module_mutex);
> +static const struct btf_link *btf_parse_link(void *start, unsigned int size)
> +{
> +	const struct btf_link *link = start;
> +	unsigned int module_name_len;
> +
> +	if (!link || size != sizeof(*link))
> +		return NULL;
> +
> +	if (link->btf_size == 0)
> +		return 0;

this isn't a bug, but btf_parse_link() returns a pointer and this path
returns a plain integer 0 where the other failure paths return NULL.  sparse
reports "Using plain integer as NULL pointer" here.

The only caller, btf_vmlinux_inline_lazy_init(), handles this the same way
as the other failures and prints "invalid vmlinux inline BTF link".  Could
this return NULL, or be folded into the check above?

[ ... ]

>  static int btf_module_notify(struct notifier_block *nb, unsigned long op,
>  			     void *module)
>  {
> [ ... ]
>  	int err = 0;
>
> -	if (mod->btf_data_size == 0 ||
> -	    (op != MODULE_STATE_COMING && op != MODULE_STATE_LIVE &&
> -	     op != MODULE_STATE_GOING))
> +	if (op != MODULE_STATE_COMING && op != MODULE_STATE_LIVE &&
> +	    op != MODULE_STATE_GOING)
>  		goto out;
>
>  	switch (op) {
>  	case MODULE_STATE_COMING:
> +		err = btf_module_handle_vmlinux_inline(mod);
> +		if (err != -ENOENT) {
> +			err = 0;
> +			break;
> +		}
> +		if (!mod->btf_data_size)
> +			break;
>  		btf_mod = kzalloc_obj(*btf_mod);

Can this reject every module that has no .BTF section?

btf_module_handle_vmlinux_inline() returns -ENOENT for any module that is
not the vmlinux inline carrier, and the
!IS_MODULE(CONFIG_DEBUG_INFO_BTF_INLINE) stub returns -ENOENT
unconditionally.  That value stays in err.

The old code returned early with err == 0 when mod->btf_data_size was 0.
Now a module without .BTF hits:

		if (!mod->btf_data_size)
			break;

and btf_module_notify() returns notifier_from_errno(-ENOENT) from the out:
label.

The same leftover err is returned when btf_parse_module() fails with
CONFIG_MODULE_ALLOW_BTF_MISMATCH=y:

		if (IS_ERR(btf)) {
			kfree(btf_mod);
			if (!IS_ENABLED(CONFIG_MODULE_ALLOW_BTF_MISMATCH)) {
				...
			} else {
				pr_warn_once("Kernel module BTF mismatch detected, ...");
			}
			goto out;
		}

That branch never resets err, so a mismatched module, which that option
exists to let load, now fails with -ENOENT as well.

notifier_from_errno() sets NOTIFY_STOP_MASK, notifier_call_chain_robust()
rolls back the COMING chain, prepare_coming_module() returns
notifier_to_errno() == -ENOENT, and load_module() goes to bug_cleanup.  The
module load then fails with "No such file or directory".

Modules without .BTF are a normal case.  scripts/Makefile.modfinal prints
"Skipping BTF generation for %s due to unavailability of vmlinux" for
external/DKMS modules, and the kernel.spec comment changed in this same
commit says eu-strip removes .BTF when find-debuginfo has no --keep-section.
Before this patch both cases loaded fine.

The problem is still there at the end of the series (e1c2367cf1b5);
3357b172196f ("btf: Relocate and expose module inline BTF") keeps the same
COMING prologue.

Would resetting err to 0 when the helper returns -ENOENT work?

	err = btf_module_handle_vmlinux_inline(mod);
	if (err != -ENOENT) {
		err = 0;
		break;
	}
	err = 0;

[ ... ]

> diff --git a/kernel/bpf/sysfs_btf.c b/kernel/bpf/sysfs_btf.c
> index 9cbe15ce3540..a3c54b5fe294 100644
> --- a/kernel/bpf/sysfs_btf.c
> +++ b/kernel/bpf/sysfs_btf.c

[ ... ]

> @@ -33,24 +31,149 @@ static int btf_sysfs_vmlinux_mmap(struct file *filp, struct kobject *kobj,
> +static int btf_sysfs_mmap_direct(struct file *filp, struct kobject *kobj,
> +				 const struct bin_attribute *attr,
> +				 struct vm_area_struct *vma)
> +{
> +	void *data = READ_ONCE(attr->private);
> [ ... ]
> +	err = btf_sysfs_mmap_check(data, attr->size, vma);
> +	if (err)
> +		return err;
> +	if (is_vmalloc_addr(data))
> +		return remap_vmalloc_range(vma, data, 0);
> +
> +	addr = __pa_symbol(data);
> [ ... ]
>  static struct bin_attribute bin_attr_btf_vmlinux __ro_after_init = {
>  	.attr = { .name = "vmlinux", .mode = 0444, },
>  	.read = sysfs_bin_attr_simple_read,
> -	.mmap = btf_sysfs_vmlinux_mmap,
> +	.mmap = btf_sysfs_mmap_direct,
>  };

Does this break mmap() of /sys/kernel/btf/vmlinux on arm64?

bin_attr_btf_vmlinux now uses btf_sysfs_mmap_direct(), which chooses between
remap_vmalloc_range() and remap_pfn_range() based on is_vmalloc_addr(data).
On arm64 the kernel image lives inside the vmalloc range:

  arch/arm64/include/asm/memory.h:  #define KIMAGE_VADDR (MODULES_END)
  arch/arm64/include/asm/pgtable.h: #define VMALLOC_START (MODULES_END)

So is_vmalloc_addr(__start_BTF) returns true, and the call goes to
remap_vmalloc_range() -> remap_vmalloc_range_partial().  There,
find_vm_area() finds the vm_struct that declare_kernel_vmas() registered for
the image rodata segment:

  declare_vma(&vmlinux_seg[1], __start_rodata, __inittext_begin, VM_NO_GUARD);
  ...
  vma->flags = VM_MAP | vm_flags;

That vm_struct has no VM_USERMAP, so this check:

  if (!(area->flags & (VM_USERMAP | VM_DMA_COHERENT)))
          return -EINVAL;

fails and mmap() returns -EINVAL.  Before this patch,
btf_sysfs_vmlinux_mmap() always used __pa_symbol(__start_BTF) plus
remap_pfn_range(), which worked on arm64 since .BTF sits inside RO_DATA,
between __start_rodata and __inittext_begin.

The same applies to the built-in /sys/kernel/btf/vmlinux.inline, which the
commit message says supports read-only mmap().  The selftest
test_btf_mmap_sysfs("/sys/kernel/btf/vmlinux") would fail on arm64 as well.

Would it be better to use remap_vmalloc_range() only for the lazily
populated vmalloc_user() entries, for example from btf_sysfs_mmap_lazy() or
by recording the backing type in struct btf_sysfs_entry, and keep the
__pa_symbol()/remap_pfn_range() path for kernel image data instead of
testing the address range?

[ ... ]

> diff --git a/scripts/gen-btf.sh b/scripts/gen-btf.sh
> index 8ca96eb10a69..e638291753d0 100755
> --- a/scripts/gen-btf.sh
> +++ b/scripts/gen-btf.sh

[ ... ]

> @@ -83,14 +88,28 @@ gen_btf_o()
> +	btf_inline=${ELF_FILE}.BTF.inline
> +	if [ "${BTF_INLINE}" = "m" ]; then
> +		if [ -f "${btf_inline}" ]; then
> +			cp "${btf_inline}" "${objtree}/vmlinux.BTF.inline"
> +		else
> +			rm -f "${objtree}/vmlinux.BTF.inline"
> +		fi
> +	fi

With CONFIG_DEBUG_INFO_BTF_INLINE=m, this leaves a long-lived top-level
build artifact, vmlinux.BTF.inline.  link-vmlinux.sh reads it for
--btf_link, and Makefile.modfinal reads it later to embed .BTF.inline into
btf_vmlinux_inline.ko.

The patch adds it to CLEAN_FILES in the top-level Makefile but not to
.gitignore, where the other top-level vmlinux artifacts are listed
(/vmlinux, /vmlinux.32, /vmlinux.map, /vmlinux.symvers,
/vmlinux.thinlto-index, /vmlinux.unstripped).  In an in-tree build,
"git check-ignore -v vmlinux.BTF.inline" returns nothing, so the file shows
up as untracked in git status.

Should /vmlinux.BTF.inline be added to .gitignore next to
/vmlinux.unstripped?  The later commits in the series (f61c6417ac15 through
e1c2367cf1b5) do not touch .gitignore.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37149955093
--===============7786763177781177600==--
