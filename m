Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A2E388E66
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 18:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785351313; cv=pass; b=q8NKb89RbclcqV0Tbv6X0SsJ8DVLWXV7RRm3qoDyMhvxzLmuI+vo4ACN3QB076IKpat1k8XmmXYmubE67J5AgjNVT3wFjGEG416lnoYukYFWLmfq5oUdwoGVGIQjklMrA47qeZ2l+t87eAEgNdOuEKsVueQ3CofD2/anM8h83ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785351313; c=relaxed/simple;
	bh=J7Q/JG0CswAWT05HS4viuqu/HlixkuPXvFfCWhRvvqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oKniVVBGnKWGC7p7kiuekvU8oWvlraIF8NP+C+cljW87RGLHSsgWAemWJ2gBKxBBxBiacTgP0D2baR3qvgPUThDPz0bQ5QMB9H+83YUwnhRzaZQv+PDLaCRcllhPhQyUAn7w24mUBpm/pMKC2q+Q62RKkZWqgZguMeygQYge97E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SD/49TbQ; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SD/49TbQ"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c15e2dab83eso203056866b.1
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 11:55:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785351309; cv=none;
        d=google.com; s=arc-20260327;
        b=WLUhJl+fMFTomakOqKxWYMkKqldMX7jLpICV4uaqNmPsCsO5vzczbksboEawnaNfB2
         Rug4QVho9h/TkMI47uGZq7EjMPwnre0iALGrkHsNOIeI4Lz8GCiBdPcV1f3tcqhMx/XV
         dKyFW+qGqEljpTIVZJ9oszFG8+d1b6Zle/SVtEsYWx8q3V0bZvJBg2/y7GAIsFs85R3l
         xdEm2VpJPpKf6k+d0Xc8L9msfAfxkHDCUcyYJIgDZ+Gbt0GlcZHvTO6T7ll/Bn377VD0
         5m/b7M+4pfhPF3nftTZ0SrJouO7Khu1J+jtse+pYTkYYIKZPVl49v4pEralYoupCGKh+
         48dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=J7Q/JG0CswAWT05HS4viuqu/HlixkuPXvFfCWhRvvqA=;
        fh=rsW5GYiaQdRT+hgSbluhdMFpgSrzmRud7WyBW+8A1nE=;
        b=hsjAol07/ophcSVx2fC/WIdO4+ayCKo55c95nLIvRqnarFzhKXzIEZIyXoBXN1qXA2
         j20a/xmYlOv3xROSXivcD4mwvf/a4A7z5H/YM4u+bVymv4pGWxeCVP/+MXEhFO8pjLsG
         EhQb7TeKnhgFpcaKTOsGW1Jd7uQ0e0fKy3jsSrOIQz5jxxsOh4Vbf1/QvKvDszrfWdE9
         O3whfB+bg3Kl1mE0FhU4G9QNO8+LhoMJSWm8RQUCx0bDTkdotjjKjlzE1InSthQXo2f1
         bVYMw7EH3bAq7KCMtn1Tm6ggPy5YlnSVTigjYxo4KD3jBb79Tw5i15z6OfM9V8qVWlDm
         NzHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785351309; x=1785956109; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J7Q/JG0CswAWT05HS4viuqu/HlixkuPXvFfCWhRvvqA=;
        b=SD/49TbQ7ecu0O0yrPXJ39fhxeZ+irmfAcw37GW3j2glDbWOzkZ/6+q8nYYNdwqAVL
         YMdPf3qfgdat4u8nE0Zuks94EFwcaTH9escyW7q1DUi7ItPwaPGteVXh3YSqqw+y7Bhi
         +bSLCsrks50HDPYnGE7JgReSofvEIQz9XTzcOSm8+FqO0HU63DIkYYlGI7WZySmxM686
         2jO3s51ibMWikiwM4RMHJ+Yx7uZFsgzi5B9/gdyKLSbUXb4qFt3TYddnnb4A11lBXDv/
         nLETkDpKy79I0QIrIMIMsTRR55lLy9YJAadL8RN5Q9+w6ZnobLyc1cNdBdBBuQKUdeR7
         G6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785351309; x=1785956109;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=J7Q/JG0CswAWT05HS4viuqu/HlixkuPXvFfCWhRvvqA=;
        b=PkR9nkxAF2SLi5tWcsqM2Nm4oKYzMbIaoStdzsRsx+WE7i/9cLfcd3GXpkCy1zCiEb
         FBH7EaFjLORk25tIG5mLc6gdAEjwsicJAwnNa0W/E5T7OVOCJrpq7zVfszT51fNCUzjw
         9SX7hue8LIAmPxEB/HUov/LE3wLgb9nPrrtu1mLKitfZuitnlFkbD/+ey8UWvTNsecTX
         cbX/TVFtC1DYfoqzTU7zYGzT2AG3huXDWOO4OLk+yoXSGLR/4Zwm9fqrV7e0vjewcJQv
         RYpdKK6qGcVwY+GndgY+/orLKNp0/n8kswnrNsuj6j2a11BbMOY+jH7CNCJcqe+p0CFb
         fgag==
X-Forwarded-Encrypted: i=1; AHgh+Rr7K0p+dAI9PZ8TuTp1pehETvlpJQ8ECFU9pRYGC21olvFHF4LUQkgVuRB4mJF3UDTsyh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX0o2cF3Fxl4GA+bEc07jHIScO0rC75FIEWMw15DushCrbjyFY
	D27rWdAJHa2CyRohxzzvCz30vuVu58Snxtb6udYP3ELl4eg0Wb6RVOEzzRiknrv4/XrMvlmj9Kb
	E20bo99hykNvaFJ5c710sIy+/XwG0KNM=
X-Gm-Gg: AR+sD11Dr1AIFzld464JKTx2ud2oqmn4dYNGaByasPJsoMVZ5F7q29oBBSD+U/SGbAE
	UgSBkmE2gLFbhL8qj1+m6H9WQrlvWN4XXUAo6d9C8h1CuNnlS01qLwOwyb3xc9R6jVRSsQCsolT
	A8HP5GRx/EH15CrdHCk0XKgQh5ftE0Qe1xKYrPMHuk5PaRS8+39ipcJAp4nu96MjWF2FGX5IaI1
	FiDLgbuuZyys+mwpTY3TL+s18EJdPAOL8KfigrlqaSOAhk3HCa2hJNOHFIB8dP8mDsSPmnV+kId
	K+mUYnqPzoMAzdN3npDbRYZm1pqMd42Y0faLUASk9+GYzPw=
X-Received: by 2002:a17:907:8b98:b0:c15:de33:a018 with SMTP id
 a640c23a62f3a-c1f72172377mr425820266b.45.1785351308941; Wed, 29 Jul 2026
 11:55:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729162931.2369353-2-main.kalliope@gmail.com> <c517c61555d5ac0e7dda77c6f9a4e3624ef8ed742d6372ab3d5af4879291ec4f@mail.kernel.org>
In-Reply-To: <c517c61555d5ac0e7dda77c6f9a4e3624ef8ed742d6372ab3d5af4879291ec4f@mail.kernel.org>
From: Nicholas Dudar <main.kalliope@gmail.com>
Date: Wed, 29 Jul 2026 14:54:57 -0400
X-Gm-Features: AUfX_mzbDEUq0RxwG2PGkCepUkKTA7z_JftWhQx9fqbQwagGHCFzwbNwaMMOaBI
Message-ID: <CAJZwKkjS6aREL7zSXp-4XDL7aHjCmLpUFOyO8nPAiJMUtBgSTA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf, mips: Factor out div/mod emission helpers
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, tsbogend@alpha.franken.de, johan.almbladh@anyfinetworks.com, 
	paulburton@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	ihor.solodrai@linux.dev, philmd@oss.qualcomm.com, visitorckw@gmail.com, 
	bpf@vger.kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@kernel.org, clm@meta.com
Content-Type: text/plain; charset="UTF-8"

> This isn't a bug, but would a short header comment on emit_div() and
> emit_mod(), in the style of the neighbouring '/* ALU register operation
> (32-bit) */', keep these consistent with the rest of the file? Every
> other emitter here carries one.
>
> Same for emit_div64() and emit_mod64() here.

Agreed that short comments would match the surrounding emitter style.
I'll add them if the series needs another revision.

Nicholas
