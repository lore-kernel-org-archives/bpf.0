Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C83E23A9B3
	for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 01:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769821921; cv=none; b=fEhg1AWPgjYKKThyZ51eHn83RL7PQzp0lZieLza4OpFuOuYqb+RCEJw1YD3gkSEO9wv1pwurZDixvdPNZ480ks3U0fWpqKObb+z5UdNeidMMhkUIzFZ/s4Np6DVA/idv6zscOC7PDJa7vfR5RGDG53JdNk3hur/WdbTj3vVCWVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769821921; c=relaxed/simple;
	bh=P/AkJ7VMQl7xg3h+SCs73opP330uFlSO7pps2YFNAtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nvk1bif7kpbRCGsMuG3aPBxMy+nRYci4BXsponrco0n/cKJzYCIk2KfCxfYn+WHFgviyqgbL9eD3Fth4a3Lm+fLJ9D2L2h17L8bKKWDYA/UXa9FJtuW7a8DXaVfdyD9rmcCqE/4CesqCH8c39mUWhE66mVZfGzSfMKluMvS2dE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DbM1u7g6; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DbM1u7g6"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6505d3b84bcso3488260a12.3
        for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 17:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1769821918; x=1770426718; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EPpl6A64UKlYlKR2j1fRkib4LdNnz2WqgktVIjm2uzU=;
        b=DbM1u7g62eaA22G12YDCgw6FfPrC9AGXLGX7iF0rNmBPWfv/u4ap+cNzhL1tarzl2z
         40elyx8w5CpfIYhbj9YfS3kVs9khisjfZ6QFIDLnMrK5rB9ANTysweVCAImtMiQM7iZt
         bNrL/HGnZy8cozCygh8QbZd8D7rEEsdY84Zew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769821918; x=1770426718;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPpl6A64UKlYlKR2j1fRkib4LdNnz2WqgktVIjm2uzU=;
        b=Y6zix9ydTDRSzYkMq+kcoPxrzUv6nRZn9yo5nAIIMf7vormJ32KINiHsSQd0xSvTAo
         Y8tT7bJ9qy4JZ9NgB15qfdZu6sFsCUclw2VICfW1ifOx1BE4iVVIsAxbl/0GJFDjWc6r
         lCwsZTeSAC6YXjHba0XgzPU5ooS8VVCaVYlCrOwF0tQ4O9pYLMN+Qwl0cAr5cW0OxC7A
         KPrLHP1fDuAj3O2uvVZYPkvvxveVMw9kqm8qFREUiokEQrK0kXLeiMJElkiqp3iwoRAl
         3GlcZNVVfadUUy5ZjMegyBW8eQnnWBAtQkXcDTUHQxj/QWYYffe9zptYG3zMC5foGL9+
         0chA==
X-Forwarded-Encrypted: i=1; AJvYcCW5Zwt1CzovYcyeTjsIZI29roeMtLBBCXZK38+4Inh0OKPQwIpdW6UciPZWErkmkxpQ/Wk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuINNrYRHopTPbPv5M5GECvyH6zK8DxcE7l2f2KJH6X2bGQ6eI
	Q408IaFR98sb9ZDRsq+AwEWrtAdYZeBDt1KFJ4+RG5KEEMMUjM1Sa5Rtsh93rYtCA94xXqW4lW8
	CVtK+M+o=
X-Gm-Gg: AZuq6aICpWpcjiRLkZKb2znPQ2LNRv/cQcD5ANv99N1AfhY5cC2O8zGeKvZ7mxXyx0v
	0g4+sBC5uBQ8APZNzrVuthVRAYuu7Ww/FgNnUe6aKaL5IWDkTOCZXCLKA11MaC8y/vPlzmP5pz8
	o31ib/H8q/w8YoHn8LzcdxFfNLLitlpemjNc3JEjHPFXzGOYTGP1OPnULdrZwadJLSmtHf1g8RR
	pSOowzCUnmf0znxyVFCFyRZO9GaWGrRpyBpbRGuXZFOnjkc6KGW3r6OhrVcI/uvdofo11fZ3L1i
	5v0Dn1SE5d5HFhujwA6ka5iTYl3y2jRRl5jDjtZNTepG7nxdY7/a1sslyaFThd9EltP1hwxdQ3l
	EK/kFFTdsHrkfKbIGDQJYba7Q6mqaJnkc+p5DQM0o0prNGh+cUObmwnAWO96W6yg+bcb8PmxEe9
	uvQz/ffh+m5SDgaTjCscgVMAK3amDAMiuciRkWF6NSFIb80QE2YKj2Lsvt4v1e
X-Received: by 2002:a17:907:3e89:b0:b73:667e:bb29 with SMTP id a640c23a62f3a-b8dff515b6emr279039466b.8.1769821917700;
        Fri, 30 Jan 2026 17:11:57 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf2ed6edsm511692666b.68.2026.01.30.17.11.56
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 17:11:56 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64d1ef53cf3so3390081a12.0
        for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 17:11:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWoiHKxMc5CseOc+kW3bh+oUTCA93GJdbgPbNO+jf2Lo3QwI8P7Ayma7V+Rb5S6vaenslk=@vger.kernel.org
X-Received: by 2002:a05:6402:35c7:b0:658:ba49:96c2 with SMTP id
 4fb4d7f45d1cf-658de54e61dmr2863591a12.6.1769821915767; Fri, 30 Jan 2026
 17:11:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG2Kctoo=xiVdhRZnLaoePuu2cuQXMCdj2q6L-iTnb8K1RMHkw@mail.gmail.com>
 <20260128045954.GS3183987@ZenIV> <CAG2KctqWy-gnB4o6FAv3kv6+P2YwqeWMBu7bmHZ=Acq+4vVZ3g@mail.gmail.com>
 <20260129032335.GT3183987@ZenIV> <20260129225433.GU3183987@ZenIV>
 <CAG2KctoNjktJTQqBb7nGeazXe=ncpwjsc+Lm+JotcpaO3Sf9gw@mail.gmail.com>
 <20260130070424.GV3183987@ZenIV> <CAG2Kctoqja9R1bBzdEAV15_yt=sBGkcub6C2nGE6VHMJh13=FQ@mail.gmail.com>
 <20260130235743.GW3183987@ZenIV> <CAHk-=wgk7MRBj4iwQLHocVCa94Jf0cMEz2HzUAS9+6rGtnp4JA@mail.gmail.com>
 <20260131010821.GY3183987@ZenIV>
In-Reply-To: <20260131010821.GY3183987@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 30 Jan 2026 17:11:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiXq-bPyKywNOw7z6ehrVReyS-hSPuQkJvuhJWfXGFm=A@mail.gmail.com>
X-Gm-Features: AZwV_QiG_nByRrd83VYAdhaCU5_carsYUlImGLyJR9w-28CTqo3phlyWLRwFL8I
Message-ID: <CAHk-=wiXq-bPyKywNOw7z6ehrVReyS-hSPuQkJvuhJWfXGFm=A@mail.gmail.com>
Subject: Re: [PATCH v4 00/54] tree-in-dcache stuff
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Samuel Wu <wusamuel@google.com>, Greg KH <gregkh@linuxfoundation.org>, 
	linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz, 
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org, 
	linux-mm@kvack.org, linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org, 
	paul@paul-moore.com, casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org, clm@meta.com, 
	android-kernel-team <android-kernel-team@google.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 30 Jan 2026 at 17:06, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> I'd rather go for a spinlock there, protecting these FFS_DEACTIVATED
> transitions;

Yes, that's the much better solution.  The locking in this thing is horrendous.

But judging by Samuel's recent email, there's something else than the
open locking thing going on.

          Linus
