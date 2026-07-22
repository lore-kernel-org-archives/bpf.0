Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BB833EAF9
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 07:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784707193; cv=none; b=i7Ydpu3dgw1Cid1FLgB5ILwNCXnqqOvKaPzY8Q+l++7vfpKAC+2mFB2in2poBXUs1/eRbGExb9nIAB3zAhV9rX+7er89FdjvCJ+TkBqYmXLya+nEeggxKwTfxk9mJkR068topiBZOIdn2pVLXWzycWJoMh3XAssM8gKvSpGS88s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784707193; c=relaxed/simple;
	bh=x9jhofdDugmF8hSgWTuPHvlR8KzVI2c00+fLuUy3i6w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VYeol7iFB91M/uGf+Z+/lvE5owSXAJBMGIpziOeYv0jczRNA4OU91kEfeYced502g7YPPjHSfX7vGp58xaMMivLArDflh/vEMPdEdauSSEruk75QWNM6G/V7S8eh+J9W0DlxXkOljpSCFnwfTRlFVaPRCJlefYL/jfpAyKxtRa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eu2zhGzS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eu2zhGzS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B33211F000E9;
	Wed, 22 Jul 2026 07:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784707191;
	bh=iwIoZgvGQpeDKPKrrjnMQ3I3R6riCbZIJgz2qzovpjs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eu2zhGzSlcrCd5TkYD86SX2kEyViXP/5+yH/ryFaliNv2nkxoiCM5NMGafzQlOJoy
	 FfM+zGaBVn+Fmy2T15Hx7eqmKHM+Mcxb1fHq31SUoSDHOOHHCZRTWX9Q+a1RlCBcim
	 o1vbaGYILTvMK5t1qrLg2E2gSZMrh6Ozi6BPdMTWZIYMcAKYizH0CAO7RIOj72lEUg
	 vBu4o1MePyv6f+fTvgyPhcp3Xw0Pp/0g20Xmu5pQuAKnFTuEcKwMPXVUaW66+CytoK
	 xHOC6w3Mz9gwg8u0onrFMBQ7J+dsOhyJuvfdPB22s9gnNCxIztJWjUBfx2OLC9nC8W
	 uPBDwkP6oKfRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf-next 2/5] selftests/bpf: Fix missing allocation
 null checks in test_progs.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Feng Yang" <yangfeng59949@163.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260722074748.674080-3-yangfeng59949@163.com>
References: <20260722074748.674080-1-yangfeng59949@163.com>
 <20260722074748.674080-3-yangfeng59949@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 07:59:51 +0000
Message-Id: <20260722075951.B33211F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The newly added NULL check prevents an immediate crash but intro=
duces a segmentation fault during program teardown due to inconsistent stat=
e.
- [Medium] Direct return on allocation failure in `main()` and `server_main=
()` bypasses the cleanup path, leaving the test kernel module loaded.
--

--- Patch [2]: [PATCH v2 bpf-next 2/5] selftests/bpf: Fix missing allocatio=
n null checks in test_progs.c ---
commit 5b8390b4a3f20a060d50a407c4941f4877ed4709
Author: Feng Yang <yangfeng@kylinos.cn>

selftests/bpf: Fix missing allocation null checks in test_progs.c
   =20
Add null checks after memory allocations to prevent potential segmentation =
faults.

> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
> index 1d3caf9969717..88c65ce5b0189 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
[ ... ]
> @@ -1514,6 +1517,8 @@ static int dispatch_thread_send_subtests(int sock_f=
d, struct test_state *state)
>  	int subtest_num =3D state->subtest_num;
> =20
>  	state->subtest_states =3D malloc(subtest_num * sizeof(*subtest_state));
> +	if (!state->subtest_states)
> +		return -ENOMEM;

[Severity: Medium]
Will this lead to a segmentation fault during program teardown?

If this allocation fails, we return without clearing state->subtest_num.
Later during teardown, free_test_states() loops over test_state->subtest_num
and accesses test_state->subtest_states[j], which calculates an offset from
a NULL array:

tools/testing/selftests/bpf/test_progs.c:free_test_states() {
    ...
		for (j =3D 0; j < test_state->subtest_num; j++)
			free_subtest_state(&test_state->subtest_states[j]);
    ...
}

Should state->subtest_num be set to 0 before returning here?

[ ... ]
> @@ -1732,9 +1737,24 @@ static void server_main(void)
>  	sigaction(SIGINT, &sigact_int, NULL);
> =20
>  	dispatcher_threads =3D calloc(sizeof(pthread_t), env.workers);
> +	if (!dispatcher_threads) {
> +		perror("Failed to calloc dispatcher_threads");
> +		exit(EXIT_ERR_SETUP_INFRA);
> +	}

[Severity: Medium]
Does exiting directly here leak the loaded bpf_testmod kernel module?

Normally, main() handles cleanup by going to the out label and calling
unload_bpf_testmod(), but calling exit() bypasses this cleanup path.

[ ... ]
> @@ -2094,7 +2114,16 @@ int main(int argc, char **argv)
>  	env.worker_id =3D -1; /* main process */
>  	if (env.workers) {
>  		env.worker_pids =3D calloc(sizeof(pid_t), env.workers);
> +		if (!env.worker_pids) {
> +			perror("Failed to calloc worker_pids");
> +			return -ENOMEM;
> +		}
>  		env.worker_socks =3D calloc(sizeof(int), env.workers);
> +		if (!env.worker_socks) {
> +			perror("Failed to calloc worker_socks");
> +			free(env.worker_pids);
> +			return -ENOMEM;
> +		}

[Severity: Medium]
Could this direct return also bypass the cleanup path?

Returning directly skips the out label at the end of main(), which is
responsible for unloading the bpf_testmod module if it was loaded. Should t=
his
use a goto to reach the cleanup code?

>  		if (env.debug)
>  			fprintf(stdout, "Launching %d workers.\n", env.workers);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722074748.6740=
80-1-yangfeng59949@163.com?part=3D2
