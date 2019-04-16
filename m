Return-Path: <SRS0=hZ0g=SS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07405C10F13
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 07:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF1D2073F
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 07:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="yv+Y8lpq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbfDPHrO (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 16 Apr 2019 03:47:14 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34971 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728475AbfDPHrO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Apr 2019 03:47:14 -0400
Received: by mail-wm1-f67.google.com with SMTP id y197so12086075wmd.0
        for <bpf@vger.kernel.org>; Tue, 16 Apr 2019 00:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=0Zmi44RmepL3ugmtxZhsUnTuj0oUJ4BCQZi+wmxEsiQ=;
        b=yv+Y8lpqiuq6+04xqrLNfrC6bcajiEAOYQ8gZ7kHQjpkX2ClZvdRLVN6QPHHkJzydu
         ICI7Ej+c9Pg2cunSNpOYYNFCpAkGF2aSLdPOuj3p62QXsG2HwhDVd7MSEqsXLDD5slyE
         RlXoGTg/JYgIrpTSzy/e/5yYNTHO+SDVq71vKjRSYKYMFI++dN1ympvuRvdldrzEOkAp
         +zNHFHwSBgX97G1BRJCGGjXPbbt2S1BJxObCT3dDfsZKgkVNQycR9aTHeFwGTsQAwTIg
         Y264fTeD5w5uyKwCECeidQsHoWl7IrUUsIEa48AmQFJSRmVQHiF5RCXqJy55WVc4EYpS
         X+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=0Zmi44RmepL3ugmtxZhsUnTuj0oUJ4BCQZi+wmxEsiQ=;
        b=LEsKXWIRZgVbT5M4d6FiotZ1zjwWmPnt75ANt+wqJewGkyWtd9a1D7MAm44g1miOVR
         kCpSdoH6/kAV81s5Dw0zLXaToG1+RhPYXy8vDoT9oSejRPQ8BH2FcFPSEc2kshK+pB12
         V51PL8QMIitgZJncwUzLdYCmr6SHdFm7ftfHPAXDyXW0attsuFdKyzhzDLfXH7SOhJMs
         npDW7E1W+JhYdI+eSIovHXuu3mWqiuQcPHbITW1R4Izw+08al8pCvOPPAm06vAmZ/0NH
         KUHRRpWu4dpa6gvXZfwLIYYaj+EFwODsFyBYVDsdQsaIYGXdT7rdUZh9UzuA0KSPfvgB
         vvNQ==
X-Gm-Message-State: APjAAAX1QpVgLP8gG5lzGG5Lxv79qegaTGKbkGeOfTX2lbKTFqlpaV/7
        PFRod8tHVCUD37C02MNGWv1rlMVKbKw=
X-Google-Smtp-Source: APXvYqyrHYUpnJutUwuEdjIcnTaEjf81qGqZ/pbR79liSp0465yfzLDAKbhxB++e5Nx7MyuLASXnKw==
X-Received: by 2002:a1c:9dc8:: with SMTP id g191mr26249448wme.132.1555400831951;
        Tue, 16 Apr 2019 00:47:11 -0700 (PDT)
Received: from cb-macbook.local (cpc1-cmbg19-2-0-cust104.5-4.cable.virginm.net. [82.27.180.105])
        by smtp.gmail.com with ESMTPSA id o17sm64978525wrw.73.2019.04.16.00.47.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 00:47:11 -0700 (PDT)
References: <1555106392-20117-1-git-send-email-jiong.wang@netronome.com> <1555106392-20117-9-git-send-email-jiong.wang@netronome.com> <1555321893.44its0xa9r.naveen@linux.ibm.com> <1555322953.xj35xt2bjs.naveen@linux.ibm.com> <874l6zfr4f.fsf@netronome.com> <1555352013.198bf870q9.naveen@linux.ibm.com> <51F46782-5453-4A5F-A4E4-F53DBF4712AD@netronome.com> <1555396526.uk89zrw6ri.naveen@linux.ibm.com>
User-agent: mu4e 1.0; emacs 26.1
From:   Jiong Wang <jiong.wang@netronome.com>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Jiong Wang <jiong.wang@netronome.com>,
        alexei.starovoitov@gmail.com, bpf@vger.kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org,
        oss-drivers@netronome.com
Subject: Re: [oss-drivers] Re: [PATCH v3 bpf-next 08/19] bpf: insert explicit zero extension insn when hardware doesn't do it implicitly
In-reply-to: <1555396526.uk89zrw6ri.naveen@linux.ibm.com>
Date:   Tue, 16 Apr 2019 08:47:24 +0100
Message-ID: <lyh8ayo0hf.fsf@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Naveen N. Rao writes:

> Jiong Wang wrote:
>>
>>> On 15 Apr 2019, at 19:21, Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.co=
m> wrote:
>>>
>>> Jiong Wang wrote:
>>>> It will be great if you could test the latest set on PowerPC to see if
>>>> there is any regression for example for those under test_progs and
>>>> test_verifier.
>>>
>>> With test_bpf, I am seeing a few failures with this patchset.
>>>
>>>> And it will be even greater if you also use latest llvm snapshot for t=
he
>>>> testing, which then will enable test_progs_32 etc.
>>>
>>> Is a newer llvm a dependency? Or, is this also expected to work with ol=
der llvm levels?
>>
>> There is no newer LLVM dependency. This set should work with older
>> llvm.
>> It is just newer LLVM has better sub-register code-gen support that
>> could       the generate bpf program contains more elimination
>> opportunities for verifier.
>
> Ok, I will try and get to that by next week (busy with other things
> right now).

Great, thanks!

>>>
>>> The set of tests that are failing are listed further below. I looked in=
to MUL_X2 and it looks like zero extension for the two initial ALU32 loads =
(-1) are being removed, resulting in the failure.
>>>
>>> I didn't get to look into this in detail -- am I missing something?
>>
>> Hmm, I guess the issue is:
>>                                                                         =
          1. test_bpf.c
>> is a testsuite running inside kernel space, it is calling some
>>      kernel eBPF jit interface directly without calling verifier first, =
so this
>>      set actually hasn=E2=80=99t been triggered.
>
> Ah, indeed.
>
>>
>>   2. However, the elimination information at the moment is passed from v=
erifier
>>      to JIT backend through
>>
>>        fp->aux->no_verifier_zext
>>
>>      =E2=80=9Cno_verifier_zext=E2=80=9D is initially false, and once ver=
ifier inserted zero
>>      extension, it will be set to true.
>>
>>      Now, for test_bpf, because it doesn=E2=80=99t go through verifier a=
t all, so
>>      =E2=80=9Cno_verifier_zext=E2=80=9D is left at default value which i=
s false, meaning
>>      verifier has inserted zero-extension, so PPC backend then thinks it=
 is
>>      safe to eliminate zero-extension by himself.
>>
>>      Perhaps should change =E2=80=9Cno_verifier_zext=E2=80=9D to =E2=80=
=9Cverifier_zext=E2=80=9D, then default
>>      is false and will only be true when verifier really has inserted ze=
xt.
>
> Yes, that's probably better.
>
>>            Was thinking, this will cause JIT backend writing the
>> check like
>>         if (no_verifier_zext)
>>           insert_zext_by_JIT
>>           is better than:
>>                 if (!verifier_zext)
>>           insert_zext_by_JIT
>>
>> BTW, does test_progs and test_verifier has a full pass on PowerPC?
>> On arch without hardware zext like PowerPC, verifier will insert zext an=
d test
>> mode will still randomisation high 32-bit for those sub-registers not ze=
xt,
>> this is very stressful test.
>
> test_verfier is throwing up one failure with this patchset:
> #569/p ld_abs: vlan + abs, test 1 FAIL
> Failed to load prog 'Success'!
> insn 2463 cannot be patched due to 16-bit range
> verification time 172602 usec
> stack depth 0
> processed 30728 insns (limit 1000000) max_states_per_insn 1 total_states =
1022 peak_states 1022 mark_read 1
>
> This test passes with bpf-next/master. Btw, I tried with your v4
> patches though I am replying here...

ld_abs: vlan + abs is a special test which calls a helper
"bpf_fill_ld_abs_vlan_push_pop" to fill (1 << 15) insns which it the jump
distance maximum. Extra code insertion may overflow some jump inside the
test. The selftest patch in this set changed the one place to ALU64 to
avoid high 32-bit randomization sequence insertion. Now for PowerPC,
zero-extension for low 32-bit could be inserted, so this testcase needs
further adjustment.

I will try to emulate and fix this issue on my x86_64 env.

> test_progs has no regression, but has 15 failures even without these
> patches that I need to look into.

That's a good news to hear no regression on test_progs.

Thanks.

Regards,
Jiong

