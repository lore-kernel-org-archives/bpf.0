Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAD47581A
	for <bpf@vger.kernel.org>; Thu, 14 Mar 2024 19:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710445776; cv=none; b=C03SHN2+rYaR+E7/vv45/BMAkyM8aLTzABIPDn52PAzCiW1EXN9ukqrVyZkMFCciL0jW1Yt0xWf+XT+erI/MMZhFlEx6FHuTaum+6elYkGnnZ+NFLtkLo1WbS20Q5NYVdqddjlGwi5KdnQazM/dzHqJXQOC/b/5XxRc2vV7XIzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710445776; c=relaxed/simple;
	bh=eTb1llV14lFOY7Mfvc2Fh172nxYzr/K5JJ8fOBamn5E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YxNp6iDNq9rWIW6ioM9b4wbfaWr6QZvqxBmRJISrldx3PGJnBDLurHY9k50RfIe1qkeN2CRH5YeXtd68r9I3WBq+W+2XV3graSa89wjrEVDhtODm4ilRfbc/Q42JbaplTPQSQxSL6xIasLF6YGI9LTeAbtXhWJBUCmtOPe7yROY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4ADRTT4Z; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4ADRTT4Z"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5dc1548ac56so1031547a12.3
        for <bpf@vger.kernel.org>; Thu, 14 Mar 2024 12:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710445774; x=1711050574; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2WHGxSU9IPjQW9dUVAK+wHIU1TrHuG0KptgMPY8Ca3g=;
        b=4ADRTT4ZEkfarIrO429gLquSV6Ce/lL+2Qi/TyuwP6LLxp4/p9mieRTC6OWWDv/DEU
         0grjQkaelamlgD1zRTmXuSDkjuhmLvhBNYOiQjw0P2y/EmfeVZLsnQ7ZvW1YX9ljo8T2
         hK3RMYWdX4Fed+q5ykMKDkNASjk/EXLzBHJWzGlhGpmqRKUlmU851rMic2H3yIsURP5i
         DAMQupKLKrAw/xTd+bQxX7wHh2BY5iuO0Yc5AiiTbkZ05HQ3JEjEZ8vPJi5oZ3K9NiHD
         w8vC+DpsliRgE9RF4QyvQTESM1MZW/mFscWC8G9rK9pgfNNQZvqvH/dqfsV6VJU7ievh
         HzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710445774; x=1711050574;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2WHGxSU9IPjQW9dUVAK+wHIU1TrHuG0KptgMPY8Ca3g=;
        b=J4wTpBJALBt06A7ihKvb92pXjI2/zGrQH3I2bTbdAHwCMABOkumIRIFBZYkDC5KAX8
         CcacO7OyXeR0aGFz+qFGwlrz2RzHt7FsO2oktBKnVA7aaSXWPBOL5mjyQANNetEcIosY
         Tp6DMzLE5LLcc3u2oaGBqTWbkJO6UwXhWp0SIkZJy6ici5bZt9Be/ODidWLHAgpJ9+0D
         V9IdFmvLsJZbqI4MA2Pkb93FoYbLWaI/YLPCTFHVyORJV/7hK1cPf2SX3Ul0lhlfETMV
         9KmX2K3XkrEJsnjzqDLoxLs+fCSr5Uvys4z78lc0vfg1L7IPph9DET8TERZVgyyRpZ7C
         lIxg==
X-Gm-Message-State: AOJu0Yy7Gt1Ks3/JYXIcbdGjDVlAXRQfuzoY+mA+51L8hkWAQpEaXutQ
	fB3PpxRDYls/zePB40hlEyCjpnNN2yCFbU/iEzq6n+UiNWkaGK64e2a8WmGwElzZWw==
X-Google-Smtp-Source: AGHT+IH4dzX6VMa/pVED5Bm7/4BtgzD0/zs/ugUl5V9GqxVxxyruiSD54Q0WW/hDLdHl3MW1q/P/ck8=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:d4ca:b0:1dd:a324:30b5 with SMTP id
 o10-20020a170902d4ca00b001dda32430b5mr7985plg.9.1710445774438; Thu, 14 Mar
 2024 12:49:34 -0700 (PDT)
Date: Thu, 14 Mar 2024 12:49:32 -0700
In-Reply-To: <20240314000127.3881569-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314000127.3881569-1-andrii@kernel.org>
Message-ID: <ZfNUzGekvbipa7im@google.com>
Subject: Re: [PATCH bpf-next] bpf: preserve sleepable bit in subprog info
From: Stanislav Fomichev <sdf@google.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="utf-8"

On 03/13, Andrii Nakryiko wrote:
> Copy over main program's sleepable bit into subprog's info. This might
> be important for, e.g., freplace cases.
> 
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Stanislav Fomichev <sdf@google.com>
