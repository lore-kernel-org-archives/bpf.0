Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794756572;
	b=PueBYLtsLSs9kJ5/M/WGJHHHS7nZ+B9qsZneQ0akgCTOB8Q3GB8PXQJhOxA+MUk9S9k1
	 fqP1fd21zopjWRNMPO2L8ZYCATA/SmNMSM1zRtTPL4Wgeq2Ik3Z/vr/MoIZ7j/fQKfLiX
	 BO3srUBgE7fXEB+xZM0w2RJKeW7Id0H9jMNdwftqcZKoK75nf8tcFNQkkpMWzuRuMpLzH
	 0qYcDUK+L2LNQM8KZtP3WSC3UCi/qYwa1Kir31O2Aza+1moDHb7T5zvUNAORL2cmQiqqp
	 H8Gij3FHfMFAbmGR+IgxlykRAifemK91obJGxgIvakuo6JQk0lFIzJ4Jp9loVkfZ49g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794756572;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NLJXwEaZ9/rL+ElsBsNZnJlY93VE13w8W8JutruZmwk=;
	b=pbI6TZMme5974hP/FO3XEcMDa72v4LSt6ZGeW4YoxQ86t31zzyRVeen+vZANDn0apxR0
	 iz7/TyJh17qw6+7bdfevRyaG6eAcw0kTRrGRdydR52vZ/32yG8HKjtRFPsIXL7Gxkm1er
	 NZAuAeAJuZYc4xMYOE3GKL+SJjPQWrouPrlV3DuJKbj8zqb1iO38hMpaEb8h2hJID8wVl
	 fN0o7tq/UrfJ8AJQ07W6eSleAACzDScGJUJ96Ae0KzqXtFdPLwjDTahwufFCZeB5INPT5
	 n19TyxRBb7IOo2RWnyCqXxyJyoQnGwdrv6BGVJz7ReecChlCXLKFW/y+c4H2tVonHEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L03iahJf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82433606A32E
	for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 15:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L03iahJf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 409BF1F000CD;
	Sun, 15 Nov 2026 15:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794756572;
	bh=NLJXwEaZ9/rL+ElsBsNZnJlY93VE13w8W8JutruZmwk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L03iahJfVQhBuGIauR3eEp85Ml59CPmky1tRnqPwkfdiKaKJsseewicRCk+eiSsg4
	 c7CwVwXpG4scXXRRoTXhz+YIjp2uXGrYGpo9PRqlQk23rrFYpD7oQsPbzQZKvKD7o+
	 y5VOr9Snhh1z8pGhsiMwoH5KgVQxOVOHtqXHVWyKGgJQLmv8aguykwRmGdJR5rtBW4
	 EqA6AUyBUD4WzSGEYnl5JPkHliP43t6ktBJllrNsvlsWHBcSkkwrclc9LKzgXyGaRG
	 muG7nv/vRl/fmEgOqTaNhYlo2BNMDc3fjv/7AB3jkk47Nx1NDksmDzdpVMmHY7Gsra
	 Ffmx0BdYKBtqA==
Message-ID: <sashiko-outbox-215630@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] net: sock_reuseport: check program type on the
 migration path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shihuang Liu" <shlomojune6@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261115152408.48205-1-shlomojune6@gmail.com>
References: <20261115152408.48205-1-shlomojune6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 15:29:31 +0000
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
- [High] net: sock_reuseport: placeholder Signed-off-by trailer in
  commit message
--

commit cfe7ad076364a4b63b18cb16611dd2ffb1e3f230
Author: Linux kernel audit <audit@example.invalid>

> net: sock_reuseport: check program type on the migration path
>
> A BPF_PROG_TYPE_SOCKET_FILTER program can be loaded with
> expected_attach_type set to BPF_SK_REUSEPORT_SELECT_OR_MIGRATE and
> attached to a SO_REUSEPORT TCP group; both steps are allowed without
> CAP_BPF.  Closing a listener that still has queued children then runs
> that socket filter with a struct sk_reuseport_kern as its context,
> while the program was verified against struct sk_buff.  It reads and
> writes past the 56-byte object on the stack, which KASAN reports as a
> stack-out-of-bounds in ___bpf_prog_run().
>
> The cause is that reuseport_migrate_sock() decides from
> prog->expected_attach_type alone.  That field is supplied by user
> space and does not identify the program type, and
> bpf_prog_load_check_attach() does not reject the value for
> SOCKET_FILTER programs.
>
> Fix this by requiring BPF_PROG_TYPE_SK_REUSEPORT before running the
> program, and use the same check in reuseport_stop_listen_sock().
> Socket filters can still be attached and used as selectors; the
> selection path is unchanged.
>
> Fixes: d5e4ddaeb6ab ("bpf: Support socket migration by eBPF.")
> Signed-off-by: Linux kernel audit <audit@example.invalid>

[Severity: High]
The Signed-off-by trailer uses a placeholder identity and a non-routable
.invalid email address instead of a real developer name and routable
email address as required by the Developer's Certificate of Origin.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115152408.4820=
5-1-shlomojune6@gmail.com?part=3D1
