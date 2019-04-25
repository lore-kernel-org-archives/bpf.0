Return-Path: <SRS0=aERf=S3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DDAC10F03
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 07:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0543218B0
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 07:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="FvUXZYKX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbfDYHZs (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:25:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36106 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfDYHZs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Apr 2019 03:25:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id b1so17452933wru.3
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2019 00:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=jnhrBEVumNHtOAPF2q0RxCPH2jdfAMf7mCGWLB2O550=;
        b=FvUXZYKX8LKyGLH0RmxyyXShAr4Pzl0McbIpudim7j5bMKWrpKrjriI/EC2qk4sB8i
         d9fjwVXgEeE9w8prHnHA3mT3Y9MuB1e4Lllq096HBeJd6OOvTu6sxGK2nOuCzCohuvJU
         BQihFweU5d7GAAfSnYbwkTivWWv9XqK+ogQ4bXc1zOCe6SKHdcAg9OubvGaW7M/YF26G
         kgu1xY7kYns5Ds5SXUtbzPagDbjCiWSN9tMRMA5nlZI7GtKKQ9Qhiw2bOUXYFrmRQWz8
         s/XODGBj/C/mZ99fgLjSxm1kA6hLVSO16vn6XNmSsmF/rwXdM6T1+3a4rq2eOsDkn7kY
         oJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=jnhrBEVumNHtOAPF2q0RxCPH2jdfAMf7mCGWLB2O550=;
        b=GcAptQXKA5ToSYkkCXe0Yy0UukexMBeTKlxg48YRjjtqmQuhawWKuarFLzoRYPHyh/
         4m6malVCTVaVsP6ht3gTi6IJdJSiKnzR+9SCyChx3aX2bH1Li8xSUPfXHZ7HSSe0qRAh
         02CcsEMeuzvq5Avx4RnhFgL3zn79HfssOfIkzFYAF9Y5B2xTeUKZ0OpXfgpk2Y2S5Vcv
         NqMMIgwEfywkUKnZjSAXsMrGXyucKpHaWX03lzbSiPYvbmaPrwAZOcaVI9xdHAKmLM4G
         Qy/IgYQ11FK/2aozA2GPJvAoPlgGZgiT5jL/4hJNkQHnc4DuXUWQan3v7lmwd2fky6i+
         OAzQ==
X-Gm-Message-State: APjAAAX2/+gmaTKdq0tAzzhwkjQeMqr+bZVxBxyqfDQPWFs3bDdm5BAY
        LSmcuU5aEtzUSHLqdY0CjaGFTw==
X-Google-Smtp-Source: APXvYqzo8b7t+Mr5ku1ENjazhZcBagROdF79ALMIZN+YfhDNx9m8xehUjXiMZE0Fi9s9UnfqpBrMtQ==
X-Received: by 2002:a5d:53c8:: with SMTP id a8mr1990016wrw.38.1556177146406;
        Thu, 25 Apr 2019 00:25:46 -0700 (PDT)
Received: from cb-macbook.local (cpc1-cmbg19-2-0-cust104.5-4.cable.virginm.net. [82.27.180.105])
        by smtp.gmail.com with ESMTPSA id s4sm7015548wrt.94.2019.04.25.00.25.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 00:25:45 -0700 (PDT)
References: <20190412214132.2726285-1-ast@kernel.org> <lyimv3hujp.fsf@netronome.com> <20190425043347.pxrz5ln4m7khebt6@ast-mbp.dhcp.thefacebook.com>
User-agent: mu4e 1.0; emacs 26.1
From:   Jiong Wang <jiong.wang@netronome.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiong Wang <jiong.wang@netronome.com>,
        Alexei Starovoitov <ast@kernel.org>, daniel@iogearbox.net,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "oss-drivers\@netronome.com" <oss-drivers@netronome.com>
Subject: Re: 32-bit zext time complexity (Was Re: [PATCH bpf-next] selftests/bpf: two scale tests)
In-reply-to: <20190425043347.pxrz5ln4m7khebt6@ast-mbp.dhcp.thefacebook.com>
Date:   Thu, 25 Apr 2019 08:25:44 +0100
Message-ID: <lylfzyeebr.fsf@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Alexei Starovoitov writes:

> On Thu, Apr 25, 2019 at 12:07:06AM +0100, Jiong Wang wrote:
>> 
>> Alexei Starovoitov writes:
>> 
>> > Add two tests to check that sequence of 1024 jumps is verifiable.
>> >
>> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>> > ---
>> >  tools/testing/selftests/bpf/test_verifier.c  | 70 ++++++++++++++++++++
>> >  tools/testing/selftests/bpf/verifier/scale.c | 18 +++++
>> 
>> I am rebasing 32-bit opt pass on top of latest bpf-next and found these new
>> tests take more than 20 minutes to run and had not finished after that.
>> 
>> The reason the following insn filling insde bpf_fill_scale1 is generating
>> nearly 1M insn whose results are recognized as safe to be poisoned.
>> 
>>   bpf_fill_scale1:
>>     while (i < MAX_TEST_INSNS - 1025)
>>       insn[i++] = BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 42);
>> 
>> For each hi32 poisoning, there will be one call to "bpf_patch_insn_data"
>> which actually is not cheap (adjust jump insns, insn aux info etc). Now,
>> 1M call to it has exhausted server resources as described, 20minutes running
>> still not finished.
>> 
>> For real world applications, we don't do hi32 poisoning, and there isn't much
>> lo32 zext. Benchmarking those bpf programs inside Cilium shows the final
>> zext pass adds about 8% ~ 15% verification time.
>> 
>> The zext pass based on top of "bpf_patch_insn_data" looks more and more is
>> not the best approach to utilize the read32 analysis results.
>> 
>> Previously, in v1 cover letter, I listed some of my other thoughts on how to
>> utilize the liveness analysis results:
>> 
>>    1 Minor change on back-end JIT hook, also pass aux_insn information to
>>      back-ends so they could have per insn information and they could do
>>      zero extension for the marked insn themselves using the most
>>      efficient native insn.
>> 
>>    2 Introduce zero extension insn for eBPF. Then verifier could insert
>>      the new zext insn instead of lshift + rshift. zext could be JITed
>>      more efficiently.
>> 
>>    3 Otherwise JIT back-ends need to do peephole to catch lshift + rshift
>>      and turn them into native zext.
>
> all options sounds like hacks to workaround inefficient bpf_patch_insn_data().
> Especially option 2 will work only because single insn is replaced
> with another insn ?

Option 1 should be a generic solution. It is passing verifier analysis
results generated by insn walk down to JIT back-ends. The information
passed down could be any analysis result useful for JIT code-gen.

> Let's fix the algo of bpf_patch_insn_data() instead, so that 1 insn -> 2+ insn
> is also fast.

The issue with 1 insn -> 2+ insn should be calling of bpf_adj_branches
which is doing another for_each_insn_in_prog traversal, so the zext
insertion becomes something like:

  for_each_insn_in_prog
  ...
     if (zext)
     ...
       for_each_insn_in_prog

which is quadratic. One solution is we chain all branch insns during
previous insn traversal in for example cfg check, and keep the information
somewhere info bpf_prog (env->insn_aux_data is a good place to keep such
information, but insn patch helpers are supposed to work with bpf_prog)
then bpf_adj_branches could traversal this chain instead of iterating
through all insns.

Regards,
Jiong

