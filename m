Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207258;
	b=eB87f2AML9FLur+1Cr1uOkM6EXI0Z3mfCGVtudSzRSSivETQmFNtQYq7c54xbs5pxxiG
	 9jl3y0T8sbo9Ea3mqpL8LqU9idrGOu0j8bvN/hwEY8pj/BkG27DcHXlWDjSqenQgiqCkB
	 audgRRfHlkAyiLvUCL0/UocElYZFn/gXuy+SrygEmj9tNotmOv8f2w2n8tSlD4mrsbJSp
	 3NJa1vxICoK3w9+Vmwz5cRmAKzXWPmKmir6j0glqfcSmwJ0N5r5l60ebcgrpVVevR1ooO
	 RwrxXi35eBEpycZ1sMe8PzHI5THWVr+cZgbqGORRYNeCsmLpz7srhWzXvqfa76EDzbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207258;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding;
	bh=PXzImmwMcDhGvn09GiQZkXuApv8MaadtSn2F4xSnzms=;
	b=VE8UUSPvCZSuMegKY8GQ7NsxOyhzfB+r1lKhjMKXN5O3Ie412FbTwUOsiqz8/20+ZxD1
	 8s7fjYHjGlLF4uxQ/QUPPU/d/XAkZRtoLjFva+I2/owtplG+kD6oNSU8OCGe0bkm+ZNMr
	 29xTDvHfXXAP8PXoHbteqcAO8NBP5a4e81tcarKskdRKTje8MnLXdzqgHLZ/7s+DsvuB4
	 iUISeEGksZTAdRkCjconhSPPEjL/KblqOCjeJV9yAO+5vCHgDBLkYgarybTdGuf7ATAIs
	 Gt0ZeH+sBbLDO5S9QzewnyqtkH9/CpHF+RMMfYsnTNh5H+xGZzcVkA6ad4jd6/f+EJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=kernel.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B51606A6F4
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8B51606A6F4
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5364648ae07so15227891cf.1
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:40:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207257; x=1795812057;
        h=content-transfer-encoding:content-type:references:in-reply-to
         :mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PXzImmwMcDhGvn09GiQZkXuApv8MaadtSn2F4xSnzms=;
        b=ss/R/pbcHddvGPtHVPCwtHjl6v+KciGPBa3p9tbLWFSHeEJoECDpSJYG4grdV0sjAG
         wW27sWoIYDL4+S7/vvYGnK2vn8exClUGXM5JX85gy9befaRwh4bfQxLUzpONBCGfTn4m
         44avQOkuObETdTJ9QTMA1fDrrxCqlJxRBJQZxG/mOqq0Syri2i1+PQw/RvBSqTmVErZM
         nRiuwToZRvY3qTsWHW6RDCMQHnLvahXh2ou8HPotlK+Pw9MHQl5HdCHKV1MT8/gR8rJx
         rMcPzE2FPPjaHpjJbeuFrf9NFdjimgKvk0nFM1dluAFHW2G9mdSmxhaHgLuogC2GZE15
         HrTA==
X-Gm-Message-State: APuU4Z85PtWEmJ48nfFLb7Tf/ghcfn/6NRWH+TEY+esl4X/Gsff9S0a9
	jsdzGyCe5v77FBwqhble3+xFOHmt6QB4doOraaSTQAT5MzxbOvtIC6eg
X-Gm-Gg: AYBFou3BjuNLCjkhAiOUW39cJY+p1f7hFs/4vMJNSYNIfu4X0iA/OiUvYg3F3SB1e6x
	SuxJjLsdiF9wqm67b1FQhvbvrOdqadm3yALrr+GLpQHeqZoyxPlVBGb2iT0SNChZvmEh7pm15h2
	b6OrCS/zvtO4vnuD68bpX4JKolasGGD2wwMpZZvDoiPqnIYmiEGMlhobRutdkXowZXErnrx//6O
	u9Gku8uEI9UnOUYS6UYATL27OBNuOGDD2QCYmEZK/TpMD/V0mf/nZF47oxc/XooamzQEDg/9iUR
	qviDOOsY7fwXZ2fN8f5EV7EEqW+bUu6WbxaOw1iI88ktk6+4o+UakZ9qMIrAbVqfvfC6LLsL8bH
	H1nvceB+EVf6zn6wZeOMK+C9YofIUHzbbWkzCOrKuskZDeQHKEFuMdaKR9ML36SQkbAqBDUqkl8
	/nb5xtRcGkxs8i1rERx2eaPIMKkb3kmKYRmupeSWcbzcytdWIICNepMehkYLaJi5UzzMmLiJ+6d
	CidCLWUN5T+vYMpMDgniCm2wo5W9I/QrlGFT/tglDQqvMXZnpp+eKxtkN/Wq3HPJY/vSMEciA39
	yslLf6Aja0WAAlSsQq92FAufoC/WMI+ElTuWbhcHytrHaa7yhG39CmMdBf3Uc1c99I5hf25Pmsn
	ccj+HEAm/d/aYDPKR5Bg1ctbxeC3hPl4/yHn7ho+QUTzrv48eB6Mr
X-Received: by 2002:a05:622a:a05:b0:536:6586:4f82 with SMTP id d75a77b69052e-55d768a4acamr74184941cf.7.1795207256790;
        Fri, 20 Nov 2026 12:40:56 -0800 (PST)
Received: from localhost ([199.170.132.196])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921347a0b79sm36079326d6.5.2026.11.20.12.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:40:56 -0800 (PST)
From: Tamir Duberstein <tamird@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf 4/6] libbpf: ringbuf: Use compiler atomics
Date: Fri, 20 Nov 2026 17:51:54 -0000
Message-ID: <179519711417.18576.12732381933688672041@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20260614015923.3BC301F000E9@smtp.kernel.org>
References: <20260613-bpf-ringbuf-fixes-v1-4-e623481cb724@kernel.org> <20260614015923.3BC301F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> does this write to
> consumer_pos safely handle a 32-bit userspace application running on a
> 64-bit kernel?

No. That requires matching counter representations, loads, and stores
across both word sizes.
