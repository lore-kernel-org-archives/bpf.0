Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298EF2D63E8
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 18:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776537953; cv=none; b=SGWnXK7sxAsDEOb8CbS1tO5Chf7/oDpLzzpXLZUudAS8xgk9CARv8Mx1WUWCWoOzPOltSbq/SPe8GwhtM/2qIUJSFnqfLaAHUbqWRzjUEkB5dwLa4eSM/1FIEmzUfJo3rrDg1TB9LbsCX9yFdlrsgO9DGZAntOpQEYr4W90y8OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776537953; c=relaxed/simple;
	bh=AoJFuDPiMa4mxdf3Ln1Ht6EhH1o8zZ0TO2ncwXAz1F0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZOiI9nTKuJU5ZEDCKqW5rey0B6BuWp4jrlxApdJdj6VNuWc5o1zhkAkruYosK01RfPuoGDmskkqU7aXUnjO4EhduDgbdwQ9LmNahSiMndLgjRb0d2ocKwsq9DwxqQ3JTkeishPpIrQ5TcwswuBGdPAfYSyIhefIV+dOUR5aKixY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+aE+OTL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+aE+OTL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C983C19424;
	Sat, 18 Apr 2026 18:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776537952;
	bh=AoJFuDPiMa4mxdf3Ln1Ht6EhH1o8zZ0TO2ncwXAz1F0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=X+aE+OTLKpdWH4N5fyQ5T/L1zKodDOtSrSTyEoNeDzAgOVuhut9zBmodUdpc1hd8j
	 JdPaOCxGcOoPM8nmNaNTtCIU5csN1LCc75rVc/5xcnT11P5UZEcIYGtNWw7wBpIlDx
	 lwtBvaUn34E7ch9vqO1ZXLprDccr277ikQqo00TfZsYBVtxojl3xf5w4Uc7CrZq6Ih
	 ClV0lD/uSby9xsVDPhRGrAazZiVU3e6ut9COph0Z+jtdsUxD5fxgIz/jBTHVHj8fC2
	 xJ0mFhzf8tHgxZVvOweTaQMmynmYde62A+dEdz75SnuDD+D5c4SvtuTf2wRV1oRg8H
	 LRurlmefz7qpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 4/4] selftests/bpf: Test verifier warning
 logging
Reply-To: sashiko@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260418171701.610025-5-memxor@gmail.com>
References: <20260418171701.610025-5-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Apr 2026 18:45:51 +0000
Message-Id: <20260418184552.8C983C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] The custom `libbpf_print_cb` unconditionally buffers all log lev=
els into a fixed 4096-byte buffer, which will inevitably overflow during sk=
eleton load and silently drop the expected verifier warnings.
--

commit 602c54794881684bfce8f29591c7e680ab7d51fe
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

selftests/bpf: Test verifier warning logging

This commit adds test coverage for explicit verifier warning logging and=20
libbpf's default warning flush path while keeping the warning bit private=20
to the test.

> diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_implicit_args.c=
 b/tools/testing/selftests/bpf/prog_tests/kfunc_implicit_args.c
> index 5e4793c9c29a0..f92a27d764557 100644
> --- a/tools/testing/selftests/bpf/prog_tests/kfunc_implicit_args.c
> +++ b/tools/testing/selftests/bpf/prog_tests/kfunc_implicit_args.c
> @@ -4,7 +4,99 @@
>  #include <test_progs.h>
>  #include "kfunc_implicit_args.skel.h"
> =20
> +#define TEST_BPF_LOG_LEVEL_WARN	(1U << 4)
> +
> +static size_t libbpf_log_pos;
> +static char libbpf_log_buf[4096];
> +static bool libbpf_log_error;
> +
> +static int libbpf_print_cb(enum libbpf_print_level level, const char *fm=
t, va_list args)
> +{
> +	int emitted_cnt;
> +	size_t left_cnt;
> +
> +	(void)level;
> +
> +	left_cnt =3D sizeof(libbpf_log_buf) - libbpf_log_pos;
> +	emitted_cnt =3D vsnprintf(libbpf_log_buf + libbpf_log_pos, left_cnt, fm=
t, args);
> +	if (emitted_cnt < 0 || emitted_cnt + 1 > left_cnt) {
> +		libbpf_log_error =3D true;
> +		return 0;
> +	}

Since libbpf generates a high volume of LIBBPF_DEBUG and LIBBPF_INFO messag=
es
during object load, will this unconditionally buffer all log levels and ove=
rflow
the 4096-byte buffer before the load completes?

If the buffer overflows, libbpf_log_error becomes true and subsequent messa=
ges
(including the expected verifier warnings flushed at the end of the load) w=
ill
be discarded.

Should this callback filter out non-warning levels to avoid filling the buf=
fer
too quickly?

[ ... ]

> +static void test_default_warning_flush(void)
> +{
> +	libbpf_print_fn_t old_print_cb =3D libbpf_set_print(libbpf_print_cb);
> +	struct kfunc_implicit_args *skel =3D NULL;
> +	int err;
> +
> +	libbpf_log_pos =3D 0;
> +	libbpf_log_buf[0] =3D '\0';
> +	libbpf_log_error =3D false;
> +
> +	skel =3D kfunc_implicit_args__open();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		goto cleanup;
> +
> +	select_legacy_impl_prog(skel);
> +
> +	err =3D kfunc_implicit_args__load(skel);
> +	ASSERT_OK(err, "skel_load");
> +	ASSERT_FALSE(libbpf_log_error, "libbpf_log_error");

Will this assertion predictably fail due to the buffer overflow mentioned
above?

> +	ASSERT_OK_PTR(strstr(libbpf_log_buf, "-- BEGIN PROG LOAD WARNINGS --"),=
 "warn_banner");
> +	ASSERT_OK_PTR(strstr(libbpf_log_buf,
> +			     "uses deprecated kfunc bpf_kfunc_implicit_arg_legacy_impl()"),
> +		      "warn_msg");
> +	ASSERT_NULL(strstr(libbpf_log_buf, "-- BEGIN PROG LOAD LOG --"), "no_ve=
rbose_log");
> +
> +cleanup:
> +	kfunc_implicit_args__destroy(skel);
> +	libbpf_set_print(old_print_cb);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260418171701.6100=
25-1-memxor@gmail.com?part=3D4
