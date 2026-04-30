Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95D444CF45
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 15:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777564355; cv=none; b=j4DPifNMzQW/AAJtFJ7FmT3U67g2pYKJu2wA2pBffcbhMEwwXzMyuLPLaNw+hSFUpmUhnl/tmmyj39izwdt04yvzeH/CxzPPUDXoBCC7SsIzc/B3QQFSWJtm+OJgG6+6cK2s93KXqGyR9gJinkfgiGADcAl88m6mn+AnOtawhoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777564355; c=relaxed/simple;
	bh=IVuRovaZgc8SddgoaRNsscreGxylGaJxwXyqkS/+dG8=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=VJ003lQr9T88d9gTSZpmwFEXj2P7eGM7qYeO9Gvre4kh20tMbWvGFdRgZo3LEqeE+BibILcgC/UP+jCLcxaXByfZUw7G6p2oOPV0/bYKxQ0nMTgZJEwatmEbl0b5rX013vXc9QkQ72IK23/iAxCuHvmnL2ZMo2mznX5lQUrdU7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JcFu+BGF; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JcFu+BGF"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso10443675e9.2
        for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 08:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777564351; x=1778169151; darn=vger.kernel.org;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4xVis6IyBoFIIIn2ZBx1+0WJXecMf9Jb/aMUHHXR+8=;
        b=JcFu+BGFcxFIia++yhxYg9m+6h54gaZw/DH7elAdc3wxJSMQJR/H3BY2pxLYAH6/20
         BsNunj/Qfxnwy6aN2zH1FfW4npNPjFWgW0h8LLKKjLLoKwACQCrgc4yaUH7J8+RUnVk7
         bU0GX50AII8sK47x8RJ6AlCzyICCUypsWlC/kVDeIMbWieF5d8C4IEcP8/lvRyUKsazL
         vdhnuicjowCdpjbocIT96j3wKGlO9QFMw400jjQhGENKDIBCv7GtJ1I+8f1dC59M9hrv
         25gQNpihy4FuVtKS2OoiXRCcwCF3hrVPA7uBDinEq6vVTnPIrTE+lE67i6PJWUCy8vS6
         U4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777564351; x=1778169151;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o4xVis6IyBoFIIIn2ZBx1+0WJXecMf9Jb/aMUHHXR+8=;
        b=P1I7PF7GwqABQ+pLhE/SSx/NFMm220JVNhgqN3vbAk1cO1vDlm8aqBv7sKkfiDtA8B
         XWa45OktCzKhitwpFFAW0ATNpjOp3Z/DemdDNAS7Zu2o7uFMPufkVOihS7kqi7452UY3
         qSWq44i77APoD2yu9ccq4zxRQRV3otUCGEPbNtyttgQ+mEsNdCMKCmoQ/oi3yewICqO6
         dsbE09PP6+mA6zLvzRuS8DKkFBhQPws4cMlD2vMvnlQ7+3jmNdgykG6leqIFDYJyO91A
         U94e3MCS55nrvrEkpmleSYtHG/v98hnQtYeUYF/j8yDIT7qlUGOp9DazAvdKQtJgrJDX
         r9hQ==
X-Gm-Message-State: AOJu0YwE9gAK2MAgzIgKZabgM8qZImy0zl3R6X2QXQQPV85HnNKZlUx1
	JzKfVU537pZKmOY4ouLGx1smdopVYft9lqDLibXa4MSSLCrujg5Kk/7jgBgT18NvPac=
X-Gm-Gg: AeBDieulu2eJhefJMpQ33KA4sVoAUuZNM2UJe2ztfPcA3CSza1Rx/RsrOJiQBzKjqTZ
	FQ8E6RUTckvKXQyMOPdEc2ThmBMoake0Ie0+bbhwRRfugNo05M9LM4ig3aGNB1L2cjyKHl0Kjo3
	TqKASsCXSugeSwQdIqaQ/Jr1UFJb1mJdIU4RnM1K/gReYz+hBa3ZFG0ZgkjyYogN2lmYqa0Z/tU
	WP5J41wk9tqtjJ8Rl6IxeCvf2kcTEJulMnimNWY99GkfpTtK2LRjoAXdZKm2vXvG4XOu+yuTmFw
	xkL0/gZZ/k1UlgxhKvJWeO+4edviq36zH+vcUvXw3szq85ZoZ2RTiPCt7n4MVLQjD7zxg+HnSky
	hA1tPFPo0b5HhNuAl6tUtC6bZDzDda9UrUkvk/s24PQEQgA0MeN3YXh2QgwosCZBLgI146jabGV
	fCjECDfmcjxkx5Uu8qndy8o2o=
X-Received: by 2002:a05:600c:a401:b0:488:c80c:c236 with SMTP id 5b1f17b1804b1-48a83f6e3a3mr43007835e9.5.1777564350835;
        Thu, 30 Apr 2026 08:52:30 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:105d:2ecf:67ff:fe81:9da0])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12de326a583sm9901061c88.14.2026.04.30.08.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 08:52:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Apr 2026 12:52:28 -0300
Message-Id: <DI6LZ06Q21O2.38ZFZEES9W13N@suse.com>
To: <bot+bpf-ci@kernel.org>, <rbm@suse.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>,
 <eddyz87@gmail.com>, <memxor@gmail.com>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <shuah@kernel.org>,
 <nathan@kernel.org>, <nick.desaulniers+lkml@gmail.com>, <morbo@google.com>,
 <justinstitt@google.com>
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Subject: Re: [PATCH bpf-next v10 07/11] selftests/bpf: Skip tests whose
 objects were not built
Cc: <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
 <alan.maguire@oracle.com>, <martin.lau@kernel.org>, <clm@meta.com>,
 <ihor.solodrai@linux.dev>
X-Mailer: aerc 0.21.0-120-g22b95d38161f
References: <20260430-selftests-bpf_misconfig-v10-7-cd302a31af16@suse.com>
 <deceeca5bb5e141c8ad07c5ed3754c6b2613fa0b99383614f1cfcc31bd09d39c@mail.kernel.org>
In-Reply-To: <deceeca5bb5e141c8ad07c5ed3754c6b2613fa0b99383614f1cfcc31bd09d39c@mail.kernel.org>

On Thu Apr 30, 2026 at 10:30 AM -03, bot+bpf-ci wrote:
>> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/se=
lftests/bpf/test_progs.c
>> index cc14b13e23fe..7ba82974ee78 100644
>> --- a/tools/testing/selftests/bpf/test_progs.c
>> +++ b/tools/testing/selftests/bpf/test_progs.c
>
> [ ... ]
>
>> @@ -2046,15 +2069,20 @@ int main(int argc, char **argv)
>>  		struct prog_test_def *test =3D &prog_test_defs[i];
>>
>>  		test->test_num =3D i + 1;
>> -		test->should_run =3D should_run(&env.test_selector,
>> -					      test->test_num, test->test_name);
>> +		test->selected =3D should_run(&env.test_selector,
>> +					    test->test_num, test->test_name);
>> +		test->should_run =3D test->selected;
>>
>> -		if ((test->run_test =3D=3D NULL && test->run_serial_test =3D=3D NULL)=
 ||
>> -		    (test->run_test !=3D NULL && test->run_serial_test !=3D NULL)) {
>> +		if (test->run_test && test->run_serial_test) {
>>  			fprintf(stderr, "Test %d:%s must have either test_%s() or serial_tes=
t_%sl() defined.\n",
>>  				test->test_num, test->test_name, test->test_name, test->test_name);
>>  			exit(EXIT_ERR_SETUP_INFRA);
>>  		}
>> +		if (!test->run_test && !test->run_serial_test) {
>> +			test->not_built =3D true;
>> +			test->should_run =3D false;
>> +			continue;
>> +		}
>>  		if (test->should_run)
>>  			test->should_tmon =3D should_tmon(&env.tmon_selector, test->test_nam=
e);
>>  	}
>> @@ -2106,9 +2134,18 @@ int main(int argc, char **argv)
>>
>>  	for (i =3D 0; i < prog_test_cnt; i++) {
>>  		struct prog_test_def *test =3D &prog_test_defs[i];
>> +		struct test_state *state =3D &test_states[i];
>>
>> -		if (!test->should_run)
>> +		if (!test->should_run) {
>> +			if (test->not_built && test->selected &&
>> +			    !env.get_test_cnt && !env.list_test_names) {
>> +				state->tested =3D true;
>> +				state->skip_cnt =3D 1;
>> +				env.not_built_cnt++;
>> +				print_test_result(test, state);
>> +			}
>>  			continue;
>> +		}
>
> When test->should_run is false (which it is for unbuilt tests due to the
> code above setting test->should_run =3D false), the continue statement sk=
ips
> the env.get_test_cnt and env.list_test_names blocks that follow.
>
> Won't this completely omit unbuilt tests from the output of --list (-l) a=
nd
> --count modes? The code only prints unbuilt tests when !env.get_test_cnt =
&&
> !env.list_test_names is true.

It makes no sense to count and list tests that can't be run.

>
> If CI systems use test_progs -l to discover and distribute tests across
> parallel jobs, they won't be aware of unbuilt tests. Could this undermine
> the stated goal of keeping unbuilt tests visible in CI results?

Only if the CI in question sets BPF_STRICT_BUILD=3D0, which is not usually
the case and if opted-in then the user will know that some tests might not
appear and be counted.

>
> Reference: sashiko-bot raised this concern in v10 discussion at
> https://lore.kernel.org/bpf/20260430131344.B40DDC2BCB3@smtp.kernel.org/
>
>>
>>  		if (env.get_test_cnt) {
>>  			env.succ_cnt++;
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/251670=
06036

