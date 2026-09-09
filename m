Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41AD36B93B
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 07:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788938015; cv=none; b=oE/Xen1xMXobnLGVYCpApb015l+SLkYSxwgPDefhvRNhk8619a37LStashE7/Z4SsftpLwL4JnJCciq3tqWOSdIqKmyr0waY0iVx4b178FuODQD3813HaWHKYD2Ktqa7N43jS760syETPmRzkEbEvUUL/fCw6CrV20TfpIoxxa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788938015; c=relaxed/simple;
	bh=ELDeJEgTMFlfHhyi6EOeToJkmSy3hvqhRPVsh/pa4tI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=VSvQogN49OwNTuWhYlXECKdO/68kZuJ2ZZL0wMKInfdRldyRnpO99J6KL/c6m4RMNY+akt/FzZ4zYsAMokP3yJWa/bCIoXgCESU8aAioL8+VpwIFmgeIEyGDVxb12wmqrsm8VVKu+oweEWOIKqAKvRa5wBDK36Po531tcRJJaEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlOpqrn2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlOpqrn2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA491F00A3D;
	Wed,  9 Sep 2026 07:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788938014;
	bh=ILRncD4dYYb6FCDop/qqLAKf0AqfReffE8ublzu4wwI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=YlOpqrn23VWcTDPFwh1fu7vqfY2uPu7xWf3Zf/vXz9Yf62yzqnLSpBVr8q/pxpsyM
	 cz6mbu/EpVJbpq+FQ3WNjxsmTP/unpu7yvGdMMI7HUt+A+yfXW+ljWH78pHn83gmIT
	 XIiQBx+OVm67WYmuhpRndLjOpQJjGMX7hlwgj5B3UJ+xSyMjrBTgoAO7ori9TBQ8CD
	 hxeKJBNUB8utbZnGMUuYzOZpxydE74TIa9fnhZXHZscLyrx+O3ee2OeSf+UpUv4ua1
	 /CXqeI4GEOBZ4XhrNeu2Yw4WL179cATuxO2JR7oeDYq2StRFHt26Noorz16/qn1X+v
	 bXJF0u7BNYf8g==
Content-Type: multipart/mixed; boundary="===============1227024470690912243=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5b5eb3abbefc69c22b09fb686c4ff7cc3d334c9b3f73110a064252f545ff88cb@mail.kernel.org>
In-Reply-To: <20260909062528.4002148-1-yonghong.song@linux.dev>
References: <20260909062528.4002148-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 01/12] selftests/bpf: Add a test for an __int128 by-value argument
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  9 Sep 2026 07:13:33 +0000 (UTC)

--===============1227024470690912243==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
> index f7f94ccebce2..0d68b92d6692 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -50,6 +50,7 @@
>  #include "verifier_helper_packet_access.skel.h"
>  #include "verifier_helper_restricted.skel.h"
>  #include "verifier_helper_value_access.skel.h"
> +#include "verifier_int128_arg.skel.h"

[ ... ]

> @@ -214,6 +215,7 @@ void test_verifier_helper_access_var_len(void) { RUN(verifier_helper_access_var_
>  void test_verifier_helper_packet_access(void) { RUN(verifier_helper_packet_access); }
>  void test_verifier_helper_restricted(void)    { RUN(verifier_helper_restricted); }
>  void test_verifier_helper_value_access(void)  { RUN(verifier_helper_value_access); }
> +void test_verifier_int128_arg(void)           { RUN_TESTS(verifier_int128_arg); }
>  void test_verifier_int_ptr(void)              { RUN(verifier_int_ptr); }

This isn't a bug, but the name verifier_int128_arg describes only the
one case progs/verifier_int128_arg.c holds at this commit. Two patches
later in the same series, f4da9830f5a9 adds by-value struct argument
tests (struct pair, struct small, struct with_ptr) to the same file,
none of which are __int128. The sibling entry two lines up is
test_verifier_aggregate_ret for the aggregate-return family.

Since progs/verifier_int128_arg.c later grows to cover by-value struct
arguments too, would a name in the same family as verifier_aggregate_ret
-- say verifier_aggregate_arg -- fit the file better and save a rename
later in the series?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34320399441
--===============1227024470690912243==--
