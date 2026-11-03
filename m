Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744098;
	b=KRlBBWyesS8ZQDdSiBD3foO64I65YI5ifay48rNaFT2/36nvYw78gW1tiq3r7D43k8dD
	 Rki7ZOe7dAE4aFJ9I9Exi5ZaHpmEvOLv+4CRpdtEiDRbkZA1wC7lKf1r/PuGO0xwBkxs+
	 NmKi+PqxXO2swQ49g6jUE/9orj8QegHq34DMhO6m5j/moqdCdz4QlcpvI1OJ/RlysmhF/
	 uoiJgtCLfDo9co9LmySxTaMeOhoo1T8wU9lfIWaMZ19q6EJVHXDgTNXvP1rpsG2C7P1uJ
	 IiVxXtfftRQ//sWP2Q/UzDOLZJxTSLCcN0204E9HBrv8+Tp3Zs64XX/A4/lZVCkAuVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744098;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=duzRvg964RfXuPnhLXTxeyHtzA5Vnl51oG0y9EUSR9A=;
	b=GldmWnUGoHR2LgKhgaSlEH1tMuUsnT3zB9uGT5AiM2V3FIjLlXOGnvPqZQkM63kN4pZk
	 MpdiahmNI3O/RtJhcYaDK7DntklZrK9SOHsaRfRopzN2w1GBVkzns5CIzKbB0pdaGostE
	 YyRo2ZFIt5WfJEaW4hFPZqyGFfs9kdDhiVrp6jXCszEQhAlm5CR4mNUcummtySpvmnVhK
	 yMPSGQ5kb8ohKJpPc8hmlrpfvyoA73tJPKFsfaBa0aLhxOueG2MYjV8dzMPEaf02ldti+
	 VQLyTC1OaQ18yQTA3ZNBuK9FYO19FZSY1Lcj1xEUrXFWC2f/B585Y7ssFFEYf1bBUyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bBaRQdiW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BC0606D80A;
	Tue,  3 Nov 2026 22:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bBaRQdiW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED5C1F00A16;
	Tue,  3 Nov 2026 22:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793744098;
	bh=duzRvg964RfXuPnhLXTxeyHtzA5Vnl51oG0y9EUSR9A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bBaRQdiWm/PneqSd0aJZ1MkSqZ4YMJfFj3ihBTIn2Rqg68CfnOQi6ATO74gckFP3+
	 zLlz3asm6TWFVh0aXuzHXpkTHZbpxBPDy+OWpZGQ1waMB0Wuk1w+QSibz7iRru6Sah
	 hpILvVFcLy2n1BcwbSj/EELyea2wxq7wo0dzY4eHPCrCzfkXr5ceZWDCcFzm9P0RLC
	 2zFT8isozEJJ52Wbm91stdKzpp5OkW+E5SRZWNIeqmguNdrhBkD4+e319NM6GKevrQ
	 8Lhd9Y8l+5NXP5jRugwiQAkd+VWZshcluuqra/B39s0X/Lj4z+5nRmVHRdc0ptwUd0
	 7G3caakdf58ng==
Message-ID: <b7ef8ef2-d3f4-4ae6-997f-c47c58dd7d7a@kernel.org>
Date: Tue, 3 Nov 2026 22:14:54 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 2/3] bpftool: Don't require a disassembler to
 dump a JITed program to a file
To: socketpair@gmail.com, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Jiri Olsa <jolsa@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 Nick Desaulniers <ndesaulniers@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev
References: <20261103-bpftool-plugin-v5-0-683e08a25df0@gmail.com>
 <20261103-bpftool-plugin-v5-2-683e08a25df0@gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20261103-bpftool-plugin-v5-2-683e08a25df0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-11-03 18:59 UTC+0500 ~ Mark Korenberg via B4 Relay
<devnull+socketpair.gmail.com@kernel.org>
> From: Mark Korenberg <socketpair@gmail.com>
> 
> "bpftool prog dump jited PROG file FILE" only writes the JITed image to
> FILE, but do_dump() calls disasm_init() before it parses the arguments,
> so the command fails when bpftool has no disassembler.
> 
> Call disasm_init() only when the image is disassembled.
> 
> Fixes: 29a9c10e4110 ("bpftool: make libbfd optional")
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Mark Korenberg <socketpair@gmail.com>

Acked-by: Quentin Monnet <qmo@kernel.org>
