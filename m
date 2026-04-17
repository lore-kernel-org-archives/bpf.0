Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0EA364E88
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 18:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776448986; cv=none; b=jSRZzmdb48WxtlS6RukRZ5e6N8SjV8hnapX4Q17q5bL3m4NdJ4a1xxcJGoMR/dIPdqcvnH9weYqC4LlAWRjjL4m1DMT1nOW9F8XvGzQMjuXT+7L8tReeofQ6cujIeJwjeTaoLuVEJjY+R3hsaPDr+wHcUfF09JBndlSGnU1RueY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776448986; c=relaxed/simple;
	bh=KjodOoyjQ0nVOvhjWh1saHGTZu/FNWgXyaFyE+UwguM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=lFwLsAYiHpGFQOTKUY3N0xdz/WmXVkyfRyLVKquYHyY9zwwosq3TAOqncz8L/JEbk977/tIzU3V/aLl3E8r2j6hS9wnIRdtBoOZ1uKNEtp0CJw8B2cnD4pFS7pBiuwtuA2cp1fbfoppqdCsEtKNTFxBwV6alkF75N8+GDVSiwLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=mazXmyWp; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="mazXmyWp"
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-2ba895adfeaso1195657eec.0
        for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 11:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1776448983; x=1777053783; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNfsUi6dKL4uDXHe9b9tC7iPpuj36X282q3k7wwkmRY=;
        b=mazXmyWp/e5+ay2JDKn8P9F3OTHAYJRqk94gVGA0dwkQeKDilkreR118OLDZ/9F6F+
         SFmmX7U+2d6Iwl5+1AooSPJG2vX18OMht5aqJYKzX9dYvdpJzaUkJICsQf2CbbYmSbJW
         aPcg40ehBto5j+gKXQhliK4YNg4Dfcl/4VKYk7pa5C6i+/0FoA9pz+9jQTtuBOFeMRdy
         OyD7ivlek8N5XUGixSmpNdxy37HOrxZpShGVHILRz/WuW51gj/+f0Yn9f3jW2BICm9Nu
         npZ9JefXjK1YihQLSpJK+xwpU1vLIPYsSY2s4InaRc2LKPQ6W4cYDkXIKWvjsmJ7BvXU
         GWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776448983; x=1777053783;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zNfsUi6dKL4uDXHe9b9tC7iPpuj36X282q3k7wwkmRY=;
        b=hoRP2SMagWkQk4yDnpFl0k64P0w6E3Tn/RIfHoC3BKpxN45MZUtjIdfLhyu4hOX3rX
         hmD6FFoOm+gB56F+/Os0xMrUtRdOCfmoSRk3ntEVH8ZtbPXwVuYGnr6ZbaIh2c0VXIG8
         sAMZ4//FAVV0MmdQo9QhphbBhaK/gjdl3fz551YOJoyKishgi10hncJ8SfjHOU+BNZlV
         TLmZhjK2IfeY7QuxuicbaFFEukplae22A4irb19+2SQs99jROdLUksi1GrZt4CzlFLqU
         Z3XGUs9rtFYurgzVRSuk0PMwgvx3FVQsZZ1DvwCCD7rirQlzTdPnHyhK+wKTrIubYevL
         0WZw==
X-Forwarded-Encrypted: i=1; AFNElJ9irB1U92AiaYcoUAn0hmUr8FC7DdV6Lnj9DG3eVYk53Qny4TzODQNOVnNyECbAUKv3r/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1By78jhBXE1r5C6wmYAvC1UADuQteqMX9ygakNShTeOZCIYEi
	HG/31d/mA7r+2L1F60U7V3KK7U+Foh+opOFtoW0Dpjx2TeaaxtINtZbJCZEf6dQrHOoC8pihiCF
	yITEmItd6KY2uuzo=
X-Gm-Gg: AeBDievr22RaEn6g3lwk+KotZXr2ykj6CZYYHYLhU1gVbeVT8T/n+KiVxPMMnSt3TiP
	V9rDv49GhA4ZH7HXV6BpGJALOAeZIotznw8yxKaH8QvMBD2qOYsIAkU6NWUZXZ8gH+FyIXIjaYa
	Ukq0FZE+7nwOdmbh+/em4IZyJ8EEkR2PYnCBMFzBZhNLrY7G4n+IsYlEFKytzm3Huf/Ba4EGKDs
	I5Jg0rr0thmeAADilcKInrIuDD2cEJlzPaYTKk1OK9q521ZBs2DmKBZndjsqMfHEqtSUAh2iKsv
	8ua4rRqaeKxH8iqhdd6zWefBoTXrGmbMmvAHwQCEymTiwbiq5wMsliSaHNAvn/HivqEfqzOdQFm
	YZPxr1QluQBDZ/S0LN3Mnl1w3V7I+9Pp9V5fAFK4J3TEHK41KOnFaVbaS8LebYySSMJ2jPAYoMT
	sNIYMHb+sPLG+OfUk=
X-Received: by 2002:a05:7301:1693:b0:2d4:7656:4ec1 with SMTP id 5a478bee46e88-2e47873a687mr2272896eec.17.1776448982504;
        Fri, 17 Apr 2026 11:03:02 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::c769])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53a4a8018sm4052844eec.8.2026.04.17.11.03.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 11:03:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Apr 2026 14:03:00 -0400
Message-Id: <DHVMLVAMJT7X.GMOA3L4111QN@etsalapatis.com>
Cc: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "bpf"
 <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Eduard" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>
Subject: Re: [PATCH bpf-next v7 0/9] Introduce arena library and runtime
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260412174546.18684-1-emil@etsalapatis.com>
 <CAP01T754f+qzWDG=9PyDmOXuL1mn9R9UBAtUor-RdzDGMGZx7Q@mail.gmail.com>
 <DHVIDBPOK7I3.2837ZLDGJOBY@etsalapatis.com>
 <CAP01T75tGi6svN=2oPpw0m+-UcHk2gnOw989fB7GFh6J19ru4g@mail.gmail.com>
 <DHVKPB8FLV9R.7ACP5WZ7Q751@etsalapatis.com>
 <CAADnVQLtxN_+H0KKFdukO48c9zsR9m4RzpEQGhj0RHMUFvu9AA@mail.gmail.com>
In-Reply-To: <CAADnVQLtxN_+H0KKFdukO48c9zsR9m4RzpEQGhj0RHMUFvu9AA@mail.gmail.com>

On Fri Apr 17, 2026 at 1:06 PM EDT, Alexei Starovoitov wrote:
> On Fri, Apr 17, 2026 at 9:33=E2=80=AFAM Emil Tsalapatis <emil@etsalapatis=
.com> wrote:
>>
>> On Fri Apr 17, 2026 at 12:15 PM EDT, Kumar Kartikeya Dwivedi wrote:
>> > On Fri, 17 Apr 2026 at 15:43, Emil Tsalapatis <emil@etsalapatis.com> w=
rote:
>> >>
>> >> On Sun Apr 12, 2026 at 3:22 PM EDT, Kumar Kartikeya Dwivedi wrote:
>> >> > On Sun, 12 Apr 2026 at 19:45, Emil Tsalapatis <emil@etsalapatis.com=
> wrote:
>> >> >>
>> >> >> Add a new subdirectory to tools/testing/selftests/bpf called libar=
ena,
>> >> >> along with programs useful for writing arena-based BPF code. This
>> >> >> patchset adds the following:
>> >> >>
>> >> >> 1) libarena, a subdirectory where arena BPF code that is generally=
 useful
>> >> >> to BPF arena programs can be easily added and tested.
>> >> >>
>> >> >> 2) An ASAN runtime for BPF arena programs. BPF arenas allow for ac=
cessing
>> >> >> memory after it has been freed or if it is out of bounds, making i=
t more
>> >> >> difficult to triage bugs combined to regular BPF. Use LLVM's recen=
tly added
>> >> >> support for address-space based sanitization to selectively saniti=
ze just
>> >> >> the arena accesses.
>> >> >>
>> >> >> 3) A buddy memory allocator that can be reused by BPF programs to =
handle
>> >> >> memory allocation/deletion. The allocator uses the ASAN runtime to=
 add
>> >> >> address sanitization if requested.
>> >> >>
>> >> >> The patch includes testing for the new allocators and ASAN feature=
s that
>> >> >> can be built from the top directory using "make libarena_test" and
>> >> >> "make libarena_test_asan". The generated binaries reside in libare=
na/.
>> >> >> The patch also adds test-progs-based selftests to the codebase for=
 the
>> >> >> libarena code, so the new tests are run by ./test_progs.
>> >> >>
>> >> >
>> >> > I am back in the same position as I was with comments in [0].
>> >> >
>> >> > I.e., again, I don't see anything in the stream output (passing -v =
to
>> >> > test_libarena_asan) when I build it with clang 23 (LLVM tip).
>> >> > What am I doing wrong? (Leaving aside all feedback about integratin=
g
>> >> > it in the regular test runner that is still unaddressed, thus tests=
 do
>> >> > not run by default).
>> >> >
>> >> >   [0]: https://lore.kernel.org/bpf/CAP01T75+BoQfQN=3D47NhYYviZttjCP=
b_CXNpa=3DDUC0=3DxSvdNZdA@mail.gmail.com
>> >>
>> >> The series introduces a selftest for the test runner called libarena.=
 It
>> >> is introduced in patch 9 to avoid creating a runner that does nothing=
 in
>> >> the previous patches. Tests run with test_progs like regular selftest=
s.
>> >> For ASAN we do not have LLVM22 support in the CI yet so test_progs do=
esn't
>> >> exercise it.
>> >>
>> >> The stream output is suppressed by a switch in asan.c to make the out=
put
>> >> of test_libarena_asan legible. Each test that expects to generate ASA=
N
>> >> will generate a ton of output. I will add userspace logic to consume
>> >> the splats instead of emitting them to keep the output sane.
>> >
>> > Why can't we put everything in test_progs instead of separate test_lib=
arena?
>> > Then add some logic like existing stream tests for verifying / testing
>> > the generated output in ASAN mode.
>> > For example, libbpf doesn't have its own separate test suite. I think =
the same
>> > logic should apply to libarena.
>> >
>>
>> libarena is different in that it's BPF code we distribute as source.
>> Plus, the test runner is an example of how to set up the arena state.
>> It's very little code and automatically identifies the selftests without
>> having to explicitly enumerate them, so it's not extra maintenance burde=
n.
>> For followup patches it's been 0 LOC to either the libarena selftest or =
the
>> test_progs test.
>
> I think what Kumar is saying is that we have only one runner in CI:
> test_progs, so all libarena tests need to be covered by test_progs.

In that case I misunderstood. I agree that everything should be tested
by test_progs. There's currently the ASAN version of libarena missing,
but we can add it and turn it off if the compiler doesn't support it.

There is the secondary question: Do we want to have a standalone
libarena runner in addition to the one in test_progs in the codebase?
Imo we do, for the reasons above.
