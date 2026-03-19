Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A30366558
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 19:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773947315; cv=none; b=guHggC29ITzmAWly3wCezjqOzc8thgU/lrJKDSuvQjLY/M56XbaYzupKGrd/G1LH49P/Z0oMQHMiTGbcmaP+VUj2eesoGnOV7fSOf+8Ud1GB+X5YYLBFpnHxBXQPpDGvgEiQCqnIPOoEl2DV/pz43KjIIvLA6SjIri2gzD5/qPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773947315; c=relaxed/simple;
	bh=2dcZQQhk4Obh25nUhm9mysu04mQmSvK5hJHsjVT0KOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WS5Pqcaj0e5vuiSl2fJ0eDniFv02H5h/zLiX2SDT06VDvj7TI5OdvuAVBN25TRnZVORfpEMs4lNeEux/hAyfC7LddEAtx725+2DF1R4Rod/vG3RAvv92yyOuJk3bw5L+UTdBaEONUkwj6tHljDCxpzRS0ZHCvmYdaGhXtvXpNBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K93lv0WY; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K93lv0WY"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b9793fa5371so145319866b.2
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 12:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773947313; x=1774552113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dcZQQhk4Obh25nUhm9mysu04mQmSvK5hJHsjVT0KOk=;
        b=K93lv0WYDaNUQdwqnK2aNWbLVx/3EdfquczNhd6u+8P1fSfUNHUqrPvUscVvALj5n3
         sR76Qln26jqkAvqM+EvDx+zwlnj1pJ48QTICmv3RV6B9s3y/REPuo5qzzP/4sDlKVLer
         Bjq+RKMjxYsZexVR6nZkXzqPTHW+1N/KFkqZbK0Yfj4y6YodCST1ogViZwnLXrbx1mDG
         u8Jg+HYXPiud00zezL22x/rr194p66XoncclnvjrXJx40Fh0M0N7mZvU/3tK5wvLMUPl
         URITfB4y2e8L9Aer4BKYZmlCdLOw1bCunMN6JFRgnQ79XVmSZxDMQn+alwPeIqQ4h6tD
         fnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773947313; x=1774552113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2dcZQQhk4Obh25nUhm9mysu04mQmSvK5hJHsjVT0KOk=;
        b=sUSz1FcpqZAvK6oxzu6E/oPxP2iNUvq0ED5VhgZjkL3/PICBBHtdBgZ7GuSog9iIrZ
         SuP7DJR/3y/JF7Ih6THY6dSmM5GN4ZecBDM7EAnMGnfjSHDcw0PIDRcHjfZFi2+FyXmC
         AaDkuWFUNTlZgyTOVNEaOCi4ABaDUKkGyKOrnAOLe0cuXeMvOAFGcHfLgDYInVDt3LbR
         thDJ7QOEXRzMHR97Fv/npwGo641bfFryr/jNGCjtoDLJhWuzlIJle11xGk98Co0qjgPb
         UMMoIsARnXVmLX4B2fL0UvY5t5n5EqvRCTzEYQIx1aIhAA6F/nKMlUfXoPzESYDz7b0B
         B2Ww==
X-Gm-Message-State: AOJu0YxtdTvUs9XKuXvwDa9GMZ6bUmi6pOvljmUwAIbsv5wyNfJMH8cn
	U6yqXzm6R+fLLCQF6Nl2R6nR6rUBr4PFI7nTIGZvojRFL/WE9if2MTQ=
X-Gm-Gg: ATEYQzzofwyxksU+9wrP2Z/k6AQeBzivE4FDGg4KI3Pxf9WleacblabgQoYWyZvvONT
	7sVok+VdL0SQRclKKxJQHrA6guc48qq5QXB0IztcdRyfK1IYIrx34psieqOlUjjRfn8gjig1lJy
	9VQmnoyQP/a9J7Qu6MoLV/clYzcS9z1PhYRsNNzt9sYHF4bQcXRc+m7q62eVCEVSjPzE/ouC6gP
	jPLSpNc79DpCETIrfMK1wces22bBJOHVN8kZ1z/zQDvIjiqx53ARRc9DvPomcdIwdUvuVlLxeRl
	5O97XCJXsW6gChKRmzWyfzJMofLhT39uaj0tPSjq0wIn5Aeoz+KI4AhQAgggtoPqZJHAU6hTTM7
	T0AutaPxjzFqHLP6ePyGI/uziiUr9ygpQxNbLbQWrZ+RUzs0KGTsFM1tKllHj/jBRNZIWglAzDo
	FGVoAgJxyd1NyV0cg2Wx9lAWBaUxiTyPJp68vcKAwxRLg+WcGHhGfe/ScfmWspvFjY3/ZDRdvzE
	j9c4dck5Jm26Uot6czivS7NaA==
X-Received: by 2002:a17:907:8010:b0:b97:f22f:43c3 with SMTP id a640c23a62f3a-b982f2f826dmr24141866b.31.1773947312631;
        Thu, 19 Mar 2026 12:08:32 -0700 (PDT)
Received: from codespaces-35910c.jmi21fcehg3unfegezsteryjgd.ax.internal.cloudapp.net ([4.180.183.243])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97f1681603sm505235266b.41.2026.03.19.12.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 12:08:32 -0700 (PDT)
From: Ibrahim Zein <zeroxjacks@gmail.com>
To: paul.chaignon@gmail.com
Cc: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	andrii@kernel.org,
	eddyz87@gmail.com
Subject: Re: [PATCH bpf-next v3] bpf: fix out-of-bounds write in bpf_bprintf_prepare with %pI4/%pI6
Date: Thu, 19 Mar 2026 19:08:29 +0000
Message-ID: <20260319190829.14244-1-zeroxjacks@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260319125800.0000-1-paul.chaignon@gmail.com>
References: <20260319125800.0000-1-paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paul,

Apologies for dropping the list from CC, I will keep everyone in copy.

Regarding the (size_t) cast: agreed, I will remove it in v4.

Regarding the test: you are right. BPF_SNPRINTF is limited to 12
arguments, which is not enough to fill 512 bytes of bin_args with
scalar args alone to trigger the overflow path.

Would it be acceptable to keep the test as a regression test for
correct %pI4/%pI6 formatting, or should I remove it entirely?

Best regards,
Ibrahim Zein
