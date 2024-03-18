Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB3954FB2
	for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 17:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710782461; cv=none; b=M+UqpQwEHKrLLSfsaAGU2k/Fth6I3RDHDvfuDy01rVP1DR0GOeQC2mtFWGw9s9kv++oazB3kChV4JdwiQe7doFlCcei/JFmTN93sGhWQBxSst10F4w7CpOBe7lQtNlIrJ+l207C0fuKboxyCTstptzBIgV7dlfJX9PBNpzCUzOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710782461; c=relaxed/simple;
	bh=HL7cWsqv6BkO++4aE9Eh3LXes/vIrgtdyA5NR9dC82s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qkuqMDkQKbt96Ve7OfzuyUQtYXYOrD5A+iIynQbiOu6bJGsSeC4zqkds8UxS/HN1tu0ojI0sfxO7GyX8T33hG1SopW6Fba6z9Kc3L+vHQxxZIXXUVG+Q1Fi9tRy5Ykc38zsjuZPmB5oIWSfy0LEb1Byv6Y/g6UM5bifkuknzqFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R5eTzmpV; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R5eTzmpV"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-29fbe1089b8so625396a91.2
        for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 10:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710782459; x=1711387259; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OwRIFlIftdnHEAxr33vl6ATdgCEEHSOZQHwQcHxHZPI=;
        b=R5eTzmpVrndvpFVld1zmLJ+lmQ1dbSoGmkpAVl6IviBLlVp5Mc0zPAQw5qoqQVsCu3
         MoOMvf7BHSfvdodym3RA7kPYkNJ8Xn8AtWiuwrSlUAPNMLuFR3/WH2qsnKDDVjm9mDZW
         NC5ZbVqrHUlJQ1ofFDkVCNwI3JdQEm/qg3iC+wrejFPbfiXgnlo0wSliWtWSZ/ZDHmB9
         +cD/YGJ1PAK8R8QJuKmozwDx8qR4voW4X5suvdrmYz1Jojzj1F56hFVoGRHpqRoO5M5H
         r+ODnsDXJTmG6II2f/8QGF7YtSLC1T8ardO6qScLqM8uhQzZzrZY7rkK3IL7KG8D5sF+
         2Jpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710782459; x=1711387259;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OwRIFlIftdnHEAxr33vl6ATdgCEEHSOZQHwQcHxHZPI=;
        b=aJjddxdHVhr9T9ujYAhgVZcC+LMh7zhbEZ/VBpzl17Zc3q0wZhPIL7TDZlHl/JWfTA
         1W0crIX1tcEWCSonmE0QXyY0dTfYed6cVqB6TjUpMcUMXIkFu0lkskxyL48dHW+vpkaq
         ifXMrAyt0dTrtDWbHPFSI1bM0Tgxsc4B5RvQKeqOsC9F7Ao3YFvjp6gJy7w5QkA6+q3n
         bC3Y58j3SI/PuCx/qTxNj4VxHnZWLcQubbtzjqCxnFtvuemTpsfQvzKpTjKcbFwEV3yW
         YMkCD6v/N+uRZQuqbShlv2D/7Eid/5MM4W3wPCPEJbWiUtmQD0xPxv/e8aWmjXiVO+Nt
         UhVQ==
X-Gm-Message-State: AOJu0Yxu0Q4aG/I2dLvXwk8lyTfg/5lszEFTefU4WA1YaxmKpq2uelfq
	NU/PXXfBxhpjiEy5q8cn4vczEH7LpdIyK6QktTEjOKeth3Z5AKMPOeCWk4MKaxsttg==
X-Google-Smtp-Source: AGHT+IHB7x9D7I8hLdJZqfWVFPfgxt98oYB68uEkAqDVWfrmhn2+aw3FcMvBJubV+HOtNt7E3XW6LYg=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90b:1bcf:b0:29f:945c:45ac with SMTP id
 oa15-20020a17090b1bcf00b0029f945c45acmr13351pjb.5.1710782459422; Mon, 18 Mar
 2024 10:20:59 -0700 (PDT)
Date: Mon, 18 Mar 2024 10:20:57 -0700
In-Reply-To: <20240315204524.967664-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240315204524.967664-1-andrii@kernel.org>
Message-ID: <Zfh3-SlHc2kcFcCC@google.com>
Subject: Re: [PATCH bpf-next 0/5] BPF raw tracepoint support for BPF cookie
From: Stanislav Fomichev <sdf@google.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="utf-8"

On 03/15, Andrii Nakryiko wrote:
> Add ability to specify and retrieve BPF cookie for raw tracepoint programs.
> Both BTF-aware (SEC("tp_btf")) and non-BTF-aware (SEC("raw_tp")) are
> supported, as they are exactly the same at runtime.
> 
> This issue recently came up in production use cases, where custom tried to
> switch from slower classic tracepoints to raw tracepoints and ran into this
> limitation. Luckily, it's not that hard to support this for raw_tp programs.

Acked-by: Stanislav Fomichev <sdf@google.com>
