Received: from mta1.migadu.com (out-199.mta1.migadu.com [95.215.58.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAB55592E6
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791992511; cv=none; b=Ys5wrglFGgwk1LCyBPSxX/T2AoYDQGe7LW612jj8CoTIBUdtn1GVlW+SCwtyafHxLrD+vtluewmPqTI2TktE0U0vc5koQg0UZUyISRu5KTpGxGfuL0JHO60xig0sSHArH77IaD6Vdi73vgODaCN7e7G2HNc17+DfqswJSbf1Sc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791992511; c=relaxed/simple;
	bh=fxGczMJhHljOujxhYbdBhhKrQIgb8++In36E8MAL/N8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jdQBsfMUmMvDE3owTICJPJu/xO1ZAm0Z8q7xHmKzp2x+o9zsnhs/Mwhg2pHIsA0TfFfev5hsYkiYpyBQVmqZAqagDAYSOkUiWoPUBNzY+msmambYoIKHvOPeJHdgowCU+92H+5+QYj2AtoAmhD1kYjbbPv9wYJ/uoRR+x7jA6EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X2pa5/KI; arc=none smtp.client-ip=95.215.58.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X2pa5/KI"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=fxGczMJhHljOujxhYbdBhhKrQIgb8++In36E8MAL/N8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791992507; v=1; x=1792597307;
 b=X2pa5/KI/ugN2Few4+7wXaVhnKlcX2IcutYKDSv6kN7R/jF+mtIZfiOvVq13/hYwdKnLqXXK
 aY8FDf4xJiziyEEe7i1Xb+BXz83eSg8ffOeg4MRNJZxA/Th2ER8YDmVbr86MBadJtL34gsBRihG
 C+HEo55a6HLOtv6U2T3+6Bgo=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id face5b178b893870;
	Wed, 14 Oct 2026 15:41:47 +0000
X-Mizu-Trace-ID: face5b178b893870
X-Migadu-Flow: FLOW_OUT
Message-ID: <0db65f50adf251e210b6fdda44b5706f641ef4fe.camel@linux.dev>
Subject: Re: [PATCH bpf-next v2 6/7] selftests/bpf: Skip expected_msgs
 subtests when stdout is not saved
From: KaFai Wan <kafai.wan@linux.dev>
To: bot+bpf-ci@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
 john.fastabend@gmail.com, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com,  martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org,  emil@etsalapatis.com,
 ihor.solodrai@linux.dev, shuah@kernel.org, nathan@kernel.org, 
 ndesaulniers@google.com, morbo@google.com, justinstitt@google.com, 
 donggeunyoo.kernel@gmail.com, leon.hwang@linux.dev,
 menglong8.dong@gmail.com,  yatsenko@meta.com, jiangfeng@kylinos.cn,
 bjorn@kernel.org, puranjay@kernel.org,  vineet.gupta@linux.dev,
 mykolal@fb.com, bpf@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org,  llvm@lists.linux.dev
Cc: martin.lau@kernel.org, mason@kernel.org
Date: Wed, 14 Oct 2026 23:41:30 +0800
In-Reply-To: <7b00556c5b846e17d2f940c8b007b64b37dc24219d9c0a31ebbfbedb02f74ea3@mail.kernel.org>
References: <20261014113043.640435-7-kafai.wan@linux.dev>
	 <7b00556c5b846e17d2f940c8b007b64b37dc24219d9c0a31ebbfbedb02f74ea3@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-10-14 at 12:08 +0000, bot+bpf-ci@kernel.org wrote:
> > selftests/bpf: Skip expected_msgs subtests when stdout is not saved
>=20
> TL;DR: Nit only: the new test__skip() in the expected_msgs selftest is si=
lent,
> so -v output doesn't say why subtests were skipped; the review asks wheth=
er to
> print a short reason. The skip logic itself looks correct.
>=20
> > diff --git a/tools/testing/selftests/bpf/prog_tests/prog_tests_framewor=
k.c
> > b/tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c
> > index 53347f379924..b4cd7c7ff439 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c
>=20
> [ ... ]
>=20
> > @@ -169,6 +169,12 @@ void test_prog_tests_framework_expected_msgs(void)
> >=20
> > =C2=A0	for (i =3D 0; i < ARRAY_SIZE(cases); i++) {
> > =C2=A0		if (test__start_subtest(cases[i].name)) {
> > +			if (!env.subtest_state->stdout_saved) {
> > +				test__skip();
> > +				test__end_subtest();
> > +				continue;
> > +			}
> > +
>=20
> This isn't a bug, but a subsystem guideline flags a test__skip() that is
> issued silently, with no message.
>=20
> test__skip() here is called without any explanation, so a -v run only sho=
ws
> the generic "#N/M <subtest>:SKIP" line from test__end_subtest().=C2=A0 So=
meone
> reading that output has to look at the code or the commit message to lear=
n
> the subtests were skipped because stdout is not captured in non-parallel
> verbose mode.
>=20
> The skip itself looks correct, since stdio_hijack_init() returns early wh=
en
> verbose() && env.worker_id =3D=3D -1 and leaves subtest_state->stdout_sav=
ed and
> log_buf unset.=C2=A0 test__skip() takes no reason argument, and many othe=
r
> test__skip() callers in prog_tests are also bare.
>=20
> Would it be worth printing a short reason before test__skip(), for exampl=
e:
>=20
> =C2=A0=C2=A0=C2=A0 fprintf(stderr, "SKIP: stdout is not saved in non-para=
llel verbose mode\n");

I don't think we need this. for two reasons:
a) -v is mainly used for debugging, showing details; this is a test for the=
 framework, not the real
bpf test, all tests should pass, no need to debug;
b) this is a loop. if we keep adding this message, it could repeat for 9 li=
nes.
>=20
> > =C2=A0			error_cnt =3D env.subtest_state->error_cnt;
> > =C2=A0			msgs.patterns =3D cases[i].pats;
> > =C2=A0			msgs.cnt =3D 0;
>=20
>=20
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>=20
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/385595=
67568

--=20
Thanks,
KaFai
