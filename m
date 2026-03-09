Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30902D0610
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 18:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079201; cv=none; b=SbP58iHag4yYlBQbTdCNatWI0yOJZNs0WKwO/+U5ViSEH3Jw5L8sAEOIAYYk/iROW0EuusHdppA1y4aeSGfv/JgaWFakjJF3IOrE0YauaDm9lZTjIxQDt8/NK2X8QZs+nxcH87kMnLLAUooq+o5VEgjjeUTQOW1FW9d6XcuXZag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079201; c=relaxed/simple;
	bh=6tvZeAk3Wtu6wwjNFx5q88zz302zlX0m+pUSL6FxT40=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ctsev7KWQWc+/noS4VmlM2Ze3ud8TY/J0hzkaxucKQxvLxskxHDY79dxYYaw9iav7vuXviK4V8ED51eKEcqq4bD66meOr2DqYUUREuu8yZFmVLaNfyNe+xKsoiWSrNILlrcHBqt5LwLt8V2vJMAxFPcRfo8esWhJhr99X0teEPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r68f3ba7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r68f3ba7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3BD5C2BC87;
	Mon,  9 Mar 2026 17:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773079201;
	bh=6tvZeAk3Wtu6wwjNFx5q88zz302zlX0m+pUSL6FxT40=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r68f3ba7i+0+m0QqTRnn8NJ/ykBApiKcnsQTuektOIHqhQ0vtJJdcWTZpLImz6mTE
	 7TZaZWchLIQnRDXmkE+GXX0gTOEvGncioZ5R/ldqsQK7zWyQbfWtcUHw0wGBb6isQk
	 q7M3NvClZNRAVjNYq9EnktKUKeE0Qh0W3G1D1XcsGPcgTY1KcPQ8nci6aFoxoCBMbl
	 hqxRa3qI6/L8M2GxHvHvN0oPXBpL6wVE+0LNNbgCuJZNKeokIEEgkjSunOtdZYYBpf
	 5B+ekdYjjK+YNzCOTKqseNhXItJ4vjvHv88H/eu9STV/1pJ+RviBowyC3E70x9ziez
	 EXkExSWlXxMXQ==
Date: Mon, 9 Mar 2026 10:59:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, martin.lau@linux.dev,
 daniel@iogearbox.net, john.fastabend@gmail.com, ast@kernel.org,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org
Subject: Re: [RFC PATCH bpf-next 0/4] bpf: Introduce bpf_netpoll
Message-ID: <20260309105958.5fd73e0b@kernel.org>
In-Reply-To: <20260309131635.302424-1-mahe.tardy@gmail.com>
References: <20260309131635.302424-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Mar 2026 13:16:31 +0000 Mahe Tardy wrote:
> This patch series introduces bpf_netpoll, a set of BPF kfuncs that allow
> BPF programs to send UDP packets via the netpoll infrastructure. This
> provides a mechanism for BPF programs (e.g., LSM hooks) to emit
> telemetry over UDP without depending on the regular networking stack.
> 
> For reference, this was discussed at LSF/MM/BPF 2025[^1] in Montreal,
> and again at Plumbers 2025 in Tokyo. Liam Wisehart mentioned this work
> during his presentation of BpfJailer[^2].
> 
> The main use case is to be able to completely dispense with
> agents/daemons for BPF programs after startup. In the case of
> Isovalent's Tetragon, the idea would be to be able to emit security
> alerts or export data from BPF even when the agent is down. For meta,
> according to Liam presentation[^2], this could replace logging via
> ringbuffers which created cross-binary versioning issues.
> 
> The implementation follows the established kfunc lifecycle pattern
> (create/acquire/release with refcounting, kptr map storage, dtor
> registration), for example used by the network bpf_crypto kfuncs.
> 
> Further patches would extend the bpf_netpoll_send kfunc to more program
> types. Note that network program types should not encounter recursion
> issues as netpoll bypasses the network stack and sends directly to the
> driver.

netpoll is a fairly constrained and tricky vehicle for sending data out.
Its built to export logs and crash info, not arbitrary (potentially high
rate) logs.

Plus you will still need user space components in any modern
deployments to establish security associations and/or add some sort of
"security proxy".

Long story short this may be a fun PoC to vibe code but architecturally
having a standard-ish exporter or something integrated with systemd
seems like a much better system architecture.
