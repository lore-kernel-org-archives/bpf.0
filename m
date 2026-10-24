Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792836596;
	b=NVqfR8PRQcAbFP7QtBimf6LcwV3Dd0/SUskzBeIRvpQlGBHkwuLMJA8JWorBpMJBzgKo
	 uFEyAVcyF2Z2LcyZFGK2q5x6P2TPTOOp3qLd3NzvM4Zymn0jBfo6mitKoo0wzefZExc5x
	 3yKzJHs/1CGaZMAUcYglXbyzqLqcUXEnnhZkOQ+I2SHsE9Ec4+Ol2nzsqZsexCxwg4FAA
	 7hE+4qxIY/Z49kYPtiDI73c9v7Rd9L6fPLh+7siHbsr2DIqONbR+y/2/MFo4P38SKLFBH
	 uDISU8MJDmrRnFmLVq8ORcDY8LBbSyY6D3hnIiVPWtB+VV64rd/djQ9mAEGvKf7tV9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792836596;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gBmeT5JJ7GeeblMXaEFca81tlnSg9rFzTcGutmMmxPA=;
	b=IZYXccud4n2TOoQx5w0AyRHsygSyeZuprFg7i88thQ1jGItK1FvjyJGNuWaQyuXPoA61
	 zFOEy3zB3ajWax/+lQ6sjKTNijNlyCNrMwBNjJ8V5MoNYWlgXPjDi2d6KzX1AUaPT/v/r
	 9nBj1riAJLuoj+OMbKn7iH/E6RQij1FPAuo0MXXg08WfuxH7VvOhwNus5a1bQhCB7kkl4
	 4cHHlb9oxH1JQ9LoSqJgAhbkYDNA7Sh7xp8yOazMRiU6dSkDAHIF1kx3AoSF1Y7+AUWz6
	 TVLhmlbAiRa9BhJbAnK4otW8thftXImNIYDRcenqTp6s8idHMxsB51th0pg7Cpp+YFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TqAKNBFG;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C69D606A31B
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 10:09:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C69D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TqAKNBFG
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e9f6a16aedso10427555ad.2
        for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 03:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792836594; x=1793441394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gBmeT5JJ7GeeblMXaEFca81tlnSg9rFzTcGutmMmxPA=;
        b=TqAKNBFGu7Oay7kVjz7Sb1PxLYaXAZZlnGcKtDpMpW1Kkd/7x/OSpK9LruS07mebPB
         tKE1MRySUZvQYWM4iaaWg5mPC5JYbvK9zx8R50JsXjQCmWlk9va8JwWhVL/HqjZrFab4
         5F/HurqY1cuGtt5otkp9ge6GQ69QnVgkvSfIOh4eeuhNTwmPzbWuxQL88EPBGWvx2y7J
         J1oDcjYxDhRYkk1VETe0ofRev+SMfWEBuxl+qdIkIoN/26fgAPAO0ruvxdhUSsWj6ImW
         8KqUlV6s2/2rKJE0BlmvWgMbPJBeO/yFq74Z97y4/3qLCHrOL9crycND2eD5xdaVZbw5
         DsyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792836594; x=1793441394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gBmeT5JJ7GeeblMXaEFca81tlnSg9rFzTcGutmMmxPA=;
        b=J3hfMm1oyQGEH4KdDP9Hf2uYjXvW3oxUoXBAuy6oS2eDGnw/cIdpTHbe+DYLu/6d26
         BV1SORoDval4j2z9ADvL2Hjp3yxoRTtwWtox7FhPtqOdKvSOhkHYu7ynEVKrd7k+qvWW
         SIt6BeKzJhdQS49kDGecxZFTJ4PO6pKOIcQti2CkLXNom+McOBnFpiuxbKfJtpc9xx01
         dMskgNBchN4wJkAx/p/hj6MnE+Zrgap5x80DgPMYY0vN9rod1aFm8w754OY4kYeQBdZS
         k8jt6IOjSk74ZhYrp3PsKU95UcwaV071cRf2hTeev7diayhcxXZPNLKdnBc2Apmb5wBC
         NJvg==
X-Forwarded-Encrypted: i=1; AKwUvBwb7FmdD7pXPKJSP6KRAL0nP7cw9Iu+BOxDL46n8pV4kIIzTJ2LypdeAF3BN9VvWT3Sl3Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYL+xeZbscy5v+x8YB36oJFJdMbzYYoW7XWul0NF5TE1Q5Wsz1F5
	x9LzYIueT7X7ONB9N+4A+ruEm6W6I/4C5V99Kgv1bUPC3NKSOZ//i+DaE1Gzu1KX
X-Gm-Gg: AYBFou0t9fRCoNc+FkXe9P6aPN9R2XkQ8479/XBEz4U2Goa6oFI3u9JF0kUWFSZKvep
	Z3I5GPqZ7Iuxem6dHrvE9ZiRRD7ZbUNvtqy7iMMhXTfh+cXNiG1FaIObkFlTP1oQCQ7GvEoq4bI
	xhsjZ4Dh1+Uag0VbvlV9eIDWeQvtm6fZsdS3ugy0p1juhLExvlAbrUmiT0lA2MHPeYRnosWmckJ
	xJommdkwf3j6KDSqS2YXkg8QQCOTf/bG7KrMTXjvfBXQYu3s4AVO4yBK5FBLwg0z8gbffnR78tp
	OR1vTk+aAdA3YUKz6pkWG31AZpnzEzHsQKNOqETYn8wyi5MQuwmNldHuerEa+gzCF/20hJY8Ksg
	ntZdSYnHIAiTsZbeql/zuWNbSjO2M6t6eqXbdMG6Ea+TW21C654tcbEkX+8B6DhRa5OR4k4Ap6w
	YXHPMRVsKpCRyPuHovgOa+kjvLMRI4HMGZukZ/Ay305SPsHveg1cwbWOwPKGcNL6uG6raaJaqdC
	bnqdBcofW9+oc1mgHGxkqw8TVi9iuxu3If3KVnlPUNX5IwKvzjqvuRWIT4ZiDj4tkptXof0ppkv
	gWbHguI=
X-Received: by 2002:a17:902:d50a:b0:2e5:54b9:6b5c with SMTP id d9443c01a7336-2ea9c66bb6emr12267095ad.20.1792836594441;
        Sat, 24 Oct 2026 03:09:54 -0700 (PDT)
Received: from localhost.localdomain ([14.187.77.45])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1982d2sm4635355ad.41.2026.10.24.03.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 03:09:54 -0700 (PDT)
From: Nguyen Duc Thinh <ducthinh100812@gmail.com>
To: Mark Severson <gr3yf0x87@skyn3tlab.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Federico Vaga <federico.vaga@vaga.pv.it>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nguyen Duc Thinh <ducthinh100812@gmail.com>
Subject: Re: [PATCH v2] docs: changes.rst: set the pahole minimum back to 1.22
Date: Sat, 24 Oct 2026 17:09:45 +0700
Message-ID: <20261024100945.34029-1-ducthinh100812@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261022014811.2803450-1-gr3yf0x87@skyn3tlab.com>
References: <20261022014811.2803450-1-gr3yf0x87@skyn3tlab.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Oct 21, 2026 at 21:48:11 -0400, Mark Severson wrote:
> Set the table back to 1.22, in the English document and in the Italian
> translation, which carries the same table, and remove the Italian
> translation's copy of the paragraph that the English document no longer
> has.
> 
> Fixes: fd5425b67355 ("docs, resolve_btfids: Document kfunc BTF annotation emission")
> Signed-off-by: Mark Severson <gr3yf0x87@skyn3tlab.com>

Hi Mark,

Thank you for catching the mismatching requirements (pahole)
alongside the Italian documentation update. The patch makes 
complete sense and resolves the contradiction cleanly.

Reviewed-by: Nguyen Duc Thinh <ducthinh100812@gmail.com>
