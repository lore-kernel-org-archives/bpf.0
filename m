Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629AD3B14C4
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 17:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791479871; cv=none; b=RL87c559hTqaNWtRHkKtsz39OtuORA9ASf10cLKJBebtNrNwl505/uDrQPmmTYRrSyT98O5Rsw9Gst4igV/h9CKyUogooCabZ81U4LYJXZBO75X64IjCxr1fojSbZUjE7rBawqZOQtUYJ1BeqzqSupOaJXEDaDgEiqEFFDgD9uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791479871; c=relaxed/simple;
	bh=18ppHiNkWdrfkvUG18hcUeZYoOypIbeiVdUwByTYuvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SkQV2R4GxOnohpnqkpQJx1TlHxFfRRRK9Mcy7boLBLl+0e0uZsYmlYevfW5gApCpkZ/OPM4DY0NK1Do2quI8RVDGiQSzuCwbagRudUIDt0XUh6d0s0WVZrpzEqns/YoYR41gLa+d5NN/Qsdw33oLkMCixuj/fCT2jxs3vcBAIa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cj3G4jzL; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cj3G4jzL"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3a1981228f8so26028451fa.1
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 10:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791479868; x=1792084668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mGNnZ3lh/82Ool9Pw0Js9vegW0LbnM2AKPqkWKOhgzw=;
        b=Cj3G4jzLX1rpCXwELRTYJq1h3vM5Z4PEiFIxMPiUe7dxvg+toXJIDMZGpoGGkXEJw3
         TfcZ9gPi+zS7o35M5VJpZCPQ8hnYBS9/o2iDy4EL69iFCJ4k07Yn4q7k5YoLnqsc/8Nk
         GEY7jPUMWlsL2NIVIb+YxQ5xa94tgg3Ykwosxi7puQdZiCPi8tDOvbFi1hbxAU1Mzrcu
         CJ4f5o2Mfo6P4uVA2ewG3CEmitXUMmFRbJdxkE+5wvVFp0yC0V7AqeTPjv/D/w/WJabq
         BGED12ih2Y3E67VHO1tSthXhGyVSvJN/6c9QzQkrbL9WqLVYjk+c2+iLibUlMjeqkmWb
         qgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791479868; x=1792084668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mGNnZ3lh/82Ool9Pw0Js9vegW0LbnM2AKPqkWKOhgzw=;
        b=lq1wRTT3PUHI20ykSMUotQg/xhFjtFI+UMuFLhvgXZFA5L7CrXboNYN6ZBKpAT4NGc
         HAejvAl5Qgk/xTNdMl2kG+MUgFUA1nbuASiK8Tqak5rHzUQsz9+Jvyp7sEEoiIXxJJWI
         bQEnQJFX1BrhTiGeyRGYzRWRFfywW31vxe5eqPXvdVRyK6uyt2cMvQ4ljMIJu+dOum5e
         ETa42JKpShYNrl5/5aD+oRHIWzMYwfszXMeBMAta+JDzHtCaiLe/GYjaa0Q+z8bcFAS5
         0wouTVBPwGzUL+JPu0sujx1OMUy0av/LHdp1kKw3N7MVNKoYa2i0oEuMoNv+4VgzTF/3
         mQ9g==
X-Forwarded-Encrypted: i=1; AKwUvBz72Xsh+m/yrLeSVjyxKGZONO0FjP19QgnSNibltVLMBp3ApdXuf34/jXYqV2iLD8bEyH4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKp/GpaLDBJlMEA4zjSIB23f55rNsvjfEm+fzh74FwWx0Iqg3ep
	jj3dxSFThA5iZ2SIu8vWuDIHPockeLeNmuC0VDrNEIJbToeXbZSp+adaW26Jspb6lKI=
X-Gm-Gg: AYBFou2NrOwHZrhTVA1pvJgkODt8G0Axb9D+G7Kazv6GkQlcmkETjW2WLMDP+Kvv5D6
	fKl1icYEmdtGbhpHLwBkxwR6mvYCIB9eo9WVkyR7LmLSVubt30VYlDGc6fIvFcy0vcgjuOqOIWZ
	vB69AigKA6u7Bwjn7KUNLPRqatmPhO8hVyR/+wCADK+pKRoKXf0SQwGfIqbweiIJPwaYdUikIXo
	lwfZxp8GV2nMpgI4y65/R1rAqbdb1tGn9tghk9wVcO4FX/G1XcAebxtZ8UiYjWR1cCnTTqAsPol
	FH+QD9vdUw7WQUqZbnYeDJbNf/yMOTZvAd6Jq/aw1bNLc5eB1DK1/2bkAWxdsDRD1BK3CWvmqOH
	/mWWitVCSchEsIXqcig060Yo4vf8E1CSNnRrGDFedbTr1z5H5Ows40BCcLKG06t2NH2PNNax/pv
	9YltwLYyeUJ+ssZGjhRE6jCiqT9iBBqwdybNOrqqHOftDqRvYxT5mrrPa0b5SD4ridnOxZtrn8C
	Icx7xiy2sfN/AQ4N+xV3g7dstar/BVzZXLQCYuG3IODXJyQyCfZ
X-Received: by 2002:a05:651c:2106:b0:3a6:47b8:c8a4 with SMTP id 38308e7fff4ca-3a9a2d6a739mr15029421fa.29.1791479868310;
        Thu, 08 Oct 2026 10:17:48 -0700 (PDT)
Received: from localhost.localdomain (95-24-167-79.broadband.corbina.ru. [95.24.167.79])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a9c13e6530sm1193631fa.9.2026.10.08.10.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 10:17:47 -0700 (PDT)
From: Maxim Skokov <skokovmaksimevg@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: Maxim Skokov <skokovmaksimevg@gmail.com>,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Cover test_run csum validation after bpf_skb_change_tail()
Date: Thu,  8 Oct 2026 20:17:37 +0300
Message-ID: <20261008171740.47837-1-skokovmaksimevg@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-163281@kernel.org>
References: <sashiko-outbox-163281@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Oct 07, 2026 at 06:18 PM +0000, sashiko-bot@kernel.org wrote:
>> +	/* Drops CHECKSUM_COMPLETE. skb->csum still covers the trimmed bytes,
>> +	 * which hold the non-zero tcp.urg_ptr of pkt_v4, so it no longer
>> +	 * matches the packet.
>> +	 */
>
> This isn't a bug, but does this multi-line comment follow the preferred BPF
> subsystem style? The global guidelines mandate that multi-line comments in BPF
> files should have the opening '/*' on its own line, with the comment text
> starting on the next line.

Right, will move the opening /* to its own line in v2, for both comments
here and for the one in patch 1.
