Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795087319;
	b=buIdr3VpPhD+qE2keNltD5AdIycF0mD67PR5e8fUjlrrWMVEIeG0cgxPce6BD5kgh+C6
	 YtUX5QLtuE+OJOJZWUQvMjozYQozWiqY1hnO7yAeqdaN2AP0DxtkXtNaYks5p5A7bj7Bw
	 rkUV6LIvhAdECaXbyDoWKKIVZ5IdzqkSyDaBe62BCeW/DwZ5qoYZknc7fFnNHxchW2ugz
	 MhoeKudzh9d8hX99Eh/9n0nO/Gq6ievay4w4Ab9xQn08NzxHXhq1JR7XDIfkOe6AmicPe
	 GxSmEg5jLMCsW3e0+L5nWpWKELv03IhWqhBpJXcmHX+jmKcoWXuUrxkYYI8+uwsB0jw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795087319;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=e7QbyMAcdTPueERTIe2W8rC7FaSuEijLUH0VfDQBIQI=;
	b=sPSol3fckOhnGrJFV/ZNr5xUNjwTZCQjtuGpNeFVNh6/MFQtjlJ+O6Sd6oYTa6ofs0+b
	 /g8xnXBIVycD1nFhYrKt4s+aSkb29SrbMpfjhVYydS9kqx8CS9bpdkpKtRpzjO3KGIXHY
	 eur2lIhmvnXfvU8J5c9tybNROArgCHu5VeCBciqBkBUB0rnpO6wrP70I0r3wEBn4jzD+k
	 238NBMHWMySwhjUPz20njd2UgYHPawKGO+mhvVDmEGzCnPVbfzASmtgQ4soJ01orDJeAl
	 wII4Z/iuN/aCvBwLJ+x4M3g7BUPXRZy1tFaueZQzzdPD9NoPuegopAtGJompUjJXuZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sentinelone.com;
	spf=pass smtp.mailfrom=sentinelone.com;
	dkim=pass header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=Z4mols3g;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0580E606A332
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 11:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0580E606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=Z4mols3g
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ac847f9d78so170398a91.1
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 03:21:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795087318; cv=none;
        d=google.com; s=arc-20260327;
        b=qTRXZo8tCv3InLD7+Bgq4DanZ7/IN7NC1D6rlAd/LKjgUmWdDrVIJyOMeJXKwa79st
         X/fX72yypJHY1KFRwQnqzKpqgCGJFCmyBxAOXASQa+gLMHfRiMRXydYQkkgk2ExP64jd
         W+1ScFsdaSmDFTK5WKK1KD9TWljVFy+NfYq/oL6CN4Uph2WqjgXp+8qeviaDWQ9GXuWT
         jd4DVYzc4BYqH2uerzxQ2HiK1mUycp5vtCPeNax7bdPIFSDAmi3tUnerDWCl714hDRZa
         SaqHYXnnaQdzvXlGTVV+9C4/caQ1Ayn5g7UGeG2+JrQClPjreIWklEztFnsbgKKOyWfx
         MNIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=e7QbyMAcdTPueERTIe2W8rC7FaSuEijLUH0VfDQBIQI=;
        fh=SP9MQuLGLKwYAkAMPXZZy/g7jD0jDxqmFswXJ38n1oQ=;
        b=ZK1AxlMv4L3NMBqyLUe25GBOek95+c0sZ/rwZrdTaLWLwsgznMNmPGf/AYmpE7ZYHo
         aMt8cNwBmED6wbhiOZe2bS/xa4neJItvz0i+Cj6ki+cq2S+sCJQNNRhp5EX5skqaWlob
         LEO3xGSIZcb9J4mk9t8wyt412RU1jHtcPTnAADsLjsxTXDOX+Djswk7+QmLwf6kSgNcl
         u1ZvF0cJ7emWIjI7ve/JZNVYQZzlr+80Sl6CPH1sRzVBrZD2zPs50onWZ8Agkcgfb4d7
         Z7klMixMK1+IOWbuH9+wi2ogxCTp71jPjRrfufd6jXCUpAbD6Ia4Mrbpd+WnJ8e2qB/k
         pzRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sentinelone.com; s=google; t=1795087318; x=1795692118; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e7QbyMAcdTPueERTIe2W8rC7FaSuEijLUH0VfDQBIQI=;
        b=Z4mols3gn9bqimDi52cguSw/2T0WTaWDVxdxz6zcyZXyPgg4sGM6Q+/r5Aj7Rzapp4
         h4quJH7omFkk7iE4D1JVrPEgmWV4GrtURSbA15/kDOpfGZpA58rouU/VUzeMHkx1S+F7
         Hz9s26xztX/RE7p9nVIAfXB7l4QoNZ8jWho+SKI9PJDvV8FShCDPYBBuiOZ3HvFMBFhO
         v3hpLPm3gIQEI07GGdkMFokdCQWvgs1JkPg/mR2mEUTp972OXoxMqhkZvLvtSKmLROjZ
         b2Ss1p4URUlPL5cH7XnchQ8UvXl/BfSjp0iGlBz6WajH/WD0dm7i8pvOrVqQJWga0A5w
         J7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795087318; x=1795692118;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=e7QbyMAcdTPueERTIe2W8rC7FaSuEijLUH0VfDQBIQI=;
        b=TMzkamkcQMhg+hDMc+Hm/8TnJ0JOVSIuXHmQNugcOzBitHAWmrBzonXb/5cMY4pSeK
         AgUym+AzYOLd5Yj7mljlbDYlXxSj0a9UJCnoPCPTj4WVsQ1f+8c2qgF+sJ2CqHY8bsJx
         u53ukJaaIOt4PHbgbHLvqXabhZEE9PDKX7vizqXMCYGaDNreBfH/f2OnvpJDUbLP5gjD
         D2iybNIlDD9r7KnxcDKZozeiIgxycV4fu7MOXUr/MAPr0OASo/ledEOn/7ylrPC15bRu
         n4o+1SDuUFHDxi9B9/YRxITsfAG8qsl6DuvVkRtFK/HJxY2FgR1sLagLQG33HK+LiDg3
         2mTQ==
X-Gm-Message-State: APuU4Z9BUkYGolfZmYNUAi036F9Ee8yaZBUlCUuc6+mB6Wkr4Jvvc5nh
	ODqb8Ya6kB2HJnY9xWct3+tdMyWDjJjezX9wJrNNYnrAKdrxX5B9/UBLdQrg35B8cLHcuAssarz
	ukNyxP/ZXWM5gzqG/I6VYlcqQw+kYPg1a0lYQqG0HQg==
X-Gm-Gg: AZFdTZdHmqShwNWAtyibyz2giuJygJ1sKLVWhT8B7ca7OiePCEwCG2ucDKtbEfu5K8a
	DBWsLC2K/BBYfPVhljpdtE6srujEYqmm1oWLsP6xY6DPQbiCqqId5neYJEsA+8p0Pv36148Ezd+
	ZuII9wR70/zB1RBSJcOIG9jzP7IcEpHcc2uCAkKFjVagTUy2JXdluvwZP2KSBVQMWAPGSobOh90
	yWmBZRSTqo0fkQBiozBIyaS6M+O7gzAnJ/Mi1JyhSfetE0P3md7ikuN0L+tlYZasatSKEohV/S7
	oKv1cvF1MOwMX97lmut1Gr9EGQD9/cbEIlSZqF4hqsFCuU0lQJTx4kY1UTVEuDXdjnYev51Ta2Y
	EInrj5YKhtNSnmf7tbEWKX/BABdG9synkaj1jRcUaFPBN38zq8FW+pG0=
X-Received: by 2002:a17:90b:4c11:b0:3b0:9e2c:9b55 with SMTP id
 98e67ed59e1d1-3b3d06bcc48mr9840688a91.2.1795087318201; Thu, 19 Nov 2026
 03:21:58 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117-bpf-preempt-v2-r2-v3-0-586376ec3672@sentinelone.com>
 <9a47ede3-24fa-4fa3-8d7e-50f221de0929@linux.dev> <CAPnbwjpmRCR3F4V3StUz=702AdWZzHHZjP68GepnYdYykjoC8g@mail.gmail.com>
In-Reply-To: <CAPnbwjpmRCR3F4V3StUz=702AdWZzHHZjP68GepnYdYykjoC8g@mail.gmail.com>
From: Mike Bazov <mikeba@sentinelone.com>
Date: Thu, 19 Nov 2026 13:22:00 +0200
X-Gm-Features: AclHuK9_wchn9jrgtgMQTEmt7b1vm1t-1CBFRs79WS1-atFN5hx7C0543m1ETUI
Message-ID: <CAPnbwjrQcd5R0aqNKeJV3wWuMcTTsxsamxpKVpKY7Za2xKB1gA@mail.gmail.com>
Subject: Re: [EXT.MSG] Re: [PATCH bpf-next v3 0/4] bpf: Check recursion per
 task for preemptible programs
To: "JP Kobryn (CrowdStrike)" <jp.kobryn@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Martin Kelly <martin.kelly@crowdstrike.com>, 
	Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>, tyler.wilson@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"

Thanks for testing, JP.

> fexit (marked)                61      135

Marked programs take the same per-CPU counter as before, so I expect no
change there. How many runs are behind these numbers, and how much do
they vary from run to run?
