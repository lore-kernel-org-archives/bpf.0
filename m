Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E9A3F3265
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 06:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786777188; cv=none; b=O2knvKTn1qGmly1WVyKz0ZpOTMrGQvp9pL+jSdXuMXjk2RKXmjIXNwOiywbdwN3P4cadh1TzmpIheoxip+ePGH/XuAeGoRZLwVSIUySmvo2Rsq5XP6IPrseQQoVBUhKmzHRkJKyKGV/gVZ55ey7QEdpZChTgiCOIVKU6GaV6bVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786777188; c=relaxed/simple;
	bh=2XRsYUoPzYnatPTvcy6y5W3t3RWQ5s0KpPGVdws+DbY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eSh3w83Gs0TiUyAcmy512EgyC4XtTFwY6V6cg7jkm22GdjwjjWEs4HIVAyUpheWc22yNH/iTv3H6De2Yc1E7Yd2PNjewWEhyX9UqjCFz6CGBDN+XY66Fb6AkIgx8027igLud0+yzxnar4jy7CpP41sKu5owoYhi1rbrTBCE9CHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMH8arRH; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMH8arRH"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c966b9ee9cbso1088997a12.1
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 23:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786777184; x=1787381984; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2XRsYUoPzYnatPTvcy6y5W3t3RWQ5s0KpPGVdws+DbY=;
        b=MMH8arRHM2OKYrulo38TBgFRWRLrUcul/k/ue8uqtA/JKxBxUqcCi7X9dDRc67gT6C
         UNEZc18VB0of86YVRTcJ05Gkplon0I2Mzke/yQSkxInnFxt/Vxcdl7RCYr+eSZKJe+KF
         Jaq82eKNmfJSznGatBnoQli/5bsfUzn4WtXu6Shu1yadikfY5oGUaZ5TeUV+NRr/xfmC
         i2IWDaZPPUgUH9qyMO6ZARCBE1PvQocoE0HTurDIO2vFK8yoV1ABt1hgCuQ2g5LUr4qf
         VytaAaJ+THPXpU1l5YV5eW1/hWS3jkYSz2EdnGevZa+3XPe8nQcf+jkobwPU7CEKZ11L
         kwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786777184; x=1787381984;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2XRsYUoPzYnatPTvcy6y5W3t3RWQ5s0KpPGVdws+DbY=;
        b=Ohow/94CIED5nRg52TizcOCgS2VLli3n1maaHw+SDq++j0yxYALwgQefx6GKW0sipE
         EgQR+muLXR8V7DOXbXH9KK5SCd3kvFfZV6en9Q8IXRyp7eBywMF3BSfwMqb3XWjt8vzk
         iqhRR5shJUMtFP/GPezyJusBf1gEW1D2uTrcC2q/63Qds49bGdERDdCe6A9JCe/1mJbu
         8NM51AHdGUCi2X22VvOCDWoUuwncyYqutwyeERPa5WZxl85T/G9wWPvOQeO53np9K2AC
         whD/87k5us0IsbmdUOSug/gNMBapawlJkRRWxP0xu8y1DasGl4lI1TFefZTvi/quzGa+
         Hrcg==
X-Forwarded-Encrypted: i=1; AHgh+RogG3pnZtBhf5SLEDQVc0GkFmJiQnq0e/LsixA6qJjFwVhzFz/oRvFwke4cqbQct/P0+SE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhfNQV88koxWHy8UIzKPnLKHiFXw+PH+4HGvQqslyRoIdOxZHY
	6vQ88171tMLSH7t049776bKGkH/5SpO1mAsGTHGPDRhMsTZRxEwttEsS
X-Gm-Gg: AR+sD13yhPDepN76FFtkBQHamXn+rRz2TyPzss2vI91Kv9t9hMHl5yNlV2Hjmw+qaeF
	kitJObh3U6FUeIBnsl3P/etD4jp0U6ncztuwuH8S4W0bDhh3q/QYHbwhDBySRCqHqRHa/KHP7mP
	B3zS7uIxRpi7JGtPqWlr/28WR7ga6qvEEhyfg4ii2Ap8Kr08vLuFJUeafVtHxYLXnn/94XO89gk
	qkb3ikgSmrCY8f13TxRumFu4ZXt7bemnxfNoMdRNEaZuhrPx0e6pLzieaYtBhvPFL3C7qZDj98N
	bGaj+kxhvckaxHZifSo44AWNpXsL2Tax6x5+5QJnX0+EMoQroQVz+ibPSjIDM+na5+dymifGt2Y
	9FbPFXb8LAko6cbZ12jRyhkc7UNup5znndjNHaVz/mK7ai5wC/Y6+Shn3IZm7SO6e8/8ertJU8j
	VOJx4ShwgwfoY752l4KA4bWsU7+P368SQfAPWR4zUJyFz+licMPFcX1kqkv8N0BsafKyJIlDLF5
	f6KbjghsunZkhlf
X-Received: by 2002:a05:6a00:418a:b0:847:99a7:c751 with SMTP id d2e1a72fcca58-84fde75b0cemr10999018b3a.25.1786777183910;
        Fri, 14 Aug 2026 23:59:43 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517d223f8csm1223558b3a.35.2026.08.14.23.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 23:59:43 -0700 (PDT)
Message-ID: <2d19f707f3c70c3e170acd3fc79fb70e7a27d5b5.camel@gmail.com>
Subject: Re: [PATCH bpf v3 0/2] bpf, x86: fix per-CPU address resolution
 into an extended register
From: Eduard Zingerman <eddyz87@gmail.com>
To: Vineet Gupta <vineet.gupta@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, x86@kernel.org,
 	stable@vger.kernel.org
Date: Fri, 14 Aug 2026 23:59:39 -0700
In-Reply-To: <20260814220254.3797467-1-vineet.gupta@linux.dev>
References: <20260814220254.3797467-1-vineet.gupta@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-08-14 at 15:02 -0700, Vineet Gupta wrote:

Triggered bpf-next CI manually [1] and pushed to bpf-next.
(Since it would be sent to Linus on Monday).
Thank you for the fix!

[1] https://github.com/kernel-patches/bpf/pull/13314

...
