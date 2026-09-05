Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C1843B484
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 07:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788592563; cv=none; b=cYkXGdEoskLsU6m4OooA6ftHrHbURVfTb1d7nMkT6NhPxLpp/GU00cg5j71RLtw7nnRD+vu9NBriAcpw/rKpv9tXfnEN2NJNzjNpmgFKDUOCAIM3mSux4BTFpl+DyE/pHWaeKhPScY6dqj6K9kel8bUkcvj76GD2DoxSdxN9074=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788592563; c=relaxed/simple;
	bh=FX2z931M9bUttii0UU8Rxzxn177SaoIQJPoFDP9gTnI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=BkMsl66pOyd3IQ0c9v9JCV2ULoQeSqj7i33yKCX51Z7Q59oF/wm7JpOab7M5JXOpb55lQNpd4nglDkq17248ZBGLJxSJgKn9bo4oJU1V0zExTJuElPae6oTrYJKVQd+JXynRyt56veM0YV6ocDhQ2dswaKYFukSk8ueUXVjeRlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YIdTmlOe; arc=none smtp.client-ip=74.125.225.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIdTmlOe"
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-484349b1961so683958f8f.1
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 00:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788592560; x=1789197360; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hxyD4Yj6WI8bWk1StHSNdl357kbrjo2XLmREUE/sN4U=;
        b=YIdTmlOercWR1+fCZfGAlB6JxWqoyOh8kEth0FCf+e+wRCZG5+bjNXndIpxYVYtufk
         eAVR5UBcHPGHskKYrlYbCJeympYJi+yf0nRFKLbTR8Ts1cWPTTD+DZSbataY0S7dnjuz
         fjoLoBGsKTBbk9gJEQGoLiNI46G8YxlyBBLfkUxGMr4LYuy8JG568NgdS/iwVQdM/B8f
         F1N4Hl6tuLvso+JnR0EqKONU9apibBAagg1iwN0b/NiN2qKP04cPaTeOyqFbRzm++A4D
         8KzOekZ/qZ7Gcjg6EQcS8rr0QzucT26L4gbs0MIEBZ2vY9uPS6mGBYDo9X1ChacKKnv/
         SABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788592560; x=1789197360;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hxyD4Yj6WI8bWk1StHSNdl357kbrjo2XLmREUE/sN4U=;
        b=d0leUty2NfBgiO8/gSj/aPdeydWlINlhCDaRAJ/6EXTR87Kn8eskFFYpRW672ApLvr
         PaT1w/ZpSlIaU2bfJ7mxg1Wp7wMq3uiQGYpnQ0OSKv7SjwusG6LltfE2mX2wdEAqcM0J
         kMAfd37No2GIxzwmP5JHzwm0s7t5VrXVErSEx0mwa97ayTdJQXqz1EPDgWHIgrDaUMcA
         HBHSb3ywgf/W55rPozcCiiMSWjsaLqhy1wvkICxQYOep8dryuWf+hOz2vq01bZ8hot/J
         +3GCN9tCv0FQUhoGB9tMEFZYx3ipkQpYpJwada5BElIJILg1eqpD5XsEr4BKrqgJ+wYu
         avmw==
X-Gm-Message-State: AFuF++lOoRiShTxV5m+89+/bN1slf/xna8z8lqDMfTubVkvy0VoV5vGZ
	yCyM+SRwaNsX5SxzQC84wyXoeDx3T4uzuWEcNber9X6Jxdi7zpH0/OwatnxbwGpl
X-Gm-Gg: AYBFou1d9QOgnMB/o0cYteonAiHHssBvrkTFxGK/u/DYhc2jNdI8wskS91bxXkwB1o/
	VcjVfy5k4O8H8O9SfHkGP95g1+QU2W0GlsKcjv7vJ2fbmG3X10zVlSOQmbkWgesKLDwJqNM2DUa
	xLZg1UFef8f185JVDALDIwrSTDOl/um/jbICa014mIoBXbxMvYZk9mzCx0Lmq3OtzXyCaBhHZOe
	+kpwR3q34lOBBqDRBWrkG8eaPU8schB2O8ydLk8zTYwxlL0PvTbjBtQyCh1E7BKt8iRYTzOLEUe
	fDnet2XB0XN+izsdpfZWwBqflqCoLxQtHmFQJjVbHj+qjQtOEVCClOQVN0LI1hc0rBjE9GHCKdW
	95Jy5X9JoCMF3HdpFyt5e6tyOTMUypkJufvfyICpCeivxTSH57C7MVazyVMcNmYAec1XA+C0OGQ
	vTJAfKD197q5z3+SOOGHK3bR3V8iYEH90lP5yrSonBw4Glt5lqa0XXelzx3bDzQ5hHa59vsl1PZ
	okhdXxRZY/c0wbOr4JqwoOH4MQ3JzA9mY0DuA8AtyOmNq4aJYAYwb60wJQNqPruB4N1EDxRieog
	vj3/6OCFXcQgnty72ZEBMCBQ1j0=
X-Received: by 2002:a5d:588f:0:b0:485:847f:fd9b with SMTP id ffacd0b85a97d-48586e4a62bmr19188686f8f.6.1788592560006;
        Sat, 05 Sep 2026 00:16:00 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bfe14sm12352166f8f.35.2026.09.05.00.15.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2026 00:15:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 05 Sep 2026 09:15:59 +0200
Message-Id: <DL775AF87XMV.37IX3GZVA1N2H@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf v1 2/8] selftests/bpf: Test killing a loader during
 instruction rewrites
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <sashiko-reviews@lists.linux.dev>
X-Mailer: aerc 0.21.0
References: <20260905070003.3193366-1-memxor@gmail.com>
 <20260905070003.3193366-3-memxor@gmail.com>
 <20260905071354.9089C1F00A3D@smtp.kernel.org>
In-Reply-To: <20260905071354.9089C1F00A3D@smtp.kernel.org>

On Sat Sep 5, 2026 at 9:13 AM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Race condition causing false test failures on extremely fast h=
ardware or optimized verifiers.
> --
>
> commit e86296a4aae66b4d0778df9e0379e5e9bc8a6bff
> Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Subject: selftests/bpf: Test killing a loader during instruction rewrites
>
> This commit adds a selftest to verify that a child process stuck in the
> verifier's quadratic instruction rewrite phase can be successfully termin=
ated
> by a fatal signal.
>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/prog_load_signal.c b=
/tools/testing/selftests/bpf/prog_tests/prog_load_signal.c
>> new file mode 100644
>> index 0000000000000..0f78db3bccc76
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/prog_load_signal.c
> [ ... ]
>> +	if (!pid) {
>> +		close(pipefd[0]);
>> +		if (write(pipefd[1], "x", 1) !=3D 1)
>> +			_exit(1);
>> +		close(pipefd[1]);
>> +		prog_fd =3D bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL",
>> +					insns, NOP_CNT + 2, NULL);
>> +		if (prog_fd >=3D 0)
>> +			close(prog_fd);
>> +		_exit(prog_fd < 0);
>> +	}
>
> [Severity: Medium]
> Could the child process exit too quickly on very fast hardware or with an
> optimized verifier? If the child completes the load before the parent sen=
ds
> SIGKILL, it will exit normally and become a zombie.
>
> [ ... ]
>> +	/*
>> +	 * Allow linear verification to finish before sending SIGKILL. The nop
>> +	 * removal pass is quadratic, so four control-load times still leaves =
a
>> +	 * wide window in which an affected kernel is rewriting instructions.
>> +	 */
>> +	kill_delay =3D MAX(control_time * 4, MIN_KILL_DELAY_NS);
>> +	sleep_ns(kill_delay);
>
> Here, kill_delay enforces a minimum delay of 100ms (MIN_KILL_DELAY_NS). I=
s it
> possible that on modern CPUs with high cache bandwidth, the verifier's 32=
,768
> instruction rewrite could finish in under 100ms?
>
> If control_time is very small, the parent will sleep for 100ms, which mig=
ht
> give the child ample time to finish bpf_prog_load() and exit.
>
> [ ... ]
>> +	start =3D monotonic_ns();
>> +	ret =3D waitpid_timeout(pid, &status, REAP_TIMEOUT_NS);
>> +	if (!ASSERT_EQ(ret, pid, "prog_load_killable")) {
>> +		fprintf(stderr, "control load %llu us, child still alive %llu us afte=
r SIGKILL\n",
>> +			control_time / 1000, (monotonic_ns() - start) / 1000);
>> +		goto cleanup;
>> +	}
>> +	pid =3D -1;
>> +	ASSERT_TRUE(WIFSIGNALED(status) && WTERMSIG(status) =3D=3D SIGKILL,
>> +		    "killed_by_sigkill");
>
> If the child finished early and exited normally as described above, waitp=
id
> will retrieve a normal exit status. This assertion will then incorrectly =
fail
> because the child wasn't killed by the signal.
>
> Could this lead to flaky test failures on fast CI machines?

I tested this locally and it works well, so the test was at least useful in=
 that
regard. It is plausible it ends up being flaky (doens't seem to be right no=
w), I
will leave it for the final person applying to decide whether to skip this =
patch
in the series or not.

