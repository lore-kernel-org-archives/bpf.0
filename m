Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792623159;
	b=O6Snpui/na1rmfE8pJV/fiIS5l6/FcKhvmTzEPsYLoe/vfp5Qd7IEnyVWdckq4iIglRf
	 oGCGGbL8ODl9Rkko3oehm7omRO8iLypLiGX2orduk8mmV9X4X3YUPa3RSiCcqqVF/YU3H
	 XucbxO2L5JgkOGWt385x6VatdPOsn2k8Y6DHaW+ABtmOLB7OzGuvLeKPQCzsJ8+A5FvOP
	 xY+0TkBXCiRd1Cuuxh5JCq1IfWsPZvO/NklLb0yT9fQGbFwxI/zFI5w6XZxOSS4wPv1QU
	 Y40mUH9HfxH4WF75pzkCL9OlqoyDLE+tKQIVYmpJIHjtG1KO90hX3KxKaE3hp5V1dYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792623159;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=v9u/hy9t9m4fz0Ev+ivo47E4Eby44Bm0g2fkBYPU7nE=;
	b=tGQMNACzF4fSY76B6JsyPx+ACTtEgEYtMP8JlkV014tcmAa1nk+uDrXfWvJLPZTyM1Cs
	 0FP0vpKNLqYCmxrAQ+cYOCPsKDqMtdY7/PUHYr5DFyfwMTyQCK4O5FDofZ5Zn16nGq7R+
	 0v3vLx40mTgxUvEoLCpRsLYWLTeahUdNXvB856EJF6GDhtBLRUPMPbriH5Q6vThg1S8V4
	 WmDE88AdUy3NcG02yt8YykNLQ4EMejOnYFJD73iyZKlS/fkawodBAGHZ0GZnqWNaRSU7r
	 VAH+i5lQs4MSyb5rNTamHFSBZpbfhpFqTxYh8y7FKivYcuZeLoO7M/mtHTIU9Zs7RcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J6krMgcs;
	arc=none smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD81F606A319
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 22:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD81F606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J6krMgcs
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b2232d8ef5so1916704a12.3
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 15:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792623157; x=1793227957; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v9u/hy9t9m4fz0Ev+ivo47E4Eby44Bm0g2fkBYPU7nE=;
        b=J6krMgcsgyv9rcwwSw27yuUJwMV904kUEkVqycLdIhUurIL/nnK70j/PCaQOUMgRsG
         fjwQmw5/URZyc5sMmPlwaM+qk7iZ21HDyd1ObY9u/dLwdssn1ZjzzeDBj57g0DnSEpwL
         iUqaK0YHQacd0BHk2rubmekAzW1fVvMh/ExzMccDOWe+pn1QbVWL0xAlw8u86Suwzo1L
         /WgNfq/5dji2uXTqn8oNoEUvFfSmz6lbNQKBcSg5SCks+0wLKQfBMBq2GjsLfsTNuzRe
         3WDVLjmxjMZCrcDk2EPPDpkphmx/ql2OecS6P9Nr6ulKg2kpHhGbhfVWLmU/pn/mc6Ui
         yLJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792623157; x=1793227957;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v9u/hy9t9m4fz0Ev+ivo47E4Eby44Bm0g2fkBYPU7nE=;
        b=A+Pn5M3qAITO5sHaRGEjTtMmj739AVbWKppMdBJSOTLfKXnW7CMnZmo2vvtjLbUEhR
         B/59fsKZMsTUTOcgD0PsW9trG1/JPYa2YzdS25esnn76jpREVWBFtjDq4t8NkO+cIdun
         7elWbECJezULC5cpVO21MtHTaPXp7yRiEbHblBdjr4RPlA/L84hepyNcOM6fouOCe+E3
         wDOg56LyfleWxqlo3qY3kugzjP/3GX0Gt4h+v+qOIJkbEv06AjbTGfiis2wUQKlnxRhP
         QamOjD/+b2dYPzEw/s98vdwBsOD0xPh2IfebMOPgG7GwE+0bVx+pKj27oaUcxMn0aHtw
         8LeA==
X-Forwarded-Encrypted: i=1; AKwUvBxXoubNCWAFVkOT14oJN3Bn9IGYvQqb00eMwtBKQ7Y5Y0oONEXcrhIc1OfGHtO62TLYCrA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJosXPyrh0Yr+VwDye5emy8PhqwwbTDuQ7uw9DTA++9tsu7avII
	9/CRFG/gn2ntaihe+O3ehF7mb0JPzZ2MpEDijFv+Ga+4i97k0ATaZPL7
X-Gm-Gg: AYBFou06BhGXRiSxPZ3qvAp0JTnqpyi8Vd3IdGrwPkM0t4ZTs9JnOUDaIaQwBNhKl3D
	3YFN4IngBfQxgeAvx3oTqt9byZ1Pptf+DPnL0Rk+Sqd7UEhGLgzf+aS3nRd08nkWr3U2nk7QMGW
	RPJesS7+fWt2BuOg89Qkq3X1WwIZKdAXDTebg4glegveEf+QeSPnVsmL2tX+RKTTyt20uKPmlQ+
	wFIRK6DnpfMEllaeyPHLwGfK5hC63VwdFf2ZGcOHbhiiRtKyb/3TSuz+s3vx+jf7qPFCJ7o6PUr
	4mUYF19guoK7D4U9/QLq/a9wd051HVRkyaT8RaB0WKj8cwOoxtAgZKzZjt6YGqBVdCHxXPQG9hS
	e+6q2j8XBr5MP9kN1mBkM/oA4CgGMupicHj3OD+whWSlLpbRGGQysG2R5FKwpWUzKiARhdhvt1f
	2NLPbSonnHYJxSE8PcAq7KNdmAoXcVQ/HVGz5/MNUjYno81empga0zCWLsltH97QR5l1prHdqaJ
	Gz3oVcLx6tcKi80I/V8fzBN27WesU4KBiT/48l1muWwSExrsGkVd+iKZO3+xub1EPgsx+6V3rCG
	N1rNOHGRXHR33MzWcxLyoaGuJb0CP+D5d9023Lc=
X-Received: by 2002:a05:6402:2111:b0:6b4:20bc:fa3 with SMTP id 4fb4d7f45d1cf-6b420bc18c0mr141102a12.22.1792623156776;
        Wed, 21 Oct 2026 15:52:36 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:f859:cfa5:144c:f54a? ([2a02:8109:a307:d900:f859:cfa5:144c:f54a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b403110fd7sm1248786a12.20.2026.10.21.15.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 15:52:35 -0700 (PDT)
Message-ID: <6ecce342-a2a6-407b-95a4-472df021f5af@gmail.com>
Date: Wed, 21 Oct 2026 23:52:33 +0100
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] bpf: Stop JIT passes only when no insn moves
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, kernel-team@meta.com,
 eddyz87@gmail.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20261021-jit_size_fix-v1-0-b89fd32cafd6@meta.com>
 <20261021-jit_size_fix-v1-1-b89fd32cafd6@meta.com>
 <DMAV2RFTNVWP.26B5N5NZ3TCEL@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <DMAV2RFTNVWP.26B5N5NZ3TCEL@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/21/26 11:15 PM, Alexei Starovoitov wrote:
> On Wed, Oct 21, 2026 at 07:21 AM Mykyta Yatsenko <mykyta.yatsenko5@gmail.com> wrote:
>> A backward jump is sized from its target's current-pass address and its
>> own previous-pass address, so it can grow while other jumps shrink. Two
>> passes may then give the same image length with jumps still changing,
>> and the image pass fails with "bpf_jit: fatal error".
> 
> can we fix the sizing of the backward jump instead ?
> 
> It's the third time it bites us.
> commit 1612a981b766 ("bpf, x64: fix JIT emission for dead code")
> special cased ja -1 and
> commit c8831bdbfbab ("bpf, x64: Fix a jit convergence issue")
> limited imm8 to 123 because of it.
> With this patch jumps still grow, and the one that grows in a padding
> pass still ends in "unexpected jmp_cond padding: -4 bytes".
> 
> do_jit() knows how far the current pass moved insn i. With that taken
> into account a backward jump is sized by the insns it jumps over, the
> same way as a forward one. Insn sizes start at 64 and only go down, so
> the image shrinks with every pass like the comment in
> bpf_int_jit_compile() says, and proglen == oldproglen means that
> nothing moved.
> Then no need for addrs_changed, for the ja -1 special case and
> for is_imm8_jmp_offset().
> 
> Something like this (compile tested only):

I'll send v2. Thanks for the suggestion.

> pw-bot: cr

