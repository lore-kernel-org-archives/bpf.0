Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CA136404E
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 19:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779307177; cv=none; b=KINWfl4MzWhzmVAv3hvjb3XdpwksIlCXvsNKnW2YM7vC9B+6DHaFCdHcnDO+rDh9s5Z3NcLxzdu1Ztet+B4GGOkOGzva5i9+GSSvT/f5LbiUS1oIXZJsiYKHS09ijaUHjwxBQJNpbDaVKRhRi1YtG1LMwFRElwKJhAcyAfaF260=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779307177; c=relaxed/simple;
	bh=MRmQ1iSmQtrxEOe6qrbfT4Od4upA5Lzv945qF12PYNo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KleKrlp0Luo4UwU0uebEbFoi4yVrjzw5nSeXZk98C5fWj0R+SvR0kTYotD0pKhhtc/TTLN+4CD3LT0asFbcZ5cLffWn8FOha3qjJt5z1EqZntUPrzcr30iyJns6fYEhXM3ldtt4S6wR6/vE3yTdLwYanB1Oh2nBdJIYrIdVoNzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWJX3o4t; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWJX3o4t"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82748257f5fso4055424b3a.1
        for <bpf@vger.kernel.org>; Wed, 20 May 2026 12:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779307169; x=1779911969; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VWvyBk6QerGzJy4Wnf433/QgHFYbGwPbSdseO5TT7EE=;
        b=OWJX3o4t35fe8jY3gynmCbxoX1KOwQrJbUEB/b7ABu7yUxysexGXxkX7OFHjvYiz7X
         nbYT+v9B+nlnZrxvuo085YoS1KsUHenDrnvvLEylWMlWnJrN+dyM1mG8EkePljDtCaom
         NTawTotCdQ+NuuVvU8XM3JEq8mhlPuT9F+x46cK73/eK86vrJWcxmbC2Dw2iRmSD+H1R
         sbom2EW/FZk/DcUb9X8bKB1y11MY/Xi/foOhPq5NiURnR2vue9QCwfv+epdCGlLryly0
         deCCRsTUA/SKC1zMzuonpD8hw5BzQCGlMjK8u1laGVOfqTAT0PuBmBmQGbe2v6n2m50O
         snww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779307169; x=1779911969;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VWvyBk6QerGzJy4Wnf433/QgHFYbGwPbSdseO5TT7EE=;
        b=DL8lH4FlAbuve9DwOnS/mZW5MwycIeSGw3KcDVjTFi5diFm1WSj1k5UNYIyqa99iqb
         6OI5aG5CLYw9TUaELXRGTySdFQxqOeqHPBLSgUET1TGrEmcjsXjjTlH/qIeWcTZVYgH8
         qVokUJoQjjey53twAfE2IXEtH9ghjjYavjvpJrSr8GUGcw0Xvxsmg5qOoB1hn/ILJH6W
         6AWsSGbvVZRe3BbfmN2tYFOZ9rMp+C1LxwztwHvniNWPGtnWaFB/PGs5HGms3+h89/D9
         Au+3vKNkKBECcP3hzTnyJtxMhf6mNE5ffYiu+eSWeU0c/SH4UjvSE5qNsjyTxANOn14F
         vnSA==
X-Forwarded-Encrypted: i=1; AFNElJ8F0Ir2q1IY8kMeQ2UaIF/jyhC8KC8C4AmGIC0syqDUi85zwYixq1aIuC6Yk+RxdiIAAK0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+mUnqU/A3jpq5lKL9qTeussRS5oplr5glfA9QdUnKS2bIF21Z
	Hq/tdO4NGBeg17WQz3erxEen1xznG90T6tq/7qE88BW28qZt9nzPeaid
X-Gm-Gg: Acq92OFtsrNILNeEOkLr0kFX/PMbBPy457WO0d3i4QhtKwsxvYEcDdYUyfEt0iKXF2F
	OtF/6y7o/kt1k0sN/ZurZr/ervwi1fD6/xdZhCV3QHOL3prA3mY3zpOCDhdvHZ2GuPw9m7pz28D
	ipV+LxelRx2IQhT2daXyCFVLrqC/0xaTvrvPpXzcRVmXLV5T7ipcT8q06AyYwXp0cm6SU7Po7Oy
	Y8qUeN5wiZAsKl3ogB0eYsjdyMfK1my0Cis0krBzyNHZNyfvTLVBwZQjaftbdJnC6FrABH3RsyO
	5GYKlExFxr9S1ELNY+CaqZNHvDL6QuvbNKhevYLMGRH/MueTzvkpvP4PIeIsg5HNoOkfKMefg/h
	yq1O6/9NdfEgMp9gX+mmAXeHYcFv4W7QH45oET+ffK2lYdVhTnM2sQb+ALXw6M36LksgVXi4hsN
	1pBrYFXcJwxrv24LIoaMmPB2LjD8WSILXDJ8lNnHZuJd4dLyvwINk2
X-Received: by 2002:a05:6a00:3d55:b0:829:8083:472b with SMTP id d2e1a72fcca58-841486618c9mr633785b3a.4.1779307169295;
        Wed, 20 May 2026 12:59:29 -0700 (PDT)
Received: from [192.168.0.161] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f196660easm21503813b3a.11.2026.05.20.12.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 12:59:28 -0700 (PDT)
Message-ID: <fa15610bc8ffbd41d418bfe61b2e647d8fb51489.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 10/14] bpf: Fix dynptr ref counting to scan
 all call frames
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Date: Wed, 20 May 2026 12:59:26 -0700
In-Reply-To: <20260519181314.2731658-11-ameryhung@gmail.com>
References: <20260519181314.2731658-1-ameryhung@gmail.com>
	 <20260519181314.2731658-11-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-05-19 at 11:13 -0700, Amery Hung wrote:
> When checking whether a referenced dynptr can be overwritten,
> destroy_if_dynptr_stack_slot only counted sibling dynptrs in the
> current call frame. If a clone sharing the same virtual ref parent
> existed in a different frame (e.g., passed to a subprog), it would
> not be counted, causing the verifier to incorrectly reject the
> overwrite with "cannot overwrite referenced dynptr".
>=20
> Fix by extracting the counting into dynptr_ref_cnt() which uses
> bpf_for_each_reg_in_vstate_mask() to scan dynptr stack slots across
> all call frames.
>=20
> Fixes: 017f5c4ef73c ("bpf: Allow overwriting referenced dynptr when refcn=
t > 1")
> Reported-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> diff --git a/tools/testing/selftests/bpf/progs/wakeup_source_fail.c b/too=
ls/testing/selftests/bpf/progs/wakeup_source_fail.c
> index b8bbb61d4d4e..d4d0f1610853 100644
> --- a/tools/testing/selftests/bpf/progs/wakeup_source_fail.c
> +++ b/tools/testing/selftests/bpf/progs/wakeup_source_fail.c
> @@ -42,7 +42,7 @@ int wakeup_source_access_lock_fields(void *ctx)
> =C2=A0}
> =C2=A0
> =C2=A0SEC("syscall")
> -__failure __msg("type=3Dscalar expected=3Dfp")
> +__failure __msg("release kfunc bpf_wakeup_sources_read_unlock expects re=
ferenced PTR_TO_BTF_ID passed to R1")

Nit: this change seem unrelated.

> =C2=A0int wakeup_source_unlock_no_lock(void *ctx)
> =C2=A0{
> =C2=A0	struct bpf_ws_lock *lock =3D (void *)0x1;
