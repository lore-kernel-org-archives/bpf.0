Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF2C22576E
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 19:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774467375; cv=none; b=MATkJi1I2zL54xSA8y3rPrQ8U3l4H7ng4MD5o5nGzLkTPGad9xtXcd5Vd4QJRe+aXodcI5N/0bDRDnLogvdMmUnOJGapWlQFizpmQukz1t1WG9F071mQCZ1hRKn56O/LWJJv19UxAauS7khF5KYQOPjughkBCqwVAfS/xIz+aQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774467375; c=relaxed/simple;
	bh=t3vdFCTCCd/mYTmRbH029kf+rM34+Lq6Cw+Vdj1lzxI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YbAWsMwRAH9WEY+U9cPtOEIkH75tzSbh/mDG7W7j0Ef2n1gaJkpXUicDW4QVdqzXDgW1rF8epXksgNp/35ZOr00NjGRIqaFBzRl5xT+uLj05s9SrO3b70upFOU82K7SERFFPGP2ZOvNCpQy0jzEM0MPUf6AD09+D39BZCIfuL4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFUJQFLM; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFUJQFLM"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439d8dc4ae4so148473f8f.2
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 12:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774467372; x=1775072172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xbLSrdYpjpwOAwc60D31b27IF6Zr0PDhPWePECVS50=;
        b=jFUJQFLMQf3rtZYSyRGu1wRWWlFbMCsKPFtf6gFH+dqAxRQ9ywiUmSJcyT8najtaRM
         68A+mpPZauHCLvMUXvZJiqU/MRdqDWwexT/6EtNJ2Q9EQpdPLqFq/LDwxEpCz8k3pbCc
         a5bj/RIsth1DFrirmLypIdsNXBf1DE7faOoA9U/u7ii46ERZYhYg/DC45p9j5zxgYsUD
         GOKjKoRvF8xgNRS6vD0TYWigpjZPaJf/BOJPyxfee4AaagYSHPVw0VgotUsa2bhEv1Wp
         S2LKU9qR9jnEEGeGOWiLaaxMi/dpIHD6Yw8Br23Y01sRLnX21CElWkgyaa70jHC6URnF
         UXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774467372; x=1775072172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0xbLSrdYpjpwOAwc60D31b27IF6Zr0PDhPWePECVS50=;
        b=N54m9E0p/V3A3KugiivBxg8WEQr3/Iea5nBwqgbo10PP6kBWC1rbt7i7V34Dl36Ia9
         soaCCCCXrt0H9uxMTmflIK6Ohah41Sxn9HAcLSXzjn7E1FvnWEhgcIi97ETHCf/JZ7YI
         xtDAGJ6K1okce/3Pg2D+OBGDKienwNC2ooOUzQTFhalFrRmD/Vnu5pSXS06RowkrS2iR
         BBvNpV0zV8/aQIYKeMlKLWcGG7lciA8vPS3B/L30Ncju2oedvyVQDEg927UXHtwYdPiG
         jyAG1n9uvGILPu99uXqa3iBTzxNPuO7bzC6W3oxmLxL/+04lVqbL8SFH6ZPZZ+gsIv50
         OwUA==
X-Forwarded-Encrypted: i=1; AJvYcCXUi8YwRAob7g6kF8JVeO8k2wG5eF3Bt/AUNlHpA5VZ+peF1P3pUrXea/VRkKSdMMVauAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtL3JxW6SOgGkl2s6ayYZdLCkVmM0G/aVG+j1ZsbVkN1B1PbFA
	vxGisM+mugutXsKMWnGSNZjWyAr0IuT4MVXVjxLS2GV1lf1e0xSIIDHZ
X-Gm-Gg: ATEYQzwDvjW3rx0fJFgjvtQeT/otbxpMljM+rHhBW9scIx+LvNV+AQ2MBCqoTGU5lTQ
	OmcjEvb473e0Spm5ElsMeh2Ajw5wzK1SbwalcG8O5r20ZmpTkcKSrqJYw/xIeDUh9IZCIdDQ8FV
	FXjYpp6hcjJEaMm/TMdwi/bu+Mn0LXRBSh1egQYjgNCp4CSLo3WQPwb47W8deQidXrHrk1GBkgS
	jG09T07Lo6bClHTjT0sxeSYZETkFCQYF/tYoIQWB8GdMqIbyJns4WBBAFDFjizOzFDzr3Nquem1
	gHfeFjn5S4m3U+ZqMQsORE11uh1lOvwlSVnpIwuOVE5CvcJVVoNWtjkEo1F2NLNZ2Y4WJNA4AfP
	5dIWSFzIgc1trYP1XJIt5+85z97sKuMB82UvBcnMJP6TfGCvB5UZZBih4wstODr6S7h77eNcuhQ
	/XUyweXQp+OeH4P5gpAZVbjMxSG2Hs7Ud3KheCzO2k3lEtaKEruEFaFZANjxnwBnVKiiQ26pvTB
	Mg=
X-Received: by 2002:a5d:5f47:0:b0:43b:8823:c12b with SMTP id ffacd0b85a97d-43b887e6cb0mr7083427f8f.0.1774467371899;
        Wed, 25 Mar 2026 12:36:11 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919dfb54sm2097287f8f.31.2026.03.25.12.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 12:36:11 -0700 (PDT)
Date: Wed, 25 Mar 2026 19:36:08 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, bpf@vger.kernel.org, arnd@arndb.de,
 will@kernel.org, peterz@infradead.org, mark.rutland@arm.com,
 harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
 daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
 xueshuai@linux.alibaba.com, rdunlap@infradead.org,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 konrad.wilk@oracle.com
Subject: Re: [PATCH v10 00/12] barrier: Add
 smp_cond_load_{relaxed,acquire}_timeout()
Message-ID: <20260325193608.10e9eca5@pumpkin>
In-Reply-To: <acQFaVR_bGZU2JmJ@arm.com>
References: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
	<20260315184925.b6f93386e918ca79614843e3@linux-foundation.org>
	<874imftol4.fsf@oracle.com>
	<20260316233712.7cbfac27@pumpkin>
	<acQFaVR_bGZU2JmJ@arm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Mar 2026 15:55:21 +0000
Catalin Marinas <catalin.marinas@arm.com> wrote:

> On Mon, Mar 16, 2026 at 11:37:12PM +0000, David Laight wrote:
...
> > For osq_lock(), while an IPI will wake it up, there is also a small timing
> > window where the IPI can happen before the ldx and so not actually wake up it.
> > This is true whenever 'expr' is non-trivial.  
> 
> Hmm, I thought this is fine because of the implicit SEVL on exception
> return but the arm64 __cmpwait_relaxed() does a SEVL+WFE which clears
> any prior event, it can wait in theory forever when the event stream is
> disabled.

Not forever, there will be a timer interrupt in the end.

> Expanding smp_cond_load_relaxed() into asm, we have something like:
> 
> 	LDR	X0, [PTR]
> 	condition check for VAL || need_resched() with branch out
> 	SEVL
> 	WFE
> 	LDXR	X1, [PTR]
> 	EOR	X1, X1, X0
> 	CBNZ	out
> 	WFE
>   out:
> 
> If the condition is updated to become true (need_resched()) after the
> condition check but before the first WFE while *PTR remains unchanged,
> the IPI won't do anything. Maybe we should revert 1cfc63b5ae60 ("arm64:
> cmpwait: Clear event register before arming exclusive monitor"). Not
> great but probably better than reverting f5bfdc8e3947 ("locking/osq: Use
> optimized spinning loop for arm64")).

Could you change the order to:
	LDR	X0, [PTR]
	SEVL
	WFE
	condition check for VAL || need_resched() with branch out
	LDXR	X1, [PTR]
	EOR	X1, X1, X0
	CBNZ	out
	WFE
  out:

that closes the timing window for the interrupt provided the condition
check doesn't change the event register.

I must get back to the osq_lock code again.
I'm happy with the code - the per-cpu data is down to two cpu numbers.
(Apart from the acquire/release semantics in a few places.)
But the comments have got out of hand.
Writing succinct and accurate comments is hard - too verbose and they
hide too much code.

	David
