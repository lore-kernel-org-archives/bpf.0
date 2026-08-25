Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A30470122;
	Tue, 25 Aug 2026 13:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787663802; cv=none; b=JW4omH45mv/8sLdClQAAuAT3Cqzc/K4hhuddfkmh2mYWDN3jUfLTOCJnCCyP6gF50T349YsriIaXvldSCh/mmUOK6UsuU1Wtly0uAamh5lRt+auGlHzPP0Sq8zpQ/zTHl7jSuGzcIB3/00Mp8cVyBKX6dE2Yv2duPdSkcBb63jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787663802; c=relaxed/simple;
	bh=nXaAjmZXz4Q8WOSTCgDCzj0qznFmSUJ5te3Hxv/34OE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sQtMzFk98/4EvTgdF9HB6qOO/bXZvtRDVX4coac3i1cBshG1FSJjQK5zt8/46XxvZ6WGOfncYdjp5GXgEYexmlz1GgB9B2z1K69kvW7/9l9aTWNHXalrwhAlf8tuXstYOzDngLk+Zv1FORojwF24a6ppREwj/OOdXdsX5zQlYMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4kAZzFE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4kAZzFE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79AA1F00A3A;
	Tue, 25 Aug 2026 13:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787663801;
	bh=VwATnANXbcLF+RuGQE5pHvL6SYNDXCMexh01FqPSPsM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=W4kAZzFEg8RkiZf7wEIeiOrOmda2BSn6E2xZTDNeGWK/yR3mwFM70EUJQYNGb3M70
	 M8IFjTydpJIeOuRoEJpnSO/TS/nalmikigUGrTcuSsdcmOl46ZUn1cGFWKwNZJ5rv6
	 u/LzTyd1gs1MgSti9JQ6KTi/D3hQ24UMIJWnGHjjvEx0MCxqfEwfJu52yaT8LLDkpO
	 8jAYzvf0kVIt62p9+YBmcqv2nQEZRQAGuYxRdU1p9N4oLH99hpF78izUlQsro3wr4G
	 QN7u7DPupReNbsoYsT+9BddbnOEWoLqvRg5UyN09x+w1tC3+eYhDPoQ+W6KQjyoWPM
	 QQypLxFQ3+V/A==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Chen Pei <cp0613@linux.alibaba.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com,
 puranjay@kernel.org
Cc: ihor.solodrai@linux.dev, eddyz87@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, pulehui@huawei.com, pjw@kernel.org,
 palmer@dabbelt.com, shuah@kernel.org, guoren@kernel.org,
 bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 0/2] bpf, riscv: Add support for signed
 arena loads
In-Reply-To: <cover.1787140923.git.cp0613@linux.alibaba.com>
References: <cover.1787140923.git.cp0613@linux.alibaba.com>
Date: Tue, 25 Aug 2026 15:16:37 +0200
Message-ID: <87se42tk5m.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Chen Pei <cp0613@linux.alibaba.com> writes:

> Chen Pei (2):
>   bpf, riscv: Add support for signed arena loads
>   selftests/bpf: Enable arena LDSX tests for riscv64
>
>  arch/riscv/net/bpf_jit_comp64.c                 | 16 ++++++++++------
>  .../testing/selftests/bpf/progs/verifier_ldsx.c | 17 +++++++++++++++++
>  2 files changed, 27 insertions(+), 6 deletions(-)


Back from summer vacation! Apologies for the delay!

For the series:

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
