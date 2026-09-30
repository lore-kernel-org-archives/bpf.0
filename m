Received: from mail-ed2-f34.google.com (mail-ed2-f34.google.com [74.125.228.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A75219E7F7
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 04:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790742378; cv=pass; b=WPIjBeJnMkg8zslXoS0Sus35DsBvs0Wfat3Wz1D2JlVk2agS3p1uy1tqO6lGCLYmulj7FcwkpatmQvLmTIz79MjVgbhf9B9uWrma1IT1Hy6cyFziYUkrutmseDiPHpkO+TBbKpvnkiUNQP2czQzeOkoDqKXOpd0EkpU2cNJcT4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790742378; c=relaxed/simple;
	bh=pUhjs1WoaWRbKGo9W9G3o0HlrMCCBaerub5JO2SX6QA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=qHR3c4aQSldY+50w1yZvMPbMczlToyNNxWMMzLDKA9BzMyB2SVwrXUJ8eRKFyJi+OgAbxFqm+ai8XnL7+fQJ7TWX23VeS4gJG/p7zzv/D3JxW60y8L+4Il9XbP8AxMrK+53oWdf/iDuRjPzn8d5dN5IHhMFB01SCHFj2WUXVEu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAlsAWwV; arc=pass smtp.client-ip=74.125.228.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAlsAWwV"
Received: by mail-ed2-f34.google.com with SMTP id 4fb4d7f45d1cf-6aaea1cb2e4so6054646a12.2
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 21:26:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790742375; cv=none;
        d=google.com; s=arc-20260327;
        b=EPdmfjhCphNx2qA4BRNGq/r5QGGd8ZPgtnax3XAN/v2YiZrC7cxYUMTzBnk9AFxerG
         DumP9z+kJg8f0xmjemPMIQhLgBtHKxgbdfFqIML32GmdDo6/Dx0dmiqfSGeJeozFpa+v
         ERrE/pDorWXvjA+/mtkXl8Y/ElU46kUUwN+cfY8GVabjoZA4DqagoRe0ihAvJYxOuM8L
         XjT6XFMopDLscq7OHQmsMCoQMp4+5FGLJZFGf3kQXRe5o6aED+piPRB0g8sl+Zi7BURK
         SuQS2tNPaJv3ZoP7g0T8DrvdHqf4w7zd6Pjx08IOUAZnW1cMr51a1S7c1SuCQsrL6xkI
         P4pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=pUhjs1WoaWRbKGo9W9G3o0HlrMCCBaerub5JO2SX6QA=;
        fh=NPVFJnkplS0XBaxDJfGZcLOa8RPQHO8kfhXKRMGAFb4=;
        b=dovKi2sBC51UJ0FRmHgEZPmcyuBf/cmB+n7f0XtO6tkcuCcDaK6cc/Jv9bYiZyDnWR
         E6FyfV5sJ8zvahb9ywp5cBTj0gEbwC1VEEUrei85Tv+pkw52wWYsXdd54FKfMpLaX4KJ
         mWly4tMIdqm8Io0YFHbNBd1KabjwIUzHRYxBp9JwCVUlGqwjHH4bkGKlb+LgkdEVFWXq
         82r3B/4YvJuYg9pPTVmojtjtpqd/KCKw33hNGehGFONGdiqbneikGsvcFeP5BInqlXle
         I+jypAv3irZ54cYkXJYFp+a/V4PpoeuMp6RLghzJCt088eZU+bQzguvJNgBz8d4Hap9c
         BaqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790742375; x=1791347175; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pUhjs1WoaWRbKGo9W9G3o0HlrMCCBaerub5JO2SX6QA=;
        b=iAlsAWwVwdH5/Z1MLMY+ZF/0bFPWwwChRabCtVmY2JuJ/BaxsiaHFXO0OacULnUjw8
         Xvl/wmd6lMpRIyNyesnxSOsLu/jYz5h9rPTTG43g2XsktmSJDIA9JXeJzwRrCzFc1Nn9
         YsBkfCQwgD6th+tlng1pnHjSfHRQp9ruP2dQ6V5P9WGHxLNJoQqfTcqJ6nMF6aOJERMq
         zQUad2f0JCa6OXuMPyZgngoAwfTDsoxVLKDguiW7F3VnW6iDvcQv5KSiW2FToejuK8xx
         UzQyqecGCHxfGRfaRpb4ZJiNm1GbuTWthgHVugC3yFdyiMkI8kg3m8N8e7uS+09DggSY
         5utg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790742375; x=1791347175;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pUhjs1WoaWRbKGo9W9G3o0HlrMCCBaerub5JO2SX6QA=;
        b=TbzYVp2tZCnWi2xF6mt8sLW2SE2YfbQa7dcdtkPe/EQqgTDTHCHT+yeyMR6vS83v50
         Oiydonm3sJBp63j/Zgl1rJhJy76dB0xL4zgk71SyGAAQZ3HtEYDmdZseKwsbKg8WKIf6
         DlopgINCAAzTsx2OFAtl5xYawUzKcnEL+OOmMp+2oBtHil142J+3Puz+nFcRF6R9Iy0/
         bEqbyJM8GrRQSMx7cLj9rH7NKEVCGTnadaEh2JB2Ix4/mZLJWg0L+52J7zl7wQz4kMIt
         dCWULUfiIGYCvL76QQp9puWdAAXooHN+eA9j5w9uc3t9vwRWmVO15LXP0iWA6a8ofjas
         uz/g==
X-Gm-Message-State: AFq9FYLXzWB5ArtHW3uKvLIPMieq2o4pa56h03yy9sCVgu2u+6JWncf7
	z0ZHiUfTn6gDA/5r6PPGhvWoNdNQHYrbwSn1hS57ctjxKtHl7pNDy5LpouQWz3ERFliioCYsAtT
	WaVBYuQfGvp3OUflALDZeZvS9eHIKGC/L3Q==
X-Gm-Gg: AYBFou0hvgYz7X1/A4GfRO+Jfc+hzL5Su1aV0TCy3LTQCU1Rc/KkCgfFOIAf7pF2ri0
	vX8SBigN70Dfa8rsjsQZ13EEflj7hyVbCtaLW36jSMzer/S8OHeFQmav5FgpcsHasDFtiw6Qjli
	7LlYhdUgVw59fRPwt5IO70no4zLxqEcDmv6thjt8MzdNj4ZqOTmEu/suBanMnOCiJmZ/7l3vi9S
	joL3llvrAMMI4i8a6644AU8QOZUXANbCty7ptmkQsjCTgKpDSjxqJC/Vx4ZKfrceNsOKOecs3m0
	9+bsmCRt40qCpxm3TUc5ONo1lqDLRp0t3SU+taAXm8eM1qqaO9ZhHXECg81DVe5s
X-Received: by 2002:a05:6402:3886:b0:6ab:81e:e827 with SMTP id
 4fb4d7f45d1cf-6ad59de9b62mr691793a12.43.1790742375226; Tue, 29 Sep 2026
 21:26:15 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 29 Sep 2026 21:26:14 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 29 Sep 2026 21:26:14 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Eric Robles <erobles3224@gmail.com>
Date: Tue, 29 Sep 2026 21:26:14 -0700
X-Gm-Features: AclHuK_JZDdnZdOzeWKKP-VUQ_UtPxcefcb-m_D7FuJgeOyfXcXlukW-VKyyKQI
Message-ID: <CANBsAxp+1fnHf2-23PTPTMmVZkpbR4zoAn9A5JJogqHbsAPwhA@mail.gmail.com>
Subject: [RFC] Proof-gated execution boundary using BPF-LSM
To: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

BPF maintainers,

I=E2=80=99m looking for architectural criticism, not a merge request.

I implemented a live BPF-LSM execution gate around
bprm_check_security. A process explicitly marked as governed executes
only when a short-lived matching grant exists; the same governed path
with no grant returns EACCES before the requested program starts.

Live proof and receipts:
https://github.com/KnowledgeeKZA3224/linux-coherence-gate/blob/main/LIVE_PR=
OOF.md

Repository:
https://github.com/KnowledgeeKZA3224/linux-coherence-gate

Separately, I have an experimental source-layer fork coherence patch:
https://github.com/KnowledgeeKZA3224/linux-coherence-gate/blob/main/sc_pree=
xec_gate_v2.patch

Important boundary: I am not claiming that source patch as a freshly
built and booted production kernel. The repository explicitly
separates the live BPF-LSM proof from that source experiment.

The question I want reviewed is narrower: is a one-time, state-bound
execution grant of this kind conceptually best expressed through
BPF-LSM, a dedicated LSM, or another existing kernel mechanism? I
would value criticism of the boundary and failure model more than
agreement with the terminology.

Eric Robles
Supreme Computation LLC
