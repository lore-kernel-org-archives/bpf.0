Received: from mta0.migadu.com (out-228.mta0.migadu.com [91.218.175.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD10F3A0EB8
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 16:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792340971; cv=none; b=u06UN9MZbc2i+39TYRog4OjxBXmhr7TZ0Ti1Y+SrT9bx96z8ZFAjFPJCKyXghPq6zMaTOXKtUD2NQHvEn1BhyjAmUAXdbCkXeWTFMYvtF4R/fWkkcRFwhDzuzf4IoeANNf5tED7vJLDn9oyMkigHgEKoXHqUG+sRDbignsgodcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792340971; c=relaxed/simple;
	bh=ViV0nj9cRHse6UGDstHAc2ktKPo1QpwOjmKPhTsMC+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PgHCamZAM/cfZSohnJYXU5X2BOb17WVOzOcGlsWmY/YZ4sZH6AMGffA4oqzo2c2LpJqTM7v5NUZyay8OJ1+Qj+EMQRy9I6KV0NIKBTlHlPC6TzEKMTGT0mcIqIP7iTt3wOJ4bFemsziE/szErkkTme0v2hmihidVL5mIbREQOGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Mr8mLIjC; arc=none smtp.client-ip=91.218.175.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mr8mLIjC"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ViV0nj9cRHse6UGDstHAc2ktKPo1QpwOjmKPhTsMC+o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792340966; v=1; x=1792945766;
 b=Mr8mLIjCHC11h2veMmadw8h0oLWxT07AeyI1VhLC1aY9rJ0jLGE/ltAPNnarKfYCTQ35ZPCQ
 MwSzG75eJAe9ph+AZJSF0ndodhtVC2k4DfnTUGNHYEotUKshcwXjMPqtDjcm4geaBy3AeAS1ugp
 bK2aWWOQ6kP0O+skephZtUto=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d4955e8ef7af840d;
	Sun, 18 Oct 2026 16:29:26 +0000
X-Mizu-Trace-ID: d4955e8ef7af840d
X-Migadu-Flow: FLOW_OUT
Message-ID: <63df2aa4-5722-4599-9d88-ff1e74268604@linux.dev>
Date: Mon, 19 Oct 2026 00:29:16 +0800
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
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
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
 <202610181115.hv8jYAxy-lkp@intel.com>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <202610181115.hv8jYAxy-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/18 11:46, kernel test robot wrote:

[...]

> 
> All errors (new ones prefixed by >>):
> 
>    /usr/bin/ld: warning: .tmp_vmlinux1 has a LOAD segment with RWX permissions
>    /usr/bin/ld: net/core/dev.o: in function `bpf_xdp_link_attach':
>>> net/core/dev.c:10789:(.ltext+0xcb71): undefined reference to `bpf_log'
>    clang: error: linker command failed with exit code 1 (use -v to see invocation)

Will fix the issue in the next revision.

Thanks,
Leon

> [...]
