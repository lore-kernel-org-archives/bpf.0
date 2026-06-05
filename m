Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632F13B893B
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 05:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780639175; cv=none; b=VN0iAzFVv/M9xC7TpmnSTbnb4rYuuBiL+3SF7QaM/AlpqaurYV73zXJTn8zxbP6HrtxpsY6N8DzM6RefwtAJduNE0lRSZq7hP437uYdykKQfMEyQSklB3GdQ8X88p1p9rsQ8KeaY4GDkubqPHiuiy+rYHTdhbfkMAisCn30xsZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780639175; c=relaxed/simple;
	bh=8oFIKCDyTmUGffBRusxKyxwTlwmM4KQR3rq5Mr/CfgA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NxrVMP0YiyT+6MGQ2mpG5tvBnORu9TGeuprZAAZmH45Tu2jOA+ZxgeIj3r+FYgJVj047hA1QcCMxIKazSA1qaxYHKsb+fzbQr2BkCUZbKM2IXTQF2KgwB+wzKt1F/EeqM9wLKkpKpLyJ6f1PHOtyCNB4VpeCk4wf6yE6hfwNCmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfZ9m5Eu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfZ9m5Eu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF3D1F00898;
	Fri,  5 Jun 2026 05:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780639174;
	bh=sCy7e1W4vb2rlLBa5iuOwc6lPMyumNTcVGD4yBbpOuk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jfZ9m5EuHO7Klvrt6GuvuMUUFerso2z8AYirLSnszgDxvrDu51/zCY+MSrhCSnVnk
	 2u8bAhRPeyo3/LJojlWPsjs8jDbb8BxZEPD2oyddm+iDLmpRhkCLCwe58nqVhTver9
	 ztW5aGpd3Kf6ZcUT/fKstj7lDyQVCDskHPdnV1JlWzJmS0oGySm1+oRZtJnXeE+nvd
	 kloZ6SmLljpjoiEkMtkeL84/Zcq0kKrb0kadc5rKOaTeeAg4cIrHDOawaI+5Y3DKq7
	 g1mH+C3A92y49uCO/xgGulQMlMEIPBtk3NgT48HvS2MTsCFLHiDbXnETF0jv2UQqSg
	 zePJYsBAxwryQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/13] preempt: Introduce __preempt_count_{sub,
 add}_return()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Boqun Feng" <boqun@kernel.org>
Cc: ojeda@kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260605054128.5925-4-boqun@kernel.org>
References: <20260605054128.5925-4-boqun@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 05:59:33 +0000
Message-Id: <20260605055933.EDF3D1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Operator precedence bug in the commit message usage example.
--

commit 7f1eb356534806694deb9a4e04de28fe3e6692ab
Author: Boqun Feng <boqun@kernel.org>

preempt: Introduce __preempt_count_{sub, add}_return()

This commit introduces __preempt_count_add_return() and
__preempt_count_sub_return() to track the interrupt disable nesting level
while returning the new value of the preempt count. This helps avoid an
additional read of preempt_count() on certain architectures.

Link: https://patch.msgid.link/20260121223933.1568682-4-lyude@redhat.com

>     // if it's the first-time increment, then disable the interrupt
>     // at hardware level.
>     if (new_count & HARDIRQ_DISABLE_MASK =3D=3D HARDIRQ_DISABLE_OFFSET) {
>             local_irq_save(flags);
>             raw_cpu_write(local_interrupt_disable_state.flags, flags);
>     }

[Severity: Low]
Is there an operator precedence issue in this usage example?

In C, the equality operator =3D=3D has higher precedence than the bitwise
AND operator &. This means the expression evaluates as
new_count & (HARDIRQ_DISABLE_MASK =3D=3D HARDIRQ_DISABLE_OFFSET). Since the
mask does not equal the offset, the equality evaluates to 0, making the
entire condition always false.

Should this be written with explicit parentheses like
(new_count & HARDIRQ_DISABLE_MASK) =3D=3D HARDIRQ_DISABLE_OFFSET to prevent
readers from copying flawed logic into downstream implementations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605054128.5925=
-1-boqun@kernel.org?part=3D3
