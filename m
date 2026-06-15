Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6843D3B9949
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 22:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781563901; cv=none; b=u0llu0MESknRpsQPWjt5ARaj29mE0DL6JmYylq+eF3VVlh64ahrBbc4QKUzvcbQE3nn7fyOeEY9+XkyrUfLKoNEvD9bvhbk8nzAEG4EqzgqwkXHR/zuYnq1ZbYL4ODxJZbeaJjpRuOvlp9iNLSLzTAgPJZxCSUJn/X04mwtN2Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781563901; c=relaxed/simple;
	bh=ujAjSm7BhxUMJVslQmleewg+/DVfcJZ1Gp/kz42YP3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNPYyMpKp05rYJy+oAKwvqhLt09c6LK338qvKW6QEsRu9wmb9+4LDPm9DTk9gqHZZAodD/eiZt+oli1Q6SG/7PON2veK8PY/YJ2kP1l2uvsIPYwmJfyRHXyZv7/ijs1hoKmUQCMRsI3rrBcW3+bpZvk+l/4rQDCDMoOcYR63NpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJnI8+oY; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJnI8+oY"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490ac10e337so26525765e9.3
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 15:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781563898; x=1782168698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uaij0ssiVLSTJF7l7+mwMdVljWqS/GPd6aqJhzAQirw=;
        b=jJnI8+oYnPGKCz46aKZOuPWQYTSJIPRsolTSYqKCWQAgDyxI1SUBQmqFPHVks2+TpB
         4iXUTu4TTtWwNv9roSa/ClXgKgXKToEWTkT5BT1YsaXY0a0ggqk0Itry41UPBWBcZx0C
         j6EyCnwFF4AW2Picfnn1NUNOzYJyfPmMqXugAScEXFMIGSbi/W1/C78bkBUiTLVluXcf
         u3FhIRglS783WShkExW2P+uIZbMqLgPGCGcUvPcfBSc0F26elNnxjbXSnVXwPr7BoKts
         aM1OlsjHoXBbJqJG5ZNbuq1j4NVigLqHwX44DiwSdmYm6d8mC17tDemNvS19f5Gnx132
         n6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781563898; x=1782168698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uaij0ssiVLSTJF7l7+mwMdVljWqS/GPd6aqJhzAQirw=;
        b=hXgWXTwvLWizgAgduff2sgnLYNKShMiXn9Cua3uKfSXwDmmg5MjfLE3v7X2hbN9682
         CsMenhEsotWVyby6/JJelZAY8L4x7UZtNcG3e1hE4zkvBgigTfpH9XB7rMFg1m971R3v
         4vXpOs04wjGeNPp7ssemyywJYs4IJa1GJbFsCzQxT6RusUEm07W0YZnuV9JoMQkqgQ7X
         4Othrtsxe5/HmdC2NdsnvWtg28SmLgNbR/+gJCaAP7CAZhS+dqx7jmaze/0NITCqqQ+O
         67FesnwrnyZi1ZUYOYBzZHR0ZkWnDpVvtQjMpYSWoOdKxpBv0Vkbl+6JalAI4t12ybaU
         d6Hg==
X-Gm-Message-State: AOJu0Ywl3xnxuEiv4cY7UhA/cz/04XdnZBdtfYCtE6qKpX+e5HPZKpO2
	E9Rob+w4Z+mPuazkQSE66l+x7PSO629/Rf0en475xODA+pZMds+XEWaS
X-Gm-Gg: Acq92OGC9DsgLjSDOSZHsRl+pQrBBEt5gcxDkRGbHQFfAnhnUJJl3R+hYM7F3X51MwU
	51zrGPXCAi1RSCPZPDVxKMBGp/+DSGPwLtyCxK/hsCLJQX/uL1d2lm09VGYGryZwnWQGw4h33PH
	tDhoh+50Mh9LO2hM7oCj0/Qq5fAZQ1fwYOnsl9itVvlXYvxQifmLSh3ELsXV7pAb10JU0kOjedG
	0TqWyx9hMgVRAp8HeQsR6VQK8O8ni78yAwCkZR5qwOb81EHQlNeQsWRs5+4T7Klu8wZlSrZEjiL
	vCi1aBtcgHezXOyk01f38RBY3Qo4Ev17RT06+A6Y2LA3TAGeVr2PgJ9zODVWEYi07X8GA1LQLhi
	ndHJTaaPoD74JzPhS9ayyZQAwcWniYeGBOOCqUt8LMhHAyWZNrZydF+RSALhPW6SntnRzlIAa9L
	qW9PG+ondLyPI0x/xjemiIU7uLxH2SdIzdE+myURFxRGlqTTxO+xLexQJssXaZ5zETH15AYSOHY
	7FanO+N+qIrJgTS+YU1rDyCzw8uzUcf+TjO/gGZVBXrw2ZPP/vskvtAPaMX162V5Ek5iGrrhBZr
	RTBDa/ewtugX8jUfQ3o2hRW7Hm5VY0Hflw0ch4up1l0=
X-Received: by 2002:a05:600c:3b02:b0:492:2f3c:d0ed with SMTP id 5b1f17b1804b1-4922f3cd1a2mr28492865e9.30.1781563897718;
        Mon, 15 Jun 2026 15:51:37 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e009a0d3db09e2f2ffb.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:9a0d:3db0:9e2f:2ffb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2cd6c2sm38392917f8f.30.2026.06.15.15.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 15:51:36 -0700 (PDT)
Date: Tue, 16 Jun 2026 00:51:34 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Zhenzhong Wu <jt26wzz@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
	haoluo@google.com, jolsa@kernel.org, menglong8.dong@gmail.com,
	eddyz87@gmail.com, shung-hsi.yu@suse.com, stable@vger.kernel.org,
	mykolal@fb.com, tamird@kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.6.y v3 0/4] bpf: linked scalar precision fixes
Message-ID: <ajCB9jXBzPyaDNSQ@mail.gmail.com>
References: <cover.1781194510.git.jt26wzz@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781194510.git.jt26wzz@gmail.com>

On Mon, Jun 15, 2026 at 12:58:37AM +0800, Zhenzhong Wu wrote:
> Hi,
> 
> This v3 targets 6.6.y and changes the backport strategy based on review
> feedback on v2.

[...]

> Relevant QEMU selftest results on 6.6.y with this backport:
> 
>   verifier_scalar_ids passed all 18 subtests, including the newly
>   backported linked-scalar precision tests and the related
>   check_ids_in_regsafe tests.

The first patch in this backport series is actually breaking the
"precise: test 1" selftest from test_verifier. You can see the full
error at [1]. I haven't yet checked if it's the test or the backport
that needs to be adjusted.

1: https://github.com/shunghsiyu/libbpf/actions/runs/27575831217/job/81523786835

> 
> Thanks to Shung-Hsi Yu for reviewing v2 and suggesting the upstream
> linked-scalar precision series as the preferred backport direction.
> 
> Eduard Zingerman (4):
>   bpf: Track equal scalars history on per-instruction level
>   bpf: Remove mark_precise_scalar_ids()
>   selftests/bpf: Tests for per-insn sync_linked_regs() precision
>     tracking
>   selftests/bpf: Update comments find_equal_scalars->sync_linked_regs
> 
>  include/linux/bpf_verifier.h                  |   4 +
>  kernel/bpf/verifier.c                         | 367 +++++++++++-------
>  .../selftests/bpf/progs/verifier_scalar_ids.c | 253 ++++++++----
>  .../selftests/bpf/progs/verifier_spill_fill.c |   4 +-
>  .../bpf/progs/verifier_subprog_precision.c    |   2 +-
>  .../testing/selftests/bpf/verifier/precise.c  |   2 +-
>  6 files changed, 417 insertions(+), 215 deletions(-)
> 
> 
> base-commit: 924b4a879cbb75aef37c160b955b92f6894b11a4
> -- 
> 2.43.0
