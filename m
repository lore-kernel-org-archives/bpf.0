Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A89337BAB
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 18:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775846389; cv=none; b=D5/8FK0LmvZxx+4c4dEnVsghK2kPO0kBXOeSM7ktRkQMJeBLtXy3UsRp4mlkSBLNtPRUian3VgZCYFsgVWsBXafaJiDUmL1moobF0kaJg+pMKhBb09gRPd++sZnxydEleTWxLyJfSQqlZfh8qvAFj8UGggnsIrHFOr/DKSCBOh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775846389; c=relaxed/simple;
	bh=QhgAwrI4LHb7G6o5+lOwbBbIaHkOzBcYawY1cQWJMiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xtt20NnyKSgg7dRJL9aSCdLi3MFfqeYxLTa+I7hmWDTsxQQnChPG5kG+sWa2eMBKxxBZNa0592zyq0e/gKe2ofvYYQ33b+hhBvLI5nZKaiMyG95KqR23SkoCkdKyCUlJ6w/MJiDEgxV5FAGjRe/30GVoNn6B54Mxp5nWLwAB/VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJy4E/ZT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJy4E/ZT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B913AC2BCAF
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 18:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775846388;
	bh=QhgAwrI4LHb7G6o5+lOwbBbIaHkOzBcYawY1cQWJMiM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RJy4E/ZTai97k/6l+w1ZhtFXuLLehZMImBO/SCjUOVwJAcaA2Tb/FFIj15Ndw8heU
	 SRXU9zUXYXae6Oi+FJXfv/UUy2EjUIL9SJsCY8TjHVrsQJ6mYu4TRPL6j22UxlN52R
	 QeFgRR0gqkuFWhdtgT5L+/ghL7iyz2Gih/x64VWNRHMw2/hAp+OqsHbnnuoChxeskw
	 JijCAIOnV+iZPnreY4W1Zz3g1YKT+Gm6KRrd7bfYqJTk4SbUTJe4CCUNfvCplM/JRe
	 L5GH9+bDpOD6gokCTMVwMeiqCZ8cBrSITV8JOlg7w5Du0pVvpzNLpiLglVRIl1sJcI
	 kYP4DaGVLlvog==
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8a151012558so28010406d6.3
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 11:39:48 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw+cN/IZcwj1swsPVqvJ9HVil7F2F642MIkDcVsbtZ726rls1YU
	GVmzGvxuOM1Ukll6GMOylnIrZ0jKsxX4UA98zxAC3mx2XdMEcMajaEHOfdr3/E9alChi9nwesss
	ZMmrqVqa8sMCuFrKVVEb1+EDTCPrxmQM=
X-Received: by 2002:a05:6214:29c4:b0:8a4:8b2c:428f with SMTP id
 6a1803df08f44-8ac86156589mr67288456d6.2.1775846387882; Fri, 10 Apr 2026
 11:39:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410163041.8063-1-emil@etsalapatis.com> <20260410163041.8063-6-emil@etsalapatis.com>
In-Reply-To: <20260410163041.8063-6-emil@etsalapatis.com>
From: Song Liu <song@kernel.org>
Date: Fri, 10 Apr 2026 11:39:35 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6f58hx-2AW+X9kwT0oOsRZHW1RA7meWnMjuniJNoMgow@mail.gmail.com>
X-Gm-Features: AQROBzBo8iM372FioWMUAwgs21tSkFv4_IqvP4RijPMhm3t4IfwofISfeLSGRvY
Message-ID: <CAPhsuW6f58hx-2AW+X9kwT0oOsRZHW1RA7meWnMjuniJNoMgow@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 5/9] selftests/bpf: Add basic libarena scaffolding
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, memxor@gmail.com, 
	daniel@iogearbox.net, eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 9:31=E2=80=AFAM Emil Tsalapatis <emil@etsalapatis.c=
om> wrote:
[...]
> diff --git a/tools/testing/selftests/bpf/libarena/include/common.h b/tool=
s/testing/selftests/bpf/libarena/include/common.h
> new file mode 100644
> index 000000000000..5acf9b994943
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/include/common.h
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +#pragma once
> +
> +#ifdef __BPF__
> +
> +#include <vmlinux.h>
> +
> +#include "bpf_experimental.h"

bpf_experimental.h is not needed here.

> +#include "bpf_arena_common.h"
> +#include "bpf_arena_spin_lock.h"

These two headers are indeed needed. However, what's the plan
with them? They are not part of libarena at the moment. How should
we include them in the future?

Thanks,
Song

> +#include <asm-generic/errno.h>
> +
> +#ifndef __BPF_FEATURE_ADDR_SPACE_CAST
> +#error "Arena allocators require bpf_addr_space_cast feature"
> +#endif
> +
[...]
