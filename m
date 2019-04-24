Return-Path: <SRS0=W3SG=S2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A0BC10F11
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 23:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1FC20878
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 23:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="xu35cRjE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfDXXHL (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:07:11 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38485 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbfDXXHK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Apr 2019 19:07:10 -0400
Received: by mail-wm1-f68.google.com with SMTP id w15so7422394wmc.3
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2019 16:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=MIKZmJX/TNNgpu7Ti1QW2s7VRUFXkGzQcJmvYg1XRTs=;
        b=xu35cRjEpIZlu13uPMA11TqLTDcHaUh0PXJdfMn8Q4kdX05DFfnbumRMd6DhOO1wF1
         T4gpmFFF3HbEiM/BS43rgVMiNbR02FCJvOvrOm0Qrht6/EjMhiUX2Pp3xdNNhtTQeaXQ
         flJpDpXNTg3RDRi28sUTUTifUhaDb9xI5eLnuqHUKvSjLM7xAnoLm+maiHkbaoUli3uh
         eQEOYqxI3JX9sX8apxwAUH9oGuthAdjXnX5qcNKYhQGrpDkSjfaNogJetgOtepg4HwpW
         ZTycR8+eeEMIEbv0p88AQhgd9VBk7DnJDvgoQjNnWmFpI0Lt4t21F/7BxkXmxqFTq4hd
         hSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=MIKZmJX/TNNgpu7Ti1QW2s7VRUFXkGzQcJmvYg1XRTs=;
        b=G3ka3crinzeyWdmfCNERRjdaOy2YVuo08tWwRTzMQ9imolNWW+gxwZM1X8QtZP5XVs
         XIP+kEQi7Mq/WHvoHCqyoAJGzA+3Qyvd9ftaGQAZueB8vWvS0IF3vHlVQio5bUNucKuI
         fladCtowfRI679UbOpFjAyIMRsTKHzxpLQA3chmXcQg0Uys40f9uON+RVE0xljjsf34/
         Se607MOZ8ntZBenNIb0bskVbUYon0YymabJuGbMtk9nSlusXKSin2luOhw2GchucUh+g
         deGF/jIb70CZ9U4TmXjUj/5ghcHb/cAiXgm3ILo6LkNqREc7mHVAzgI18WGkIw7REGvh
         jBCw==
X-Gm-Message-State: APjAAAU2+fIDaRd00lDndz9AlL3usO13QoBf4V6k0b5E2nRaBV0x5VeT
        mcqUO/3sE9NrR13xJwl9fwqPPQ==
X-Google-Smtp-Source: APXvYqxCflTSr55k0kOsWYQZc68YAZjW58P55aCAlvv3zZMx9N+Yb1SUBliV5nuhVij9Xuzoa6u/kw==
X-Received: by 2002:a1c:ed12:: with SMTP id l18mr1112583wmh.13.1556147229103;
        Wed, 24 Apr 2019 16:07:09 -0700 (PDT)
Received: from cb-macbook.local (cpc1-cmbg19-2-0-cust104.5-4.cable.virginm.net. [82.27.180.105])
        by smtp.gmail.com with ESMTPSA id u15sm4293990wrt.40.2019.04.24.16.07.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 16:07:08 -0700 (PDT)
References: <20190412214132.2726285-1-ast@kernel.org>
User-agent: mu4e 1.0; emacs 26.1
From:   Jiong Wang <jiong.wang@netronome.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "oss-drivers\@netronome.com" <oss-drivers@netronome.com>
Subject: 32-bit zext time complexity (Was Re: [PATCH bpf-next] selftests/bpf: two scale tests)
In-reply-to: <20190412214132.2726285-1-ast@kernel.org>
Date:   Thu, 25 Apr 2019 00:07:06 +0100
Message-ID: <lyimv3hujp.fsf@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Alexei Starovoitov writes:

> Add two tests to check that sequence of 1024 jumps is verifiable.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  tools/testing/selftests/bpf/test_verifier.c  | 70 ++++++++++++++++++++
>  tools/testing/selftests/bpf/verifier/scale.c | 18 +++++

I am rebasing 32-bit opt pass on top of latest bpf-next and found these new
tests take more than 20 minutes to run and had not finished after that.

The reason the following insn filling insde bpf_fill_scale1 is generating
nearly 1M insn whose results are recognized as safe to be poisoned.

  bpf_fill_scale1:
    while (i < MAX_TEST_INSNS - 1025)
      insn[i++] = BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 42);

For each hi32 poisoning, there will be one call to "bpf_patch_insn_data"
which actually is not cheap (adjust jump insns, insn aux info etc). Now,
1M call to it has exhausted server resources as described, 20minutes running
still not finished.

For real world applications, we don't do hi32 poisoning, and there isn't much
lo32 zext. Benchmarking those bpf programs inside Cilium shows the final
zext pass adds about 8% ~ 15% verification time.

The zext pass based on top of "bpf_patch_insn_data" looks more and more is
not the best approach to utilize the read32 analysis results.

Previously, in v1 cover letter, I listed some of my other thoughts on how to
utilize the liveness analysis results:

   1 Minor change on back-end JIT hook, also pass aux_insn information to
     back-ends so they could have per insn information and they could do
     zero extension for the marked insn themselves using the most
     efficient native insn.

   2 Introduce zero extension insn for eBPF. Then verifier could insert
     the new zext insn instead of lshift + rshift. zext could be JITed
     more efficiently.

   3 Otherwise JIT back-ends need to do peephole to catch lshift + rshift
     and turn them into native zext.

More thinking on this, perhaps we should just go with approach 1 which
actually doesn't require much change I guess.

There actually is no need to change back-end JIT hook. After we finished
liveness analysis, just copy insn zext info from env->aux_insn_data.zext_dst
to new dynamic allocated storage inside something like
"bpf_prog->aux->insn_zext_dst" (a bool * pointer, with 1 * prog_len storage).
Such optimization information then is available to JIT back-end automatically,
because the currect JIT hook is 

  struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)

After bpf_int_jit_compile finished, the dynamic allocated storage could be
freed, no need to keep it along with bpf_prog's life time.

Backends also have finer control on how to do zero extension so concerns like
https://www.spinics.net/lists/netdev/msg564489.html could be addressed
naturally and no need to introduce new BPF zero-extension instruction.

I am intended to send out the updated version using approach 1 so we could
see how it looks like, comments?

Regards,
Jiong
