Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A2A3BB693
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 12:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786105982; cv=none; b=QRpuKAIRjs/Ur2Ro0WtT99kZHd6gT3RbBiI+RQZsYZAtqVONq4cYs8env9B3zauH0LKK6gUZ3ehpyt+La4hkZZyijjc/deTSWTjidglv0tRbI1Dbcbtqh4MgGTGZIk1/zsIQtT4TGrcr4XCKIO+MTQx+yFWhE/HwBpB4xh2mGPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786105982; c=relaxed/simple;
	bh=OJsdYb95cHmwJtEl4oQv6N3k43WLEK6obrGHxo8zA1I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ofqO5LZXH8NMPbTJccWVo+SzItUxvnwbXxebGwsWZ7RsM2bbSh3hvysgtjBLHJ9zqoI8lhq7dPBe8dQC5HjOBKNwLT489HQazgTSAZxXrz7i6U33ypDm5G57PaGzriNXjo9d13rcUDzJuUD6yQajWtPtSZpciuPofOyO+B9pbeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+yAGmf2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+yAGmf2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A942A1F000E9;
	Fri,  7 Aug 2026 12:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786105966;
	bh=VGYjk/GU3yZns5VM52mHXkxN3Y/OLzV0b1QFnhJiH4g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f+yAGmf2kTjjVLSA7csHnMISt+wmM50uTkX5TNhdV+FUyhoTw4I9Ae8tq6gp66W7W
	 /4fSjCpKcYv6bVdJn+ILugU/ghmsZ/y63hUf0+TS1byR/cSkkeSuCU70IW8OaZMp02
	 zqxALtf8+szmTTuFTKrjYSB3exPftfDaHG2UQvlS/4uWnwGNWUGHwO5sfSno8zMigR
	 IuaCokRmiGc19pm8Z250vnFnRb8JqvjOWqWToXMwJ40+q/0lzo1oc52Y+AcNYMRxVq
	 GEhlm1d4n97wb5J/US/SItCKyKuT3y5eEr7Rfb47oKiNjHz9l+Ljj3Re0e0d+o9gbo
	 X8gb2bq3m/t7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 6/8] selftests/bpf: Add tailcall verifier selftest
 for powerpc64
Reply-To: sashiko-reviews@lists.linux.dev
To: "Saket Kumar Bhaskar" <skb99@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <8fe0b35438a04876bee2dbcdc94e28bd919dfc40.1786099877.git.skb99@linux.ibm.com>
References: <cover.1786099877.git.skb99@linux.ibm.com>
 <8fe0b35438a04876bee2dbcdc94e28bd919dfc40.1786099877.git.skb99@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 12:32:46 +0000
Message-Id: <20260807123246.A942A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Multi-line comment in the BPF subsystem does not follow the require=
d style.
--

--- Patch [6]: [PATCH v11 6/8] selftests/bpf: Add tailcall verifier selftes=
t for powerpc64 ---
commit db11673742dde393ab8f7429a8221e1b2ec5a904
Author: Abhishek Dubey <adubey@linux.ibm.com>

selftests/bpf: Add tailcall verifier selftest for powerpc64

This commit adds a BPF verifier tailcall JIT testcase for powerpc64 to
the selftests suite. It introduces the expected JIT instruction sequences
for tail calls on the architecture.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c b/=
tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
> index 48fa34d2959f4..182302ff1db07 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
> @@ -91,6 +91,81 @@ __jited("	popq	%rax")
[ ... ]
> +__jited("	std 9, -8(1)")
> +__jited("	mflr 0")
> +__jited("	std 0, 16(1)")
> +__jited("	stdu 1, {{.*}}(1)")
> +/* load address and call sub() via count register
> + *
> + * Address materialization differs between PCREL and non-PCREL kernels.
> + * Skip the address generation sequence and verify only that the call
> + * target is loaded into CTR before branching.
> + */

[Severity: Low]
Does this multi-line comment follow the modern BPF subsystem style rules?

The BPF subsystem style requires the opening /* of a multi-line comment
to be on its own line, rather than having text on the same line. Should
the comment start with a standalone /* to match the expected format?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786099877.gi=
t.skb99@linux.ibm.com?part=3D6
