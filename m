Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68521295511
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 21:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770242038; cv=pass; b=XZ44g8p3OeSxzH1YE3LFI1Yg0c0JgKcC0SaIya1ps1cTwjDdoByCIJ1D/iQZL+H+mrB6d6gXjI3jKqqRCelpA6GBcaLH7EYcKbV9SHoDxX8vzVubpKLEquew605YFtQI6q5K1pek3yPHJe0rZ9TKrxLOamqjsKZWnf13sNBkaj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770242038; c=relaxed/simple;
	bh=ehZtbOTc4wIWe7F+7RO0dgM5xo93tMztmqUuRFnzuJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sOFki6EWDeqiSAiGMjTsOjtNk1HOJ1chlXuHFrNgmtXGZZg+v0EC3K9TaP+YHBEDjxE86H7b3WDHjKxpqnsVaDeQzXM58xAEurexoZf65te1sl7Ygn94cCqEFrdBMzn62C/DmPS9nkkCCf/YyGv7ZKKddMgCXB0iqKVH+VWTTqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuLfiZrT; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuLfiZrT"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4806ce0f97bso2375185e9.0
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 13:53:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770242037; cv=none;
        d=google.com; s=arc-20240605;
        b=Ry1SdkBcSZFhDMZKlg7m6cZ3oIlUwLvEqzhUZs1cRARU1R/QDd8qw7aCyAD4Wm9Fko
         zNEbdLnvPgaUnMWPdlg8sz2ABbBsIr7y3Xkb2VO3cebgcOnbZbLU5qk0cxKge0GMnq50
         KM8rO5K2SJkPokbFlMeb489VjgbAkarCracYSpaZlwQ8h+DnHGNHpj5EopqrAdIdMkHU
         rZ0KmNB5y2AL9DBZf7+ujMTW3OcVvhC6aPBf6Uod3Ghzlf2CLCuu9xG3/Ey5jGt4DJHZ
         KmbXKeTHnEFiTpKowt2mq0TB9m+NztWzZie1G3ZeFytXNsmIGCFpm03UR7GhJT23/q9x
         Mv1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5VMBOPHeckUcMsayIDGjMpkBDe9Ejuaw9no10EfEh6A=;
        fh=QWPamShyA1J/8s5doFWE3PWqLapUJDuSRevdrJZqM+c=;
        b=jTjEzA2Db5AfSWu5ZtHDF99m4j4I/19HKbIVpo0g8Q/mVo/2Dw9B3KuwMCexpomVxf
         Ue/HqmRAQzDWPVaREyKtvi4TPLBsi9elZQjM/X1JMlJAlxDhx8p4CvS54gTBB+mTCDqW
         KL5u+yTn3xxz4xUgUpj/AdRHy6D+5YP4Y2Bh7aNGu8FrQTLfsZ1xtIyb+PLcsq+aUSKa
         N3YxAxtFKHvaUnv+IMk2ig4f3kRbs70ssEXrLx8YE7sizfLUBZaZczXGCvGoCQuoeCDN
         qXqE5uBQwBynGrYO4HMZe0M0hIMqzkK1NDJfOrUhegJ3+/pSKNrgxML7swsKTavLJUWB
         /5jA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770242037; x=1770846837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VMBOPHeckUcMsayIDGjMpkBDe9Ejuaw9no10EfEh6A=;
        b=UuLfiZrT/8SXWidnGLpFLv0roYVHSGspZQZd2VC4HoBesykb51aCiVo2jvM5uZqyuu
         nlfTyn2+7BsWsSX5fbO456xMJ86hP5ru9uPGA80xUiJQUg3Tru7CmlX0itcZpewh1662
         SZgLCUc18m9cnlJpbjIjVRHQCrb/MLlrn+ClEC9/zhtwKGP6vKgZRT2+PqbnPtAI6zFQ
         KbDwC0PO358y4Qo4pxGhnQBbG4cQLnPfeJ+9cjrE3oRO7LOiQY2qkmc6YeS2nxU1ZQXR
         IwcZdNoBlP6U6F+XH48mvc6qmm1HMqgQflyu6AxhJfbfyG9u5EMlFUwimb4K74jVlD25
         XwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770242037; x=1770846837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5VMBOPHeckUcMsayIDGjMpkBDe9Ejuaw9no10EfEh6A=;
        b=emSpw+l5GxYVJj8ihFee0Tx6+Y47O0zYaoI7CQ8wUuUDUpsotI4TpXEZZ/EUQ/QtDG
         +lf9rOrxtzTFZKxxXKc3kI0BQlE6ABDfbcT+h/Hw0PPwA20xqHpP4Oib316Z6tfIOqX0
         FH9E/MeHM9u0R3FiO8TQwcd4AGJO2vIJTammOm8063uEecb32mT0PVyr7m19J8WySuuF
         cUopQx89tUua8VCNsKyknLpkgxY5VgfYChJA2pHiGMDmHmnI7qKojFhC1iiUItlgdp9J
         TjsxNpWYTHPvddoF4bmfkAjOtVZsriyXp3udd2l+VblkuZQEyrccdHZTHDFAWhF5BUyY
         Y76Q==
X-Gm-Message-State: AOJu0YxjiE2qv7J+LUePoxq/M7DpeQbbnZP6oFtbRopEM27+3h0LEtkD
	X7UZ8R53X9B9GipY93/iW7/PlVbXUVAmm6+ZMltt0ehDFJcPWy5LxIsiTuqC0EtKTTskqfLxM0R
	x4t4jHtxSLVwUHn/3kA0ellO24yDLJQI=
X-Gm-Gg: AZuq6aL25udTBsVVoyU7CamKhaalifbiNUy/iLIL9z5I1X8b7ORbmg8+gJXTw7Raevu
	QjcMhWMllb2b8gxLnaJ/iP8xICXyxZj260ft/SeY38xf7DLzg+pAR+0t/p2gymZxUQbsgp6dxBW
	OnBpS3za63HPOWKvQRASE9LSURWX241azNk/J4iWN6JcBbJL92XnyHr+stv+LRl3prnsmt+9SMF
	lj1wsGOAfUOVVFIzRfLHZFs8hPZ+kFVxmuepVVIs/VRtAvcuUaL52SxiRxkxxCtR/Vw9b5bi9Lp
	YW7vtaWJr7+FGZ8RwD9palrp5kezGJrNdNsiQzE79V9bbHZri5Xo3TLIwptr6n2ImudPhUxMECK
	StrA+81vrOcH3zevt+6Vamfhq
X-Received: by 2002:a05:600c:1914:b0:47b:deb9:f8a with SMTP id
 5b1f17b1804b1-4830e9862cbmr60251215e9.30.1770242036661; Wed, 04 Feb 2026
 13:53:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204151741.2678118-1-puranjay@kernel.org>
In-Reply-To: <20260204151741.2678118-1-puranjay@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 4 Feb 2026 13:53:45 -0800
X-Gm-Features: AZwV_QiwdKH2kVXfjhSSZQytNuW_IE3HTLv6jnBQZqHaBjpV6kl57AMwvF-5XjQ
Message-ID: <CAADnVQ+h50=wS9p8SqnkH7a-9tf+AKp7pHC9Akvn5_Mf+CnJTA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/2] bpf: Improve linked register tracking
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Puranjay Mohan <puranjay12@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026 at 7:18=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org>=
 wrote:
>
> V3: https://lore.kernel.org/all/20260203222643.994713-1-puranjay@kernel.o=
rg/
> Changes in v3->v4:
> - Add a call to reg_bounds_sync() in sync_linked_regs() to sync bounds af=
ter alu op.
> - Add a __sink(path[0]); in the C selftest so compiler doesn't say  "erro=
r: variable 'path' set but
>   not used"

Applied to bpf-next.
