Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949504FC8FD
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 15:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788794694; cv=none; b=kmYWQ5umlpZL1GtgOHK1fpFd6s4y2xuV3lJWrq1d+87TboShKTIz77KMKNhoQdnYXVL2vB+Bfs6fFS0o55BVhZtyBtGHC3p9J5g7EdJH72uFjhYdMzT9fNoloIDQt4CxyDd29EILud3oBQKna9vcEG+acMrshqubd4BoVdZiw38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788794694; c=relaxed/simple;
	bh=9ZBqo1rFwfzZXS4zmK71L/TD2ssWnnDmLosPeWd4WR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ff5aTW4bn4a3omNgnUOuJxs/DOZCqB5TXnOrmmgCxlmv0/pPtsqX3g/LHWnXI8RWrnVvaC35/plij7SFGmpypdx9s0b4RpPTO5Qb5BjCGpNn8dnR71RRdL67itzd69eBuo1eEzrv6ki+YXWNOmJbkbsbJoQObez9RxTdseUPzRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WaUQxzZz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaUQxzZz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 386F01F00A3A;
	Mon,  7 Sep 2026 15:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788794693;
	bh=SjPPZjM8nCZMuZCBq69sVAWq5236xcYT2B1kjN3insc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WaUQxzZzNipVH8Ep8/jyAigtU2axouDg3Ek9SB8Itd2RrPGnzAHjuIuRl8UGQPx3w
	 uflXuK0VQZtwz+NhZoMPVOtkiDfC+ytYljW0vFjHlVZU9+ZZZtoW1cDwoR8byjuw+n
	 chhfiowyE+WcnB4vqC8rDqPgTOU9Mf43KDUbMMJAXPAoxlwa2n5GsAwVMnNooqsoUw
	 icwwvKeujkgO8cIswl8WCK++XY2rQ13nneAseh60eClL1ioNneHFKX87L+X4nQcHuo
	 me6nVEh+biir98R4qgOrZMxAlXm8ZpJ+3qFvm7pdq7x8KXNu2hXj82VLSpHuKEnmN6
	 6SUCEQLsAPcNA==
Message-ID: <d9f8634e-e7cc-476f-92c6-a8f6f4f8f0c9@kernel.org>
Date: Mon, 7 Sep 2026 16:24:50 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 4/4] bpftool: Adopt bpf_program__add_flags()
 helper
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org
References: <20260903092416.223294-1-toke@redhat.com>
 <20260903092416.223294-4-toke@redhat.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260903092416.223294-4-toke@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/09/2026 10:24, Toke Høiland-Jørgensen wrote:
> Adopt the newly added bpf_program__add_flags() helper to
> non-destructively add the BPF_F_XDP_DEV_BOUND_ONLY flag to XDP programs.
> 
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>


Acked-by: Quentin Monnet <qmo@kernel.org>

Thank you!
