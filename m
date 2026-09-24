Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42343F9268
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790243877; cv=none; b=m3N1zK5btEB0Y+6r5cI9JncnRnS2/4vQm1IHlEWqlcgxYA3ikmnDyFHXDATKxY0XPckxHyNHzRSs0jvRTbyectP6npFsutn2PhgDu4IdmP82KMWi5upZg8GpA6fruDSzUagMx0jW2srXIWivAsWsL+rl8Y4x44gpxF42qS+9Gac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790243877; c=relaxed/simple;
	bh=oDmWZzEF67iT0LIDNfxsIVScHStlrZ+4gtON/6h3WTI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=u860Ws0N8VMy4EDK46olhAcUOp9v89KY75DcvgAJ/8Esfz8fplPuPgQBKQQvVCT/ZhDBG8XSe0KQvuOKXhUuLTDYAzmLxvTr62LJEJNr+wmeCHU3SzuilcZ1j0uUN1FyMQDFC0xBFHiEyyYRjgbn+5EBQa/j0dVCH2QStE5Gh2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNtHr3ls; arc=none smtp.client-ip=74.125.225.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNtHr3ls"
Received: by mail-wm2-f6.google.com with SMTP id 5b1f17b1804b1-49fe8bf90c9so914095e9.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 02:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790243867; x=1790848667; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bOX3rEX7SDzQ7fG/AqCIxYmIJXr/sz+qoblhwhXznpw=;
        b=cNtHr3ls91MMA5kINX8z4U+VsoLLdIKp1bJa+VTyV9GoiSIztfk58492cN+MLPobCB
         Y+CFBwaoKlZ4GW2N5zaTxuQvuzae32NCtkKn6r6mRx7GZ4W5sLdG7x1UE8eqikAItCi1
         quegw4I4lntual2k78M7Hg7sNwicPLA2AZBXiCoUaJQgpvE0XL9mIV5X/3J/GR0LOIz/
         YgT3SCrLk0BWcGi1hKbDwy1VMDT52s/a5CH3qF1sfORV42aLkYUjrlUUkDAf80F6T8dU
         Ko6q6S9oluZo+vqqaNZGxMBG/gJ0iK7r72AZeo+uF+4Qoi2mPOV8r7fLUB2Zevsn7lRb
         5jvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790243867; x=1790848667;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bOX3rEX7SDzQ7fG/AqCIxYmIJXr/sz+qoblhwhXznpw=;
        b=T1qYFKwLIydgC5AwEJ5GHlDdhyaQDBNA7R47RgTPcNjRRstsCPcL9PryMKLK3hQ22B
         4MYKSL4nSnfN+0vdYWKVk32dAXQ34y6RTIj/0ny3hPII9kNtP8Jo6Ay4qR4qkTMLPUfX
         8HWB8a30ZLIBuD1PTS/wrDkBKBzQa2a0M5w2yPDRbx6jGtYY+rSKzcvjqSettfF5me+A
         QHNLQRNgDnAAHhHfP/3w2fdsOW+gb06NO5tbN8d93dqrzp4r48G5dqtS5koMr/DReNZv
         A4ACtXmF7C2N9/ZDx5WqS8c/M3AUCoM48S1KnYO0tNiFrJcjsPw7oXFOZCndEYlQCZBZ
         rcuw==
X-Forwarded-Encrypted: i=1; AKwUvBzKo0eGsRjAyqGuLM2UPOBbeRG3DkAUO5I0g7LcGV0w3Fm2jIK2REL/Lkj//ev84ury/go=@vger.kernel.org
X-Gm-Message-State: AFuF++lTC6Dt3UobdUsRD1tz5JnB8ccgabXQ3kkoe3FNh6G6QkVVjww8
	0jPFlNPw2hDnFaLNvLSd0NAq0rO7yFMKlg28hC+g2Juelu8JDxC3UFWZ
X-Gm-Gg: AYBFou0PPRKBd9RSmmbW7+SQbwznUpO/y7M1sTBgRBJYlddLivqsbvJhlY87bvPTQgd
	JOvAqyQLauKNZ9b6hAc95xCBj0Q+gO6rpS5IitP+XT4amEYFc9Om1Pk46NO6vS8iDTwYvsWCi2v
	2mm6X3xaYa1ImNr2Mu1pVUm1cZqiV980ItZsqHN72dB3WkjW5FXCbWo5OKsm50bG6RwIvdwf1BT
	uYC2Zg7koL86m8VznlQL7DD70D/+FD38d2Gq5mLluc3hLuZ3TB661+HoxI4dBtGQVahhQlFjIxN
	4Q8utVvdaPrXj8JxnhruozMv6f6YOMNH9AhTnWN7xQd1MDUEpaFd5+ozPHoKR57HE0PAfxDlVA0
	Eix5bP/YSNV1VW3Ji0hp18sn6MYJwx9IxxZ4ajEkcmpvhiSpx1kOZlk9vXJ4N0j2dwURkdvO6Aj
	KkOPJ3tpYTyVQ9o4tl0dmtuxPWumv/JVuKF9ff339uieUO0iirpiLSlCkGYVKyRGwa0BQq6ufhF
	ha2QYsPVDLadqQMFn/3mx7Qdz6wXTBHdl+ie74lbRfTbBtNai3xTNbmpgFy8jlFDKdn/sMiNAnB
	/iv8cIBhPrMFoO5pmDrUKuyHh5kQqIUJ6PTQSg==
X-Received: by 2002:a05:600c:621a:b0:49c:fa21:e74a with SMTP id 5b1f17b1804b1-49fe6705673mr32565215e9.32.1790243867277;
        Thu, 24 Sep 2026 02:57:47 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488684864c8sm13561429f8f.13.2026.09.24.02.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 02:57:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 11:57:45 +0200
Message-Id: <DLNGHIB312GJ.2YIJYBY4U9TNZ@gmail.com>
Subject: Re: [PATCH bpf-next v2 17/18] bpf, arm64: Allow programs 2 KiB of
 stack
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <eddyz87@gmail.com>, <emil@etsalapatis.com>, <tj@kernel.org>,
 <kkd@meta.com>, <kernel-team@meta.com>, <martin.lau@kernel.org>,
 <yonghong.song@linux.dev>, <mason@kernel.org>, <ihor.solodrai@linux.dev>
X-Mailer: aerc 0.21.0
References: <20260924082607.2695649-18-memxor@gmail.com>
 <4ee0bb9bfdc8274a074f6e80dfc65d386e15586e27dd3951317d0eb4b01aa0f3@mail.kernel.org>
In-Reply-To: <4ee0bb9bfdc8274a074f6e80dfc65d386e15586e27dd3951317d0eb4b01aa0f3@mail.kernel.org>

On Thu Sep 24, 2026 at 11:00 AM CEST, bot+bpf-ci wrote:
>> diff --git a/Documentation/bpf/bpf_design_QA.rst b/Documentation/bpf/bpf=
_design_QA.rst
>> index be5fc4ac00d6..98d70b8a2533 100644
>> --- a/Documentation/bpf/bpf_design_QA.rst
>> +++ b/Documentation/bpf/bpf_design_QA.rst
>> @@ -223,11 +223,12 @@ Q: How much stack space a BPF program uses?
>>  -------------------------------------------
>>  A: A program may use up to 2 KiB of stack, combined over its call
>>  chain, when the JIT of the architecture reports support for large
>> -stacks (currently x86-64); a single function may use all of it, and
>> -every frame of a program running on a private stack gets the whole
>> -amount. Elsewhere, and whenever the interpreter is used, the limit is
>> -512 bytes. The verifier computes the actual amount of stack used and
>> -both interpreter and most JITed code consume necessary amount.
>> +stacks (currently x86-64 and arm64); a single function may use all of
>> +it, and every frame of a program running on a private stack gets the
>> +whole amount. Elsewhere, and for programs verified for the interpreter,
>> +the limit is 512 bytes; the interpreter itself never runs a frame
>> +larger than that. The verifier computes the actual amount of stack
>> +used and both interpreter and most JITed code consume necessary amount.
>
> This isn't a bug, but the interpreter sentence changes meaning here,
> not just the architecture list. The old sentence said "whenever the
> interpreter is used, the limit is 512 bytes" while the new one says
> "for programs verified for the interpreter, the limit is 512 bytes; the
> interpreter itself never runs a frame larger than that."
>
> Would this correction fit better in the x86 patch that first added the
> paragraph, or could the changelog say why it changes?
>

Not a bug; the sentence was corrected in the patch that adds arm64 because =
that
is where the wording was revisited, and it stays here.

> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/359763=
22553

