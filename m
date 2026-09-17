Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4204B95CA;
	Thu, 17 Sep 2026 23:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789688992; cv=none; b=d5t5qicqqrO62gBo7JiY9FrBUKivYLOq8X5pao96WideENI/Dqb+9tUd0TyL6yE7r46Ic9ZnYFtArCpTKuGK4RN+zrHQWt600lwHu2oT6RHmHySquTyDiQVes8QSqJ7NGMNCv9qmjP7rNSjSLbaq5px3ODUtnKnmvekwDuDd+n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789688992; c=relaxed/simple;
	bh=BfjdNtrGgXRunj6vrF+8T5hsFHx3zNyHhGMGqUitE6I=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=UwQ2zhXu2Hue5S/uvYFz7OpxeKMmKkxx4z1Dz2qpUjaAv/NBORbtBwX9GoHizUDV+cVLWQ7GMH7rF31/f85/9T3Kd9e2XlQoBO2S+JgzqSh+S4PjN0oIZa2SofG4Rx3rmm0o/CT9lDNs7os46nbFaW2yHQq6JCkXYSI7GnQEh9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AO2NOfFW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AO2NOfFW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF881F000FF;
	Thu, 17 Sep 2026 23:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789688988;
	bh=BfjdNtrGgXRunj6vrF+8T5hsFHx3zNyHhGMGqUitE6I=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=AO2NOfFWhVppQdHuyB/73E37hae9lvfQWVqppGolyZuEYLo+ya4Mu6xTwenAQ1JCl
	 Kq5b+Pazf/l/w/nMorJPF+7Y+AlHWTSuQHw/sBKGkc0iHJOPYoXFV4+wRVqRYO5rqK
	 DBB3+b0WLW3O7hTP475ydoJQ+7rYDqeo0W4ftMuYs0DbqQR4EAvMmyRlDcoplTYUk+
	 o8XKYCXZHyfmT/aAyQLmEE8OGoF8801uATu4t3/HQyZ/865OSg5scthJ/45KTOD+GG
	 +1jIR78bPjsSN+L76n2Q5Jf3D6MGy7i4NzRBlS1jy9ZzuVEoATrYWS0BpSK/ZNFoyX
	 w3zwxYqnsQthA==
Content-Type: multipart/mixed; boundary="===============8728234185582942083=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <218a829788764892856c729b4b4b456b8216275caff7ad88c1010e392ea1217d@mail.kernel.org>
In-Reply-To: <20260916195203.1099646-2-ihor.solodrai@linux.dev>
References: <20260916195203.1099646-2-ihor.solodrai@linux.dev>
Subject: Re: [PATCH v3 1/5] x86/cpu: Factor init_cpu_info() out of identify_cpu()
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,bp@alien8.de,dave.hansen@linux.intel.com,mingo@redhat.com,tglx@kernel.org
Cc: ast@kernel.org,andrii@kernel.org,ryabinin.a.a@gmail.com,akpm@linux-foundation.org,hpa@zytor.com,andreyknvl@gmail.com,linux-kernel@vger.kernel.org,x86@kernel.org,bpf@vger.kernel.org,kasan-dev@googlegroups.com,linux-mm@kvack.org,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 17 Sep 2026 23:49:47 +0000 (UTC)

--===============8728234185582942083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> x86/cpu: Factor init_cpu_info() out of identify_cpu()
>
> identify_cpu() unconditionally resets the struct cpuinfo_x86 fields to
> their default values and clears the capability arrays with memset()
> before rescanning the CPU to fill it in again.
>
> However the boot CPU capabilities have already been scanned by
> early_identify_cpu(), with interrupts disabled.
>
> Introduce init_cpu_info() helper in preparation for letting the
> callers decide whether the reset is needed.
>
> No functional changes.

This isn't a bug, but would it be worth adding a line noting that
c->extended_cpuid_level = 0 also moves here from generic_identify(),
which identify_cpu() is the only caller of? That is the one part of the
move that isn't local to identify_cpu(), so it would make the "No
functional changes" claim easier to confirm.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35285131592
--===============8728234185582942083==--
