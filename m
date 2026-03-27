Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8BB3DBD61
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 14:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774621467; cv=pass; b=nTcqimuheQUFTv3FTVEXStUx0ADGRsZhs9bPB37tFYUxmR6sg7rU23TIM82P0ycRP00s7cSxwcEhebg0K2U9EyOj64AlGKM1NPu1nyn2pdUXmBlxGkcHA6eST3rGpbLgNKkRUV9NEYGHdbqwUC5B6D1heHb1MJjfPkra4Hz3XkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774621467; c=relaxed/simple;
	bh=LhxvMMDKZxiaQ7HwbmGKUwivm/cqrP/i2Fyl2TBtgS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QPECknysNag2HuqxHvC/U4LkmrPZ+86L1Hft+VnN/oCsgsy6nJIlBl9LOb+7K5oqqaPBCZUHqMJwI8so24sJDCD0/bVJq0N1PpPgLndGYjz8bPCOQ1QAegHySvxkWpfK70BXDCmz07tIe3vCnTLi5O5L6EJvyB0X+W2HrAR//+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IaBxidlW; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaBxidlW"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48374014a77so26350415e9.3
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 07:24:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774621465; cv=none;
        d=google.com; s=arc-20240605;
        b=AUAHOGdJk2n504VxAfKqStRwhLlfvHO+kqSRJZgj2O2zfh23TFxebzay5xAkuxjxFp
         yRHs+ODeryxiuRUUA1VSlEaksvmviT0TrALtBow0bpWUz+c9u8muvwJMZu3YYCTho6kZ
         RfGIs0T8KT2d1ter3K/IR3s/TEfQw/1l16VrhUX6L6XwU1v6Y1sE8yTWVp01HzkWaXUC
         lnAolyJMDD7HS01xHE6T3cQJnU/T6C55Fo68DVaSVfenDdEEtFx4YGOoGTq+cS9YjsBJ
         6eekQN7xzFuBANa4AHytdF8SkzOg+cDkaBnlJbSRzMjmqdbriwRhS8DuLhPQ26U03aFg
         Fdww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LhxvMMDKZxiaQ7HwbmGKUwivm/cqrP/i2Fyl2TBtgS4=;
        fh=Fz3s/PSUX3591TwXmjKBhGCevoE8QVeBKslyI7vGiRE=;
        b=NacSGm0fJj8j2fT1ygcNNd+1QM93tuLG+0qXuf8mX6oGyxiJNuvCzJ2RTrBwArEOJE
         K32oRDo/0Z2emA8Lt91SugXThp3i3OLKBmPznm56Kt7UiI4QzoifXfjk+vw0B482dwDs
         9OuYGkH9yKzkw2+FZG3qqL5yWtgF8bKIdKnpGWRig6OKGVQizk2zwmQWACHB8PEfYnbm
         aHi7A1iViY1aCkvk8esCSQ1d4epI9GdAvUkrpugho0ZduJzokZvdQwwI4fdaS2wiHOhW
         QnBvyz7NqklCAbjOhFNfsvUx2OpfWhu+Wt4i/YWOMvEkqq7/n3GJjKm4WaeTrO1dCjAv
         eALQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774621465; x=1775226265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhxvMMDKZxiaQ7HwbmGKUwivm/cqrP/i2Fyl2TBtgS4=;
        b=IaBxidlWx69kwv8iK3l9+Kjbr04o8EWJW9X8syxZ/noxLiIc44FBHPtIT0B8HzPMda
         fZnozobglMRDxV+7QvbCMjp8ongd/n/8WefJ38egTy3YR6dlK4ms4Sa36r3W5JhKpzII
         7muSRGPxOm5WoIW5oVu1UTjc2sEARnmeDMBytBBRLYuB44XPpTU4F/pcdO8eyIg/1s/K
         Fc8Fr5Mh6956aOppkxaZUzyw5JEe6SWmKJwKPWUPjLf+GuY3KbaxDssDUXlbC+t6KJnt
         sHoucnKyNUxx0fV3rBgZQJr/ZhfMqr6mf7h/mfCZExsSQw5G4iu6hJKAeC+hPzF2mOqi
         lkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774621465; x=1775226265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LhxvMMDKZxiaQ7HwbmGKUwivm/cqrP/i2Fyl2TBtgS4=;
        b=PiS4kD0DV5i6HnEy7J4P/iWCqg2LSk58TXAOMLYokehNVqv882VKf0QxfYPejsP+bg
         Rqw+80yiXNRDt9uJleFE2ev++645+6s6nuWH+llcNku5m77ldCABrRfJTieoucD3z9n1
         A60cqylAdiS37aF+LgA9cRy6Gq2M66AIQ4LYMFbDIQysm67ihKtxiEf0MDi/5Slqeg+Q
         oVz6l0xxWujvSOYfVt7zu3Mwdme/EZgCq+SdDVJYpioSj/x5g4x6kLX6CweT9Kq4T7tA
         7CQgJe2cBaR9z9OKGZe4YS9ke5ZTSmTJRiF09ZQUOZhvNO3xDOSHQ0ozrXB8JvOhmqaY
         K1Mg==
X-Forwarded-Encrypted: i=1; AJvYcCUc0wQzg14U5HJeOFRaw7SxqZS4JaHqeXS/LQJqcfnzyRquR8W/ScG1xxXr+ANv0YyGxDU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywixal68i70dQjQltaXDVH06CXHIi+dfubk6K9Ok/BU+veW6aO+
	qQu/9U66klAZxGKa1WXYotdSuFmBbhfXZ4s2X+ZO3oU7QyhJtOYxDW+sjkVQpqk/Pe7rEnV3pJp
	5fGxHuPVGkWBZGTL/io+xk54m/VfmpwE=
X-Gm-Gg: ATEYQzwnSlJMWKuwvDH5vw8klwLXZ8JtNwTrkRHCEUAuFKlo2N5771B/+TQEVSZU4if
	qdLubUhoTfFeWXYgH8VEQwCbRyLZf3QiM9fTuVtGRLBhi/duPFkUF8R/5PN3NnHkcMKz6hsqVsR
	4GKAD0csgYO8KQa3Zwxp0OYpBobUG+PdNpw0CXZRR9pFLlIDbjLRQhG9LWpboTsb0ZSFd0os1ZI
	w6GayPGrXWtmXpw2LAexx09CwfdPZxu2sLNpGwirLD8/EpHsCYJ7nKt8GV1Yn/IeoXl6q+Drwlk
	DTg9Xeh0Ysod1FqFIF84TJIc4orODMckSYI2kjwLuasPvF+efJX3v0o+REJK3WQxfTmAfOnJ8O6
	StV8yig36l9MLhdNpzAfNIfla3g==
X-Received: by 2002:a05:600c:35c4:b0:485:353f:c651 with SMTP id
 5b1f17b1804b1-48727eb7fcdmr48200445e9.22.1774621464559; Fri, 27 Mar 2026
 07:24:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327141616.1961457-1-hayatake396@gmail.com> <20260327141616.1961457-2-hayatake396@gmail.com>
In-Reply-To: <20260327141616.1961457-2-hayatake396@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 27 Mar 2026 07:24:13 -0700
X-Gm-Features: AQROBzBuTGdhHCpO-FmZyTYgDVXird9EJq-ktWadVz5nIWMbtos_PX5dO5xKvwE
Message-ID: <CAADnVQLh76CWYJCJXgOst43FcJOrPP2Y0wcwGPX71QqmiD+7pA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf, x86: patch tail-call fentry slot on
 non-IBT JITs
To: Takeru Hayasaka <hayatake396@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, X86 ML <x86@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 7:16=E2=80=AFAM Takeru Hayasaka <hayatake396@gmail.=
com> wrote:
>
> x86 tail-call fentry patching mirrors CALL text pokes to the tail-call
> landing slot.
>
> The helper that locates that mirrored slot assumes an ENDBR-prefixed
> landing, which works on IBT JITs but fails on non-IBT JITs where the
> landing starts directly with the 5-byte patch slot.

tailcalls are deprecated. We should go the other way and
disable them ibt jit instead.
The less interaction between fentry and tailcall the better.

pw-bot: cr
