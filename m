Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40E52236F7
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 18:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782412625; cv=none; b=bLetosxH8N8bMLfrchfCY3MhO6o4qyEkgEto34a6vb7A6rF4AEjGHGkPI4ZgEkKWdolNoapXGoom2nvEhSQc26kpZ1f6EwuhvF0w+4ACcsweUYpHMTTRPCO9P2Qx9J2ZKeBKp/x97r+7DYX96fcA598yOoeDYgVxa3HtsZrYMJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782412625; c=relaxed/simple;
	bh=e7yr95CO4e7lrTHs/ETlclDyz0WPhq8KQMU65q+El/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MoDjx+JRmB9tuzWHTFLgPPuELz9pA+90i7y2U474U7mcCV86ftTJudZ0hniWAyf4U4YUZDfESDGEUvwrIyc278O1SBPLNXd+0KT+YUmfqeBugDx++NSqA5f9oqgJCY5nZYdWKNy8POZh5Gh4yYUawBZcP1/zBJ8mVmKyhVfTc04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dGnVlsVF; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dGnVlsVF"
Message-ID: <d7cc7812-3298-43ef-849b-d8172ebbaaa6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782412621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e7yr95CO4e7lrTHs/ETlclDyz0WPhq8KQMU65q+El/4=;
	b=dGnVlsVFxGOqNeG7CXXodwEJjI70K+ObTzd5io3II4Hp2S9SfM11fxiYTUEUdd36aHQxXM
	DvcVv2/gmKwTt7Gjn9+JU4XINXrU2VNq83wNx27tBTrGtvwbTpHFNxl9Zzdf2LV2f+yBt6
	vNlPGZvBvCpdI+7AeInjBY0wHWsM2os=
Date: Thu, 25 Jun 2026 11:36:46 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] libbpf: poison unresolved weak kfuncs in light skeletons
Content-Language: en-GB
To: Siddharth Nayyar <sidnayyar@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Giuliano Procida <gprocida@google.com>,
 Matthias Maennich <maennich@google.com>, Tiffany Yang <ynaffit@google.com>,
 Neill Kapron <nkapron@google.com>
References: <20260622-bpf-lskel-fixes-2-v1-1-004d72cba5c2@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260622-bpf-lskel-fixes-2-v1-1-004d72cba5c2@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/22/26 4:04 PM, Siddharth Nayyar wrote:
> When the light skeleton generator (gen_loader) fails to find a BTF ID
> for a weak kfunc, it correctly clears the immediate value (imm = 0) to
> convert the pseudo kfunc call into an invalid instruction.
>
> However, the generator fails to clear src_reg (which is set to
> BPF_PSEUDO_KFUNC_CALL). This leaves the instruction looking like a valid
> pseudo kfunc call with a zero BTF ID. When the target verifier's
> add_subprog_and_kfunc encounters this, it unconditionally scans all
> BPF_PSEUDO_KFUNC_CALL instructions, sees imm == 0, and panics or
> fails the load (e.g. bpf_unspec#0 or -EINVAL). This entirely breaks
> the verifier's dead-code elimination logic which expects to cleanly prune
> branches protected by bpf_ksym_exists().
>
> Furthermore, when the generator processes subsequent references to the
> same unresolved weak kfunc, it copies the imm and off fields from
> the first occurrence but skips the src_reg field, meaning subsequent
> calls also retain the poisonous BPF_PSEUDO_KFUNC_CALL flag.
>
> This patch fixes the issue by explicitly clearing src_reg for both the
> initial occurrence and all subsequent occurrences of unresolved weak
> kfuncs, converting them into standard invalid helper calls that the
> verifier's dead-code eliminator can safely recognize and discard.
>
> Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

