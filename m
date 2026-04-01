Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A28132D45C
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 02:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775010248; cv=none; b=Hust9cQGrS/gXzO4Ca1l10NJ89Q2iGO50TMcm/xxfHo1b+1JDgRUEXIiitc55gtWXLxw2PU1lsJIwiyXlLbf0hQwIaqvVyUKvT7SgQRDXLyO9ee1UlaD82npH5dK9GI4v2yKE3lmQ8TRy60f3yZIOrYjb9lD8ISTL0JxsnThqTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775010248; c=relaxed/simple;
	bh=hOVXd+VIFn2rFw+DwbOoBbrAzec+kPOkeaJiHzsxHUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oHQYqq4041JdvFpUVQaF7ngRNR49asaB8UJDauFl4P+QCGxWVuRnUgFD5F6QgvU1yvdSIvjEGUdhhFJByP7aBZQtNQM57TrBQhtNKCU5ilFa2zVifxdT39ia10au4gMPh7IPPB2aNsax4SuRRINcB/vYkCqYs4zxVitnRIMxjZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJDD5QGN; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJDD5QGN"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35da8d037a5so1201183a91.0
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 19:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775010247; x=1775615047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOVXd+VIFn2rFw+DwbOoBbrAzec+kPOkeaJiHzsxHUA=;
        b=lJDD5QGN89cSJykRx8l6bJ5EczQXD+etcuJk3ITA57ODUyci8/FBhBNoATEfumaF1d
         idZIioHPl1aJzNR1UG6dXmzW+tb1tL04h2Qiwp4rjykqgQRYaxAGPUfX8StwdkZIUB0g
         uGfW+UqBJAQojR76DB07t+Fd5WH/OjS4eez+TzA39vBPUxWN1UHlri1siDpOp3CfLpx5
         EXS3s+M6lL+SLDgJ83f1OG3S7+6Q31LlZD2WH3GqdERgpIOmxkTo6FvQIIbyAF/4ShKq
         VepziYAJyoXgk4Py4HgzznafVudm1vdS6x2Fgnap93j6XFkhG79nEK/e6zxGdDK1qs55
         OlWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775010247; x=1775615047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hOVXd+VIFn2rFw+DwbOoBbrAzec+kPOkeaJiHzsxHUA=;
        b=WtnhYEDvD7pxvEBDmNgNqQ57tYlbEaO1EONSL+GooWNEQ7mwne8fwO0gyn/isYmuI7
         MU+uHJTpDNAx8aWUt8fifw7aGZjmKpnD/b/LJ0wUsh+hkn1OKW/G+YZY20ckHCiPIQIu
         DHbiyu7xXHJu0Uvq1/grLyOVwT6jSht+Z4w+RIMhNu0Nw9mjL4PtNeuD8HbWXJl+ER6V
         7sh6v2Qy0iOiO9a4HdmtuatI05SJ7KuLc1yopQjU78JVy6lFhR/FNNMvoze5O8PoGWoh
         u7O03Cx6bnKAcerVeK3uTS51i6CWwli+gpy0UXpmjU2HW9fPfj/txmoQ+0ChLaqXe8Ni
         uKew==
X-Forwarded-Encrypted: i=1; AJvYcCW7UGPPwrylhQ21Bw0MRtX8uXJAFpyNJKf5Z39y1gPC8o6xA+IdNMxWa3NegXsWy4dAS1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUR34p17l6mCrwp5EPCo5OPwi/I111e2MZ9EfCg5SUjaotvOn9
	B76MxGYVkR1fBMPtQFwm9EBypi+U9s04kVxscshfi9zPzwewRAWMzkGi
X-Gm-Gg: ATEYQzxxGoBjXOQfMccUlAif3plcfKHQmUo4CgvoTRyaPNZeJBofhE/A/8UsLXl9ygv
	VQxNNURa700ixU0PE0f0i00k/Z3NOya09iuA1CftH+BZz0SYOxMiaV8F9Lhh0rE0uZ/gDL1d0yv
	3Sp5SBZ6yaTHnV9S2V1yxOF0cdKOxRH0DVSA/zi2ayhdrJpoeF58TvTrohO/tJrBOylphAa3PCk
	OZdn/ng072Qhy5smgGDS2jBhuYhsXnieBOmz5y43K1pkKkQ7ozP6eIEL0To4EAolWaPt1j4jnLS
	w0AKlexHXjnyJz6gwtqHppYAOw8nxFRPGg+5p5UJdQ+LBzAXfEpkyzQk40tcxP65d7hzHMuX/7R
	mVNxfteycpd4zIF4aF7cOzHWrFrTiXyoWbJ9c9v5t4UFqoKSZjQruTvLnRmfiJMXcDgU0Y7r0S+
	vkbKCfwvOJJAXWt+0fsRdNFrGCgKxC3LVolZ8=
X-Received: by 2002:a17:90b:3143:b0:35d:ac4d:3cb6 with SMTP id 98e67ed59e1d1-35dc6e2d0d9mr1553600a91.5.1775010246651;
        Tue, 31 Mar 2026 19:24:06 -0700 (PDT)
Received: from localhost.localdomain ([47.236.127.140])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe66fb67sm3127106a91.9.2026.03.31.19.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 19:24:05 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: Re: [PATCH] bpf: reject direct access to nullable PTR_TO_BUF pointers
Date: Wed,  1 Apr 2026 10:23:57 +0800
Message-ID: <20260401022357.73102-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <9594e5fdeaae8f81edd3b73ff7e263c535d74c7c.camel@gmail.com>
References: <9594e5fdeaae8f81edd3b73ff7e263c535d74c7c.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thanks for the review. Will send v2 with a selftest.

Qi Tang
