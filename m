Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E1E2F12D4;
	Wed,  8 Apr 2026 20:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775680386; cv=none; b=lo+TSQv6U9Q12a1d1u+1scG0KMq+bSRmhTzq0OqOEPz2ZzYSwP0CZALc4iBesiIoh32cDLDjm0KhkW1/SyfRPv7bX3FBBKQVaE05269aGZzCfR4CVjqqYNPBoWOz5E+ODIiIJ3bbTptogO+9Ylh1LnxgX82PAsIIzX0Qpt/r6kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775680386; c=relaxed/simple;
	bh=1DkctGdwrTIjPQFe3xrpJR+9Dn+GNdEzCKcXEf693Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9pylEGp3COOlrZ+KpZ2T6Kw1YRn7dS5R7dzsbdE3Hzjy+JyLSLKk7BWQUSAplNJ0EA1BArajOj16mIW1TQHAGRyz7Dw5yvHzNIS0/bfJXPs+bimPEK4rG2EAiWuh23tG27X/QZWa8vM/uEGjy9XGpp/vLfiaJtDQObmSqWbDZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YV+4hzpT; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YV+4hzpT"
Date: Wed, 8 Apr 2026 13:32:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775680382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1DkctGdwrTIjPQFe3xrpJR+9Dn+GNdEzCKcXEf693Mw=;
	b=YV+4hzpT/h7y9ud87cZn3xZiFIS7ZQbdZf5malk2jE13iSVgUyaGEH+yl8bHSWaDY66ssf
	TfEM7RyfV2oB7rDuhH0MGvgZCXQb99OanMtWzvCMfErquEByQ0oMx3jllPgUGL8LF53OFr
	8xTSi/UeIWHz5yxJi4pMM4lK9cj0lCc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org, werner@verivus.ai, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Sun Jian <sun.jian.kdev@gmail.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v3 0/2] bpf: Fix SOCK_OPS_GET_SK same-register OOB
 read in sock_ops and add selftest
Message-ID: <202648201958.2Esk.martin.lau@linux.dev>
References: <20260407022720.162151-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407022720.162151-1-jiayuan.chen@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 07, 2026 at 10:26:26AM +0800, Jiayuan Chen wrote:
> When a BPF sock_ops program accesses ctx fields with dst_reg == src_reg,
> the SOCK_OPS_GET_SK() and SOCK_OPS_GET_FIELD() macros fail to zero the
> destination register in the !fullsock / !locked_tcp_sock path, leading to
> OOB read (GET_SK) and kernel pointer leak (GET_FIELD).

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>

Jakub, can you help to push it to the net tree? Thanks!
