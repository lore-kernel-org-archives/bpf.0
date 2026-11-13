Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794587408;
	b=3IXW7OpLhGXlxDy41Jlu5Sn2s7GdPzb2XF64gnm3miHszVduVlc47a29adL4Fg9ryM79
	 N1qYXiHYhJs3yiTs/NmPzagD11HvEJQ6Bo19VNJ9eOHntKXhYUfe8sjfbrDA9MhQb0lZ0
	 CMi3C5sCqZIbdJP0nBrRLsJXEpuUbqNn7FujT74nGvo1jJNXjLJA8v5/B4N0t1ci++llU
	 0xYpCew9hvRZ2Nur4t7Z6XShzGDbMzE41SIcZCPoFBWIUZzGgrKwvr/qrbVsiQfxv1mc9
	 ZrOSYf3Phgo9iKQ5WYVxxaEJEV0EsY8qVOeHlJRSZvnNu6lIrlwALEb9cKjGgId89og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587408;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=cqCsbX3RyqYZWDeRaH4vXF7pXJb+mPTW2Vj8gfzsjjU=;
	b=2FnlXkIrYmmUIbYgMrBBV2jhQhPPGx5ePNAZwUrvFMaeeHXdY8WfcEwgz48mcGoyNLEs
	 zAPkrnkGwC0earGeomZwlnk4ThM6LirWswHVVLpD/9HRvNT7sr9G68Qnz+3u4OBi3fllh
	 EGNOaqFH9hQV/blIuzlmrF99gKkpNeqYW3Asib9E9m/WNqp6CWqXmvfmBQjtVbKC9lu/v
	 OFLynT4MuPPB9nI64tmjE/R6fkH3rjrcx6T94t2Uk+44OPx7jIy1nTEMF8Uro5gHYugG3
	 Quo2Q5pfDIvBir19EUMwlGuz7D6+lHgj0RcqrAwdPNPqdrDfb/R1038Wsy+sI4CbPsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hlxnUDzM;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AF5606A886
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 16:30:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09AF5606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hlxnUDzM
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8b612fd74e1so684623b3a.0
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 08:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794587407; x=1795192207; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cqCsbX3RyqYZWDeRaH4vXF7pXJb+mPTW2Vj8gfzsjjU=;
        b=hlxnUDzMLTsv/M1XS65Ts0U0nML4kZS5No5vTaxurjafFHmzioJNIRn/9ainMckpBV
         mXOi52PraNdHlgIc33CbkW5utMt9MNY3aEesbHGk4qVNWavWewdwukelDelWxEAgdCF2
         MUG6xTnm9D2XzaPsAeNelasfrWM3vEgvEyMdxo9qXcQHvxe8RgYbGj9gGy9yAaI3jgmL
         ZLOfMijQaDNtBFrQTogZf2tF404RgZHK34In6D8AkSYlPLNshjlfY20GtWIaDvWMxJEW
         hUq3SHQMkpXh5wjKUpc53A35GyTNU8UgP4Xlx6AznFsblqZLb1lMKTshWmbbOnWtCwhs
         mLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794587407; x=1795192207;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cqCsbX3RyqYZWDeRaH4vXF7pXJb+mPTW2Vj8gfzsjjU=;
        b=E16nz2iexaQuAo495BGug8f5NbFi+9yAFZ0c4ufLFWdVe/5EahpmzLtnQCHyVMBwy4
         Sb2g6rOlaQRCKDUPYoqda/snsUUD9EG6yY9Jq+c8PmvRDJxNx7calWsZ/F/uynmMK0Gd
         4M0grLzk+nOYvzv7currZmG4a3kmIydQ0cC4+snOwPek2Tqq0VCbPTLv+2jHrxniy5cc
         8miJ5E7QM55gO2XdH2lUq4c/pJa2IVse9W5t/4ns+h6QgwmCqpVjEVwAN/m1dO8mWUyi
         c+VyKNilriC2gwoFqvyaDYvHqwXLuIbfLtU2fGGD4d1iY2moyu+jJNuL8hXil2PEI/5K
         uuCA==
X-Gm-Message-State: APuU4Z8EV++orGYcKl3vyhlcpw64ZRGEiAvvTBKKVceyOO+r0yf1aALc
	CyIPNGM6C61mMxp6aHPU/AoQgeMMIJqqNnoo8qCTS4G9gw8A7JeFY0zZ
X-Gm-Gg: AYBFou1F95oV98aTitaryofcTe6nCDIYw98NypYTrBpB543HmfjiaaYCDFSbOvYwxeN
	PaO6rrJFdKkU9gKtNJj+nwxze+DDMJcjj5xRvZpcTvb6TmpgxKyeOQ17tGaf2Ffzj7yQOZULUCL
	gLONJyXRio9kbjdgwYJSWFOGCK9UuTrUh8Twt+I3qek+OZ4HIIA6W+skeH8yPUQlZdlLwwYiBaP
	wGRJbQQUDo3aLqKAmKKq+vyudE26gYZGaN6eHlqRwgHcYZ6+farobhaIO1egGALg9V1S6/6PdAK
	iV3N3UcBlkyiGLZzlS0qZ9/g2hBIF7XtjR7JvvRwXbtjptyWEcC1EZiz/Q6POYyqxVaQA0oZYun
	35Q00yev6f5dVZq5ifGL5r6pdY/Ls7v/+lPVIWV2Nuf4CjONawRMe5kPdzGi78I+xi4Fg0q2S9C
	VsCcXtVqcKYwWXuCghwbVd23XCVENyGjoQUV8WxcjhX7pWy6pW3lAdWfe9fXefjt9Cw88im1AEc
	BckG2C5YiB22X69nOv3c/b0ZeGjJ19LUmJsyyOqTmuKVFHJuY3DqWhW6Gq7k0WBHWpfnYCN2IcR
	YbrUTh6tFSq9E4bqE6wQwe/pEo+lR8//ouJ6kUiXJVqYARvaZmnPU8zye5DQyIyjfk8MXZLzLV4
	6N9L5MHphvq/7vcu0p/kmdvB6d6c2MCZpZg==
X-Received: by 2002:a05:6a21:3f91:b0:3e2:d68:e8f6 with SMTP id adf61e73a8af0-3f7a85d799cmr2481810637.63.1794587407244;
        Fri, 13 Nov 2026 08:30:07 -0800 (PST)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8becbad7de3sm1373303b3a.0.2026.11.13.08.30.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 08:30:06 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Nov 2026 16:30:05 +0000
Message-Id: <DMU854VMCPXG.6LJLSEU82GMO@gmail.com>
Cc: <bpf@vger.kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <memxor@gmail.com>
Subject: Re: [PATCH v2 bpf-next 11/13] bpf: Mark the arguments of fmod_ret
 progs as PTR_UNTRUSTED
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Anton Protopopov" <a.s.protopopov@gmail.com>
In-Reply-To: <avbvzPFUFQOB4iYj@mail.gmail.com>
References: <20261113050901.1399091-1-alexei.starovoitov@gmail.com> <20261113050901.1399091-12-alexei.starovoitov@gmail.com> <avbvzPFUFQOB4iYj@mail.gmail.com>
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

On Fri, Nov 13, 2026 at 03:09 AM Anton Protopopov <a.s.protopopov@gmail.com> wrote:
>> The arguments of fentry and fexit progs keep their type for now.
>
> I am not 100% following why this change is needed without enforcing
> this for fentry as well. One can attach fentry before fmodret and
> follow all the same args. (But in general, +1 for this and the
> following patches.)

Spot on question.
we've been talking about deprecating legacy PTR_TO_BTF_ID forever
and tried to do that several times, but there was always something in the way.

I did the analysis of all bpf open source programs I could find.
Turned out with these patches none of them fail
when we make only fmod_ret's args to be untrusted.
Of course, there is a chance of braking non-public progs.
Before this patch set the kernel has ~1200 fmod_ret targets.
After it will have ~12000 fmod_ret targets.
If we keep them legacy ptr_to_btf_id, we will have endless
slop from bots demonstrating how fmod_ret can crash the kernel.

But back to "why not fentry question"... having decompiler is so empowering :)
I'm thinking to add a step to analyze how all these fmod_rets access their args.
If BTF says it's a pointer and asm code just goes and reads through this
pointer without any checks, that's 99% likely a trusted pointer and will be
marked as such.
All other pointers will be untrusted. This way we can finally
remove legacy ptr_to_btf_id with minimal bpf prog breakage.

