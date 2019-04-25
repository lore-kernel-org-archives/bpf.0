Return-Path: <SRS0=aERf=S3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F763C10F03
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 09:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CE7620878
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 09:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="gQeeKmRC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbfDYJtg (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:49:36 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51441 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfDYJtf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Apr 2019 05:49:35 -0400
Received: by mail-wm1-f67.google.com with SMTP id 4so8411418wmf.1
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2019 02:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qWRXaQdyS2GlB+bwXs66JyzUz7Pm2wK4XVHuodQa4KM=;
        b=gQeeKmRCliW2CG7ZnL5THY3ahfaXnTQ62cp300aC2TxFxJmAgeCkpObaXysjLLXiC9
         oDbA8AH5krJBnUBYcrbh+SN+7gTPrAl7fXbi1s0VkIHWRqNcIhPy1FR0nBTi8G6Toevr
         rWhsMFzcX1cgx66q6XO/aYjBhpfAM3lg6a7ZOXQjmKiI6yv2JkXIXS3Q7NwWTqG+pAUP
         QG9UjLMAU6j55lkwO4lVAgoc1aWnwyeqPDiTGjmdYSh6Nvex37dQZO38QjSdadTyP9RE
         ruWmqSyJTP1Jh2uHw4VN7MluGHDZ2IVM8fBAa28OesOif6acAbA0TUdQd62OG7ZnfTqC
         8Jmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qWRXaQdyS2GlB+bwXs66JyzUz7Pm2wK4XVHuodQa4KM=;
        b=Z7fvGgKSTGNp1ouR47duxq4iPHHywr37T4wYG9zrFjIYmZiF4EYj9iqiSv3XJYlH1Z
         hJgzBF+IvWp0etfxS0U9bm3NxpskoLm9ZT8UDPF2CJyvp7gEKayJH/kek2pUI4td5Ei9
         BKn/86VKkz0gzsxEDlm+VFuOQSOGehANdjjQu7kc3SfbBNsluRgxtkTYBrcPE7rNzjb5
         70KsPCGk+bJlo34dtoUEX0NV4CYCAPRCzLjqX4+aEzDVrOeefE8chgUxca0HmEiLq6KT
         tntkaa9RNgDliMQXgY9IKiTHykr/gMFMX+V1K8hIfEMDZl0YF3OgQrNLSIH3HJ+nh3Bc
         GvXg==
X-Gm-Message-State: APjAAAXnNNrmjbYcJZb8kJCCw1OiSiqS2a3l4UQIFv8tLVtylbIPDSyu
        en4flMdWWIJCc22/nkQmi5J+NA==
X-Google-Smtp-Source: APXvYqzHWg41XQe5Z0ZLyLNHqUFYnS+9EiqMQjhmbXEz/uDb/CK7KIbP4e8x+4K54YXyNSkBAdJiwA==
X-Received: by 2002:a1c:ca06:: with SMTP id a6mr80056wmg.14.1556185773706;
        Thu, 25 Apr 2019 02:49:33 -0700 (PDT)
Received: from [172.20.1.229] ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id e1sm20842184wrw.66.2019.04.25.02.49.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 02:49:33 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: 32-bit zext time complexity (Was Re: [PATCH bpf-next]
 selftests/bpf: two scale tests)
From:   Jiong Wang <jiong.wang@netronome.com>
In-Reply-To: <lylfzyeebr.fsf@netronome.com>
Date:   Thu, 25 Apr 2019 10:49:27 +0100
Cc:     Alexei Starovoitov <ast@kernel.org>, daniel@iogearbox.net,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "oss-drivers@netronome.com" <oss-drivers@netronome.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <690AC61B-84A6-4D1D-888E-F1B7987B9EC9@netronome.com>
References: <20190412214132.2726285-1-ast@kernel.org>
 <lyimv3hujp.fsf@netronome.com>
 <20190425043347.pxrz5ln4m7khebt6@ast-mbp.dhcp.thefacebook.com>
 <lylfzyeebr.fsf@netronome.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On 25 Apr 2019, at 08:25, Jiong Wang <jiong.wang@netronome.com> wrote:
>=20
>=20
> Alexei Starovoitov writes:
>=20
>> On Thu, Apr 25, 2019 at 12:07:06AM +0100, Jiong Wang wrote:
>>>=20
>>> Alexei Starovoitov writes:
>>>=20
>>>> Add two tests to check that sequence of 1024 jumps is verifiable.
>>>>=20
>>>> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>>>> ---
>>>> tools/testing/selftests/bpf/test_verifier.c  | 70 =
++++++++++++++++++++
>>>> tools/testing/selftests/bpf/verifier/scale.c | 18 +++++
>>>=20
>>> I am rebasing 32-bit opt pass on top of latest bpf-next and found =
these new
>>> tests take more than 20 minutes to run and had not finished after =
that.
>>>=20
>>> The reason the following insn filling insde bpf_fill_scale1 is =
generating
>>> nearly 1M insn whose results are recognized as safe to be poisoned.
>>>=20
>>>  bpf_fill_scale1:
>>>    while (i < MAX_TEST_INSNS - 1025)
>>>      insn[i++] =3D BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 42);
>>>=20
>>> For each hi32 poisoning, there will be one call to =
"bpf_patch_insn_data"
>>> which actually is not cheap (adjust jump insns, insn aux info etc). =
Now,
>>> 1M call to it has exhausted server resources as described, 20minutes =
running
>>> still not finished.
>>>=20
>>> For real world applications, we don't do hi32 poisoning, and there =
isn't much
>>> lo32 zext. Benchmarking those bpf programs inside Cilium shows the =
final
>>> zext pass adds about 8% ~ 15% verification time.
>>>=20
>>> The zext pass based on top of "bpf_patch_insn_data" looks more and =
more is
>>> not the best approach to utilize the read32 analysis results.
>>>=20
>>> Previously, in v1 cover letter, I listed some of my other thoughts =
on how to
>>> utilize the liveness analysis results:
>>>=20
>>>   1 Minor change on back-end JIT hook, also pass aux_insn =
information to
>>>     back-ends so they could have per insn information and they could =
do
>>>     zero extension for the marked insn themselves using the most
>>>     efficient native insn.
>>>=20
>>>   2 Introduce zero extension insn for eBPF. Then verifier could =
insert
>>>     the new zext insn instead of lshift + rshift. zext could be =
JITed
>>>     more efficiently.
>>>=20
>>>   3 Otherwise JIT back-ends need to do peephole to catch lshift + =
rshift
>>>     and turn them into native zext.
>>=20
>> all options sounds like hacks to workaround inefficient =
bpf_patch_insn_data().
>> Especially option 2 will work only because single insn is replaced
>> with another insn ?
>=20
> Option 1 should be a generic solution. It is passing verifier analysis
> results generated by insn walk down to JIT back-ends. The information
> passed down could be any analysis result useful for JIT code-gen.
>=20
>> Let's fix the algo of bpf_patch_insn_data() instead, so that 1 insn =
-> 2+ insn
>> is also fast.
>=20
> The issue with 1 insn -> 2+ insn should be calling of bpf_adj_branches
> which is doing another for_each_insn_in_prog traversal, so the zext
> insertion becomes something like:
>=20
>  for_each_insn_in_prog
>  ...
>     if (zext)
>     ...
>       for_each_insn_in_prog
>=20
> which is quadratic. One solution

s/solution/mitigation/

> is we chain all branch insns during
> previous insn traversal in for example cfg check, and keep the =
information
> somewhere info bpf_prog (env->insn_aux_data is a good place to keep =
such
> information, but insn patch helpers are supposed to work with =
bpf_prog)
> then bpf_adj_branches could traversal this chain instead of iterating
> through all insns.
>=20
> Regards,
> Jiong

