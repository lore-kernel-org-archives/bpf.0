Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3094432E3
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 12:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787229527; cv=pass; b=pgr7DmMbQa8EW4/TNipOO+PLfw2jQyfZxdtyF1ycfd1FNIW1InZRKVvqEwgPIJQ/BSnbtrvUvVAhMtwObCc1bqjJLH8gzNW3iojnKmRIwCCq/OiYPbht/SDilgV8TVtHtWvGu5Sj4gByzyQlUCwOlMsQmPY1zuWYv7Ke3HRVTp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787229527; c=relaxed/simple;
	bh=VM1MWMpecoO3oBSY0PExAdSiWynZ46+1n09KsPJoLHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vFI4SCr2UVIljQkyM2Qj6vGWWXA4219SJ/qLIIPd/914dPkFUGCVaGnG9eeqLO+WNGHl2H91kany5sMkGihRGNnbHfUGJvtRhE+k4PDM7vrP5malX5JlvxLpTj3t2ys0gGQ+2vJVp+IOV8FUEJO+bNNQknxQRmkvRiCn5WWuy5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2Llr/qB; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2Llr/qB"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c15cd3fd760so297423866b.2
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 05:38:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787229525; cv=none;
        d=google.com; s=arc-20260327;
        b=dMhlrITrVUihehwR7+YA5h09iBL8B9ZVh+pqv0Q8gpblFcoxfy/FaBVaG26M3eYh20
         uBZVlP90JPXNxV4k/u2QpxEljqj8JP1o8HgrU1k9RAu/jJ6KJtVPg8RTELI77tjCSEWK
         1by5m3Uf577+IMGBofW6C8sY6UuxKLw3/k8NDu+Z4bSTanm9iwgtlJwPAoKb3CQsJhxO
         zACJab6g984ss1TrKb/zFNJK5wTzG5fC4DWD7IAVSu6MK6w2IAzTTPKR1GF4rcL1GHUK
         12etoM27Jr7e2YdjVE2D0SWS3hesQR+ZYhZa5gKcgSX8N0wEFcXt9QtacTtece6Cnq6v
         2dVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pg/JlBFq4DxSKWz7zIecQXsZEO1ggjN8avjeEqTyt28=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=mquryJHPew//viJTo3mo2XZ0VZS999C5kkp7fMLnhnLus2gDonhPRX5xj54zfBrldo
         UKUKecOi97+YMWhpo8uZyrult6aajJ/bRA6aF1C9rnnAITMDTPNhhNLOuZtcOumI3cCc
         uAAN+7LFWqc9NdtH/J08l3Ec1c2Nsnu4XaCsv5WY/ZEOJTTJxFdQMdfmNSAhHvTq0u8g
         Ol79XxGHlmqXu93qz7eNebQypHdlYZOUgTtDld6mE2QY625jFbVse/7/7XGVkuiEznaB
         EBnmLCDAcsL2Y571qYcZcSw+hEExZ2VfOj9a9GefFaRqpNxzufaP4VUhMf+8wmgZhT/Y
         BOoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787229524; x=1787834324; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pg/JlBFq4DxSKWz7zIecQXsZEO1ggjN8avjeEqTyt28=;
        b=m2Llr/qBbw2fYdDMANx6CRqFnmtqJ6ipmir5HOWadvUxtGcdSSz5VTDMChztV3p+cJ
         m8Op0SXuSLaQ3EiB20/u9ZVzbrU4lIgifzUOW/oGGHBt8bB+yukCp3gN4TXTZQwIaKZY
         k48sA1jJJA7x4EOvk33g7bpMwp3po/vHcHbvF5aih+H2nEPy3hxJL0qaL546yu3qaiwM
         vzS7Y/mfmoiyPcUMKioC253KYhDJpqVOxiM0s33NJ+PRlhFOumaZ1F7tAuUOdF5rWf9K
         CKMlJx1rpdUyjKngGhRgHl6QlCtkxNRMeMxU1mfI9zkodqKg+P1tZNPDq4WDXgIFWuyv
         2fTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787229524; x=1787834324;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pg/JlBFq4DxSKWz7zIecQXsZEO1ggjN8avjeEqTyt28=;
        b=ZviMwkYmjP89oeJFK5MaNnbXETCFUP8tEN5z4ENYUXDdGaqfSjWHM8gxyKHhv9E2UY
         tZ620fZEOlm78evgwXQa3Ole0o+euKtS1P5NAb/+kdULK3tGKBxQS7IvZarK+WiMS/xo
         Hq8prITUwq/t0Wa6/TssJtFWJrQrm4QS/idzC+vGhPuJh8PUkz3Z/lPT70xXTdLAGd8J
         +Ka0OK/2JXkiKGi6mD/yfgtk4YyYENaRU+npf1TUGfUl9aHwaZvV+UuQLriRW/BA0LHi
         Osaj3Z4S6uPCVPAsyk9TnAEL+5NxjfodYf7G/jysPsGFXp9+yjV2/CLSZj2o8OR7jFWy
         Dyqg==
X-Gm-Message-State: AOJu0Yx9lZrWBJFjjGoHJB5GHLrGsDiQrrA5DnLNPGNS5juDYjRHo4LM
	Zzfy+bVKDKsncHzVGbTcv1oD94QeG1fZUJlrSOPk9bwebEqf1PFRkm7/yl+CAAuj4KwS18TIGCi
	djR8IWd3et5vrElh9PDSad58aPQvJDD8=
X-Gm-Gg: AR+sD134f5qJTXi2tGkORGfJdva0+Bl0N7DgVLwzzSww37vucl15mL+3Sbdb0N6R+U4
	Zj7CMn0/PTWcYzrS3lAvZJv24ykqCyAYTiKq7L8Uczk4mUlWkv0c4H18gSdnPoUgexbKoVWtmZJ
	awl1dIChb51F1/DnJE3Oa4fEu3cH8dZGO0kFqjVtXGjYfXk9GefytRz+jmMN9yVQMWxDW6NFDyK
	JAcZ7eB9jUOuv6JxgT6hfGpma0fK/RSJqG7p6D7h3uJlGDqpNKaXaG1RM8p8diqREY/ne6Wyxm3
	ZFM03VGJBAtcEgHWVjpsZ4LArK4mQ4H1ps2heC7z6NiiELGw/EKfO4SU
X-Received: by 2002:a17:907:a643:b0:c21:7f24:968e with SMTP id
 a640c23a62f3a-c23e87191camr972568266b.11.1787229524502; Thu, 20 Aug 2026
 05:38:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819010523.1057789-1-main.kalliope@gmail.com>
 <20260819010523.1057789-2-main.kalliope@gmail.com> <20260819011611.014451F000E9@smtp.kernel.org>
In-Reply-To: <20260819011611.014451F000E9@smtp.kernel.org>
From: Nicholas Dudar <main.kalliope@gmail.com>
Date: Thu, 20 Aug 2026 08:38:32 -0400
X-Gm-Features: AcwNN1U71KYur43I7SB9OG6_Bx05_bbubWfeh1nXgQPx2RdwViSfURIcB7d606Q
Message-ID: <CAJZwKkg08J_ZD4cTDX+h6Dz3-Rv7FoRpknb9e=_r+=4rTjxmTA@mail.gmail.com>
Subject: Re: [RFC bpf-next 1/2] bpf, mips: Factor register moves into helpers
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks for the review.

> This is a pre-existing issue, but does this switch case in build_insn()
> silently miscompile BPF_MOVSX (move with sign extension) instructions?

Yes.  Patch 1/2 is a behavior-preserving helper extraction, so that
intermediate retains the existing behavior.

> Since you are refactoring the MOV handlers here, should emit_mov_r32() be
> updated to take insn->off and implement the proper sign extension logic?

Patch 2/2 does that for both emit_mov_r32() and emit_mov_r64().  It passes
insn->off to the move helpers.  They handle these verifier-valid widths:
8 and 16 bits for ALU32, and 8, 16, and 32 bits for ALU64.  An offset of
zero remains an ordinary move.  The verifier-inserted zero-extension move
stays on its separate path.
