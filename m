Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7B3415F13
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 21:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786052804; cv=none; b=AX8hFwXsJ6SOSV9iYCk65BJhT1ZQiZA77bDtvW7jNRtnmW0Ah6B8M+8ilSKZFVpUAm49Q00sjkWbaoyC2v4PxpIEE4IvySyfJE2AgI2DoD6KarVtgbe39cjBux01KH+AoU/QcqW//h48f2OXixfOzgIMgf07xq+mZuJ7a35dk5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786052804; c=relaxed/simple;
	bh=T0hD2DXJ/q3FwPikHjI4gkljbtqDDJPlUsmgogm6D/U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=RTrX+VN23jMDQnP+mMcjTJVx1Pku0dSfUiYRshl59ntAUasSM1zngkR4PIuqqu0lHRDyI2QjS/k+6QacYWpY5wgzxBPquvNF6KF42QCta8A5Lf3jOWFhp6xmzwh9CCsYxk3D2KKK80Jo1u9dZGWEAHukV/czEtBl14b4nxe6Smc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c16MvOKW; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c16MvOKW"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-472365266f5so986348f8f.1
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 14:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786052800; x=1786657600; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sc5+0+P+kBPOJJ2JZITgu16eEoXiCOQvb0agpV+FkBM=;
        b=c16MvOKWZED4dLGuS+OzHxfmJZGe5AJeCQOSpazFks6idP1hUstJktRKRGXMVkNJXN
         yCfNO3a6yZW3a8rYkFFx60fCy7HxqSGSniFBznmdjlrA7v/fczWkOAT9ZqjljjxjeV7Y
         6M2rhCtRjhSz7CgLWxvpk7aOH2879CfXeDN1exB9SNigZKaLRHAZ/V9/ObwFsp3iCflq
         u0RbX4IJm2oM8fcWwERwE0AJYqJBKxjJiDxAzJB+KQuHRvjqqpLzPBkDLeihFFWr1mvI
         4/8aph53WMwyBGgu8MUnNvjexn2+8aSlQP+pa4TApJdUIeRzsHIqYRRJMTUJ6ZIpdU7w
         Kn7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786052800; x=1786657600;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sc5+0+P+kBPOJJ2JZITgu16eEoXiCOQvb0agpV+FkBM=;
        b=GbauhyxMBkmrpvntEwbH7t6wgvEkI0kUj09WeIWIo/ISTRuks7eoQJ3bwqY+FLD/0G
         EQiSwjra35yT2r/mrusAo3C2EB+7OuI7mt2oJR7+oNKfUuWLXGRYXIab/zJslcoM9Jfv
         O3S0Rh/9ZqKe5xIbgy3fKVtpiaL5z/sE/RnSyGBt6Db5LL4ioESHAwhDe385ns7DPAyI
         rSnkha52O6BqUZEUv5K5rbUGRF0ibl6q+T8Mt8wONWDteGy12Is/vRuC8fqtXhSbEQgw
         GvPRSozvyWDFDUGi/nyEZ+GuIF7Is1EhohIeEBMSEnk+GghEpLUA0SGDzjWTXWmJFGn5
         rsdA==
X-Forwarded-Encrypted: i=1; AHgh+Rr1NG0dLRSlRkOYMHOgw/wiYSP1s8mbSfWMrA6u4U2I4SOYrmQu1+I5PC9cm3ADLpnBf2c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo3+/WTagr7Hdi71S5D2nanwvuoDiPjRcXSOe0sLAdg30Cdovh
	4XRj+bkPXvB1MHND87hOZws2EwQejzK7IiLYrNwiMBWHwhVi8NnKJVi1
X-Gm-Gg: AR+sD13cwwoyYXsNozVYiGEWz+AF9KEpFdRMWfDFJ4xhPSiZklK77creOENt1dbg0ZD
	wfP5GGZW2XDspJ+PlY5s33EN/cjRfQG10KmOnP+f0UzB1VTvkJjqcjoxZo2n/EKKbWyUMVePT62
	lK1jPd/5jVr+MMzAAhRUeyUcvjUNuPpX9nsJpyQKm3skZ1AXQfdXPqSBvjSDp8RC42xGfy81I8j
	lnAarQEbANXWe6k80M1OXJ51/UoRmNTitILbk7AsujC/+CkfkVP6Jg8Wf192DZvWV6dQQg42S2L
	bPtk61BmbGP7P1gdJ+CaAtcFK0PNuLTmeZYy78IwN0FqiLj7THmjtHZxr3WCa5vsVIWpFvS9A7h
	6IqNc6nWzVyUPJP5+qGFrbMEyjBcpmFIHkwHsRwDjqABdSXX1MjpSZa2AX+VsXubPAUdEVOWyGc
	pHRpNH6mDuRNXy8h37MRVqHNGlXCLvd4ZUPCEgrlP9p/WOCPcjzxamsr+pdzsFdk6nr9D0G05F0
	vKeNE1xuhm1sR6HeJp5tu8NbmSCcFPas1lk7MfLKiHIBByCIqrdjNT1MwLbvuLWq9ihbW8hlr72
	EgWTvXkmRmR62Ip8koH8bEoNBWk=
X-Received: by 2002:a05:6000:29cc:b0:474:5a38:f650 with SMTP id ffacd0b85a97d-47fec502189mr21244855f8f.3.1786052800301;
        Thu, 06 Aug 2026 14:46:40 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff79a7258sm8863915f8f.3.2026.08.06.14.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 14:46:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Aug 2026 23:46:39 +0200
Message-Id: <DKI6VKZN6IQ6.3473IFAEODGGT@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Fix sleepable context checks and
 remove in_sleepable helper
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, <kkd@meta.com>, <kernel-team@meta.com>
X-Mailer: aerc 0.21.0
References: <20260806164049.3158887-1-memxor@gmail.com>
 <20260806164049.3158887-2-memxor@gmail.com>
 <8818323417f335355e02d7e10d220ef2ff370c0e.camel@gmail.com>
 <DKI6BEY44SYI.1SASQ9TSOCCG9@gmail.com>
In-Reply-To: <DKI6BEY44SYI.1SASQ9TSOCCG9@gmail.com>

On Thu Aug 6, 2026 at 11:20 PM CEST, Kumar Kartikeya Dwivedi wrote:
> On Thu Aug 6, 2026 at 11:10 PM CEST, Eduard Zingerman wrote:
>> On Thu, 2026-08-06 at 18:40 +0200, Kumar Kartikeya Dwivedi wrote:
>>
>> ...
>>
>>> Several call sites incorrectly used in_sleepable() where
>>> in_sleepable_context() is required. This allowed sleepable programs
>>> in non-sleepable contexts (e.g., inside bpf_rcu_read_lock()) to
>>> incorrectly use sleepable iterators and kfuncs:
>>>
>>> =C2=A0 - check_css_task_iter_allowlist() returned in_sleepable() and
>>> =C2=A0=C2=A0=C2=A0 therefore allowed css_task iterator in any sleepable=
 program,
>>> =C2=A0=C2=A0=C2=A0 even inside RCU/preempt/lock/IRQ-disabled regions. F=
ix it to
>>> =C2=A0=C2=A0=C2=A0 use in_sleepable_context().
>>
>> ...
>>
>>> @@ -12083,7 +12078,7 @@ static bool check_css_task_iter_allowlist(struc=
t bpf_verifier_env *env)
>>> =C2=A0			return true;
>>> =C2=A0		fallthrough;
>>> =C2=A0	default:
>>> -		return in_sleepable(env);
>>> +		return in_sleepable_context(env);
>>> =C2=A0	}
>>> =C2=A0}
>>
>> I don't understand this change. The comment on top of the
>> check_css_task_iter_allowlist() says that it is about
>> cgroup.c:css_set_lock, not the current context per se.
>
> I haven't looked deeply into this on whether this should change, that sai=
d the
> usage of in_sleepable() is obviously wrong here, in that it is not enough=
.
>

Ok, I looked at it.

I guess I see what you mean, sleepable programs won't run inside css_set_lo=
ck
critical section, hence it should be ok to not check in_sleepable_context()=
. So
we probably only care about the program being sleepable, and not the contex=
t.

So the current thing should be ok except on PREEMPT_RT, when spin lock on
css_set_lock becomes a rt_mutex. It depends on whether we care enough to ma=
ke it
context dependent on PREEMPT_RT and leave it open otherwise, or just let it=
 be.

I can still move it to a filter outside the verifier though.

> [...]
