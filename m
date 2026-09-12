Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B1B353A70
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 22:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789252041; cv=pass; b=eMCDHsg1aGYweZQQAX1KNsRecbBkVFNvN8I54B3nxqcRvtTFS250Skj5IIlZBoN84PyOlbqq0N7/f8ehkANEyoA6MjsUfCn/BSS7eG4eOtjnYo+Mu4NFRnJ7qV/Er+PspH4aVI9Tk6OZoUzWdT97zsWH2VOJsWGg1Br1VhTBWeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789252041; c=relaxed/simple;
	bh=s1NoDAASJu12CTH1pP05uATarRtW42V8k/Pmv15QtlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o7ZsD9SCP2WpPQW0UFpo2ucYsvWF4eEodVcViqdExiU6Vim4SDRrPhrCsSCptdtgrd67mmnCXHLFygtQhIkrzfkMNh+N4Y1QbN+BRei/kHP32ooaC4ATxId+CyX2b2uiz+zY/zslkRcMWR1qd0lACSZpvR1f6TYffXmrciGUaz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5BY09Ek; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5BY09Ek"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c294183384fso343814866b.1
        for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 15:27:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789252038; cv=none;
        d=google.com; s=arc-20260327;
        b=Zz0TLxbRup0uDaKug7NJyrVDr1RFru+1ln9bDpRfd6OBXcdScpClx74H4iZdbfFzMV
         ppZDz8nxkk09Rq/5Eblg4ZvoKk9yHbqw2TipMgA9pVbD8Ld5tlGLKXmdPP0n3fOOOa23
         s9Anf/WdnO14nX++e0JuCsdLityNLMO2Aw9QDNx7sWzkoCQySpoJ9Ml0fmkDRLbPRkCL
         bYK05PFY1cneW7fvfu8MflZPGA6aoUQRXuDJ0LljCGUek9PRXM/hCnm9I0739QL6Y1uU
         0jhOBXW1s02350n4TolO2dAnJkLeS5GKUROdsRB7AK5BGeXaGxGMW+jGUygtPsgm3P91
         04dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=s1NoDAASJu12CTH1pP05uATarRtW42V8k/Pmv15QtlA=;
        fh=kLBwz9jtykQ1ABqs1exrys9uDsJOk7PgtfLwa9xSwmY=;
        b=AnLFmqByLvxLX3LE/5Z8JxKvha1DZgTRNfNWPzKsHUsZbP8lQQynKtryeJ546m5PDd
         WlBjaDCIzAebH0MFbLGNVixqQfe++aqgHiJvg6nb27RTRfx8l/Dez31VSC/oXbyN+j4W
         Y6uf28MmZb1u4JGzApW2SsEFyzJDspZFPBLD7Ac99M9o2QnIFIIAZRyHFukTkQ5CI1L+
         ioVSR6oXfeRx++IePlGtAVzTdeOemzve/pRdqK1Yorogd2yZwE2g01nSFwS+YELFMGrZ
         PnDbdOkRjNwBzrCXpemRPVL/lMkelip5vUyWNI7ZaxWoFkehn2tE/UpbxP5DZWqDa71K
         rPJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789252038; x=1789856838; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s1NoDAASJu12CTH1pP05uATarRtW42V8k/Pmv15QtlA=;
        b=a5BY09Ekq5mJNpcdv0VJkGxoqqfySN6Y24UDsQOTy7yJoyUREL5ZDwbbXG6/742ney
         Q3Rz33g9/8aAxwwAHmVdeFXOvcvsewk3qcUzJ/TO09yJ2eh1xwLwtWLQxtP5xLEXYYUp
         rZUcbysVeJDNNy5SlrUJO97TfJs1XCm9Qex0/Dkbgpnr5jT1xQUnlZ6mmABUYQhN9qi3
         MYmR0MT5qiaK+plTUv9LASDAf//F910l1Dq0jA2qEDB2bzw7fPUfzLCNnZtsAi2vGOvC
         QcyAlWYdwiatbM/VS7Dl+5/9VTdp3RE4EKf8Up0eUiMyRxKaFeXD5et/A/8mHSEmU8Dr
         3i7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789252038; x=1789856838;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=s1NoDAASJu12CTH1pP05uATarRtW42V8k/Pmv15QtlA=;
        b=HRi5hpnp2gVqcaQ5zewuBhUpPQYXp4u6oLjPuHKqiIt1beT6mM9jSHMJ44HF8g4e4b
         l1FeHaDaUw9SW/RZ6bOlo4q+Ft1NgIZVznUunGtwT1DW7RHRIGWU3bT3PHmZwVZl/7GW
         0FSzwWK/8hSYYAsNAZfXz+BZjV768cOzNHrQUtZamAnu3gCQl1vN9/Rqy1ye7swfTi2Y
         RQ/ZH5A6VcXQqCS35+25lixUw6aB+O1g+b5I4FVmajoldyYmSLsZ+6+ex/SfJsa96Agy
         96gDkClkUkz4C4x8dg5vMhDhh7oBDp7GmeRI2VpSUC38HKWcjwVDcXDLts64OiBLyz3A
         Cx2A==
X-Gm-Message-State: AFuF++mDUPvdxlAKiM4bvsNzdArn1Yv8Q8+HA5S3jSAV3YFYhiCrbSUY
	WUSlj4zNTfy5zyFHbDzkQivDljuZRj63+xr3SA5NqQsICnueBvvdIfEZGRPOcK13sFw079EXp2h
	0UPFkk4Y4LTjjFXOBCLisDXA52vmkR2fyHIpA
X-Gm-Gg: AYBFou3Rlyho67Bfinu/KF0D/z4EGOlkRHsbxkVH0Qb5xdqAaEd0eNgLRULGSKb6Ugm
	JBzs5DfOFrq4/Mg5ZANgpzwTbUVBTVxk//G1rccG39qrBXwi48Bb4d67y7tAnyh2Ex5FOi+/btq
	VkmHRu0ho9NstX6wBaYBAHyOWgDtGM6IWkP+YhvSe9V3snFreXCISgJf3OaN1P1kA1yotNiZW/A
	VGsXHfzxJiojjRA2FbIgmfwHeldC7XE4n2KMCsE2TN+VcCHpApjl3fvCQKRobKMcfqTexhDEui1
	lEtD/E75NrddoKpvJjkju07ahQhJLpT4xBUiID7v8rlZGRFZ0zGePg==
X-Received: by 2002:a17:907:3f15:b0:c26:19e3:e98d with SMTP id
 a640c23a62f3a-c29667b44bemr515837966b.45.1789252037884; Sat, 12 Sep 2026
 15:27:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731002950.179573-1-main.kalliope@gmail.com>
In-Reply-To: <20260731002950.179573-1-main.kalliope@gmail.com>
From: Nicholas Dudar <main.kalliope@gmail.com>
Date: Sat, 12 Sep 2026 18:27:06 -0400
X-Gm-Features: AcwNN1UqgW-Opt4xQd9BdYy2ScqYUvtjx3sk3AD9u1sWDpZjldnDls8e5e9Ytzo
Message-ID: <CAJZwKkgrEjkKAHVcGxvnAGm0iJ+5+g+AzyV6GKtWoirbUzi20A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf, x86: Add support for BPF_SDIV and
 BPF_SMOD in the i386 JIT
To: bpf@vger.kernel.org, udknight@gmail.com, x86@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	ihor.solodrai@linux.dev, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org, 
	visitorckw@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi,

Following up on this patch. Patchwork marks it as "handled-elsewhere",
but doesn't list a commit. Is it queued in another tree, or is anything
further needed for bpf-next?

Thanks,
Nicholas
