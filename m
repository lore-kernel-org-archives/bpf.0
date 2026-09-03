Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988B04E80C1
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 15:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788450764; cv=none; b=OU2CDdLdUeEpkfUKm/y2a6BkYhkzvAVW7bEm1H5PvOMVdAa9G9tTmCXKHcD3tKPVRmJVmtvQczoUhG8d/PQgmpAWi2+3TQlNs3Q9Sfua1GqLP/nVDKaaroN3B1Ys8FfaA1bPfqdTISL2dldBJ2SuPxR65fN9ysO+6InzdEjM2Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788450764; c=relaxed/simple;
	bh=eQI6YP6bmKrPiop0OY58QPv3bRuIqRy3ul+1p3S3V/4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WtrZVf8WEqIG2eAMVN7INuwLB1NB0TrrSRjXCqw+SdIiOs7C2Enq4qCfrvj1oWLJonUK9s2P6CBYHfgHhJqHI9TKGsa1+0AOwn3Ov/2W6cnQ7qcuTtToSNQKmvoO81sAIfq92jW9zaMl7wRazzW6v8Okf+1NhTrSqwNrs5PDxkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGQoP7UZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGQoP7UZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D276F1F00A3D;
	Thu,  3 Sep 2026 15:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788450763;
	bh=eQI6YP6bmKrPiop0OY58QPv3bRuIqRy3ul+1p3S3V/4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=dGQoP7UZVL71eoLQxnbaARNq3o8+/ujrN2OB23TdRmp39jZdY6vMjStgE4bzeA5a7
	 b97cEC1pcoGPa29GaIfmyXRQjMF1MQV5AvYta2SfRnlFYfmhfqG7j5jJTOFa56s9zU
	 KRE03kQ5acCkMNAxV5ILkoXJRUPxwGrP4B1pv9gIvAzeK2J3R7N8HUGU/CfVUwo1Ui
	 vb5NBypSNbXcPpycVvMhMBz7Lmy1sQHwE4WM1Uu+XIjbqeAesmcAtIfaFSOef/Q3J8
	 e75WmsoQugQXFcEwiH/nbMsJGxE8P5HwJ2gsGhv6n9sMDfIV+6BNAcIOrRTpRld34J
	 P7c7slKc2I83A==
Content-Type: multipart/mixed; boundary="===============7875676898712707087=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c2b95994cd7177a255e46003970c55ff679460924a5d6a9d9dc3a398a6125147@mail.kernel.org>
In-Reply-To: <20260903144433.1716731-3-memxor@gmail.com>
References: <20260903144433.1716731-3-memxor@gmail.com>
Subject: Re: [PATCH bpf v1 02/10] selftests/bpf: Cover signal tracepoint siginfo sentinels
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  3 Sep 2026 15:52:42 +0000 (UTC)

--===============7875676898712707087==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Cover signal tracepoint siginfo sentinels
>
> Add load-only verifier coverage for the signal_generate and
> signal_deliver info arguments. The signal_generate case performs a NULL
> check before dereferencing info, ensuring that merely making it nullable
> cannot satisfy the test when the nonzero SEND_SIG_PRIV sentinel is used.
>
> Both programs load successfully without the verifier fix, contrary to
> their expected-failure annotations. With the fix, info is a scalar and
> the attempted dereferences are rejected.
>
> Also add success cases showing that plain raw tracepoint and tp_btf
> programs can continue to read and compare the context word as a scalar.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

This isn't a bug, but would it read more clearly to name the two
expected-failure programs explicitly in the "Both programs load
successfully" sentence?

The patch adds four programs total (two __success controls and two
__failure cases), so "Both" has to be inferred as referring to the two
__failure programs. Something like "without the verifier fix the two
__failure programs load, so the tests fail; with the fix info is a
scalar and both dereferences are rejected" would make the antecedent
explicit.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33770534313
--===============7875676898712707087==--
