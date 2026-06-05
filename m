Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27677344025
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 07:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780645226; cv=none; b=qX4WfT0N9qOyT6XE4qv8jtgCTO7V5Lgd4tNBkp8ZbvnwFLIBE4QXDOnNTNSzfKQdiJVIhZqTWeIrY++B7XyCOibYCoXesRQTV/bcJ3NapqGULZxPzIfUpqCVx7kMzgJaa9TlPgFDVrEc5XxJ/D/9gMsKYtYC6jX4UaoLAZqsdoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780645226; c=relaxed/simple;
	bh=tiG/yjbrQ1P0y8uY+C+/0KN3C8CTk9z6B3ImiU0sKeU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=e0DTWhzFOTQFkB4OGsD0L5qfZn+5k0k2XPZae3rdnAw6WQEyaqnuohbvjdNcjm4l2otb21CAKHl1edB1aJrfpXNZ3QewqQpCEf/7UlBYHK5ByqGg3iDpqzokqybKxnUS4sCx9q6nj975pjIQ+YSkiQoQzhqnckvisLr+9y6ZjOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crss6PYK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crss6PYK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BDDA1F00893;
	Fri,  5 Jun 2026 07:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780645224;
	bh=UjYJeW+EzWQYokj9lNc9VFaaH+ATwO3g49WWF8TdljI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=crss6PYK5UX5pId5yfezCcjQNm7yRRg7nYXw5sD7At5sDkADv+Mu6K0uKNr9IH6tQ
	 +IWmwEeQgwjr6A6WDmD4ynV5kQmU2z16B2jEGeA6WkJqGfB9ph6URxqVQVAOVZXRAg
	 BKL+ABUog+J/TbQFcXfttLeM0lgaNPYa082N68hVINkWg4giG373upRTn4Cu+aWK7d
	 QT4RLmR8E04Kh3wlH5UVHi54KlqlWeLJPPFU3P20RntXCTwTm+TomDPMD7A3tEyNAu
	 NqTz2bVgwFEsnVEQLxjSfxW5UC+uaTeN2pDvWBA/cJTr6k0KQ4jkhUqSeNQu6Lm6+b
	 uiFtmlWEQL5gw==
Content-Type: multipart/mixed; boundary="===============0368979163512937342=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dc4731561264fb1eac445767bba0360e185a3092bb49b46c961a7891d609a0ab@mail.kernel.org>
In-Reply-To: <20260605063412.974640-16-memxor@gmail.com>
References: <20260605063412.974640-16-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 15/17] bpf: Report Verifier Limit errors
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  5 Jun 2026 07:40:24 +0000 (UTC)

--===============0368979163512937342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f81aad4aeb8e..c5a3b6876c68 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -5233,6 +5267,8 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>  	bool tail_call_reachable = false;
>  	int total;
>  	int tmp;
> +	char chain[256];
> +	char reason[512];

This adds 768 bytes of on-stack character buffers to
check_max_stack_depth_subprog().

The same pattern appears in setup_func_entry():

> @@ -9443,11 +9557,22 @@ ...
>  	struct bpf_func_state *caller, *callee;
> +	char chain[256];
> +	char reason[512];
>  	int err;

setup_func_entry() runs deep in the verifier call path:

  do_check()
    -> do_check_insn()
      -> check_func_call()
        -> setup_func_entry()

Since the buffers are only written on the error paths, but compilers
typically reserve locals in the prologue unconditionally, would these
~768-800 byte additions to those frames be better served by dynamic
allocation (for example kasprintf) on the failure path?

Could the added frame size trigger frame-size warnings or contribute to
kernel stack pressure here?

This same concern was raised by the Sashiko AI review on v1
(https://lore.kernel.org/bpf/20260605065307.339231F00893@smtp.kernel.org/),
which suggested dynamic allocation since the strings are only used on
failure paths. There does not appear to have been a response, and the
arrays remain in the current code.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27000182395
--===============0368979163512937342==--
