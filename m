Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81BA3845A6
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 19:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786043934; cv=none; b=uMjHtdYqx135CVts9XZplSZmvxTLJYBeSNjQFj0O2HS67YHsEZnHo35B4QWb6yKg6gxJvYXrWoCf0wszW4Rx7gTxYR4cvsdLCkh2tqmaeMM2vtUFF/8OLYVolov7cqGx3m5Csa7NwEnY25CjU+e7qn/3xqTTlWeMu104lJOltKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786043934; c=relaxed/simple;
	bh=8ysPuyYJ5tBSbLOfkMuIjE0BO4otxUtNxK5LppHGtsM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MMu5v2YuJZ3RCxepTzcQSie3IKWfkChxZOBpFRicL5O7QYm4kzO/poTu1atiOlpHitxzHLEmslfzqMj3nowrb9miefxfxmEy2DPNc4ptZls/v4Cpl9j93ogxs1sDjuBpi8RMSz6wVP9/OWKOpxpCiGsxqjjfTePA8up0ngu49PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gutVZu0n; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gutVZu0n"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cca0c5799eso25884455ad.0
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 12:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786043932; x=1786648732; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8ysPuyYJ5tBSbLOfkMuIjE0BO4otxUtNxK5LppHGtsM=;
        b=gutVZu0ngEOz82BMGnZNdCcQtsaCoh4zjfpSbToGEjMYQPfLhUn3yGBCk8T8ySxP73
         ckHA+piXHzyht4N3X75HQ6QKpxrstHegBYlZaTm1+Hd6QrFsHPzC0JWscI5oxCcCSfdW
         GKeih5FG/dPTioN3uqiWyr+jQrmaDMFholdGnQTHzvvYG7USmNbVdIGJQs1P1w2NWLZC
         6VVAVB81V6nW38W6oaZ7qP994cnXh98HMl7t842DARgy+/tnYZeumYK0fdutWOEpU1UM
         r3aJhWMFRiP1nFHKEqB7MPAl98KDTU+dciLmKnH6Fsm+OnCfcyWnh51pitnwKPGXPhLI
         xCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786043932; x=1786648732;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8ysPuyYJ5tBSbLOfkMuIjE0BO4otxUtNxK5LppHGtsM=;
        b=iuIHPNFeynGZwMPrfYx4jib4gdX8ViVpi6mmoiYe4tz0thMiGTDXFvdmtnhG+0sqtg
         XAmPFebpk+Lh4kaR6fqXAIiD69/igXpANsDVlAg1cQv5Ryjy+CsXD9yqo/+BZwig1ZXs
         5RVYOX46NM9jGT7TlK5v/Bp4Sf4dRn4RBQFtRkFuVpQApLJ8AioC3OG6V3/ARnE/8GQQ
         h+3jUxi/Qqw1MzE1+d7T4+VbOtquCj9uNoXg1R+6xvl7bpg46ufsOxEr85qzxg3VFgcV
         3H5MazP6n+CgAN0LeTad2AB8UAOjlJ77sFC20SySlPxP8SuVz68+QHvxH79Jcu7UJnG2
         PV1A==
X-Forwarded-Encrypted: i=1; AHgh+RoIGpl3GIDQ5NEel/qIfe7XAcSKasMwKCqzbAYkhW9MsnCopruwDbXgQXYngq6Ww3chtkc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnl65ReqHbTSQNFDZBhHSD56N+a4SWNhc6+wbwB4eCU/VwrVxN
	R3HhyPvbgsvWtM2AS2r05BtNMZCAfJll7PK3u6xGWZ2zEh07/oyuASTP
X-Gm-Gg: AR+sD12GiuNDWVFmJDzCyqn20xl4C45Zb+w1GEGDfi9M5yve52vFaX7n5pGCPMAMLI6
	nbEhDfGd2xtLdJEKLWpLJtraAnIpk0m5bb7VWgwDpP2tkfJ+pFBGocZnFzjNIKDmGwvnERB+9Cw
	c9KV+vWubAISw0aLGBc/uYcR8a82EKc7bTMR0m1ZftAU7bT2qLO8Nl6U9yiTUydCvloPfB2l+Cp
	pP7vzads5+5fR3sBM6cadfeWvFQONlp9Netqf8qhl/bBPeLjb7HYOuMyyCbfUEXxlIZtqmCRVZc
	8WgAkp5QOWdQwUC6Zb745pSCeRnapUzsVY7bs9jhOJi/2EbXcRsvo7yt/VE1urSffLgLeahb2Hd
	jK7/utgSIThR578IL6HY8wmVXGswTDJtB6tADFZgLIgaX3guwYASP7rpr0qirAeQ1tHokcxotIJ
	C8qkJT1qUn5kUk4RpB+CHQj0T/8Uelf14wE2n8VmD0OSuUA5iU3Xgvg3ny6toWNfDwe1Iqx4NNl
	mdVstNg9/eNz19G
X-Received: by 2002:a17:902:d547:b0:2c9:b8b7:5d1c with SMTP id d9443c01a7336-2d0ca7faee4mr198648165ad.16.1786043932079;
        Thu, 06 Aug 2026 12:18:52 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d12086e598sm1181045ad.33.2026.08.06.12.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 12:18:51 -0700 (PDT)
Message-ID: <be2289b5bc582579976c8cba00719820cf94d76b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 4/6] resolve_btfids: Emit bpf_kfunc and
 bpf_fastcall decl tags
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Date: Thu, 06 Aug 2026 12:18:49 -0700
In-Reply-To: <20260805230648.2354989-5-ihor.solodrai@linux.dev>
References: <20260805230648.2354989-1-ihor.solodrai@linux.dev>
	 <20260805230648.2354989-5-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-08-05 at 16:06 -0700, Ihor Solodrai wrote:
> Emit the bpf_kfunc decl tag for every discovered kfunc, and bpf_fastcall
> for kfuncs flagged KF_FASTCALL. These were previously produced by pahole
> under --btf_features=3Ddecl_tag_kfuncs.
>=20
> resolve_btfids now discovers kfuncs from the BTF ID sets [1] and
> becomes the source of truth for their annotations.
>=20
> Drop decl_tag_kfuncs pahole feature flag from scripts/Makefile.btf
>=20
> [1] https://lore.kernel.org/all/20260722233518.778854-1-ihor.solodrai@lin=
ux.dev/
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
