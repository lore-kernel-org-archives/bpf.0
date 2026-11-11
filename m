Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794368612;
	b=bpcc1LdHbvmEXsqB/HSYHeMiHlLEyl8L6KD9swaJNO4DEioxArWEr/AkJR8aTNKb+S2A
	 JUiroweaA4B3GUT3VA4PAnjEOw/m5/AxxVAl4h1YyKF68lYRODT0l5c0SaREeZSfJbB7I
	 6Efc9PexjBn0VbE094oKvqBW2BBT6OKUX+hwFlVNF3nBv2wooZl2rfbwJDY7n+bGW2u6W
	 Iy9R2uR57thsT2SqegLpPP+9tZ07G3ysUPKpx/Ext0WhRjwBgt1gB8HXSsDP30iXgwXJ7
	 Nyius213wIL+Xqoq9jthaIdbr1ZtVlJG4CIgx2RfGmmWhgId06FMRwiXqfFYePLW85A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368612;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OyqEwsVKgCb75AzlXzpVfP/JqW3N+5RQYem8p8SKdd4=;
	b=g+XTQD/79lAzEE8nRvvAKrp8+kPd1CBKemgZC7+klsS2x2kd4b0hi5o9LxhesNDzNXBC
	 L1hwcxUXZ8leDfsumjp0g8RBzoS3SlhF7ywIkL7NYRt0dIFDgkFkjif0VQ5qlFF0q9dqF
	 ciQoL3xaPcXZzM58m/LgxJ0jFPulpHcBg8SIE/ALyOCxA8HQITL3br6urY0ioCvDqS7yS
	 6IjDZA3qcQm3a5316KRNpYm/GKcjanMlpFIW7pD5+9yLhfPcFCdmumOHD5BGBPvZvOgRp
	 rZyMqvuVXCBAEScX5GUIWEEysA0FPSoHTQjeaPLNMGzXg5/ucPRZgoBWybcJXKoF1Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ToALkZ9X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5CF606A320
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 03:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ToALkZ9X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06FD01F0089F;
	Wed, 11 Nov 2026 03:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794368612;
	bh=OyqEwsVKgCb75AzlXzpVfP/JqW3N+5RQYem8p8SKdd4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ToALkZ9XaeK1HTvn6Z7GuXYphek2EPL7YuNf3ER8jqVnAQDUHpaxrIAS5g2PrTjIh
	 gwxZ20lxftaDwGxmgSoc0hxmjEmS8qMuZC0wNwDJtsMS4IaVzHbYldoVRNRcsmBl8K
	 c/NPmXa3vflHNA3wTrDX6J7woUj8Mq5FSb9cqq+dY4d+lA1u0GNTIgmetA7D3kVpUb
	 Lbax7wZv0a5QZ1VCzZflU3sW0pCGrVlmw89nxrOk2vBEOnnN4khDxlQIHZxkSuKY2B
	 ad+oUT0stqePCsI5HLdnU7ecF3p8L5qudjE2NsOhKdga2dXyvHmmmGNh44IaND+oMh
	 /ofugYlsFJWvg==
Message-ID: <sashiko-outbox-208215@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC bpf-next v3 1/3] bpf: Add KF_CHANGES_PKT kfunc flag
Reply-To: sashiko-reviews@lists.linux.dev
To: ThisSeanZhang <thisseanzhang@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261111032141.525444-2-thisseanzhang@gmail.com>
References: <20261111032141.525444-1-thisseanzhang@gmail.com>
 <20261111032141.525444-2-thisseanzhang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 03:43:31 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] bpf: Signed-off-by trailer uses handle instead of full name
--

commit 59e7e83571f6e7abee77827b13a92abbf8a20431
Author: ThisSeanZhang <thisseanzhang@gmail.com>

> bpf: Add KF_CHANGES_PKT kfunc flag
>
> The verifier invalidates packet pointers after a call to a helper that
> may change packet data, see bpf_helper_changes_pkt_data(). Kfuncs have
> no equivalent: bpf_is_kfunc_pkt_changing() special-cases
> bpf_xdp_pull_data() by ID, and the kfuncs that write through a dynptr
> are listed in dynptr_write_kfuncs, because the dynptr type is not known
> when the arguments are checked.
>
> Add KF_CHANGES_PKT so that a kfunc can declare this where it is
> defined, instead of adding another entry to the kfunc lists in the
> verifier. The verifier then invalidates packet pointers after a call to
> such a kfunc, like it does for the equivalent helpers; a stale packet
> pointer kept in a callee-saved register across the call is rejected at
> verification time.
>
> The same predicate is used by the CFG pass to propagate the
> changes_pkt_data property to the callers of a subprogram, so a kfunc
> called through a subprogram is covered as well.
>
> This is needed by the PPPoE encap/decap kfuncs added later in this
> series, which adjust the skb like bpf_skb_adjust_room() does.
>
> Signed-off-by: ThisSeanZhang <thisseanzhang@gmail.com>

[Severity: High]
The Author header and Signed-off-by trailer use a single-word handle
(ThisSeanZhang) rather than a real full name (such as Sean Zhang), as
required by the Developer's Certificate of Origin in
Documentation/process/submitting-patches.rst.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111032141.5254=
44-1-thisseanzhang@gmail.com?part=3D1
