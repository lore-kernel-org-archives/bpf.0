Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793121024;
	b=i1Rl8jD0WE/bCz3NL9AeJW4/OHeMVqw6hzXreDvIxlEEG6yE6R3NpDoqjZYLMku7RzM/
	 QILpXILwH3N3t5oNnS4lhhdXf061rZy1db5tNjY+XpU7KkVVbW0GqqqV3N/VN/sigZ+Fk
	 pjxX8ZNOT96yDAgVgyuHlf+wqM1gT2BCsw3dWtC20SmRhD9jySGfKOeXkOSA0ahppjL23
	 FVaCDqS4h8wN0u+wqmzZGUJXNFZVBcUUQalogKtnS4Llf64Le/By8iflO8zO8zNrvH38X
	 F6TUGT4FmDulQSZsyK/Qf8umOo3NGx8QdKqPDerSPnFZ8/7Yr3i/zmVPTu17G+PLHow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793121024;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=kX3D/nzhzyhJmwSjrC1VRBCYdjTL/ZW0/bmHmI6MFUQ=;
	b=ygC42s5g8teJLu9r/dowpCuUp8PETiWXNyAKvy4HzC3ZnAe9FN/MlS1EWpV+c4h+MrNm
	 FatPJthqbRknYb3s/GDAKk5OMR8G1DpFl+rMb1z/Rsn+moivJuj6QOKalEs1jtMiss5i5
	 5iiQbp1OkbVTTykm1E2HjKVAu1a1hb1N5MF6TwofTJhNH6FGoeTxQQqacOuSfNbQpyJbB
	 R2ytzSKxlv5hCkFZZCUFaTPTPqXC6fDMweY8gzicG2Pft7KNpL8PGKTqCc5qxQk8hDYHY
	 2gk+U8qbeHz0c4J5ufTNuJGofglEuAyyufuZmLAqisBuJfLAUSxN0SvgQHd1TpSLpcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eIlpIcca;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A94606A31D
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 17:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eIlpIcca
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E591F031E3;
	Tue, 27 Oct 2026 17:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793121023;
	bh=kX3D/nzhzyhJmwSjrC1VRBCYdjTL/ZW0/bmHmI6MFUQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=eIlpIccaENWeRIoCUfM2o0zkzjtApGOPPWQM1Wz2B+qMwNb0n1qSdP8aMoijekWlk
	 GxpyXqjFt1XdBRn/HuTPMDj13VwAgG4TG/4M/UFc+1r7fF9o2LGbD0cps1w9OiGj6f
	 AHhXP/WwuxbNsMfOeXPlp1QyvPoWGuTWOl69NAUFQxi5ppvAKLTm1FdUDqvSt1hy/N
	 fhcn8c6yjQ9KNJHiRvVAkHt+Ks1BkLcVfmFrkCir9wtqiqC+GVtKqw/s5pheLMtMYx
	 Im/ajsvmHQCJpOn3h6HmaQn4qqhp6O62tPAh6WZemViaVJnNO3trWnNapQ09e2Y8ga
	 DTa3OVtEVPv2w==
Content-Type: multipart/mixed; boundary="===============3081449311569489612=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <1c6798d00f9493490cfdd7c2a76a1937b3d9ddfea81ebadd722bd6f351ef6f18@mail.kernel.org>
In-Reply-To: <20261027162820.10887-8-emil@etsalapatis.com>
References: <20261027162820.10887-8-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next 7/7] selftests/bpf: Verify register preservation for IRQ fastcalls
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,daniel@iogearbox.net,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 27 Oct 2026 17:10:23 +0000 (UTC)

--===============3081449311569489612==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Verify register preservation for IRQ fastcalls

TL;DR: Nits only: the two new irq_fastcall selftest files (prog_tests and
progs) lack the SPDX license identifier line that nearly all neighbouring
files carry.

> diff --git a/tools/testing/selftests/bpf/prog_tests/irq_fastcall.c b/tools/testing/selftests/bpf/prog_tests/irq_fastcall.c
> new file mode 100644
> index 000000000000..3c1073bc1e49
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/irq_fastcall.c
> @@ -0,0 +1,71 @@
> +#include <test_progs.h>
> +#include <network_helpers.h>
> +#include "irq_fastcall.skel.h"

Neither new file starts with an SPDX license identifier.  This one begins
with '#include <test_progs.h>' and progs/irq_fastcall.c begins with
'#include <vmlinux.h>'.

The char _license[] SEC("license") = "GPL" in the BPF object is the program
license that the verifier checks, not the file's SPDX header.

Most files in prog_tests/ carry the tag (482 of 487), and checkpatch.pl
warns about a missing SPDX-License-Identifier on the first line of a new .c
file.  irq_jit.c from earlier in this series is one of the few that lack it.

Should both new files start with:

  // SPDX-License-Identifier: GPL-2.0

like the other files in prog_tests/ and progs/?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/irq_fastcall.c b/tools/testing/selftests/bpf/progs/irq_fastcall.c
> new file mode 100644
> index 000000000000..3988e489c14f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/irq_fastcall.c
> @@ -0,0 +1,56 @@
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"

The same SPDX line seems to be missing here as well.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40544258296
--===============3081449311569489612==--
