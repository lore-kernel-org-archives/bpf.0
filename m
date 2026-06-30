Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8D243900E;
	Tue, 30 Jun 2026 14:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782830254; cv=none; b=HKAakKxJj0CNAwcGngvLZwYl20QrbNDKa8CRxUjLXV4YTr/dxGEG5kUVOX3cjxlDklY0jWHuFytWgzke2oQqwXI75FsgBG3k2FArGvrfZzUXePj1oPv4HPud/DQKeseaCZTF5e5bV9yHqtbr1keTrHuceSscyBwHdElFdUKbHGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782830254; c=relaxed/simple;
	bh=qYkGTJXbPXZcHnt20w8gJCZ37O5G4G3Mba+cie49R0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWteplM4Qs0U7xBke+uylZrER02fHXC5Tb6Mu9Ymg8FDFOHP5pvXhSgTT6Anwe/mjrzPU/wuOt7QekPXqZvS20eUJGBgTBrNF4zJYwQiWR+RaLAJZdE4dKCkKX0yC1TrN4luXMPs2/vySA0jazLJX3XFx075rryq+DmIORJIddE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CgemoEDA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D5H2UWkM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CgemoEDA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D5H2UWkM"
Date: Tue, 30 Jun 2026 16:37:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782830251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ezLN1M9JlwArYj7BBJygaHQ3CcZPQGglpyFqaQ1V4EU=;
	b=CgemoEDAhBhli2MXnGblrEhYV4/HcyVG4Xjp+/Gd2phD6kvZ1O2qSs1SIjc0nbTGDvSe1t
	SUJgsFTMOKgoypA7l9oYtkoLES9+TVoa4dzx1NmzQlSTu0UbjXTPPVl7queu7A0B036oOl
	+mTf78Onz3uOxHkVFhcZhJXi4AQT3wzFKLh7ZDLlloV7JEPFhRHH+VfT+XErIq3g2UR85A
	STi/ttIDIN1dryJa3rHioQ6LwN6vECe0c+OC2C5wMP+AVoLXLOPYe2/WkueA8QNKog3IFk
	hs3ENulEsxDhWGQEaiwGDa4zWbL8cCFIic4c/wm3xEpvKXuMR+tzrug7dBSBYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782830251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ezLN1M9JlwArYj7BBJygaHQ3CcZPQGglpyFqaQ1V4EU=;
	b=D5H2UWkM9IozabpBUu6oLVONiIjo5RguuKx2l7+CVKip0gjzunesfuYXepr0BBWbXW1QU0
	33ipBUNDFvJMU6DQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com, andrii@kernel.org,
	memxor@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net 0/3] Fix broken TC_ACT_REDIRECT from qdiscs
Message-ID: <20260630143730.ZhXWjEIh@linutronix.de>
References: <20260630123331.186840-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260630123331.186840-1-daniel@iogearbox.net>

On 2026-06-30 14:33:28 [+0200], Daniel Borkmann wrote:
> This is an alternative fix to [0] in order to not uglify
> __dev_queue_xmit() with sprinkled ifdefs given this can be
> simplified and isolated through a simple test into the BPF
> redirect helper itself.
> 
> I've also added a proper BPF selftest, so there is no need
> to check-in a binary BPF object into selftests given we do
> have BPF infra for all of this.

1/3 makes sense. Assuming we wouldn't have this per-task memory
assignment, wouldn't then the state from one redirect leak into another?

For what it's worth:
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
