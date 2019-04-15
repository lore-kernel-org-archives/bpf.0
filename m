Return-Path: <SRS0=RZwz=SR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB05C282DF
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 19:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB6020818
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 19:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="kTW9C0Dg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbfDOT2n (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:28:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42180 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729562AbfDOT2n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Apr 2019 15:28:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id g3so23415014wrx.9
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2019 12:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WOn1/FnGpXgH2U3uMHs8uMnX/4GX3BWy3nCMBAmq6oA=;
        b=kTW9C0DgRZLJrkt6t6azL6mKU0jObt5rhVLfT+CYSa45KhBh3FdigEVPW2LEKoGGgU
         jA7WSLr/jJaF6XtoHI1WpIlOuG0LYPRtWKXHKR4FrF4Xze9B4SjPpAVX+2ihjavwqZUM
         35oI6vw069tv4YMTPaS7uSPzUQ/bnTb3utz1Mg6Ka/CVHAaADhbkd7mTfzxQktOv0LyS
         iIG6BnX/n4vUxubJaxhGAhgiSRDlspnv5tEIPfDyh0ALLNMYGCOEdext3ctsHpS2FwpE
         rn8zikbP6f7JH+OhYDPRX3Eq5IE1lNTkWYUpdwhqfFeeGr6M+rVpuBwxtrjaZ3SpGywA
         QIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WOn1/FnGpXgH2U3uMHs8uMnX/4GX3BWy3nCMBAmq6oA=;
        b=BjB1OjCc5C1N5VYusITh5lnLIWfu7sKP9IksFK8LJNIX3wwYYx7Wh22EMpjWh9y7FF
         zJ+R6XN1kv/k0CfSw/+77DNiU1AflEnqqVA8zv8xZjUBfxbNde0VdEMR2MhTzQ+dhi4E
         4ghI4WMhl8z71AyeUqMG68UFEQNSo6OeDY4ATJuw5Xj04hwvkLPGcnxOLYcQSy8RAeuN
         5lW0+jdimt2TPf3YxgrXM0ZWdTBYxdc2sbL6GYTs3oI34Gt71Booy2RHgrCDo5Kh6Y12
         rx75HxjZHDGpfm+azBIvf5YxAEGi9tSYbhc0i6+SMU+JPdEJLfG50RldP79WB6va1nCT
         QudQ==
X-Gm-Message-State: APjAAAUMOnpatqQKa/de1uAioWYedyhP/WHoUo48OWFdwExWlc8aUvZI
        aTYAavFeY2m/rlv8R+Z/Q3iveQ==
X-Google-Smtp-Source: APXvYqz15FI5v98mi4L/qFTtuY4jDt62Jd9ThDlP/xZzqD30rrRFunIPYfMj/iawGVeEoxQXvTUPQg==
X-Received: by 2002:adf:f1c6:: with SMTP id z6mr47650298wro.232.1555356520964;
        Mon, 15 Apr 2019 12:28:40 -0700 (PDT)
Received: from [192.168.0.23] (cpc1-cmbg19-2-0-cust104.5-4.cable.virginm.net. [82.27.180.105])
        by smtp.gmail.com with ESMTPSA id e1sm84005117wrw.66.2019.04.15.12.28.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 12:28:39 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3 bpf-next 08/19] bpf: insert explicit zero extension
 insn when hardware doesn't do it implicitly
From:   Jiong Wang <jiong.wang@netronome.com>
In-Reply-To: <1555352013.198bf870q9.naveen@linux.ibm.com>
Date:   Mon, 15 Apr 2019 20:28:50 +0100
Cc:     alexei.starovoitov@gmail.com, bpf@vger.kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org,
        oss-drivers@netronome.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <51F46782-5453-4A5F-A4E4-F53DBF4712AD@netronome.com>
References: <1555106392-20117-1-git-send-email-jiong.wang@netronome.com>
 <1555106392-20117-9-git-send-email-jiong.wang@netronome.com>
 <1555321893.44its0xa9r.naveen@linux.ibm.com>
 <1555322953.xj35xt2bjs.naveen@linux.ibm.com> <874l6zfr4f.fsf@netronome.com>
 <1555352013.198bf870q9.naveen@linux.ibm.com>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: Apple Mail (2.3273)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On 15 Apr 2019, at 19:21, Naveen N. Rao =
<naveen.n.rao@linux.vnet.ibm.com> wrote:
>=20
> Jiong Wang wrote:
>> It will be great if you could test the latest set on PowerPC to see =
if
>> there is any regression for example for those under test_progs and
>> test_verifier.
>=20
> With test_bpf, I am seeing a few failures with this patchset.
>=20
>> And it will be even greater if you also use latest llvm snapshot for =
the
>> testing, which then will enable test_progs_32 etc.
>=20
> Is a newer llvm a dependency? Or, is this also expected to work with =
older llvm levels?

There is no newer LLVM dependency. This set should work with older llvm. =
      =20
                                                                         =
      =20
It is just newer LLVM has better sub-register code-gen support that =
could      =20
the generate bpf program contains more elimination opportunities for =
verifier.

>=20
> The set of tests that are failing are listed further below. I looked =
into MUL_X2 and it looks like zero extension for the two initial ALU32 =
loads (-1) are being removed, resulting in the failure.
>=20
> I didn't get to look into this in detail -- am I missing something?

Hmm, I guess the issue is:
                                                                         =
      =20
  1. test_bpf.c is a testsuite running inside kernel space, it is =
calling some
     kernel eBPF jit interface directly without calling verifier first, =
so this
     set actually hasn=E2=80=99t been triggered.

  2. However, the elimination information at the moment is passed from =
verifier
     to JIT backend through

       fp->aux->no_verifier_zext

     =E2=80=9Cno_verifier_zext=E2=80=9D is initially false, and once =
verifier inserted zero
     extension, it will be set to true.

     Now, for test_bpf, because it doesn=E2=80=99t go through verifier =
at all, so
     =E2=80=9Cno_verifier_zext=E2=80=9D is left at default value which =
is false, meaning
     verifier has inserted zero-extension, so PPC backend then thinks it =
is
     safe to eliminate zero-extension by himself.

     Perhaps should change =E2=80=9Cno_verifier_zext=E2=80=9D to =
=E2=80=9Cverifier_zext=E2=80=9D, then default
     is false and will only be true when verifier really has inserted =
zext.
     =20
     Was thinking, this will cause JIT backend writing the check like
        if (no_verifier_zext)
          insert_zext_by_JIT
    =20
     is better than:
       =20
        if (!verifier_zext)
          insert_zext_by_JIT

BTW, does test_progs and test_verifier has a full pass on PowerPC?
On arch without hardware zext like PowerPC, verifier will insert zext =
and test
mode will still randomisation high 32-bit for those sub-registers not =
zext,
this is very stressful test.

Regards,
Jiong

>=20
>=20
> - Naveen
>=20
>=20
> ---
> $ cat ~/jit_fail.out | grep -v "JIT code" | grep -B4 FAIL
> test_bpf: #38 INT: MUL_X2 Pass 1: shrink =3D 0, seen =3D 0x0
> Pass 2: shrink =3D 0, seen =3D 0x0
> flen=3D9 proglen=3D64 pass=3D3 image=3Dd000000006bfca9c from=3Dinsmod =
pid=3D8923
> jited:1 ret -1 !=3D 1 FAIL (1 times)
> test_bpf: #39 INT: MUL32_X Pass 1: shrink =3D 0, seen =3D 0x0
> Pass 2: shrink =3D 0, seen =3D 0x0
> flen=3D9 proglen=3D64 pass=3D3 image=3Dd000000006c335fc from=3Dinsmod =
pid=3D8923
> jited:1 ret -1 !=3D 1 FAIL (1 times)
>=20
> test_bpf: #49 INT: shifts by register Pass 1: shrink =3D 0, seen =3D =
0x0
> Pass 2: shrink =3D 0, seen =3D 0x0
> flen=3D30 proglen=3D192 pass=3D3 image=3Dd000000006eb80e4 from=3Dinsmod =
pid=3D8923
> jited:1 ret -1234 !=3D -1 FAIL (1 times)
>=20
> test_bpf: #68 ALU_MOV_K: 0x0000ffffffff0000 =3D 0x00000000ffffffff =
Pass 1: shrink =3D 0, seen =3D 0x0
> Pass 2: shrink =3D 0, seen =3D 0x0
> flen=3D10 proglen=3D76 pass=3D3 image=3Dd000000007290e48 from=3Dinsmod =
pid=3D8923
> jited:1 ret 2 !=3D 1 FAIL (1 times)
>=20
> test_bpf: #75 ALU_ADD_X: 2 + 4294967294 =3D 0 Pass 1: shrink =3D 0, =
seen =3D 0x0
> Pass 2: shrink =3D 0, seen =3D 0x0
> flen=3D10 proglen=3D64 pass=3D3 image=3Dd0000000074537b0 from=3Dinsmod =
pid=3D8923
> jited:1 ret 0 !=3D 1 FAIL (1 times)
>=20
> test_bpf: #82 ALU_ADD_K: 4294967294 + 2 =3D 0 Pass 1: shrink =3D 0, =
seen =3D 0x0
> Pass 2: shrink =3D 0, seen =3D 0x0
> flen=3D8 proglen=3D60 pass=3D3 image=3Dd00000000761af8c from=3Dinsmod =
pid=3D8923
> jited:1 ret 0 !=3D 1 FAIL (1 times)
> test_bpf: #83 ALU_ADD_K: 0 + (-1) =3D 0x00000000ffffffff Pass 1: =
shrink =3D 0, seen =3D 0x0
> Pass 2: shrink =3D 0, seen =3D 0x0
> flen=3D10 proglen=3D64 pass=3D3 image=3Dd0000000076579dc from=3Dinsmod =
pid=3D8923
> jited:1 ret 2 !=3D 1 FAIL (1 times)
>=20
> test_bpf: #86 ALU_ADD_K: 0 + 0x80000000 =3D 0x80000000 Pass 1: shrink =
=3D 0, seen =3D 0x0
> Pass 2: shrink =3D 0, seen =3D 0x0
> flen=3D10 proglen=3D64 pass=3D3 image=3Dd000000007719958 from=3Dinsmod =
pid=3D8923
> jited:1 ret 2 !=3D 1 FAIL (1 times)
> test_bpf: #87 ALU_ADD_K: 0 + 0x80008000 =3D 0x80008000 Pass 1: shrink =
=3D 0, seen =3D 0x0
> Pass 2: shrink =3D 0, seen =3D 0x0
> flen=3D10 proglen=3D72 pass=3D3 image=3Dd000000007752510 from=3Dinsmod =
pid=3D8923
> jited:1 ret 2 !=3D 1 FAIL (1 times)
>=20
> test_bpf: #118 ALU_MUL_K: 1 * (-1) =3D 0x00000000ffffffff Pass 1: =
shrink =3D 0, seen =3D 0x0
> Pass 2: shrink =3D 0, seen =3D 0x0
> flen=3D10 proglen=3D64 pass=3D3 image=3Dd000000007f184f8 from=3Dinsmod =
pid=3D8923
> jited:1 ret 2 !=3D 1 FAIL (1 times)
>=20
> test_bpf: #371 JNE signed compare, test 1 Pass 1: shrink =3D 0, seen =3D=
 0x0
> Pass 2: shrink =3D 0, seen =3D 0x0
> flen=3D8 proglen=3D60 pass=3D3 image=3Dd000000002394ab8 from=3Dinsmod =
pid=3D8923
> jited:1 ret 2 !=3D 1 FAIL (1 times)
> test_bpf: #372 JNE signed compare, test 2 Pass 1: shrink =3D 0, seen =3D=
 0x0
> Pass 2: shrink =3D 0, seen =3D 0x0
> flen=3D8 proglen=3D60 pass=3D3 image=3Dd0000000023d98b4 from=3Dinsmod =
pid=3D8923
> jited:1 ret 2 !=3D 1 FAIL (1 times)
>=20
> Pass 1: shrink =3D 0, seen =3D 0x18
> Pass 2: shrink =3D 0, seen =3D 0x18
> flen=3D13 proglen=3D92 pass=3D3 image=3Dd0000000025105f8 from=3Dinsmod =
pid=3D8923
> jited:1 12 PASS
> test_bpf: Summary: 366 PASSED, 12 FAILED, [366/366 JIT'ed]
>=20
>=20
>=20

