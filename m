Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793153722;
	b=kBtDxSOA9S5K7s+3VrTkpH/s5DcodijStQ3pL4bRXHyQdDpSCAKIscbrev0F07qEFYbN
	 cOpFAIcZP57aIwpeOda1pWgImnr6fUQDet//bx41VkjqY1V1385KkPnsFBFAUdk2tmofi
	 /0bz+0gtJASFS4EkGiPGACv6BbrCF2NSPDEIyQ68xbddBKRWdHFwzBbwNPRtoEXiqhtd8
	 QsbCQFSnxn8fM+5gnptCD0KSLvMSA9gxm4WGN+dDDZvhK1hU+tP1TmcDU+OJyTiBfnQxj
	 73+SFhG+o332ieIL4WEaWty2Q2gF/uMSr7G/5MFWiGTvWQ2qYtVAIRnx8hGwHsMskPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793153722;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=NLBIAayvlvf3sQ+/IvGlf+0hd85ILv6HIkD5Ad9OfYo=;
	b=Wru31R//Rqz7dFr4/i7FnSpHR4x1VE46EaGhmBYav6criKewnoyFRkWZNH1D3E5xNhNj
	 K+t281XzcU9Mw6N4MGD83PEjDGnbA0NSsSvDB11uUJlrb8yG7uI9oVwNogooIYOh4rUi/
	 83feur9nvTWpwh+N1wAqU4evOXlSDaz0j5nyCGBA9seZR/N1JvmHHtyZHmkGu5j2omiKa
	 +TyxL9txshnG11fWRr3NNXdt3p9P5q+hiD2z6ojjocipJWGkQQCiUR/9uL45X8Td7K4Ar
	 NPi/HPGiL1AyXd9Q9KKxXGKLnsLndCghg1KH9WtiyhO4Me4SKHE1I8wzKiBE2vuagrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=02zetP6K;
	arc=none smtp.remote-ip=74.125.225.74
Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B65606A320
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 02:15:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41B65606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=02zetP6K
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-48dea979eb9so207015f8f.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793153721; x=1793758521; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NLBIAayvlvf3sQ+/IvGlf+0hd85ILv6HIkD5Ad9OfYo=;
        b=02zetP6KfskWHXaSsgPyKTFoPfCshC9wl/Kmv324aqlSN+AzJuK/lihyavsK9JJQf4
         wxLyWj1gNL+/sT6jxbvpu9MIFx7m24qs5klDOmNp+Irl/X4J8iKWNMBEbWO2Fx6QwEj1
         ofPFQokJD66IM6InOKkR5SVh8d6O2kEAWe6axTrSmXtSBq570XxtPXe2WJstAcvHPdpX
         3WH+uRDMwMOeYCpmArRqR8fQYHZ4SZ6UPC9N6c+MYhCZJ3gYXrBcEyylQnY+6rKNn4uN
         qTdB27QYo3UFWGNrJM+N4dTQETyymVm65erYTqXdmNF6oWrFaVRGaF/adEMZdL3McL7r
         5QKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793153721; x=1793758521;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NLBIAayvlvf3sQ+/IvGlf+0hd85ILv6HIkD5Ad9OfYo=;
        b=NkZMeAM0lybaPc3Djq7yPdxEKrkm761nfZkH+upmIzy0q5wDovtFMHjMiVbPo7teTb
         OuxOZ72OUS3Yvx9nbSH+wFpFpxDJXIZ5vtqdS5zELxgorevv9UQzz8ywUyzE2+zzS6aH
         Eie9x9oq2NQ3d4Q90mz72PIo5+zZM/bnkQLjk/I5Hw3KNLV/BBuDRYwB3wjMVzXN7BtU
         yPnAZlNbWHNkGpjAynf56ej6VH82U87QUP68O1FMAYSMlliY8DDTHwcZAZ0EztRnabwR
         Q9uwL2WIdcLiDY7h+PhzcgVRfRI7atDDQmTCm+uOxWOrZG8C7dMHOCx4BKzIlL/xKiTT
         My+Q==
X-Gm-Message-State: AFq9FYLNDbydHq675Cl/Fp6PsA8K0UStMyamyyEi0bi4uAJgoyZTBaO0
	G3jGdomkIOhhGV6sfK3G5k16hP2kZUWg9aOS/D274Hpl3vl9Z1xFfE86pQtqr9tg
X-Gm-Gg: AYBFou2eFiTFA7h4fAv/bf7ZOVImtJX7nPTUJuwuSkbsNw4nhXehhSSxXyFJyeGY8FF
	mriJLgAlgEn5uNAgkJ2kDqd+h7cf5kw3KPjNkoKcxEomGRY9We+4OGXdS26gP1ZHt0+MfUILJKu
	BwvTi/oTMtLCOnYbKBlgZopgqu08O+Yzir3DgLCr6DlMrMLwyC2sBAnAA/zBa1kwGUNnxGIAMtT
	1A6Dqgqlj5oiz2J10VxmMBJBKI3y3mrZVppcGDO5yRqHt9grmksX4wfuan0uOeQMp14R0pbxZBm
	FpgH6YZCj/j8ykeg4Pa5J919IQcl+0fWCTSq8cWWHgKAMWPRfjdxixVRv8r/rIqpjCZ8qaa7G3G
	8CSt/S0lYEiEF/lcGkaY0PvblIdJCnR5RcEa/AmTQNhmM4IfDLiEFuieUT/tdiaImvi8aTH0A/K
	CwxXzqWR/PJdP/AIo2EYRjQaH8w9BLZMIe3UBcm7LY0UIy2GC/NQk9aEVpCiCYiB0PCMOWlEShO
	Hsk95uhZgydd3b3Q3j3r+Ry91d+540zosAVJrATisA0W0h0GmLvXoE3Rlhjjhro46auJ9r2WGg+
	YVW1lN1GUC4VCTygJbYu/B2LAtGev2BilvORjN+tqc1eAI8Sm09Cbwpk+jFsIdl26mpwof70aOj
	6U3S14nPyc+0VSArqFJz6oEmO4Bhzh50LBrmMwAJFYYB2sgyTU9BN6E8/1kwcLqq0teHK
X-Received: by 2002:a05:600c:4454:b0:4a1:ce33:1536 with SMTP id 5b1f17b1804b1-4a965cdb7afmr16056415e9.9.1793153720605;
        Tue, 27 Oct 2026 19:15:20 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a97c42b3c1sm10695605e9.6.2026.10.27.19.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 19:15:20 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	kkd@meta.com,
	kernel-team@meta.com,
	martin.lau@kernel.org,
	yonghong.song@linux.dev,
	mason@kernel.org
Subject: Re: [RFC PATCH bpf-next v1 01/11] bpf: Give a helper a way to call its callback with a pad
Date: Wed, 28 Oct 2026 03:15:19 +0100
Message-ID: <20261028021519.1203900-8-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <81df2f63249021a13160d155eccab3bbd591e464d05db9765a15427c3cc97650@mail.kernel.org>
References: <03d6c53ccdf3eb0f5503eae9f9ffa5e6570549c3.1793147364.git.memxor@gmail.com> <81df2f63249021a13160d155eccab3bbd591e464d05db9765a15427c3cc97650@mail.kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed Oct 28, 2026 at 2:39 AM CET, bot+bpf-ci wrote:
> [...]
> TL;DR:
> - bpf_unwind_leave() may misbehave if the helper is ftrace/kretprobe/fexit
>   traced: unwind lost, pointer or reference treated as scalar

Right. Every function with a pad is notrace and no kprobe target in the
next version, as the verifier lets only fentry attach to a subprog that
unwinds, with a test that fexit on bpf_loop() is refused.

> - With gcc, bpf_call_cb() register variables may be clobbered by KASAN/KCSAN
>   calls, possibly jumping to a bad address

Right, for a call in the evaluation of a later argument, which the
compiler does not keep the register variables across. The next version
evaluates every argument into a temporary first.

> [...]
