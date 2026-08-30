Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B026339EB5B;
	Sun, 30 Aug 2026 08:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788078903; cv=none; b=a1pfKyFgAXkppY0BJbhTikX6rSg4qVK6CG5sgdczDYaUbvZqwybiLpM0aZ8uQ5iGwk2kG0PqUAuDcInOEk7gDkxhE9Ka+ydT6eKph5XjZiIR0OasZVLP/x1IxwTwT5nAYaADjlNXtQTBlv5WK/mdOTThv1fmqKrrOEr7YyOZ8f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788078903; c=relaxed/simple;
	bh=9nr+VUZ1KaTmwr4E/jTg2V56fkbrGOh1EBpjOXokfuA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=nOTmdTkHAdGXOLZ+kEAccwtdmUyi4WuhwfMmVgI4T7xw49JlaPmf6j+qf5lhFrQBD4fB5deLeuHfxWEI1wIbiugnTJt8hgdsUM6HXRQgB0+9pIWJCgpiumO9hJgLO55iGaDiKO7ul1U1chmVIU9ZmSWgW0w6cC4vcECvUolCd1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3gDjneJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3gDjneJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFBA1F00A3D;
	Sun, 30 Aug 2026 08:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788078902;
	bh=9nr+VUZ1KaTmwr4E/jTg2V56fkbrGOh1EBpjOXokfuA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=e3gDjneJrk6BIxqiDBSHOL+RVblTUGdambxqVrU0Br84iI+FkPmjitU4KaQ0JjLHn
	 mjMYqQ1ikONsR+XD9MyupaKdWlZSC/l8sMTkgASE8C/1vpDdIAxWqzbcEunhcV9i9R
	 2svQj1GVoMN7GMeQls4ytJtmMfbmg/RiPHmfBnJCDAZzv3rsrsZoZVDPAm6em6s15H
	 +W0UKF5E83lRMW37XhjSWBXkIetXGoyiN44vmlCJbNlZt3hPUOe5ZuGu3dkcl58lZF
	 1Kxq/oiuGi3K7+RuSvaXaE/e+ZEkQ5k3m3Wj7qPlP1dmmBLXvuH57NAOV7iQ9IFGPI
	 h2rIUtvWuKotg==
Content-Type: multipart/mixed; boundary="===============9095257157457930131=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <be21d868793ab07d612780b2a53e63112b1556bb67aa3b52369f90b852194a82@mail.kernel.org>
In-Reply-To: <20260830073242.148092-4-jiayuan.chen@linux.dev>
References: <20260830073242.148092-4-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf v2 3/4] selftests/bpf: Add test for key-less BTF hash map
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org
Cc: jiayuan.chen@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,yatsenko@meta.com,alan.maguire@oracle.com,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 30 Aug 2026 08:35:01 +0000 (UTC)

--===============9095257157457930131==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_map_keyless.c b/tools/testing/selftests/bpf/prog_tests/btf_map_keyless.c
> new file mode 100644
> index 0000000000000..43f0bb9bd5786
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_map_keyless.c
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _GNU_SOURCE

This isn't a bug, but is the #define _GNU_SOURCE needed here?
Everything the file uses looks like plain POSIX (fopen/fgets/fclose from
stdio.h, unlink/close from unistd.h, plus libbpf/BTF calls), and
lib.mk already passes -D_GNU_SOURCE= to selftest builds.

> +#include <test_progs.h>
> +#include <bpf/btf.h>

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33300136294
--===============9095257157457930131==--
