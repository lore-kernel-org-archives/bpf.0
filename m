Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DBD3BFAE8
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 03:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788666341; cv=none; b=nc5G82LRfFnNAxAPD/NtKGyhU4TgwbmXyhyXszodmCLYSo/M8rNhLLLnKPfZN+bZjHDM+bA4AK2HpWEbsGIrEpnbYJvFdmwKld3RqExhRzlhkgLYFOzx5iqb832ZkcLgXmebDfjlgNv5JfnS+5ETIF8716mLxuxjwi3qhKTLb5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788666341; c=relaxed/simple;
	bh=g1hhV7cYBnRp4AT5fxdPFCy6UwYrXvCZZJXF1RQi8xE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RW88wEJDvdbMVSp39/BPeTyq8DviABZe1Mi3iz/7kTyzsEba4NF1SaM14Oc28CAhwYugv+xUBzXsWJtqqxO9AC/dFohvSnPIOOjwWinXL/sWEM5cJQCcoHaJzNcdpHnEVQABLFMYj0SGyLfsE11Y0XGmPysZy+9ZDxYl6UVZtOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMASzZ/l; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMASzZ/l"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d53197d8b5so20836895ad.3
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 20:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788666340; x=1789271140; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+daPWdP8ohkCa2nyV8OA3WHj3sZMx69S7EV2qJl2bQw=;
        b=nMASzZ/lykZhXEZSkfPpHKyd/c/aXiDinmwNXC8s8QTV4KV4KezzwuBiAyRp/cjwId
         o4QEOo2PCpUmoAk3k2nDcAoQOImeFfn4Rvk2syYBqP5a1hsxNOMu7NexoQIaMn7yt5Dt
         5WpOziKyeFlV6bsRhFA57f1J41/2QzMugMhgOJ57JgVZam/wxT1Cc33ymo4Rg9SDlu/P
         6hHacGLNd7+WP2Dolq77O33bULXs9X7aXIMHOxRLjO7maCOLoOIojsxDjgpTa4C7EhCx
         lbr3iVZsR7IVibqeBlrJtrSd1xm/WiuGGGZAUM7324rPU9dwcw+c5evghsp+RFYPB4bO
         /zyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788666340; x=1789271140;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+daPWdP8ohkCa2nyV8OA3WHj3sZMx69S7EV2qJl2bQw=;
        b=KLOaGldGuCwIMQxn5FlPXMIQF/wELkL5pv5mzUJ72GBahU4nR16ye6aQYUx3l2MW1R
         LXodwF1d3qMlejC6N+8ZfEpAHQ+Kk4+/HllCBlXazquF0tdc/P7CQkuGU+jHK6/VVA8j
         Ey0iaV2kHiJXiN9S1IqZZlzviJIZ6iMb5/fT/7tqBynQd/jUBG3AR3IX6y7kjxqWfkkg
         sjrfkzA+qDgI49XMe9pDSBoJURCiOIz51k6+fRmiDNm5CtUAzuK9U1UKRdrLmsAOtSI5
         Dhoyj8SW8PMs9ZDGPrkASS8Y1veovH8kwSPPA+/oW8zb8LJo+lg5UVrS9OQS7ChEai4B
         NY8g==
X-Forwarded-Encrypted: i=1; AKwUvBwheRjIyonjTHQQirgSIekyR+U8zT0AwYiKmVGRYhuxLIwuy/5c5tfPnZTEMkp/gJxhxz4=@vger.kernel.org
X-Gm-Message-State: AFuF++kiL1jiF0k6DhC84+HWIt7vec3dBPExgvVeCXRyfRbNDt/L+sQO
	yxdvm8Gky4wO+CTvoC/6aUynNmiMX2QU4PgaLLIYI/3WJ/wkpEn39Dq4
X-Gm-Gg: AYBFou3I5xN/R+duVot943nbTe8TE9F4xlxGh1PHBqfI9eiGp96Bp0pQ8cn4dbytPdP
	wgpj96h8Kt3reVSSg+YLHhHiHpuGbbWWIgqI1W1/OXnbSsELwc+3GzcEcq70hbzaH8GnXHdhE7Q
	tAf42x055m4zi+5qXso7psBiBbwHQspuMx6VDp/n8J0eNfdOIumnrNC4XQC3S0cBXodKZwisHO3
	rjeZCkb35SqexXjn52pzSnMswdCGTpOElKTuNq2EWFFIVdSatxIpZDS6cjpk4P8sogbuQg2Hvm7
	JPH9gGbLtD1bBU5CJpV3JOUpUGesns/pcweRbcGJx6LCUKv4fEF77DrPEkN7YGQgbyl1V5LJb4J
	rFMdBEZK41WgLrdXj8FKfLzkexQj5gUVd8QTkkqmiBCpRIa+iJBFv0Na2ZLMsASA8jOgwWcRtgN
	QLbrijBK7Hdhzv2en0mUt00e4RmNkkvw+G61vgC8Ol6FDiY8Usg3HGNyOahufZI9uO4AHu4yleN
	O71dibboeJWtA0nn/1wRX9VHJE=
X-Received: by 2002:a17:903:9cf:b0:2d8:d4d1:313a with SMTP id d9443c01a7336-2db12634535mr249115595ad.17.1788666339975;
        Sat, 05 Sep 2026 20:45:39 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db2c60f687sm13929195ad.58.2026.09.05.20.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 20:45:39 -0700 (PDT)
Message-ID: <db3ff123cffcc72d735340d4bbcefa2b5184de09.camel@gmail.com>
Subject: Re: [PATCH bpf v1 2/2] selftests/bpf: Test pointer bpf_loop
 iteration count rejection
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Sat, 05 Sep 2026 20:45:35 -0700
In-Reply-To: <20260905014735.1452988-3-memxor@gmail.com>
References: <20260905014735.1452988-1-memxor@gmail.com>
	 <20260905014735.1452988-3-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-09-05 at 03:47 +0200, Kumar Kartikeya Dwivedi wrote:
> Add a verifier test that leaves the raw tracepoint context pointer in R1
> when calling bpf_loop(). This is the smallest trigger for the incorrect
> precision backtracking: it reuses an existing callback and needs no maps =
or
> userspace setup.
>=20
> Expect an ordinary scalar-type rejection. Without the verifier fix, the
> test instead reaches precision backtracking and reports an internal
> "backtracking misuse" error.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...

> @@ -168,6 +168,23 @@ static int iter_limit_cb(__u32 idx, struct num_conte=
xt *ctx)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +SEC("?raw_tp")
> +__failure __msg("R1 type=3Dctx expected=3Dscalar")

I switched to matching new and shiny error messages (:

...
