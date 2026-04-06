Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B84535294E
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 23:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775517004; cv=none; b=t7Bjs27F8V8YD4ytLF+P/pRkYvprvV5P4B2u7j0p/z+DXkYwpvCkfUasXdJhkXPFswzJhRhwIExo+JWZcyOd78FbztElwO82R8NIvYxNmXaOVoslE4pM0en5el7+ayFPMpzPNjNm0nwO3GXtdK3B8aLJ9TsgW4P1Y+G2diDMPoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775517004; c=relaxed/simple;
	bh=aav1lhR8vSFtAoSET/qKuyidyqCyOvG8gkWmbtg64So=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTk3IHYBJS4Dk6350dYypyruDY5PYk1jNZ8GPz+LEdOnNYGhNbSKhF8tgD5zQ7J5E3RBxbAuzu1GTyhR/STxe7t2qPky7bQOcs12GeunUQkcs9kMDcHGTYR1wz3UbJSsMd7KYByE+hKZyUffQmwUZ5st6dA4K4uscSw8A1CbiQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nRATh4BG; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nRATh4BG"
Date: Mon, 6 Apr 2026 16:09:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775517000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/bPOhIIvmuTeeJGSnL/TObh+9FGDRoQVYzMHqtnl5g=;
	b=nRATh4BGOrpkfckLmZMVXj8l7mNOBfAeRwqzL5E4XfOeZJoH6qksRu0gPRtrsGijderNLO
	TxJHabaIP2gbyqfZL+lD5MKbILj7F/J+p/XxmtLEl97EpXLmPSt6jI32AaeWCQ1ERpb1K4
	uqUEQpEiVCIhPLAJqQmSeZfPsok555c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, 
	2022090917019@std.uestc.edu.cn, dddddd@hust.edu.cn, M202472210@hust.edu.cn, dzm91@hust.edu.cn, 
	emil@etsalapatis.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	shuah@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix same-register dst/src OOB read and
 pointer leak in sock_ops
Message-ID: <20264623643.FrCc.martin.lau@linux.dev>
References: <20260406031330.187630-1-jiayuan.chen@linux.dev>
 <913274772cd62d8d93e6cfb2c251c2388b73f24f90d05be3c9994207ac7048bf@mail.kernel.org>
 <739cdd1f-1838-457d-9b71-f47c3eadb0fb@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <739cdd1f-1838-457d-9b71-f47c3eadb0fb@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Mon, Apr 06, 2026 at 12:54:04PM +0800, Jiayuan Chen wrote:
> 
> On 4/6/26 11:47 AM, bot+bpf-ci@kernel.org wrote:
> > This Fixes: tag covers the SOCK_OPS_GET_SK() portion of the fix,
> > since 84f44df664e9 introduced that macro. However, the identical
> > bug in SOCK_OPS_GET_FIELD() was introduced by an earlier commit:
> > 
> >    fd09af010788 ("bpf: sock_ops ctx access may stomp registers in corner case")
> > 
> > That commit added the dst_reg == src_reg handling to
> > SOCK_OPS_GET_FIELD() with the same missing zeroing in the
> > !fullsock path. Should this also carry:
> > 
> >    Fixes: fd09af010788 ("bpf: sock_ops ctx access may stomp registers in corner case")
> > 
> > Without it, kernels that have fd09af010788 but not 84f44df664e9
> > would not receive the SOCK_OPS_GET_FIELD() fix via stable backport.
> > 
> > 
> > ---
> > AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> > See:https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> > 
> > CI run summary:https://github.com/kernel-patches/bpf/actions/runs/24017481706
> Well, it's true. However, fd09af010788 and 84f44df664e9 are from the
> same patchset (same author, same minute), so any stable branch carrying
> one will have both. That's why I only included a single Fixes tag.
> 
> But if you prefer carrying both explicitly, I'm happy to add it in next
> version.

Please list both in the Fixes tags so that it is clear both bugs will
be fixed. Thanks.
