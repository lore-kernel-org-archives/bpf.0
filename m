Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E042C16A395
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 22:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785967386; cv=none; b=ZTw2+5qNpaa/M56E3z57tWwQPXVagO3O7+Y2Nhu3+YFDLnqED84ofqn0cEB+x6zjCWTgPl3fAX3QiPr8pkJXcT6R05FtnAzXQuC3FI7z2JP+JcUdniKHFkf3fQmsWBknAIbposHwRAlVXIXBoKZ01bB3j9BB/1q8ArVnG27q6Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785967386; c=relaxed/simple;
	bh=yT8al07KbRr0CNKka+4pocar0G4DOwh/90do6bA5eco=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jX8pfGnhSffqK3daoSQ7OGmf/97sUr9twYdn65Qhhf+XQvRDwMRgdxt6lCGLiDgkEk7vTM4VsKIdbLbV8daKeYSWPXVtUM5x8iPmsdC725uOAoKYRwMrHdmjp24SroRnvOVZRC+aPd1c1RtvJFO/pPQiP4sY2xASMWNeKdgDzqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEJUsr5d; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEJUsr5d"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-ca88130e09aso1193002a12.3
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 15:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785967384; x=1786572184; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=yT8al07KbRr0CNKka+4pocar0G4DOwh/90do6bA5eco=;
        b=PEJUsr5d4utvlYqva8vxWXfEzveMeRRorrFd6G4H3fjD7fJ9mCAxys57ogLlGmCYGT
         c9kkqngt/0r381rqvitPWzvcn3bGCCTzlOebsR7RVERlEjNxIEzNwFooNk73hoFBIizW
         etGdLFSt9vPkT1o8vMhuKAUPIz7TuHmYCobgQcE3wPHRTvWpywtJevxSHdgtV6M4n1eN
         0ZUbinXje+MPH/AqhJ9E7zgjCJ+ROqX+3NR3Y7nowdS4yhYzvZhjrSVY7NxQWDD7FaOJ
         CLS7TbDlharmugIcuNjdMSZ/72zW1HI4Fu0TanlaaHAg+qocahQU0Vz3+ejQRpJAkuUJ
         GEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785967384; x=1786572184;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yT8al07KbRr0CNKka+4pocar0G4DOwh/90do6bA5eco=;
        b=d1WXlABKceKe2EucujjRw2LTH5Qz/roUtGHrzSUk3ZsRGlmp2edw6a1tw/8VosRFGD
         vYokQNVGpZjJxtrmeAYGT29BYwij71PfdR+NTpRJr6HKNu1h+S1nYD2X2RMc+SENG/l8
         FaPYY66B+78zpfW85D8n4eeYMMDMbthxo1R+t51SXJKBHxP7ZUrRsrLWJ2aytTQHuTbj
         L9VY3USSw/CHzh/YZogpo+A2tnzBjCoF593IXg7V7B9CNlylYPRKgrStsFo43CMEajXb
         XktKW0F+fM5V8w8i+2wWmAqvNiFO+ILBeP4EYWrLumAuV/C93KVkdz2mSQXohguuNnY5
         m1wQ==
X-Forwarded-Encrypted: i=1; AHgh+RrYEz8BdNfPkf9jh2yhAUfRD/XilLAs3dOarklsMF/ftgdVPMU799i7mehhmr0E7uKdEwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YziTrm+wGOVzojrJ7VsETV+UNILWrmtKHg0751xRU4uM0l7KlYf
	Rzj+NusV2ABII0/0fu0tUpihtaOO8+lIsKb08kfJTOsCR6d2U0c8jJkn
X-Gm-Gg: AR+sD11y8ZHpcKyLGNoYf9qZljb+vxwEBNGGY1UJchBvodVlMOEyxzK3hQV8/1KqY4o
	rF6jzOLcQm+v0X39uSH7KbkiQB9i/TgIASZ+n0GlRYDreqK8fMOvk5OqBV87+CoOycC2OzFbJx+
	isBe5hkMEjXXZFaIwlP6hx+NiIJg4JBK+hOuNd4wOYZ3GvZZ74dFC1mCXTTpHJU+E09oFHQr/VV
	Ruakr+JwXOKhdKKpvmmCqYIJnpVGSqWUmyzeu2zpuhosdrq0Eg+WFH3TVwyWGQ0mz+2zVK0w+A/
	5HGtnprjiZjTiNhh+Sh3xacDPhyTwQesw3LTVyOaifRYIvE9xwH3pRBJukEeRSybreQ4jQftwcH
	379PZg1g2VfIN26nylT3gFNy5J2GrpbjK4Pjtu51kCOePXLm5tBh9SSXCqvF44YW7BGQGUoBDIR
	LHYOdBWCjENjLRMgOVZ7Y5dVYP9Q2wlENUf0rYgNxTnnMEVNKuEqeJjMZeHp+OGi9LHyhHRTIkq
	m6Q9qvCjSIKJvObsRYujuZQkavhpFlritAFjK9CaDPT
X-Received: by 2002:a05:6a21:697:b0:3c3:c3fb:2473 with SMTP id adf61e73a8af0-3cb85e736ecmr13214348637.20.1785967383861;
        Wed, 05 Aug 2026 15:03:03 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:969b:c0a:ff6f:454e? ([2620:10d:c090:500::5:b61b])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca52d329sm17217964c88.4.2026.08.05.15.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 15:03:03 -0700 (PDT)
Message-ID: <f6aa637ffe297ce0ba24f42565a5f9921195b909.camel@gmail.com>
Subject: Re: [RFC PATCH bpf-next v5 4/8] selftests/bpf: generate the signing
 key and certificate once
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykola Lysenko <nickolay.lysenko@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, 	song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, memxor@gmail.com
Date: Wed, 05 Aug 2026 15:03:01 -0700
In-Reply-To: <20260804170156.1709916-5-nickolay.lysenko@gmail.com>
References: <20260804170156.1709916-1-nickolay.lysenko@gmail.com>
	 <20260804170156.1709916-5-nickolay.lysenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-08-04 at 10:01 -0700, Mykola Lysenko wrote:
> $(VERIFICATION_CERT) and $(PRIVATE_KEY) come from a single genkey
> invocation, but a rule with two normal targets runs its recipe once
> per stale target - under -j both runs execute concurrently and the
> openssl invocations race on the same output files. Rewrite it as a
> pattern rule: pattern rules with multiple targets are implicitly
> grouped even before make 4.3 introduced grouped (&:) targets - the
> same workaround the test_kmods rule already uses.
>=20
> Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
