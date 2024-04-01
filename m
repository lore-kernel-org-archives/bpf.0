Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A17D481C6
	for <bpf@vger.kernel.org>; Mon,  1 Apr 2024 18:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711994994; cv=none; b=qgw3Lr0z57fU3jRGt7mOfzXBS6EN1A0DDPLhvHPGO3BwapCtXvCmaO2OzWTPuuaXYkExqyahLZxGKozuw1A/JDZzgXnwe2FBZfiqTtUD4RhE9D9lphCcXtxJX5tbLKQAmJV0nEvl/pWh8bVIK3E4q+L9Ds7XupU+UrfpgYhX1Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711994994; c=relaxed/simple;
	bh=sUv9O7ogw4qYy9tW771956WxkF0D/7y1pi3fvhY1X9g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=lRoO5P9xDv7SIX8ct4W/OVCGdOCYYWPWkSEoWIkpsQkcP1RVjPerISrqr0YckL7S2hXgbYn7KUmZD5ow3n1KGbWOcxLL4YXbo3I3FhQei7bPF4eeLOGD2H/zUGvQFpwAB7K4fmcELIhGE8Iy0m4sSzlzXjbDRPgy18ktRpOQZbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAwZi3Hg; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAwZi3Hg"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso2185724a12.3
        for <bpf@vger.kernel.org>; Mon, 01 Apr 2024 11:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711994992; x=1712599792; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=25GBM2zkBDJ8jH8EwS/Cd12ef3RKk8estQ+2dJHXeTk=;
        b=GAwZi3Hg2L9o3hfaRragdyPX4AsRnlW0lkKIzXWzvmGQtJekDDkS/BQDgkM3vaA9IB
         sbdfaPHWnLpLy9WCYODxzCvM+hs8N4tOuaOIojX8SDT1uDugB/i59H/QewikVqYWm0Vn
         PTviDNXNbvUTLlBEcMhyAuhTs0BQoVXyR6NfPx+2ycrmrUmUkDbp/fTXHDfnOIVVhUhm
         rLo3GpW1CzYhK4TsDdTNBQdU35O3t214yivRLFf2gp2zOs2YrxL7VnqNoM/NBMhmM6Vf
         RipHPIcGltWKxCFww4D3/6GRG3qTwlJ8VoAHUoMHZgEkjSuURZxiBgRhkokREZJGgNrV
         NVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711994992; x=1712599792;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=25GBM2zkBDJ8jH8EwS/Cd12ef3RKk8estQ+2dJHXeTk=;
        b=Un4D55ZVy2rkCMmDQ2R9Wng8ERLkscfy06ijJ6CgpNarotX9ZmkCXadEl4c3peTZHs
         4LS36EB/RUorlOcDogd7ai15cwbpjfewIo2+uhvhYDGPTAilcTFHJKo4js1b185F0lZd
         bI67GKos25FkafHI1Q6ga6Kt3TJFtadqnzI0Gnmdrniod03LUPrusYp225rel9Vypbkx
         ETzAz4cQQm0pMIkD2Iu8j/xpylZfIMiROkGcYHAP3Fv3/kFajV9nb8AZC0b8a0jEQDB7
         vUv373Fn61TLR/NZl0QV2ErLSsxVUR+TyQS4Ss2sxZIXCMu8kenxmrC1oVvjx5ixn5lC
         tveA==
X-Gm-Message-State: AOJu0YzGtzaXZcdbe4Ftp/Dp90wJZ12ZHdoZdsBmwQL1BxRXt2llDfA4
	MVqtcDUoGvKg8LFfz3U+vNqWEVTZ5tjP/rtiZ3dbz8XaNKtwx52Qo4cBpee9pwcalrnSHmVTc+h
	RE2bltRO0wpdlQPg6n6nMFsrdH5QE/W9p
X-Google-Smtp-Source: AGHT+IHk6ijMlDdCTKyuejBQWj8EVkf+5d0bTkDfghId3ImEDDf32T9EGOotzrMYVi5Fu18HLibS+5G40uzTLkG+ULA=
X-Received: by 2002:a17:90a:4593:b0:2a0:4fe5:e4f3 with SMTP id
 v19-20020a17090a459300b002a04fe5e4f3mr7505061pjg.2.1711994991710; Mon, 01 Apr
 2024 11:09:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 1 Apr 2024 11:09:39 -0700
Message-ID: <CAEf4BzbCTU3P3_e-=XC5PpxBuyh=HSOOO8_r-Zbcgr2vVdZv5A@mail.gmail.com>
Subject: [ANNOUNCEMENT] libbpf v1.4.0 release
To: bpf <bpf@vger.kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Libbpf v1.4.0 has been released ([0]).

Another 4 months of libbpf development has passed.

On libbpf's user space side, we added support for some brand new BPF
features (BPF token, BPF arena maps, BPF cookies for raw tracepoints).
A big chunk of changes happened around struct_ops usability (kernel
module support) and handling backwards compatibility aspects using BPF
CO-RE principles (see notes below for details). Libbpf is now also
more helpful in its error messages when attempting to use BPF
maps/programs that were not auto-loaded/auto-created.

On BPF-side functionality, one major feature is support for annotating
BPF global subprogram arguments, making global subprogs usable and
useful in wider and more complicated scenarios. Helpfully, `__arg_ctx`
(for marking passed-in context argument) functionality is supported
even on old kernels that don't support `__arg_ctx` annotation
natively, thanks to (transparent) libbpf-only type rewriting logic.
This applies to kprobe/uprobe and perf_event programs, only. Other
program types require kernel-side support, unfortunately. See all the
`__arg_xxx` annotations added for full set of annotations supported.

Among other BPF-side additions are BPF arena-mapped global variables
support, significantly improving usability of BPF arena for
fixed-sized data sets. And the `bpf_core_cast()` macro was added to
make the usage of `bpf_rdonly_cast()` helper simpler in real programs.
There were also important additions to make libbpf work better with
the GCC-BPF compiler (mostly BPF CO-RE helpers).

Last but not least, a bunch of important bug fixes were applied,
making libbpf work better on Android systems, improving handling of
corrupt ELF files and various other edge cases.

Thanks to everyone contributing fixes, features, code reviews, as well
as feature requests and bug reports!

  [0] https://github.com/libbpf/libbpf/releases/tag/v1.4.0
  [1] Full Changelog: https://github.com/libbpf/libbpf/compare/v1.3.0...v1.4.0

-- Andrii
