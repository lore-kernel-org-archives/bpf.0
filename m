Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122A11CAA6C
	for <bpf@vger.kernel.org>; Sat,  7 Mar 2026 01:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772847437; cv=none; b=ObSpshLB2rMxuchI1mXpSQ03t38+wqakw17jFX3EUYmkIVC8K1elxLoav68jow0AQP82Biq/D4Fa297FXG6VaGodrS6liv+uJbv0FzZfqOP+/25rNoDujMGzDBTtNiI/e1sYREg7W1AgFVNHJNwC8spzPhvUiSWCkme20GH4eX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772847437; c=relaxed/simple;
	bh=HIChEXukZcliW1jSUM/qhSjhsUiqy7ApYkMI/wPCXDs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e8KVF4WSLWxtbc6rdlQGH1raB26FLh+4rz32jIUVlXk/Oc92b93z3Jhap4979ni0oQ7MclwvXfiE4c/jJ8sPKRD5PWcUuNH2gO+BpncuAPl9b6Vg1KiNSq3YxEfPBHWRjvQCDeYUkoucAqF2jWyIm13or9+dARjhYJml/EdEaLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkiUWuly; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkiUWuly"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ab077e3f32so43635235ad.3
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 17:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772847435; x=1773452235; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HIChEXukZcliW1jSUM/qhSjhsUiqy7ApYkMI/wPCXDs=;
        b=WkiUWulybNZFoto1K417/EnyQON1eWO41itni43inV/bZkcmpuVS8B/A+TPLBKAM0Y
         hwucqhOEOOwGLnWFFaocposjkxs65stow2QtSOIXatnXeZlGKo2OoNb25owZgUXuWc02
         j/gwG58OHCVJNEskooP6nPzStu9lgppM02HRpFS0ASptF14nukrD8GTkiKkEIoF5Se4u
         KfwbWizADkHowmC0xRMTR2VzyPmCxNDfxv+m/XBoKUbRbKHuhyZMPwoKPXNnHeC7UakG
         owuMniSVHiDWM2vsGYpH8o1wfClulExZnpajxM0y8MWPaSwRkve61S0jQ7UabgNGZmfy
         QuOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772847435; x=1773452235;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HIChEXukZcliW1jSUM/qhSjhsUiqy7ApYkMI/wPCXDs=;
        b=Zvn0hiyJWqwNQSXiAEqcpFm4Gufp1t005Haljfs0CllVQmU9+5X9yGmvOPEDBBSmBR
         8EsYZPdAxQz0BHN94lLQMumMXqiFmI9j5Xisxse/+6D4jcEHrMc3d2ha24mMZwZHkdc/
         c04vN9LeRWrWrPsbVtwS3sM6sCdiI6tY75/1DAnz06B4wGcfzc5NN/u87+0UWGXHeFXQ
         49pBOk+W/f96prnFog7eVgWuZZp+H7TSIH2P3JXigFE8whIEe/rEc7053KPl7qAZDaBw
         kc0CrwOsWGCY7NFlxlPrlyH3Z8yhDdVrAiVeeshYreRFFKR7c2mtH+r+jsMfYGJpLUbr
         v+Aw==
X-Forwarded-Encrypted: i=1; AJvYcCWUOGZiXJfV+L+cBGwWFbY+Jh/OSpsR+uBnsUCvMWV/6OokHQA4YxAUQwm+V4gNwJAdtuM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywyvk4SZk5XR4LEkwNBQQp9ugvZEecjOiOHiESlkalI6HMtkh0
	ffRPbMGP6Pwx7vmQ+YUcHNa5oeqAIYfYp3bex0f70lZcJ7yBRtoQvZaP
X-Gm-Gg: ATEYQzwQBvd/6nJJgyN4RZeLcvS1eVbBMmQNJKRZMhGG94HohP0KcOD8B8OBZWqXw13
	WAAb1fRmNFM6Cd4kR+8/TOEmGwSUdazRdQX0jwkvEJUrk92a1yNs6OwE1ZwjiTnpVD8hUMp6UZ5
	S9vUGLa24PShgmWQoumnTy0FWqzrre86Cc2+zZTaDarAc/rA4NGZV4h+aJfktJrZzRp5WSqMgpH
	S/Ap8SUzWDZNLKPsirZHOagqP+Rgkhre0WOVkwzd5hgP9IKjHzZjMC2v4xIUwWC97oTJyuhhgOv
	4GSMSOBFgR0elJxVZl91RC1NfRkKmq0skvNm5LqlAzec0T3OtQhixnqf+bt4Qbd0EFx0bXI4bbk
	5Blt1OKpvFfUugNR1TNXqERuLRThfKl1/r+1x0P1VyTCdGjy96vR+Nnm09n4A9JYPyp+m/hSarY
	QH5rFD/2D7i8lk+SV0VZH1MRJrAOUrM2a1/DAKK1zDCv25md6iomk1+mzP5gxbm03SWBDKWtQsa
	j53GCvSKtp8JOsSbxXJ63YokQT633g=
X-Received: by 2002:a17:902:f68d:b0:2ae:6457:309a with SMTP id d9443c01a7336-2ae824f506cmr38231855ad.37.1772847435411;
        Fri, 06 Mar 2026 17:37:15 -0800 (PST)
Received: from ?IPv6:2605:8d80:58a0:ac1f:d4e0:c92d:83b9:f4f5? ([2605:8d80:58a0:ac1f:d4e0:c92d:83b9:f4f5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae840ad74asm46063665ad.78.2026.03.06.17.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 17:37:15 -0800 (PST)
Message-ID: <fa536bff0c883281901beca4c5719862de8a0332.camel@gmail.com>
Subject: Re: [PATCH bpf v3 1/3] bpf: refine u32/s32 bounds when ranges cross
 min/max boundary
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, shung-hsi.yu@suse.com, paul.chaignon@gmail.com, 
	emil@etsalapatis.com, arighi@nvidia.com, martin.lau@kernel.org,
 clm@meta.com, 	ihor.solodrai@linux.dev
Date: Fri, 06 Mar 2026 17:37:13 -0800
In-Reply-To: <15fca35ac582a44314e22a1d2fba11832355fe6f00635b1da7aded6e48dc35d2@mail.kernel.org>
References: <20260306-bpf-32-bit-range-overflow-v3-1-f7f67e060a6b@gmail.com>
	 <15fca35ac582a44314e22a1d2fba11832355fe6f00635b1da7aded6e48dc35d2@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-03-07 at 01:35 +0000, bot+bpf-ci@kernel.org wrote:
> > Reported-by: Andrea Righi <arighi@nvidia.com>
> > Reported-by: Emil Tsalapatis <emil@etsalapatis.com>
> > Closes: https://lore.kernel.org/bpf/aakqucg4vcujVwif@gpd4/T/
> > Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> > Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
>=20
> Should this have a Fixes: tag? The 64-bit version of this
> refinement was added by commit 00bf8d0c6c9b ("bpf: Improve
> bounds when s64 crosses sign boundary"), which explicitly noted
> that the same logic could apply to s32/u32 ranges but did not
> implement it. This patch fills that gap.
>=20
> A Fixes: tag pointing to that commit would help with stable
> backports:
>=20
> Fixes: 00bf8d0c6c9b ("bpf: Improve bounds when s64 crosses sign boundary"=
)

Nope, not necessary.

>=20
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>=20
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/227885=
11420
