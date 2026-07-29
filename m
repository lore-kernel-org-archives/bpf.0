Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBE125A655
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 01:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785288978; cv=pass; b=I146CjT7Yfzxeo1Pg49BysriPnR0cUbo80FJwsgcqO0+L6BdqMIs9YSlR6ODPP0lcgZr+cWg4xT0slKRe0rtKMpMyyDzzUEx1/WFD+ChjghnF6zn/lVzAaO3RbZarVp8gZ38GNKxDJ4RYxGDT6u9W//sGE5ggkoYF9StKh8Rmws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785288978; c=relaxed/simple;
	bh=smrSPmbFPzzbUQc1cVkn2G0XxLhpKiHLkqRA7mUmAXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fhkmKs9tMynyuSkbVL+ptHNT2vNdvrFyDGR7ZFD+YIK6oOLAJZ/Dngdgu5k/Pq874twyfq/vKYkszNHuAkUBcF76Hb1TM1ZUaafv9KKnYIk9sOb65eYpQeSsl7Nr17rfxhBSM2xpI9D7vf4UT5QKt+ZUk8vYFYrCDBzpJDxs8T0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XaX5e/le; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XaX5e/le"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-69fc2261f2bso546110a12.3
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 18:36:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785288975; cv=none;
        d=google.com; s=arc-20260327;
        b=HL2hKx98zqyassLMjMfOTxdQ0Wh7SK2END/kdMcMMPbk53Vnvy1glo7N/qRKJKXm+i
         aU53V2J4lsGDOs15ft2kiwd43d0tNTIjAM6MC9R5A+s5Vt0CwR6G6xN0f8otj94cB9Og
         08N3HfZVDyIa51X0gfUAAyZsRWdWhJ5R01TLIkOh3nRY7GIud9sSxgKoiGs33VljZyTU
         lpERnw48cbGAi4r7p0Bf/hwLBRMk8zK7sZk2yiNA8abgASN5WdYRPMs0srLEA4TEFSJB
         tt0IOHAdIyA1RaI16xuq5eEifprAEpFKHyghnhKnyikg9SLHh3m/KlMVgSERwXMxm02H
         vQwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=smrSPmbFPzzbUQc1cVkn2G0XxLhpKiHLkqRA7mUmAXk=;
        fh=YIGN0BzLwJKM+Y8VfENwDtYFF8PQnfPgQo5X+npVbLI=;
        b=htrVUmbPKPONpTQ9l38nbqYh6QPuJFyTOa55nwGi72ora3jLNy9vLLW/ILyLBPt24A
         XAQeiCFrn7D7T/dvY5oh1rY9p14mpO8vOYZ6RbrnbVdMB4XfL72m+uYk70wl+iGT8gcM
         G+qrgGGOsd0iHL8k0mltAzdgYFXM1IVXoXaP/w7X7pxt36BWead+LWcC7nV123Zj2z0f
         X0JFOayqRhq+T3Fc5XocrabeB1Y2TonBTSzea+PtsE7hup2pAzt4SVxhTJsaxArS0Fvc
         XAs8pgbMWSPiQGEx80k3FgDw07gjZfAl41ajup41GHq5DYl72ofgfinBic21or20ehCS
         PWPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785288975; x=1785893775; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=smrSPmbFPzzbUQc1cVkn2G0XxLhpKiHLkqRA7mUmAXk=;
        b=XaX5e/lejryy8eBRGEfWv3wq0Nz03uOLR6EOPg7jcQSDfPT4aduSfAxqV2JjR/t889
         OP/QRQqZZyZ22Msw/Ik0B+5g2C45LclHQk/ssSQ9/4ve09nPj1n5wWr4yxqgTpLz0oyF
         LSwPP9rdEqXZ1nWIOmytddm76gQYOBWJPl7dD4BP3KJrOLqAZRK0k5XREgDVKcnLYc5k
         HulNUiGJofUTH0AJRarynzE8/MjUicQ0SNYWPzy4Ls52W0U1RQIQkwcE6KFCqHMdOPBE
         px8JECy7b9DsnMuSCDFH8QpuHGvdJuyCJ8jcfHuxrcgxtJfEOrvMgcms+0Cv0pD07arC
         /wrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785288975; x=1785893775;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=smrSPmbFPzzbUQc1cVkn2G0XxLhpKiHLkqRA7mUmAXk=;
        b=KWsI9jits5V22GVmK7lkMnQlfKhB7nrPFYkcgI/6J/MbvEoR698sgNl+kUdyDmPyyu
         wyl8UcNLYr1RPVbKqcqvOHl9lC7Z1+9UTIuuznlVZlg4SoGqqZucUQ38wICFJr+qQoa2
         7evFPDOVDmWwxIi+KTuntZAQIX9wEHz7gtoD4zfGfQS6Tfno9Hj6iNpBZN3fk3lCppzh
         DqRmfP3zUO/5d/uoSYLToqMRNVgaWsD/cKROUUmkQ0MehjNZdvYt5XdF8JugU8MEzXVm
         2rZSIi2/QDaGZfwaqzMNw78GSiS60nxRW6M8TYdPp6eEZNC447K2k60kWLoEzUoEyzQk
         FZfw==
X-Forwarded-Encrypted: i=1; AHgh+RoXKHBfiN4RcbobisaLrsZmRypBT/y/Vp9dyJn8pfC/Pzkd5Vh4K4z2e1OJ0VRhVVMci6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUhqj7KrCndZYSa3OJJQ1HA1jTLgX24q89X7DRopAaEF1xotg9
	9YqFST2fMK8iOvE7TDMGuJaM1YJzpGG6gL5e/7bt7p6oj4I99RWLiWocNtErhHdOMFEpZ0JOEOa
	q65NWsGSgckxpQH+fN6SkFvY4Hklt4Iw=
X-Gm-Gg: AR+sD12wJWJY0FBiN+fBrPb3Ows3/TIJ95mpZLNvyMnEW3rk9ND72U/JNuY/3BFYSD4
	l+hINQ9Mm7tIzkMjhSM+YM22fOF//b3ooWQDirVuqnx/ycQ0NEPLCNL/1cIx0TxusPUehe/7qeO
	fbkMYUm/4y5nWOoI7IJduaMrSzA8aAha/hOn1sVdkRacKAk1eUp3TGCm9bGdG4bV8g9DbnkOGP4
	hVn2zj9IrfUgzdmCmcPweqF6kCFOMrIKNyVRut//kPONUU96GQfdRqka+Kvu1CB/b4mDADZmEJX
	D8yDqVazoLB72t9BaKHlSmCOYBX8Xg5AV4Rwwb/5Vc69tDI=
X-Received: by 2002:a17:907:7b81:b0:c15:c658:dc0d with SMTP id
 a640c23a62f3a-c1f7212f768mr251959466b.39.1785288974858; Tue, 28 Jul 2026
 18:36:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716151110.1716607-1-main.kalliope@gmail.com> <amlKS9s1YYh5mOEi@google.com>
In-Reply-To: <amlKS9s1YYh5mOEi@google.com>
From: Nicholas Dudar <main.kalliope@gmail.com>
Date: Tue, 28 Jul 2026 21:36:03 -0400
X-Gm-Features: AUfX_my0gUeQYf1nnJh4m9pf7naN6uxhrPjSsEWTnFIn1kxBlXCU6U98WoIrpbY
Message-ID: <CAJZwKkhoVSuHqeNaC=3CK07UVLfCTAM0MNFRoi=hZ=X=t=nVNQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf, sparc: Add support for BPF_SDIV and
 BPF_SMOD in the sparc64 JIT
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, davem@davemloft.net, andreas@gaisler.com, 
	bpf@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, Jul 29, 2026 at 08:33:15AM +0800, Kuan-Wei Chiu wrote:
> I saw that your bpf jit patches span multiple architectures.
> Assuming you don't have access to all these different hardware platforms.
> Just out of curiosity how were these patches tested?

Correct, I used QEMU for my local testing. For sparc64 I cross-compiled
bpf-next 520d7d794202 with sparc64-linux-gnu-gcc 11.4.0, then compared
complete lib/test_bpf runs from stock and patched kernels under
qemu-system-sparc64 -M sun4u. Ten tests changed from FAIL to PASS.

I also compared stock and patched runs for x86_32, parisc32/64 and
MIPS32/64, including MIPS R6.

For LoongArch I reproduced the issue under QEMU and Tiezhu Yang later
ran test_bpf with the patch and supplied Tested-by.

Thanks,
Nicholas
