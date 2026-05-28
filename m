Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B7C319857
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 23:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780009284; cv=pass; b=FpRl/5nvPElusqRetj76qCQqLDWt450add36cMh0/XAtMwYj6Cciu1Ax2HrCMj/qd8ikiLHaS4c62scFLn9fOBUjY3sI5JCRjQmaMp4MpHAgUGk82VN7QUZ08I3koeTao55UN8vjpALTyrXOCrQYOzf5Avoi+1BEaVtGnc+nhHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780009284; c=relaxed/simple;
	bh=x8Eki9jvGfG5bldVMQTy06hu2GMjw7Q0FO0LBBMJZTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hDc65fKl4ILfPapZTdnvc5b9Gu5jKe1hL5/UE4MG067mPE/TRbQsF/IxQtzmxsFT8qIXvkqWcqaL9NJdihs+BwNTTHeP0GqKGwa4PKOT+GE/QBmt9vaFtZDCctVTDajDR6RIsh7YFcEaMLQPYyToDZpPOHFJczJTRQzLIG6o+GE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=swY398oy; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="swY398oy"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c8025aecc40so5992237a12.0
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 16:01:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780009282; cv=none;
        d=google.com; s=arc-20240605;
        b=P5W2oaU+ruTrgR39eZT6MeUY9/DHnwhQpmQuG20sMgeo6jDAfHkN8zh06B5sGMwuco
         S/sSt3o888AdEtoaPGDpsT1tcv/SO1bKv6mzwH4I/Yuzd/A/7HtBpKgADSi3Vg7TfSZM
         EgrSkBExobKbdonJtLcEzHk1lKzsJ9wzTn/6P7/lgiNXtvO3zloXL8US9jdHAXPPevP/
         aaDWrsW6BdXhRgD14MCzMmoNHNA1t+YuO9HtLOhq3/x8Mguh/7SsfLyAU7xyhZ7mqyUX
         LFxPn3iny424jLd1KEt0wXLO14ECS4KDyMqcg3gD1i1HBUydL+813yevJecCE78+eGGc
         ifZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lVpJVCPjc6hUaUYGBwm8xx7FBsgckNuE/gAqE8RC6GM=;
        fh=0o+Ar/ru5cFNtgNM8hmbffS+cibv0yjaOkzvWVra1IA=;
        b=WeSdwqQu4TzqXKiAR5NrwvViHgM/1Bgl/DDBOGyt5GdmazMTMB9gfKNmmg+vpDUtya
         mY6TtYeiI3kiTJHolgPHk4Xpr4tpevAZ7Q2uVKPxvzD07zeiSK8nq+96OT68eRs3krh+
         ouHT1JKrMgkymVwyaiSYE/e1wcLcCiVP4ZfT6ZF+GNc/1jZAPZ+R07VkVXmFc4d71xgN
         t0gHySRMM2tCyMtTx420CHTPFVV+mMlzYlb0oUk8rYeqzxJRcEf58se54xPIedZ1AaRn
         SDSBfrtC9CKo4s/dMpgQnBIcyO4yMIbGHRf+x1Y9BFzKiuU72fFfoRzako6B5le1+S3G
         vo8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780009282; x=1780614082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVpJVCPjc6hUaUYGBwm8xx7FBsgckNuE/gAqE8RC6GM=;
        b=swY398oykfM+9t+OsRHwqfAxU5hoIlTaO6Y1v58OOT1uG0su47Whx3pkSscG3lDZ+o
         h87BZ3+6lDwZvV9MPz3sMiBzMvu7LCVKtmFWK5bDCgZLYt7g7shrcAZo0+WgKJhCgUgM
         /2RnIX8+qOnoS8vSE4P5NGj15ZFp7qbtdYjpk6daChuFl88b0PahV1oPJlDYfOKlym/3
         /70pf6eq8HnZBlb7c8ZN7hbk9dvRgxDXV5G4E6grR2YBHGYTysueefj0dLyao7Mc1xYa
         4lT3QhbrgxTlq9e2/DpEWvcJd0/w/0TDxagat6tcLsXYl4kwHKA+c+b7cyWhmvBzUsQH
         5LLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780009282; x=1780614082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lVpJVCPjc6hUaUYGBwm8xx7FBsgckNuE/gAqE8RC6GM=;
        b=OB0nwJY3XvtQiB4Vtgp1Gi2SW/QnL4uhnqXCeBLQIfcXHBu4JeTjdy/52LUXosHep+
         VtyZnk3umi6aAhukj80hZ/UiBcoj8u1/OLsXkOFBIOqcw3UzJL2l+nnF3ppH9fq2qpUI
         k1VAR/lKx7ibCCOBZLwakBRI1gJCplyYbzUgWVlVb4Qmt8jNGR5lrJJaW6K8zBYuFhb5
         OHVLgAEcVqNQLNV9BRqcHcCNYUMlm0xrSiGd+oSbk99E1vaDeuIxsRxC3W673utX6Fzx
         hL5A5Zgti0P1l3kXn3xhSjwT2H0SMvSVoJ5kFKWfsMv4CGMe/qmDyqoT2Gi2OJQ3ixGT
         hXEg==
X-Forwarded-Encrypted: i=1; AFNElJ+hA1P4/+TGUjYljUlMcZnng/mmvM7qiKXJXnZXmcSn4Ltcg1UDM5i7FUKg0Ka0oOevM8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw3oKnlonVJu9pzPhGsd92ipgyDph9PJjwtkH3zAYYvU1VN5fJ
	142UuojcpYUeZDV6xZzBLEzGbdiBT7UWBUPl1k/4v4QRZbLqJ+VHo8fPQZxDPFobDPgEaX0gu9s
	Q/V98Snph9kOhzwskafC1OnucOdDliLw=
X-Gm-Gg: Acq92OHNvQ925DCwIvfdCyNWiplqyy0OMRWgHvGkqIbBBK7xqKa5W1hUlNUzTEJaP6s
	Cbr2n4iRtlMHNKFEqwZdeZp9DFpGZEC+VDuo65aRuQ6bN8NyvmLJOdeC+/qmNzizeUbHA9J1Air
	g6yA3iFHP0KEeMrl9Dx23amiV1qMYewJ5EkqubAPIguu/6Po/eYtLhmXRcDMjTFfTVNNR+AtEn4
	auhKd3YCmhYfqV0t1xjhR56UBd/kuFc8BWBDJS3n7RYdbZOnpsU/9l4U1d6AjW0Z2LBjhquy1YV
	rTmX/2AZiN7GoXIGTwePBh+0Gl7bfHWvnA==
X-Received: by 2002:a05:6a21:6da7:b0:3b2:924a:36d9 with SMTP id
 adf61e73a8af0-3b4101848e5mr301816637.11.1780009282179; Thu, 28 May 2026
 16:01:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528151023.00f5ec4e@gandalf.local.home>
In-Reply-To: <20260528151023.00f5ec4e@gandalf.local.home>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 28 May 2026 16:01:06 -0700
X-Gm-Features: AVHnY4IKIArU2u2cgzgUd57NiMK9BDVblvRKSS0W1yjsNpD-_4-LxeiQaAAznE0
Message-ID: <CAEf4BzZh4qyPiMbpZPeVGx+HFNjBjAHTsNOx5wE7RWidM-iphA@mail.gmail.com>
Subject: Re: [PATCH v2] unwind: Add sframe_(un)register() system calls
To: Steven Rostedt <rostedt@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, bpf@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jens Remus <jremus@linux.ibm.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>, 
	Kees Cook <kees@kernel.org>, "Carlos O'Donell" <codonell@redhat.com>, Sam James <sam@gentoo.org>, 
	Dylan Hatch <dylanbhatch@google.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko <mhocko@suse.com>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 12:09=E2=80=AFPM Steven Rostedt <rostedt@kernel.org=
> wrote:
>
> From: Steven Rostedt <rostedt@goodmis.org>
>
> Add system calls to register and unregister sframes that can be used by
> dynamic linkers to tell the kernel where the sframe section is in memory
> for libraries it loads.
>
> Both system calls take a pointer to a new structure:
>
>   struct sframe_setup {
>         __u64                   sframe_start;
>         __u64                   sframe_size;
>         __u64                   text_start;
>         __u64                   text_size;
>   };
>
> and a size of the passed in structure. If the system call needs to be
> extended, then the structure could be changed and the size of that
> structure will tell the kernel that it is the new version. If the kernel
> does not recognize the structure size, it will return -EINVAL.
>
>   sframe_start - The virtual address of the sframe section
>   sframe_size  - The length of the sframe section
>   text_start   - the text section the sframe represents
>   test_size    - the length of the section
>
> If other stack tracing functionality is added, it will require a new
> system call.
>
> The unregister only needs the sframe_start and requires all the rest of
> the fields to be 0. In the future, if more can be done, then user space
> can update the other values and check the return code to see if the kerne=
l
> supports it.
>
> Also added a DEFINE_GUARD() for mmap_write_lock. There was one for
> mmap_read_lock but not for mmap_write_lock.
>
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>
> Changes since v1: https://patch.msgid.link/20260521183532.7a145c8a@gandal=
f.local.home
>
> - Use mmap_write_lock() instead of mmap_read_lock() for mutual
>   exclusiveness. (Jens Remus)
>
> - Guard mtree_insert_range() with mmap_write_lock. (Jens Remus)
>
> - Added a guard for mmap_write_lock() similar to the one for mmap_read_lo=
ck.
>
> - Have syscall prototype use structure pointer instead of void (Thomas We=
i=C3=9Fschuh)
>
> - Use __u64 instead of unsigned long for struct members (Thomas Wei=C3=9F=
schuh)
>
> - Use size_t instead of int for structure size in syscall argument.
>  (Thomas Wei=C3=9Fschuh)
>
>  arch/alpha/kernel/syscalls/syscall.tbl      |  2 +
>  arch/arm/tools/syscall.tbl                  |  2 +
>  arch/arm64/tools/syscall_32.tbl             |  2 +
>  arch/m68k/kernel/syscalls/syscall.tbl       |  2 +
>  arch/microblaze/kernel/syscalls/syscall.tbl |  2 +
>  arch/mips/kernel/syscalls/syscall_n32.tbl   |  2 +
>  arch/mips/kernel/syscalls/syscall_n64.tbl   |  2 +
>  arch/mips/kernel/syscalls/syscall_o32.tbl   |  2 +
>  arch/parisc/kernel/syscalls/syscall.tbl     |  2 +
>  arch/powerpc/kernel/syscalls/syscall.tbl    |  2 +
>  arch/s390/kernel/syscalls/syscall.tbl       |  3 +
>  arch/sh/kernel/syscalls/syscall.tbl         |  2 +
>  arch/sparc/kernel/syscalls/syscall.tbl      |  2 +
>  arch/x86/entry/syscalls/syscall_32.tbl      |  2 +
>  arch/x86/entry/syscalls/syscall_64.tbl      |  2 +
>  arch/xtensa/kernel/syscalls/syscall.tbl     |  2 +
>  include/linux/mmap_lock.h                   |  3 +
>  include/linux/syscalls.h                    |  3 +
>  include/uapi/asm-generic/unistd.h           |  7 ++-
>  include/uapi/linux/sframe.h                 | 12 ++++
>  kernel/sys_ni.c                             |  3 +
>  kernel/unwind/sframe.c                      | 69 +++++++++++++++++++--
>  scripts/syscall.tbl                         |  2 +
>  23 files changed, 126 insertions(+), 6 deletions(-)
>  create mode 100644 include/uapi/linux/sframe.h
>

[...]

>   * Architecture-specific system calls
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic=
/unistd.h
> index a627acc8fb5f..17042d7e5e87 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -863,8 +863,13 @@ __SYSCALL(__NR_listns, sys_listns)
>  #define __NR_rseq_slice_yield 471
>  __SYSCALL(__NR_rseq_slice_yield, sys_rseq_slice_yield)
>
> +#define __NR_sframe_register 472
> +__SYSCALL(__NR_sframe_register, sys_sframe_register)
> +#define __NR_sframe_unregister 473
> +__SYSCALL(__NR_sframe_unregister, sys_sframe_unregister)
> +
>  #undef __NR_syscalls
> -#define __NR_syscalls 472
> +#define __NR_syscalls 474
>
>  /*
>   * 32 bit systems traditionally used different
> diff --git a/include/uapi/linux/sframe.h b/include/uapi/linux/sframe.h
> new file mode 100644
> index 000000000000..d3c9f88b024b
> --- /dev/null
> +++ b/include/uapi/linux/sframe.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> +#ifndef _UAPI_LINUX_SFRAME_H
> +#define _UAPI_LINUX_SFRAME_H
> +
> +struct sframe_setup {

I'd add `u64 flags;` field for easier and nicer extensibility. Check
in the kernel that it is set to zero, future kernels will allow some
of the bits to be set.

And I still think that prctl() instead of a separate sframe-specific
syscall is the way to go. I see no reason for sframe-specific set of
syscalls just to set a bit of extra metadata for the entire process.
That seems to be the job of prctl().

> +       __u64                   sframe_start;
> +       __u64                   sframe_size;
> +       __u64                   text_start;
> +       __u64                   text_size;
> +};
> +

[...]

> +
> +/**
> + * sys_sframe_register - register an address for user space stacktrace w=
alking.
> + * @data: Structure of sframe data used to register the sframe section
> + * @size: The size of the given structure.
> + *
> + * This system call is used by dynamic library utilities to inform the k=
ernel
> + * of meta data that it loaded that can be used by the kernel to know ho=
w
> + * to stack walk the given text locations.
> + *
> + * Return: 0 if successful, otherwise a negative error.
> + */
> +SYSCALL_DEFINE2(sframe_register, struct sframe_setup __user *, data, siz=
e_t, size)
> +{
> +       struct sframe_setup sframe;
> +
> +       if (sizeof(sframe) !=3D size)
> +               return -EINVAL;

This seems overly aggressive. It seems like the pattern is to allow
sizes both smaller and bigger:
  - if user-provided size is smaller than what kernel knows about,
treat missing fields as zeroes
  - if user-provided size is bigger, then check that space after
fields that kernel recognizes are all zeroes.

This allows extensibility without having to change user space code all
the time. Old code will provide smaller struct without new (presumably
optional) fields, while newer code can use newer and larger struct
size, but as long as it clears extra fields old kernel will be fine
with that.

> +
> +       if (copy_from_user(&sframe, data, size))
> +               return -EFAULT;
> +
> +       return sframe_add_section(sframe.sframe_start,
> +                                 sframe.sframe_start + sframe.sframe_siz=
e,
> +                                 sframe.text_start,
> +                                 sframe.text_start + sframe.text_size);
> +}
> +

[...]
