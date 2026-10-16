Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C797463B6F
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 09:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142747; cv=none; b=fsThd2eTKJ5yykVgSVX7r4ser6UMX7Cm7aYyvUOW+YtMHbRQ8esyUHzQun3KXOQWVKG4rzvuN6+z7zl/G/P3SVy5cDJH62uJJQoRaIn5Q6019k9SQEgVAaeYAS3fsnQN9uSfhSPJjRLqC4Nx8sAybtfrav2hJndnTZc+H3wDrRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142747; c=relaxed/simple;
	bh=P652jYdbCQlcASTD0EfuKlldPxwkPAa+hZ15G5j6aYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C1n62jRQ4tUrLHGnhI2KipfZxQ6rtegJ1XaN++S+Aa5np2v15Pn9QG1rsjDcY0PtZ9nbq/yc92gWAbjHq0R12Gcv0iaXHyM8gzE4gWfVzzlqqKel5WfQUp3YZtlXDSeAvLiL8VN9hTRlvGk9RdUQMZfoWkkgEf9ugq4Nh9i3tD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmJ8aIOl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmJ8aIOl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E1201F000C4;
	Fri, 16 Oct 2026 09:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792142746;
	bh=OXeGMtL8pYSgWGAQsewXeUQzwMPnVQAz6YDQBAl9ieE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=AmJ8aIOl9jDJm+lMXNK/9TLQP3A5/K+Cz9iu5nX84KsDYzCaSgb49qhRid9ea95l7
	 NbK3qeSkG2/8qc8LIOt6VoT1QftIF2L2w6jac991X4XfSGosvHqOJbhO0cybyJaBNT
	 JBgBt9v5dIDgEwb0dmOvli7Wmz5TdJT5frndI/AaW7Umls6a4Km+nMj6MD5RX5ice8
	 Q9fCGf0iFwdZ0Kg8JM8NxdzySEVNehnWrETgJlgEx7xEV3yJi5X5dZQzyw9Fk/kBoG
	 EtgTQR+ksXYrgG3UJSKyfj5nN7D2zTwndBqZHG5dq/9gP87IPUKeSDFccvtMRAQFR0
	 JtP3ekF8FPq2g==
Message-ID: <b05d0c61-6b4d-41cf-adfa-c5b1da0133d3@kernel.org>
Date: Fri, 16 Oct 2026 10:25:41 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 1/8] bpftool: Dump C from a detached BTF copy
To: Ihor Solodrai <ihor.solodrai@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Quentin Monnet <qmo@kernel.org>
Cc: bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>,
 Cupertino Miranda <cupertino.miranda@oracle.com>,
 David Faust <david.faust@oracle.com>, Ian Rogers <irogers@google.com>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>,
 Vineet Gupta <vineet.gupta@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>
References: <20261016000012.2232059-1-ihor.solodrai@linux.dev>
 <20261016000012.2232059-2-ihor.solodrai@linux.dev>
Content-Language: en-GB
From: Alan Maguire <almagui@kernel.org>
In-Reply-To: <20261016000012.2232059-2-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/26 1:00 AM, Ihor Solodrai wrote:
> To emit per-record attributes in the C dump, bpftool needs to add decl
> tags to the BTF it dumps.
> 
> Modifying the parsed BTF fails for some valid input: libbpf refuses to
> modify BTF whose header carries unknown nonzero extension bytes, so
> such a dump would stop with -EOPNOTSUPP.
>

Curious here; did you run into such cases? I would have thought the
only case would be something like where we have kind layout info in
a bpftool that does not know about kind layout, but that can't happen
for an up-to-date bpftool with libbpf that knows about kind layout
unless there are issues with out-of-date UAPI headers for btf_header
or something. Wondering if there's something we need to fix somewhere?

Thanks!
