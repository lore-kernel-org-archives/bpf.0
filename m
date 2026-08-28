Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41126356762
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 22:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787956141; cv=none; b=pSNCw0rgkeOrpK6d8K8iWhxLivc6fjKZNiEdv/B+KbpTlCfzo/4IlhenIH/JaHG18XksXdW5C0CMlpnFCGJd2DsimzUIdjbc45OG5AVFe4GFpbKmijSfuMnFv9cLzHQl09rGKDoTaEDASGYbEnnHs+xEAarPMx76EZkedigoUyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787956141; c=relaxed/simple;
	bh=zKSWaarfHk+sxiW45kRdXEk0Zuj1GaHMmg0cAWIMgYs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=kICOE8BS1WHE7XwuiDA4g2TqumMwUQHOFCAcqzB0X0qahZeiBfNnlw1jC9or4tKnKGYeFz8IIP+jzscsfHn5Zd0BqlpxKgDISqZ9RrRGLqGt/4NIt9xYEb7LJa9ynqldbskQWcRbSxJ1PuutYMfiFMe08mMHvaC5y1mAz0YwgaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJ4n1yHi; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJ4n1yHi"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-482e1b0bd08so96388f8f.1
        for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 15:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787956138; x=1788560938; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=t4mmsE0vwNZ+9eHiF/Qqnz01ajNJwzmK5X2K1V28jao=;
        b=lJ4n1yHi2nxN0Npxsth0XNUzkukp5TOVZzWrcTwhD1v665rfJAEjoHZOAbDWq7jtlQ
         93e6Hp8oiJbt3rPSya8xylFfoP5NXy7K5KMiIpLHM0a8mnQ9/r6FGjZP6L+zgZcGVPcm
         Xy7Tu967xSPi9ml316Q4eAx9nHYWcpBeQL+ooOiHi9ClEdNEBgG9ULY1BMque+/xfdDO
         cNWp0nX25MgCFT55rOMbAcG+eZ47daGuflTboAShNODUxiu3cIm/4PlIkxcPCHJyjXuY
         XwiqmwtIxYwY11i8phBltKWb3yJeilHC9FaF9/c9gzOiNNSznQyw0sgIr+JB521J53KN
         XMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787956138; x=1788560938;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t4mmsE0vwNZ+9eHiF/Qqnz01ajNJwzmK5X2K1V28jao=;
        b=K2nGF/ew0COhz2bqmhatJMT9P5t/5gn+PfPEmcKr7dOtxF4JtRyTov4pDL8Vbfww4r
         SUNp/WUD+O71yMwnvQlfh6p/zXojzKYCs58+7kpXG5j0UnZ0Pe4jsqIrEsTx7sbmdjYu
         /zJGCljlS9CbT1GhExdQACoorvhzJAlrQeUaO/1il3If3rAwqVrJKfmBOzVYSz10ok0U
         tsuAQl6oK5FsTfQdl7QOHkiggGx2VU4KOT/03oaP8zjmh7JHMrIvrWKbdTak8pH7MYs9
         pmwcfeHoQkcAH/To9foG1sAIwZ5y6TRd94mJ/qCYW9J92LPbon5E3i6iwzrzBXx3KoVA
         2umQ==
X-Gm-Message-State: AFuF++lmGdCGMHQA27RQPmrSkkjUSd9aZOaXPtxCzu6qTWUvai/CWg9y
	tUFViNf0vBqfRS0LcPJsRFvBtmVxEzHoN8JRYiiinVnX+9mQcTnMhGxWjfKW1yhF
X-Gm-Gg: AR+sD13cf9Wdm1rSebUxJhcEq1CXKax0eVRDWIPhhDZ9STdAWUuSX34oS2cPM1knntQ
	jGuiyfZdfc3dRa2Yk+SyFu4eyL4uYPn226rR0ERHqse8MtULnPEO2aef++lmLbwR8m/eGY17Vug
	bRDtdhsOzDlmwxDpY92pbhMtD2yfo9uiBLbjS9jhjdPA3O1lnX+8aVWoFM48ubNQI85ATCoIo9Q
	X52vZEae1dJ6S5yxQykDkSuxKAHb4ZBmlDiH8HZfdnnF5leAML7WQaP1X/c28/KvYHrifOGoBur
	9rioUVB/bRdz+qKrlzmCpM0BAVkkq9I02rDoz+++Mk/yZ5nKtwzC9CvT4Ep/VxuPbr3E6ad4Rrk
	dOevQwmkDuYKFUWJxqkhaOsh8deN8TRu3tCdaDLUS2NiGTcfCokhlekc4igp0a4TracIGGuBZU7
	mRmrNu4JyO/S4FWLnDjh+Dh9uKLUbH21Tfjq6Cq3rofxAgQ8KZRGCcg7tcO2tS64qMIjoPvEjEk
	e03axb6JX2ikUWhK1isqAvpvZcFgOVroXTllf/lQqUUb6v4R153YGTqGssyjAvbEB8r4GaoGhO0
	qjd5r7XrqWNTfBcvqM4ZLTGwKLY=
X-Received: by 2002:a05:600c:529b:b0:499:59fd:dbfc with SMTP id 5b1f17b1804b1-49cca2b77afmr43421205e9.1.1787956138058;
        Fri, 28 Aug 2026 15:28:58 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b91728319sm89138465e9.12.2026.08.28.15.28.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2026 15:28:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 29 Aug 2026 00:28:57 +0200
Message-Id: <DL0XJY6WNQO4.121HF3BIU9E4L@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf 1/2] bpf: Fix NULL-ptr-deref when dumping a key-less
 BTF hash map
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>,
 <sashiko-reviews@lists.linux.dev>
X-Mailer: aerc 0.21.0
References: <20260828093142.179856-1-jiayuan.chen@linux.dev>
 <20260828095416.50FE61F000E9@smtp.kernel.org>
 <8b3e7f24-795d-458b-a24e-fe154b0cf03d@linux.dev>
In-Reply-To: <8b3e7f24-795d-458b-a24e-fe154b0cf03d@linux.dev>

On Fri Aug 28, 2026 at 12:51 PM CEST, Jiayuan Chen wrote:
>
> on 8/28/26 5:54 PM, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential iss=
ue(s) to consider:
>>
>> Pre-existing issues:
>> - [High] btf_modifier_show dereferences NULL when a modifier resolves to=
 a void type.
>> --
>>
>> commit 36dc7c26f56375bd142801da1fcbc83e4a765c35
>> Author: Jiayuan Chen <jiayuan.chen@linux.dev>
>>
>> bpf: Fix NULL-ptr-deref when dumping a key-less BTF hash map
>>
>> This patch fixes a NULL pointer dereference in btf_type_show() that occu=
rs
>> when dumping a key-less BTF hash map. It restores previous behavior by
>> rejecting key-less BTF in hash map check callbacks, and adds a NULL chec=
k
>> for void types in btf_type_show() to gracefully handle any other paths.
>>
>> Reported-by: syzbot+37b56485bbbf90ad8489@syzkaller.appspotmail.com
>> Closes: https://lore.kernel.org/all/6a8f4e88.27659fcc.2ceef7.0008.GAE@go=
ogle.com/T/
>> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>>
>>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>>> index da36d4b9d31ab..c32265dc4ae7e 100644
>>> --- a/kernel/bpf/btf.c
>>> +++ b/kernel/bpf/btf.c
>>> @@ -8229,6 +8229,10 @@ static void btf_type_show(const struct btf *btf,=
 u32 type_id, void *obj,
>>>   	memset(&show->state, 0, sizeof(show->state));
>>>   	memset(&show->obj, 0, sizeof(show->obj));
>>>
>>> +	/* A void type (e.g. type_id 0) has no show op, don't deref NULL. */
>>> +	if (!t || !btf_type_ops(t))
>>> +		return;
>>> +
>>>   	btf_type_ops(t)->show(btf, t, type_id, obj, 0, show);
>>>   }
>> [Severity: High]
>> This is a pre-existing issue, but does this fix need to be extended to
>> btf_modifier_show() as well?
>>
>> If a user with BPF tracing privileges invokes the bpf_snprintf_btf() hel=
per
>> with a btf_id of a modifier that points to void (e.g., const void),
>> btf_type_show() will see the modifier type and pass this check since
>> modifier_ops is not NULL.
>
>
> Right, good catch. Passing a "const void" type_id to bpf_snprintf_btf()
> resolves to
>
> void in btf_modifier_show() and hits the same NULL deref, which the
> check here does not cover.
>
> Shoud I add the fix in this patchset since they are all about "show"
> semantics?

It would make sense to include a fix in v2 together with this, but in case =
of
bpf_snprintf_btf(), we should still print something for such type id, right=
?
