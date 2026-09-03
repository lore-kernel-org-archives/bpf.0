Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973404A92C6
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 13:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788441197; cv=none; b=R+EQvXdjcZ2/oGeXIQJPNe9X+gjM43sHB3NKWsUBnx+DKYgpzxfy2+UdYbvAWcdgFCIxSn52Njuq2UFNQuZS3/amyU3QOadxDKPpmterGftXj/QBkY2SSlmgMmzzYsxKzinG5duR7mr9HqnEF2g8xCdB0oSpQ+0La+dVYbzxFwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788441197; c=relaxed/simple;
	bh=YfhrJ/RsU4qXyUHZUbgKLATh3vnW+x8pyI+69lFyI1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqD5ZwbWArEY9maAesza93ApCn6ecdxZBsOFab7lxmbX3t3fGNYHWj3PLLLdElyxDARzYuYPTlB5PzYNTG1ELpklRn2lw8V9VfERoOInfdX/5+8JgMxTLSk4KOMCR+PgKJRfO/oN5367neTKYN++YZlXno18DqMDuqnppND0m/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQ/9Nbbl; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQ/9Nbbl"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c25fbcf5d44so70164166b.1
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 06:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788441179; x=1789045979; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=F7q5cK/wUKU6kkZjsGx0QcDU5b5co3Eimifh5j77YDE=;
        b=nQ/9Nbbl8weE1toKLcVNPmybDARfVabaN+NcqykJwLqGLsZum0rdVcib+YNZZqYxa4
         AZDA3QjSNCGKqbjse/w82dkwZLVY4Kk6KDihgBhllIQJHSoW0vYYQI0bTz2M/XEtKtii
         tZr8Ldw1WxRtUJmNSK/SEjBXZlj4cIdTvxZkNma1KD8CxZXK7lRQBGP2bV0d80H11pW8
         jhFGpzubdRHAuw6n2mi5YkKXxkg1Yo7kBknUe5LEREFqHbNz3uFmQ5I9EpNmfycsXSaZ
         xECJnAjE5RQShw4ZABqWHaJHdfHqI1ZWAw1NDdbAldl+U0km0N/hYEbpQ27MbPVQIFfv
         NMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788441179; x=1789045979;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=F7q5cK/wUKU6kkZjsGx0QcDU5b5co3Eimifh5j77YDE=;
        b=iKUV9G/Ft6Ucc0uG4u08Al6DIQQb2uTc1jNoq+6jg+6Ane5L/oVW3DysbyCQKWrjpN
         uK0mD7J7oicPe+UtG5Wu7XoTnvm2JBA9G4PuNxXoksom8owkWbNYrVMFUMEy5IYtpCVf
         MxDFOjsR4L4hpyWvgxHWKF7dTkgpjYhKUsvQeLHUquR1RpDS5zkmf0LyyIcHnFZXS365
         xY7lGsoqcPeWYD7nkRg3XW/mJJt1rb8wzocUV2B9zOFXAlGIwMvUVyCl5HzqjFecYl+C
         vyKfkguNcRew0nzpy6a0mu5fQ1dvfM16MmwHIOj7P7gNHe2KvH7ARsI3wDmgR1if2zbH
         eLUg==
X-Forwarded-Encrypted: i=1; AKwUvBzVy06U/7KybcRm/0tV6HrXbX14QAXaVIhyQtMy2QAOj5aKHihQFyPYCiJUo+CmWsXf9J4=@vger.kernel.org
X-Gm-Message-State: AFuF++m1F9sBn018EQEgJwVlsEknoyhwipD+ysc0uopHKRuiCJoJp/8T
	4yqaZwdkTRhVMQIUmlxQryG/bFiruGjE6fDX9iw+jp5h6n9OYdxLns+1
X-Gm-Gg: AYBFou2rCl/yOClfXwKQzEftWZCoxzwkqg+A67Ran8qpZGJfIU05hGz1DAE7RVnJfaR
	CyNFdLp2dpjHS2YIiqrhMrii5oVSKAmSM6FWDp6pDBOIksqFEvVNiV7pHGiOvA1LdRSjK/Zfln+
	YAGHADigZ2Dg1iC6MC2gCA2btft3KoOvD9OiAZMwar6K/Y+MMgE8U2TGbfJWut12waj6eXAMd6C
	OEtl3/AC2Cr3QM6BOSe2VYkt6n5XLfsYrmfqf/SDKFPB3p6cDTs5CBiTysDns2GnPIJKRXfmcU2
	4LQ6cUBG7JUcopEvI02ZbYAFGkFkwKghNbHaKQX3QGD/2a65v67Kny7noFmHhf7UMzA+HACO7Oq
	AhXubGHh2PeOpP0TSlna9tE8x6yqjeMiJMXQpHRTqlS7cydfXFaxT9optYuf9/mnAjt6QXa+Giy
	jAxMpcob8Ag1C0pTc4UXDyOgUcKpdrG2b9veEwplf92WCGqYtaMVeD7j49Ey/GH4Wl6eIU
X-Received: by 2002:a17:907:3d49:b0:c25:c7a9:7b8a with SMTP id a640c23a62f3a-c25d54b6d03mr830373566b.12.1788441179056;
        Thu, 03 Sep 2026 06:12:59 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25f419d91bsm96400266b.23.2026.09.03.06.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 06:12:58 -0700 (PDT)
Date: Thu, 3 Sep 2026 13:23:31 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Justin Suess <utilityemal77@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	bpf <bpf@vger.kernel.org>,
	lsm <linux-security-module@vger.kernel.org>,
	netdev <netdev@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <matt@bobrowski.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH bpf-next 0/7] Add new way to add BPF LSM hooks
Message-ID: <apl005R08S6jdbWg@mail.gmail.com>
References: <20260831110934.241898-1-a.s.protopopov@gmail.com>
 <DL514LM5TA6V.IOW7P2WM70BE@gmail.com>
 <CAGn_itxwZcMLtass5fZQ5XqgUtwTaJHfUGxg_SK7h_vqEgpmeA@mail.gmail.com>
 <apljnyb9nNRuN2xg@zenbox>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <apljnyb9nNRuN2xg@zenbox>

On 26/09/03 08:16AM, Justin Suess wrote:
> On Wed, Sep 02, 2026 at 09:31:36PM +0200, Anton Protopopov wrote:
> > On Wed, Sep 2, 2026 at 8:07 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > > On Mon Aug 31, 2026 at 4:09 AM PDT, Anton Protopopov wrote:
> > > > The BPF LSM programs are allowed to attach to LSM hooks. This enables
> > > > operators to mitigate known bugs without a need to reboot or livepatch
> > > > machines.  BPF has shown very useful to create such runtime policies.
> > > > However, many APIs and parts of kernel aren't covered by existing LSM
> > > > hooks and this would be beneficial to extend the coverage.
> > > >
> > > > To simplify the process of adding new hooks this patch series enables
> > > > BPF to attach policy programs to hooks defined outside of the
> > > > official LSM list.
> > > >
> > > > One of the reasons to add a new mechanism is that in order to add a
> > > > new LSM hook an implementation, at least one in-kernel LSM must be
> > > > added, such as SELinux or AppArmor, and BPF is specifically not
> > > > considered as a reference implementation [1].  This is, however, not
> > > > feasible for the use cases and capabilities covered by BPF LSMs,
> > > > which are not directly comparable to those of traditional LSMs.
> > >
> > > This is no go.
> > > bpf-lsm can attach to lsm hooks, but the machinery has nothing to
> > > do with LSM. bpf-lsm is exactly the same as bpf-mod-ret.
> > > So calling everything LSM is actively misleading and wrong.
> > > Patch 1 starts this misleading naming convention
> > > and then later patches add fake LSM hooks. Sorry, but no.
> > 
> > Got it, thank you.
> >
> 
> Adding to this, there was the previously proposed "killswitch" mechanism
> which may be closer to what you want. [1] Unsure of the current status of
> this work, but it's a better idea than creating BPF-only LSM hooks... 

Yes, thanks, I've seen it. In the proposed form it is not realistic.
I was going to discuss in my slot at lpc how we possibly can 
approach this in a more safe way, powered by BPF.

> (like a bpf_override_return helper that doesn't care about
> ALLOW_ERROR_INJECTION? unsure what would be best here)
>
> Justin
> 
> [1] https://lore.kernel.org/all/20260508195749.1885522-1-sashal@kernel.org/
> 
> 
> > >
> > > pw-bot: cr
> > 
