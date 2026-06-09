Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2DD343894
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 18:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781030622; cv=none; b=Ri00DfNGA+YVkpL6iKgGRmJp/zE8EikT+0lTXCDt+P/ytlIax/gOthI9IyaKJLmZA40OVhprJ/qyIW2ijV1ZLOra5bYr1XF11BEUMrApGn4/tpRpkpP+YpTnNXoqTw6gkw7nMbzEe4FSE9huGcWs9J3Q9UFa5yz4fYy0bosa5yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781030622; c=relaxed/simple;
	bh=3sZr8aWKz6NoWdAehVLqQ+NR9pLs06MWgGeDQdrwJHw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nr+zD5axYpLWr7JnR0EdI4nYAJQg3626UDEG2aBi/bSjzZ3pBGzrrsBe3DbyB3uodSwq/ytgRK1QNggkfvZgqKp4sLohMlWesPKCMTXesGcpxP3ANanrAvfvXiSCgv0PMB8n1DA3uWmX3yTxHKtQ/rlc8lelaTfUn2dsuPRQzcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArLq18bo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArLq18bo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 623541F00898;
	Tue,  9 Jun 2026 18:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781030621;
	bh=G1lsx8PpF2ufjmozjWFIbKdXkMTYjFFSmHIklIuJSIY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ArLq18boGoyyjTcl96mYFjICLO3ehxJxIKn8kiRFg+hfzO/aO5kCrk7akYjDYueJq
	 EuZp+E9JYTDCvl5czOldvhWgtey0KlRGdTKYZ4KS8Fq2U3FYAql16/6pitHGJH7MNM
	 KoTqCpGeyPjwjhJ4qvCeAeIy/U1upE4ssMbNqA5epJny9CWUdsxXlCkGHwQV+j27BK
	 HrcxvOxI7Q6XrNVA5gAqZba8O2LHEzAerg/D77DqMsVARc0/Ieuu0xnQkUEwmrntZp
	 nH+frgaNP461IGwelrRKL3ONdOwMVaMc073J9bhnZ3ThxDDXPi9eki2EqHXWoO0KPM
	 vBgDcVYaUn9XA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Adjust fexit_bpf2bpf ctx
 layout for llvm23 true signature
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260609164002.1721294-1-yonghong.song@linux.dev>
References: <20260609164002.1721294-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 18:43:40 +0000
Message-Id: <20260609184341.623541F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Low] The modified multi-line comment retains text on the same line as th=
e opening `/*`, violating the BPF subsystem comment style guidelines.
--

commit 895b9c1828c7212301bcd7381a175a6b61a7df58
Author: Yonghong Song <yonghong.song@linux.dev>

selftests/bpf: Adjust fexit_bpf2bpf ctx layout for llvm23 true signature

This commit adjusts the fexit context layout for test_pkt_access_subprog2()
to accommodate differences in how llvm23 records the function signature in
BTF. It selects the matching arguments struct based on the compiler version
to ensure compatibility.

> diff --git a/tools/testing/selftests/bpf/progs/fexit_bpf2bpf.c b/tools/te=
sting/selftests/bpf/progs/fexit_bpf2bpf.c
> --- a/tools/testing/selftests/bpf/progs/fexit_bpf2bpf.c
> +++ b/tools/testing/selftests/bpf/progs/fexit_bpf2bpf.c
> @@ -53,14 +53,23 @@ int BPF_PROG(test_subprog1, struct sk_buff *skb, int =
ret)
>   *   r0 =3D *(u32 *)(r1 + 0)
>   *   w0 <<=3D 1
>   *   exit
> - * In such case the verifier falls back to conservative and
> + * Before llvm23, in such case the verifier falls back to conservative a=
nd
>   * tracing program can access arguments and return value as u64
> - * instead of accurate types.
> + * instead of accurate types. With llvm23, the true signature
> + *   int test_pkt_access_subprog2(volatile struct __sk_buff *skb)
> + * is available in btf.
>   */

[Severity: Low]
This is a pre-existing issue, but since this multi-line comment block is
being modified, could we update its opening to comply with the current
BPF subsystem style rules?

The guidelines prefer the opening /* to be on its own line, rather than
keeping text on the same line.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609163947.1717=
694-1-yonghong.song@linux.dev?part=3D3
