Return-Path: <SRS0=YLVI=R6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CD0C43381
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 17:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2F42082F
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 17:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="OBw5FfxL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfC0RGE (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Mar 2019 13:06:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44410 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727812AbfC0RGE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Mar 2019 13:06:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id y7so15348637wrn.11
        for <bpf@vger.kernel.org>; Wed, 27 Mar 2019 10:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jl5SXk2hssxPH9cY7pQTkW7rn9Tj376YhX3J5OpptWk=;
        b=OBw5FfxLfF5jQCBfr97jqrOjlqQJcZVHWbVtb7YRa8NBFlF44rs/C/7uPrDeNs+UAD
         TfdLUK2n4EO0KZpy0YCyuc0RcHZH1EC5lddH2BP05L7/+hUJubmuGujIx11XfkjrAnGN
         Q/tp1Ubh1Oy0xqls6ywvQDpovy4rNFOW90WkS9l0B5P1kaUE9XUUkk715ms5Jmn3+llr
         zHfqKVItG3eqMgSxggcXd8/9+TEINBYmrzOYUziRcYfw3kOU/rR1UVM7HNUvs6WMrOxc
         TMPexNGobAp/4PaSn2+MW+bCcPdgQMs8lcXc3rnepMfQMtgNiBI77+3qR1OBL5dhr25P
         noOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jl5SXk2hssxPH9cY7pQTkW7rn9Tj376YhX3J5OpptWk=;
        b=cE30b8u+rFVxrgPj2hmmn4ETBcKPTGbMcnJDMMtyYoorcxzXv9drXL3a1wr9SaTBUu
         W+wUvAFMiMeZ1nBpi4CsQEEEHpUQ1ntNnGxDU024fWyq+s0F3opqVu8OzwhbRKXNPYSt
         6Am6bHXNwjrLYYmtSp0aXMG7sERVuUH43bBPbhMQx9JzDGc5yEesVrWZ61UMge93Bk3d
         9SWN6HGw/hZopZ79tXB6LvQ7PKArmpeTLjMp/RP6H1N1fAjDdabxodCkrwWZPSJBmBF0
         UEEE/iHLciMEPT2kO9ffc1pr+YQD3rKtgaz31FdTrWkVKqsz5X7C18rh5fPcN7E7kIs0
         df8g==
X-Gm-Message-State: APjAAAXatYgCgJyy7wbIOZwLCsYRBC8Y4Z5Gv80QucoH0WLcbiF6ziBi
        jiK0jE6MYlv0MN+usEAj2U5ERgQ5TtA=
X-Google-Smtp-Source: APXvYqxHmwX4zs1Uh0mqxrrVPfsMp6am9gAxwY5iAVkxuk2782a54sKlQplHNtxkseDSYsEFAxn5Iw==
X-Received: by 2002:a5d:6246:: with SMTP id m6mr25259408wrv.184.1553706362809;
        Wed, 27 Mar 2019 10:06:02 -0700 (PDT)
Received: from [172.20.1.229] ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id d17sm21461871wrw.88.2019.03.27.10.06.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 10:06:01 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH/RFC bpf-next 06/16] bpf: new sysctl "bpf_jit_32bit_opt"
From:   Jiong Wang <jiong.wang@netronome.com>
In-Reply-To: <20190327170035.qbyli5r5a3cctfca@ast-mbp>
Date:   Wed, 27 Mar 2019 17:06:01 +0000
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, oss-drivers@netronome.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <352EED46-6368-4A25-B0DC-23D1E736C7A1@netronome.com>
References: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
 <1553623539-15474-7-git-send-email-jiong.wang@netronome.com>
 <20190327170035.qbyli5r5a3cctfca@ast-mbp>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On 27 Mar 2019, at 17:00, Alexei Starovoitov =
<alexei.starovoitov@gmail.com> wrote:
>=20
> On Tue, Mar 26, 2019 at 06:05:29PM +0000, Jiong Wang wrote:
>> After previous patches, verifier has marked those instructions that =
really
>> need zero extension on dst_reg.
>>=20
>> It is then for all back-ends to decide how to use such information to
>> eliminate unnecessary zero extension codegen during JIT compilation.
>>=20
>> One approach is:
>>  1. Verifier insert explicit zero extension for those instructions =
that
>>     need zero extension.
>>  2. All JIT back-ends do NOT generate zero extension for sub-register
>>     write any more.
>>=20
>> The good thing for this approach is no major change on JIT back-end
>> interface, all back-ends could get this optimization.
>>=20
>> However, only those back-ends that do not have hardware zero =
extension
>> want this optimization. For back-ends like x86_64 and AArch64, there =
is
>> hardware support, so this optimization should be disabled.
>>=20
>> This patch introduces new sysctl "bpf_jit_32bit_opt" which is the =
control
>> variable for whether the optimization should be enabled.
>>=20
>> It is initialized using target hook bpf_jit_hardware_zext which is =
default
>> true, meaning the underlying hardware will do zero extension =
automatically,
>> therefore the optimization will be disabled.
>>=20
>> Offload targets do not use this native target hook, instead, they =
could
>> get the optimization results using bpf_prog_offload_ops.finalize.
>>=20
>> The user could always enable or disable the optimization by using:
>>=20
>>   sysctl net/core/bpf_jit_32bit_opt=3D[0 | 1]
>=20
> I don't think there should be a sysctl for this.

The sysctl introduced mostly because I think it could be useful for =
testing.
For example on x86_64, with this sysctl, we can enable the optimisation =
and
can run selftest.

Does this make sense?

Or when one insn is marked, we print verbose info, so the tester could =
catch
it from log?
=20

> 32-bit archs and ppc/sparc should always do it, since there is no =
downside
> and for x64/arm64 the verifier won't be inserting shifts because
> bpf_jit_hardware_zext=3D=3Dtrue.
> We probably need a new insn for this.

Agree, and I mentioned this issue on the ToDo in cover letter.

> I'm guessing shifts are not always
> optimal on all archs. There could be arch specific insns that do it.
> I'd love to hear from arch folks though.
>=20

Regards,
Jiong=
