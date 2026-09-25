Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E8020125F
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 00:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790295112; cv=none; b=R7DFhZ+t0TFvygYSt2HOeZLZrP6fDYMRgEjU31n3nX28/Vgl+hu4t4Rd0wtR9/v2tmKBhbUjJhq48vW3r1EV9CSyxsUVyF8HAUg1RHDGTZbVdhb3KfHLlcRWTr/q7OofPbpj4tn/ii/sOJ5ze2PiCupgn3G/PgGjzmweWXVt9xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790295112; c=relaxed/simple;
	bh=UvMDeOommhXZhfMgmvwD9zEfGjf1RgqWgXpX6eI4PyY=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=YcsBdH9aVujSKMDM731+WJxF6Z6rEheZ/wiES0xx/msTu9UjJsLIhBK1vZjloN8eIdeHLwsg7Ny5gEt/xaE4f999M1EECvm0lj5ZMELu/vHV7qO4A/7ypx8ueJ++YJCI6qo1a8wyYI/hqksbHqIj2WzcBO/kBHxDWxUooWRe0W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fAv8q6E2; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAv8q6E2"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d91ede8035so2487485ad.3
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 17:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790295110; x=1790899910; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1sumhp6TC0oFODPLbstUoLZjfI0b4gRvdtq6iMSnjFg=;
        b=fAv8q6E2gfeJU/u2GLle6dTC+QcgEen0cVseUq0G22FFSrhjGQFJfO3PAz+7rfHlqy
         X0V/ZOzfZBczxeBP7lUR0ytNBYnBPQ++csjJX3HgeKwqqn4iz+dz1byp5tgmsqvci3zi
         yNj8pz2SOK9KPv+JanDXXYB7IfE7xBOxJK69N1X64UhkyoaOKWRhBaVABDCJBAas2fNd
         TibBen8VuEEpR6NvRkPKoYsggRQXQFPtU1gcwxLAEsDhfh+ft0qPPishx50tttO73RtA
         EfATYjnevTPh+VQhjWqMKwdVY7Gzzpl9kzjVj02QF2iw9juhy3g9uCbWlCnF1OK+q58x
         nkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790295110; x=1790899910;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1sumhp6TC0oFODPLbstUoLZjfI0b4gRvdtq6iMSnjFg=;
        b=lNj+JpFVznWUleO1Qu2pkDVRFsmdfTN+yYkiAtxJ4gsAdnCxTJd6leAdKXA188C4MS
         D/c6S6LEkf4gI1ShThY+XxLBmdbe+17mhCsaVMfBy/R5sOkOVO9IJIymafm3HX9iqiMS
         uRQX0Fztx/byomPWZj1aufarwmzk8uH4dGc5YOuP2j3CjzIPiKygeZ70Dz1oiCy0iSr9
         4vewfOwXd5rib+FP+6syCM92563YBlJbLCWIEvjRLXhuI4OskMJ7l29GDN299hWW613j
         uLTcXKkuEX/fAmWR6FyMFv750nVLRlPZ8HfLVuq7YozGIImNr0YcVDFpJ/Wn8aO4/b3Y
         1wqw==
X-Forwarded-Encrypted: i=1; AKwUvBwohOcJWQVf92wDCekm9WEaNxKrFHWWWRMyZwisp5gq69wv15wNYKutFykQh2KCzPuJ1kg=@vger.kernel.org
X-Gm-Message-State: AFuF++ntWN63tihMKdDwX63A5vOffDALdgzHKOwF5bzIZGU11Pbucdls
	njK4Q07XJJ1BMkTDHlTDpG3wG8qLAgLMM7SD0cpBHHMprYhTvhhXNzCk
X-Gm-Gg: AYBFou1c49fKK5yUMj6ZIXSELA0rjQFNJ87+wboFIkJkW29xWXDL5vnx+0OWGHRti5i
	y8EWO3n49uPuOhlH63Ia0sY7wMfyaLzl2dQZmuRbwkCWsRA2MGnctjS8PUVN9t6Mel8jn/feBEX
	Z5IGvid9r6Ivow90kBl1OMQ8VB3HN7eU4rFRT6Bs8gwxqLS1svsXDjcQcxLH2m1EKN6XCXRlEh4
	K3/hHOINtr+7yn29SqLBYomYrN7S7CgQzRgAsqWJPGlhaJZR8NJiZdK1ZErGu1mimY2oc3U+dNU
	4cn4MSQg09mn1CuVZnAC76F9mZZmYb2aI6PA4ybr8FPD2v3kcFYisO6Qe/iG65ZKv/++hxoS/wK
	Vfmeoc2T9ABO8tfHsj4wWMmVo5Ii6BDIRPG7qaOSLixP5dG0v0OZft2bzvbHmLekKLAdHgk8gVK
	tkZ13/cbl5cOu4jRwE16xw5psz16Q+Bbifx/pSncGAUj/nAVZDIXCKx3BuWaSmbopYJ7Hn86MyT
	66Z9S3UCn8T0AYcpJj5ePIsrbD3FKCgnENNTxxGvpFojNTVkB5cmNDfOSGJdeL/tKvCN3FtRqQY
	17A=
X-Received: by 2002:a17:902:ebc7:b0:2ca:e19c:97b with SMTP id d9443c01a7336-2df94901b8dmr3042545ad.5.1790295110023;
        Thu, 24 Sep 2026 17:11:50 -0700 (PDT)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df90fbac49sm2417745ad.3.2026.09.24.17.11.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 17:11:49 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Sep 2026 00:11:48 +0000
Message-Id: <DLNYNF0A4YCX.2QY0EHNSJZMGA@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@kernel.org>, <yonghong.song@linux.dev>,
 <mason@kernel.org>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next 6/8] selftests/bpf: Add tests for may_goto with
 far target
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
In-Reply-To: <33bcc2451681d52494c3e01a9b968271d55664d3d14bd1c99e7944090c9038cf@mail.kernel.org>
References: <20260924233130.1213812-7-alexei.starovoitov@gmail.com> <33bcc2451681d52494c3e01a9b968271d55664d3d14bd1c99e7944090c9038cf@mail.kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Sep 25, 2026 at 12:01 AM bot+bpf-ci@kernel.org <bot+bpf-ci@kernel.org> wrote:
>> +static void test_far(int off)
>> +{
>> +	LIBBPF_OPTS(bpf_prog_load_opts, opts, .prog_flags = BPF_F_SLEEPABLE);
>> +	LIBBPF_OPTS(bpf_test_run_opts, topts);
>> +	int front = off < 0 ? 1 : FILL_CNT;
>> +	int mid = off < 0 ? -off - 5 : 1;
>> +	int back = off < 0 ? FILL_CNT : off - 1;

[...]

> Could the four offsets (32762, 32767, -32767, -32768) be __naked
> __retval(0) cases in verifier_may_goto_1.c instead of a new file?

No. That's four progs of 66k insns each. 2 Mbyte of .rept in
verifier_may_goto_1.bpf.o and test_loader opens the whole object
again for every test in the file.
Here the fill counts are computed from 'off' at run time, like
bpf_fill_*() do in test_verifier.c.
