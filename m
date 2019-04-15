Return-Path: <SRS0=RZwz=SR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E51C10F0E
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 11:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE29F206BA
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 11:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="fhcI2UKK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfDOLYg (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:24:36 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40384 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfDOLYg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Apr 2019 07:24:36 -0400
Received: by mail-wm1-f67.google.com with SMTP id z24so20061174wmi.5
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2019 04:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=xm3Qjl8XLC15EuuZAoAe5b5Cq8QWrE83w02aeKEfS8s=;
        b=fhcI2UKKzouBkxvo4HOBI/RqIQjRFUfPT702aToxNZhFuz1oKIN0FPqOynbsWqV6g9
         +S4WkwxwGyNdw8BRtOo4uYovSJGKqQfJp3bTTNm929xzJb6tjd3TJbvmeMkUGEVUwN/T
         clfF+pawBlrcDUjNx80uKt5UZ1KuQSVDLPwetMsQJXoWpTBpUDC5HhRcmJJVlB+XV7Vc
         doWhLiAzhVPV+OK2d1OzqV42EoOg7+8yaYlNrbl495Y80xxkkoxEcuX3aRgpciKfAoCS
         fehdVVyq1bd7bE9PMBf5nnkLwiyRb/kh2vSHZB+nXOWJjeOja2gqeOkkf0mdCuDXe8i0
         4Z5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=xm3Qjl8XLC15EuuZAoAe5b5Cq8QWrE83w02aeKEfS8s=;
        b=r3bQ6+ox0DtBGB9S6WxWQBuIXyNX1K795DdjMNeWgNhmXdwHjFc6JIYFOB51ponW9M
         6PJOfaWWeQxI9n0L3uXYZ3wOY3Yit6Ef81QgUy9fHuzeIhZdJDA3OlPNgBGl1mefAiAN
         FAFfUCIGYp7U2+Ph0IAVekBLY96VL78uvMCn+fagB4xk4sX2OSwAqni9mi6W09ITLgBz
         18G7IK2gizKrJ0r84k6rDfqyoHqabup3ACfZv9TiK8UE4eix80ps7tRaII3dXCg1FE+f
         52JiLWmKpVFpEkTxveR+bePyVyeCkQjeQLbCpyZAmtpdKG6QfMWnoIj0zoHAGJ77RS2c
         L1Vw==
X-Gm-Message-State: APjAAAU7sxQxYwylo5RVvrM+By6jGxyqepwhvR5+HmnU21VI3i4589GH
        EYL5SbM5742NSANf7DTELWVI2g==
X-Google-Smtp-Source: APXvYqwegaaSqfE1/6Y6JnKG7JakWO/ASSqtx6DA0J1phpRAmydx78R1aDMpKKH8/Xq6tziTOc/d+w==
X-Received: by 2002:a7b:c14c:: with SMTP id z12mr21043097wmi.138.1555327474629;
        Mon, 15 Apr 2019 04:24:34 -0700 (PDT)
Received: from LAPTOP-V3S7NLPL ([176.12.107.132])
        by smtp.gmail.com with ESMTPSA id 11sm16671271wmk.17.2019.04.15.04.24.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 04:24:34 -0700 (PDT)
References: <1555106392-20117-1-git-send-email-jiong.wang@netronome.com> <1555106392-20117-9-git-send-email-jiong.wang@netronome.com> <1555321893.44its0xa9r.naveen@linux.ibm.com> <1555322953.xj35xt2bjs.naveen@linux.ibm.com>
User-agent: mu4e 0.9.18; emacs 25.2.2
From:   Jiong Wang <jiong.wang@netronome.com>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     alexei.starovoitov@gmail.com, daniel@iogearbox.net,
        Jiong Wang <jiong.wang@netronome.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, oss-drivers@netronome.com
Subject: Re: [PATCH v3 bpf-next 08/19] bpf: insert explicit zero extension insn when hardware doesn't do it implicitly
In-reply-to: <1555322953.xj35xt2bjs.naveen@linux.ibm.com>
Date:   Mon, 15 Apr 2019 12:24:32 +0100
Message-ID: <874l6zfr4f.fsf@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Naveen N. Rao writes:

> Naveen N. Rao wrote:
>>> It is then for all back-ends to decide how to use such information to
>>> eliminate unnecessary zero extension code-gen during JIT compilation.
>>> 
>>> One approach is:
>>>   1. Verifier insert explicit zero extension for those instructions that
>>>      need zero extension.
>>>   2. All JIT back-ends do NOT generate zero extension for sub-register
>>>      write any more.
>> 
>> Is it possible to instead give a hint to the JIT back-ends on the 
>> instructions needing zero-extension? That would help in case of 
>> architectures that have single/more-optimal instruction for zero 
>> extension, compared to having to emit 2 instructions with the current 
>> approach.
>
> I just noticed your discussion with Alexei on RFC v1 after posting this.  
> I agree that this can be looked into subsequently -- either a new 
> instruction, or detecting this during JIT.

Thanks Naveen.

It will be great if you could test the latest set on PowerPC to see if
there is any regression for example for those under test_progs and
test_verifier.

And it will be even greater if you also use latest llvm snapshot for the
testing, which then will enable test_progs_32 etc.

Thanks.

Regards,
Jiong
