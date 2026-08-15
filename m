Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A16736B916
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 08:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786781698; cv=none; b=TVWoIEoq79+bZkGXS/vzJCNKZHTRn27BGkomGFLXxSeBkRWC4QM724rswOGJmFX7zbdTq6ffGn1YJozifqv4UidaHiJxNVtT3WtkT12GmzyB73KhpPwTcNbKRrd45aBxV6xViEn7MamdOFeyQlhFUsRoPL8gRvnKP4xDqmeT8UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786781698; c=relaxed/simple;
	bh=RA1h4iN5c6dOi2+EpHtbCUGvqTO56Bm2dI3kVTf3+5c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eolXW1xZ0jAVTnJhclRRq8YgFBdSRm1FTzbmVVUF1xQ9XprD3tcb8WOEoGdexH+1F7ZHtgqH4C2/o5ibN5a/0yEhZpjGbws1YwhBoU1VTW6KAKQxOyuaLbWtZGGxdGh7ayzJsQ3RDS5L1E3FlmmL4FgEd4nix1Y8UFh3Wum1kq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vev0LQ87; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vev0LQ87"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307B11F00A3A;
	Sat, 15 Aug 2026 08:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786781697;
	bh=wDwNXOM8Bvn6kLlvbBWBG9VMkgGHLPR5nqGvNXW38Fg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vev0LQ87doQifz0Xx9R8Z7L06ID6IHXM4RQNjmvFeH7smE+tBjDqN2Uf+SQ1C+QvO
	 EvnNYc/LzJ3hYlES/vBMhcgdTNHzI7jlO+tC5t+gj+uRDyOn99PkagiIlNxaB8XsAJ
	 xKEtN1wstdjEO0jWL26dyNIwP/Cin+NIOFKY+7p64D6Ro3AFhs1GCSmJcyqdY4Q9l8
	 Fzp+okXpfLQ1ZE0j3Y37vQakdkhRrerthGD0gtWcdeRU+ib7UGfbCBzeosPte2+lZE
	 qKeoizk87wkUsmZBlP11JNhK01Mmr/MzCANxxSXNpY6jpNmigk7rve0Y1fXKC7XpsK
	 q+RnjEbuqp/pA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 13/14] selftests/bpf: Test skb_ext read from
 sk_skb stream verdict hook
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jakub Sitnicki" <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260814-bpf-meta-inside-skb-ext-v1-13-767edd862656@cloudflare.com>
References: <20260814-bpf-meta-inside-skb-ext-v1-0-767edd862656@cloudflare.com>
 <20260814-bpf-meta-inside-skb-ext-v1-13-767edd862656@cloudflare.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 08:14:56 +0000
Message-Id: <20260815081457.307B11F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The multi-line comment preceding `test_skb_ext_sk_skb` violates the=
 BPF subsystem comment style guidelines by placing text on the same line as=
 the opening `/*`.
--

--- Patch [13]: [PATCH net-next 13/14] selftests/bpf: Test skb_ext read fro=
m sk_skb stream verdict hook ---
commit a5b31d7bdebf3ee8a7f99246938befdabdfff8e4
Author: Jakub Sitnicki <jakub@cloudflare.com>

selftests/bpf: Test skb_ext read from sk_skb stream verdict hook

This commit adds a selftest to verify that skb_ext survives across the TC
ingress to sk_skb verdict hook. It implements this by writing to skb_ext
from TC on loopback and reading from it in the sockmap verdict program.

> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.=
c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> index 5f9247941aa01..f5fbc19757e3e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
[ ... ]
> @@ -1560,6 +1561,82 @@ static void test_skb_ext_seg6local(struct test_xdp=
_meta *skel)
>  		unlink(SEG6_PIN_PATH);
>  }
> =20
> +/* Test skb_ext survival across TC ingress -> sk_skb verdict hook.
> + * TC ingress writes skb_ext on loopback; the verdict program reads it
> + * on skb delivery to a socket in the sockmap.
> + */

[Severity: Low]
This isn't a bug, but does this multi-line comment format follow the BPF
subsystem style guidelines? The preferred modern kernel style for BPF
subsystem files places the opening /* on its own line before the text begin=
s.

> +static void test_skb_ext_sk_skb(struct test_xdp_meta *skel)
> +{
> +	LIBBPF_OPTS(bpf_tc_hook, tc_hook,
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-bpf-meta-i=
nside-skb-ext-v1-0-767edd862656@cloudflare.com?part=3D13
