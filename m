Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794326138;
	b=DTaQuXnm3Ze04WFzxSIBebVBk9DhwuN6U9VJWOQr4RmHPPCQ0TloESphV/4Tz3OH1MUa
	 l/hyjErqDHGmKxJA8cwjI2n4j1/D4xAwRu51dnwxo23UAImQYZ0egtl4BTDo/jpmonhpE
	 UZJCNRxgZEeRW2WBers/A2QwqtzfG55DJ1W6mS1YKG8WoFN8SS/nCmmJw3cHtBpC5rIga
	 y7JzZTXRh/71hD0TES8rRhhIqoI3tZk05eZo5PEvGQT16Kxt7InCrDBp4adkfxewxoBle
	 1Hu/dDx5c/zOKhG1zW1pfI46L8vjG+QMwppLJQGGTXsuvK/gb+kPknhJGBuQOpwVLhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794326138;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=SvIe1dTA5bgP0oOOky8Z1uVZhZTsydnSnODkTILXkXw=;
	b=p/g4jx9xwtDMDKuklICSM6fK0KcGcKByPt/CKqep6ufHRILEuHHScLXikD0VZ2UWQgwl
	 7EAjNOWq8LyMJSBX+ChtXJINOj0lmO13LoX5ncqan22r3M/W+qm/I6JZN3kFa+DxWC684
	 4Ee8NDFFxmEVh2fiWqdq6iFMLhNTKQvEzxHG9QiknyLv0KSHblhZV1Np45wpzFzy4FujL
	 SpWVg2110lz4JY1inmTUSNP0Mdo3UUx8eW1xpsfWwX0t5WEt8hCxiiGP/QIkIPl097SN8
	 bIG8E6+Mx4oxYNzvxme86Ukcj2sRlgFILQqvot5VhGqbUKDJXDEr+3/3RBobsm4Ok7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hxozIhHm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370BB606A323;
	Tue, 10 Nov 2026 15:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hxozIhHm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD06D1F0089F;
	Tue, 10 Nov 2026 15:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794326138;
	bh=SvIe1dTA5bgP0oOOky8Z1uVZhZTsydnSnODkTILXkXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hxozIhHmmpI0orJHynU5GErfujgQcajB7c5xDfVJaCwJou8oudZLuQk/PhicbS0K7
	 XNmgvLHiXxVpurT9ttEcApD8O0aIbqdrPmJHZNjpuRaLyqXmSQ5+Uf32xSIiKjIic0
	 Ic5+0xgvDdFUuxitJ/dzD6YM7jV20SLaKKRi2ebOQPBPACLThIMab3dl3LbKXvLZUz
	 5irq6W8mI0FPPZB7SGVHrNurymQtdA7AXHGWGNoomKzVQFgiiPkAq4bW2qx7B3fFcs
	 pkwz/3s/25vWVBP7mKxlgp5d8PcnhH6WqiIQkZRln0vpFOV8I/KugDXhXFIZ9Qc4qc
	 SvD8pzcRJX39Q==
Date: Tue, 10 Nov 2026 16:55:32 +0100
From: Christian Brauner <brauner@kernel.org>
To: Eneshan Karaca <Eneshan-Karaca@yandex.com>
Cc: kees@kernel.org, rostedt@goodmis.org, viro@zeniv.linux.org.uk, 
	jack@suse.cz, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	jkoolstra@xs4all.nl, farid.m.zakaria@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Subject: Re: [RFC PATCH v2] binfmt_misc: add binfmt_misc_select tracepoint
Message-ID: <20261110-gefruchtet-singt-allabendlich-ff8653eb8631@brauner>
References: <20261029185849.8016-1-Eneshan-Karaca@yandex.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261029185849.8016-1-Eneshan-Karaca@yandex.com>

On Thu, Oct 29, 2026 at 09:58:49PM +0300, Eneshan Karaca wrote:
> From: Eneshan Erdoğan Karaca <BoxStrikesTeam@proton.me>
> 
> A binfmt_misc entry can select an interpreter for an exec.  With a BPF
> 'B' handler, that selection can be made by a BPF struct_ops program.
> The kernel commits the decision in bprm->interp and bprm->flags, but it
> does not emit an event at the selection point.
> 
> Existing observers have to reconstruct the decision from
> /proc/PID/exe, AT_EXECFD, AT_FLAGS, or /proc/PID/maps.  These sources
> are mode-dependent: a transparent dispatch still reports the original
> binary in /proc/PID/exe, and a short-lived process can exit before the
> observer reads it.  A classic dispatch reports the interpreter, but
> not which handler selected it or which invocation flags were used.
> 
> Add a tracepoint after the interpreter and the invocation flags are
> selected.  The caller passes the matched entry and the raw flags; the
> trace event resolves the handler name and masks the flags with
> MISC_FMT_INVOCATION_FLAGS.  The event reports the binary filename, the
> selected interpreter, the handler name, the invocation flags, and the
> pid.
> 
> The tracepoint is observability only; it does not change exec
> behavior.
> 
> Assisted-by: LLM
> Signed-off-by: Eneshan Erdoğan Karaca <BoxStrikesTeam@proton.me>
> ---

This is whitespace damaged. So Sashiko can't look at it.
Resend it properly, please.
