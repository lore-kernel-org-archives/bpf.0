Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0564F55A7
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 15:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788535838; cv=none; b=lTIc62SUJCJ2YkyCi4HjO+eAZZFElKV0mta67uQai26qjz9O1+zcjlxD0VoKJX1dB86TvArbicmBj1zcfyKixGDKMomr1gMnI1Wa+JRxJJshuk7a99zvx4cpoDRU2WxF4bEkgG6egEMKLNABLliYd8/xRdY4QkdRd4CSTyMOz/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788535838; c=relaxed/simple;
	bh=enrMTCqbcwGpANG0acoNtI2xdi6tb37KrmYRVbYAknM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YuRlWXLeOqO8scBUn4neC9MJwxcA3TRJQC00Z1a+rodx/i6MO3wNWIQQ6KaqE9uSViinO0g1tAItropOQ/qCpSw+WgYCNXIjKCWTFZbA+EXQohkA64O6Fkq4Kk7Hv6HopZBIMxJIkJPAt9F4bFtOr4YBLs0poRd/QapCKRwP/TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8+pE0X+; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8+pE0X+"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49b8eeb3ff2so10598815e9.2
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 08:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788535835; x=1789140635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EckKFK1Ub9PvsMWglTbO4VcDJbOw095C6Au9K6oB4qQ=;
        b=E8+pE0X+S47UpnPOxBRnL7xeK9ewmlc0eVFzFGxriFDe8y+Uz2QbTwR1KmgXlQ2Du6
         5NlEkrzZ8aNrMjTHIq68StCn7ck+8DVEif3jsqydoYNC3h5cVtYbiv6WKZKKlAFTqquo
         /xCUKaHLgh7TRo8Od+3gxoxcNTJKjn/K4l61rQTzmwHAxouwpLlchPFNf8WhYqN6Bc/n
         ZsSZeCeH+t+TvIHFFj+QHCbaaS+AwFFVYs7mFcC1wyayu+1XF0WZqVr0hyBfGpL5spNs
         RH59V88g0n0DSnNqMwW/m6/QOtfLrz7CXI8xvviFDvghx0XSrQlQTDPC87CLLwboE6E5
         oZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788535835; x=1789140635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EckKFK1Ub9PvsMWglTbO4VcDJbOw095C6Au9K6oB4qQ=;
        b=IYem3TdYv5JLS2CgEATDJr7Ft9eN9ZF7fzaCTOfe7pz5UagaG8M24mieC4fErQuBT9
         wVnSKk82EG9gK9HbhXp9mrjZ8W2HUvf2uEeCj5S6UZUn/kENTjWemwOIeQGoJVobQiyi
         8SvCc92VIoEGBRskoT4+ceKL49qE21IM/0ugznVA98wtGZeIbB1oJCAL9KnaRshtJZ9K
         LnW4WNua6YCF9errsWzxHfnwH0EiB5LTk25xV4HhlD7pe3xqHVq+UvM/pGztmbEwPj6l
         6Wn9CGmFRSEDk1VRExscCvPdY7o8vXaR4U0NHAkrU2qkeNwwEVBcOsEBvq97ul7Iz1O0
         9cvA==
X-Gm-Message-State: AFuF++kAjNLnqYomvdCUGpvu9SyX+Kn1FPo+snkEWAEbJjEmu2or6Sdf
	vISUUVFVx2jimyvh78VLl6ziw2Y4ZGNAA/XmFLcn9jEwagtyfW5i7o2N
X-Gm-Gg: AYBFou2ON7Nom2AZ7v4qAy+1ZPha8A6E/q7jQ/JocT6zCSAAxQcYyQfKG9awKa6XAZY
	ztB5J8wNEybmPMwfefPv1u9u2FKRf2PZAqPbjyHl701BeOCZoNTWIPM/gdcOj6E3M84bFhHWm12
	q0nkS0gcpPAsKVj6sDpFWVKDdr0845lTm8OOBzKDQXnAo3ocKxbIsVMGAYFqzQWPEWic6990hMr
	CT/IKnqBw3nNOWZBeJ6jZEifBpfdLzXX1LMTAhzbAPbOH/T/k3iU037BGXX2/IGkZ6mvoBzdOaz
	jvsqZFcmsS+4wkRI9JbuzqDh7qZfMvtiXzq2moB9TzwUGHnpzZKr/HH3phJeLkw6sY4ljonhW2i
	4k7EUDo3lo0IPBlEGrup3ZleJV6dQoW5xLlg9LfmlifKyrZR1fUiagxRRDIlnn8P6f6++Efwdml
	6z+w+8WxuOgSoML/JLs7CQhmfu9eYyB6d+0CkMSiNTlMwWOHn/yE7cdll3ppvB8iYcArxaY0mNt
	w==
X-Received: by 2002:a05:600c:a4b:b0:499:4e47:eaf2 with SMTP id 5b1f17b1804b1-49cf824020amr63299485e9.6.1788535834752;
        Fri, 04 Sep 2026 08:30:34 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5f:900:ef25:2f4:1792:4e6f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee60bae6sm194191315e9.9.2026.09.04.08.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 08:30:34 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: sashiko-bot@kernel.org
Cc: bpf@vger.kernel.org,
	sashiko-reviews@lists.linux.dev,
	tasos.papagiannnis@gmail.com
Subject: Re: [PATCH bpf-next v4 2/7] exec: Clear bprm->mm before dropping its reference
Date: Fri,  4 Sep 2026 18:30:06 +0300
Message-ID: <20260904153006.42450-1-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904152018.0B7B11F00A3D@smtp.kernel.org>
References: <20260904152018.0B7B11F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [Severity: High]
> This isn't a bug introduced by this patch, but since this commit prevents a
> use-after-free for bprm->mm, should we also clear bprm->file?

> Looking slightly further down in free_bprm(), the reference to bprm->file is
> dropped, but the pointer is not set to NULL:

> 	do_close_execat(bprm->file);
> 	/* An unconsumed PT_INTERP substitute from a binfmt_misc loader entry. */
> 	bprm_drop_loader(bprm);

> Immediately after, the global function bprm_drop_loader() is called. If a
> BPF fentry program is attached to bprm_drop_loader(), it will receive the
> bprm argument.

> Because the BPF verifier explicitly annotates bprm->file as a trusted
> pointer in kernel/bpf/verifier.c:

> BTF_TYPE_SAFE_TRUSTED(struct linux_binprm) {
> 	struct file *file;
> };

> Could this allow the BPF program to read the dangling bprm->file pointer as
> a PTR_TRUSTED pointer and pass it to kfuncs requiring trusted arguments,
> resulting in a use-after-free?

This is already fixed by:
https://lore.kernel.org/bpf/20260903-normung-opfer-matten-d29bbd55cf46@brauner/.
