Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795203452;
	b=eu4vDQBeyzNhqTSobyUCPyo3XEsWCEsyzvkyB1gs4XahMJyHgPfH8xUQ6Crfd3M0WAKB
	 2cfClH8kbv59yJulhQcqz4BhvzmEQOmotzxU1tzaE407Oy9udMqJc2ER0HKa7SX9X9us2
	 H0xhgJXnmFyGEAEEpBNX2BdH1CE70l3qogfOCxq8Wlh6vJcBZn7a2oMAM086zmN4pHG58
	 5Jiu+6gnAAVVqCXWW0nyN3605yn9lfdj9bTRyM3wE9xQtIN/KpCjAjEb71udgc8SVoBIA
	 CwvLvi5DhOCNCWyELTmhWEM88557zBHX/Al8MvMMvyEoGr4/oh707TppjhXH6nLKjLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795203452;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=HLU92PpOXK+Ktbjntwj6K/wKzrqD7ZTq4i89OR79Z88=;
	b=R1RjwnFqNuI8L+QtubOyy8AsLMKKw7ilUUn9OdYR1RPo2ay+oDNqqIAZ29tR+NctWocy
	 ZaXKID/hBh4xVpOKfeqaVCWVG6foV2PWEBHGySektmZJCYsO354nSkglThfRTKkDwyOJc
	 YjKvYml9jjXrWU0hCajWPGiBFCunT2VmpQFB39EYKFMwlDEXZfaX4KDGa4gy20Cy1UshM
	 d14pBJeonnvIeUggBeBk0dotc3GGIxDfQP09hegGHxlKFM4kwZugECpc06V9IVKz1uzmg
	 pHUWf3nwakCaSrd5zbgfQS1rjL8UdXWn/dC6bRu4Mf14lNCdM/MknDh56Ys2LyJlrfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ejUUxyfM;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0C8606A6D8
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 19:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE0C8606A6D8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ejUUxyfM
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b413d04c93so848734a91.1
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 11:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795203451; x=1795808251; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HLU92PpOXK+Ktbjntwj6K/wKzrqD7ZTq4i89OR79Z88=;
        b=ejUUxyfMijObmR/uk71uc7wEiWG63666i4kANiVWLKS7e/TPrrDFRbh/lojYHlKQwM
         HNgjBk6ieOzaG6ss2SQE4W8DWwsk3WblsgjSaxY7Qp7+nfp9DTkAonaPZOp8sbG+q54y
         c5TDKfV+9GA/zeJBnGq8yYq5jZ33RdGlI/AJtHE9SD+ABUzjhinTq5mb8CvP767E2jOz
         LfvKnL2r3Xm3oE23U5QMjMHdqNNcpz5TOnNcNbSBqx9IS1ZJjS16NX8ZCGX6PC640YBt
         wH/V9z4epp7jQSKsNe+VwJpqiItaoWSEEIkjebRHiGz9eoJ65r7GO5uf9y1CWJ2PBXvZ
         L12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795203451; x=1795808251;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HLU92PpOXK+Ktbjntwj6K/wKzrqD7ZTq4i89OR79Z88=;
        b=xiR6dYW9U62eyJmCUMEMygUDhBT+T06n9fnplO814oheCDGlChrbwHqFA3iZ8qUyIX
         CnrgpAfQAVT85byCDVBzUuqb2WRPq4zQ+f9SofX9bxDZ1Gh1ieAxThIzgfmUGo7ghU1V
         wNP5D+Y7ALUTDMj6HZUF3P1tY61t3pucM03dUv6gk1/S6usnJ9QMtCRJjcABOzn2BAm/
         xmnoVdFqyVFGJhD7xlwoLM9Wv2YUc/kAowpTUES1GQUIJtdcGYlO6DHUwYO4fvTz0cg6
         Pnfoo82dQC/uDm1DlKVAcaIDglBdQdEF6ctZ2KdwJdrzgqsim0o6BUFGPumgK+c+9/U7
         YnoA==
X-Forwarded-Encrypted: i=1; AL+hErEjvTc7EyQWugKJKL1pAuR1mCwXU3sGiJ06a3GJ2xUneDqvksmD+xex/qKHks5e4ZznPWA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/dDgV9Aa58zgyYCbKEJev6/xxtpzoMmpy6DrKORHbTSiJK3dHi
	7X3YYlaqJ0vAdH/A7r8tOw+HdkOUcdyG/8hC0b5zP2awkzK5rJIvG6Js
X-Gm-Gg: AZFdTZf5YdmxtL82vsI3ybSXERQq1AFFcX3gDscAbMoQYx4R188xogYPVCJ/+XmCbSC
	jPglvSWZKa771m0M5zX3ZaG7dKkYaQBoGztly+8QZwiUme39UBN2xEoWlOtaOAc5zPlzmU4clAE
	eYsbtYNLftRjaN3nvL0nNg0aTyRrzqy4nXygjIdAmngx69DaXcgiSCAFJ99f3pg7auS+O1P/voq
	EX2BPOTWon8NuSJiB/wSOGwZkNf/R3BMd3PCVa9q0uLtTZ/tceAeB+uFt5hmdCLcRO30k8rW8mD
	8q6B60eY7nkezGItxxudr1FIpzhp+OvpcB3jnO5crafKYAi9+ZFH4gKajXj62wGez+wwFka0NAh
	SnKV/ZlVgfu2+CbgxERUY8FvfsTZ0H7hJrk12RhFj178qxAR/tUvsu3rMLb+hzcNiboAUXlUrvq
	HzyxmD1VOLt831KMxmzUYlrm6uB0o3F9S11I8JOTCTRq7/nudx4d6ynZUFh8mgEsrdzntxK92fs
	OLjUuux8hEyrTz7RxVj6XOjB1rjsh9PQgMixEZI1cDndFAd94MKV4jVQBy8i+ER1YMGqYAXQ9dH
	nx6LzaFt0rOmQj/HS8uCwMLKQQNaSRq1J3KyADC6kZoI32TZ9rnbXdS8QwKBD9oLcYEH1hg4SvJ
	F3n6UJnTfgGD+VozoGdVj6hpqZZ27s6h49g==
X-Received: by 2002:a17:90b:4d10:b0:3ac:9669:846b with SMTP id 98e67ed59e1d1-3b41c852826mr3992020a91.9.1795203450819;
        Fri, 20 Nov 2026 11:37:30 -0800 (PST)
Received: from localhost ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ecb486sm8290165a91.16.2026.11.20.11.37.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 11:37:30 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Nov 2026 19:37:29 +0000
Message-Id: <DN0AIFQ82CFP.34SDTH6ZFZC1G@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Xu Kuohai" <xukuohai@huaweicloud.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <io-uring@vger.kernel.org>,
 <netdev@vger.kernel.org>
Cc: "Kees Cook" <kees@kernel.org>, "Andy Lutomirski" <luto@amacapital.net>,
 "Will Drewry" <wad@chromium.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "David S . Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Jens
 Axboe" <axboe@kernel.dk>
Subject: Re: [RFC PATCH 0/3] Introduce a classic BPF filter cache for
 seccomp
In-Reply-To: <cover.1795139109.git.xukuohai@huaweicloud.com>
References: <cover.1795139109.git.xukuohai@huaweicloud.com>
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

On Thu, Nov 19, 2026 at 10:48 PM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
> The kernel repeatedly translates and JIT-compiles these same cBPF
> programs, wasting CPU cycles and slowing down bulk startup of
> identically sandboxed workloads. cBPF lacks dynamic instruction patching

There is no VM startup number in the series
which makes me question the whole thing.

> features like tail calls or tracing. Its JITed instructions remain
> immutable at runtime. This makes it possible to share the same cBPF
> filter between different processes.

Immutable is not enough. The image depends on the caps of the task
that loads the filter.
Also any task can time seccomp() and learn that somebody has this filter.
seccomp_get_filter() needs CAP_SYS_ADMIN for that today.

fork() shares the filter already, see copy_seccomp().
A launcher can install the common filter once and fork the VMs.

I don't think we need this.

pw-bot: cr
