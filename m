Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E8A3126B2
	for <bpf@vger.kernel.org>; Sat, 23 May 2026 16:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779552381; cv=pass; b=H5zkGBDXAZ42LP6UVoOPutCBzfZxiPFYhMJ85PmUcc4QUuaMQ2J+kuUKN1kz5vrPMQGQRfsnAPzGlnfGJmgblnlfbmyG2Q0JShdLnL8fdEI6G3RuUBXxymtHgBofU9L7InQqhMbLIicWo9xJTnu88Eiw/DWKjKt+mZJk7vB8SV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779552381; c=relaxed/simple;
	bh=5RT6gx3WNSCcANgMySSyAw/pGeqa7pvPn+JlBzeRtfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=H7tfggQw2Uwx1HUPSQdCD/crRaqU+alfXx83aJfTal4Udn3fdbXSKbIVzJCzn0Zfq384BOJfUVEK/aC2riP2aqrZbrdJYvFN06Pefeax+5LGx5lzCVFSox+h8GzEsI5BD2l3kOXXQ5hVGMHqaeJvtYBP99dmUW38SdxE2eYl4G0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fWDD8NbD; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fWDD8NbD"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c80203b9d7bso3621251a12.0
        for <bpf@vger.kernel.org>; Sat, 23 May 2026 09:06:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779552378; cv=none;
        d=google.com; s=arc-20240605;
        b=UIjftwcV5mfOtfojrcz45+9KWiU+jwIY51Bvy67/UoJcNWnw0fnN7GSqVc8LjLnn57
         KWa5p1VBzTispyDjV84tg1xm8MGefroHmLSEvGb5qUXj2SM2v8ralAzpMeHzW5jn3MgZ
         G6TVRPg+YxyIdd4tw6fIdrz1ppyn9lLugwS+jC/dyUbzlEfp53L4iYErxS+A7UoSQDQp
         M8W05UUMaPzPbAYkwUXCeE8mdPesVBBWYBhOnhozr0lerw+a0HeVRP1MIvIJSTT+v9of
         9ZB2/PP26ZJSkD4suIQhMfwWo4NEvBmfHzKOcOd6B5l93fsAubc12Dgo4+OdFycZWrDw
         LMpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YzuxNquxS4blmJZDdgOjr52REsd/YHhwoXobXMMFVCg=;
        fh=7+mjycnEej9hjdixEsqfgn0WxYjB55gXXEggkACmcMs=;
        b=loXCr4YrB/qUZLw7CrNmzooqT8YT0Cq/Rg+89spwpU/a5/kUtWlDnimUvc3qR+z4KV
         sq/5uz2wkaUOiDMuMH31O9OCyoWlu6bEWfo1kvqPvGmeviHJIMkYKZKo8I+LOgUjh3k1
         X6+i3C7pIWLt5v5W76xQ0bPC43AfWztrioURWHx5cbZ50lTxEfs0uI+4ETw1yOsGtShQ
         ViDBbawif3GwFC1SGo+7CFeIDvlKL2rzX5fLAhPqjYdiSmfbgRs8Ki2e6cjyJNYsGUwx
         ZFVv2w1Dwb2LYpESRXIDe8b0yuEzlUeyu6kGKRa+HqaKY+WZ8zSQxCWtzzf26gFGM6wt
         7l6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1779552378; x=1780157178; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzuxNquxS4blmJZDdgOjr52REsd/YHhwoXobXMMFVCg=;
        b=fWDD8NbDhVvdl8zej7KFyXn8LmxJy513BUWU2lNZU9rKPQxqho6+WyVpxmUjW+ra5X
         E+01/mpHsI5F6N1BZ4OkPtQZXpZ6pNsRc9rLZ0L64H0CoLeBN0eSKU43n6KGPmrTYODD
         yKJPkv5NFeHyXpgcN/KIyxB66XaecptJF60k7y75l9zOQ/7/hxAd2Wanohcr/DIZlhe5
         OFa4rz8hbIKjvtHeOhp6DSRVEzWBymuxfzcbqtG1TTmraubl/GIFNbfO6pO8NKySJkl3
         A8Jpay9L1cntQIPzH0f6Y9Iw6ya8QRTPw284wuCRtiOT3psWKpnm7rDSGpFtl8zugACd
         r4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779552378; x=1780157178;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YzuxNquxS4blmJZDdgOjr52REsd/YHhwoXobXMMFVCg=;
        b=fcCWXjQDycxOK7N2LKRpYej7680Nd8Sc3NCgVxetTAbHX7w7X4xBpY1yqrvH/z63gu
         1PnfPn5qOHme3eEsXj9LLUPSZR3HjX9VBVK7kQnoyNdSsWAE6fFFXoSPATCVguyXvmOD
         AJ3MnjdnGg/TYjuTc/J++uiui03ukka87gryRgZwqlRNjrPnEa5FtvdAC0R5JePdDa3R
         H6/iINAjyTm7arzWyXaiiL5XsmblFvBCa75TQDjNo7p3VZakorVzrIvVotK+qtksaPcv
         btQs41ioy4DhUExkN71aFccMdfUTJUEUBxEpuyGUxnxzCL4YzUyWdhJdWOWDB9WNB85+
         hP5g==
X-Gm-Message-State: AOJu0YyodDz65AxTyob1PVJrg8RdZ7jwqCmsuK6Y/0ov8zjJfFVBvwHt
	CwgGVTh3hT0FTb7NFnNljxG4RApEacSCvhdoIBHwRakDmDIxL+eQ0PyZJ8eOvg4W5evgqbb6XYf
	iWLAaKaowqmYfNYcy13zEnLSsELMlah5pT2A5gRn2P27E4TsMJ2DKIhnN
X-Gm-Gg: Acq92OE6HkzhVh+dtzscDbjEn4VKXcD37e2lOnplNxpbzMObdFVcIBKfay/PlV5DiTT
	ANJEUJrd40pEKPEaUlhrW3w42FbU6/KU8BGitLVPUvUnN5BJuz/KFawSMgZxTSqjKjKcEQcNAZA
	mf+GQ8cbadCyEceDl9J0Z8HRi+TAzix3f/89PtO3DjGObYgdl/vI34zoF+RsmFi2igCEc3MAMCF
	3+2EJqrJBgccbtJV8VlL3dfbmZtvcC6wkm6mf2sAk+8SiQk6kFRxfGMVC5TR1LfdXgIDMhbfkRj
	snHd
X-Received: by 2002:a05:6a20:a11b:b0:398:7c6b:8615 with SMTP id
 adf61e73a8af0-3b328c704aemr8691849637.6.1779552377963; Sat, 23 May 2026
 09:06:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523160025.16363-2-paul@paul-moore.com>
In-Reply-To: <20260523160025.16363-2-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 23 May 2026 12:06:06 -0400
X-Gm-Features: AVHnY4Ksrg5MgyuLuXO5H_htBNxpD8uLxSvwcm-hjCJO3jA1M6Rnf7obQMcr7Vo
Message-ID: <CAHC9VhR6RSq1TUgAyvHmaF01h87Cazy=BNJhk654BP8yfeSwng@mail.gmail.com>
Subject: Re: [PATCH] lsm,bpf: fix security_bpf_prog_load() error handling
To: bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 23, 2026 at 12:00=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> If security_bpf_prog_load() fails there is no need to call into
> security_bpf_prog_free() as the LSM will handle the cleanup of any partia=
l
> LSM state before returning to the caller with an error.  Thankfully this
> isn't an issue with any of the existing code as the LSMs which currently
> provide BPF hook callback implementations don't allocate any internal
> state, but this is something we want to fix for potential future users.
>
> Cc: bpf@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  kernel/bpf/syscall.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Alexei, I'm assuming you would prefer to take this via the BPF tree?

--=20
paul-moore.com
