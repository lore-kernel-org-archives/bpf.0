Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792808634;
	b=Qr9JIF7kPEk8Cwef8pZ0Ebt/xnrZhx04yKXIcJLqT/v0vciViFQWmSO5x6pkNJ4kODBb
	 4dPq+4D3SqsjZ+ldRY/ArPc6nohCrp88XAwzSF6VKstYYjG+NACaSUkngArXAN5cL5Yz5
	 DOzKV2YXr++Ompungs4B8w4ni6O4biObfGcPHYNERoGciGfdk35HlcJA3W7MHVHGAnRYD
	 9WU8CUKFeVIHTLhk14fzRMVy56wkvYCIj0SjRpkOesXK/sf/LydbfnflrI/wTYQ7FONrd
	 kwiudMbMnHV0HNQYGztgmkV7r6mDgAXtrG2Hm9X8mJQpSeNnAGMenMV6OTAJHB4FHGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792808634;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=yr2jFPpadHaHHD7vYesdiqqqKONanhpygp3V4COPFzg=;
	b=P/jEG+eolYgg4rHziH3lVfkgy3NhuryYhfYXiKe7svciEgeR+E6QUb4kdzHWg6D7Gd3t
	 4tNQ9L3FFD7GSWsOwCzQ8rrAwlEb1ZwF83npBK9KoNB2fk2tWZIJoNMy05swyMDQ3GMoT
	 vBtTyKZWyP5uagOTX2nceB9w3jLz5CT0oqiq6bTogcvjgI6qM93SeQeB4DT1qaVIC5Se/
	 FELcsErWRidWbe4puNb1AEykksEwSkeqWDrkMVyK8U0hmZo5MVEphUTQYlTqxvGs2yRdl
	 QAIvq+xbYcfrSVqOdLINTsp+ND7vpg8LF3ZrKUaRndg5UuD9Smr8w4jqxUZFkKSbJrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F0jaGOnY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B11606A31B
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 02:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F0jaGOnY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C8A1F01828;
	Sat, 24 Oct 2026 02:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792808634;
	bh=yr2jFPpadHaHHD7vYesdiqqqKONanhpygp3V4COPFzg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=F0jaGOnYId3jzqG4YpszddDtfE/D9Snq30weTBA8D39pYATEtDvvEnURHUk8caMNC
	 LHgqB4wr7F0lJqcaIXS9M1DjbQELNi86wxSCU4r7TtPDgcJYRcuYFotZGfNtfZ+P3+
	 plVhjhseHPJjAKnYIN+7t/3tUxBtdouXX83rcSJtDd/RE/SQKH93ZoIRGXPJq0LibC
	 A3UXe3QMO32e3w90SK6ITbh5mBCMLmW5kxBLxLjVryWOK9S9zwZjubb6CQEWwBIXnn
	 07QoyjhY0IMCBdt0BoauB75XDo50s8Cw6U4YySs4vKQLC2B7iZYG5VulPgXVr0XN+L
	 7MF/rtGRk5ELA==
Content-Type: multipart/mixed; boundary="===============7960461725624875402=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <8413db5b8b4723123f31049a33844a31b5e73d39b104192c4196a71e3045ddde@mail.kernel.org>
In-Reply-To: <20261024014514.2959514-6-andrey.grodzovsky@crowdstrike.com>
References: <20261024014514.2959514-6-andrey.grodzovsky@crowdstrike.com>
Subject: Re: [PATCH bpf-next v8 5/7] selftests/bpf: Cover BPF program load strategy transitions
From: bot+bpf-ci@kernel.org
To: andrey.grodzovsky@crowdstrike.com,bpf@vger.kernel.org,andrii@kernel.org
Cc: ast@kernel.org,martin.kelly@crowdstrike.com,slava.imameev@crowdstrike.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 24 Oct 2026 02:23:53 +0000 (UTC)

--===============7960461725624875402==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Cover BPF program load strategy transitions

TL;DR: Nit only: the new selftest is named load_type, but the API it tests
says "load strategy"; renaming it to load_strategy would make it easier to
find.

> diff --git a/tools/testing/selftests/bpf/prog_tests/load_type.c b/tools/testing/selftests/bpf/prog_tests/load_type.c
> new file mode 100644
> index 000000000000..7e344c0b0445
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/load_type.c
> @@ -0,0 +1,154 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +#include <time.h>
> +#include "test_load_type.skel.h"
> +
> +void test_load_type(void)
> +{

This isn't a bug, but the API this test exercises is named load strategy
throughout (enum bpf_prog_load_strategy, bpf_program__set_load_strategy(),
bpf_program__load_strategy()), and the commit subject says "load strategy"
as well.  The string load_type doesn't appear anywhere else in tools/lib/bpf
or the selftests.

Would naming this test load_strategy (prog_tests/load_strategy.c,
progs/test_load_strategy.c) make it easier to find with
'./test_progs -t load_strategy' or by grepping for tests of
bpf_program__set_load_strategy()?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40052381836
--===============7960461725624875402==--
