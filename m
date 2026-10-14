Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70762F7F05
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 06:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791959880; cv=none; b=qaZw8Jh4M+2I53sDux8lF04ffQluK7hwBDstyA/Adkeo1Sef6/wVOpC1kJj1SUSXg6Ayl8R/1HDkAdUL9k0pg8GeyvxCFCKd+mLu05G7+laqsBt86FUcNjXsqi7wfzig4BK2VKEVB29l68rGnk/h0PZLKE5EjPtAg/yQSJutjYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791959880; c=relaxed/simple;
	bh=ECV3oaqJGPxfzOxcf2JSzP0Ld5kVQ0Hhq3CGs653n94=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=Qbyqb4zZSrZFf9lZiHkrfG363fdDN7PZ3llpyCy7TMKTTO6D3JCaEt/U5XaClS+oBTYnGeqjRvVP4e2HEOw1m5ptM65kr/PgLBQRilwtLlckAV60dDH4nXYnq1PBO6D6NWIF7kqnjL0F1nZrmxhkkILd2RdWJx3KaFKnD4S5ir8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvQQ/ooQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvQQ/ooQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86BC1F000FF;
	Wed, 14 Oct 2026 06:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791959875;
	bh=WYRJtx7FR7sEVv8Ahd72/ILi+f3pwTJZlJTmXSJVJbw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=AvQQ/ooQ5scZbFK+oTeq0UyDB70DpkSxtFx/yVDITCQ8SQSv6QUWlIsl9w9WLefc7
	 QyxC4eW/g5EZ5jZSR4cy1fbLqPcyhoDDeEsObNjG4OE/EYK2AYNsPiiUiQJP1R05jX
	 /6w1Uiv7SclU9ZQYJG8FPMhZ1q91bSRy62YyKWvjklV14q6KzPyJ44bykISWfcJ409
	 q6k10y9n4N1Vnw0KDkY0dQBjh929XF+BIwllnAVtPZZ7Tz3s1Z8cCGD7zCJxVicoPF
	 3LHtjzfhcpiEYOmDAUeyDTspvobwNDFlA9yCdPM4zy1Uls/QhrW2pmLAEWUvv6epIT
	 HWXdsVsNcD/Zw==
Message-ID: <sashiko-outbox-170874@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 6/7] selftests/bpf: harden __msg patterns
 for step_movsx_bounds_on_line
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261013-scev-minimal-v3-followups-v2-6-6d9d61965486@gmail.com>
References: <20261013-scev-minimal-v3-followups-v2-0-6d9d61965486@gmail.com>
 <20261013-scev-minimal-v3-followups-v2-6-6d9d61965486@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 06:37:54 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf/selftests: missing closing parenthesis in regex pattern allows =
test to pass incorrectly
--

commit 0cba693bc29a347d1c334a9ea3f7803ac49d1bab
Author: Eduard Zingerman <eddyz87@gmail.com>

selftests/bpf: harden __msg patterns for step_movsx_bounds_on_line

The commit drops the __no_step annotations and replaces them with full
expected logs to prevent {{.*}} from matching and hiding step=3D... logging.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds_step.c b/t=
ools/testing/selftests/bpf/progs/verifier_bounds_step.c
> index c9ee1c7efcbb8..d824a5d48a394 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bounds_step.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bounds_step.c
> @@ -338,9 +338,9 @@ SEC("socket")
>  __success __log_level(2)
>  __msg("r1 =3D (s16)r0 {{.*}}R1=3Dscalar(id=3D{{[0-9]+}},smin=3Dsmin32=3D=
0,smax=3Dumax=3Dsmax32=3Dumax32=3D168,{{.*}}step=3D0+24)")
>  __msg("r2 =3D (s16)r0 {{.*}}R2=3Dscalar(smin=3Dsmin32=3D-24,smax=3Dsmax3=
2=3D144,{{.*}}step=3D0+24)")
> -__msg("r3 =3D (s8)r0 {{.*}}R3=3Dscalar(smin=3Dsmin32=3D-128,smax=3Dsmax3=
2=3D127)") __no_step
> +__msg("r3 =3D (s8)r0 {{.*}}R3=3Dscalar(smin=3Dsmin32=3D-128,smax=3Dsmax3=
2=3D127)")

[Severity: Low]
Is this string literal missing a closing parenthesis after 127?

Since the explicit __no_step check was removed, and the test_loader uses
unanchored regex matching for patterns containing {{.*}}, matching as a
prefix allows the test to silently succeed even if the verifier incorrectly
appends step=3D... to the log.

Should the pattern be 127)) to strictly match the end of the scalar state
and preserve the intended test coverage?

>  __msg("w4 =3D (s16)w1 {{.*}}R4=3Dscalar(id=3D{{[0-9]+}},smin=3Dsmin32=3D=
0,smax=3Dumax=3Dsmax32=3Dumax32=3D168,{{.*}}step=3D0+24)")
> -__msg("w5 =3D (s8)w1 {{.*}}R5=3Dscalar({{.*}}smin32=3D-128,smax32=3D127,=
{{.*}})") __no_step
> +__msg("w5 =3D (s8)w1 {{.*}}R5=3Dscalar({{.*}}smin32=3D-128,smax32=3D127,=
var_off=3D(0x0; 0xffffffff))")
>  __naked void step_movsx_bounds_on_line(void)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-scev-minim=
al-v3-followups-v2-0-6d9d61965486@gmail.com?part=3D6
