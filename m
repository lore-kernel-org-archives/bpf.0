Received: from mta0.migadu.com (out-239.mta0.migadu.com [91.218.175.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095714D9542
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 16:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792340991; cv=none; b=rp571L+sDr+XZ9oExADCso2p6Nk42YIZM/H9wL2bDq+gM/jhmOOoarenf8mX4n9CEsAP1TkZrFkUoSM87DM9wwAs2hKkF//hSSx5G+R9U0r/Yx5y01XtVevzF111O+a7wV6TlO09FYTI0gJ3DYUvlJvmb0ZfZ9dMVeRwajg6vcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792340991; c=relaxed/simple;
	bh=U9wav5sfIjFQdO2RKChZ68p+smfiOFOGB3gnSg0l6Jk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F1B429fI27mH+jJEUSwoVxt28A+QJT/jYVGTSHcNf0uAUsz1+yKU4bK+4vim092Gj2mzD/C+gnHTVaLEzc6ij5SpWMRsy6CHUD7fTpxTVxjvlTEaHaDlfLTGnKndYnDGa4ENn8yHeUxHfljD5NqRb3r0Py6644gJ6NUrQZ9+LVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PahR0H1w; arc=none smtp.client-ip=91.218.175.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PahR0H1w"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=U9wav5sfIjFQdO2RKChZ68p+smfiOFOGB3gnSg0l6Jk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792340986; v=1; x=1792945786;
 b=PahR0H1wOWm41Oq82t0mWcvCAHwUDQDE5BelUpYTvTFnGulSvqmRmn5BEAQgZkSXa3cP3wfT
 h2cRpQ8elTB+sw60TYzzDu6t3oIfbaAb6MIGJ3mw6Zjgs27x1FFAIpE77HtCmqlTWYHs+71rfEW
 R/d9dUqUVIIdtaDd9N/XVVp4=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 65eb856f4f97cb8f;
	Sun, 18 Oct 2026 16:29:46 +0000
X-Mizu-Trace-ID: 65eb856f4f97cb8f
X-Migadu-Flow: FLOW_OUT
Message-ID: <faf8f8e0-819c-49c9-81c8-d5ce41d26566@linux.dev>
Date: Mon, 19 Oct 2026 00:29:36 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/6] bpf: Add syscall common attrs support for
 xdp link_create
To: kernel test robot <lkp@intel.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, Hangbin Liu <liuhangbin@gmail.com>,
 Martin Karsten <mkarsten@uwaterloo.ca>,
 Masashi Honma <masashi.honma@gmail.com>, linux-kernel@vger.kernel.org
References: <20261017142649.51047-3-leon.hwang@linux.dev>
 <202610181150.jL2DnHl7-lkp@intel.com>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <202610181150.jL2DnHl7-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/18 11:28, kernel test robot wrote:

[...]

> 
> All errors (new ones prefixed by >>):
> 
>    /usr/bin/ld: net/core/dev.o: in function `bpf_xdp_link_attach':
>>> net/core/dev.c:10789:(.text+0x96f9): undefined reference to `bpf_log'
>    collect2: error: ld returned 1 exit status

Will fix the issue in the next revision.

Thanks,
Leon

> [...]
