Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A775448BA9
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 13:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785850952; cv=none; b=EZ8doxXLaEx3we7eUntY3hy6XUm098gVhU5zPp5kxgCRODR0h1z4UCxnW8AG5FEP8kFo5S3Dq/ppM8t01VfC3Wg+iRMAwZCpZEwvNLeJj44WjSb7mMe5wd6Le4cfwWgWjoisS1n8bV+xQcpZd19cU0LS4JRkYqM2Z7I3vMl0BEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785850952; c=relaxed/simple;
	bh=6BqqmJ+CkjzQyLJ9nl1mxgsYp2XZlncwLWU2u6v8GGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J3/L89n0lUhKGnC3WpdX05qABHxkmpfk7RAMiVpXK8PhZ54kqz+Sm33o9wmMryXgmD+nGaqKOOZ8ruo+EkcqK+gIKZpf0k0B+IDntilpkbcfWBlWhskkBh6Bd/rpIznzZFPYHW1vnNDH2qBfNuWRT+1I76j7QJF/R+Grj6/gYsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=HVNDJ2sl; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="HVNDJ2sl"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8485b358552so4713891b3a.2
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 06:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1785850950; x=1786455750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6BqqmJ+CkjzQyLJ9nl1mxgsYp2XZlncwLWU2u6v8GGk=;
        b=HVNDJ2slChBLAnAtHJWsuM0GqQ+U+3j5u8Cc8lkAul0O+w064O3addkYOLXF8JgZA5
         JVvXgnopt/Ar23f/ERGQYebRecvOLu1bnMh/KasRc4bAUdtPyEymba/0tQk3od0O1/n1
         seakULTsJyWKgcz8t2Th3LZwg9ADI7IyEVMSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785850950; x=1786455750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6BqqmJ+CkjzQyLJ9nl1mxgsYp2XZlncwLWU2u6v8GGk=;
        b=HvFldPeRfmvTuhr5kYnqjB2gxwS2Zw6HQ5hf3F/O8UmDrp1TJWR4GiH3DWYcD9ulYL
         bT0cvfjn4nXdrk9JgP0VDl+LuoLcoT69Lz2lP7Acv9IRx9uBmw+hh+WmJ+7MI1Yrt2Uc
         g69qZjM4N3+MRQHqzkWEaGGKMbUzunQSPKe2DRMadsFDYoifbx4X2tEmyx5/WPmdrH10
         EKSPK9F7nswaOmzTtETzzSGPM4U8VxU7F9+yfKws0gw0J+uGctSXgPUCU8kNx/NPPuYG
         yGeqBAPzhysyu9Vr75gdYV8CTEPAtSC8b7EPHDZIe7QkKHeDh0sEDZ6Z8jn1ZGgcuvUr
         rkbw==
X-Forwarded-Encrypted: i=1; AHgh+RpoiY/hzrwJafdNcLDFdbidICgI3XPg6dbcc0iuH44hYyZBV0BSJDMEXBnZJ3SYMIuxsWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJQXak/nVh2IN16oKqaEBBrLwiHW2mbDim9yPMZlmk4xV/WlYX
	TJ06UF4EPvRImcprUB8ombJGHyvJPSM+6TAKM5eJKPBDu+MUrBZwm4Ee8UI42Hr53dQ=
X-Gm-Gg: AR+sD13u566VBZi35QYiQ5Oi47Wm0bX0l4GPsrYnYpVN0qfeSuvp9OIzz4fi6PQ1BwQ
	cHFthVwv0pKboEZdSH6DXCWSgOnhXIJsVL75U2whnOK6KHGaf4zBknDLj964sZM73qc3hG9UQJN
	QL+ytcBY0dmtg2wRusJayrxK5HWUpESBw010kHH1IcBcfBQjXD8F9A9ar6rdFiBLObtRbXVAgab
	0uOtxJ+AtGtG6PXUcMy1Ol1a1QCGU92kcTckAX6Y7MEQKMXim0tdXAJmsJMoE/RrVAfOfJvr9Ml
	OprsPi+8M1BFY90UHSRUzfEoaT/6HaO1S0Mq5wq6Q/ZNlJL+uqs22IcGhwWR44EfItpw9Je00wG
	iQQvYD2+vDzlYYapeiZYQFdSXWt4YkVHVtYLZ7VOWeaSOxD8RBqfYY7jSlI+rTmG9wlV9L+B7vI
	MnHEYC2iXxmYyYlpRyeHusvmXQcphGUcBpy8wMPCJ50lmMyuvHkog=
X-Received: by 2002:a05:6a00:12c9:b0:848:67ca:c03 with SMTP id d2e1a72fcca58-84ee4915d1fmr13645029b3a.58.1785850950265;
        Tue, 04 Aug 2026 06:42:30 -0700 (PDT)
Received: from shiro ([2400:4162:2428:2ffe:e3e3:8255:fe3e:c7f5])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-84edc29e6f0sm5258690b3a.39.2026.08.04.06.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 06:42:29 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: jkoolstra@xs4all.nl
Cc: ast@kernel.org,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	corbet@lwn.net,
	daniel@iogearbox.net,
	farid.m.zakaria@gmail.com,
	jack@suse.cz,
	jannh@google.com,
	kees@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	mail@johnericson.me,
	stable@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] binfmt_elf_fdpic: only honour the first PT_INTERP
Date: Tue,  4 Aug 2026 22:42:25 +0900
Message-ID: <20260804134225.3631912-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <al_MqBrjDW1QjRau@daedalus>
References: <al_MqBrjDW1QjRau@daedalus>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Sorry if I messed this up. First time replying via git.

>Afaict, currently read_code() may blow past what vm_mmap() allocated
>there, which may result in memory corruption for a non MMU system.

I ran Fable on all of the "nommu files" and it found the issue this
commit fixes and the above issue,
I sent a patch (co-written with fable) and we proved this is an actual
issue on nommu via a reproducer tested on a real system.

https://lore.kernel.org/all/20260710121443.1059549-1-daniel@thingy.jp/

Thanks,

Daniel
