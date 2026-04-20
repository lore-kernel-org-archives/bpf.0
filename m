Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989343783CC
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 05:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776663930; cv=none; b=OP8YgtNbi4RHIgK1WTwwsc8UsU5ezlt0osIFxSNtbL4i7ZDNjYUa2bL3XoBDZlvchXtaDFm9pVahuMqqXOEHu4i/YihQBv2wgtl+vZ66uCk3PKgekq0RB2JE+Njlv+RdRNbTZo+XnXOJIZr7OzfARaMpmpBp+aonwKZKrDQUhu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776663930; c=relaxed/simple;
	bh=MgTfL4hcReOYBI5Tm5H0TniZgVEW/A1hJFqIRwsnFd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ec4mhV3M8LebleP3Hi0EDy5HCt3S/XbQrcs9JVfsW5/gvf08qJixX2bGxPmpwGOJA76J6Yggw5g+5Ww3RhhaKYzQFc7/dxY0W5A1fhF+yraIDQoFBEDLH4nDn907u9T6sO7MJiByPr1tslnqsARpx2FIHox99pjtXn2k5ORW0iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMLBJZ7r; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMLBJZ7r"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35da1af3e10so2572109a91.3
        for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 22:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776663929; x=1777268729; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tJIF/OkmYP+1od9OnWg/0GXVniINWQBKYZWI269j2LU=;
        b=iMLBJZ7rJCoj2R0PWFYw+ff2sHHnQLyOqNEbMZ3IrRTHIKhTfMuQbQPxBRpIPB0x5s
         qp4NQBEg33ZZyA1JVcLuXePay+TQs9O3TsQFnaClo2fBj4RFGVUxDcpH6GfWhR8iVjIq
         7/6B/nJyQXBoUSNpDNCyZxKskCFlLgz4OGIHyvwFEXb/8kxXTNgJZuNp1gfGF7mZxja/
         LW0EvV9v0Kt2R0zl1x/ADdZo/TbnqwHJCRwoPnaY1RnHnKVPOtWiKdl30kGViVP1gCyK
         qzrH5F6lthyNQ2CO7uyGpgiwisip0+LIAn5xAnxZPJS/kQ5MS3i9PLne005cWdSkYlCT
         uZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776663929; x=1777268729;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tJIF/OkmYP+1od9OnWg/0GXVniINWQBKYZWI269j2LU=;
        b=HlexQGzdXTAgN42fu9FpCY1czmbeIl4cckFXDNMtbEi6i6Zo5i5IpsK6+7le97aOeU
         34+5tlqTWpej1v3cRdO+dXv64XtGaXtYthMlgDZJqrtzpmt6rNK/YvYuTmvn7YQ4rlzh
         oHrGD0xgcJR6ZFoZGn5km+KTWtRi59h7CVluScIjDQpTPlVOAH3lsE0n/OFXV8VIUjSx
         ehpATl2Z16UQ32KPxmi1Gy+krHynOuYWPnI1hYCarVdZiszwcg1NmIWGtyXGa/nOBCU0
         xHqfQyCPjPrfkfB7EjyEL0fzTDSlANSDld1IXD/LcZSy0qY07C9AuTkdaU8yO2IziKI3
         +tag==
X-Gm-Message-State: AOJu0YzOtcUBbl+I/XcoGLmB8cgl90qadUaSi8cokSYx6IqJ5qNQyCAF
	bTsNADK6d/tW+/Bchi/aoeWqbDSm0vq6sKkExcvxU5HtfjfSNhL+sWR8
X-Gm-Gg: AeBDiesl0WoIdSoVt9LV/cBEWKxVuDHhZoqJEtqiIw57K+QuxN8zXhm2cXfJKGaXAmf
	mJaFcbRwT7KPOxY1YdXyb/cyH02xV1kY8kPbMrV7H5CYz5sinqXYMUMoCa1VSLg/gRu8BXYfoZD
	5hMYeZQu7ZXPYNs0hoEQCkDvGvDsfusaF4FHgkQ1hMJ6cerrVuPeu8+15FinyndqqbAoT7W+3AB
	1PTNYLu4CQfm3Cgw9+qUJapglWxokBHaA5VesjMmtvRo/faXgXIk3Xz0wGzNdTAWoBwt6Ll6MT/
	aOQdi2dHkXsu1UN3+LLZfdummTy61ZMAP3AQlkYpziYf4R3442W8YxdwvJU95gCdfnaYW6N8cfN
	/6zeVh4s5dnhI2BWw5NpFy6nlp2hPBo2TdQEbaPqtMOuN6+3EGPsv+urOx002C2AAA3TEY0Rfq0
	6DE/EL5EqVck6YXE+ofEjaCn80yZDuugvkXSIBPNvqiKFSefyB
X-Received: by 2002:a17:90b:3c8d:b0:35d:93ff:284f with SMTP id 98e67ed59e1d1-36140462afcmr12973259a91.15.1776663928900;
        Sun, 19 Apr 2026 22:45:28 -0700 (PDT)
Received: from [10.22.65.66] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613fb7118esm4579541a91.4.2026.04.19.22.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 22:45:28 -0700 (PDT)
Message-ID: <e3e40b8b-9fff-4cb0-869e-fcaeb6b307ac@gmail.com>
Date: Mon, 20 Apr 2026 13:45:23 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 0/6] Add support to emit verifier warnings
Content-Language: en-US
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, kkd@meta.com, kernel-team@meta.com
References: <20260408021359.3786905-1-memxor@gmail.com>
 <1a7aea41-cc64-4277-a08d-1cee1ad6024b@gmail.com>
 <66a977bb-cfe4-4bac-990e-2b91512c354a@gmail.com>
 <CAP01T76wkwaXSmLpAS3GtK4VKELzgkeYxozcxFav+C1F7LTYTg@mail.gmail.com>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <CAP01T76wkwaXSmLpAS3GtK4VKELzgkeYxozcxFav+C1F7LTYTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/4/26 19:06, Kumar Kartikeya Dwivedi wrote:
> On Wed, 8 Apr 2026 at 16:30, Leon Hwang <hffilwlqm@gmail.com> wrote:
>>
>> On 2026/4/8 22:55, Leon Hwang wrote:
>>>
[...]
>>>
>>> Since I'm going to add common attributes [1] support for BPF syscall,
>>> how about reporting the warnings via the common attributes? Even though,
>>> the original intent of common attributes support for BPF_LOAD was
>> BPF_LOAD -> BPF_PROG_LOAD
>>
>> Also, common attributes support for BPF_BTF_LOAD was to report logs,
>> similar to btf_log_* in union bpf_attr.
>>
>> If to report the warnings via common attributes for BPF_PROG_LOAD, we
>> should rethink the purpose of common attributes support for BPF_BTF_LOAD.
>>
>>> report the verifier log too.
>>>
>>> [1]
>> https://lore.kernel.org/bpf/20260216150445.68278-1-leon.hwang@linux.dev/
> 
> It can be used when present, I will switch to a warning bit in the log
> level in the next version. But I don't think we need to rethink
> anything. If we want warnings for other objects they can use the log
> level's warning bit to supply those to user space as well. When you
> add support you already have to figure out how to merge those in
> bpf_attr and common attributes.
> 
Make sense.

Thanks,
Leon

