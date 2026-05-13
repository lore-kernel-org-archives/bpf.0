Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCDD35B632
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 18:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778697375; cv=none; b=hcOVGbXId/11o71j/A8Xp62tUzFaAjQ0Sbrj3dlEsj3zWnj0cryWSeJQy6z2+6aVNoTU/nN2bjyLIT7LTkC+O+p5v9qjBHlV5YhCSPHFDYPhv6879KTFw5zrLIS0NZSgvzPoy94Y45NdE6llRoyHB5n4PKoJosboLxTH9mhWA8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778697375; c=relaxed/simple;
	bh=rO3h1Z0IMdUe40XbniH7Syeq4c4URoeuKQNA3ehrqjo=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Subject:
	 References:In-Reply-To; b=FsbVcPJvlAJIN1w9ZLIzcJdjTCap0FWaMnOp/nNygEfvaNdCkzZHAsdlu9gqys6mie/Oxv+sDxlqOfKE1oR6XKVfATLobORCsXt+f4ehaSZa+yWOLMODsFCPL1A3W6G4yxsv+STZ+13+KlxJ9me+0ou5PvGZhix+2COWAj8qvD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=L+JVn93l; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="L+JVn93l"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-512f750d4b2so56518281cf.1
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 11:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778697373; x=1779302173; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P2T1YkP403+tJ+X3WhxlPcahyNJiY7q6QXlcKSX4nKU=;
        b=L+JVn93ljCggkMDRrMmIQOy+ciQrWxjROtkJXOeNISU2XT6bdwnTLW9cnFpAOCb3qW
         hj7l6kus1Tg5JCyvFnieHdneRhoG0MZZiR8Gg6MYf6IUkX+C1oI7ex3/+pl6lwYz762+
         0dZ29t1CW5vj79bKQsDAn96DY9FuVB0+jfEh696a39fkEwg1Q1Gd6kGZ2LwZrSX5ZjT9
         YEbdx8lvyMeF8EtQer+i20Xj4UYzmDU59TcYoOCR1y693DT9Vy0Hsw2jGIPh5ZRR1gNG
         V+Xdy8dBcmPk9EYc6uZL73a38kbvOgELR9YtJrKFI1hs8qF+b+mDxrjAepdXSbimsOmX
         Cw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778697373; x=1779302173;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P2T1YkP403+tJ+X3WhxlPcahyNJiY7q6QXlcKSX4nKU=;
        b=hqrtjk3eY2QUXKfJ2yYXwbKwQZ+kgbAkSAeGcHmwgVsXLwBhkPJP1NiCp6S6JtrDtn
         T/IVFUnCBa9QZXp/+1MJAAcwJeNJCTopZzXdLUkNdCc3DjAhJviiMQ6dPPAkPF8bW8DM
         uaTO/ndC/673TkjcMcze67W/PSCtnEx/7t7lpAubsZeNfsBaAY8a69ybk0gGLAMry/tW
         QYPzFWBqjjxw5BoCnTG2Hd+t4XZW7MleJw8zfK28y18viOGwmD4xxZD6EUPGOqdEOEQ3
         eq37jWOk1r6UjLFOh0ZWDABEprekjVEYqsylkC14dqxWedL4rMOsyZ5IhNd730pXDEb4
         nVSQ==
X-Forwarded-Encrypted: i=1; AFNElJ/oBWQ2sb047GFMq8oQM95iz0nvVJNjHyeZjP6YBirOxJuYbHYLnWSN8UgaD0xrkIQZAeE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2iVUnkbHA4qi2xn/GOSAHyEREe8VVAkWcB9nMXgFHy++6N9hU
	NBqIjedXYqwKQmsUHs6U1G/Tb+Fss3PQU0W16fm4DyJzYAKXL/zHiKZSMEg3vqR41Q==
X-Gm-Gg: Acq92OHEkSh/bEmvs9od+qZnU/B7SnCGVc/tVB/uqnYla4jdmhWgc97tF7jbXr5Z3KI
	iS672bMTCf22/2t+8kMBlZomRIx/6Tpwu+gU8ItN+OpmZYTtxYN0+XPyHzWBy6IA6AHWPaJhlYj
	C7IwelgK8Q2vJINsgol/VLwCy7vRhE/NJjx0cRqS+L60Z3JgYvbZgvfPJi3aQtArnmsDOYp+SY9
	xhqTmL05pUzdQkeVWErtnCGu+4mNBKOeCqltUkPd4huwg2j5Q7mClFlLqDcCdsuf9vTXQBhucrq
	s0+rsSXzIxUDT+m9TAE8JtVwVTykUMhy65h2js4lZkTasOuewmAgkB9yRfJ/Yj2dyGWxb9hOW2K
	Pltz53G9ZZbCAgaXXEuruiNL6QSWDogW2AHwPobZfh/SYqT7Ddf+sBl5Io5L7FIvW+L32f6MuWD
	iQ4aRwWCtLx9lET/46EwY+G4EIXHiR3ce/CcDk8Wg/ZIDsd2CLbCB7Gga6kYzPPr8O4aG3UCsEK
	JFIMK0=
X-Received: by 2002:a05:622a:6d06:20b0:516:3183:c1fc with SMTP id d75a77b69052e-5163183cb11mr38795191cf.50.1778697373350;
        Wed, 13 May 2026 11:36:13 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90bb82a7asm2888936d6.37.2026.05.13.11.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 11:36:10 -0700 (PDT)
Date: Wed, 13 May 2026 14:36:09 -0400
Message-ID: <f367fe9b2695df27e47f4836d0f51fbf@paul-moore.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260512_1604/pstg-lib:20260513_1343/pstg-pwork:20260512_1604
From: Paul Moore <paul@paul-moore.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, "Blaise Boscaccy" <bboscaccy@linux.microsoft.com>, "Jonathan Corbet" <corbet@lwn.net>, "" , "James Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, "Andrew Morton" <akpm@linux-foundation.org>, James.Bottomley@HansenPartnership.com, dhowells@redhat.com, "Fan Wu" <wufan@kernel.org>, "Ryan Foster" <foster.ryan.r@gmail.com>, "Randy Dunlap" <rdunlap@infradead.org>, linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, "Song Liu" <song@kernel.org>
Subject: Re: [PATCH v7 5/10] lsm: security: Add additional enum values for bpf  integrity checks
References: <20260507191416.2984054-6-bboscaccy@linux.microsoft.com>
In-Reply-To: <20260507191416.2984054-6-bboscaccy@linux.microsoft.com>

On May  7, 2026 Blaise Boscaccy <bboscaccy@linux.microsoft.com> wrote:
> 
> First add a generic LSM_INT_VERDICT_FAULT value to indicate a system
> failure during checking. Second, add a LSM_INT_VERDICT_UNKNOWNKEY to
> signal that the payload was signed with a key other than one that
> exists in the secondary keyring. And finally add an
> LSM_INT_VERDICT_UNEXPECTED enum value to indicate that a unexpected
> hash value was encountered at some stage of verification.
> 
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> ---
>  include/linux/security.h | 3 +++
>  1 file changed, 3 insertions(+)

Merged into lsm/dev, thanks.

--
paul-moore.com
