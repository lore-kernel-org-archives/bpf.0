Received: from mta0.migadu.com (out-19.mta0.migadu.com [91.218.175.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7593033E3
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 03:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789096050; cv=none; b=Nliog5a8Jmmv7lyEUrCaX3WL8BR6dpI4EJ47ox/XscH+d0/zkAzQyZtDKHVcvBGoa5M+3eO6NGIsiPBGwcIMNVq7oGY3KEWDaMY+YRf/bj6gjOOZlAktrLSsTdX3RZpcleWp+/em0w9PxGbEseb4uxzJUH86ZKSJr58ify+m8Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789096050; c=relaxed/simple;
	bh=m80zThT3GJxyGJi0WVJ0a3esGXcgquWl1UDQEhn4+GE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j98MNxwhqihPm9zbMH9lwDT+I0Q2k1PeWMbPfV4EHr/G/dEneSbTnkab7V6EDZqO1rSqhMH12vg9g1Z8Qdae+ZijgRZ6j/dJLLXT3rpyFFLzWFq2dNy6LjHItIr+UczIESPwlBLAc98/wKfkkIa7yQRO9v9mFm9Y9moZNQQNOko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KV1RpeRP; arc=none smtp.client-ip=91.218.175.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KV1RpeRP"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=m80zThT3GJxyGJi0WVJ0a3esGXcgquWl1UDQEhn4+GE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789096044; v=1; x=1789700844;
 b=KV1RpeRP0AozSWGWSyRP1cEPNlbD28FtyXY/4AnNRDbGtLNmBORaeWbzXAgqbNIzWG5PYq2c
 vbLlnoRY5Cor1VdTlflpxCtLjYiCNQyooruKh+wocqTJ8U1KPMr3lEKvidTpokiOLzfI0pWjRiO
 /ZtJ9HSROQoQJbLYOOOmFSEA=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d197f8c87a57860d;
	Fri, 11 Sep 2026 03:07:24 +0000
X-Mizu-Trace-ID: d197f8c87a57860d
X-Migadu-Flow: FLOW_OUT
Message-ID: <3758e7fd-2a00-4cca-b507-3e634cf24497@linux.dev>
Date: Fri, 11 Sep 2026 11:07:16 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/4] libbpf: Add bpf_program__add_flags() and
 bpf_program__clear_flags()
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org
References: <20260910183222.307208-1-toke@redhat.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260910183222.307208-1-toke@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/11/26 2:32 AM, Toke Høiland-Jørgensen wrote:
> When changing BPF program flags, applications often need to just add or
> remove a single flag, without touching the existing ones. When using the
> bpf_program__set_flags() function, this requires reading the existing
> flags and doing bitwise manipulations before resetting the result, which
> is slightly awkward to do, and easy to forget.
>
> Add two new convenience helpers, bpf_program__add_flags() and
> bpf_program__clear_flags(), which wraps bpf_program__set_flags() in the
> bitwise operations required to modify flags without clobbering the
> existing ones.
>
> Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


