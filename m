Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793496489;
	b=JALGygQtB6o0Wws6VlbH6DGAaW/o6jI+zpNmfdOFCTNZHALP+Uy0rBhe+x42DvUJ1HVd
	 uShGjul9rbP7fYQwA/ivURXqG9HGE5/ykHtTbwysB3biedXWJeBEbGA0/Iz7tAIwp6B9w
	 MDK3ML1nnoShUVEGMacjjsLpdNrEYleOo6cUX6WBQP/C2xVdrjE4TzRUfxKg3wlM6RJtv
	 xMCWPmnXLwFX6dY60NCI/azno5BiZF/XArV957QUW/VG4KyHxs96DDADMsAAKCEOekzw3
	 7LVhSO6iZugJEg6wTe7NblTUdQpm3OlLVYBkw5flot6yO2lUbn7XfRcdGNaS07+I4zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793496489;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Subject:From:To:Cc:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=7LrPxy9BAKXEpY6N5O++ZaxG2WFSWYtlj7o2XKSx/mA=;
	b=YV73f4iMi5yRu5oauJH6SgscFctH30umbi1Rh9NKJFrLAh0/Bxtv9w7St3QX9svxWZzM
	 fEzS675j7wnAiCL++luD17nRq+X4S3iCHp10KSN0FYLRAp0UiuJ3OPi9mffIcPBGmQ75j
	 O16q/9TpW12+YXSzPHwooV4GiR9wa6M2qVZ5zuFs28ORaLUqfTrFeAKErBvRkNFqV0I43
	 kXV8xP0X+Mzgy6G4rmcxBhg0kTTH2s2kv1erWqKKLKGG/JOyW/1FfQHdGgwquKPhkge8V
	 Q0MedxMhpCRsSgH2zL/nn5JfmepCZ7+2XA1JFnazB+l1lakEuyovFOXmNhneNsvgtWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e7QGLOUt;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF20606A31A
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 01:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDF20606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e7QGLOUt
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e9eb579c0eso9785225ad.3
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 18:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793496488; x=1794101288; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7LrPxy9BAKXEpY6N5O++ZaxG2WFSWYtlj7o2XKSx/mA=;
        b=e7QGLOUt1jxbs51TNaA0p1UUxmGARGoDenhBRBvjutBP0RHrN3UgwV4ztk4nScfO2I
         CE0Khf/XsabYm+Az0Fh2deLwMw4WrujKvXwboO7GN+8g/mw3DBwk3vAe2ccjnq0v0y8K
         m1GbyoFMkINnRyNsmQx2GyNiWksPqWZd8cZg21VJhUR9Utr5VjzGL0yU4w6zsqwVVekr
         8JaIez//EUyXR/rRBaNHY3y98GohEKGOtA09sJN19Od5PNGhCKHglo8MNnVhwLeIJXHS
         1ll7DAejSrLUJGKn2R8vIExPLwpt9dh6o+h4OeI4WLiPUCWOy2DmJbDq1x39rNKV0usU
         QgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793496488; x=1794101288;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7LrPxy9BAKXEpY6N5O++ZaxG2WFSWYtlj7o2XKSx/mA=;
        b=SC4jo28U7sPYcr5sXn28vBQzYezUr7UMWPDp02dOrq1Usyk4+WXgziblvx8lEut0Wk
         V5HhJwva17PNtLLpY/PBTlpPrmx7gwl8NST1gtsfkSFuXexl1CMx4xgDphrBQ9KL8g9C
         0yjKbUv+x3DH5Qod3FbPL583STF/Lu37rlqjr7izgIJEZo3p3mGX/cBbJQ0yh17ZxK/h
         lKUbv7xCPQa1saGLEyvdgkiepL/LuCWbrwOV5Pzr1+4OJid7x24WW+BSAO45HiV7bsOp
         L9fSz8fOoHprMK1bpYJy3n7ulYseUrJBJ7UxO3aYU56ASJPihF2arHoxboD7K2UhXNY+
         62Tg==
X-Gm-Message-State: APuU4Z/Jtd2luZPwMqKMDbG0CCBj9Bx/16/mpt+vsL7T4Fq+6lXlcnW0
	XjhmIfud260FE6MTMdzMbuLSaMGAXWU2b14xSWpzMU1HHO1ZwwAMXo+5
X-Gm-Gg: AYBFou288tiYWAbqDQj5WfCK4Dw6Y/GgkUvIYtgkJtKkCICsqPE4X7dsUE4Asqp4nmY
	eu9OdIZFgVZIo/p552+EOFfBvDARqcRsZCAZ5MgihppJMtQNkUTW/585fnXIc0SqaNm0Swjk9JP
	M8/WtHQoX//RiSBLOQKNfzgFeYPs8XcctkMBG4gUkN0RohhdFJL8c/imhpfnvKduUXbwYjOzVGj
	nPHaFuwZC7aGBLAeThtppkUWnRFUx3ebTUuAn5BcR8dvbElP2Kmw98fw38MGgf4r0NgN6+7TBdm
	YUEBw4/LDjFovnZO6s1xXPoAR2GYXYh0aslCBhyz9in+KKcjcQScCEFYn14qdbQopDjshfFb+ju
	7MFznB7f1t4U37VJrzaJEonTJrVqgM5WZdfNWwu9HaqRd11cXbSTDU+Oox1bqAtN1OFp4DiI1pY
	+5QQMCNbICz5TAYBRwiI9SROniJ6Zqs62RUTNBeUI2tVq0GpNfUTVUr8SdR+6TMW+i3rmVlOf1s
	FqClruxlUbzeWgUlp6a1ru+MrFZXU562ycPcGG+00O3vwf6+GdjlXU1zrc1K0HGrqDwKxY03IQr
	uY+gjEyOhWxpteY/EZ1rdfXoZ4eKhxZdzWWqv66rWC7hAYpp8FuFpQVu4qvlYsVIp+tgHZ21zsx
	aVy3iwkwFl+NK6JwfJqLtD/YrwHh/vG/+XA==
X-Received: by 2002:a17:902:d585:b0:2e8:422e:19c5 with SMTP id d9443c01a7336-2eb3647c0b4mr52613375ad.55.1793496488003;
        Sat, 31 Oct 2026 18:28:08 -0700 (PDT)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39298329sm16832345ad.61.2026.10.31.18.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2026 18:28:07 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 01 Nov 2026 01:28:06 +0000
Message-Id: <DMJHFZPKETD8.PUM30IJH9D66@gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf, sockmap: Restrict iter-context
 sockmap updates to iter/sockmap
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Michal Luczaj" <mhal@rbox.co>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "Shuah Khan" <shuah@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, "Lorenz Bauer" <lmb@cloudflare.com>
Cc: <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Sashiko" <sashiko-bot@kernel.org>, "Jakub
 Sitnicki" <jakub@cloudflare.com>
In-Reply-To: <0bcebb4f-4b36-4f8e-a3cd-1eb0455081a8@rbox.co>
References: <20261016-sockmap-update-limit-iter-v1-0-23fa946db59e@rbox.co> <20261016-sockmap-update-limit-iter-v1-2-23fa946db59e@rbox.co> <DM6O08VBRY20.1PFUYACCZ38JL@gmail.com> <a9ba4549-4bae-4516-85ef-ee38f13551cd@rbox.co> <DM92JCFA4X4U.30MTDH0KCPTJ@gmail.com> <0bcebb4f-4b36-4f8e-a3cd-1eb0455081a8@rbox.co>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Oct 21, 2026 at 04:12 AM Michal Luczaj <mhal@rbox.co> wrote:

sorry for delay.

> But, if I understand correctly, the removal of plain PTR_TO_BTF_ID will
> make pointers like `peer` inaccessible to helpers. And we just accept progs
> have to deal with potentially stale data, e.g. the value of sk_shutdown.

Right. Then the lock can go.

> Ah, sure. So the same bit for unix_reg_info left for later?

Yes. iter/unix cannot update sockmap after this patch.

> I've noticed commit 7cc639dc45c5 ("bpf: Don't take an extension for an
> iterator program") got merged. Should I post v2 with the env->prog->type
> check dropped or you guys don't want to restrict iters anymore?

The former. We still want it.
bpf-next doesn't close during merge window. Only people that
can process patches get busier.
Pls send the PTR_TRUSTED part in v2.

I'd also limit tracing_iter_filter() to iter/tcp and iter/udp.
