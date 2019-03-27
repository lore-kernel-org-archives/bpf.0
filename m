Return-Path: <SRS0=YLVI=R6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570B4C43381
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 17:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2417A206C0
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 17:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="jDAEqG20"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfC0RSj (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Mar 2019 13:18:39 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37219 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbfC0RSj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Mar 2019 13:18:39 -0400
Received: by mail-wm1-f67.google.com with SMTP id v14so927820wmf.2
        for <bpf@vger.kernel.org>; Wed, 27 Mar 2019 10:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tjN7tzAZKMIUDqaiYT2GK5YnN+CIulXYA4/q1qtxvFg=;
        b=jDAEqG20QyrEQ44C4BAkY50/Fml2iBA+w5oDfY+6DmaWXwN08aJq5h8tbg4Z+UwINJ
         Wo91eqrBo9mSl79u2llWOfkt46WBaxU1X4Fmllg2Z+2c4uziUp+rpYqxl+MdNZvdouxH
         5/fLKFe3V3XvREU1tUE0UewPapkzQwSpNFn0rElpnSFNOyVAS2inqkx4xTj0+uZLF4jp
         TE90R8BMjy1lpEZMH80YZx1Hcpg6VTw19L3zUtJc8pYUr0iYsHnS2kFB4Cq/uSpXfv1r
         NoSWhbyBVE9YZ0MPTGodtmQJNSoN9kjhlTkwE1u6iu1wFb7KpY4BY75dGiJFf1M5NLa/
         D0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tjN7tzAZKMIUDqaiYT2GK5YnN+CIulXYA4/q1qtxvFg=;
        b=FU7wNjbn4AyIwk62kBKRAL2nUown6Pe+9msi2EDNRzKvcatBzyuGkNfhaGUAhk78ux
         qcdOZLSYPSG9GGb3lsctzzRJmo/v+9TasHr4v6schcn0FbB0ZgM/tEusrS/KsTT1dla5
         0EymBY7O7vzXTDYdVcd88+S1WCDBYLcs6ecy/V7f2ETeoW6ZRk5q025BJqM/YjDCC1f9
         GTH0skeJbJbEvRzk+rgO5CiDoSgw7hHAWg7B9HgHMTht+fh+jr5NPV2Dp+j6rkC+/WY8
         mEXN62riTYJclMLBOjNrErnFqnNEu3a7COUQH3KREP7jaOG5WWbkQ0w6MKxDjax50/sp
         0EJg==
X-Gm-Message-State: APjAAAVvuQXqWsAK4yDyKsfcYcNjw6iSsQVkfXLQF+HIjmvrC7nYGrup
        q2bZX8ZzF5zAGtUwthrP5Bef7g==
X-Google-Smtp-Source: APXvYqxlZsO5W6ZoB/OoYTOeWZ86zPWwIO/ICKVMcP5D6//FCWYCjo+l+dQjUfJncWmZBftRyBNtDg==
X-Received: by 2002:a1c:d189:: with SMTP id i131mr19598034wmg.151.1553707117561;
        Wed, 27 Mar 2019 10:18:37 -0700 (PDT)
Received: from [172.20.1.229] ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id 66sm5962026wmd.3.2019.03.27.10.18.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 10:18:36 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH/RFC bpf-next 06/16] bpf: new sysctl "bpf_jit_32bit_opt"
From:   Jiong Wang <jiong.wang@netronome.com>
In-Reply-To: <20190327171717.hnq2ay4ajdl6ztli@ast-mbp>
Date:   Wed, 27 Mar 2019 17:18:35 +0000
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, oss-drivers@netronome.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <15A1CE1E-E86F-4F8D-B43F-DF8A6000640A@netronome.com>
References: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
 <1553623539-15474-7-git-send-email-jiong.wang@netronome.com>
 <20190327170035.qbyli5r5a3cctfca@ast-mbp>
 <352EED46-6368-4A25-B0DC-23D1E736C7A1@netronome.com>
 <20190327171717.hnq2ay4ajdl6ztli@ast-mbp>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On 27 Mar 2019, at 17:17, Alexei Starovoitov =
<alexei.starovoitov@gmail.com> wrote:
>=20
> On Wed, Mar 27, 2019 at 05:06:01PM +0000, Jiong Wang wrote:
>>=20
>>> On 27 Mar 2019, at 17:00, Alexei Starovoitov =
<alexei.starovoitov@gmail.com> wrote:
>>>=20
>>> On Tue, Mar 26, 2019 at 06:05:29PM +0000, Jiong Wang wrote:
>>>> After previous patches, verifier has marked those instructions that =
really
>>>> need zero extension on dst_reg.
>>>>=20
>>>> It is then for all back-ends to decide how to use such information =
to
>>>> eliminate unnecessary zero extension codegen during JIT =
compilation.
>>>>=20
>>>> One approach is:
>>>> 1. Verifier insert explicit zero extension for those instructions =
that
>>>>    need zero extension.
>>>> 2. All JIT back-ends do NOT generate zero extension for =
sub-register
>>>>    write any more.
>>>>=20
>>>> The good thing for this approach is no major change on JIT back-end
>>>> interface, all back-ends could get this optimization.
>>>>=20
>>>> However, only those back-ends that do not have hardware zero =
extension
>>>> want this optimization. For back-ends like x86_64 and AArch64, =
there is
>>>> hardware support, so this optimization should be disabled.
>>>>=20
>>>> This patch introduces new sysctl "bpf_jit_32bit_opt" which is the =
control
>>>> variable for whether the optimization should be enabled.
>>>>=20
>>>> It is initialized using target hook bpf_jit_hardware_zext which is =
default
>>>> true, meaning the underlying hardware will do zero extension =
automatically,
>>>> therefore the optimization will be disabled.
>>>>=20
>>>> Offload targets do not use this native target hook, instead, they =
could
>>>> get the optimization results using bpf_prog_offload_ops.finalize.
>>>>=20
>>>> The user could always enable or disable the optimization by using:
>>>>=20
>>>>  sysctl net/core/bpf_jit_32bit_opt=3D[0 | 1]
>>>=20
>>> I don't think there should be a sysctl for this.
>>=20
>> The sysctl introduced mostly because I think it could be useful for =
testing.
>> For example on x86_64, with this sysctl, we can enable the =
optimisation and
>> can run selftest.
>>=20
>> Does this make sense?
>>=20
>> Or when one insn is marked, we print verbose info, so the tester =
could catch
>> it from log?
>=20
> sysctl in this patch only triggers insertion of shifts.
> what kind of testing does it enable on x64?
> The writing insn is already 32-bit and hw does zero extend.
> These two shifts is always a nop?
> a sysctl to test that the verifier inserted shifts in the right place?

Yes, that=E2=80=99s the test methodology I am using. Match the =
instruction sequence after
shifts insertion.

Regards,
Jiong

