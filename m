Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F7D2E7BD3
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 18:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778263315; cv=none; b=tsABd3DjxiKHsIauPJs9T0+3QD3Sh4LsYBScQojhQO4laASQPBJ+U3CkutOG2U0q5dvQJHqa8zVOv8PR32JS9Uwf/o/pbcnIIdrPp6Ib7k1KxjiZ2hh2Eb4a0YiY7Jzi3UDIcqYs+h1uY0YZioeNpUCZbI4sLoF8rs4pDfEmC5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778263315; c=relaxed/simple;
	bh=kZW8TH3GBoIgD+WULBIcif1nJ/pvEZ+sZq10VpORYp4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=Kmu7MrdaMckhEsspGybJwxPssNsbbtU9Be747xHLjnCs/bdBKoti5GJ0YbcSJ0gAt/unPwNBHW5MkEti09OX8PVYnB3IdYvtXilafr5gubj963WuEEvc0TMOC6KFXXszsGqyCgvj/xuhL5pkuVNuiLhV59nMq4Xuo2UQ5iEBR0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5NQk2lQ; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5NQk2lQ"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d1872504cbso2160473a34.0
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 11:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778263313; x=1778868113; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZW8TH3GBoIgD+WULBIcif1nJ/pvEZ+sZq10VpORYp4=;
        b=a5NQk2lQBKzlKh+7RhUu4xrl4DJ1xmg7s5DKPUhUA2zaAu+2cu51DaWYx53TQtaWCB
         6OUDCEpv0gwzCjfhqmDqTDXd6xesNLut4UKiyjvFa3PweXaegT9DH/6ejyH/Se8wr7TA
         LngOQszA5sX53S7OYT2yu/5Z62DxlyFE7Tt4qVIDyKhpS0Ygi0UDk2W6TMVvb+RWpIWG
         cSxFyE03GtFqfNhD+J6PUMq2yTxuiMoqw+dmK3HJohmvEwzDE/L61nEYk1TyZQ+gNlJW
         M2DWJlTcaER32Hr9cnrGBCnGq3U3X3Hj7tIMosgYXfX8isfpFuasXy5VGtDj55ci5ET8
         FPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778263313; x=1778868113;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kZW8TH3GBoIgD+WULBIcif1nJ/pvEZ+sZq10VpORYp4=;
        b=MHk+Hl2Tzk3G639i0hRe9lNmeVNoU6vygCphJKQdmsTBOQ6k6TCz/OutCgMk4cNV4T
         43PN3avmWD9yXhjwW62HpZG1CUpnJEBf5gDeZHCoVaszb963yBCu8G5J0VSJ/LBGBXr2
         ZPSmpcmorQtTySqc+DPXWxRuxqFC5xDsLuGWSRM0ateErfPB7zYKsia3iuI7mq9Beeb7
         dmEU6oAyqD8Ony6ACGHkwfldNMnpigxHoPmsu2f72zZ8mKFgE7v7o/BfMJCkU6mpZGsI
         BtZZodMCwdHVFtBBUDRnE03iyNvDMFY2FtbLzSTQY3ne7SUaSqB1sAdHuwG+iHPCdlIx
         nPdA==
X-Forwarded-Encrypted: i=1; AFNElJ/3FJYEt0S+rjIV2hads231V0K66YEUsK2vG2yqLbapiUm3v4tg+6WXJCOKWl/zus6867g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj4e6I8Ofsa0+1TwgAv5ml3Wm/SZ2CMKInm+oj18k0Y3tKwQJj
	koDXux0uV7Yo9GPrTzaaa1UXaMjeA3HaqP3biKywZBRscCuoXZjFje3O
X-Gm-Gg: AeBDietfsQ7+wxVJqBLxL9c5aaTFDRe216g/UfHePBMri4vvPS5x5Zjj860RjkWGQ3G
	XDmOs5OdUfKryCodOQzMQdRi1sCI6yyT27Rvty36/pOV7Ja+9P7Q3CCWfvCBplrElI6be1nUA+b
	zDMqaOsMQudU0hOVxD/VS0DgowZlUQ4C4sS8kZYGwK4QisG6f2+GenvapIay0DHbzt8Wx4izfaP
	ivWmCwzUypltK3yefP63cGcuUz844K5AKlWNsQCrlj4Q2szbV0th397ZKEm7u6YXcsYq+gpL9QZ
	RHIGLf269wQCgk8k8MjRpI93HIwNhycRPnT9NgDu9IQevibopsZgnC7uqMmEVyEwJsrLX26w6wg
	toRGmGHu+E/wyjhzE39zHOoS52GcRqo8zI64UPY96pVi/eMbnQV1PM8IrP94n/+rVCENtkcDcGQ
	RAf/pjDMbg0nGrAPbrwUYLUSC45gpCxJn+K4JKBr10xGN+OPtwSxIabN4QnVK9VGJv8ASGhu+wZ
	43wQZxBSxMCkBcHFv6Sje6R5y51
X-Received: by 2002:a05:6830:61cc:b0:7dc:d725:fdb with SMTP id 46e09a7af769-7e1fd20ba59mr4968472a34.8.1778263312967;
        Fri, 08 May 2026 11:01:52 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:45::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367d4fde9sm1514030a34.13.2026.05.08.11.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 11:01:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 08 May 2026 11:01:51 -0700
Message-Id: <DIDHQFKDC6HH.4WI1HOEQ6HT5@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Jose E .
 Marchesi" <jose.marchesi@oracle.com>, <kernel-team@fb.com>, "Martin KaFai
 Lau" <martin.lau@kernel.org>, "Puranjay Mohan" <puranjay@kernel.org>
Subject: Re: [PATCH bpf-next v2 21/23] bpf, arm64: Map BPF_REG_0 to x8
 instead of x7
X-Mailer: aerc
References: <20260507212942.1122000-1-yonghong.song@linux.dev>
 <20260507213156.1139442-1-yonghong.song@linux.dev>
In-Reply-To: <20260507213156.1139442-1-yonghong.song@linux.dev>

On Thu May 7, 2026 at 2:31 PM PDT, Yonghong Song wrote:
> From: Puranjay Mohan <puranjay@kernel.org>
>
> Move the BPF return value register from x7 to x8, freeing x7 for use
> as an argument register. AAPCS64 designates x8 as the indirect result
> location register; it is caller-saved and not used for argument
> passing, making it a suitable home for BPF_REG_0.
>
> This is a prerequisite for stack argument support, which needs x5-x7
> to pass arguments 6-8 to native kfuncs following the AAPCS64 calling
> convention.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

That's not right.
It should probably be:
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

