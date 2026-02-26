Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51608286405
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 18:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772131025; cv=none; b=mIXxCHFtLh6/o3maLCMchhbe6lRkBFNXqB8Posc/z1RiXeUiCgZp8f4kXxVoGo7l6TEKEYK3leaPUUxobucQhXlqPeOuV6vp+e9MTM9OYBQ7NEXuXiz0rqT/7ayiUz+0DjroKKlgeaTqsPEg++/dy0p4XYX9N7pRjXId6Zw5RTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772131025; c=relaxed/simple;
	bh=GNW7uNFFAA+y9nnKuBtqwzr50WyKcX6RSpKGxOoE9a4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UZu1A0FI0i6Q9g8vdJMzdkZD4TZSezF6igloYSYQb5a0FMM/jSs5DfSV+pA7A1UUDsrc2Prz+orBnNMAwMigNjGW3WW39vnw0qsiUYIEQHsToptnEAVBud3lULO+18irYZmnYjY9tDXOYrfJAXSDVXxqHd0Gp3Iv0G/yKcc9uDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkQi94Ii; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkQi94Ii"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-358d7dcc230so744942a91.0
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 10:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772131019; x=1772735819; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GNW7uNFFAA+y9nnKuBtqwzr50WyKcX6RSpKGxOoE9a4=;
        b=lkQi94IiD5PIzX6lHOWhZoRLMnntR15WgkqSl4Yjx35pu+Evm3heXaTWA4rAMrSIxl
         jeRJg6Vm6T0jIILfUqYtTxm9FoSRxlUNJoh/D4Ms4qESP5FXnd29OyY0hiXjU+68hyeI
         fLy2kZzFJJKx/4FTBfGTDLsbP8f82iQpRkbgR43BAd/CYHpnlItKQLRQofB9PVwMpVLA
         bEx3qtIqXP2nUGnoHKyiLKjzoY6AaZ86a8ndLdzI18Xonv/2lVy9/wHocrl0vBOmPy6B
         1qbWeIFkDXUelQ+EwZadDyZAL4CSKYpyclr30Z2Q8tB9QfIaGXDKwL28bhDtmkbrcUHN
         iRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772131019; x=1772735819;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GNW7uNFFAA+y9nnKuBtqwzr50WyKcX6RSpKGxOoE9a4=;
        b=WjyrpE+1DYuH4cZZHHX9+PlPCEJaURWcxZnl7u4bIckjZEK6KShcMgz3HhPJ0vAUbM
         SxMrTjNOYMnYz/MQ0NklFyC7l9w0ZCZykx2iv0Zyib2czFfIZPRunor5B/NfOG0K2cTA
         cK3Ks1hX/NcaSGiaoumiePYosKzTw2oEz8pAPjqH44LPkU1cchDYQEL+kHBnwgWJGziF
         E/YyzaoOiLtZcqOEm++0IF9GDzJtnhCQWFcCHeQcRDlOBbFunt4GeGTRIkuDKudH4xF+
         npNldcdIfymtyA66hW1p8sJDpicgZFFeUCAYFMWrFtx5VTeEBJEDQbWgEaJoqgoLEyoM
         KzGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWacZ6xwR7xxQiiY8wObzEWLTbvc3ExPVwrTFTTfZJZ0FIbqTPSwlf56K963Ak+AfbWbF8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh95NRiSaSu+Y9efENuXkO8i5eWejtn8LVTfz1Lwd/34Myi4G3
	LjdSe616W9HRxXtMCYs2HWaW78wThDS00tBNTofiR3+uM2zLq6I13oX2
X-Gm-Gg: ATEYQzwFqZ+maKvyBEzOujGm3FUny2OnFBOmF3G4Kksv9opnLlsF++9sAMQgcJesn3/
	J4QeqJlt75PG/oT4QDNzKMbP7Wx8TbPeL9SAMPGpyczzz5Wh+Y2UuKYyjJyFFQRnCS7S2bc1t1s
	Uyd+BCvzv/pWrRQsSMmQbJlRU36KtKjPnBXdzY5wvIgSc8CLa8xhjTyodb7PrUBDHnvGNiLgotq
	qSArqXED2xHLJ1ym9xJso1ui9IAQTgu2Dl6gzkQNzymdY7ewnrWxBg+osKomgAInxCyoMs5loaM
	Ytjm1jidfYNP16vfYNiNlHADPnAFQAZXCzqqC57ohlkpbZVCjquc47RVvcVTatU4dX0WKqrNkce
	22ew0N/7H86bRtpVGaFSGysEcsDe9ccWLk4m98ISB8n8UMrdIDEH/Erys/JpRdTvrYvPJTji6PB
	60CnVg3JCv/gL0GWJEKcDL4YGNfnGiIpzq3ZztS7SteAU3d5jMEc4=
X-Received: by 2002:a17:90b:2496:b0:356:3ba2:122c with SMTP id 98e67ed59e1d1-35965c4982emr93310a91.9.1772131019156;
        Thu, 26 Feb 2026 10:36:59 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3593ddfca77sm2796966a91.17.2026.02.26.10.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 10:36:58 -0800 (PST)
Message-ID: <c0b1fc58e963f204c2947ad0e94c3cc307986475.camel@gmail.com>
Subject: Re: [PATCH bpf v5 2/8] bpf: consolidate sleepable checks in
 check_helper_call()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko
 <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com, Mykyta Yatsenko
 <yatsenko@meta.com>
Date: Thu, 26 Feb 2026 10:36:55 -0800
In-Reply-To: <20260226161500.775715-3-puranjay@kernel.org>
References: <20260226161500.775715-1-puranjay@kernel.org>
	 <20260226161500.775715-3-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-02-26 at 08:14 -0800, Puranjay Mohan wrote:
> check_helper_call() prints the error message for every
> env->cur_state->active* element when calling a sleepable helper.
> Consolidate all of them into a single print statement.
>=20
> The check for env->cur_state->active_locks was not part of the removed
> print statements and will not be triggered with the consolidated print
> as well because it is checked in do_check() before check_helper_call()
> is even reached.
>=20
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> Acked-by: Mykyta Yatsenko <yatsenko@meta.com>

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
