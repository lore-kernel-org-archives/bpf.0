Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51335466AE7
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 11:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788522434; cv=none; b=I+EuZYa4+fQIooI8eyeJInx0HJH22t7SXNTpq3lJDL/Pr65XImXHA8sSxebzkY9nCb3uZmbu5J/D5vIflxtFxSyQ58jfhpbHh2w5/eU0Q8g8BcIxs00eXbEbcfDmlXRTouVEeiMKhXVAwdIdhTbAQWSHeGFeoh0j9vBEa60Pn7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788522434; c=relaxed/simple;
	bh=scmCEnz5Q/vMPnlQ11YriJcSvdZGamezy2tnYHvZSWo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=mpeox5FCemO/tJ+KGyjIWGfgWVt2XyYYqxXmbGUufPUIv53oq2ihhpg+LN+juDr1A7edHmUNMzQzKDUnJtMlvvNagL8QRa94LgCQ53Ei2CQHES/vQ/nbzOGtl+nPe0kWnlW8EhqZXL5tNVNv/lUZPhHj9wihht+09Je2nMu+/Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBR7/3bt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBR7/3bt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318DE1F00A3D;
	Fri,  4 Sep 2026 11:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788522432;
	bh=xdrYZs4xvoNSi2h9menqeNmh7zbbnuadBzFJPOugzAo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=gBR7/3bt90uVTtD4pfjLnttK19RKxL2Uo+G6Z9BLkJ6uBgdMKJ/aY1P3aHK0v6MaI
	 qaxBQLxA4m2C0rKnmiA7HUbhRKSMPl60PaRUYH29ZbT0l+U2zA4nfLG6bReD0PWSl5
	 0i/vYVi/p50FcfIvHGxVoZVPMQ1vpNiJ8oU1qtpRF7Pr7k1eiAS2mnVn0vdPzly+D8
	 C/qmTDygTYfsl/thogcxO85HkSenVh5MplFPB+YJCy/f1BO88TmoMqCcKs3SNoO+cU
	 HX/HrycXlKrrvjqxbBEfwohEKWtNxz3FLnQ9b2BcD0IDUKPJRc6LNe5JCcnmZ7s+yV
	 njpipRZjvfWIQ==
Content-Type: multipart/mixed; boundary="===============5431249471208810196=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3c20a1872d5565bf90376d5f6bd1879ef153d896a96547aa85e5b2616f902dfe@mail.kernel.org>
In-Reply-To: <20260904104203.345917-9-memxor@gmail.com>
References: <20260904104203.345917-9-memxor@gmail.com>
Subject: Re: [PATCH bpf v1 8/8] selftests/bpf: Test inner map identities in callbacks
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,npc@anthropic.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  4 Sep 2026 11:47:12 +0000 (UTC)

--===============5431249471208810196==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/timer_mim.c b/tools/testing/selftests/bpf/prog_tests/timer_mim.c
> index c930c7d7105b9..fa7bb769ca31e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/timer_mim.c
> +++ b/tools/testing/selftests/bpf/prog_tests/timer_mim.c
> @@ -59,10 +59,32 @@ void serial_test_timer_mim(void)
>  	int err;
>
>  	old_print_fn = libbpf_set_print(NULL);
> -	timer_reject_skel = timer_mim_reject__open_and_load();
> -	libbpf_set_print(old_print_fn);
> -	if (!ASSERT_ERR_PTR(timer_reject_skel, "timer_reject_skel_load"))
> +	timer_reject_skel = timer_mim_reject__open();
> +	if (!ASSERT_OK_PTR(timer_reject_skel, "timer_reject_skel_open"))
> +		goto cleanup;
> +	bpf_program__set_autoload(timer_reject_skel->progs.test1, true);
> +	err = timer_mim_reject__load(timer_reject_skel);
> +	ASSERT_ERR(err, "timer_reject_skel_load");
> +	timer_mim_reject__destroy(timer_reject_skel);
> +
> +	timer_reject_skel = timer_mim_reject__open();
> +	if (!ASSERT_OK_PTR(timer_reject_skel, "callback_reject_skel_open"))
>  		goto cleanup;
> +	bpf_program__set_autoload(timer_reject_skel->progs.callback_map_uid_mismatch, true);
> +	err = timer_mim_reject__load(timer_reject_skel);
> +	ASSERT_ERR(err, "callback_reject_skel_load");
> +	timer_mim_reject__destroy(timer_reject_skel);
> +
> +	timer_reject_skel = timer_mim_reject__open();
> +	if (!ASSERT_OK_PTR(timer_reject_skel, "callback_accept_skel_open"))
> +		goto cleanup;
> +	bpf_program__set_autoload(timer_reject_skel->progs.callback_map_uid_match, true);
> +	err = timer_mim_reject__load(timer_reject_skel);
> +	if (!ASSERT_OK(err, "callback_accept_skel_load"))
> +		goto cleanup;

Does this handle CONFIG_PREEMPT_RT correctly?

The callback_map_uid_match program calls bpf_timer_init(), which the
verifier rejects unconditionally on PREEMPT_RT kernels:

kernel/bpf/verifier.c:process_timer_func() {
    if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
        verbose(env, "bpf_timer cannot be used for PREEMPT_RT.\n");
        return -EOPNOTSUPP;
    }

On a PREEMPT_RT build timer_mim_reject__load() returns -EOPNOTSUPP and
ASSERT_OK(err, "callback_accept_skel_load") reports a test failure.

The existing skip hatch is a few lines later:

    timer_skel = timer_mim__open_and_load();
    if (!timer_skel && errno == EOPNOTSUPP) {
            test__skip();
            return;
    }

Before this patch all timer_mim_reject loads were expected to fail, so
-EOPNOTSUPP satisfied the rejection assertion and control reached the
skip. After this patch the must-succeed load fires first, converting
timer_mim from SKIP to FAIL on PREEMPT_RT.

Should the capability check move ahead of the new positive control, or
should callback_accept_skel_load check for err == -EOPNOTSUPP and call
test__skip()?

Two related issues also follow from this ordering:

- libbpf_set_print(NULL) is still active when the positive control
  fails, so the verifier log is suppressed and only "unexpected error:
  -95" is shown.

- The two ASSERT_ERR() arms for test1 and callback_map_uid_mismatch
  only check err < 0, so on PREEMPT_RT they also pass for the wrong
  reason (-EOPNOTSUPP instead of the intended map_uid mismatch), making
  those negative cases silent tautologies.

> +	timer_mim_reject__destroy(timer_reject_skel);
> +	timer_reject_skel = NULL;
> +	libbpf_set_print(old_print_fn);
>
>  	timer_skel = timer_mim__open_and_load();
>  	if (!timer_skel && errno == EOPNOTSUPP) {

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/timer_mim_reject.c b/tools/testing/selftests/bpf/progs/timer_mim_reject.c
> index dd3f1ed6d6e62..83f31138336b7 100644
> --- a/tools/testing/selftests/bpf/progs/timer_mim_reject.c
> +++ b/tools/testing/selftests/bpf/progs/timer_mim_reject.c
> @@ -43,7 +43,7 @@ static int timer_cb(void *map, int *key, struct hmap_elem *val)
>  	return 0;
>  }
>
> -SEC("fentry/bpf_fentry_test1")
> +SEC("?fentry/bpf_fentry_test1")
>  int BPF_PROG(test1, int a)
>  {

[ ... ]

> +SEC("?fentry/bpf_fentry_test1")
> +int BPF_PROG(callback_map_uid_match, int a)
> +{
> +	struct hmap_elem *val;
> +	struct bpf_map *inner_map;
> +	int array_key = ARRAY_KEY;
> +	int hash_key = HASH_KEY;
> +
> +	inner_map = bpf_map_lookup_elem(&outer_arr, &array_key);
> +	if (!inner_map)
> +		return 0;
> +	val = bpf_map_lookup_elem(inner_map, &hash_key);
> +	if (!val)
> +		return 0;
> +
> +	bpf_timer_init(&val->timer, inner_map, CLOCK_MONOTONIC);
> +	bpf_timer_set_callback(&val->timer, timer_match_cb);
> +	return 0;
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33865340224
--===============5431249471208810196==--
