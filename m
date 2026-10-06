Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3182430E82B
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 19:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791315640; cv=none; b=qxjSPjTksvx4pjiIPgqXI4WmeugoVpwSTFouPwH2OTEStxHE1zOj5Js4Dcag11ezXM+/qYicOSTLU9I4tnsBdt0gjzgTGHr40SDn3aRtkzX1OJDpTFUS3JE2i6egOQrbWB0J89AJqT1lKF3kYMMDCAQqmhl6vbyyzgyD9kjMC3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791315640; c=relaxed/simple;
	bh=pv7d/KDTpDXzfHcUAIwT1jeFxIorJR36amVh2IaINDk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ncwuIbtKcmmIM/S7z/+3A+MGurefmmchK6IJ+FRjqhvhATa8am2UtykJ3EWH4TZiShuRi/HJMhe418PTNmnTOeOjMVgrcE1R6W5EAXv9bA4+i5vov+gFR+U8msC51NXDa0e+IIKCZOoFB6gW1l6mT20AIhUU1t8B7RXDRbJdunk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koSVpzj9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koSVpzj9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F3851F0089B;
	Tue,  6 Oct 2026 19:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791315638;
	bh=I31OBaiK+MJZkJtrEaNCxqlsWB0yD5rDwPAhVklCvlY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=koSVpzj9WSD3MR0SsgonZCt1Sga7UD+mg6ampoWRh1zI93xhmpRoE1JvbTMC54IjO
	 ETggMpJa3m0vTrO5UiHy773HMLh2lFPSBnii+L7C4OGp5HWG13q5wpsUmzy2jxoLAm
	 Tn0WW+XrSKhXLynSuB3sRc7rPhVnAC6b1mg2daz6nGZ1b6Dk8AuklzDlQkDG2cNUch
	 WmR3PkZrWdfkkRVaTfR9bpqaOxedkDtpx8b+4+l/Fo7d5mv21gnbdfMJwnMNNGJ/k2
	 y3p5blcMP6wRd6reQS/2/0Z2hinvWXruOncL6Pntel6cvh/1/NRdgXHG2mnAdDuiY6
	 AvJXQ+1fDl2tg==
Message-ID: <sashiko-outbox-162402@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] bpf: test: parallel execution of basic tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Antipov" <dmantipov@yandex.ru>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261006192840.155680-1-dmantipov@yandex.ru>
References: <20261006192840.155680-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 19:40:38 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] bpf: test: missing workqueue cleanup on error paths in test_bpf_=
init()
- [Medium] bpf: data race on global net_device dev in populate_skb()
- [Low] bpf: test: silent log drop for expected failures and generation err=
ors
- [Low] bpf: memory leak of bpf_prog in generate_filter() error paths
--

commit eef3e387313bc16bbeb43208bc729ec2b250d2a8
Author: Dmitry Antipov <dmantipov@yandex.ru>

bpf: test: parallel execution of basic tests

This commit implements a workqueue-based parallel execution for the basic
BPF tests, adding a legacy fallback option.

> diff --git a/lib/test_bpf.c b/lib/test_bpf.c
> --- a/lib/test_bpf.c
> +++ b/lib/test_bpf.c
> @@ -15012,14 +15032,14 @@ static struct bpf_prog *generate_filter(int whi=
ch, int *err)
>  		fprog.len =3D flen;
> =20
>  		*err =3D bpf_prog_create(&fp, &fprog);
> -		if (tests[which].aux & FLAG_EXPECTED_FAIL) {
> -			if (*err =3D=3D tests[which].expected_errcode) {
> -				pr_cont("PASS\n");
> +		if (test->aux & FLAG_EXPECTED_FAIL) {
> +			if (*err =3D=3D test->expected_errcode) {
> +				test_log(test, "PASS\n");
>  				/* Verifier rejected filter as expected. */
>  				*err =3D 0;
>  				return NULL;
>  			} else {
> -				pr_cont("UNEXPECTED_PASS\n");
> +				test_log(test, "UNEXPECTED_PASS\n");
>  				/* Verifier didn't reject the test that's
>  				 * bad enough, just return!
>  				 */
>  				*err =3D -EINVAL;
>  				return NULL;
>  			}

[Severity: Low]
Is there a memory leak of the fp pointer on an unexpected pass?

If bpf_prog_create successfully allocates fp (returning 0) but the test
was marked with FLAG_EXPECTED_FAIL, this branch sets *err to -EINVAL and
returns NULL without cleaning up the allocated fp.

[ ... ]

>  		/* We cannot error here as we don't need type compatibility
> @@ -15055,7 +15075,7 @@ static struct bpf_prog *generate_filter(int which=
, int *err)
>  		 */
>  		fp =3D bpf_prog_select_runtime(fp, err);
>  		if (*err) {
> -			pr_cont("FAIL to select_runtime err=3D%d\n", *err);
> +			test_log(test, "FAIL to select_runtime err=3D%d\n", *err);
>  			return NULL;
>  		}
>  		break;

[Severity: Low]
Similarly, if bpf_prog_select_runtime fails, it returns the allocated
fp. Could returning NULL here without freeing it result in a memory leak?

[ ... ]

>  static void test_bpf_work_handler(struct work_struct *work)
>  {
[ ... ]
> +	if (fp =3D=3D NULL) {
> +		if (err =3D=3D 0) {
> +			atomic_inc(&pass_cnt);
> +			return;
> +		}
> +		atomic_inc(&err_cnt);
> +		return;
> +	}

[Severity: Low]
Is it intended for this early return to bypass printing the test output
buffered in test->output?

For tests marked with FLAG_EXPECTED_FAIL that successfully trigger a
verifier rejection, or for unexpected generation errors, returning
early here skips the final pr_info call, which causes the test log
output to be completely lost.

[ ... ]

> +	err =3D run_one(fp, test);

[Severity: Medium]
Can parallel workers executing run_one() cause a data race on the global
net_device dev in populate_skb()?

Workers execute this path concurrently, and generate_test_data() calls
populate_skb(), which unconditionally writes to the shared static struct
net_device dev without synchronization:

lib/test_bpf.c:populate_skb() {
    ...
    dev_net_set(&dev, &init_net);
    skb->dev =3D &dev;
    skb->dev->ifindex =3D SKB_DEV_IFINDEX;
    skb->dev->type =3D SKB_DEV_TYPE;
    ...
}

[ ... ]

>  static int __init test_bpf_init(void)
>  {
[ ... ]
>  	if (!strlen(test_suite) || !strcmp(test_suite, "test_bpf")) {
>  		ret =3D test_bpf();
>  		if (ret)
>  			return ret;
>  	}
> =20
>  	if (!strlen(test_suite) || !strcmp(test_suite, "test_tail_calls")) {
>  		ret =3D prepare_tail_call_tests(&progs);
>  		if (ret)
>  			return ret;
>  		ret =3D test_tail_calls(progs);
>  		destroy_tail_call_tests(progs);
>  		if (ret)
>  			return ret;
>  	}

[Severity: Medium]
Would these error paths leave the newly allocated bpf_wq workqueue leaked
during module initialization?

If test_bpf(), prepare_tail_call_tests(), or test_tail_calls() return an
error code, the direct return paths leave the globally allocated bpf_wq
un-freed. Should these error paths be calling destroy_workqueue(bpf_wq)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006192840.1556=
80-1-dmantipov@yandex.ru?part=3D1
