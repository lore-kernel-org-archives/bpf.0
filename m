Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566093B2AA;
	Sat, 14 Mar 2026 21:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773522377; cv=none; b=Jaz9F3JPjEQOclxikcrJvpRvGMMrV41t8OF61nJum8eCOMAu74nJELj55YPt8mOUPpN/RrRhD0tLRQ4Wl9xt0BjRRi/Q9q5mNM4bnFKs/3CGe3tOdqnLO6YgkJWdZAMY9fuGahQU0a9eqnmJNY8sNSUVHSVkdPQ6KnGagaCN/6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773522377; c=relaxed/simple;
	bh=bms8vMynUJtytUWR8ov5kA6t6ZsRurOXRs5n5q6qcbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hgcl1Hdins9zOMvYMVB0VfyQ2/d6rMw8Jit7Nw8CFUX/WVmvuBujPymovgAzMlypGlV0GNDQsCq4qlMWrPQ26wtixcvlljv0If5G0iG9CBwDvPwhzxIpR+BNlnwf7TTPu/OpCpqNPJPwbhPthGTR2A22PGYyo7hDmI8PEF0nV7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DM2RRZwR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DM2RRZwR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC56C116C6;
	Sat, 14 Mar 2026 21:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773522377;
	bh=bms8vMynUJtytUWR8ov5kA6t6ZsRurOXRs5n5q6qcbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DM2RRZwRcLJt3LYmIPzwSsvjss5qJg2Nj4ijIsywbTC3ExwYDvCSw9GUrvcOYgJhj
	 AsH0sZaNNgHa32S1IZz0Mltm8XLInzydw3aXJgoxsa75epWWnSOQKxH7/sRRDwxGbv
	 Yg3u97kKgfCymlH3yy9zrV5iQJcagszbXnLbFN8xL1wYEG3QAYF8XUCh7jeDIZ9/SV
	 xixA2C69eGGM+cdd075nVytYMlglPxnHNYyocIUxAqsKAg9hblS2fy5/2HVqVJ8Mj1
	 5HlOTPUzJTk4DupxP0IMGXhXMqJcxilRkbshR+0tIbRqGc7Qp3rnPMx8E5J8pBNu5P
	 tKZsSmAqxLXeg==
Date: Sat, 14 Mar 2026 14:06:14 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: Remove inclusion of crypto/sha1.h
Message-ID: <20260314210614.GB45660@quark>
References: <20260314204734.46111-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314204734.46111-1-ebiggers@kernel.org>

On Sat, Mar 14, 2026 at 01:47:34PM -0700, Eric Biggers wrote:
> Since commit 603b44162325 ("bpf: Update the bpf_prog_calc_tag to use
> SHA256") made kernel/bpf/core.c use only SHA-256 and not SHA-1, the
> header <crypto/sha1.h> no longer needs to be included.  Remove the
> inclusion so that it no longer unnecessarily comes up in searches for
> which kernel code is still using the obsolete SHA-1 algorithm.
> 
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  kernel/bpf/core.c | 1 -
>  1 file changed, 1 deletion(-)

I missed include/linux/filter.h which is related.  I'll send a v2.

- Eric
