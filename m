Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A22233953;
	Sun, 21 Jun 2026 15:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782055246; cv=none; b=WBXH6QCcg7l4uV7SQLwtZHKApApl2wyrMlrsVe65t0dwMcBkdSSdcRyv7Bz4Okssj7LaDAku2yX0/j8y+OBvEYQWxtiVF4/5Qyo2vuvlzYGZQ3j4jvMpqC1OiIVN80NIIaLY9oq2g6L8Ca59xT7HsA7HQaeE0BV4cjwaGe9ka0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782055246; c=relaxed/simple;
	bh=rKIMPUmzRveKwHddJ/EA21WdlMmGguO4xgX4pF0584M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ajXt9bPHOJOazOb8dsvZKsLk9UeHHGqNNkvAlnuc6dWvjuDUQpOeaoDNi0TEA9pT9Uxgt8FGxWUZeQ7cTRm4uNNsDIvN3fbGa1aWE7JZnF8zeKCgJ1x+rWPgQNbe55WUxtK9mXNQ2IF1KPT4CsV0vPCQVqXM7r+l0PgWM7N449c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m+lZcp0z; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m+lZcp0z"
Message-ID: <2b32c86c-ec24-4fad-951c-4f915364692e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782055242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rKIMPUmzRveKwHddJ/EA21WdlMmGguO4xgX4pF0584M=;
	b=m+lZcp0zzk+bbLPANtlAQIU5dbn9xJkcV9dUVVKFQtYmMaeTHO005U7O4tyS7QUt99hPPY
	3iO4RrR4W7d0T+WdBB2KmIGTIN72TinrrwN6TD4Tb6Zah2pgSFulaRo0w8f+HQQAk6PkHv
	M5ojhqXX6iaNNfUgNTBzfTpNvDd3apA=
Date: Sun, 21 Jun 2026 08:20:33 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Enforce gotox targets against
 subprog bounds
Content-Language: en-GB
To: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Anton Protopopov <a.s.protopopov@gmail.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260613-f01-02-gotox-bpf-next-v2-send-v2-0-ff980bc5a329@mails.tsinghua.edu.cn>
 <20260613-f01-02-gotox-bpf-next-v2-send-v2-1-ff980bc5a329@mails.tsinghua.edu.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260613-f01-02-gotox-bpf-next-v2-send-v2-1-ff980bc5a329@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/13/26 2:33 AM, Nuoqi Gui wrote:
> CFG construction records the modeled gotox target set in
> insn_aux_data->jt. It includes INSN_ARRAY maps based on whether the map
> target is in the current subprog. check_indirect_jump() later validates and
> follows the current PTR_TO_INSN register's actual INSN_ARRAY map. The
> verifier does not check that targets copied from that map stay inside the
> same subprog as the gotox instruction.
>
> This lets one gotox instruction observe two different INSN_ARRAY maps. CFG
> can select a map whose target is in the current subprog. Another path to
> the same gotox can carry a PTR_TO_INSN value from a map whose target points
> at a different subprog. The verifier then accepts a cross-subprog edge that
> CFG construction did not allow for this gotox instruction.
>
> On x86, gotox becomes a raw indirect jump in the JIT image. Accepting a
> target outside the gotox subprog can enter another subprog without a
> matching BPF call frame and crash when executed. Validation observed a GPF
> in bpf_test_run().
>
> Fix this by requiring every target copied from the actual PTR_TO_INSN
> map to stay within the subprog that contains the current gotox instruction.
> Reject the program before pushing verifier states for any cross-subprog
> target.
>
> Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
> Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

