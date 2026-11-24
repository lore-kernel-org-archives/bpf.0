Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795502516;
	b=mgIkvTLazWefD6U/RKkvXvzIC7nUzPhTCYXYsipm8vQ2YFbs5gtPAdWMnOc3e9nZrB1L
	 iDjuvisjo3vF510eq1Z4Bgc2u4bPOuFeYU4l50JcZ2k/GduKPk9BZuGpC+zqOsG6nonar
	 RL5zhCgqT74gC7aCZ3e3YLavU4sv7dPFr4RBe/SHYBzM7haSeoARuI3nXJd+crw1KrqXP
	 qkoxkCLE21jBQb9elVwz1/HwfYXJJvWJWtT8chnyHmn2YUwQVSLotJEvDUQRD8spqDVdb
	 fUEo8BLmmUzb2fZLRtTmIpX3m9S54IAKtGWKyfEECpb7MLfxm9L5ylf/wX1PQvTXiXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795502516;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0MTKVnxWcKYuk0Iai4ZAjEaKmzIPrFCLRJdlgwxvUFQ=;
	b=FnfiDx82Zf8u56hLq8FSwn0d1+tR1EXxIpCa0go5UF8unq+5VZN1HLjKYEdqZMOwN3yY
	 tTaa2xKnKoAL27sh03Kou1Vd82zhbdwOTzj7OAdURg1LO/vEA7zxqWPlC7vOEweRb8qb5
	 Zlw6KG6Je5QryksnKufp7RMzYr4XpgLKGNdsgt3vctKB94FkcJKuQajLcZpjLdYeb2GCZ
	 Ar9yP3lMKDpnsc/qRqztRkMT1tx8gNRo1+vFNMTgtqX40jWdmj4MSe2uKWkalsgx4AclV
	 N+T1B8+PA/fUYj4/CRockuwAqMtwvJPZeiykRinI3VNwL4VC2kC0nEJxBuXsDBrINEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CsXw0n9X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51465606A31E
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 06:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CsXw0n9X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C8B1F000CF;
	Tue, 24 Nov 2026 06:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795502515;
	bh=0MTKVnxWcKYuk0Iai4ZAjEaKmzIPrFCLRJdlgwxvUFQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=CsXw0n9XMTxgARSrZRaAj0eiPkpAO9ddmNxhS3axF+6BibUS+c1VQlH1o9PV6lrNU
	 LTBA1S4HLTmlYuWVbEUPxrwyfWecXrhrD6P/nSitpH96mz1RQutXj4uHbV1bO9sTRm
	 HFuDnCPkejXhTLn/CWj+64DupNCPy0E2WkzFyLScAyImZrFed0EpEJePBBhx5IsJh0
	 jrA0hDG6qZ30l35KvGt+QqaldSK3tVeWIwxJe5s2KIeRnc2vSBqlyWsioSq4pKy5Xa
	 5kVW0rNuHvwSBA8ZU5U+U4tU1DpsLTDJ+6QNlF1K/kQR9l7pwfQY6L9a+UCdKvdQQx
	 hGueDP3IWo21w==
Message-ID: <sashiko-outbox-230606@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 3/4] bpf: Add sleepable local storage
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>, bpf@vger.kernel.org
In-Reply-To: <20261124060357.11700-4-emil@etsalapatis.com>
References: <20261124060357.11700-1-emil@etsalapatis.com>
 <20261124060357.11700-4-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 06:41:54 +0000
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
- [Low] bpf: missing __GFP_NOWARN in sleepable
  bpf_local_storage_alloc_mem()
--

commit 6a9b8094f2dfaf87e47ddf985c894923ff71ad36
Author: Emil Tsalapatis <emil@etsalapatis.com>

bpf: Add sleepable local storage

This commit uses bpf_map_kzalloc() with GFP_KERNEL | __GFP_RETRY_MAYFAIL
to allocate local storage when called from a sleepable BPF program in a
sleepable context.

> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storag=
e.c
> index 28eaee5c66ce8..74dfebf180970 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -69,6 +69,10 @@ static bool selem_linked_to_map(const struct bpf_local=
_storage_elem *selem)
>  static void *bpf_local_storage_alloc_mem(struct bpf_local_storage_map *s=
map,
>  					size_t size, bool sleepable)
>  {
> +	if (sleepable)
> +		return bpf_map_kzalloc(&smap->map, size,
> +				       GFP_KERNEL | __GFP_RETRY_MAYFAIL);
> +
>  	return bpf_map_kmalloc_maylock(&smap->map, size, __GFP_ZERO);
>  }

[Severity: Low]
Should this bpf_map_kzalloc() call also pass __GFP_NOWARN?  Without it, an
allocation failure under memory pressure or higher-order fragmentation
triggers a warn_alloc() stack dump in dmesg, even though
bpf_local_storage_update() handles a NULL return gracefully.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124060357.1170=
0-1-emil@etsalapatis.com?part=3D3
