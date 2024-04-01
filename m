Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC42A4E1D5
	for <bpf@vger.kernel.org>; Mon,  1 Apr 2024 18:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711995145; cv=none; b=FKByzD7wyT6vK8kHmMGdBcNoeq66G28H9xAbGCTGslZHbGfhgM5u5MbNP5e3RksWrYF5rB8zy5l+Q7bQYsqSo2n2XwfkJsQRB+p8ZGkMtSrMgKAln7abimT+Q9W8yDP/Io09NnaBK3GffCk2/hF4hkXbqXcqachoQgVKu5cKNGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711995145; c=relaxed/simple;
	bh=s4xNTF+xvJhC+bebmlP+9V9FDT+XrrcWoIPhexOFfpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eZCkQxkZZJaOKoBwfdsCxFJmRQzMt4Ojq8myG7dsh1HJfdFeAJIREZzqS+bGGLy9hrX7hydZmw2Hxrqq/YmH8EwMtfo0F0GoN28UybTgeh448Rs9ibJIKIz4fJKx6q49w7ud1mz8A2uZiwKAgfLrkHWfjjNl2g5JmwMayXaSX+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4PWxvp0; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4PWxvp0"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5e4613f2b56so2920738a12.1
        for <bpf@vger.kernel.org>; Mon, 01 Apr 2024 11:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711995142; x=1712599942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02cLJJfYmTbazvSA8Ot/x+RdkLBSjbvQ43u1GT3xvqg=;
        b=m4PWxvp0+1eP7lsoXEErz2cM4LzGMaUybeCgLmPxga/Zy1hY9TgjzZKNA3nEGpuL9S
         tMW8OHIGrTaxx2mua0CpxDq2K4QaWEBOwnqN6pjAUpOnLj1bs1eYVEHHqDFZiKwf1whG
         8+w4tqeOMP86u2x01tzuXzMw8lUlBzJvZk8w+qFivPguezrfoH4lDWchgGaCj+XBwLAV
         1AmISExQN2HrdxR0dCPAR7tj98wBCW+2LY0iF0pQ45lzpo4Gu06POnKKUW9tIr/pcbnj
         sCMixv1+gRxHCamIEBFTh4apEk0795yCLwLkKg2EmvbKg9RV5cN+QNgJUgqtowlKvq4I
         i0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711995142; x=1712599942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02cLJJfYmTbazvSA8Ot/x+RdkLBSjbvQ43u1GT3xvqg=;
        b=evFHlSM/seD7qPLn8bXq08CD3POrh9somjtjpdZK8nviDfHl/FvtV4KdPltaAjBPXE
         TEet6yEqe9Kg/bYojX73ezlquiySfffgzjTCBmNc5ZThKPDr/Qedf2zYCjkjcIpe9hqB
         hH2goXbqQQbdHZOwsGFG4o0WNaDbWAIGsSQyJp/ixIQUPdkHEhd86Zt4wwXramOIwa8z
         530JZm49fl/VhW3/F+bKTWhIt2KuKgyCM8p2+LfGhPZ+GKG0sa23vRRv7cXkymEAICQF
         XnU5s9j5/8/cX3F0QnbU2LSgY/AcldmfDPwqhRO/LBYvPM4q+Bc1bcDuEEhBiC4BhDZ/
         oqFg==
X-Gm-Message-State: AOJu0Yx6VXaJfOMyb74MMR2IXil2KgCmBCRGv2Co1OoLR4tOdO5wusol
	anVKYeCWdQAu8xArJHAuwJPXIws9z6J0WAXdDtIFOHs3MtjJnqP3N16YRbns0nr9qpsfF6j7CSK
	zWD3o4DZqttA62D8LwYl5ITlXoMemBDOHoyk=
X-Google-Smtp-Source: AGHT+IFWP4oRyllPgx8YLOZLezz6pQYSpoV5pVRdidwRwQRCngb7U0WW9xhLZCZaFp+AMq4Hj33oS5l7LPZm2UWR9cU=
X-Received: by 2002:a17:90b:202:b0:29c:1eb6:7347 with SMTP id
 fy2-20020a17090b020200b0029c1eb67347mr7815283pjb.6.1711995142044; Mon, 01 Apr
 2024 11:12:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4BzbCTU3P3_e-=XC5PpxBuyh=HSOOO8_r-Zbcgr2vVdZv5A@mail.gmail.com>
In-Reply-To: <CAEf4BzbCTU3P3_e-=XC5PpxBuyh=HSOOO8_r-Zbcgr2vVdZv5A@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 1 Apr 2024 11:12:09 -0700
Message-ID: <CAEf4Bzbvd6n_2-EN8RiVxa-MDsoUFLzBuY0UoO2EFvXAsjoGSg@mail.gmail.com>
Subject: Re: [ANNOUNCEMENT] libbpf v1.4.0 release
To: bpf <bpf@vger.kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 11:09=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> Libbpf v1.4.0 has been released ([0]).
>
> Another 4 months of libbpf development has passed.
>
> On libbpf's user space side, we added support for some brand new BPF
> features (BPF token, BPF arena maps, BPF cookies for raw tracepoints).
> A big chunk of changes happened around struct_ops usability (kernel
> module support) and handling backwards compatibility aspects using BPF
> CO-RE principles (see notes below for details). Libbpf is now also
> more helpful in its error messages when attempting to use BPF
> maps/programs that were not auto-loaded/auto-created.
>
> On BPF-side functionality, one major feature is support for annotating
> BPF global subprogram arguments, making global subprogs usable and
> useful in wider and more complicated scenarios. Helpfully, `__arg_ctx`
> (for marking passed-in context argument) functionality is supported
> even on old kernels that don't support `__arg_ctx` annotation
> natively, thanks to (transparent) libbpf-only type rewriting logic.
> This applies to kprobe/uprobe and perf_event programs, only. Other
> program types require kernel-side support, unfortunately. See all the
> `__arg_xxx` annotations added for full set of annotations supported.
>
> Among other BPF-side additions are BPF arena-mapped global variables
> support, significantly improving usability of BPF arena for
> fixed-sized data sets. And the `bpf_core_cast()` macro was added to
> make the usage of `bpf_rdonly_cast()` helper simpler in real programs.
> There were also important additions to make libbpf work better with
> the GCC-BPF compiler (mostly BPF CO-RE helpers).
>
> Last but not least, a bunch of important bug fixes were applied,
> making libbpf work better on Android systems, improving handling of
> corrupt ELF files and various other edge cases.
>
> Thanks to everyone contributing fixes, features, code reviews, as well
> as feature requests and bug reports!
>

And promised release notes inline:

## User space-side features and APIs

- support for BPF token throughout low-level and high-level APIs (see
also `LIBBPF_BPF_TOKEN_PATH` envvar);
- a bunch of struct_ops functionality added, mostly around handling
multi-kernel compatibility using BPF CO-RE principles and approaches:
  - support struct_ops defined in kernel modules;
  - support "flavor" suffixes (`___smth`) for struct_ops types,
allowing to define two incompatible definitions for the same target
struct_ops kernel type;
  - support disabling/enabling auto-creation of struct_ops variables (maps)=
:
    - `SEC("?.struct_ops")` and `SEC("?.struct_ops.link")` are now
supported, default to not auto-create struct_ops map;
    - `bpf_map__set_autocreate()` is now honored for struct_ops maps;
  - disabling auto-creation of struct_ops variable (map) disables
auto-loading of related BPF programs (unless they are shared between
multiple struct_ops), which means that disabling struct_ops map
creation behaves naturally w.r.t. related BPF programs and doesn't
require explicitly disabling them from auto-loading;
  - support struct_ops "shadow type" through BPF skeleton, allowing to
set/adjust custom data fields *and* also set/reset/change specific BPF
programs implementing struct_ops' callbacks;
- BPF arena map support;
- BPF cookie support for raw tracepoint BPF programs in attach APIs;
- helpful error messages added to libbpf logs when attempting to use
`struct bpf_program` or `struct bpf_map` instances there were not
loaded or created, respectively;
- `SEC("sk_skb/verdict")` support;

## BPF-side features and APIs

- support global subprog argument tagging:
  - `__arg_ctx`, `__arg_nonnull`, `__arg_nullable`, `__arg_trusted`,
and `__arg_arena` annotations added;
  - for kprobe/uprobe, and perf_event BPF program types, support
fallback logic making `__arg_ctx` work on older kernels that don't yet
support `__arg_ctx` (i.e., `arg:ctx` decl tag) annotation natively;
- `bpf_core_cast()` macro added, improving ergonomics of
`bpf_rdonly_cast()` BPF helper;
- support `__arena` tagged global variables, which are automatically
put into BPF arena map;
- `__long()` macro added for specifying 64-bit values when declaring
BTF-defined maps;
- better GCC-BPF support in BPF CO-RE macros in `bpf_core_read.h` header;

## Bug fixes

- fix `faccessat()` internal usage, breaking Android versions of libbpf;
- use `OPTS_SET()` in `bpf_xdp_query()` for better backward/forward
compatibility;
- fix inner map's `max_entries` setting logic;
- `btf_ext__raw_data()` and `btf__new_split()` APIs are added back,
they were "lost" during libbpf v1.0 release process;
- ignore DWARF sections in BPF linker sanity checks, improving
handling of some corner cases;
- fix potential NULL dereference when handling corrupted ELF files.

>   [0] https://github.com/libbpf/libbpf/releases/tag/v1.4.0
>   [1] Full Changelog: https://github.com/libbpf/libbpf/compare/v1.3.0...v=
1.4.0
>
> -- Andrii
