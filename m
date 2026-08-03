Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A253721883E
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 05:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785735472; cv=none; b=nmLL6ktHkcBvgHA6tx0gtRxI/mg8suriGQuaUfanYi2DnIAm2tqrAk6ehpNEZ+tC+WYjCmA1mQbLdo7TyIZMOoQrP+8FdRny7GOXa3g3vfw8yKHq9i09+Ffs90knwvs8n6aOi7YQ0YCYxKzYgBjvCuco9zipJmJwM9LU4d4d51I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785735472; c=relaxed/simple;
	bh=7Anm3AKnvvhwKIgrFjCZyc9SbAgIqEWfs7rg+g/A5us=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NBup8hhBK0b7mMY3peJVRJiH8TWg38AqQqHquBakFbym+iJbil0uotblMj0aPPrztT5KV2/CwqeJvqNjhGsqpQXLQjPJ1/mK5oQaZF/oJewrFcv6ZUgsAWOa+Nt6YjKdCBynLepSdoDv3FMhDzWNojoMxwbHPeXwb9BGezHrmJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dWK26w45; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dWK26w45"
Message-ID: <deb23c06-79e9-4c70-859d-14aaad4f0837@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785735466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G6MwJUKJDqGGyXm+wtcp6yfWvqnhfFRmmiwknxsMKUY=;
	b=dWK26w45PF7uFA2BzcaJK05CUpvWwLlxrtCHufkjoLbiPXEZxSbrvq7Khwtl5QcXvcE5T7
	8/53+zcBOsLAbaO2pvN3eU+E2R0nP1Fkls1BIDUSNMVBTFvP/RBAUAigONKvllff9aREXa
	G5fRmZFGYMYjTqvOWZrDkqeKjZnPFd0=
Date: Mon, 3 Aug 2026 13:37:30 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Remove unused BTF_FMODEL_STRUCT_ARG
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, kernel-team@fb.com
References: <20260803052726.2821447-1-yonghong.song@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260803052726.2821447-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/8/26 13:27, Yonghong Song wrote:
> Commit 814cba835ef6 ("bpf, x86: Fix trampoline stack size for 128-bit
> arguments") changed the x86 trampoline to compute the number of
> registers from arg_size for every argument, which removed the last user
> of BTF_FMODEL_STRUCT_ARG. No other architecture or verifier code looks
> at the flag, so remove the macro and the code in __get_type_fmodel_flags()
> which sets it.
> 
> Keep BTF_FMODEL_SIGNED_ARG at BIT(1) rather than renumbering it to
> BIT(0), so BIT(0) is available for a future flag.
> 
> No functional change.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>


Acked-by: Leon Hwang <leon.hwang@linux.dev>

> [...]
