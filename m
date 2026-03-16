Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A9F34B434
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 23:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773704238; cv=none; b=cLfXkNQr/k1WyK+77KjGtFzq9KdCFtZhj3CSd7lluVMUGVJZvHEQ1W7OsLdy9iOnd9qaPxzM3W4AY6t2BXe/vdG9JWzR0C1hZergnPZED6Hq8WkN3VpfzIASBNS/7JG5SCcp4dX5f+0RBmbGTU/5+mdmmqMreD1t0WiYDa2g+UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773704238; c=relaxed/simple;
	bh=2DmUkIQk68nUHosP/saZetuyTBWym4GTB8xne8YydJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tKH+N3Xa7nsn2gt81mMXo//WjNf/ZIDKqFKnxnEMk9ojdFZ2Lmb/otR6mdOC2nPXLMvDNy0Lv+cBvV9iE8bHTBpJuu7j9VhaAMlUPz6RN2RdJRWDh3swdlC4cSeh5x1GbqVxkNm8uuBFqZOhLLwjlTfgXMbBnbl0RW/g801TFAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPC5WxpA; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPC5WxpA"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-485345e1013so1322315e9.1
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 16:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773704235; x=1774309035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FrJSvnP5t2ZAkb3zCRgf6mgahxyGJGt35l4bNQI7QjY=;
        b=QPC5WxpABMCAeZi6z60g8BZHDoFHTdbDEMC5sJa1WQXmjRCtM7qyq1BN3aLbPQrknC
         l1JpxGID+JiHi0+D8Eo3kaW7kskN56iB3hw4sSVwcb21I5MJm4pm32zKJs15qqp4L21u
         nnQfljhQ27BTYWgKwQE2nxFLv61CZ3mkm/+5jIXnrPhihFBG6xfnJYijzGDNfY2RsQ5/
         oA/ud4M333RvrCvS/BprY4etcc4XsZdKYFfI+xkKrzwq9Dw+nH9TtyokxzNwlIXPMItP
         9fQXC7jZtjHgpskaUBFTZqqxDBQX76FAbyL7lE/nbtlKrRbnKhkg3Vve9tI8fS8qhoCq
         nQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773704235; x=1774309035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FrJSvnP5t2ZAkb3zCRgf6mgahxyGJGt35l4bNQI7QjY=;
        b=ottJ4RSZ8U0d631TXqADnJG0aQySr905/6639lWstag8Di6OlKkE7DBfW1E6TSt8G3
         rIF3iaqzMVrshQF4c/ZyHsjkjCspCADF7sU3XRLQa6C0xnd9bZ9GzwzytzfAXdtxm7xO
         LjpQMO3eK1/oKNZJju5R5/jXYSgjnYu3ZlHsGc9mttCcFGsQSrcKs47BEU20mpGpbt3T
         jbfRygnL5n93l6gy11S/ALb1RlD61oBEu2az4Uqs8HwleMAc0pddMB2LHzrzwz3L5bev
         t3pTLvSShuh4sz8iV3bCJK/29DTN3V4x1sP2tvpMCKsaptxObkaFXcX+sJkcKwhKax7K
         xuxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJvX0uBMIqsynWnLF9Mb/A+kNyS/r0rxF/Cu0NP3UOK1GbPOIj5SUhc6QbSLrFlR3iNPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyscJkdda3F+GDbjpHo5UXRq+2Gpf3ZtHoMWPYdtHTOLs++BF5
	Utg59cp79L7VHdfPlp7lAx4SeIe1hkNx+22LILJFCKaKdkamxC5rB622
X-Gm-Gg: ATEYQzx0xV4vRfHupBQzOAootOJRZ0NQ14bVLMiN2jdzkJocqHB8+PvIbUNFWv4rOnw
	JLycP7xCD9jwXOB5kLe3OX6GlvsRvbiB5/ea7XUd3a6Yn+nANJAFln7klUVjeXlZCCqptvv3OoX
	L1ay0TYnAaZaYROqAY0wqxPJHNlEu0Rgkhm0lttAHYLWHwTRgzd2GOSPcinl0yV4840/F9N2fK3
	5CzuegKcVTGhU65zh9gIQ+QnoajheydqGii53IpM6Kc9ccuU9M50y+XWd4SCYotWmtNBWqROvwB
	n2uUmUYpoir0vHHtYH+uBlzN0MERgbEp9hrcf6on4cY0xBsUDJpXsV9TlWulV4eJOooqgvH403c
	HrivnCzgULrbffZMgDs0RnsvGLdRActBvl/U53XQ1K3EHX12O+TxF2nKR5VetDCO1rXH3L0VREv
	XQRkUnQ4a/IurS5Qa6Blt2Y0aW0GQejjjFGLdtTMzetuKWP4R/U8pqE4dS12zIVX3YGONuvqbhM
	sY=
X-Received: by 2002:a05:600c:17ca:b0:485:343b:38d with SMTP id 5b1f17b1804b1-4856eaac647mr13270265e9.5.1773704234827;
        Mon, 16 Mar 2026 16:37:14 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b42e680ddsm14706435f8f.13.2026.03.16.16.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 16:37:14 -0700 (PDT)
Date: Mon, 16 Mar 2026 23:37:12 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, bpf@vger.kernel.org, arnd@arndb.de,
 catalin.marinas@arm.com, will@kernel.org, peterz@infradead.org,
 mark.rutland@arm.com, harisokn@amazon.com, cl@gentwo.org, ast@kernel.org,
 rafael@kernel.org, daniel.lezcano@linaro.org, memxor@gmail.com,
 zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com, rdunlap@infradead.org,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 konrad.wilk@oracle.com
Subject: Re: [PATCH v10 00/12] barrier: Add
 smp_cond_load_{relaxed,acquire}_timeout()
Message-ID: <20260316233712.7cbfac27@pumpkin>
In-Reply-To: <874imftol4.fsf@oracle.com>
References: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
	<20260315184925.b6f93386e918ca79614843e3@linux-foundation.org>
	<874imftol4.fsf@oracle.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 15:08:07 -0700
Ankur Arora <ankur.a.arora@oracle.com> wrote:

...
> However, as David Laight pointed out in this thread
> (https://lore.kernel.org/lkml/20260214113122.70627a8b@pumpkin/)
> that this would be fine so long as the polling is on memory, but would
> need some work to handle MMIO.

I'm not sure the current code works with MMIO on arm64.
I was looking at the osq_lock() code, it uses smp_cond_load() with 'expr'
being 'VAL || need_resched()' expecting to get woken by the IPI associated
with the preemption being requested.
But the arm64 code relies on 'wfe' being woken when the memory write
'breaks' the 'ldx' for the monitored location.
That will only work for cached addresses.

For osq_lock(), while an IPI will wake it up, there is also a small timing
window where the IPI can happen before the ldx and so not actually wake up it.
This is true whenever 'expr' is non-trivial.
On arm64 I think you could use explicit sev and wfe - but that will wake all
'sleeping' cpu; and you may not want the 'thundering herd'.

	David
