Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238C233A9FE
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 16:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776443614; cv=none; b=J+xeAlcvYIiYPASv03hT7aeXjE3ElRdQeMFroBEb5ekZG0z3vdsSCRC6UsnD+dlbU+L4RyrA518c4t9RtWeoKTdhto5Pqm1dZtfFNVNjYhEXBlmqLd/uhAymNwm0S61x2fSXCss+XNCMQtKFZgOmw/S+cvyUDj5H5YSW66cG0GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776443614; c=relaxed/simple;
	bh=ghdx8tgKbgofsieLQWmipni6pdYmJ5TPoxTsETc9QtY=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=CzIVy5J4X3Jodz1BTa99GbxOKjI6gVxT8bW1v3c5lzjMofXqKsW0NHbhsVNZWEeOoul4OlSSze4DTWcZDH4OyTNJtcEGzb26Pv7uNCnfWV5Z7JmK2Q2NvqYZey81Jd8irVJWDG4hpVCB9QJWD20jQC3STqMpW5485hvSj4i/gVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=UqGw/cSv; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="UqGw/cSv"
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2dec803f9f0so1030546eec.0
        for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 09:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1776443610; x=1777048410; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNi7Jz4+o5uJhFpSLvgLhZwNsPkQYsBPf46AVesaADY=;
        b=UqGw/cSv4vOT2NP/EFGl2t5S3+ISvdOgVX5tz1SAUySh1L6D+G+GKCQTTWDJfk0Knu
         4nYK/7cAJqIEaAPZgghz+2PiGg3Wj0JBpvtFCIXWnOI5lxGlEUvGw+BiC02tDbVa9WYl
         2tLSbS+PvDi9K5vpoYrjrjx6iXNrCy8zCBIMyZWYmJOYyRJyi4H02d6oH76dWn19K2Lq
         iGkRRWvVKj8g//PUyUjczMeGIiJxs3PAQYYH5N21Uu7TkchY/oUFOR8vDysmOWqMLzNZ
         WY93iEukXfeKddybB8FJMuKCz3RLf3IwA9XZ2BCGqsjwHcFqhQ62I7u90vxd4M1TURMI
         /PMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776443610; x=1777048410;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mNi7Jz4+o5uJhFpSLvgLhZwNsPkQYsBPf46AVesaADY=;
        b=rzCJiCc67+5ygCb9PIqSiOTr1P7L/+U+Vk0742v00Vymthxrk09lamipoBCdnhOOMR
         vhS8AZYprSwDCIzEKY+6pHR34kVOEmvhV/4SI1VYshDpZU8ieNkN+9lXOmfh/9iSJZH3
         IN/gsmLSjK/UZCLMdPES05B+DCTVQ1p+9M2yPrXSy2z/hw/rfYkFrKOqmTmTdDujJWlZ
         +cMIufu2Y01w1EHt7gwsrVMUIZ8WJgUmaV7tIPWuzJssnFYu+toWlbSYNWv1kDuKgKHO
         SIBFU5bkYy+f3N+SJTXSb6UPbQT5rRWMnqGf5nsiFI2XzQzgmw66kS2ddnPAFKbv8Ld1
         PRhQ==
X-Gm-Message-State: AOJu0YzHwxVmgJO4PSdA/h89DwrhQujKdrFld0sBFgMBo9ipRbCCk68y
	zcJuFhOSfkWZ4UaPfkQUIJcujgyOkEnSaNo1MlnpyX6s08iYrkQuQChIBpeEy9UsI/4=
X-Gm-Gg: AeBDiesZGNU6J0TuL3T/UOAQSvArHNbDCnmM6DPXBaBmCUiD1awsyrvjGtHPfp07Ai6
	aqtxY4tsu0ty4pliehEfgLU4WeQjtf7pddjUfa5PxMP5Z3C0f4He3qD3Gk+fKr6tPeNaIU7DlsM
	wsQtgrXsWzu+RqjhCIomrsLWmCktjHGyMLzJNvQHwzUuqrze+wauJt7frTNX9KWPKkhy1LCSJ/v
	dnY7cxTaIIbcUJEESQUmwGogCSkUHq3MRihzlZONayYdIwnO8cVC0Zbew293TPLgFN6F//qQcIV
	MVl26y9v/3OnOxD4AIxwnuKdRF6JMICInDbhRtEwnm6jHCCntTvzgWTjvDaT9JCdIwB4riSz4LV
	DF0IqragEldKrs2o0xHp6l8jJdAVsunaN0t+jHRoAusZKxxBCjpE5GDqIxoSnhNV7gjsWsyZH+0
	Ul5mbbWAc/rICjYrg=
X-Received: by 2002:a05:7300:3253:b0:2c0:df3b:ec1e with SMTP id 5a478bee46e88-2e42dc0732emr1166368eec.11.1776443609815;
        Fri, 17 Apr 2026 09:33:29 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::5d38])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d9b056fsm3644436eec.29.2026.04.17.09.33.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 09:33:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Apr 2026 12:33:27 -0400
Message-Id: <DHVKPB8FLV9R.7ACP5WZ7Q751@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
 <daniel@iogearbox.net>, <eddyz87@gmail.com>, <song@kernel.org>
Subject: Re: [PATCH bpf-next v7 0/9] Introduce arena library and runtime
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260412174546.18684-1-emil@etsalapatis.com>
 <CAP01T754f+qzWDG=9PyDmOXuL1mn9R9UBAtUor-RdzDGMGZx7Q@mail.gmail.com>
 <DHVIDBPOK7I3.2837ZLDGJOBY@etsalapatis.com>
 <CAP01T75tGi6svN=2oPpw0m+-UcHk2gnOw989fB7GFh6J19ru4g@mail.gmail.com>
In-Reply-To: <CAP01T75tGi6svN=2oPpw0m+-UcHk2gnOw989fB7GFh6J19ru4g@mail.gmail.com>

On Fri Apr 17, 2026 at 12:15 PM EDT, Kumar Kartikeya Dwivedi wrote:
> On Fri, 17 Apr 2026 at 15:43, Emil Tsalapatis <emil@etsalapatis.com> wrot=
e:
>>
>> On Sun Apr 12, 2026 at 3:22 PM EDT, Kumar Kartikeya Dwivedi wrote:
>> > On Sun, 12 Apr 2026 at 19:45, Emil Tsalapatis <emil@etsalapatis.com> w=
rote:
>> >>
>> >> Add a new subdirectory to tools/testing/selftests/bpf called libarena=
,
>> >> along with programs useful for writing arena-based BPF code. This
>> >> patchset adds the following:
>> >>
>> >> 1) libarena, a subdirectory where arena BPF code that is generally us=
eful
>> >> to BPF arena programs can be easily added and tested.
>> >>
>> >> 2) An ASAN runtime for BPF arena programs. BPF arenas allow for acces=
sing
>> >> memory after it has been freed or if it is out of bounds, making it m=
ore
>> >> difficult to triage bugs combined to regular BPF. Use LLVM's recently=
 added
>> >> support for address-space based sanitization to selectively sanitize =
just
>> >> the arena accesses.
>> >>
>> >> 3) A buddy memory allocator that can be reused by BPF programs to han=
dle
>> >> memory allocation/deletion. The allocator uses the ASAN runtime to ad=
d
>> >> address sanitization if requested.
>> >>
>> >> The patch includes testing for the new allocators and ASAN features t=
hat
>> >> can be built from the top directory using "make libarena_test" and
>> >> "make libarena_test_asan". The generated binaries reside in libarena/=
.
>> >> The patch also adds test-progs-based selftests to the codebase for th=
e
>> >> libarena code, so the new tests are run by ./test_progs.
>> >>
>> >
>> > I am back in the same position as I was with comments in [0].
>> >
>> > I.e., again, I don't see anything in the stream output (passing -v to
>> > test_libarena_asan) when I build it with clang 23 (LLVM tip).
>> > What am I doing wrong? (Leaving aside all feedback about integrating
>> > it in the regular test runner that is still unaddressed, thus tests do
>> > not run by default).
>> >
>> >   [0]: https://lore.kernel.org/bpf/CAP01T75+BoQfQN=3D47NhYYviZttjCPb_C=
XNpa=3DDUC0=3DxSvdNZdA@mail.gmail.com
>>
>> The series introduces a selftest for the test runner called libarena. It
>> is introduced in patch 9 to avoid creating a runner that does nothing in
>> the previous patches. Tests run with test_progs like regular selftests.
>> For ASAN we do not have LLVM22 support in the CI yet so test_progs doesn=
't
>> exercise it.
>>
>> The stream output is suppressed by a switch in asan.c to make the output
>> of test_libarena_asan legible. Each test that expects to generate ASAN
>> will generate a ton of output. I will add userspace logic to consume
>> the splats instead of emitting them to keep the output sane.
>
> Why can't we put everything in test_progs instead of separate test_libare=
na?
> Then add some logic like existing stream tests for verifying / testing
> the generated output in ASAN mode.
> For example, libbpf doesn't have its own separate test suite. I think the=
 same
> logic should apply to libarena.
>

libarena is different in that it's BPF code we distribute as source.=20
Plus, the test runner is an example of how to set up the arena state.
It's very little code and automatically identifies the selftests without
having to explicitly enumerate them, so it's not extra maintenance burden.
For followup patches it's been 0 LOC to either the libarena selftest or the
test_progs test.

> If LLVM 22 is a problem just detect and mark the test as skipped for
> now when unavailable.
>

Fair enough we can make it in the Makefile to check if the ASAN flag is
supported by the BPF backend before compiling the selftest, otherwise
make it a no-op.

>>
>> >
>> >> [...]
>>

