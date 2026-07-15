Received: from mail-ed2-f5.google.com (mail-ed2-f5.google.com [74.125.228.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C087443E2B
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 18:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784139000; cv=none; b=fUypZb7AdAMDf8VBCZX27lL8mgwCkIMFcfZlzEMx0rk8+OeEhXAaHixGq0aEES+mBEUFt+JKdFYew3EvmQSSYZbilbwHvsFb05GTZxPxQfXgPBwWpni4FymJV1xwuv85UmlijgWOAuL31pCqjzv132J2PhbVRQxI9Vy5S4toEiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784139000; c=relaxed/simple;
	bh=wFdPoMUXQm/WB4ZSQLwu+3wH3z6IFqAhDlGmGjFR1P0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=oRpA/pEK1Vu8+EEa5Q6qQD5aaX3gn6IzJNSvA05Lwwc3UUQReMCUF/WtENwzUI6pbovePdM4xJAbkj0/1Fq7cjna5Gkyp1kRUynNHPv4WEjVvtMKho15auWb05rovximRcSdPAgwv3WQJYB7rwHHuJ16aEl8P/pglrmBqPshLaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TujQuPEI; arc=none smtp.client-ip=74.125.228.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TujQuPEI"
Received: by mail-ed2-f5.google.com with SMTP id 4fb4d7f45d1cf-69c566c2cc7so2374315a12.1
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 11:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784138997; x=1784743797; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wFdPoMUXQm/WB4ZSQLwu+3wH3z6IFqAhDlGmGjFR1P0=;
        b=TujQuPEI1260m65Ft6Z66eDYKpOAw2+kAdXbOr/O+on8xQCOzcTi4jrKiz65nA26Dv
         OePVJzDTHxE/A0Mgiv+jgxPviJnrCUFZRrPDIkavNSxr1y0gpx1Hzv6+gZUHBQgoyB1h
         J9VHI8wpDX/liEYu0IkAXOZZBkOOxT0u4LmukC+NcqaYjBGghKhn5vyVoaGiiMPyNFjx
         /yj6p8GrBU3rWoh+pf4P8iKW41Acy3NUuBqgngR52dYaR882koLLzfWrPn5pwdWesBhQ
         qKpNAeMYJb3ZOXa9eAmC+SAmjRj/omjRSjJsRBrt3c3vu4FTeg+XHRkKyrfAFLBtrfJR
         DiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784138997; x=1784743797;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wFdPoMUXQm/WB4ZSQLwu+3wH3z6IFqAhDlGmGjFR1P0=;
        b=P9rQvJMRYN+LbNs3VLCuYPu45pREB9TjG3i/B1URNtAkeZfr3S54GXZWACJGkowMld
         +sw3w4Qs1qoIsT5xnfryAQ8ufNC5gQcHhruGQ4WoFmhuoyPNskrEqHSLXxNKgw1vF088
         ilZU8eZHw5fFPKWtgb1x4z4wrPAaE23nGHCfJDaFH8qvQwkoQMT3IiYsBok+rZy159GE
         7BOXt2JQx4oThYJ7I3SNxeXh6HDOMlRq1245t4Th+/MQ/uxXdoT77Xew5Wz17SL0OIop
         QH/2YIpn0VHiciaDLMPrJMO3uwM32HFuYSmXPVGQxoWtVi97ndxflCcSn4YaIBjOmv9b
         CwOA==
X-Forwarded-Encrypted: i=1; AHgh+RqSHT/E1em4fvAOBokBU++RbWAWLSJaOVNGcOkI+zCu8EgczEpb9VBJ7uL3KzIfADapIXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYsxs2v1g3T5UEp23cViJbCsl7pTcffDMyfeX84XfaJuSD2Ps9
	AiDFbMD0chHcl7jwaK7aAgGS48CAQVd7HK1YpD81VFu/68kpADMlLeBW
X-Gm-Gg: AfdE7clWvrHp4X11HjrCd7O16qkLVUgEKx0O4B5CMvYuq0tzwN6C5UCwfhQ6p+I5jlB
	6DVHw4yi8oW8djsyap5bglsr8eKm1dIOh1dcxApXWXDiWOD4oD1RCT0mZZeJcKe5Qc3el81wbs2
	zDcmg30/q8jlQoptNDfsfIB+oy/vlkzw1Z8ykYutdVerRjREcl2cUrHpZ0Dydzd+Z8nEN7H8m5L
	46KeggyXGE6vHhL8d2qDUqH+oj8thVqNju0hAR+vckXbAgk38HS1lP3PFqeMqoMhUkJ2iFN1qx7
	b92GjUyOVe9E/E62drg1hV1sdIsZYQtX5m2/msfl9mn9tFzMhReDfyfGOyreuoTJDk3tsm+J2JW
	3MtWuZ6a6/Hl8rF8RhVk5v2iHkFA3tUlDmQWrSnQ3yPtsVjXcTuXYol9E5uTBglgE2T0SAvbGKm
	4cFKnCfDEuDSUkJXxD7FYE/eS5tev3xliZm4THXwtSPeHKVwdu50AkKU5NAsX777CrrWY+hsYNa
	b7XDs3TahtKcZRKLRcqJ22ecd0sSJypbbDLx/niFypmso6f3sjaU6o=
X-Received: by 2002:a05:6402:551b:b0:69c:2ffe:114a with SMTP id 4fb4d7f45d1cf-69cd6f15bfamr4629465a12.39.1784138997243;
        Wed, 15 Jul 2026 11:09:57 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69cd2922f9esm3441879a12.17.2026.07.15.11.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 11:09:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Jul 2026 20:09:56 +0200
Message-Id: <DJZCHNTTXDXY.2SETI3I98235S@gmail.com>
Cc: <alexei.starovoitov@gmail.com>, <andrii@kernel.org>,
 <daniel@iogearbox.net>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v1 2/2] bpf: Zero kfunc arg meta before error
 paths can read it
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Amery Hung" <ameryhung@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260715172127.2416388-1-ameryhung@gmail.com>
 <20260715172127.2416388-3-ameryhung@gmail.com>
In-Reply-To: <20260715172127.2416388-3-ameryhung@gmail.com>

On Wed Jul 15, 2026 at 7:21 PM CEST, Amery Hung wrote:
> check_kfunc_call() reads meta.func_name when bpf_fetch_kfunc_arg_meta()
> returns -EACCES, but that error can come from fetch_kfunc_meta() (e.g.
> fd_array_get_btf() rejecting BTF binding for a signed program) before
> meta is memset(), leaving it uninitialized and risking a garbage deref
> in verbose().
>
> Move the memset() to the start of bpf_fetch_kfunc_arg_meta() so meta is
> zeroed on every error return. The intended "not allowed" -EACCES path
> still sets func_name first, so its message is unchanged.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
