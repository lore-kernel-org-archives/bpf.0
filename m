Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491123DD503
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 15:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773932495; cv=pass; b=Wq0BSnAxk5JcV9l0sm5lmiG00YicgsSwZQYzAF9jRDMIJNh7c6OmY/YWLNioMawhMHUYllO5hMLTN/11+PGhnIAbGp8fqMFZt5RBLhk7+jfk9+KM5jGfWJG3X/OQI8QSSCm0eR5g2pKFIcDuubLk2bZOl/ToHt+IR8M6GXeQ3Mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773932495; c=relaxed/simple;
	bh=JM0nLN4VC3fM/jo/n5vvKQclmHQR9MzZPkOXF3LfwLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oohw5R/silb7+rAWzfcDb8wcvvwsp+WjlF6ellS+ySeQfvzee/hkwxpYCmVYlVSQOenTyypwTnMRxOgJ5Zw8DlyMfXJFDE4sSSg6cYxos5QJ2S8N4FkVKVituzvEyt4a+0kv6gd5OKB4WXKrCIaK9yotF9mzDSSC7ICRx51Bny8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fc07dkVk; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fc07dkVk"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-78fc4425b6bso10659057b3.1
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 08:01:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773932492; cv=none;
        d=google.com; s=arc-20240605;
        b=eH1ucyNN0NXhck9CpsqSLI64SS0Kb/24s3onnwEzZ9yIMc4wI9EcRdTS7UN4ctWTEA
         EHV/V8kwRPtVAyk79ck3aV42Dly+HxOknevWHFMMD4JBGo5HicIMPGJwE/+4UVQdeM71
         ER84nX3mtEGgucneJQqp1+rbYUbR/i47Yk/mTua5i1VVAvBk+U07nVvZQlPRyCBhgOjq
         2e9OGVOTMUmcl/fSA8HO50M2dFy9xiCBYbvBVb9NDJE/51qWzCfaWH+zMBLgcxO0KIKz
         9Eu5OXyzQ03F7+0/+UE4puaFJQ6mnrTluzaRWLWI80/t1XWxcpmeoRyEWVIgwJfhoihi
         jGMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kNOzaniBhKwab2/cDV0vRovKevUI10ARwl0nTO4/vVs=;
        fh=qBi5thozEGOvYrw2iEbXXAc0F9+OmrWtI9IUJNxrs+c=;
        b=GrTCUjbSy5bXFir6TFr1edPxp8/zu3X+9NEQB32dzoms40dkhjlb2Cq2YzHlUPucyo
         nXy4d1Kir6PzGdAttpjc5Oe5QU7N2Xa/0iZWti3P+1mXQHwJQNQvJjPWK9g4oDMlAcLc
         IeWCXVqhm7MZC1QxHCN7xTRbTkCDKWkStieF5OlGiifEKEA6J6DJGU6IZYz2yLOKcWdO
         uw+Lj7ax4mDsom6q9aQ0aiyAFwaP7tqL75TvXEak9LpUbWkAGARjFVbf9OzUY5H+LNtR
         4COWBU3ZpZl5uIDQp86F9IjtPkmwfRl/5hWZf+u3lPS9AklHQTQuWblGO8ouXjf5qpao
         w7XQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773932492; x=1774537292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNOzaniBhKwab2/cDV0vRovKevUI10ARwl0nTO4/vVs=;
        b=fc07dkVkcG3Gri8TXYY2aMZZ2g7Zb+8DzCuqjXeiFf3nx0AztfD+JP/nbHWmziqrwS
         jP2kEXoEjB/aWtd7SlV0ogzPGc/XW9++indmNrPukNtC88SjL6alZij6ts4OE2xdaWJe
         1epQms7zHsU0ozHkIrYXbMr1WAy0ZN8gAJuVDUA4MrrwxVb9hBz1RFCLi9lff3gmHqcE
         Hu07xuJjtizOGdc1mjyYrUChcHdY+VWL3th1mSFsVpPkETSic2o4wEM3iihQT1G+9JZk
         cyIADwwXtNXtU/s6tQTXBzOMlS6ICsyRmng0meMDZa49OkQjxB4EmwtFsRyg5a+1L20E
         LTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773932492; x=1774537292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kNOzaniBhKwab2/cDV0vRovKevUI10ARwl0nTO4/vVs=;
        b=FPFnj6fuTOuhXbISI1bGuldMEs0Z8hf8fXgCiPrg/vyiof873+F9J3UWa7flXQvAD1
         k+I8SdIxko3J21a87I/bRL3rCKTGSaqR53QtX1td9x253uCWv/gRJQzqzX03Ck3Hz2tR
         uCmHHa2bdIyh0f2va4dpOuSNMS+Z38UFKC24mnAYVBQX8gUWcfIYyJvEt7OHnDQCt6jo
         LKnMlna8yqRy26uGyl361v7j5QjaRde5NZd57MMuuTNUDxce2+w6vOTbQIAxsosKQwiP
         d5WBWeqOC333H7NY1hplu4rWOPwDUMnSKjOtf7n9zNJ2eH6+GCBb6AZoEM1U/4Smq8jR
         6IAA==
X-Forwarded-Encrypted: i=1; AJvYcCU4thNCUZRxzrTr8qAsv/gnOJ2Q6wuD42FLnDMkk5sv4kw28ZgPnhdUs6ZCyf4tMc6mY4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEztSPsJYH/17/7cGpNUGdNHEmRssw2Terus1IKtUEsZlcHgXp
	BiUXAgiE6A4xHWoYaCawa53dg4xdblesuufKSocuNhPGGoW7zpz9D3yXjpO2ARqnwx8J2eb3yJy
	IqjKCi0aLaA28RN3NtQ/RSDO52LPx99o=
X-Gm-Gg: ATEYQzwH9Ok6k/Gy/PtwmfPKjWx4nql2S70YVPveW5AfMERo/WP/VnvmtfxLd/9tcgE
	1MkWQ+aKtsAosD0bpMnt4AfUg3l4tTrChzEvGa+meH6bMRozjhJ02/9HOdIV8fzRGExrxCOye8n
	9vLQBAdcB28V0f3ZduIhIvRRTgi4vZoBUO7p/ikKQRVxTfbzXJZ/O3YAvA9w7Y6Hpkm/AHMblU+
	19kIfDOxmK8f5FJAzcfpvkfMrCi90lLB9JbZaB5OcIZlrSu/qkU/dVspk3m81DAFx3/vY1xA+cj
	kVrPV5s07BVdNv01bV7j
X-Received: by 2002:a05:690c:e3ce:b0:798:6042:12f8 with SMTP id
 00721157ae682-79a71cb3425mr67781757b3.55.1773932491706; Thu, 19 Mar 2026
 08:01:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319031227.330505-1-sun.jian.kdev@gmail.com>
 <20260319040337.366375-1-sun.jian.kdev@gmail.com> <CAADnVQJAg1hYmsbVaHcR0jYZY2v3A4iNOiPaMAWRVGpf0qPN_w@mail.gmail.com>
In-Reply-To: <CAADnVQJAg1hYmsbVaHcR0jYZY2v3A4iNOiPaMAWRVGpf0qPN_w@mail.gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Thu, 19 Mar 2026 23:01:19 +0800
X-Gm-Features: AaiRm51jQOs-wRpxQuIRzEtqS4hO4WyoZmuNflEiqt1alJyaQ1dOm0ZSn9Ilbw8
Message-ID: <CABFUUZG8ALyYEH=QbeM0kd9eAjmRPBPDfaYHYek8T4-=+X+8_g@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/bpf: move trampoline_count to dedicated
 bpf_testmod target
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Paul Chaignon <paul.chaignon@gmail.com>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 2:14=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> if you want to land these patches please participate in code reviews:
> https://lore.kernel.org/bpf/CAADnVQ+TKKptnNB25V3=3Dbcdybh5G6c2DyW2sYtXvyR=
aVnPN8MA@mail.gmail.com/

Understood.  Will participate in reviews as well.

Sun Jian
