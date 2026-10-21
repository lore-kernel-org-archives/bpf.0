Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792540980;
	b=PIYlsCKt0Ij7IigWv0PCZ/5GUaWHSwkljRBn+b86MOuR8RVTMSnCrugTos9FTRSM0YJd
	 Qyp3NiFOcBs1C+4/uz3pPfDv/j87fEY0QIL5vBjxV5J4XRcGXGgpxIGBgcZI6MqvpEdzH
	 IEPfbKGCPFgVWNrUa/+EGS5QVbKJnTviJWGzXRuRNhqBFomA7lEftQ/b92k8nDQz5/umO
	 iqLJf6eCJFvP5+yX8sR6FuAYDFAMYA3wC1izFK/mDTmC9Yw5yHO+6bHGYz1yv6CIMBS6Z
	 Ig7B/EXnxYyVhX8eYO/7x3v6rRul6K2dWRyOTj7ByFq2l3Dn6sdKisB2khisX7Eohzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792540980;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:From:To:Cc:Subject:In-Reply-To:References:X-Mailer:
	 Content-Transfer-Encoding:MIME-Version;
	bh=E6DQo/iSAc/GRocxDOVFdU5x0X1nUJZ/jw8Dj2FTgzg=;
	b=dDjzir4V1m5oKYk0C7AAz4AT4YIXNk/ZfSZ774HYfbb6ybYtIxtIT5wRP9KSi2c6V6TS
	 a38TGMHvtP2SAdg55FM9zKwA7hZL3A/tMAMMgke9kDGgoSYjNV8RgRCLAVEf1env02C3e
	 TbLscGzEv351VH/XteD1dznwqENIjMP6nLsAsB0xmwq9gA+v1KDquUu/Z2B8ALhGzd1QL
	 99JCvJ7z+r0rV0SgitxySeRkcTNnBwjsbjaseufJKuLASIWuouNAxPWFBawnCo0sjjSlr
	 I/NhZ6cKJlUV4e/xp6pCt9rNBK2ks3TKWfu9XhWfC4cRQkNqgSObKZSKJFtRT7qX0mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RgAF5g69;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F1D606A319
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 00:03:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67F1D606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RgAF5g69
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ac6794fe45so175023a91.0
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 17:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792540980; x=1793145780; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E6DQo/iSAc/GRocxDOVFdU5x0X1nUJZ/jw8Dj2FTgzg=;
        b=RgAF5g69icJGlvHbD3mcZZXrpzRYBuNDgAgE1YGBHzfV8HVTIcmBfgDNOnAOI/KKxa
         mqpwhFNZk9+nkR6JGkbVD1hQfLVZMGztuaEDZewo8nUn1TCTnZFUyvOpcce1BUXQVG2c
         ETjK62f7ofcKqKqpE+Q6/hC/nvpbGr1DwjF7ftwk16v5eUC1QD4WWPh58qQinI90jhjt
         VEepNPAu3BOAjH6zRApL5EqkMw0Elk/yqJF9sOkuut4R0Gwp3bEqLNiivkEiVjNF4PIz
         YjJRzpab/n0QR8qKFnMxKDWaBTdLTO0Sme/D1KkNRIla+1291rl+s0Kemw5Dpiy+STgV
         SY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792540980; x=1793145780;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E6DQo/iSAc/GRocxDOVFdU5x0X1nUJZ/jw8Dj2FTgzg=;
        b=hn9KZY/Ga+KnEx57sZgIWTDLQqnn/SX/XhyjCcfD90i7rpGKvIeaxwS3FijNoPGae6
         SUcFKZYWztMAlJ7xzo+Qc8eotvhF3o6D/nCcCfsEJLVhIIeskkKw43ZfPmbBjyDsSSGQ
         C1boP056WDG91e/boepoU384OGdIsFIFHCAzhCYqvUaKhcMcnOSyQndpnXtmVk3OyCXM
         entkgbd+L0iAQ5R9myVAzaEDinhfaOKpw1x5/D1YNSHl7YImoVmVMWUQ0ZJr8xKJFh/n
         XolS3mrHHIhD+1KXolYeB28Jo3rki8cxCHWtGko1e84iOpvwwDLC1bucVxnWsx+a6Zv5
         YSKg==
X-Gm-Message-State: AFq9FYK5jfqfH3n99FPUzEBa8SUz2/3zjMVOthWlTxc6AFYxqgMpbHaD
	8EFCAyVS5X/EiQKvsBOrjB2i2c31wkkAzM12e0hodoxKlYOjfD7vsnuL
X-Gm-Gg: AYBFou3LZl/o0ed+VEIz+VDGSqX2nhOJ84Y7ecOG8l9dtF5OuUrZWac1lbVVyRrIWmf
	n6wC8kNjkDrIYnKhYz2GGBf7hY+G4CVqkjquzTkNYNg2KkLBb7gT2++yiumSnAQbC5YxfEpY3Lj
	sp2Cj7fbtgkgiJPKVwvEovZCHQy0uPz2lcwJi46xFv/UvSjG1ugOLn1+OTQ6SOmJk3KHaAzmaDR
	9KcRlkdXkKceaZa9krEJ15yW9fjugJtDpj9g7mv8iPYfvU/4KQF1OBFF5stHxgDzey+n2tmIZOi
	sAMUlAwbU7y198dvlZx2JRqZwvzSI1fPc40mdYk3FPKrSx8yDTW9yE7TvhnpPA3z64j3hD6aQIG
	RYNp40wMfiYC14F1XaZ5blwXEEbx7zD0aQvd6FxPS7y/NZ6+jURvmLzsbzXyatsjw8MGDXhlutz
	jCn5W4auDUnq3dwEYHi415WDRz/HqVZpeApvOQR0drBwLvW2QQv1OHq3rie/E1oXlXZrv1XFOAg
	1W27ZGtqzDpy4bsU3kbq/+53/qnA18GJkKEIz/ZLp9D5RbUtbZk1JZEq+i/G+uzJD63NPaLCS+Z
	EyM=
X-Received: by 2002:a17:90b:4a90:b0:3ac:aa8d:19de with SMTP id 98e67ed59e1d1-3ad86e5ae73mr384944a91.3.1792540979783;
        Tue, 20 Oct 2026 17:02:59 -0700 (PDT)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad80912f26sm1424756a91.1.2026.10.20.17.02.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 17:02:57 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 00:02:56 +0000
Message-Id: <DMA2QS9N1LRH.OIOET3SWXS1L@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Qiliang Yuan" <odys.yuan@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan" <shuah@kernel.org>,
 "Hou Tao" <houtao1@huawei.com>
Cc: <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: Expect at least one kprobe miss
 in missed/perf_kprobe
In-Reply-To: <20261009-selftests-bpf-missed-perf-kprobe-v1-1-c9d0f75f6f99@gmail.com>
References: <20261009-selftests-bpf-missed-perf-kprobe-v1-1-c9d0f75f6f99@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, Oct 08, 2026 at 06:49 PM Qiliang Yuan <odys.yuan@gmail.com> wrote:
> bpf_kfunc_common_test is a kfunc of bpf_testmod that other tests call
> as well. When one of them calls it from another kprobe while test2 is
> attached, the kprobe of test2 counts an extra miss, and the test reads
> 2 instead of 1.

Which test is that?
The only other test that calls bpf_kfunc_common_test() is wq.
wq_callback() runs from a workqueue, not from a kprobe,
and serial_test_wq() doesn't run in parallel with anything.
The extra miss comes from test1 in missed_kprobe.c.
It's a kprobe on bpf_fentry_test1() without pid filter.
fentry_test, fexit_test, kprobe_multi_test and many others are not serial.
Their bpf_prog_test_run() calls bpf_fentry_test1(). That runs test1,
it calls bpf_kfunc_common_test() and the kprobe of test2 counts a miss.
Pls fix the commit log and include the output of the failed run.

> -	ASSERT_EQ(info.perf_event.kprobe.missed, 1, "info.perf_event.kprobe.missed");
> +	ASSERT_GE(info.perf_event.kprobe.missed, 1, "info.perf_event.kprobe.missed");

Yesterday you sent the same change for tp_recursion in the same file:
https://lore.kernel.org/bpf/20261008-selftests-bpf-missed-tp-recursion-v1-1-0dd60471d655@gmail.com/
The cause is the same. test1 there is a kprobe on bpf_fentry_test1() too.
No other kprobe prog with bpf_printk() is involved.
test6 in test_missed_kprobe_recursion() is still ASSERT_EQ 1
and another test bumps it the same way.
Fix all three in one patch.

Also pls send selftest fixes as a series instead of 10 separate mails.

pw-bot: cr
