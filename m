Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B0A23EA84
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 13:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786454968; cv=none; b=KNqWyScyCvV0n3EklNOFU8BcZFLLa+C1FQXJEB+wT2YHj6egEaNDFLpjgGGIP/XEw+BMvIb15K4ZU4QPObXQw2anK2bOeC61UhAxWhhd3H45UOUwwLtBvgZXWR30EE0NT8kWMsihcc1HRg5Fd2JezmN0V8ZyS7KhgberjC58SKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786454968; c=relaxed/simple;
	bh=J9vBjygmcNS+aVa3FlHNEQWeRjGqbbUmRSnb3iurApo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r20pKCPQBQmMg0lVOhJ8hnYpR/WhzYBV0XugHZSd8OLASGGKFEtD2y5cVy0V33GcVMQy6Lfw/DkhdZyLPCx/aYoO6dO385c1D5gQCTUqQdc6xdXCGOOrOoq7ymWnB9fLHhh+2kEjqB0/GGcFmLYZ7jfEPdejzv0nZkL4GZs/NNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMMMg0Ci; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMMMg0Ci"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4954a9e8490so6384995e9.1
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 06:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786454965; x=1787059765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J9vBjygmcNS+aVa3FlHNEQWeRjGqbbUmRSnb3iurApo=;
        b=UMMMg0CikUUo9lzcKQd2gKrGLq6ETHzzxcRKRGNnM7gD7yEeoAfNcRm/I+ZVn9YwIT
         viWM9svCWdrH9RrO2ddt4X7PfYnlgb0am2YiOZCFaQF7OjKD9fZsOD303CzUJ7kPH28y
         /p5Z47NdsdoKb8ReZxWUyGudAjyJbOk7PU1zjGUa/0HkjqvnCG+gkAWiPg3RhkwvKD9Z
         7kQSrXOpVyR7lZKYx1dBJ0aiT91niifFcXAgVzQ9rgMXlOOGuriWfEKuwiWLPFLvVBzy
         h8whhXuP47LVzLaut71+sy9B1v4TW/LwjArXW8ZXyKVaxQ/sQxT0Yu/tvEyj0rC6vk2s
         va/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786454965; x=1787059765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J9vBjygmcNS+aVa3FlHNEQWeRjGqbbUmRSnb3iurApo=;
        b=DgqvqscJRYa514x6jxXaD94TJM04KmRXXFyfsTJoPipxgPWnJdrOtCevPoe74E8q9q
         k+40oYzKHOhg4gkMHzZWqAMSndh2frgLhaIowl4dYW6eQzTduEbwXQRoWS94CoJxzmMe
         AkyOhvMxsAeaqZMnxUv0kvj6S1ATFk9cMPL5kLmBrs5FxSHMNy2hMtAe+TteCTjjBQiW
         pJsSFoMfsECaMSVyZQmICGg5KsnoLdNSrw2jp8VTz9txXcDQrBHnzWnsQCbLr03fc8Hf
         HCrpr8Z9SQ630eMXnLOElgIgAmO/SxkDYeVvJloPMEsDhgwnl53GMkKlWhE2kUbvzeSg
         RM6A==
X-Gm-Message-State: AOJu0YxslGB2HzrNShjf4SoQ6vHdSuJE7ALuj+GEnntAjzAZnf58wJvx
	zJ1FhaLiGLOYaMTAIczsrxJReI2xynbvRtUqntrELQkjxYQs6LYPfzPONruXfcVy
X-Gm-Gg: AR+sD10vbPcpMJYGmP8oWvRAcffGcGjfmRAMOOhuxbspq7Lrna18AxUbdGplscusPe+
	L47oUA+DunSR4ufcUVmGsMBpL4R/H8c8tb9PIRbCm1LiwtqZVmzfm9Ggd2FqsoeopexJWv68UqX
	vAu37tPkSBvxejwGG1aOilxk35GVuyP0C5Mq+I4KVA5D/DqNSTjJC9G+3wlQuAeEAdiHr9yOCw6
	YX/MKogbP228CO2uDEkOeQesIxsm5rSnT1LunyeN/8zKnh4mQX/qXqz31TCVIXPJ98CcYQVMqI4
	hgsHR3RpJUvBA8BmBI4FAEVAzpiEq17krvNE2q9XOULyEuCykrA/nOxttxcBp61xziQNroHCoRb
	/Mzm5vr1nB7mFLIIq0ru2Ga1uwIlvK3uL3ZzXn0DhnvVDHFllHi2STfH+5y1mT3TfE1JrGSfONS
	c/YTruzXPZ0hlD9Yb3YGZBorrObtlvFASrH78M+R+LJwgZa2F0NSTym+j1OokAgBpD5bwCrFAKE
	4tg
X-Received: by 2002:a05:600c:4894:b0:499:60e5:248a with SMTP id 5b1f17b1804b1-4997a63788amr1222975e9.4.1786454964817;
        Tue, 11 Aug 2026 06:29:24 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5e:1100:7303:647d:7cc4:8552])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4814a6b2ea8sm4285953f8f.16.2026.08.11.06.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 06:29:24 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	song@kernel.org,
	tasos.papagiannnis@gmail.com
Subject: Re: [PATCH bpf-next 0/5] bpf: Add user memory access kfuncs for mm_struct
Date: Tue, 11 Aug 2026 16:28:49 +0300
Message-ID: <20260811132849.98483-1-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811112154.94053-1-tasos.papagiannnis@gmail.com>
References: <20260811112154.94053-1-tasos.papagiannnis@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After looking at the output from
https://sashiko.dev/#/patchset/20260811112154.94053-1-tasos.papagiannnis%40gmail.com
and https://github.com/kernel-patches/bpf/pull/13211 I believe that fixing
those issues in this series would complicate things.

For this reason, please disregard this series. I will send another version
separately.

Thanks,
Anastasios
