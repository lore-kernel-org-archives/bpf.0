Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794586653;
	b=5U6lOKgxnfaxXa/k4YOo7XpaaWCw1WNi1NAu7f8pR23g6QASFk0H3B8bujFKoqbTY0cG
	 ZNHUWp0W52KvtSHvtLl2eonXcu5VyJ9So9rzwEAu5zswDXy7DTQagTezWIzVED4CfD3+9
	 iaiLdwDB2GPs/19QUsJPDIpKILwua6ma3/2/eJEZ5TaAdCzORJbawldn8I87xsm1xrEU8
	 /wMWKsfUKmfPFuVi1UP3tvXSwY7DQdhDchFM5MFliLLNtaxcjXdIzb+R/bbT4GYXZzvHT
	 2CTj0hRT+7JFLVuO52jU/Yql9D2y981VRI69E6eHZhFGEiH6b9h4ubPy5Lhqn78igww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794586653;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=8QfbNQxKnFInMHl24Makozgilc6zbzBzk3COchYK5J8=;
	b=FnEw34uRxbnYQZtdbNXiiMGjatgIHq4jqL67uz2fcrlVEbuhpo7GMy2/Jscv+mNJngE3
	 W9AUh0LZssj/m+5WnfZtBa6DSUXYG7mUgl+w25qWEl7a2lYmZQHPCTsrdFKDq3A9/8Dkl
	 QFu0jmJQd4BVPMJkE9D97Prk9PEtVWJbrgF/4tIiwt4GAh62tmRBcl5ouL39T3/mHOGVE
	 OY0GsDowY8vy47tk+FA25EgVyDG25VEBNq0tyl/v/0CE7GolZp3a98FWnRspVbjm+bpVJ
	 OW5nSE2mTYkXwcJaQ/z2747oqtQZYNmPBiJPSHd5O+evSOyspffpZuOAUlUB70trWeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vV6ac6eT;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B880606A885
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 16:17:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B880606A885
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vV6ac6eT
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8b8ecfa886bso1111641b3a.0
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 08:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794586653; x=1795191453; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8QfbNQxKnFInMHl24Makozgilc6zbzBzk3COchYK5J8=;
        b=vV6ac6eTLbjg8qntlGqftrFFaKzSKH9KBR7bSt7ezGcQn8yhqTBkQRGogYkcv/6DEf
         cfH7vuvRGdOf+FKhbG+8poeyGo8AFalXgDdBTSLb85kh5Xg7wUYipGytp+uxGx7ejKz/
         3U/IbQj4dQS03DtxurI9wSIpZ0fTzxQY8w3rrT0NPMBbVPBtnPGEOulvlbHyto+bXhBT
         xbBKr1gz/5LIxKJGGDdd2Zi8CobLNUsoDqDVsLYlny/y6hHoWijPOvM4Z/rdrXZ8qWxq
         cnV0zC5/wMsXPV3z9qtv/OtakISXfbLe6qc08IJRpHmNId1CgMxaHTxu9tJRJxBPy1dj
         Gebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794586653; x=1795191453;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8QfbNQxKnFInMHl24Makozgilc6zbzBzk3COchYK5J8=;
        b=fw938WscG8YYZHhC7+1DHHWvzu16zwy2AtSzbK23zLYrhWhA88NVqC31KAsTzngTnq
         FWt8ee+bWSLDla2AY8ywCnctfT/TF/pv58Bt0fgSv1/76OXH5x5g9XUTcr3dWAyPTZiS
         AvstZZkLeZqPSNSB5jE5E5flsuBUVsL9YKcsHqtRCwDsHcOVRgWQvsFe7RBVcl4mtEk5
         vwmQd41ipnMSUFpQ9y9PwMB/rJynEUuWKcWcZ/73cE60OFno0W0WL+DtHqXmjGCm7V1K
         SoNDWeDur2z+Xwt2XNTQyjEml92aGkpNKmzwNe1E6eznVMQyxqBCyd1Ra0S2QL+qiVfe
         dTbA==
X-Forwarded-Encrypted: i=1; AL+hErHxbPQdxWclBs5KhQjyEZK2LffLHfLQ07XAejhJ2tyxSzmYjWTKCbeHwdD11BUQ2P7WLuM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/HRF1bKoSlJx4ex/GTjEary02f8wl6zx85AxxBEFKFfoWSLE8r
	L9RPrRTS6ZY20lCq0X6lkWqfXhuAGUNyW1f78Od4tsvR1xiFQor0ukyW
X-Gm-Gg: AYBFou1nQUxVUK/MnjXbEeaoirvZNWujP+y1xL+ImJR+RqvB9dcYgQV42WReZr7grUw
	PZJPxTreNDljXewLFwuMNGUmZ7H8Y54vLfKKBTZ3iNpMbKs7s6GRLjBD9Q/Z82U79pHV5plW+Jg
	/96Okz6bU7GfSCIKIgZ61oKr6VLEqLYK9ZAgZPqNDshM5tPPXnJCYrIaeUNxzWIPt/u7wKPOJ8g
	aTA0NKq8AtQ8CbwlwgmPgrgjU90Jkw651Vwace1mtwaVXEH2Bf3vis6otRno4HnYuJfLqpmj7+G
	6rIDIxV+FYwEVINOLUuqBFFH0bCxCeJvyi5NgVtoedAGPweseRp/2Y781/GCWfbh7Q04AXsYCEo
	apl6EAcQKdyBGgyXOyUTGwo4Yd7eesf0u7q29b0gYWSiCP0mIR/R7BsoB8cdvBCD0nxq7/3XIoo
	MA6m22Uh//IcvuTbcP2izVSzQDfW5soDscJPLB9V9jlzZmFiVxwWpMZiAc1jdyB0thQA9TbyMLY
	FVGNnd+oyLKE17CSov7qIqwu/Yn1t79YCuK34lKk7IxCzIcb6v6kvEXrlpE0hUf3TesXyTBHav+
	vgjbMRXE0YrB65ggA92/udJiib9wGecIJuy5t2PtbWJO7etoUnRAjjUnlw7d8J4q0ktFspwnPe0
	0XGLLJjqeeM+h0Jdymov0pP5TvbrF1yqg1os=
X-Received: by 2002:a05:6a00:189a:b0:8b9:a5ee:cf05 with SMTP id d2e1a72fcca58-8bd6202494dmr4316240b3a.17.1794586652637;
        Fri, 13 Nov 2026 08:17:32 -0800 (PST)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed243c34dsm1355086b3a.41.2026.11.13.08.17.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 08:17:31 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Nov 2026 16:17:31 +0000
Message-Id: <DMU7VICU015G.3JV7MVOKG99JG@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <a.s.protopopov@gmail.com>, <martin.lau@kernel.org>,
 <yonghong.song@linux.dev>, <mason@kernel.org>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH v2 bpf-next 09/13] bpf: Allow fmod_ret on tagged
 functions and check the return value
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
In-Reply-To: <3750dbb63ba14bc0a43aaf4c61cd27c20d2483dee161e98b9cb35793dc48d122@mail.kernel.org>
References: <20261113050901.1399091-10-alexei.starovoitov@gmail.com> <3750dbb63ba14bc0a43aaf4c61cd27c20d2483dee161e98b9cb35793dc48d122@mail.kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, Nov 12, 2026 at 09:52 PM bot+bpf-ci@kernel.org <bot+bpf-ci@kernel.org> wrote:
>> +	if (env->fmodret_retvals)
>> +		return check_fmodret_retval(env, regno, exit_ctx, reg_name);
>> +
>
> Can this reject valid programs when the exit comes from an exception
> callback?

hmm. yes. No ld_imm64 takes the address of the exception callback, so
flow_compute_need_const() misses it.
It rarely shows with a range: the join of two allowed values is in the
range. The list has gaps.

> Would setting ret[env->exception_callback_subprog] = BIT(BPF_REG_0) next to
> ret[0] in flow_compute_need_const() address this?  The selftest added later

Yes. Will fix in v3.
