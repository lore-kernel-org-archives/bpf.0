Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AB6381B0E;
	Wed, 15 Apr 2026 21:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776289404; cv=none; b=V5VAUyAWswNzzG15xm7m0j0NHXibvrwcCD9ZCzHqpl21/sFCEt24VAVO+8KdrT22mQJxgnras0IsvyRtVSRlxrnjvgs+ArqHEF/Iqc2RoOAc9StuHQ6mFaW9iCGur7jrX1odY6Ph+09imIvkUU7Z6OeaDczDtygQeLcKuhS85pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776289404; c=relaxed/simple;
	bh=Hx3fqxnlCYc3RSrNwt5h8aHCuamxN2L4FSlmbkpYEaY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=tI47sVwTe1nPSEhZqPnzjQu4iyqNPq5w5E73L8Ct8tZZMV9mcHmMUNXJyBcE8WnPziYYTbwS4IRfbGjOY2fiOdX6Hs4kl2YVUQos59iOPiJzJp1sbZvgZILqJy57AbukK2qvM1BjmhcJTo6Lon515Af2VzUfZL7ORwPL6D3Tyr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BbKrraLJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BbKrraLJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A598C19424;
	Wed, 15 Apr 2026 21:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776289404;
	bh=Hx3fqxnlCYc3RSrNwt5h8aHCuamxN2L4FSlmbkpYEaY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=BbKrraLJpcEADM/I5rZj6RzL4L5iJJlqob+Bdwel76eFbVLfcNo0jLkz8CZla5BG1
	 QNpeQhV13/B8+wa8DMQaA8DM/0vSqs787Nrh7McF93qObTN7iBx+T5yyidI8XCq1Kx
	 lzrAldiHEke9OEg0WQMQEIkwcePvLVEC1YNjiT50X+AjlbyVZ+J3UdqFJm9ALuKo+R
	 B6SYZcj1N7VT6NAdJqou9h9LUyJ0Sjuv3PnbGbqjIdxqEdxJSZWVdvPBOaVSVUwZSQ
	 vJhaLI7NgcYpxlFVvV8F3LGhS/p7iXn6MTAhrAXJmSbOF1H0vg9Uz5VpOBYtk55qr3
	 +VPvAhAYlvcZw==
Content-Type: multipart/mixed; boundary="===============2522503836257251815=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7be2eda557c07a9319e8197c1e96e5f4b3b08bc57de6d8384fb0755b63a90b16@mail.kernel.org>
In-Reply-To: <20260415-selftests-bpf_misconfig-v5-10-03d0a52a898a@suse.com>
References: <20260415-selftests-bpf_misconfig-v5-10-03d0a52a898a@suse.com>
Subject: Re: [PATCH bpf-next v5 10/11] selftests/bpf: Skip tests whose objects were not built
From: bot+bpf-ci@kernel.org
To: rbm@suse.com,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org,nathan@kernel.org,nick.desaulniers+lkml@gmail.com,morbo@google.com,justinstitt@google.com
Cc: bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,llvm@lists.linux.dev,alan.maguire@oracle.com,rbm@suse.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 15 Apr 2026 21:43:24 +0000 (UTC)

--===============2522503836257251815==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index 7fe16b5131b1..759e76d76c57 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c

[ ... ]

> @@ -2049,12 +2070,16 @@ int main(int argc, char **argv)
>  		test->should_run = should_run(&env.test_selector,
>  					      test->test_num, test->test_name);
>
> +		if (test->run_test && test->run_serial_test) {
>  			fprintf(stderr, "Test %d:%s must have either test_%s() or serial_test_%sl() defined.\n",
>  				test->test_num, test->test_name, test->test_name, test->test_name);
>  			exit(EXIT_ERR_SETUP_INFRA);
>  		}
> +		if (!test->run_test && !test->run_serial_test) {
> +			test->not_built = true;
> +			test->should_run = false;
> +			continue;
> +		}

This sets not_built unconditionally, regardless of what should_run()
returned.  The commit message says:

  "Tests filtered out by -t/-n remain invisible as before"

but doesn't this do the opposite?  When should_run() already returned
false because of -t/-n filtering, the test still gets not_built = true.

> @@ -2106,9 +2131,18 @@ int main(int argc, char **argv)
>
>  	for (i = 0; i < prog_test_cnt; i++) {
>  		struct prog_test_def *test = &prog_test_defs[i];
> +		struct test_state *state = &test_states[i];
>
> -		if (!test->should_run)
> +		if (!test->should_run) {
> +			if (test->not_built && !env.get_test_cnt &&
> +			    !env.list_test_names) {
> +				state->tested = true;
> +				state->skip_cnt = 1;
> +				env.not_built_cnt++;
> +				print_test_result(test, state);
> +			}
>  			continue;
> +		}

Then here, every not-built test is printed and counted as skipped,
even ones the user excluded with -t or -n.  Running something like
"./test_progs -t my_test" on a partial build would print
"SKIP (not built)" for all unbuilt tests, and inflate both succ_cnt
and skip_cnt in calculate_summary_and_print_errors().

The same issue applies to the server_main() loop:

> @@ -1772,6 +1780,19 @@ static void server_main(void)
> +	/* mark not-built tests as skipped */
> +	for (int i = 0; i < prog_test_cnt; i++) {
> +		struct prog_test_def *test = &prog_test_defs[i];
> +		struct test_state *state = &test_states[i];
> +
> +		if (test->not_built) {

This also has no check against the original test selector, so in
parallel mode with -t, all not-built tests are surfaced as well.

Would it make sense to preserve the original should_run() result and
only set not_built when the test was actually selected?

This was also flagged in an earlier review of v5:
https://sashiko.dev/#/patchset/20260415-selftests-bpf_misconfig-v5-0-03d0a52a898a@suse.com?part=10


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24478691588
--===============2522503836257251815==--
