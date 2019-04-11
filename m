Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5607C10F13
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 21:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA7D21850
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 21:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="Vz/9ZIpY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfDKVtY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Apr 2019 17:49:24 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45390 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbfDKVtY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Apr 2019 17:49:24 -0400
Received: by mail-wr1-f65.google.com with SMTP id s15so9228389wra.12
        for <bpf@vger.kernel.org>; Thu, 11 Apr 2019 14:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kgOn6KRso2UiWP9ySi+VQVTa8EAxCrN6o04q2B6tRd0=;
        b=Vz/9ZIpYQEukdkdSGGFjUIP9Ou2BzkOwjEZXyGelcWJY9jc+fpjqCYuQ8UocHB3dxt
         jcnH0pXd56D6zPu8ui4x+yMozy/ZLKeauJBbp45HIjOSGWKP6AcA6NgZNLovol3mgRFz
         SUMb1oxFL60jX4Mk5kvEj04pnerRPZISuxpzVQTa5AzZOSlb/0AADYbdTJVGSP+OKKU6
         cgNfApjXbaTsIsCANr7PIzvWGUazCLdh58tAQ/cxZnbSpIKqOERsTkvTH/zU/f5jyKuz
         RM6QHj/fWkCXrLE6MejgrN0XvTyKfIGjvZRyiWGPzZJwpFId+2VjAijoJZGda/p/Y1Mp
         MBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kgOn6KRso2UiWP9ySi+VQVTa8EAxCrN6o04q2B6tRd0=;
        b=GFF3c23C9vyqWj3taAKtFPyhjrl5pUWBe4FOH9EY4Y6pbLdCvzzRvJekcfpk3jhlu8
         voZEC6tGQiGvOightUOeVImEVHwEK23mojIXzymgQTodYd/6cGywtSTakTFw/Eyd5a6+
         Ci2zGjIByeIGERoCd30fBgsd6Wxy12nmnF6lP0Iv2F7uW8IdUukUwFlSa0p9ER4wf4bS
         +SuQUKYgWxK7S5lQfpjh7/fCS57aS3WFCAQ1igqYfEt0tsR1DkJjilDsNJeHySY9p8Fj
         1VJcSeweujuDVymzzDKrSQOCL/bpBuw64sdYxTHX+9LH74JRXsUucdgVRRtf7xFVQJW4
         nTEg==
X-Gm-Message-State: APjAAAVwAcQoKDP2Cshgon5p6/qNJOxUDVmAdLP0WodTemen3h6FeS8g
        4kmh2V96qTUMNaGasVM4sGFWHA==
X-Google-Smtp-Source: APXvYqyVi8e/xJvab3dmBUTOklObADo4uxk7NC8w0Hcu/LcKADGC+GQm0uOl37GonEoWGOCYKRGMTA==
X-Received: by 2002:a5d:62c4:: with SMTP id o4mr12338181wrv.282.1555019362317;
        Thu, 11 Apr 2019 14:49:22 -0700 (PDT)
Received: from [192.168.0.23] (cpc1-cmbg19-2-0-cust104.5-4.cable.virginm.net. [82.27.180.105])
        by smtp.gmail.com with ESMTPSA id u17sm11147399wmu.36.2019.04.11.14.49.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 14:49:21 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH/RFC v2 bpf-next 11/19] libbpf: new global variable
 "libbpf_test_mode"
From:   Jiong Wang <jiong.wang@netronome.com>
In-Reply-To: <ECEC6F69-18BE-43C8-A5A7-818631F98D52@netronome.com>
Date:   Thu, 11 Apr 2019 22:49:22 +0100
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, oss-drivers@netronome.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <AE6C1BDB-0491-4471-BBA8-7DA3989D4E1E@netronome.com>
References: <1554925833-7333-1-git-send-email-jiong.wang@netronome.com>
 <1554925833-7333-12-git-send-email-jiong.wang@netronome.com>
 <20190410201913.44dbf536@cakuba.netronome.com>
 <ECEC6F69-18BE-43C8-A5A7-818631F98D52@netronome.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
X-Mailer: Apple Mail (2.3273)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On 11 Apr 2019, at 15:32, Jiong Wang <jiong.wang@netronome.com> wrote:
>=20
>=20
>> On 11 Apr 2019, at 04:19, Jakub Kicinski =
<jakub.kicinski@netronome.com> wrote:
>>=20
>> On Wed, 10 Apr 2019 20:50:25 +0100, Jiong Wang wrote:
>>> Enable BPF_F_TEST_RND_HI32 for all existing bpf selftests or other
>>> independent tests could involve quite a few changes to make sure all =
bpf
>>> prog load places has BPF_F_TEST_RND_HI32 set.
>>>=20
>>> Given most of the tests are using libbpf, this patch introduces a =
new
>>> global variable "libbpf_test_mode" into libbpf, once which is set, =
all bpf
>>> prog load issued through libbpf will have BPF_F_TEST_RND_HI32 set
>>> automatically, this could minimize changes required from testsuite.
>>>=20
>>> The other way might be introducing new load function like
>>> "bpf_prog_test_load", which will set BPF_F_TEST_RND_HI32. But there =
are
>>> several prog load APIs, and we need minor changes on some =
parameters.
>>>=20
>>> The global variable approach seems to be a proper first step for =
easy
>>> testsuite porting.
>>>=20
>>> Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
>>=20
>> Can we perhaps make it per-object by setting it after
>> bpf_object__open() but before bpf_object__load(), or add=20
>> it to struct bpf_object_open_attr?
>=20
> Not sure I followed the meaning correctly. My read is you mean it =
would
> better if there is more accurate and fine control on this feature, =
especially
> if prog_flags could become an API parameter during file/obj/prog load?
>=20
> As mentioned in the cover letter, I tried to implement =
bpf_prog_test_load
> In parallel with existing bpf_prog_test_run, but then found there are
> also similar APIs for bpf_object__open, and raw insn load =
=E2=80=9Cbpf_load_progams=E2=80=9D
> etc and they may involve extending =
bpf_prog_load_attr/bpf_load_program_attr
> etc. I thought the change is a little bit heavy. I could go further if =
it
> is thought to be the correct way or there is any other suggestion on =
nicely
> passing =E2=80=9Cprog_flags=E2=80=9D to low level bpf syscall in =
libbpf.
>=20

Would really appreciate more feedbacks on how to do the libbpf change =
for      =20
the next patch set re-spin.

Whether this global variable approach is acceptable or we must find =
another    =20
way which enable high 32-bit randomization for all tests under           =
      =20
test_verifier/test_progs with reasonable testsuite and libbpf change.    =
      =20

I feel the global variable approach taken in this patch has done its job =
      =20
with minimum change, that is to offer a interface to enable high 32-bit  =
      =20
randomization for all tests under test_verifier/test_progs to deliver    =
      =20
equal stressfull tests on x86_64 platform and to expose bugs in the      =
       =20
optimization, now given there is no regression, we could have confidence =
      =20
on the correctness of the optimization. If we want a more clean change =
in      =20
libbpf, it is more about how to offer clean API to pass "prog_flags" =
when      =20
load file/obj/raw_insn, it looks to me could be a separate patch set.    =
      =20
However, for this set, we also need to make sure high 32-bit =
randomization      =20
*always enabled* for all test_verifier + test_progs so the new opt is
tested in daily bpf selftest.

Regards,
Jiong

