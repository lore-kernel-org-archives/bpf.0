Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E176435F189
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 17:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776446564; cv=none; b=jhgK3fTY3Y146dT2kGkolGyx9VXyLdRYTPHP38Zi51QOhZVbbHcp2h4yRTBp3kb8614JIoRlgnfiyLVCsYK5j17NFW68FU8NxYQr64SMA4xzVnGGbeO/NpkQeh/VoDLRC0eGG8SQRNRwkWdDgO71OO7SCNwyhEQX35zg5N4rSH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776446564; c=relaxed/simple;
	bh=zKYCpWOZr1bz6RbA+dNa0pIvU5r/RGqVdCYgv/PANHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XYBdhelbhNsqu4z9q9iafVcuOtKYudgjqnlCqeCPBuH5oNNuwernkAA/LSxQzGzxWC0dlTnKwlErBoGOCkcfHiTCYpxbnU2x1PVghM/KUf29XcqfbuxpTedS2qWpVypri5MG80aZr2A41YUGoOfGZTvO0+vJM7MBCQviYKisVSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gd9HdD/o; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gd9HdD/o"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso9118665e9.3
        for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 10:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776446561; x=1777051361; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jbqatp0qHepZF3d8fjmGE/KljlJeUlBWWbHvGa0ch0w=;
        b=gd9HdD/ogjm6ffUDXBTW7Bce9SGh5cesJ6vJqmsG4NfBN73hXM0nb1f1UYE1/ZeeiZ
         Jz0uOsu4ik6ySiBScUrT4kEK24h+rNWBRpfJfZJNBUzSS8qFnfMJQ/OWOmwYpXdfpNEy
         ooSEPzrDnoPhSRWSoRT8uifdUWHP3NV9HtGkDByf2QAukBcfF6vUIx5ZFxEBMVBR7a5c
         ps494FNNQbMwi0fju3yvucUkdA70DMFwJw9u9YvLjdwsKvjrMkPb877FsuYlW1s90+7j
         bhV/+8LKulVeAMElKjLNkGyFdeyB/45BTXgvFm3FHjWKMA/YYWabAhD2Fv5Vl6cxnsu6
         txcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776446561; x=1777051361;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jbqatp0qHepZF3d8fjmGE/KljlJeUlBWWbHvGa0ch0w=;
        b=U+t/1CGupX5a4OgmN5auh5yWtcuZ5UADzGLb4gqThRxCCPR7mUVJcpCEcstZ2ukgO7
         DDkbksRDuUP48qK2bGdinqugwM0Ey62V5UyC/EYdn2wNegP440lT91Cc+AICOwglQd5r
         dqabWCOW2Bf3V6Gyp7kD65g2mx8sV00wyrBEIr4/N+RHv7483nmEg7lWbj0+prX2w0Hx
         Dy4KdQjU3HFdGa5TbKNu5MaFG/8/iNhuJ9xXTY03+GmFKScCoSV5E1c7FaQ8gU4LeItR
         amsIzsN/fpp0roQlOqnguzYI2fJc4lrvKlRM0ZdXcPu/UkDQHRFaqen0TKP+Su6TvtoW
         7mTg==
X-Forwarded-Encrypted: i=1; AFNElJ9FOd7tpuf4/sYT9SnRltfFjRMboh7eJkWiXXFT+C4Cm9hFkveQVtEQ2PjMWmrpoZmvVHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXXZNFAkc+GC9PTLY14T6vkMwn5vtMUPqp/DKLN52fJTQKHBtS
	5PANtf11iTNRSJdZ+kXpjADT+gMxTwzwb/5tfbRVB0+HZ+6DaCRjrCHg
X-Gm-Gg: AeBDievQ2V2fBgigtfVX5oXd9bAdmPay57R97gTke1KzOexI58yetQHn8L+syY8C7dw
	HjQkGjuRHOWcBZboQpvZOAVIo6h9Uq0hsWuvYUNZpzuyvrmHpdlRGxmBpKv4Uf8lrH6OXCGnVHk
	DdAq1r74uoVhnfIenwPsH+PMGHehEFDQtcq7ie/5eAzTBsOFoAkfTaSNLN0CY428KpJIHTRfxuu
	fbqd5yJk6YIvMFMkMKkGiaxSPXXSAr7S0sSIFZeAVYTsFGt15tgWnjG0IGsAQW+fGtykNUbR4LC
	cbuwFGX7GjOaRiarnfhp7Xt7aoEcyyACPB66/N/AwtWLb7eop3B1MP2AUNUis4gJEXR4ukcrrcl
	CVXujQ1Y0WQ5z0/jkxKnWSVikeK6vUtJi9FpskKq8ottmfssRzdkcBfFK8PyGP0yphmxBY9lgOY
	6Tg1ZYk9XELhLPUgezsS6bpLP4u4mT/6S3tvjQ7lI2V7mEHPvb3Ldkpyvgo5zwdcepS/4BtUJmJ
	cfTjqpBpjXQ+K7Yoy+oryPwudp1pAy9
X-Received: by 2002:a05:600c:a00f:b0:486:fe83:8621 with SMTP id 5b1f17b1804b1-488fb788924mr59982755e9.23.1776446560959;
        Fri, 17 Apr 2026 10:22:40 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1365sm6324879f8f.7.2026.04.17.10.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 10:22:40 -0700 (PDT)
Message-ID: <337f2570-acb2-4b31-8c4f-86ba4cbdfe65@gmail.com>
Date: Fri, 17 Apr 2026 18:22:39 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v10 2/6] bpf: Add bpf_prog_run_array_sleepable()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin Lau <kafai@meta.com>, Kernel Team <kernel-team@meta.com>,
 Eduard <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20260415-sleepable_tracepoints-v10-0-161f40b33dd7@meta.com>
 <20260415-sleepable_tracepoints-v10-2-161f40b33dd7@meta.com>
 <DHU7408DLITK.2DC76VINL2F7K@gmail.com>
 <CAADnVQ+6udrUD-xW96ZJkz3UkEq8JZAdFiMgB=f5jfFaYVjJ5g@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAADnVQ+6udrUD-xW96ZJkz3UkEq8JZAdFiMgB=f5jfFaYVjJ5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/16/26 3:40 PM, Alexei Starovoitov wrote:
> On Wed, Apr 15, 2026 at 6:41 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> One more thing..
> Please go back to my 'do your homework' request from v9
> and answer the question why it's not safe to do bpf_prog_run
> on dummy prog like this patch does.
> I missed it yesterday and only complained about the waste of cpu cycles.
> It's more than that.
> 
> Do not send v11.

I see that very similar bug was fixed in 7dc211c1159d ("bpf: Fix invalid 
prog->stats access when update_effective_progs fails"), the problem is 
the same - NULL field access on the dummy prog. So the approach to just 
allow dummy to run further is fragile, because other NULL fields may be 
accessed.
