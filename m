Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96955373C04
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 21:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776287461; cv=none; b=hzzsX+R46Mk3Jgt+RhpVRUFdHFQjvg6bwTfWpkLgqcnmnTz50aTbXLM4Jp7zlTS3DDrgs8l6PpJpA7eSLKn/SqbrBH1B0byX21MHTSOg1O/rip5VH6GhJ7i0HWHOX/D5kPdRCRMFCMEc1d3UXBOxWjh54uw2kLWVL+YS2/o+pvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776287461; c=relaxed/simple;
	bh=+9BMT23Kv4N1g5lvvIfMEUxYt0Un+ccs9hOZ9Tf67QA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FYIXOsBz1wdttuFvteshv0TFhKBR6W+9BVKTHcdKjTspglwINd2dgZJ/7eGGq2vIV2JhTaEMTCiY2E1n3ahv/uLG69BLls3Y/5MX/XnbJ7dpT/aE0t900UXcQDOZq/R14x44ai27oCpq4UdrT0CFdMOojqXf1HP8nS6xBBoMBG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eun83KVB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eun83KVB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C02C19424;
	Wed, 15 Apr 2026 21:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776287461;
	bh=+9BMT23Kv4N1g5lvvIfMEUxYt0Un+ccs9hOZ9Tf67QA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=eun83KVB9LETymN3qLQUIMhEvtkSzcvAMxrP0pXPdXMqrIedxtTYTF7z2VlzV/UVp
	 P/wM6hWF1nLquUPCh2qaL8ckJ6x3a7JfbsJuC6FlVhHHqr3iBVUL269DD1s34BefN+
	 H+/mBwCV27DCfzSnZv8Pjha8gSO8R54A1jydypCA55kCQ2VziTiyAU92YKgF2t036m
	 /sOkZTm89Y0N21a3iCfzwldTf13SBGBiND2yio5+SJoRRhS00CopwB3gfxUNkmzOzT
	 PLRYzxYZSKrKM+wYML7uy3zyTGeHFFmtppii6ZVzg6YNRqcyMocaW4EpJTXjLrE9UX
	 GIcB1oQexmbEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 10/11] selftests/bpf: Skip tests whose
 objects were not built
Reply-To: sashiko@lists.linux.dev
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260415-selftests-bpf_misconfig-v5-10-03d0a52a898a@suse.com>
References: <20260415-selftests-bpf_misconfig-v5-10-03d0a52a898a@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Apr 2026 21:11:00 +0000
Message-Id: <20260415211101.12C02C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Unbuilt tests bypass test filters (e.g., `-t`, `-n`) and are alw=
ays printed and counted as skipped, breaking test isolation and contradicti=
ng the commit message.
--

commit 6ad669628925e7e8627a5068e116b6bbdf0f87d0
Author: Ricardo B. Marli=C3=A8re <rbm@suse.com>

selftests/bpf: Skip tests whose objects were not built

When tests are not compiled, this commit marks them as not built instead
of fatally aborting. It surfaces these unbuilt tests as skipped in the
output so they remain visible in CI results.

> Tests filtered out by -t/-n remain invisible as before; only genuinely
> unbuilt tests are surfaced.

Does the implementation actually keep filtered tests invisible? Looking at
how the flags are set during initialization, it appears unbuilt tests
might bypass the test selector:

> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -2049,12 +2070,16 @@ int main(int argc, char **argv)
>  		test->should_run =3D should_run(&env.test_selector,
>  					      test->test_num, test->test_name);
> =20
>  		if (test->run_test && test->run_serial_test) {
>  			fprintf(stderr, "Test %d:%s must have either test_%s() or serial_test=
_%sl() defined.\n",
>  				test->test_num, test->test_name, test->test_name, test->test_name);
>  			exit(EXIT_ERR_SETUP_INFRA);
>  		}
> +		if (!test->run_test && !test->run_serial_test) {
> +			test->not_built =3D true;
> +			test->should_run =3D false;
> +			continue;
> +		}

Since test->not_built is set to true regardless of what should_run() return=
ed
for env.test_selector, won't every unbuilt test be flagged as not_built even
if the user filtered it out?

[ ... ]

> @@ -1772,6 +1780,19 @@ static void server_main(void)
>  		run_one_test(i);
>  	}
> =20
> +	/* mark not-built tests as skipped */
> +	for (int i =3D 0; i < prog_test_cnt; i++) {
> +		struct prog_test_def *test =3D &prog_test_defs[i];
> +		struct test_state *state =3D &test_states[i];
> +
> +		if (test->not_built) {
> +			state->tested =3D true;
> +			state->skip_cnt =3D 1;
> +			env.not_built_cnt++;
> +			print_test_result(test, state);
> +		}
> +	}

Will this unconditionally print every unbuilt test in the test suite when
running in parallel mode, directly contradicting the commit message?

[ ... ]

> @@ -2106,9 +2131,18 @@ int main(int argc, char **argv)
> =20
>  	for (i =3D 0; i < prog_test_cnt; i++) {
>  		struct prog_test_def *test =3D &prog_test_defs[i];
> +		struct test_state *state =3D &test_states[i];
> =20
> -		if (!test->should_run)
> +		if (!test->should_run) {
> +			if (test->not_built && !env.get_test_cnt &&
> +			    !env.list_test_names) {
> +				state->tested =3D true;
> +				state->skip_cnt =3D 1;
> +				env.not_built_cnt++;
> +				print_test_result(test, state);
> +			}
>  			continue;
> +		}

Could a similar issue occur here in sequential mode? If a user runs
"./test_progs -t my_test", wouldn't this logic still print "SKIP (not built=
)"
for all the other unbuilt tests that were supposed to be ignored?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260415-selftests-=
bpf_misconfig-v5-0-03d0a52a898a@suse.com?part=3D10
