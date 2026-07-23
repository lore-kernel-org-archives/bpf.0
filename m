Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6E740097F
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 21:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784843744; cv=none; b=X2k08K1TFH6V3IsgsXjf7AOuUQU5jRGtiXRc5C0Ioh3eYgsajxrAuWtmQ07sv7+DZx0tEOTlITd3x/TQVItm2G++KumzCJcKr5cutYrX5ahahWW7yVVR7xIiV15CBSPGcvMDM582ccfaIhWXak+ZrXLz9yyEfKccMpmnYFIcRgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784843744; c=relaxed/simple;
	bh=/9Vkf+SH2DeryCQm4xaIpblRo96pf41ZoqZ1k6gyIpo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bd1ZTybSrS4z2FYmfzl9eYpYWbmMIcb69w69ALJ39jgguLMm8iikm/BSky2tmLWw12SS7gcgBYWF5dYu3mooWmg7FMLvKoEMDOjzD6W/qISuy8gjUsnr1wt0rWuYuyupFYOQdH2bFaH5WzRH3Q80RHuDAO+0tMuq3ueemRSkEmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gX5uPWn9; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gX5uPWn9"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ca7c1176317so853407a12.1
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 14:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784843740; x=1785448540; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/9Vkf+SH2DeryCQm4xaIpblRo96pf41ZoqZ1k6gyIpo=;
        b=gX5uPWn915qOw+iDS6ttmrin5k3w59WTk/or2QfB7pGxRNohGGjp6a4TdDIb9nMJzL
         D6qk1kXcYNw1NMM+/u7Mh1pjDlr0aahPf5PC1AxotNc/NXHG8ccKTzy0o+9R2iIFICit
         CNz6AwwkbBLm2t4LXV6PCPxXioqT74J34qfh1CpNidqdeC0cfYHem7XHrWf1LDoAoJOC
         /pLBAoKrJe9Z977lU1hD1IQ7A3E7o9L4RZccptJFsjrIgAZRQrTSjzfQqRRUsIbe44eC
         ZA5JOKvmSs51haClpqD08XemDgTt6IBulXAAHx7wVpbA7TkK1sEcRnzTnOxnVE0ltGTB
         Qfzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784843740; x=1785448540;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/9Vkf+SH2DeryCQm4xaIpblRo96pf41ZoqZ1k6gyIpo=;
        b=fbs6Xd8sFLjwicXYKHyrDZOvbVAlmIFYeb8BMkEPUXeqf3iHAuWFY35n9jBDQPTtVx
         0MPxCZ2eztptzYcfDMEPF4f6utdLmaJu1NhcyrRLzqHwNyACvMQ73Ufe/tPkAb98k+m+
         jy6MCNY3Jud9QEtECMWyxTUfLBsjDEQccXT7zDRmm9Fo9NKwvN6xMobPNkwUUhW2+4ar
         hNbTG9qFhwn6Iuz85r2dV6KP5hU6CLIJOXmBFK+X1fMlMy3Js2jsJttIdYaGFgsMeLIW
         ytOU2UNSIjLRc63btWosCTEhtB11Kpa/aMYv8dNT9n26FvrtNIKXwq4NyTAcmV+Mj5ga
         FvjA==
X-Forwarded-Encrypted: i=1; AHgh+Rpo8YC9T476b6xafMn6uC+FjyyzgGlj51jB7aj8qS88eHIpLRBdsvOhtKVBI48nn1Oy2mE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuWY1EENklyniJFo7xVSnvbJXbuuvmRyk4MJc+rEB3+hrsL/XP
	9oME+FvuBXZpykG5hCSeUQwLvEdLn9i7cTSduD/CLGaSW0aDH7uHdru5
X-Gm-Gg: AR+sD10lNk8PadkT6OqymEjezlO1/6rdjIbm4hwbgIL7Vgf/EOyzi9U3/PxIIRBqK9d
	OHYycwoz9gfgVCHP3u1m6HYnX13YqbUH4XSgn2Osc3RI1bME1VhcjaifqXsj9FT/XfTVZI8Y7a1
	gJ6QrBUwhTWh0LriFoTMP8YDUCOZKPkDcs+0KX3BJWTW91OgT7Ze1gZQfr0MqGfADal3eUXxOiY
	CfKWNdJ0x1PNQYzcDPJtxB0VVpOUVgeldxIOPBkrq4PJCeFGcKTIrF70k9OvN7u9Kml8+ogh59q
	eWJApWxHfNtFcX003YsAqmAYgSgg91mZZ1pcbS6xjwQKTmnuDmk4+HlHTe2KCZklVul8OP0Sx2b
	IkVZ8KST9VHA/+kJ9Y0cy2SgvD1/W4W9wCBIf19dDl8hrSNc4nReY4Szu2ErW+8o+5I6gW7qoY5
	DlEJg/ewtiR40AiukYpvvyZnEn+Jz0V/wgiwLt6gaKU6FkplDyU1f25MrtZkk=
X-Received: by 2002:a05:6a20:9f88:b0:3c4:203a:c334 with SMTP id adf61e73a8af0-3c44b21d15bmr5778152637.55.1784843740625;
        Thu, 23 Jul 2026 14:55:40 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:c221:d012:6e37:77f9? ([2620:10d:c090:500::2:8dac])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e0818e4sm22867016eec.22.2026.07.23.14.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 14:55:40 -0700 (PDT)
Message-ID: <e3fe822d1cb593c0ab78f20e2f16b2a832299ea3.camel@gmail.com>
Subject: Re: [PATCH bpf v1 1/2] bpf: Reject passing scalar NULL to nonnull
 arg of a global subprog
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	memxor@gmail.com, kernel-team@meta.com
Date: Thu, 23 Jul 2026 14:55:38 -0700
In-Reply-To: <20260723202456.3754267-1-ameryhung@gmail.com>
References: <20260723202456.3754267-1-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-07-23 at 13:24 -0700, Amery Hung wrote:
> A global subprogram argument tagged __arg_nonnull is set up as a
> non-nullable PTR_TO_MEM. However the verifier does not check against a
> scalar NULL, leading to real NULL pointer dereference. Reject it as
> well.
>=20
> Fixes: 94e1c70a3452 ("bpf: support 'arg:xxx' btf_decl_tag-based hints for=
 global subprog args")
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Amery, git am complains about merge conflict when applying on top of
the current bpf/master (`patch` can apply it with fuzz). Because of
that CI did not trigger for this patch-set. Could you please rebase
and resend?
