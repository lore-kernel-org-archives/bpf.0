Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928033D6CB4
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 08:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774342637; cv=none; b=FIRB+EC76lIFVXPe6akdCmqe8oZrFq7SdQ0t/+YUgkWYzkoXfVPP/wOqVX+GE4VkEiHyJux/vnMtMLiQVpj111O02PewLEncTMMhbWHQt24+twJumM2c0YHe9qUf0NDoSSMLzJ9zo2P+WgPJx1WSWUxafJNvdjVf8a9N/ufZQL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774342637; c=relaxed/simple;
	bh=7zBFqX7ByhUH7THOne1A2FrxDyPagzTEbZXn/LE9rsE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFAg0+GZ0ZGYma52kXtnbx4TfmcgtLOuGpguCIpMO/m4Om76TBXwjide80h+uNj1E5q5qDghtkKyAf80pDmfAKU7UGAbTuuHnB0PUG5NZwmYumzZRiM4/4BIW5OaR0K1/enymRrGAOsO3L4AIzTVgDF2rYrwfefiTBsChEYXC04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oOCZO/5g; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oOCZO/5g"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-486fb112c09so32838575e9.1
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 01:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774342634; x=1774947434; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2N8pM8rI/exlpoJn6H8Uz7b0TMfTyl2xUTL4+Iyxt4A=;
        b=oOCZO/5gucluzXtpEeCsf7fX31zKjRapIzVuC8mUmcW/w9zdVA+/IKyaDM+97QFbDF
         Jc4hsZqmldPCWgltTpS3xjoyzH+nssEpjScwHwH7fniYXBjVyHJlvngF/IsvZR7Fu0oo
         t23txzJf9wKvTmTswudfLPbLDRExU5JMredYiIlPjyn5Zj+t5kCiSVbVefUZMfDATjoS
         QSPj4Naij2cQUj5eQQEBRhVQDvhI+SKfNoXkZu8rvjOgZGu1LKdOyrZkXq3J6cNrd9ds
         0HC29iHZwUpsik521V1+eUICQd3PZ9gYNMeU9kazLONPDnUPjMpaODaIPN5d+/Kh0KE6
         t4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774342634; x=1774947434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2N8pM8rI/exlpoJn6H8Uz7b0TMfTyl2xUTL4+Iyxt4A=;
        b=IyTkuo2qOHUHzJY3JFj5sB+0vHuszC6hABWr7sAn7GFU+V8+3ylX6sceagvXi6wxMv
         QhNYY/wwVOGuox/117qnQzXSpFs92UVpAxAafy2Nl48lckmF2ALr72I05F03idQHdYUl
         8RdobMV0XRhNYZW/vEr4mxFaonbjU/+xeQtfk/UlwDEciiob/bWFS4yVinmf8ccqRkNB
         Flvt5jKkBNXkXHtMNZxWYeQoJArnQNDwdYEF39d8Bp1ChyO8ouikNLyQUtmMSav0MiYr
         vGfvJg8HTLr02q9fKYLy7YO8WKLmnKZf3ShMp4vql7CPRDUpUrW4N372aJc7RDG8bR/l
         x/bA==
X-Forwarded-Encrypted: i=1; AJvYcCXyaBFlzBPuWXLmbJxBeYSM3NoH0hH5wiOOzSqpWyrTSRU9lqK8q/txnzSu83yYLcMbWbU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe5/ffmfeQgORPn7pmICfYFrPI0UBooqJ+6XkSvSb8JnTuCdy+
	CJGdqj6nR9wGViPVffp5OrOartF3CMsPCY4dAVnBKQ/LmDH6DCqaENb6
X-Gm-Gg: ATEYQzyyCjux7IpZjkQaETDWTS7xkYr+69OmY6erpYA6obyp8UTL8Gb6nNlPJNcDyE5
	1F03+AEdLeHnp6V99aanxWfA6JQPx4i7/ftHuZ7ApVc5LtC+X6W2YZg8AtwXe/MVecCgU47XCO3
	8wePyVNuMIKOBNB27vKhTd0QeB/J12DveNoDxUSdL2BVSmvt9XOfDoSYM1TLts4BQ/v3OrLqR2Q
	IKTSzFUEJwpYF+69R62xurY97pib1C8Bdy68yDds2QvT9S7bp4FrL7I1pveF9a3q2Vv1K4J6CLy
	V41j4X6RfpZ8KSkdzPAFw+0Di5sb4WLCPGYIRr6Gcl2Ig1CeQ0AokQ5kZVnXW5kEwlSE6QcbC26
	I2bqNM6606H0Icl2v7WmKp1pDmYsLm/qZr/9F/ggvbvw/q4FCZgJDoWvmySshFOvz5wCRvr4v
X-Received: by 2002:a05:600c:4714:b0:485:3bc7:a231 with SMTP id 5b1f17b1804b1-486ff01f1d0mr218776415e9.29.1774342633627;
        Tue, 24 Mar 2026 01:57:13 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487116ee514sm43591345e9.13.2026.03.24.01.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 01:57:13 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 24 Mar 2026 09:57:11 +0100
To: Sasha Levin <sashal@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Petr Mladek <pmladek@suse.com>, Alexei Starovoitov <ast@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, David Gow <davidgow@google.com>,
	Kees Cook <kees@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Helge Deller <deller@gmx.de>,
	Randy Dunlap <rdunlap@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Juergen Gross <jgross@suse.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Petr Pavlu <petr.pavlu@suse.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-modules@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH 0/2] kallsyms: show typed function parameters in
 oops/WARN dumps
Message-ID: <acJR51EAjn-7EOPm@krava>
References: <20260323164858.1939248-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323164858.1939248-1-sashal@kernel.org>

On Mon, Mar 23, 2026 at 12:48:55PM -0400, Sasha Levin wrote:
> Building on the lineinfo series, this adds typed function parameter

hi,
could you please specify the exact tree/commit and point to the
series this patchset is based on?

thanks,
jirka


> display to oops and WARN dumps.  A build-time tool extracts parameter
> names and types from DWARF, and the kernel maps pt_regs to the calling
> convention at crash time.  When BTF is available, struct pointer
> parameters are dereferenced and their members displayed.
> 
> Example output from a WARN in a function receiving struct new_utsname *
> (kernel version info) and struct file * parameters:
> 
>  ------------[ cut here ]------------
>  WARNING: drivers/tty/sysrq.c:1209 at demo_crash+0xf/0x20 (drivers/tty/sysrq.c:1209)
>  CPU: 2 UID: 0 PID: 323 Comm: bash
>  RIP: 0010:demo_crash+0xf/0x20 (drivers/tty/sysrq.c:1209)
>  ...
>  RDI: ffffffffb8ca8d00
>  RSI: ffffa0a3c250acc0
>  ...
>  Function parameters (paraminfo_demo_crash):
>   uts      (struct new_utsname *) = 0xffffffffb8ca8d00
>    .sysname = "Linux"                        .nodename = "localhost"
>    .release = "7.0.0-rc2-00006-g3190..."     .version = "#45 SMP PRE"
>   file     (struct file *       ) = 0xffffa0a3c250acc0
>    .f_mode = (fmode_t)67993630               .f_op = (struct file_operations *)0xffffffffb7237620
>    .f_flags = (unsigned int)32769            .f_cred = (struct cred *)0xffffa0a3c2e06a80
>    .dentry = (struct dentry *)0xffffa0a3c0978cc0
>    .prev_pos = (loff_t)-1
>  Call Trace:
>   <TASK>
>   write_sysrq_trigger+0x96/0xb0 (drivers/tty/sysrq.c:1222)
>   proc_reg_write+0x54/0xa0 (fs/proc/inode.c:330)
>   vfs_write+0xc9/0x480 (fs/read_write.c:686)
>   ksys_write+0x6e/0xe0 (fs/read_write.c:738)
>   do_syscall_64+0xe2/0x570 (arch/x86/entry/syscall_64.c:62)
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f (arch/x86/entry/entry_64.S:121)
> 
> Patch 1 adds the core paraminfo infrastructure (DWARF extraction,
> kernel-side lookup, register-to-parameter mapping, ~1-2 MB overhead).
> Patch 2 adds optional BTF-based struct rendering, gated behind
> CONFIG_KALLSYMS_PARAMINFO_BTF.
> 
> Sasha Levin (2):
>   kallsyms: show function parameter info in oops/WARN dumps
>   kallsyms: add BTF-based deep parameter rendering in oops dumps
> 
>  .../admin-guide/kallsyms-lineinfo.rst         |  31 +
>  arch/x86/kernel/dumpstack.c                   |   6 +-
>  include/linux/kallsyms.h                      |   9 +
>  init/Kconfig                                  |  40 ++
>  kernel/Makefile                               |   1 +
>  kernel/kallsyms.c                             | 182 ++++++
>  kernel/kallsyms_internal.h                    |   6 +
>  kernel/kallsyms_paraminfo_btf.c               | 199 ++++++
>  lib/Kconfig.debug                             |  11 +
>  lib/tests/Makefile                            |   3 +
>  lib/tests/paraminfo_kunit.c                   | 249 ++++++++
>  scripts/Makefile                              |   3 +
>  scripts/empty_paraminfo.S                     |  18 +
>  scripts/gen_paraminfo.c                       | 597 ++++++++++++++++++
>  scripts/link-vmlinux.sh                       |  44 +-
>  15 files changed, 1393 insertions(+), 6 deletions(-)
>  create mode 100644 kernel/kallsyms_paraminfo_btf.c
>  create mode 100644 lib/tests/paraminfo_kunit.c
>  create mode 100644 scripts/empty_paraminfo.S
>  create mode 100644 scripts/gen_paraminfo.c
> 
> --
> 2.51.0
> 
> 
