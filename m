Received: from mail-106118.protonmail.ch (mail-106118.protonmail.ch [79.135.106.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37AC49BB6A;
	Sat, 17 Oct 2026 22:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792274783; cv=none; b=a0DT4lu2MoJEhzf6J3tpCKK4GbUdbfMU92wD026iMuBtPvGZM7xBPxdcOJOzNmv9onNn0WguapZfcPH4ibB/uPdoNLd4ohmfPpu85NECc+n+LenWHXfAKvaLAf/k9QVTdeEuupj8HCPx5HDWleiJC/3YE65B8TnVGtPkxDbfzOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792274783; c=relaxed/simple;
	bh=e59q2smTiseUa9ougC7vymomZfpuROq2NgPviBX2A4A=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=C17J8iKsWPy8eze/Mg7jnstM+HZrmhZlIo5s+NHQmmSYTa9SyGuKNGlLZgYmkfPpV4KY0pTe0Pef6rCRZBXX0q9vIEcOB3NABosnCUNfvje6FKyLtjhScFHZFVQ4HmUp1CCeetdQ0UYAa5SQZ6QjY4bXfG/VB9wcpbSo9zhRwY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=FCjmoON2; arc=none smtp.client-ip=79.135.106.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="FCjmoON2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1792274773; x=1792533973;
	bh=e59q2smTiseUa9ougC7vymomZfpuROq2NgPviBX2A4A=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=FCjmoON2vUglYfwtqXPCv6bTNp/9BfCyXEuF3gXO0KvQfbzipY3L3IVmJAiJeNf4r
	 6kiW+7jwejAUmmpLgWApXyVlD8m2zmtYjUsfgcKvavYH820upQJQKYahK00AR7/u/J
	 wFj66Mp3z79qneQIqsxoFRyenGJWTTNfr62INaiw0aR4ELV0i9e6CfF2I9+Lcb0x7i
	 6Zyx4MvG3U0MrEMM7t64Oju4UBHJQObY04SRg526llaFKtnLkAhsox2hA876D9p0C0
	 9CBISd1mSEzv71aeJzzpkORCLYi9f8uIikXhbmsyryEeRfuJfhU8gpXalAsMxAlkrV
	 u6Df5Rj0MVN5Q==
Date: Sat, 17 Oct 2026 22:06:06 +0000
To: alexei.starovoitov@gmail.com
From: Tyrone Wu <tkwu@pm.me>
Cc: andrii@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, josef@toxicpanda.com, mason@kernel.org, memxor@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 26/43] bpf: Don't take an extension for an iterator program
Message-ID: <20261017220550.1661-1-tkwu@pm.me>
Feedback-ID: 180442703:user:proton
X-Pm-Message-ID: 430d7e6868b238d3ecc9960c7e73000ff49b337e
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi, I originally reported this issue a few weeks ago
(srry for no text wrapping):
https://lore.kernel.org/bpf/AyAj3bTqZ30lo9rs1fqBKO0Vk7CJqGfxcmHqHhmmEBpxlQx=
f0M4lfKOmSE_MbTVLhhxeFUx1PbyX6oZKq8Jh54h0pzjEFtXlRSqi4m6DcQA=3D@pm.me/

with the BPF global function name issue when freplace'ing a global func in
an ITER prog. I'm hoping for EXT to still support ITER progs for my
usecase, so rejecting all extensions seems extreme.

From what I understand, `tinfo` should be a registered iterator target
(`tgt_prog`/`prog->aux->dst_prog` in our case for an EXT prog),
and this is used to set `prog->aux->ctx_arg_info` for later verification.

Could `bpf_iter_prog_supported()` instead have the `tinfo` search loop be
applied on the `prog->aux->dst_prog`/`tgt_prog`, and
`bpf_prog_ctx_arg_info_init` on the original `prog`?

Ideally I'd still like EXT to support ITER prog types if possible.

Thanks.
