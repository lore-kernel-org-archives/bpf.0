Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14B7349AE6
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 21:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781039359; cv=none; b=bUHt9ZcE+RmIBVhSMSkhSAVzfO0dfTEEALWH/KwtvR63n1ORdZzu7UgWkfF+b8K3vaTAtNGBVDl+UqplQOO0o6puB8HpDvKHzIJF6yV5xDt57+FzdJKDrV8GzgLLwNo9aSp5mRciuH1jvM6/wlQa2FDehIyjhrpujNESzBHInvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781039359; c=relaxed/simple;
	bh=fvROXGvWRpZgrohZFMvA5fAIhiCJzC0ftJGT0WnQUkQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Bb7fQ9v5mi0eDHcHZwTBeXqGlzKhqB3Z3N1vFyhLpmGpcTCIaXSAPs33d0HfMOXYGNrDTfROIYS186HyXiWu/Q6764Vi/qr084vvIR19uu7bpkrmTnQFVie876ouay/b3pxpW0UCLz6qTTCeZj0RMD+VAOk84jub9/Hx68XDmaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMgY5z2c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMgY5z2c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC0A1F00893;
	Tue,  9 Jun 2026 21:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781039358;
	bh=fvROXGvWRpZgrohZFMvA5fAIhiCJzC0ftJGT0WnQUkQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=gMgY5z2cl3Fk+/FPPJUZAYofYSGLiiquOiAbMH2V7VYCUytVbDsUwKbdErvwMonks
	 I6wSiGhuPJXa/+MgFXeeQhDILiQJq4DcxDRHgLZxkqpPntkG87JkBq3U415VWNYk7a
	 DuTJazLJGsRjlX7qqxjgJrGqB6eYSAXyBag9tG91X41tImvLtGG+P+4qIVeHwqvSlM
	 xZIh51AYhRBNDixA3fGY6bw6tf3wt93n1Kq5p7qdn2OvKVxYf/4snAkEbREgwki9dw
	 M59yqFu1FHNA4wfnv6QLBzbSigx3QF8pqRes3IERC+mfG9vFe3WD6HHOA2whAzHOBm
	 etdaQ7OPRE5EQ==
Content-Type: multipart/mixed; boundary="===============4338983937359353707=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <da5e0e9b67e6e241ded25340b7cc83c6fcaadbe9b9f7c65fbb8f386c8887bfc9@mail.kernel.org>
In-Reply-To: <20260609202548.3571690-3-memxor@gmail.com>
References: <20260609202548.3571690-3-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/4] bpf: Cancel special fields on map value recycle
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: utilityemal77@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  9 Jun 2026 21:09:17 +0000 (UTC)

--===============4338983937359353707==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Would a WARN_ON_ONCE for in_nmi in bpf_obj_free_fields help spot these kind
> of bugs in the future?
>
> Usually calling bpf_obj_free_fields in_nmi won't result in a deadlock unless
> specific conditions are met (ie last reference to a refcounted object, using
> a workqueue, etc).
>
> Adding a check here would quickly surface bugs of this class.

Reference: https://lore.kernel.org/bpf/aicB9SZfVnUV1rz-@zenbox

While there was discussion explaining rationale against this approach due to
panic-on-warn concerns and existing guardrails, the suggestion itself was not
implemented. Would it be worth revisiting this as a future enhancement, perhaps
with a rate-limited warning or a config-gated check to help catch this class of
bugs during development without impacting production systems?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27234422852
--===============4338983937359353707==--
