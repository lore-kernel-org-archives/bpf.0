Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAE44AEBE4
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 13:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738101; cv=none; b=Cxfp9uaKfrnK3RxiJ6mBqPFmBt+XqeobHmRlqUYRRrV/LsmHH9wlJdUxrROsZeUtuc5QvfEZ7yMfsto9FfjmcTzy1kYtCMPC+JDrwS5UCzWkAW9Hxp767qHzwNk1JakjMAlFIZMGwA6kO72f14mlWGLJP2FhyW4R9VfRwd9sN/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738101; c=relaxed/simple;
	bh=zIvzoRp4EqaaXbBaAXZ0LdKRD2UHE9DJZN9NC6iw0vU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=du1XHTENfF+e63aB4HOSkN66OZRGEVTz3jvqV5vVMVESx78c0J7fmivlR/ZgkiGqH/nultFZwQ4CVb+oc9jjJgk8/1lm3vQ5Ol53rASKk0/A6Y+mL5HuXgBLtveLAdba4Ni+RGaoB53iqlonBZL40VgES/7I76IvBvAAitH0qy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqJ0oyXR; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqJ0oyXR"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d3920so5303205e9.1
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 06:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789738097; x=1790342897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zIvzoRp4EqaaXbBaAXZ0LdKRD2UHE9DJZN9NC6iw0vU=;
        b=TqJ0oyXRUy20MTaZ+YvOAQUaxjdNILraHK3DTeOufBtn76cKYMi59CdP6W8vdn+Z2V
         XgQT9nteXpQHtFkZ+WckR7lzG/YUIRbGhZSNX0A1UXajBI+is2ojFDhbFB5RjQSyPUHG
         3Uv5cMh9LyTApSYDCIm6F6HxRovmznwzRPkY+FkrwuF7XojJ58FvWTxPsUaZ5gNEo75E
         ZlgSNItm7LCShMHKGfDWTcxE/Ka77bamoERvpg0z6nuOrBcfV441AingHuyNEgfLktLF
         KJrrXZ2+LgqllrspnxH2pU0B2lHmmaM9656UL2qJbJ9jzU+u2SkhODjcXy7WwpoctNZQ
         wmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789738098; x=1790342898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zIvzoRp4EqaaXbBaAXZ0LdKRD2UHE9DJZN9NC6iw0vU=;
        b=NFm3ZeMP+oQlXkuURfuUr23hY4ZvuaypzcrzKQBKZlRoyFAno170sx1RELWj2Tjvi6
         5oOpLAo5sUAAkMAoi+lCFWlmnkSgiksZQ44+/qVC0ysd7J7Rh0t3v3GLmkgBFftlMXe1
         vZCkzn4u6fCXHpmYZ20V1kc4/6qAcnWQlb81sKxYexuBnYCgZqhXnFoGYwlHNPztNdJy
         Hx9DQT2oMg8EEjhHIfwmtLaYGHIKEt++OGvNphbIrsKyiPavwLxGkaeI8pcxxWhqSG/Y
         I6vGGbaXsBu/oyYWD8ai28KyqzJX9F3UjR0cpX5p6MXIbGyWdiwtudHYTsrFXbYaEQxx
         PivA==
X-Forwarded-Encrypted: i=1; AKwUvBxddoJy+IgZjFkGCoTTRnBKM0MQzwU6+9Bfsd9W1Nf3OhE1wPSUKo5Tql1nvJNRsdKWCRA=@vger.kernel.org
X-Gm-Message-State: AFuF++nceJLH4/Dfjb9iexRHA+bdaBOVlKMs8/ogtPSZJ/8B4SZ1ux6l
	1skZfTv1oKgY+me6/qgt0Q7I6f/W0IlL9/zO9GNTF0iUKmephT/l469L
X-Gm-Gg: AYBFou0Ht6DWWko9JLzTml3az/g6Akekm1zNoMDrMFhKPiAi4TawJ9bz5NKcORcb2Kf
	LelOxvjGy3NnlpWGMAFRFjcN0ZMZg5y4231IJyP+o0mJoduBQwDjnPiICQo2lfbl9UxaMDMQAZf
	0leWoLsc1CPNMZuqc5Pz8Xam8E3ZUGYwwU17m2iNHA3Z9hoC2VPFR+yvkkDIIf0AZQDCkvBp0mp
	4AJ+E/4Zt+cONRFHvYRJlPbGnZIfUY/qfNQYvOA2tOjx9zvWIdc3at+3IrJLYn9LnGXNw84hjq6
	pBWYS6yj6rvz6R07bz93qygJUaopeDWxbYPLlAw6+KuilvvlDjC+ySBKMrQh2gNE+6v1VMvid7l
	Ai/TDLkHC2qG+NBbhdmQhmFkT/w/U/U6i8aW0YiLHYgGOwVFNgCJZzU5bzF3lrGMozHEqSqtofx
	Q+859ZfoEEi6TAT99xp/bc9P8HNJ6tYvB1yp8BR9yqJOHQPWrw0hrOKmEX8yTp8SG9MAjmvZLT2
	lio1znHmVhQ7m00lcRv78spbw==
X-Received: by 2002:a05:600c:1f8f:b0:49e:8354:26fb with SMTP id 5b1f17b1804b1-49fc574c729mr35408655e9.32.1789738097326;
        Fri, 18 Sep 2026 06:28:17 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b4e:8500:290c:210b:1c76:5710])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc58a1176sm40807795e9.2.2026.09.18.06.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 06:28:16 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	kpsingh@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	matt@bobrowski.net,
	memxor@gmail.com,
	song@kernel.org,
	sun.jian.kdev@gmail.com,
	tasos.papagiannnis@gmail.com,
	utilityemal77@gmail.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH bpf-next v8 1/5] mm: Add copy_remote_mm_str()
Date: Fri, 18 Sep 2026 16:27:54 +0300
Message-ID: <20260918132754.43435-1-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <0b276f0a-39b7-46ae-b72f-6ba92f65380f@kernel.org>
References: <0b276f0a-39b7-46ae-b72f-6ba92f65380f@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Two tabs please. (I thought I commented on that already)

Sorry, I have missed some cases. It shoud be good now in v9 [1].

[1] https://lore.kernel.org/bpf/20260918131757.42802-1-tasos.papagiannnis@gmail.com/
