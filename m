Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AB4483815
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 18:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790273219; cv=none; b=AM9mH44sptkLYJXzWXjB8dOPZD0jjiA8EXDUO7OdGfuIXJ8KuMfuvE6u0QjUaMdTIHs+awpXXgCYdvqLTcsj1weWjayXRg+RV7/lcy6+e2iERFBNEOIaC4KIneWQUes6+vKzD31SGuAyqpSWz1T/3amlUDpTCtaStJMXfmj/lao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790273219; c=relaxed/simple;
	bh=Q4UOovSgXSW6cU2eIihltljGhGMu4QxkVcEs5c4rx+Y=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=FeA0dIPdVsZ3FJzsUW9+oQMi98niQdrG17Yv/3HgXTIle63g25edaiQP26d7D9/0toz7OoDSGbLmnzzCUeKgoLvR6ksKiPJ/s1ez5MV7p5KQsFiRh7GUblI1KpWRUFVQW5ZBMTtZZDD69rIPYvP/ld4yLdi/yRfK+RXWFzBEiEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WasMTPi7; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WasMTPi7"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-3a02902dce2so138081a91.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 11:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790273217; x=1790878017; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q4UOovSgXSW6cU2eIihltljGhGMu4QxkVcEs5c4rx+Y=;
        b=WasMTPi7IQ7Pl3NNkPbqCtdTPqCsg14sXoTVnTzkFoCzKuhgMLQ08UqQUODw8T+hxu
         2giRySLcipe1caFQQ3fv3IqvZCPNi+KGsF6t+WtloY0vby5Nva7e5tw0B4Yv7Up1oE+a
         bCAio4JcfAoxwSLucYlBqFo54j3m89OtpJaiRAhwIFiao1A9+99vBKgi4IJxchQiSSf0
         yOWytBIt9+oUriQFRJr6lFYxNd637EGI2DCI+bw7xvICIUUkuVUVzELly9CgvbgGbaMw
         hwQnbdlx1qbgs0NqeieYT+HCDjPWiUsfyM2/Tep8QJtTP0+zTL1Y8uY9QH+/q7bMpnvG
         0JZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790273217; x=1790878017;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q4UOovSgXSW6cU2eIihltljGhGMu4QxkVcEs5c4rx+Y=;
        b=d/wX85m/9gktezihJIon015LGFbtskR9KJcFVf8I3hzOfNyLcvIvy9uXfe7wFBm79g
         gqC5BMe0mHGRXSMy84XhoW84RYyUMr66+WC1Fq1LLdO2n5NZzV6qa13Gm+Sr4YFIDyw1
         D0r7LLJgvhDJxcSkjiwWz9QC61ZRgmSdBPKyhSn6Q6/fSSnrOADKMrJKn/ger45L3tBj
         /aCRwjqTnM541fCOUTGiZ73fGM81nyNQfUUiYqshYZphD57RGv56OMCTx1Kwv5tflrdP
         HWLfUnQG/p4tzSSJ55M3ii9CCjzkojO28f/pkmcJfAUuvcNLlvrKB1EV+g3eHP3mjK+L
         2CMA==
X-Forwarded-Encrypted: i=1; AKwUvByv9c0oPlzoWicRscZzvLt/K0wTm6UJcTjOr8ogeaTyTARHO62JxpSNDkmi1CbLDJjU8K4=@vger.kernel.org
X-Gm-Message-State: AFuF++mO+iTFhzZjywTN6nu8Mu+8CU//T2iXYixnfnwusOSxdAaGFicZ
	YMUkvVeAh4Hoc+ukhcNKy1e/sD9ChlmZ4/J8v4Q3U3ahPUOuYGbJ9Gd4
X-Gm-Gg: AYBFou0eevhAXii3koMBuO6LhrMyuo+6zX89tEhxuP17uxdCHbhJtZhL5t64ExOCunS
	GoEsW6TK2pTwz1Okyt3GRUgx6jSj1fziWHf3q8KltkiYMv/A0UVAuUJSs5W/UlKpm5juleVg+jt
	BxzgDn13jyUGPZcrXijRN612QDNdhD2CYXd1x6nIgtuy9bDw2U+IjgR1TiX45PvKq61AakCoa0P
	xrE5so6ayGE/u1Ay8pJvkFUA4MmQmdJ0F9K/uayiauV9X8Ym/m+n6k1Jmn+aOUMsNEz/dg38DUg
	4p4T+sSzcFLezuEqlABX7A3bjxxD6eMD73v6W16oMIS62ElFizvF3cTeatc0XBLH34a5VxaPtkd
	YE/5ZfqhAHBe9sz25anWih/Irhkn/WJr7Mfwo4v7b1R4EZAPmmKb+GuRQxssvYJAa5gi/vOWoZi
	Hnmh5rrscxaBsf9IXe6IskBj4ydXpLCfJtqxgM8GsP8fU5qMWiJyvIjtIA8UOrDr82S9GOfNOIg
	ezTvozPPvSzeAX4FvD5l3Imtjd54y/ogewwJqckyKOUuUNCeNwKK/QOzXfb12GeCmiStteFZ7+2
	3fo=
X-Received: by 2002:a17:90b:4a89:b0:3a0:9640:802c with SMTP id 98e67ed59e1d1-3a098ad5cecmr2893474a91.3.1790273217268;
        Thu, 24 Sep 2026 11:06:57 -0700 (PDT)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0976ca5f9sm6273359a91.14.2026.09.24.11.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 11:06:56 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 18:06:56 +0000
Message-Id: <DLNQW1IRYK94.1DP0M5VKZSY32@gmail.com>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Tejun Heo" <tj@kernel.org>,
 <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v4 08/18] bpf: Grow the verifier id scratch on
 demand
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>
In-Reply-To: <20260924165740.2146806-9-memxor@gmail.com>
References: <20260924165740.2146806-1-memxor@gmail.com> <20260924165740.2146806-9-memxor@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Sep 24, 2026 at 06:57 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> state can possibly hold: 1312 entries, 10 KiB, for 512-byte frames, and
> four times that once frames may reach 2 KiB, which pushes the env
> allocation from 64 KiB to 128 KiB for every program verified. States
> compare a few dozen ids in practice.

env is allocated once per prog load.
can we keep the arrays fixed and let env grow by 24K ?
Then there is no need for bpf_id_scratch_reserve(), for -ENOMEM
out of release_reference() and unmark_stack_slots_iter(), and for
'complete' in bpf_clear_singular_ids().

if you agree pls send a follow up.
