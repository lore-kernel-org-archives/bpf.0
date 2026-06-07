Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF3538B7D4
	for <bpf@vger.kernel.org>; Sun,  7 Jun 2026 11:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780830400; cv=none; b=B+/0p89KiR5E4WZHYkvPCMsalJM3iDpAqmkuAYy+Ntnc6EdNj3VZNOeQRImCrdsCrU5J6s1JQnBCDENdziKgPV6bVUXQxEi/0fLiy4pvQtfO5DXtpOK34oVsIS9MoxMOuNHbR5Porw2Vh3dltwDOGLEJzCdz7KhCbAYm3zoeeIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780830400; c=relaxed/simple;
	bh=aVd7z22a+mRisIph7HsQw1b/xfCIYxnP8FjGBSiqnAA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ux15Df+B0OJDbhDtVSNndAdUwLbV2BO2BIj4GVntjXvcq2cXcpe802cZ0cgjdba2Tnm/ly0CqYaT5EQJ+A1Jdvf7u0wpEUson1RavgjuJJ96J5f1mDsWSt92wPBsrK7zpPIxFiBK/P87vC1S/9elfIjcAkpWNQUGLBayEoIWTeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgmfDDhP; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgmfDDhP"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-490b613a17bso32021965e9.3
        for <bpf@vger.kernel.org>; Sun, 07 Jun 2026 04:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780830396; x=1781435196; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbrPFfMUPEshyjWmvJtWAlA2RlCdQJQIVgTBRQv0Avw=;
        b=UgmfDDhPmrIxuD9p0ffAmgaAQFCmN5KedmMnV7VX3Kbq7KjSvoL/RDyJIg2vp81ylv
         qL6x34DHELv61hRQhd5X1+sAbwCQZlPwZztEqzxA0C0KM1VvABuJqsjkKDPuqvEmZMcP
         pNRouNekbwQKR5ZQDr7DcoUASivDfvm2BKiF5RDlt03RCmEWIsWEPczjSSra9iRnBYRs
         6BqT4vchZSa1zwGWbG8KsS3He59MdJJNYVm74iQJZilLlq9tFknLATsIMyC552etn1XI
         4aBjGK9rBKuAkYxpDswGqx7RwtluNW4AVwjtrPX7NVIarIldLmdO8B+bcX3F6njl3SFd
         iA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780830396; x=1781435196;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zbrPFfMUPEshyjWmvJtWAlA2RlCdQJQIVgTBRQv0Avw=;
        b=TOrFt2m438P4sinNj0AAdq973EGzjzStLJTUWp1fHmtdnYs6SuLfFwMDsm/fpkDXw5
         n5o8RFax5WgJ9Ll2CA1CUGwwgi/M+qG6tUJlYCvHACbrIfvQKtls9tCATNHPDuB9PBY1
         IyAPNhSJL1Bq9iwkQZU/fSKj4fkwW32b1gi6QMk3fz0AZXs/HOVGGLC1h0UwfW1adQCK
         gwwyZLoy+3URWJLF33nNG5hyObAZnjvcVD4y1Riiuh5GWBeKER952d+2z20E10Vt2eiC
         LnEPLV+U41as3t/7cMj6bC1BFrSfWmv73IfaE6ItQLrvnBnJ8DZxH3cOemPqe5bakR/K
         aX5g==
X-Forwarded-Encrypted: i=1; AFNElJ/3oOi4dymz23AiWxhYtSVcfYKAebNBl5PxQwd+89TyfwQ9Iwk6BHfo4fabVzAwhJpbTXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaEfUiRnMn0LhLfgOYGpiRlJuDyma3DkuF7wtWh8chopp4l7XS
	9s3FufCQdYQCWdLzArtoTJw3mAhajIDdLhnofcutzaDWhnrNxBwtCiJv
X-Gm-Gg: Acq92OEK/9Sq0jpJbVsZ3enEOca/uX/Erhd4uqhR250Ob/HncsQC9cq/AC1fISI/CMS
	PznIzMOWWfXpEXA+RRFENNUOYkRFggTSvEY2iupz0vZHBlzegZAx2iQO810jbFrRRGoPEFR51yi
	PSYarH6JA71h/i+X2BaOiEm16bTQb149aU76x0an/Y5z1jbF1okEjyQebXG4N2TYmPOJ4qzyEBO
	M1Q6dWc47X6o8MZ/rJHjnhk+M2I80kfkz9ojtYy9fe/tRgZ3mZMY589Ruzd125McNwrn1jv2QF5
	7bi4wM2GmpfKIpcyfz+tCDMwqcVrvTVBy7q1XBYnEK5uzn/rL+lRFp2bQ8BQ6vsVh5r6wkQPAEb
	xui3ZWA7nPi9p1WxhrNad2rESbcM61rqz88DJvWXPvLNebkFjKZbnl4ySyBMlPkICHUU4Scij6D
	W+MyI19k1MYVu6ygRqwxYDaMzczT6WCCf0D2g0SBlVazVQgo5ELwwbOzSFs5AOXZRVzVL7tr8CM
	mAmx0CevqW556/tIGdQZSBzLQMQVPpBy4BfeJf8Ljs1iT7u4xGAd4MT9dKS8IRrypdqCHmGP+4K
X-Received: by 2002:a05:600c:4e47:b0:490:9bc2:bf8b with SMTP id 5b1f17b1804b1-490c25acd68mr187067275e9.5.1780830395478;
        Sun, 07 Jun 2026 04:06:35 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d37edbsm210341945e9.2.2026.06.07.04.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 04:06:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 07 Jun 2026 13:06:34 +0200
Message-Id: <DJ2ROT6HWPCR.3EJLG83YWTZN6@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>,
 "Jiri Olsa" <jolsa@kernel.org>, "Juntong Deng" <juntong.deng@outlook.com>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf v3] bpf: fix NULL pointer dereference in
 bpf_task_from_vpid()
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Sechang Lim" <rhkrqnwk98@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260606091941.1803115-1-rhkrqnwk98@gmail.com>
 <DJ2OO6CSLUR6.2AGL1QQ2QSSDR@gmail.com>
 <64l5t5yu77d5xg4jqjjwyqr2k75f2pi2vl7yus4oczgosjrpyx@2ink2pha4wt5>
In-Reply-To: <64l5t5yu77d5xg4jqjjwyqr2k75f2pi2vl7yus4oczgosjrpyx@2ink2pha4wt5>

On Sun Jun 7, 2026 at 12:05 PM CEST, Sechang Lim wrote:
> On Sun, Jun 07, 2026 at 10:44:41AM +0200, Kumar Kartikeya Dwivedi wrote:
>>>  kernel/bpf/helpers.c | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>>> index b5314c9fed3c..226c31ccb5d6 100644
>>> --- a/kernel/bpf/helpers.c
>>> +++ b/kernel/bpf/helpers.c
>>> @@ -2912,7 +2912,14 @@ __bpf_kfunc struct task_struct *bpf_task_from_vp=
id(s32 vpid)
>>>  {
>>>  	struct task_struct *p;
>>>
>>> +	if (in_interrupt())
>>> +		return NULL;
>>> +
>>
>>This seems too broad, I would just drop this hunk. It seems unrelated to =
the fix.
>>IIUC we only need the bit below to prevent the original NULL deref.
>>
>>pw-bot: cr
>>
>>>  	rcu_read_lock();
>>> +	if (!task_active_pid_ns(current)) {
>>> +		rcu_read_unlock();
>>> +		return NULL;
>>> +	}
>>>  	p =3D find_task_by_vpid(vpid);
>>>  	if (p)
>>>  		p =3D bpf_task_acquire(p);
>>
>
> Right, the NULL check alone fixes the crash. The async-context guard was
> added on Yonghong's v1 request: in softirq current is unrelated to the
> packet, so the looked-up task is meaning less even without the crash.
>
> Drop it entirely, or keep that intent with a narrower predicate?
> in_interrupt() is also true under spin_lock_bh(), so !in_task() would be
> more precise.

Drop it. I think there are contexts where tracing programs use it, may run =
with
interrupts disabled, but current still remains meaningful.
