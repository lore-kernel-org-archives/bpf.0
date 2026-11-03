Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744091;
	b=xVvsXPJdoHtGKCqPxCeL9+2wAc66dN+kR/WLEr89fuDcEDiaiEtWidveNG33XSJKq1VE
	 Ac6lH2gNRq8D9DfqzQMT1kb2iP7b8XCnHoEJzCS6o1U/SnYZqgz21lD6qFeS0foaX0GNi
	 C6kC8pSolSPK/qNXSf1DC6WUaR9+8ViNBQ5HKaX0EZW9Rj2EsQin8LtfsvenCi5aQY728
	 lwLGoJhyS4F1t1wgXjDpAQlaTqQwrBoZfKf/QKzrvmWsuQMh1YLsX2Th3pDM1L1RgO3Vr
	 qG56C5CMX0qumUtxchnCdFYOT+4GsiV50hckyT/adYMqgE18n9XeJtFn2IQJ2cRwwlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744091;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=GrWMLf5u+Ta3+WJYmHg9xA9PrNNnzI5nPox/tR4OoAA=;
	b=JRmYqsIz2JBlVagduCaUqohR+wSxMNtpsM3bU6sCFi0bZLRGbVGoXX0yjQMQOoe1+XUj
	 ofL3NLDc1KxSxtmF/rUSKqZi/b2iXCq4ArNaUKO49DF4Cb36R10/ArtbaV6H3BdloooRK
	 Axks1SIowfc4nyy2iCKubEoAh6R37fCDxUB21i2bCBYqX8oz5aHliJh68wEfjOLR7FYnQ
	 HPO+jlNc515xlzkPO9KEpWlCiXrb+ZxXto8W8ScblVUgoJ+iizGHDmQsFO6hcct8FHRlR
	 CQ+MRnhzUllY6MoGjVHe1SCBIuCcbUm0YOSmul/J4leaY/lLzGT8PbZ1etW98rLaOSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ejQ1g1+t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400A1606A326;
	Tue,  3 Nov 2026 22:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ejQ1g1+t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9615A1F000C1;
	Tue,  3 Nov 2026 22:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793744090;
	bh=GrWMLf5u+Ta3+WJYmHg9xA9PrNNnzI5nPox/tR4OoAA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ejQ1g1+tKWLQP5xtbi3inO8a/xlExDnXSLdhDTNvnH49TrVn3DG4qF0yZ2XqRfsqa
	 oKAocEh8B2jcTcLublrJyFQXZLCScpTd9m8+3LAhpybqBOVthNQeshTmKhOzvbGtuv
	 w9y03MRNyN0jJ7aDJ/+GGZuspc2xtvs8VWt9lBjz4yqzgbe2Yove6CNvZP/XW3Nnha
	 1YoE6FX7Q8dwXpvCKR4Mzy7IQe5Y6y2kDnPv4lyKhG9HEZC25u2KnD6MDo16W1c6oS
	 mHn5EyT1NBxSmtYU+akyVtFH16euS38bByL6lwBjVzGg/KKCVQi+DiRiTvIMBW/hrY
	 nq965KidmwKzg==
Message-ID: <a3ef692a-a9b5-4057-b9b6-1279951d7bc1@kernel.org>
Date: Tue, 3 Nov 2026 22:14:46 +0000
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
Subject: Re: [PATCH bpf-next v5 1/3] bpftool: Fix disposal of the LLVM
 disassembler context
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
 <20261103-bpftool-plugin-v5-1-683e08a25df0@gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20261103-bpftool-plugin-v5-1-683e08a25df0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-11-03 18:59 UTC+0500 ~ Mark Korenberg via B4 Relay
<devnull+socketpair.gmail.com@kernel.org>
> From: Mark Korenberg <socketpair@gmail.com>
> 
> destroy_context() frees the disassembler context with LLVMDisposeMessage(),
> which is a plain free() meant for strings returned by LLVM. The context is
> therefore never destroyed, leaking about 28 KiB per disassembled function.
> Use LLVMDisasmDispose() instead.
> 
> Fixes: eb9d1acf634b ("bpftool: Add LLVM as default library for disassembling JIT-ed programs")
> Signed-off-by: Mark Korenberg <socketpair@gmail.com>

Acked-by: Quentin Monnet <qmo@kernel.org>
