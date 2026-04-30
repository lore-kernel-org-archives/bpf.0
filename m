Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745D8413225
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 13:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777554825; cv=none; b=Ugqf4jib+iLcdRkv+/FRqWT836Lu3pcnPmTZT0nx4Cjn6OPZbeD59w/2M53M4gf21N1VMsxpxEV2BEujpD6BSAHcWzU3/ElTL+ZI+bgtLhILYvm1LbWhsH5iWg0b73NM0HEtSTcFjq/GiL1LXMXt0vsLaq5MqYdnHLmqaYulB8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777554825; c=relaxed/simple;
	bh=u3OZptq4wjbEfVVkcREpIJ0nLVI1yx00m0EIRqTeQJ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EHHpLtkvKCl5eQ/3nZc/Lu+hMOv4IkyD/V3w5LsD1yzbcnZCylGv+oRoVmchKoRmWB+tgg4NTGeHkxlPBnp0F+8Wruzuuu3sbvYfruPQzWkUBQZ1K8ORCvZ7ekIl7jJYgv/aCj6N3tvygmlTGCF7xH7uJUtv/wTiLBCYcDga5vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vh0SQE8y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vh0SQE8y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40DDC2BCB3;
	Thu, 30 Apr 2026 13:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777554824;
	bh=u3OZptq4wjbEfVVkcREpIJ0nLVI1yx00m0EIRqTeQJ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Vh0SQE8y9/WUKvoQLhS2nAiCtvaQblRThUoNp0yx1wtCQnuJumfvAd0wKTMPc9H9Z
	 rWZ14oCc08e88fmIvk4y8eP4LgpsF7StgauIgtLH+EkHEeX5ruu+Zyd++H8UeARZN0
	 zDNNFFnkRVD1qDv5SGdnw1UsLSniL3n+hTdnToCt3ug0HSpFjJ4istxYtvTugMG2dL
	 YpC2z19KRWkU1ciL3JOir5MLGtkGtcqMlkta3moATX3wSghJrrnnNq2ntdKrswZ44g
	 pl3vNCj+BceOjOmPJ/ytFLkvZ1yfHWALRaoVdrbIMw9szOUx+kf2ujigmAjmAsHlsQ
	 YwSCmMyZXdgaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v10 07/11] selftests/bpf: Skip tests whose
 objects were not built
Reply-To: sashiko@lists.linux.dev
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260430-selftests-bpf_misconfig-v10-7-cd302a31af16@suse.com>
References: <20260430-selftests-bpf_misconfig-v10-7-cd302a31af16@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Apr 2026 13:13:44 +0000
Message-Id: <20260430131344.B40DDC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unbuilt tests are completely omitted from the output of `--list`=
 (`-l`) and `--count` modes, undermining the goal of keeping them visible i=
n CI.
--

commit 16f4b9e5278a9d4b4fc723587353c47ffcf761e1
Author: Ricardo B. Marli=C3=A8re <rbm@suse.com>

selftests/bpf: Skip tests whose objects were not built

When both run_test and run_serial_test are NULL (because the corresponding
.test.o was not compiled), mark the test as not built instead of fatally
aborting.

> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
> index cc14b13e23fe1..7ba82974ee784 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
[ ... ]
> @@ -2106,9 +2134,18 @@ int main(int argc, char **argv)
> =20
>  	for (i =3D 0; i < prog_test_cnt; i++) {
>  		struct prog_test_def *test =3D &prog_test_defs[i];
> +		struct test_state *state =3D &test_states[i];
> =20
> -		if (!test->should_run)
> +		if (!test->should_run) {
> +			if (test->not_built && test->selected &&
> +			    !env.get_test_cnt && !env.list_test_names) {
> +				state->tested =3D true;
> +				state->skip_cnt =3D 1;
> +				env.not_built_cnt++;
> +				print_test_result(test, state);
> +			}
>  			continue;

Since should_run is set to false for unbuilt tests, will the unconditional
continue here completely omit unbuilt tests from the output of --list (-l) =
and
--count modes?

If these tests are omitted during list mode, CI systems that use test_progs=
 -l
to discover, chunk, and distribute tests across parallel jobs won't be aware
of them.

Could this lead to the unbuilt tests quietly disappearing from final CI
results, undermining the goal of keeping them visible?

> +		}
> =20
>  		if (env.get_test_cnt) {
>  			env.succ_cnt++;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260430-selftests-=
bpf_misconfig-v10-0-cd302a31af16@suse.com?part=3D7
