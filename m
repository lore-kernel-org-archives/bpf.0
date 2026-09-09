Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A8C29405
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 07:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788938704; cv=none; b=AOL4sOdR0tazzB9LGGZU9LNNzCpzJVc8CwePRg7yB8qQDpvotFqhAkp90F2ClQf2RXJBgOZQ3vfOVPS7sPu9GfcRFN9F6Utg9N+j4K9ejfX1nuNF1p/lvt1SuACLSsL+2pxtUgtA8LEUOPuFkJKfIGdWWGUxSl9EVsIpseKcM7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788938704; c=relaxed/simple;
	bh=6IpihIKg7y7X2cwXfcmqkmOxJCzJb7Ke/fCjIixrgYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oVqIf8/SvxA0G6HiTgrSAVHqjsubt0qXP9eoIV9sVegUBcAtGALzr3jc1EGNPRTuCfXYOorMjJxgf7bImjGKIgtlVykDjSHDzJyHqzv90mWi6Lg3UReiiwzwSaLns/4lItmrtgT+ZT72NHm5OeskEQxrAp4/ovW4wDnA7DqFkzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctdGs+8w; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctdGs+8w"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-484392e3d33so3921867f8f.2
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2026 00:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788938700; x=1789543500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6IpihIKg7y7X2cwXfcmqkmOxJCzJb7Ke/fCjIixrgYE=;
        b=ctdGs+8wEAYbTbCeAp8ELG1CwjP3pXcBGVSoduIKr0ldo2r+KDJZGduZCG/BpoY6pg
         yecUBlmUEataUjdPUK3qzadO6JcJ13qjR8ig80joGcxStO7bEP8WDMXCTDJ4pxP8B0Ti
         TyElTkg2UcV1eKHzLQ8BMPfDqtPfWyvim3+uTNGMDn7Uasiq+9IBKRPHJmJc1bbH3t7Z
         vF9xWYAsNTOroKZSDWiW4cKfAkNBiFHbjIebIuRj7OgoSUWtz3pWHYREm/PzUdsceGJL
         nGWbtmKvMCq6C/6uljQNpUVE/J9xvBrQ3hz/5Z2kKgdyIB1nyUXnnTEO3oASsiSzZRqO
         b51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788938700; x=1789543500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6IpihIKg7y7X2cwXfcmqkmOxJCzJb7Ke/fCjIixrgYE=;
        b=WsBtTKqCNLAt67IeNOxjhPe+HIk++c3VSeJCAoZkSwetJ13UbyUCgFkLgX2qlPujlo
         RVxCvdEYdrK2BzlTeufQOFMn/5IaI39e0YU3Ytos9vGswG7v6Xe6DLrJlWxVyj5oJkt+
         K+aT7l43OoeAVUM9f7Et0RzNgHOu2BI5/g8Jlk/vx9DOnFyB+P7lhiAmffbgihIDlmG6
         bWvs6+DDCDYkjrvGaOhkePkZtuxJOrVfpFw1KqY1ytK3uNERgFCZDrHWUWaFotfYO6Jn
         iIBoSN5jJBLyA+zWk13tO3Kd8j+xOyISdzQHnKAYUXrWVeRJwpNieusxuKRO1bUreOUA
         a3Ug==
X-Forwarded-Encrypted: i=1; AKwUvBzAM/2CyVxO953OmRHpgrsjzLtUkbSruESdDjuGPeoQrS3yCjaPVEc6tx77RXnSzPds4UQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nuXMd0ON0Sr9YBOA8vurgZV4dQOjhmfZBa/0qbQpWt4TIK3dqi
	DlsUjJ6g6KOKYTTW/PLJ4Dzp9ifhLwTrRmuvhm7cJx5LXlA3z9Q7pSqC
X-Gm-Gg: AYBFou1v3+kcOgGfUrZsIWLBKT3yCrKDO/B45WiF/cV2igTZhpW9Eje67NcTqkIg6AY
	XbHyJbZYdJcZyvFwHSxioH+VmvLOK5TmoOJ4JfQVGNnhayiSQktl5YtsPSXp8EH0uOhHYy/hrkM
	/0yrVlXRNFfypaPRUuSwUJb+ewnwRZnINYcBWtlyiFvavEXcNbK8O7+jgjr8rWQE5OsfN9ysALM
	HcYE7QZzYRHWoeXqxjDuJFNXu8o9cLp07TfkW1ksRskTj92KWmwuMWwGnCtqF4iwbxTk9rhPSfe
	i8C+auv/6o9jhvjDLCDTTxh1il/YajDmGXV+7IYpAumaWYCBI6gVvyvWnf+KYbIafDvCCGVEnL+
	YWNKVM3lf3dSxM+Le6jKu4BI/JErkpH66KVziYxFVP6N+eCtmqfAsEGfRSj3NvpWSQlwhJVl8rA
	ttWZNHd5QACXTYhiRiOwsdcxK7G1yPTZPWFmyVRJg1WGSX9iz5q+o6YRQ+zVkPRp4qH1N/wENCG
	qocI0V+6EmH
X-Received: by 2002:a05:6000:4909:b0:485:8c17:9764 with SMTP id ffacd0b85a97d-4858c179966mr30927449f8f.38.1788938700220;
        Wed, 09 Sep 2026 00:25:00 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5f:900:ef25:2f4:1792:4e6f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883acd33sm41527265f8f.18.2026.09.09.00.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 00:24:59 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: akpm@linux-foundation.org,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	daniel@iogearbox.net,
	david@kernel.org,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	kpsingh@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	martin.lau@kernel.org,
	mason@kernel.org,
	matt@bobrowski.net,
	memxor@gmail.com,
	song@kernel.org,
	sun.jian.kdev@gmail.com,
	tasos.papagiannnis@gmail.com,
	utilityemal77@gmail.com,
	viro@zeniv.linux.org.uk,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v6 3/5] bpf: Add user memory access kfuncs for mm_struct
Date: Wed,  9 Sep 2026 10:24:34 +0300
Message-ID: <20260909072434.66868-1-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <4ef240a5bea36ff84df9589671367832860795159386a4c8fba546a0fa8b786f@mail.kernel.org>
References: <4ef240a5bea36ff84df9589671367832860795159386a4c8fba546a0fa8b786f@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Does this drop the address-wrap guard on !CONFIG_MMU builds?

This is fixed in https://lore.kernel.org/bpf/20260909064231.18693-1-tasos.papagiannnis@gmail.com/
