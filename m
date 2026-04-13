Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61173BB9FC
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 10:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776077556; cv=none; b=oedp67dtkPmxiP9n5usWxfr4IvYkYHRpzvGquhFtxMx3DVwgvrBm2k3TPV3xg+9udUALTLsnZY8KpBDJqiPhO7qSLaZx8yTSOVYYtrGR2QCDvz6TWqK1/xSJQDZAZSRs2XqcqwSL+fqfshawjcZObA/0ezAb1bYF7F1AN/UIyBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776077556; c=relaxed/simple;
	bh=mseYpsspEcqxGWkjHiNkzN9xhhlcW0uyCPk0QHOgsro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gIOPCbHFp+gMRRCEMSVzaxn/lhUECZNszIvC6ks/LrBOyPK6eMnybz43EA4rJPWSHWHfO7+wlYPm/Sqo4A9XwYuT7LU5eWWp6YzoDiEcfo5GQCdCsT+vu9ZllslAeZraGsPChQZYoefV3Xnf7ztUAAkhp7cQWDTieF/2t2tsWiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tJqtsjtH; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJqtsjtH"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488ba840146so41181515e9.1
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 03:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776077553; x=1776682353; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zKk6rDtq+2Yem+762XQWmfK16jGVtS2f4Wiv4vNjpqE=;
        b=tJqtsjtHDh38y6FojRhz0qr7vZ+9c7bWC2fVHqjga4VXaNO4aA5vOFPA/4TKDVIMcP
         /yMZgwaYrxTrECaBdPeRZmNK0jSawUvuvdyjJIFmnO48dBjPHcu3HOukVaigMWnoVprw
         S/WR1PjKaAWbg+aD7DMVA9RddqeAI7ESd1Wu2k9pjCNOwuXC79fa1/YWGZhazTG/Gsjx
         iaZq0fsjpXpxw4uiOJZQBw0VvEO0Ilfn6ITOQgxXS1W4o36dyBh3UV82NYgPYeqI+tGA
         T8reLT3GoDcY1alCd0Go6LZMVsBZjcwqP6CfVIWaIvxpa15YCGKfuZaoa9FTUqrMZzd1
         ukpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776077553; x=1776682353;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zKk6rDtq+2Yem+762XQWmfK16jGVtS2f4Wiv4vNjpqE=;
        b=nHzXfPdlIB96nVTCKdloNghl51KOva+FWKcVCxZ2id4SLXp1vw5Q09yVCpWdCdMow7
         kki1nFrimwmjCc03MbKOQRcC6F7KeB7N9DOk+gVU/usBqBtJZbq2NORElxV221wyx+4t
         f+VWw+V6eedokWBggAAQOycnXgs91gmpjGwIKgQ11DbPtaXnPIs71Dcs7hmEl8+PU4gU
         40mGwtCDgpuhut3VCGGlfaP3+IdT3HcQiPEy/h5x21+YxTJAhV8IX4ZgTUThtGz/n2ki
         /xBA/qmopnAgNftDj5046IKDIMdb5WfszvxKMNcFm5oESarhJpBympiEYyyp2QkWhPL1
         xWXw==
X-Gm-Message-State: AOJu0YxTP8mvpavuqFTsXXFC678zgymZtU2IK1TEsOIcYojJ12c+cVnQ
	iszVkSyemh27u4ZCjvYeA59BPfZLhdgw41NRRsXc7pnnISWFc+4GY7hI9tL8pnDd
X-Gm-Gg: AeBDiesPGIRu8nb+7u9DjOZ8TGhpM6LvUPA4sM+s/MECQMnpl+9UcsLy9+gF33SlNMo
	FAQch0nLEfmdo2qsldF7JDpS6wZVg0MrMCYELj7GtguP6+SqJLHeiGKp9vOA9Pkas95KrrfNUCr
	XYILq5tbwtpq4C10ryceC8863KJBhLnVUgmokz7diS8CfP0AlxBiDP6eTAjqNkYSSowj77I9mL5
	RUEe9KrDIC91KcVgnJnwK2FlXtFYep60Q6AtyWTFt916gpbV0m5Ei5DDYTdf0DEBntKDRjYZctk
	tPWbrpdoPAJ27j2N0MyZbnTfkBOFX/YUOYHZS1jS2xa7dw8ktCup0Bms+IxQJp254MCFCJXZWfh
	ca8OybH/18AJQM7+vX8kmZ1yjJDEH0KZKsyR1QC6A0+MFjjZo5cRVPoNJNUoaAd1luoPR2APqfS
	KjIDc2xuWvBpRQh8qo+ubASTg5s3bnJU462LUiajI1KdqIWs6ZIPscAEGzcL5r0Vr4MWGW3gSKm
	ZU55hVsiqs=
X-Received: by 2002:a05:600c:c0da:b0:488:ab5b:d711 with SMTP id 5b1f17b1804b1-488d6864b6cmr140339895e9.23.1776077552883;
        Mon, 13 Apr 2026 03:52:32 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:1086:f5f1:32fc:93b3? ([2a02:8109:a307:d900:1086:f5f1:32fc:93b3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d6ffd3880sm16359168f8f.7.2026.04.13.03.52.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 03:52:32 -0700 (PDT)
Message-ID: <a103c612-2639-4578-8d8b-48ac72e96c63@gmail.com>
Date: Mon, 13 Apr 2026 11:52:30 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC bpf-next v2 03/18] bpf: Implement lookup, delete,
 update for resizable hashtab
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin Lau <kafai@meta.com>, Kernel Team <kernel-team@meta.com>,
 Eduard <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Mykyta Yatsenko <yatsenko@meta.com>
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
 <20260408-rhash-v2-3-3b3675da1f6e@meta.com>
 <CAADnVQJ-rW+MkrrtaAoVvExNYX9rEc+=zSw+phzCgv9QtaAX8w@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAADnVQJ-rW+MkrrtaAoVvExNYX9rEc+=zSw+phzCgv9QtaAX8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/13/26 12:10 AM, Alexei Starovoitov wrote:
> On Wed, Apr 8, 2026 at 8:10 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>>
>>
>> +static void *rhtab_lookup_elem(struct bpf_map *map, void *key)
>> +{
>> +       struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
>> +       /* Using constant zeroed params to force rhashtable use inlined hashfunc */
>> +       static const struct rhashtable_params params = { 0 };
>> +
>> +       return rhashtable_lookup_likely(&rhtab->ht, key, params);
> 
> How does the asm look like?

You can see how asm looks like below. An interesting thing is that gcc 
inlines jhash2, but not clang, which costs a lot of performance.

gcc:
lookup 20.675M ± 0.090M events/sec (approximated from 32 samples of ~48ms)

clang:
cpu00: lookup 15.882M ± 0.530M events/sec (approximated from 32 samples 
of ~62ms)

I think inlining is also consistent for htab and rhtab (either both 
inline or both do not inline).

perf annotate on gcc:
  Percent |	Source code & Disassembly of vmlinux for cpu/cycles/P (18251 
samples, percent: local period)
------------------------------------------------------------------------------------------------------------
          : 0                0xffffffff8146b630 <rhtab_lookup_elem>:
     0.00 :   ffffffff8146b630:        endbr64
     0.10 :   ffffffff8146b634:        callq   0xffffffff8126c6c0 
<__fentry__>
     0.00 :   ffffffff8146b639:        pushq   %r15
     0.70 :   ffffffff8146b63b:        pushq   %r14
     0.03 :   ffffffff8146b63d:        pushq   %r13
     0.56 :   ffffffff8146b63f:        pushq   %r12
     0.00 :   ffffffff8146b641:        pushq   %rbp
     0.00 :   ffffffff8146b642:        movq    %rsi, %rbp
     0.00 :   ffffffff8146b645:        pushq   %rbx
     0.06 :   ffffffff8146b646:        movq    %rdi, %rbx
     0.00 :   ffffffff8146b649:        subq    $0x18, %rsp
     0.02 :   ffffffff8146b64d:        movq    0x120(%rdi), %r12
     2.58 :   ffffffff8146b654:        movzwl  0x132(%rbx), %r8d
     0.00 :   ffffffff8146b65c:        movl    0x8(%r12), %edx
     0.12 :   ffffffff8146b661:        movl    %r8d, %eax
     0.00 :   ffffffff8146b664:        movl    %r8d, %esi
     0.00 :   ffffffff8146b667:        testb   $0x3, %al
     0.00 :   ffffffff8146b669:        je      0xffffffff8146b726 
<rhtab_lookup_elem+0xf6>
     0.00 :   ffffffff8146b66f:        movq    %rbp, %rdi
     0.00 :   ffffffff8146b672:        callq   0xffffffff81467bd0 <jhash>
     0.00 :   ffffffff8146b677:        movl    (%r12), %esi
     0.13 :   ffffffff8146b67b:        subl    $0x1, %esi
     1.91 :   ffffffff8146b67e:        andl    %eax, %esi
     0.00 :   ffffffff8146b680:        movl    %esi, %eax
     0.01 :   ffffffff8146b682:        leaq    0x40(%r12,%rax,8), %r14
     2.80 :   ffffffff8146b687:        movl    0x4(%r12), %eax
     0.01 :   ffffffff8146b68c:        testl   %eax, %eax
     0.01 :   ffffffff8146b68e:        jne     0xffffffff8146b821 
<rhtab_lookup_elem+0x1f1>
     0.00 :   ffffffff8146b694:        movq    %r14, %rax
     2.41 :   ffffffff8146b697:        orq     $0x1, %rax
     0.00 :   ffffffff8146b69b:        movq    %rax, 0x8(%rsp)
     2.63 :   ffffffff8146b6a0:        movq    (%r14), %rcx
    13.96 :   ffffffff8146b6a3:        andq    $-0x2, %rcx
     0.01 :   ffffffff8146b6a7:        cmoveq  0x8(%rsp), %rcx
     0.02 :   ffffffff8146b6ad:        movq    %rcx, %r15
     0.00 :   ffffffff8146b6b0:        testb   $0x1, %cl
     0.06 :   ffffffff8146b6b3:        jne     0xffffffff8146b809 
<rhtab_lookup_elem+0x1d9>
     0.00 :   ffffffff8146b6b9:        movzwl  0x136(%rbx), %eax
     0.00 :   ffffffff8146b6c0:        movzwl  0x134(%rbx), %r13d
     0.00 :   ffffffff8146b6c8:        movzwl  0x132(%rbx), %edx
     0.00 :   ffffffff8146b6cf:        movq    %rax, 0x10(%rsp)
     2.15 :   ffffffff8146b6d4:        subq    %rax, %r13
     0.00 :   ffffffff8146b6d7:        leaq    (%r15,%r13), %rdi
     0.04 :   ffffffff8146b6db:        movq    %rbp, %rsi
     0.00 :   ffffffff8146b6de:        movq    %rdx, (%rsp)
     1.13 :   ffffffff8146b6e2:        callq   0xffffffff81eaa020 <memcmp>
     3.18 :   ffffffff8146b6e7:        movq    (%rsp), %rdx
    42.96 :   ffffffff8146b6eb:        testl   %eax, %eax
     0.00 :   ffffffff8146b6ed:        jne     0xffffffff8146b7fc 
<rhtab_lookup_elem+0x1cc>
     0.00 :   ffffffff8146b6f3:        testq   %r15, %r15
     0.00 :   ffffffff8146b6f6:        jne     0xffffffff8146b71c 
<rhtab_lookup_elem+0xec>
     0.00 :   ffffffff8146b6f8:        movq    0x30(%r12), %r12
     0.00 :   ffffffff8146b6fd:        testq   %r12, %r12
     0.00 :   ffffffff8146b700:        jne     0xffffffff8146b654 
<rhtab_lookup_elem+0x24>
     0.00 :   ffffffff8146b706:        addq    $0x18, %rsp
     0.01 :   ffffffff8146b70a:        movq    %r12, %rax
     0.07 :   ffffffff8146b70d:        popq    %rbx
     3.71 :   ffffffff8146b70e:        popq    %rbp
     0.00 :   ffffffff8146b70f:        popq    %r12
     0.02 :   ffffffff8146b711:        popq    %r13
     0.09 :   ffffffff8146b713:        popq    %r14
     0.03 :   ffffffff8146b715:        popq    %r15
     0.09 :   ffffffff8146b717:        jmp     0xffffffff81ecbb70 
<__pi___x86_return_thunk>
     0.00 :   ffffffff8146b71c:        subq    0x10(%rsp), %r15
     2.77 :   ffffffff8146b721:        movq    %r15, %r12
     0.00 :   ffffffff8146b724:        jmp     0xffffffff8146b706 
<rhtab_lookup_elem+0xd6>
     0.00 :   ffffffff8146b726:        andl    $-0x4, %eax
     0.00 :   ffffffff8146b729:        shrl    $0x2, %esi
     0.00 :   ffffffff8146b72c:        movq    %rbp, %rcx
     0.45 :   ffffffff8146b72f:        leal    -0x21524111(%rdx,%rax), %edx
     0.01 :   ffffffff8146b736:        movl    %edx, %eax
     0.00 :   ffffffff8146b738:        movl    %edx, %edi
     0.00 :   ffffffff8146b73a:        cmpl    $0xf, %r8d
     0.00 :   ffffffff8146b73e:        jbe     0xffffffff8146b7a7 
<rhtab_lookup_elem+0x177>
     0.00 :   ffffffff8146b740:        addl    0x8(%rcx), %eax
     0.00 :   ffffffff8146b743:        addl    (%rcx), %edx
     0.00 :   ffffffff8146b745:        subl    $0x3, %esi
     0.00 :   ffffffff8146b748:        addq    $0xc, %rcx
     0.00 :   ffffffff8146b74c:        movl    %eax, %r8d
     0.00 :   ffffffff8146b74f:        subl    %eax, %edx
     0.00 :   ffffffff8146b751:        addl    -0x8(%rcx), %edi
     0.00 :   ffffffff8146b754:        roll    $0x4, %r8d
     0.00 :   ffffffff8146b758:        addl    %edi, %eax
     0.00 :   ffffffff8146b75a:        xorl    %edx, %r8d
     0.00 :   ffffffff8146b75d:        movl    %r8d, %edx
     0.00 :   ffffffff8146b760:        subl    %r8d, %edi
     0.00 :   ffffffff8146b763:        addl    %eax, %r8d
     0.00 :   ffffffff8146b766:        roll    $0x6, %edx
     0.00 :   ffffffff8146b769:        xorl    %edx, %edi
     0.00 :   ffffffff8146b76b:        movl    %edi, %edx
     0.00 :   ffffffff8146b76d:        subl    %edi, %eax
     0.00 :   ffffffff8146b76f:        addl    %r8d, %edi
     0.00 :   ffffffff8146b772:        roll    $0x8, %edx
     0.00 :   ffffffff8146b775:        xorl    %eax, %edx
     0.00 :   ffffffff8146b777:        movl    %edx, %eax
     0.00 :   ffffffff8146b779:        subl    %edx, %r8d
     0.00 :   ffffffff8146b77c:        roll    $0x10, %eax
     0.00 :   ffffffff8146b77f:        xorl    %r8d, %eax
     0.00 :   ffffffff8146b782:        leal    (%rdx,%rdi), %r8d
     0.00 :   ffffffff8146b786:        subl    %eax, %edi
     0.00 :   ffffffff8146b788:        movl    %edi, %edx
     0.00 :   ffffffff8146b78a:        movl    %eax, %edi
     0.00 :   ffffffff8146b78c:        rorl    $0xd, %edi
     0.00 :   ffffffff8146b78f:        xorl    %edx, %edi
     0.00 :   ffffffff8146b791:        leal    (%rax,%r8), %edx
     0.00 :   ffffffff8146b795:        movl    %edi, %eax
     0.00 :   ffffffff8146b797:        subl    %edi, %r8d
     0.00 :   ffffffff8146b79a:        addl    %edx, %edi
     0.00 :   ffffffff8146b79c:        roll    $0x4, %eax
     0.00 :   ffffffff8146b79f:        xorl    %r8d, %eax
     0.00 :   ffffffff8146b7a2:        cmpl    $0x3, %esi
     0.00 :   ffffffff8146b7a5:        ja      0xffffffff8146b740 
<rhtab_lookup_elem+0x110>
     0.00 :   ffffffff8146b7a7:        cmpl    $0x2, %esi
     0.01 :   ffffffff8146b7aa:        je      0xffffffff8146b81c 
<rhtab_lookup_elem+0x1ec>
     0.01 :   ffffffff8146b7ac:        cmpl    $0x3, %esi
     0.01 :   ffffffff8146b7af:        je      0xffffffff8146b819 
<rhtab_lookup_elem+0x1e9>
     0.00 :   ffffffff8146b7b1:        cmpl    $0x1, %esi
     1.14 :   ffffffff8146b7b4:        jne     0xffffffff8146b677 
<rhtab_lookup_elem+0x47>
     0.00 :   ffffffff8146b7ba:        addl    (%rcx), %edx
     0.03 :   ffffffff8146b7bc:        movl    %edi, %ecx
     0.00 :   ffffffff8146b7be:        xorl    %edi, %eax
     0.00 :   ffffffff8146b7c0:        roll    $0xe, %ecx
     0.04 :   ffffffff8146b7c3:        subl    %ecx, %eax
     0.00 :   ffffffff8146b7c5:        movl    %eax, %ecx
     0.00 :   ffffffff8146b7c7:        xorl    %eax, %edx
     0.00 :   ffffffff8146b7c9:        roll    $0xb, %ecx
     0.85 :   ffffffff8146b7cc:        subl    %ecx, %edx
     0.00 :   ffffffff8146b7ce:        movl    %edx, %ecx
     0.00 :   ffffffff8146b7d0:        xorl    %edx, %edi
     0.03 :   ffffffff8146b7d2:        rorl    $0x7, %ecx
     0.06 :   ffffffff8146b7d5:        subl    %ecx, %edi
     0.00 :   ffffffff8146b7d7:        movl    %edi, %ecx
     0.00 :   ffffffff8146b7d9:        xorl    %edi, %eax
     0.13 :   ffffffff8146b7db:        roll    $0x10, %ecx
     0.78 :   ffffffff8146b7de:        subl    %ecx, %eax
     0.00 :   ffffffff8146b7e0:        movl    %eax, %ecx
     0.00 :   ffffffff8146b7e2:        xorl    %eax, %edx
     1.22 :   ffffffff8146b7e4:        roll    $0x4, %ecx
     0.28 :   ffffffff8146b7e7:        subl    %ecx, %edx
     0.00 :   ffffffff8146b7e9:        xorl    %edx, %edi
     0.06 :   ffffffff8146b7eb:        roll    $0xe, %edx
     1.13 :   ffffffff8146b7ee:        subl    %edx, %edi
     0.01 :   ffffffff8146b7f0:        xorl    %edi, %eax
     1.37 :   ffffffff8146b7f2:        rorl    $0x8, %edi
     4.96 :   ffffffff8146b7f5:        subl    %edi, %eax
     0.00 :   ffffffff8146b7f7:        jmp     0xffffffff8146b677 
<rhtab_lookup_elem+0x47>
     0.00 :   ffffffff8146b7fc:        movq    (%r15), %r15
     3.07 :   ffffffff8146b7ff:        testb   $0x1, %r15b
     0.00 :   ffffffff8146b803:        je      0xffffffff8146b6d7 
<rhtab_lookup_elem+0xa7>
     0.00 :   ffffffff8146b809:        cmpq    0x8(%rsp), %r15
     0.00 :   ffffffff8146b80e:        jne     0xffffffff8146b6a0 
<rhtab_lookup_elem+0x70>
     0.00 :   ffffffff8146b814:        jmp     0xffffffff8146b6f8 
<rhtab_lookup_elem+0xc8>
     0.00 :   ffffffff8146b819:        addl    0x8(%rcx), %eax
     0.00 :   ffffffff8146b81c:        addl    0x4(%rcx), %edi
     0.00 :   ffffffff8146b81f:        jmp     0xffffffff8146b7ba 
<rhtab_lookup_elem+0x18a>
     0.00 :   ffffffff8146b821:        movq    %r12, %rdi
     0.00 :   ffffffff8146b824:        callq   0xffffffff81840570 
<rht_bucket_nested>
     0.00 :   ffffffff8146b829:        movq    %rax, %r14
     0.00 :   ffffffff8146b82c:        jmp     0xffffffff8146b694 
<rhtab_lookup_elem+0x64>


> Please share 'perf report' or 'perf annotate' for lookup.
> Maybe worth it to include in commit log.
> 
>> +}
>> +
>>   static void *rhtab_map_lookup_elem(struct bpf_map *map, void *key) __must_hold(RCU)
>>   {
>> -       return NULL;
> 
> imo there is no point in such a step by step introduction.
> Patches 1,2,3 can be squashed.

