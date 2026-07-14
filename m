Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBA8175A99
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 07:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784015419; cv=none; b=PoWCQ7kS63HX59B+hT9u+ARx6Gkz/eP+ozxGFKY+LlxdLc46tRXAjeJ++fqsCr5e5E4I8vvY7lFJxEoxAOQ3DBgO2Jo8YeVpXKYIeUDpUrixfzn1QeJ20eBHRUpKc7syBqzk5mclwTIiXbLSTR0agXqGHue4QxZL4jVTVCt4LJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784015419; c=relaxed/simple;
	bh=fln8QvAr22tp6PaLTPwucGX+fi2QQu14N0SNxOKohzs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pJxBTwqHhiUe96bNmlS3tDBg+7oGnKIkAjHW4BIyHZLmaaqI3qwHhg3MbhXAloWXFzkb/f85XwVb+NDh6zwKQP1RAjmxml6CDSLkYx6F/PGmpWulQo6Qw1cBm+5iUAeMbFKotjvsEo+xjCZWBWmW5eNRIh3LD4LJBkg1LFB0Tq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOOMyDoZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOOMyDoZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66CE1F000E9;
	Tue, 14 Jul 2026 07:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784015417;
	bh=fln8QvAr22tp6PaLTPwucGX+fi2QQu14N0SNxOKohzs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kOOMyDoZcpmVkCR7SV2WkB/OJ5W9+cRmxucWtybXOFVBoko57odWwoRHJ9OI5V712
	 3XOvIRbKxyAaEBn7V1Q3bK7eMo9iiIFkixG9ndyRNwuFBQLHzUjaULaPunMWds1c9j
	 I1jTm/Dd/CJRm0/GvgMN1z61srE/mxyHU6cvqUWO/2M96J0GXqmfoMO/637HDkyNpD
	 h0WLiNakCEyuZj9G4JCtusSRltzUypRM/WlaGx0a0FPuRPp+zIgRnCEqvxdbQ3K3Ht
	 rGcXMykJsDKxFr2xL+AxdrVlpvqofbx5wn4hbnfh9gBEhbLe2cZAiw9f9p1fb06Rni
	 Q6pGUWZtQaq5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 02/15] arm64: barrier: Support
 smp_cond_load_relaxed_timeout()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260714073041.40250-3-ankur.a.arora@oracle.com>
References: <20260714073041.40250-1-ankur.a.arora@oracle.com>
 <20260714073041.40250-3-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 07:50:17 +0000
Message-Id: <20260714075017.B66CE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The generic macro `smp_cond_load_relaxed_timeout()` is broken for =
loadable modules on ARM64 because it uses the unexported symbol `arch_timer=
_evtstrm_available`.
--

--- Patch [2]: [PATCH v14 02/15] arm64: barrier: Support smp_cond_load_rela=
xed_timeout() ---
(Note: The format of this review has been altered to provide a free-form su=
mmary rather than inline quotes due to recitation restrictions.)

commit 8ff6ac5954b14995e35ca4865c27742e37086e23
Author: Ankur Arora <ankur.a.arora@oracle.com>
arm64: barrier: Support smp_cond_load_relaxed_timeout()

This commit adds support for smp_cond_load_relaxed_timeout() on arm64 by
using __cmpwait_relaxed() when the event-stream is available. It introduces
cpu_poll_relax() which checks arch_timer_evtstrm_available() before deciding
to wait or fallback to cpu_relax().

[Severity: High]
Will loadable modules be able to build if they use the new timeout barrier =
API?

The new cpu_poll_relax() macro in arch/arm64/include/asm/barrier.h calls
arch_timer_evtstrm_available(), which is defined in
drivers/clocksource/arm_arch_timer.c.=20

Since cpu_poll_relax() is embedded inline into callers of
smp_cond_load_relaxed_timeout(), any loadable module that uses this generic
API will now require the arch_timer_evtstrm_available symbol.

However, it does not appear that arch_timer_evtstrm_available is exported w=
ith
EXPORT_SYMBOL or EXPORT_SYMBOL_GPL.=20

Does this cause an undefined reference error during the modpost step for
device drivers that attempt to use smp_cond_load_relaxed_timeout()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714073041.4025=
0-1-ankur.a.arora@oracle.com?part=3D2
