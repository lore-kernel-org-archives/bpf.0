Received: from mail-ej2-f11.google.com (mail-ej2-f11.google.com [74.125.228.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7BC426429
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 12:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787660594; cv=none; b=WfF36V23lrVHyTJjSiVeIcgNMzuefl9gnS38pdTOehFRMRBeCqq/Wq6fhWeqXZoOdN2PFREFGviNv4cPE0kMRzeECbB4ZajAMNOySMn8jFBfsDeF/R4OlqFjqCFemAXiRuvjqhkM+2Pz4SKzjkcruk3HuACDwFmtKB3JsN6IrLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787660594; c=relaxed/simple;
	bh=T82kPS0r20tb52VMwMiP90ZL+6R9xinNvOVGOM6Amm4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ITDtj7KiU7r6HsqDy3AkPGOyqPjxnpG8xRpjIVehGS6RYQ8XyJu89yB4nqjAohkTnF5KKXVnISiA1df8+it3WHwY5BiBn+kpgBKDWx/n29r0rVG6jbHEj/BBQK9dD2HHc1e2MUpNBXmvjKa/mHuoQWwpFx7rgSxNvkwXx+7bJB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ij/XQ/w4; arc=none smtp.client-ip=74.125.228.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ij/XQ/w4"
Received: by mail-ej2-f11.google.com with SMTP id a640c23a62f3a-c2117cb0c09so183772066b.0
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 05:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787660591; x=1788265391; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bjm6ttTTLAAxVRPB57CUI15k21GkGZTZ0M8HFR93li8=;
        b=ij/XQ/w4hJMAW/ppnF3tfa8BoVn9rOdrvNN/Bdmd1eJUrc79zcCTYLLgJuJngGkZZn
         JfjdYtYGqOGsgBZgH+ap2ZhV9yH14P/yyXgmYaUXS2aWLbVkcDqaQMHxCpvVXUPToNYa
         Hedgnm4Ct8ComGJJ9aV7gj37KtNeoSYIRVMDFTqpfqtdZp/gJR4iJVZhaQKhGaXpveAV
         OXcCLhYRBIkxrFAYxI8mOiUsOf16VxTX0j5dKCfWNqnLLtUdT4CL1wQ19y734Q7HK5xb
         8AHx+0xya9V2az5euzLt8rM2vAIv5BybbzTtby3t6gPIXSTpB1zeUL/6NtgrgCC0+EW7
         iIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787660591; x=1788265391;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bjm6ttTTLAAxVRPB57CUI15k21GkGZTZ0M8HFR93li8=;
        b=Afssth+MV4t8QS7IKpWf4v05gx8Zh51svj64JnKQ72GeVZUOt82sz+ZwXnfz1uR4CZ
         +YXe8dPGVNbzhQhtTYtudwQ/izx7L5FsXtmm2BMOcE6/PKzmQxzL5iirkJFrX27tK6WN
         METUS6L/m7qic6qmqjwRGaEszeYkElgFIdZKyLfDUGQ8DkG+PItNTV3C88W0d5SY9xtC
         bG6Xfdt+HE1XnrnjC+LHPZVIrfF0d3Zd0EAKpMzlKwYFaKcJZu1ZNdpfnjZQrO89tE5h
         Tlnvl0V7JfAWlEVx3GjGyoZquzNXArRMc8K7pY36+A4SRpaIy6yRcAx+XWOJeNFMdPb7
         YT5A==
X-Forwarded-Encrypted: i=1; AHgh+RpVQm56fubU8Y1ME9d8K79BInxwGbLl//r0tbtW4JM71y1O3U2+Obclx88/6gdPUtq99Vg=@vger.kernel.org
X-Gm-Message-State: AFuF++kLVc5tl6SViWYIsXCCmi9Z6/gja7+dx8xsDX/i37cfvAcmxjk6
	kH2x7z50g2iHE0YUPJ2M83On76a2ddGUwYgZo1wqgmsmL7PRJvZY17mn
X-Gm-Gg: AR+sD10xy+foZ55IxMNoPeZ0nICXTWIjdJiphDUq90/ltijzym3PWtxC4vQAmpq+Q83
	pmZ87GxkupXEcbY0UHKEK+MD8ftidm9JVxr2PNafhQc2eNNdQ2zoAzkactSmSCKuuAWTmWzkmK+
	mZDjo4zV8CvVTfAnEa69H77vLMMQFg3ucIcs4LnlRNoN8+fbVIwBi8nwdB0/JeBd+vgfP+4m0yK
	4mZaYe2PS3b3e5FJR0dcCL0Q0Rv/2MjYw0ukLj8N8NaeEfGIC9Pp5e3luvtxTiZRDV30bgK7AnK
	uSWReHo1dzy+9Xnh3c5veg8OcRD0azM9vkQ4mayCz2mdAhKcNe45VOkTcyLVgINqZCZDoyW8S9a
	U53S2Neq6tGcPx2hVVJI+JyPvAoQUjSGWkzKQnDdoF1esYzN3f4sPagnZJAEzNPJN18apAHFhMN
	4Cihxso14wEYXariKeOnWxaOg3M+Kefyxn63hNUvRwaHLJNXvOgVXC6WZHmurdp778m2y8IHrTb
	j3pUwbRpfrcl9Of+S/QdCoHXbxL6l9bqC28j9oBmuujyal5QZPL6YIISbWa6CfvE3SDRdmoCx3r
	nzE6C0cbQ3JLHQsixxdTgYokDU6HO/rcFHkbzQ==
X-Received: by 2002:a17:907:3e1a:b0:c24:6505:8f67 with SMTP id a640c23a62f3a-c24e589a884mr660203266b.10.1787660590418;
        Tue, 25 Aug 2026 05:23:10 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606b60asm1629389366b.9.2026.08.25.05.23.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 05:23:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Aug 2026 14:23:08 +0200
Message-Id: <DKY0SGUZGSIY.3NR8NYCRVQNM@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <emil@etsalapatis.com>, <martin.lau@linux.dev>, <yonghong.song@linux.dev>,
 <clm@meta.com>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v6 4/4] selftests/bpf: Add a test for arena
 fault-in under memory.max
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, "Khawar Ahemad"
 <ahemadkhawar123@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260825094955.83240-5-ahemadkhawar123@gmail.com>
 <20260825104311.84038-1-ahemadkhawar123@gmail.com>
 <ab878224-d75f-45e7-b625-39c4f56e548b@linux.dev>
In-Reply-To: <ab878224-d75f-45e7-b625-39c4f56e548b@linux.dev>

On Tue Aug 25, 2026 at 1:19 PM CEST, Jiayuan Chen wrote:
>
> On 8/25/26 6:43 PM, Khawar Ahemad wrote:
>> Addressing the three CI review comments on the v6 series:
>>
>> ---
>> [Patch 4/4] max_entries comment
>> ---
>>
>>> could the 50000 carry a short note that it just has to outrun
>>> ARENA_BUDGET on the smallest page size
>> Accepted. Will be fixed in v7 as a proper preceding block comment:
>>
>>    /*
>>     * 50000 pages must exceed ARENA_BUDGET / PAGE_SIZE (64M / 4k =3D 163=
84)
>>     * so the fault loop hits memory.max before exhausting the arena itse=
lf.
>>     */
>>    __uint(max_entries, 50000);
>
>
> Not that simple.
>
> It also make sure the arean not exceed 4G when page size is 64K.
>
>
> ---
>
> Please don't submit further versions of this patchset. I have already
> prepared a
>
> V6 (the one you sent), and I'm planning to send it myself. Additional
> submissions
>
> from you would create unnecessary conflicts and confusion.
>
>
> If you're interested in this series, I'd really appreciate your review
> and feedback instead.

Khawar, it's not acceptable to take someone else's patchset, and then spam =
the
list multiple times without their permission. If you continue doing this we=
 will
have no choice but to redirect all your emails to spam.

>
> I'll also be sure to cc you on future versions.
>

I think that is unnecessary, I don't think Khawar is providing any meaningf=
ul
input for this.
