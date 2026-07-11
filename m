Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F673B1016
	for <bpf@vger.kernel.org>; Sat, 11 Jul 2026 10:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783767244; cv=none; b=cgISocrCsWFZQ15ffjtpMgU6HbGVyU2uYaxNrnsAcePXXZwGVkxaYyQE7IrBb/P2soMecWEowfnV+4sz3L0vmx8bayWoRfxi1WfjwEpy6adaUumvRRnd/m/hzSJuCk2qEADXOlzO/3zuNP/QXd4/BU9CSNMvNuUaBLPP1XHJR7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783767244; c=relaxed/simple;
	bh=EMygczQZ0IM/8++q6I6ih+jWeCYGOvtfOTomUlFgKz0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pZsoZ82FmG//nNjcmWtktL9nUZHKt4S4jBd6tdq6YklY/LgQPsRouJFub94JknxFKFlUzsUE40e7flmH+OZuV7PQDEa1N4EdCuyVMllAwwWi1tyUrg0WB8RooscrT27LLs6SWx5a9M0Ir/T2n1CJXfPBFHb8VC+h2Y4u+nzGyhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RoPmXzFE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RoPmXzFE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DF81F000E9;
	Sat, 11 Jul 2026 10:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783767241;
	bh=9itvaQYr+UFCMUuw4yttyefsu1AzzHFvXzCPx5XRXL8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RoPmXzFEUOVCQkKQohbqRXcIa5rn3IzKXKmKnew8pyaaNAQtJblC1s8DhLg5YuyA9
	 Wv4PdxPW6JymDQ/iBDGwfs+oUUPxC3w7ofG2aRH+Wmr7HLbiomOQ2vl8/INatrSrqK
	 GJJdY0rtvb+hCQiU/JBluLsGVq2hi8NctnOqXJ9dcEqhekAkv3eT/fiqt78T6bkjiy
	 +ut0ZGz84EhI6stOfqzCbBtphubB1g/SSzorc679iDipkESLpccKQdcxRCN+YNAV61
	 u7FNnAOAoy2AxtEWe24rbfMlVjlhvY4Mf3HFOapQfkebNGfvRqmQDRt26JHHwpE9gG
	 AWs8x0ozW1Fgg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add testcases for callback
 with tailcall
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260711104727.4023420-3-pulehui@huaweicloud.com>
References: <20260711104727.4023420-1-pulehui@huaweicloud.com>
 <20260711104727.4023420-3-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 10:54:01 +0000
Message-Id: <20260711105401.84DF81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The test `tailcall_direct_callback` intentionally expects a verifi=
er bug message (`"callback unexpected regs 1"`), which triggers a kernel `W=
ARN_ONCE`.
--

--- Patch [2]: [PATCH bpf-next 2/2] selftests/bpf: Add testcases for callba=
ck with tailcall ---
commit 037342732803eb60c98636ac87d004705531bc5d
Author: Pu Lehui <pulehui@huawei.com>

selftests/bpf: Add testcases for callback with tailcall

This patch adds three testcases for BPF callbacks interacting with tail cal=
ls.
It tests scenarios where a callback directly invokes a tail call, or where
subprograms invoked by the callback issue the tail call.

> diff --git a/tools/testing/selftests/bpf/progs/tailcall_callback.c b/tool=
s/testing/selftests/bpf/progs/tailcall_callback.c
> new file mode 100644
> index 0000000000000..504d8e7a69969
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/tailcall_callback.c
[ ... ]
> +/* callback involving tail call directly is rejected */
> +SEC("tc")
> +__failure __msg("callback unexpected regs 1")
> +int tailcall_direct_callback(struct __sk_buff *skb)
> +{

[Severity: High]
Does expecting this specific failure message codify a kernel warning as a
passing testcase?

The message "callback unexpected regs 1" is emitted by verifier_bug() in
kernel/bpf/backtrack.c during precision backtracking, which intentionally
triggers a kernel WARN_ONCE. On systems configured with panic_on_warn=3D1,
such as syzbot or standard CI environments, wouldn't loading this test cause
a kernel panic?

If the verifier hits an internal state corruption (tracking r0 back into a
faked exit) and triggers verifier_bug() before it can gracefully reject the
program, does this indicate that the underlying issue with callbacks and ta=
il
calls isn't fully fixed by the series?

> +	clobber_regs_stack();
> +
> +	bpf_loop(1, callback_loop_1, &skb, 0);
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711104727.4023=
420-1-pulehui@huaweicloud.com?part=3D2
