Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F042F851
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 23:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776035821; cv=pass; b=kih5GuuSbqVDE4ApLXnwOH7w4NLUjHY7yoNxHA4sgJQMo9PuIKKJIBeeMKSC934i9V1nzyj0Q+DRp6L+mxmzY+dT1J6RbQdKCdA8acPx+Pg39OR2OkDAhulZokW9ugnG0xG4f+WTd7wWAjyTp11ATSydXPCP+FkwFXArB3J9AlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776035821; c=relaxed/simple;
	bh=bZSzwtjkGedP+pp4l8agHmh78WZOpJ34XOIrTmWhOQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oAVTo5KBL4LYvUnZgYZBr6FhIwuemUjbWyMuqHu7I9rjPJyTwRF2Utzlx7nUaTThdOuFsjAVU+AYC0xMTQOk4sflbx4GKMjIi/gMtkfKJ51D5BAwjN3j7zK4S2yhjP7wYBfzFY6XBzAII8zk8kDwWAlvPs9PPq0itef8jaO4e9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcFOx/yT; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcFOx/yT"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d74086e5bso533468f8f.0
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 16:16:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776035818; cv=none;
        d=google.com; s=arc-20240605;
        b=lTK+CbaiFLg+CU3q46uxoVJ6jBUswBG1dteXvP6yfjhaGLh/sF6kbwHRDLTtgQWGmr
         X4ibAMpESDGLUHNi0S2QTAQwY4MkJdKLg0YSm9RM13WvwexURENvyevuwjc1wAZMkXw4
         XP6P6Ho7dqMCn6XcE/yYWFIc4JlAEL/ndOAuBPg5MxxRvtxvz3CEozGkiRwcN1JoCjrh
         UwrDunOYug+afwpTaPSlYeLJg4c9hKtex6idn3nAn5G9c2mOTUnSEIEvD6wxPoG9wfMJ
         kOhgAhJWEIFyhikVRrxpPsmasiqDGaEs/A+WlIyqfSf0R3yd7AiNw7R4ffpnucIVXNKS
         a/Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6qdSBxH0eTYbSEHmjzdVFHo4E3qWo4kk0GIxyh4ZtTE=;
        fh=AoyNRaktsZ7bW/hTwiP8Dm5frmwh/+vEg7lx+EPGuMM=;
        b=KZDunzyeEiDquJ6u9R/tuFJwnWEAOOWGxVMv8FDhLqk9KsdXEG9esdXC4v16Rec0PC
         3i+3tD4Iuk+H/+vx1djU3h8f921euPGPePNVpKW1ffqvZ1YHCUXfDk4pbYV5VHAjeHvW
         +b1ngmD2PFcPAvmQd62qp47NajH0xmK9UwOCIvy9lcZNU8TjDqFIUlOvXFwMQUeknCiv
         us3m4V5w+7bgYjYbCtRJIu6ULDe4J7vS9rQmRHP7QjE1mZAlP6xlSIfQMgMtukQ0z0YD
         5I22p49/3MlSzobQXLnsFKIv07ksq8qcS7g50w2QzsW9zIenoWui2W8Ob3zJDkd+y3YE
         VH8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776035818; x=1776640618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qdSBxH0eTYbSEHmjzdVFHo4E3qWo4kk0GIxyh4ZtTE=;
        b=EcFOx/yTW1kSr+NOr4my9yvDEihcuXzXW5nx7ctVKepCaOyW+DKrIjxJLUF2If5+OQ
         Un0tPotTvgNq97Dwxwt6vDUvWw+bia1LgKD5CwMFQNzGBR0PDCIcNZiHA2x4FZmgdVW4
         r/4LI1I1y3N6HD64W6nYImHlIIZuh8Koc340toeqiZ2Q0OVRNop9QEzfGKlg6rDwyaru
         wBmrRiuh0sYMWVk1lBTfhiHdv+LVnmEfWJeym0Ip8g91JNXFjFJp1Sckj+uGYxIDZly8
         KJlvOT0CE0HPvDBpcfqmca1NaXhRDe3u3wQ9lC+bJfaAolsXqOScpP7IU39w7xnnS3pd
         VQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776035818; x=1776640618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6qdSBxH0eTYbSEHmjzdVFHo4E3qWo4kk0GIxyh4ZtTE=;
        b=omrcMLbxDPaFU9jDQ66IlZmt6eT4Gw2yqmI5HkiHoMl9mXmQwlPHLHF8iPGdxAAAY6
         L4p94r9w3sMqMnENy1E+r6p10UTNR/wt1kmuRmMTFU0QihkcU77qZeJflT/5WB9KbfNS
         M4e2YqnZ4y46IUiWo+3ZVQuMOBkMARP6dGEmRL4o6QUNkTGxsXRTHzueCX1FeB1tXJAZ
         4NGy2j0u5kc66t69NmY78v24iEwDImszeoKdJUD5GmC3WXj9RDnRVg9Y4FFgGlNwVS2M
         /fTcqtxWh3lgLLK+LhlJ2PkC/jyrKmeHeYtMLO0KEHHDoJ0b8Y/peGVFSMmCUhDIY3JR
         y8VQ==
X-Gm-Message-State: AOJu0YwnHn9KmE9gblvR+EDgP9cDzDaCXbzfv/yPSH5mWSL6Oz75zSuf
	4ss5Z28kSKXYOzLqBetSR0YGrl8GeImv0GDIkYzyWySOOi8sXOwWF/ciOTa4TlJOb2vJETXxMnc
	8YsVUoAPZpzoV7zC273M743nfzy6ebO0=
X-Gm-Gg: AeBDieuSyblVXXur3l05ThZ9YIWN5P0CVs7sHM8v0b8LRD6MAM+YgNR0AA5qmMmhfUy
	G7m2WHk/RPvgRNv0MyTfcQ9g6YGZV1EoiWaYeFWAap00CLdoqFzvPuifxJ15/orVXOatBPJ2hCQ
	B4KPU6f6DRtwS/E4CjthC7YvUy1/6rAKkjwLTvIEtE3tiDU3plfsDR69QAuQaf8qcI1DNZsFc4i
	nTyFUC1/E9s4wCUA+fv6zZuPtz6758CF7Ih33UreNPgsN/y0kf2n61SPZPN8RTbOR5W+zenGE8i
	2jdQGeID1qDsBT2uc4Jt1E7Maqks/+a8X6UIuF9IBOTsVPJIngXqZe8fd94w15z8AfOfgTcX9iH
	T0tJGeo7EoL+/NLM8KJS8BfAKeQ==
X-Received: by 2002:a5d:5d0b:0:b0:43d:70e5:bfa9 with SMTP id
 ffacd0b85a97d-43d70e5c016mr5609330f8f.48.1776035818347; Sun, 12 Apr 2026
 16:16:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com> <20260408-rhash-v2-12-3b3675da1f6e@meta.com>
In-Reply-To: <20260408-rhash-v2-12-3b3675da1f6e@meta.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 12 Apr 2026 16:16:47 -0700
X-Gm-Features: AQROBzDWpENZhx-b0RSj4gRM_i21wM1wad3ZjUEBBKeKacp2_vQDSYq_3BEJ3Rc
Message-ID: <CAADnVQKgaA7rT50XCpsNAqmPNRNzZQ673-NWJhQZQvQ6JHkWvA@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v2 12/18] selftests/bpf: Add basic tests for
 resizable hash map
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 8:10=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Test basic map operations (lookup, update, delete) for
> BPF_MAP_TYPE_RHASH including boundary conditions like duplicate
> key insertion and deletion of nonexistent keys.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/rhash.c |  64 +++++++
>  tools/testing/selftests/bpf/progs/rhash.c      | 242 +++++++++++++++++++=
++++++
>  2 files changed, 306 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/rhash.c b/tools/testi=
ng/selftests/bpf/prog_tests/rhash.c
> new file mode 100644
> index 000000000000..40f30ce69190
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/rhash.c
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */

year what?
