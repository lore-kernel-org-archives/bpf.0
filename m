Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F17C2D0C92
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777561467; cv=none; b=Z9QdAh3Xfr/FibOvGt7f661Mjvq93wEOfMF6ShfQfzKIS/r1983CbKWz+h2Bb0c+9KWqrzUovg+ZM1vLa6LLIKhY8DVy2IWahTfsrLh8PU4d+2oO1XZ2FmoOuAdUdnyEBLSTTgrKjsbUTJI8FzyTSP/qUmRcTvISGlzvxHoKlh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777561467; c=relaxed/simple;
	bh=nPl3S5xTCSMNQ8splI/q0IRS2w0nnDEVyrVlcwnPvvU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=p9VT1X1hJHzkxFOSFg5i2gn5Enp7LDUUSEnn+MqluqB7Rz8WP8qA9AMH27hwj65JvH5/Qy/eIertfSkYyyl89XsnF0b3lPYLJ5Qqb+kkHQEnTu73oxVHbjXlPUo8U1A/eNSkr9znc1lfx6Yp82yWppzz11UXym7IcgxgoFrsVp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fUCCBlkl; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fUCCBlkl"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a2c500750dso1807504e87.1
        for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 08:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777561464; x=1778166264; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ryqSrHFMNl2iyHShwOhMHlwgorJnsltwFPZhZyA51sQ=;
        b=fUCCBlklqw5F8ZacokRvqKklNfRxyOz6oomlo7kCGUCXCZr5MK5bJBIk3BYUyArU/U
         SKpgVRZXhW4bSytE9iD2w/xJpQ0XAdTUnubNaUHTaKRdtLz6kW8u0S/O4wyqZRCZ4UH0
         V/eil2l4ZJZKo9WWcUAQFVrPavWiZyVGjNcIE1MUCAKnuT5RFgC/OWCWRPy7geGI2DUr
         l/WYV3E/bDs6LqKTK2yA83XuS66R7dOK+1XQRQRuwDbjzdAzaVw+++IxKgemFiOYQVVL
         hA17Ztb+nu+0XhSVMJ5FxpGHcGhq+ZchyPQKh+zORemlmKMDMr9gFmEECRXcDgnMynE8
         pWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777561464; x=1778166264;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ryqSrHFMNl2iyHShwOhMHlwgorJnsltwFPZhZyA51sQ=;
        b=iMPgHi/HhX0SvDXRNq1n3X5Hj18PCx7WGu5Xfc7CB6nhIBb5zXpOEI83CcbU2ua/ch
         iURQ+LwXJSTtMs7dANUK/D86W281FoxrheL/BmxbzW8VR5TttvfTvP1G+F2DRRZGsFYD
         f8mZz7ZdeOqffGgGWjNuclAUe/PC6oUte5cc9UQFtF0N7+ToMMVJDcZ1r+vo46udF4Pw
         ho9Byg/dq4eftFLMbx2FJ1aEs6ulfXObERBwmJ+mJL6tIL9KBLzocCUEYgZqghmm721X
         ho4qY+V5Q7KBE+i2FXa4UAxvMcmxrxleBwuyDwJjJsaVqlN93lc2h8PKzDGBQVnBVCnZ
         d6vg==
X-Gm-Message-State: AOJu0YxNKVOSUDFe8Mz704CSei4bL79v+7kBa9uEk1WaG67/nF3qpsZs
	i2gIzxQP5mTtCmxBwYXSM7LRbABfAWwTfg9Sb8N24dhNsBhgG2FfgPG17bckzVFn/Sw=
X-Gm-Gg: AeBDiesl/LI5gnNIlvX7ELNLbZOGrdMcRNjHxLA0lVOUJiyN9cAbrKL4rk399WDrgGN
	NEjdbkVKzio0QKG7qr8AUIsOiWj8X6taVImLHou+VHd166wIL/aD9teR1kKwE9JOU4GUGCnlrsX
	4Ap5pwxuLVpqTb1qrwgAslwmXJahPd//wzY6IjIeflakMV1wEKVznqwofPEiA9FpyVialnb3vWb
	a9xQwgahYczU8HiUsJXCptA0ESPOt47TW7KhBeY371uluZBBT5+qmyBVvSw40pMD0IPTzSUHjkv
	/4da4KVoOVz/jqK9k5c4sTK5+w9i/z1JrWqvLc5YBE1ukJLGflsyCkemhGsaiuMp6sy9syWdCIu
	yInkf+0m1urr+VLkpb6NtL6coeXcN2mel2jbrwG6Nvx+V8aZM6I9rZfJgYrRlr01xTzljlM9k0S
	gZ0QUNn1Q7/5rffdP6lJgMTg8=
X-Received: by 2002:a05:6512:1289:b0:5a4:1900:92b1 with SMTP id 2adb3069b0e04-5a8522db66cmr1164817e87.32.1777561462169;
        Thu, 30 Apr 2026 08:04:22 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:105d:2ecf:67ff:fe81:9da0])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12de3261533sm8467722c88.9.2026.04.30.08.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 08:04:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Apr 2026 12:04:18 -0300
Message-Id: <DI6KY4J2N2UB.39XQW4ZLTT1VV@suse.com>
Subject: Re: [PATCH bpf-next v10 05/11] selftests/bpf: Make skeleton headers
 order-only prerequisites of .test.d
Cc: <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
 <alan.maguire@oracle.com>, <martin.lau@kernel.org>, <clm@meta.com>,
 <ihor.solodrai@linux.dev>
To: <bot+bpf-ci@kernel.org>, <rbm@suse.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>,
 <eddyz87@gmail.com>, <memxor@gmail.com>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <shuah@kernel.org>,
 <nathan@kernel.org>, <nick.desaulniers+lkml@gmail.com>, <morbo@google.com>,
 <justinstitt@google.com>
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
X-Mailer: aerc 0.21.0-120-g22b95d38161f
References: <20260430-selftests-bpf_misconfig-v10-5-cd302a31af16@suse.com>
 <4de9eeb57c344c41536f55d67f71254eb43687505ecf15f6c4995d73a8fe49c5@mail.kernel.org>
In-Reply-To: <4de9eeb57c344c41536f55d67f71254eb43687505ecf15f6c4995d73a8fe49c5@mail.kernel.org>

On Thu Apr 30, 2026 at 10:30 AM -03, bot+bpf-ci wrote:
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selfte=
sts/bpf/Makefile
>> index 9a4d8bea0c18..608e6dff0392 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -726,11 +726,11 @@ $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:	=
		\
>>  $(TRUNNER_TEST_OBJS:.o=3D.d): $(TRUNNER_OUTPUT)/%.test.d:			\
>>  			    $(TRUNNER_TESTS_DIR)/%.c			\
>>  			    $(TRUNNER_EXTRA_HDRS)			\
>> +			    $$(BPFOBJ) | $(TRUNNER_OUTPUT)		\
>>  			    $(TRUNNER_BPF_SKELS)			\
>>  			    $(TRUNNER_BPF_LSKELS)			\
>>  			    $(TRUNNER_BPF_LSKELS_SIGNED)		\
>> -			    $(TRUNNER_BPF_SKELS_LINKED)			\
>> -			    $$(BPFOBJ) | $(TRUNNER_OUTPUT)
>> +			    $(TRUNNER_BPF_SKELS_LINKED)
>
> sashiko-bot raised concerns in v9 about the assumption regarding GNU
> Make's behavior with order-only prerequisites. The commit message claims
> that "GNU make builds order-only prerequisites that do not exist," but is
> this correct in the scenario described?
>
> If .test.d already exists and its regular prerequisites are not newer, Ma=
ke
> ignores order-only prerequisites completely. Since the generated .d files
> only declare dependencies for .test.o and not for .test.d itself, modifyi=
ng
> a local header to include a new skeleton doesn't mark .test.d as out-of-d=
ate.

Alright so this seems to be false. A small counter example below
(disclaimer: also LLM output).

/tmp/oo.mk:
# Reproduces the bot's exact scenario from tools/testing/selftests/bpf:
#   .test.o : .c | .test.d                (existing rule)
#   .test.d : .c | <skel headers>         (this patch's change)
# Setup mimics a previous build: .test.o, .test.d, the .c file, and a
# local header all exist on disk; the .d already records that .test.o
# depends on the local header (this is what gcc -MMD captured during the
# previous compile). The local header is then touched -- as if a
# developer had just added a new #include to it -- so .test.o becomes
# timestamp-out-of-date. Crucially, .test.d's own normal prereqs (just
# .c) have NOT been touched, so .test.d is itself "up-to-date": this is
# the bot's exact precondition. A new .skel.h is listed in the
# order-only chain but does not exist on disk yet. The bot claims make
# will silently skip building it. Below shows make builds it anyway.

$(shell rm -rf /tmp/oo; mkdir -p /tmp/oo;                            \
	touch /tmp/oo/foo.c /tmp/oo/local.h;                         \
	printf '%s\n' '/tmp/oo/foo.test.o: /tmp/oo/foo.c /tmp/oo/local.h' \
		> /tmp/oo/foo.test.d;                                \
	touch /tmp/oo/foo.test.o;                                    \
	sleep 0.1;                                                   \
	touch /tmp/oo/local.h)

-include /tmp/oo/foo.test.d

/tmp/oo/foo.test.o: /tmp/oo/foo.c | /tmp/oo/foo.test.d
	@cat /tmp/oo/new.skel.h >/dev/null && touch $@
	@echo "  TEST-OBJ $@"

/tmp/oo/foo.test.d: /tmp/oo/foo.c | /tmp/oo/new.skel.h

/tmp/oo/new.skel.h:
	@echo "/* generated */" > $@
	@echo "  GEN-SKEL $@"

Then run it:

$ make -f /tmp/oo.mk /tmp/oo/foo.test.o
  GEN-SKEL /tmp/oo/new.skel.h
  TEST-OBJ /tmp/oo/foo.test.o

If the order-only chain were skipped at the up-to-date /tmp/oo/foo.test.d,
then /tmp/oo/new.skel.h would never be created, the recipe's cat would fail
with "No such file or directory", and make would abort with Error 1 instead
of relinking /tmp/oo/foo.test.o -- the same failure mode hypothesised for
the real .test.o case. That does not happen.

>
> Could this introduce a race condition or build failures for newly added B=
PF
> skeletons? The new skeleton might not be generated before compilation, ca=
using
> a missing file error when building .test.o.
>
> Additionally, if the new skeleton is concurrently being generated for ano=
ther
> test that correctly tracks it, Make won't enforce dependency ordering for=
 the
> modified test. This could result in gcc reading a partially written .skel=
.h
> file.

With this patch every .test.d entry treats skel headers as order-only, so
there is no "test that does correctly track it" to race against -- the
premise does not hold.

>
> This concern from v9 was not addressed in v10.
>
> Reference: https://lore.kernel.org/bpf/20260429202343.CB842C2BCFA@smtp.ke=
rnel.org/
> Reviewer: sashiko-bot@kernel.org
> Date: Wed, 29 Apr 2026 20:23:42 +0000
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

