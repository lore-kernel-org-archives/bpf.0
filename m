Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E783DA7E3
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 09:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781516405; cv=none; b=NLgrzK+G8pw5+5p1txMHjWBjmpa82pjvl2apJnC+6IyI7eBLlxOS8WzdTPEM/ZB39rWY0dJE0YCM32hofKk0KVGKCIMfFC/ReRl6Zap50Bt6JQVB+UPpRQPdLBbC9wONZsYKLFuSRIlkmZQTYLYX0y7nVXwb7HBVXUUbiLAAGHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781516405; c=relaxed/simple;
	bh=yuZOjeKUQvuOh9Mb8jFUvO3r6PfArjCEIg/DDAG8xb4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=Lvj7CEIbvk/3qk+MxpqRe92bWOfuZe1nwh9PjCtq/O6BOMKV/A+D3QcdBYrKX4b8Trncxoklx5+iGnoTwREaxLGfmQCW/wUX+p6Rma5KtRha7qOjs2luxJa2WO0qYpAyBN9kBpkTJmSkYHD1l7FLi4ymdfMDqptxtpcRmiU9HOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UyNbsDRQ; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyNbsDRQ"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-490b3e03939so23109605e9.1
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 02:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781516403; x=1782121203; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30D3lk2m4MPe1WlWUP+Xy2TkeorO71aGo8DIuGzIXbw=;
        b=UyNbsDRQ1oPgXaifIFyAikgrMXaHTPWofKkeVM0347UeQRKl62NelmEkUC5BnBmJ8u
         NU8DhSuItVrj7dKhwKefywPKAT/IoEE9G3lv02H/7aTMzw3tnqz747oC+CtcljoTNGCh
         444TF/pSG8G6pJN19nmVxqCUjzAGatsImBduwH2LEU9o+kEU46mx1fuaiq7yxuX5WfNH
         RxSq1Ms9MFSfl7UgPiOsLbEcIG3+EhLnVkMLcHVnEng2vfcbODWESzcJHVbJcUbtc+ZX
         CTvg4Fgo/n2BpN2VfUiZH2mzr30CvKsc172Khn8hWC/BZQoh4x+QGvoQ+0HUEmqnNiSa
         xJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781516403; x=1782121203;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=30D3lk2m4MPe1WlWUP+Xy2TkeorO71aGo8DIuGzIXbw=;
        b=LX3OlNav7D+MSxzBWtTND0jhErMlIwYnMlHGOqIcYzyAVWhZy0m/N9GCJfwQxJXILq
         f56GFpPfzbweH3UUyNhYi4lvASoHxftpVwrqzf9szp7BGkS0W7LVQqLWwqQr8yUYY8My
         keAuBMsiftWM3U+AE6rnnYwhUzkdv33W7iQV3d5ul/cDmK9HYjgZbFWzyczJjtjNxo1S
         PmCNg3pvwyB4dnlYXr2j6ey+dq+Z3gaEha+R+M9tOdqlvk668anv6fDflZTQIX7cTd0W
         MTe6q9iSUt8t3xXjOIh/0k287qpeANGKpzuegMBvVi6/lppsRFZXUvhsTr836iI5e73U
         anqA==
X-Forwarded-Encrypted: i=1; AFNElJ+Gqw3rnt/hGI+SUo3l5r6g/kNaiK7cQu5cFfYvmhp3W0sCyPV+U5F+K1UXnbUevbwPOQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDTsHqQ4Bn0GS4K9qTAMJrbXEHBdJyDWmqYIg7U8zjW0PPSS44
	d8IsXL6sOVHbXyKKvLtUyNiVe0uZ12w9HhtIT55RMxB3k2iYjAfXGLh8
X-Gm-Gg: Acq92OFwmZxHzMgPQx4q+p74qjUCdhUEvKmHXaMquQWPp3vFS1NkIL7OpHfLSCDgzrv
	jOidN+jzQ4E1y5xrGSVqhhD/l3KVKOAvlFb3ByaTQE5fqX6xDgSo70ux79UpfACnydLqyLee6zJ
	KO6gr15dc6w5GMA42obijbhULiyUebyyOGrQJjuaixTHb/JZKIRkPLa/eE7/GL6D/9UOAUTePit
	aLQO4x12SH62k8g5uJkBJBzvTeRFOpdWvQIH0sxAbOs3fNh5RZNUMHJEtRGrtAUnDahF/D4C1XP
	yx9xXvveI62JgAkYbJWImece8KkUqHGpibZz0O3QhJO19pM1sIzDDBi5tvfq4n4t2N3rZ+TjGab
	ej1w7O/0OsxxeVj1PuCWiQuB2cm47F32wL7nQIMkpfBrLbH9eHhlahDfl6K6mKLFo+sk2fx1U0Q
	5PkwtBd1pTn1uph2kHTXClKFUGOekPU55rsgJfU3DSZbg9GFOaHtmkgfIzlKZtt7U5Ftz4GHmML
	nzfXEPbPK8nTeUzA3J+hgHS9U7t1HIAU8tXa1IbRtrs7PYl/BkyGMXzOsqZmWU6wQ==
X-Received: by 2002:a05:600c:8b2a:b0:490:4b89:5372 with SMTP id 5b1f17b1804b1-490ec50a338mr160503935e9.11.1781516402495;
        Mon, 15 Jun 2026 02:40:02 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49220304180sm233055375e9.4.2026.06.15.02.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 02:40:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jun 2026 11:40:01 +0200
Message-Id: <DJ9IUWKK7EFS.XXLT3ZAGOPC4@gmail.com>
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Nuoqi Gui" <gnq25@mails.tsinghua.edu.cn>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "Shuah Khan" <shuah@kernel.org>,
 <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf 0/2] bpf: Preserve rdonly_cast dynptr slice lifetime
X-Mailer: aerc 0.21.0
References: <20260615-f01-09-rdonly-cast-dynptr-lifetime-v1-0-2dd0a369e153@mails.tsinghua.edu.cn>
In-Reply-To: <20260615-f01-09-rdonly-cast-dynptr-lifetime-v1-0-2dd0a369e153@mails.tsinghua.edu.cn>

On Mon Jun 15, 2026 at 10:57 AM CEST, Nuoqi Gui wrote:
> bpf_rdonly_cast() is an identity operation at runtime, but the verifier
> currently assigns the result fresh return-state metadata. When the source
> pointer comes from bpf_dynptr_slice(), that drops the relationship needed
> to invalidate the alias when the dynptr is released.
>
> Preserve the dynptr-slice lifetime metadata across bpf_rdonly_cast(), and
> add verifier selftests covering cases where a dynptr slice is cast and th=
en
> read after the dynptr is released or after the originating dynptr stack s=
lot is
> overwritten while a clone still holds the reference. Also cover the valid=
 clone
> case where the cast alias is derived from the clone and remains usable af=
ter
> the original dynptr is overwritten.
>
> This fixes regressions introduced by 66e3a13e7c2c ("bpf: Add
> bpf_dynptr_slice and bpf_dynptr_slice_rdwr") and a35b9af4ec2c ("bpf: Add =
a
> kfunc for generic type cast").
>
> Impact is bounded to verifier lifetime tracking for CAP-required BPF
> programs. The evidence confirms stale read acceptance after dynptr releas=
e,
> including a typed field-read shape, but does not demonstrate unprivileged
> reachability, cross-context disclosure, controlled reuse, arbitrary kerne=
l
> read, write-capable aliasing, privilege escalation, crash, or KASAN/UAF
> signal. No CVE, embargo, or security escalation is claimed.
>
> Validation:
> - The new dynptr_fail.c subtests exercise the verifier's dynptr-slice
>   lifetime invariant across bpf_rdonly_cast(): a cast alias of a
>   bpf_dynptr_slice() result must be invalidated when the dynptr is releas=
ed or
>   its stack slot overwritten, while a cast alias derived from a surviving=
 clone
>   must stay usable.

Won't fix. The semantics of bpf_rdonly_cast() do not require soruce provena=
nce
tracking, and thus don't need any invalidation. It can take any unknown val=
ue
and produces safe to read pointer. Please try to reason about whether it's =
a
real issue before posting AI's output directly.

pw-bot: cr

> - Unpatched bpf at 76f62d237538: test_progs -t dynptr FAILs as expected,
>   because the four __failure subtests
>   (dynptr_rdonly_cast_{,typed_}slice_after_{release,overwrite}) are wrong=
ly
>   accepted - the stale read survives dynptr release.
> - Patched with this series: test_progs -t dynptr PASSes, because those fo=
ur
>   casts are now rejected with "invalid mem access 'scalar'" and the two
>   __success clone subtests remain accepted (all six dynptr_rdonly_cast_*
>   subtests OK, rc 0).
>
> Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
> ---
> Nuoqi Gui (2):
>       bpf: Preserve dynptr slice lifetime across rdonly_cast
>       selftests/bpf: Cover rdonly_cast dynptr slice lifetime
>
>  include/linux/bpf_verifier.h                    |   5 +
>  kernel/bpf/verifier.c                           |  36 ++++--
>  tools/testing/selftests/bpf/progs/dynptr_fail.c | 160 ++++++++++++++++++=
++++++
>  3 files changed, 193 insertions(+), 8 deletions(-)
> ---
> base-commit: 76f62d237538b456354a44e796a541cde03c6e28
> change-id: 20260615-f01-09-rdonly-cast-dynptr-lifetime-de114e5a1838
>
> Best regards,
> --
> Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

