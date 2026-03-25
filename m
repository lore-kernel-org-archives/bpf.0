Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6772F1EA7DF
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 20:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774470243; cv=none; b=pczKKKsoASXHA7CPKSfBufw/ifM51vwWmhq+zx/EJyjzwEw/UGu7Yv3Wc1SqeEkP4J9tR7tqN708XiOd+21enNecbSIy5910D2i1q0B/bcZGUFzzLsm+k9Sr74py7MBZNACa9eceYR8mPLZUvQEcJsWJnDvoD0Ow0Sbf/UGis+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774470243; c=relaxed/simple;
	bh=yLQmvGZ9qUpeV/RlqPnpEBWWJVhN3ND5IbWmVgrZ9hc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q50B+9Jg8KUDjwPo9oaoWT2FPE9RrHssAsuO0E4ZuLzVa+M70pX8FtOJmtj+6nSE4wv3Viayo4VbSh8mT6H+qY1ou9RwNcfIJ/WHioRecoGBBoyVr0+KiyVk2zyOBRgtCIzvpt0Bl6gcIFy19ZIq60kzerRCnHmaXZQDy/R6K3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ud6j+46n; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ud6j+46n"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso2329325e9.1
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 13:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774470240; x=1775075040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXPaSk6rOeSHzsuBeOwJ4iqoWQAtJOAov6388j1L0Ko=;
        b=Ud6j+46n3VJTG/W17THyEbW2e7ncYy5oZMQV/zIS4NWA6K41fRt8pGOa0mZHDls0Ho
         tAnoqx818c1OPDdszo6POX6hDOYA5MArxKOD2ks9ohbhzsbtLhMB5E0f48+qcmtHQXdB
         cc5+wW5wrEN449Uvk6PsvIiXxs65BeCk8dbppKk6rhVegLfzFq2mWRvqCt5WfZhDis6z
         YYIJMMc4+ONjPnmSe+46jOZZsxQDb42mcXES6s7IRWpwHayST7GJxYc2Iat7rCJmgwoh
         wdrKmBfOo3Zvu8butllgBCGlzd7zAlmaEKqr+RaBLjpIuaVI+C/Acsezbh155UecLcaG
         gqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774470240; x=1775075040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gXPaSk6rOeSHzsuBeOwJ4iqoWQAtJOAov6388j1L0Ko=;
        b=HYqHBkUnQG/V0OS8AASNbzm1+CBbyIlRqOcezqjEOv4iZxaz9lFXaEqtvIOxXjxTVE
         xR94d1PqYOXlr5yeJ7tmwJnHHqp0EHt2n5YK+UWqWXeezHGbTXRDfZJYANWrAB3aNkJp
         gfUrYQI2DYqS/bwsdHNzLZ/1KiC9ffDzJ2DZbBRtUFnwUK6spqQaqsSWYsi5VgVHyW09
         ar2nwgGRn5MkCHrwRgXcUzNNuUFX9ZfjXaqY5osni6f9DAkI+fmGfpLkKovu3MKGTmLW
         6aO0kzqqIJuVhXEdM2349OHOHeH6YnCajtwhLnRqff5+cV397cVtQ5AkXefkL8H7e/zN
         RD4w==
X-Forwarded-Encrypted: i=1; AJvYcCU10HLqzN0ki+I7kUMoI8DjoOGK5m1PgGbwjBZ8Yil5XKgYYXZ/m4/vDwJ8IMrl9zWkwIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAyeG7ZyLzKNGQ8dTjiF8CmxljFwKRWR8zHPK0DBHyp64z0ZJY
	xFrmIEutZLINwwoWIaPBjL92zKQxfJ9GACXwoa5ywsb+PFS5fJSMNF8D
X-Gm-Gg: ATEYQzzbe7t4mH6VchF4N5leHafTnjGCEIuZ+WSdEVyTjem6iYgVz1CQxWL+6r1uBK5
	Bsl69U7YUAz4lIFtmUnAuSqEzzh0y3ctwojdzDtXdLyXeAjS7SYuzpnqb1aLlonGsVelUrL+7Y0
	Wa+9z76lHbedZk1Xca/YbxO9/h9TZejwcYluVKlFCjcfQKqsTuVgnyJJ19G5QkzUHHXWopiw3OB
	31oX9ynCs4hS4nm72Q5MiMRJJP22QdtgVK1Ss7U88/cc8H/FsOiVZvy1aqcHe6OSGm6g4M6ntoS
	2lb7C7YPju1w2vDdWbj122xq6V25F9paVrTqpyMc1ux+yGG6kYZ7shdoVJ0GIcgqcglB3q/32Mb
	CUf1y+FtQh7hRliagsuZ6KHmljHLGg6yp2BeOZ0QdLgeR21UE3oNPZC7J68cvxR438OXt2uYyKC
	iPmMTJgKnO3rM8B+FeF4GgVFHrsHUSUspJ2+sPlHfvqnzNM8GM6dFKplgi673VK1qX
X-Received: by 2002:a05:600c:4685:b0:47d:8479:78d5 with SMTP id 5b1f17b1804b1-48715fc38e8mr75859145e9.7.1774470239711;
        Wed, 25 Mar 2026 13:23:59 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871fbca47dsm2239685e9.1.2026.03.25.13.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 13:23:59 -0700 (PDT)
Date: Wed, 25 Mar 2026 20:23:57 +0000
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
Message-ID: <20260325202357.3e203314@pumpkin>
In-Reply-To: <acQOMZMk0OMfIgFO@arm.com>
References: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
	<20260315184925.b6f93386e918ca79614843e3@linux-foundation.org>
	<874imftol4.fsf@oracle.com>
	<20260316233712.7cbfac27@pumpkin>
	<87ms07rlp9.fsf@oracle.com>
	<20260317091705.5a64fc56@pumpkin>
	<acPo7l_pd5rnHpSX@arm.com>
	<20260325154210.79a621df@pumpkin>
	<acQOMZMk0OMfIgFO@arm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Mar 2026 16:32:49 +0000
Catalin Marinas <catalin.marinas@arm.com> wrote:

> On Wed, Mar 25, 2026 at 03:42:10PM +0000, David Laight wrote:
...
> > Looking at the code I think the "sevl; wfe" pair should be higher up.  
> 
> Yes, I replied to your other message. We could move it higher indeed,
> before the condition check, but I can't get my head around the ordering.
> Can need_resched() check be speculated before the WFE? I need to think
> some more.

I don't think speculation can matter.
Both SEVL and WFE must be serialised against any other instructions
that can change the event flag (as well as each other) otherwise
everything is broken.
Apart from that it doesn't matter, what matters is the instruction
boundary the interrupt happens at.

Actually both SEVL and WFE may be synchronising instructions and very slow.
So you may not want to put them in the fast path where the condition
is true on entry (or even true after a retry).
So the code might have to look like:
	for (;;) {
		VAL = mem;
		if (cond(VAL)) return;
		SEVL; WFE;
		if (cond(VAL)) return;
		v1 = LDX(mem);
		if (v1 == VAL)
			WFE;
	}

Definitely needs a comment that both 'return from exception' and
losing the exclusive access set the event flag.

The asm probably ought to have a full "memory" clobber.
Just in case the compiler gets lively with re-ordering.

	David
