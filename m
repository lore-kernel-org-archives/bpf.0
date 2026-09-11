Received: from mta0.migadu.com (out-142.mta0.migadu.com [91.218.175.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAC42FFDEA
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 03:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789096699; cv=none; b=OzuDOHvWGH69W1vMB2FFDUx4/D7/kQb90J/gBrF1fjN7zHev8cPeODGfdeVgqJRisvPjNqmWGMBb+LpWW0/pOA9Jz7uez7oFUAV/Zx6zl6s1T+RmnO5vS2VDuRzRxguTyrw818uNlvepUuKhexBCa2rTOnbkPvBblhDZRabdHs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789096699; c=relaxed/simple;
	bh=z+h64Bw5LGymmtqK6vxANAX9/xXvrCTaoNjZM15BHvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=utmd+XQln/ZmCy8jPLLeqtFvozR8sGPoQ8CYqskuoFaIucg1WegLcBwFCTZB4D4jDRRwKz98+ZzSYXkJt9x2A71xuGjB8vRqPeKXxJYJzuan1iNn6YFpYgw3MuDYw2Xz5Qi1+B2ZlRUCp3LLfa68oqk+6csYgY72G+dd21cwFlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=prsq5kIY; arc=none smtp.client-ip=91.218.175.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="prsq5kIY"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=z+h64Bw5LGymmtqK6vxANAX9/xXvrCTaoNjZM15BHvc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789096693; v=1; x=1789701493;
 b=prsq5kIY8dkUV1+olcjqAMByoT1gAqFCOBYwvkmIE/Yh+SwL4CqYkC+eF3DzmSHVp4e1e/cO
 Qq1NbWcFHw54DJjtOErJGHizXpwY125zYM2aJwyL1DXAfm1ut4SWqr1RBEv+zaAoLVgNOpknRj1
 YcOlPAaUc3a4q1zFtNeg26dg=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 50d6d9201047e531;
	Fri, 11 Sep 2026 03:18:13 +0000
X-Mizu-Trace-ID: 50d6d9201047e531
X-Migadu-Flow: FLOW_OUT
Message-ID: <0e8f9a9c-6295-49ad-b29b-84613dfbfd65@linux.dev>
Date: Fri, 11 Sep 2026 11:18:02 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 3/4] selftests/bpf: Adopt
 bpf_program__add_flags() helper
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20260910183222.307208-1-toke@redhat.com>
 <20260910183222.307208-3-toke@redhat.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260910183222.307208-3-toke@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/11/26 2:32 AM, Toke Høiland-Jørgensen wrote:
> Adopt the newly added bpf_program__add_flags() helper everywhere the
> selftests non-destructively modifies program flags (which turns out to
> be every use of bpf_program__set_flags() in the tests).
>
> Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


‌AI pays excessive attention to wording.

maybe just delete whole parenthetical notes‌ "(which turns out ...)"


