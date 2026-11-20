Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207342;
	b=C+GMbx1SFTtMxe7l/SFnOjONZ8r/wZRQ5zaA+6T+xeV7nDiM4Id009ZpFTzGbew5G9aw
	 G7xJ+wtTV+x2HcKf9RDp4YOIHR8GtqxaKM8+wgVmlLXNj/ImbyHusWHyWozxM/qQ7GGfU
	 gcsla/tgemSBG84dq5unT74tJNI0BUEBOs2vJBHNilOpA6MhOJi8QSb/mON+5gx9YT3Kr
	 Z3doXVVugdWcMdc4ZamE+Qec/R9i7NQVBK46xfVhuPJyvvmUXB479f3C72FW21bVTJ4bA
	 vTaiJ3NKqRgwJ+7patibW3sc48cdAj7WbEk91NwrDVsMe8QdfrHj6Hk1EYtnksbxlzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207342;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding;
	bh=zjEa/5UGkvmboDqiKH3vCqUwfyIWNYaswKb2LA9yUPc=;
	b=kLVOaIbfjMhUe5tvIFqxzj0FScgfkAl0OD3PVWyREU84+YEzAMzyI18+NBU+ZIvY7tC8
	 VltH2wyuIvaV01mmMZ4oR2Sw7ex3O7ndog81n4tncjLLlGhaIBg+EWn++sT+RzRxkIhCk
	 AW/T/BeADGPycltC72mXlBXAOT8/qKbrPix/Q/IOjsjQsc51WkZhD36h732R7TsDhRSfu
	 dJRdXfJAGeroBoxWiN9pMYVnPVSBnASLd4fEvDsejf3qDgRVAmMcW7v62GKQD7xCwqWr5
	 RmKbMtZoq+llR9HafkjoFWBK87LhF9/gBqLXmrNViKLOAakyuQIIWo1kEspj19IYK0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=kernel.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC3C606A6DE
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:42:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EC3C606A6DE
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-55c38cdd5b7so8607861cf.2
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:42:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207339; x=1795812139;
        h=content-transfer-encoding:content-type:references:in-reply-to
         :mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zjEa/5UGkvmboDqiKH3vCqUwfyIWNYaswKb2LA9yUPc=;
        b=DaWOrLiQFoB3nCQS4hweDb3vs6U3yIkPX93dnijO4di6W9KDxwxnz8U4t83s0Bdy7+
         afrleybVwXkIth0iNEz3ZTCchUsue+vJ5vZJkgchuIlXrOOa/yKVm6EFbNSC4XJlqCqn
         Ea0pvexjy0JTPE7j7uPCYspdLTsmItuZgrwR3lAnO019M9JeSY3uCmoRuPtdYZ+uCDJi
         kheAcYnn3FlYrDmQIxiuoZBLnndPSDcoBSQLUAZLpsp7nnsjdL/sI7UmswvZvBPyts2g
         Eu5DIbxq46rP3P3JnbxIyBx5+nxoP0fHcJhr8nL+1shbq6Yxr4urMzUXtyoLSgAFoo5j
         9fRw==
X-Forwarded-Encrypted: i=1; AL+hErF0YM46Ej8Chil7oRniPOc7tH6KYIDNwXuIhuOY5CHmCdhF1/hlS1UBHNTIy7BlQjhebWY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+RrYtAZHDFy9y1MLL6DSXV3LTAiYm2e+2UdxudpLteMxIXYZnD
	MYPEmy4wilY0iP3j1C/ltOz2UEcN2nKtVOLf9jf+FMmB14XfY1FmxUWV
X-Gm-Gg: AYBFou1W88PNw2KKgzejx4Zgu04efJAsv1bwODlc7GBfQhgPXftjozVB2nhNqNn+A+E
	aUGcaqiI56yMZd0R+nwR/8iJXqAND+3vP6ZFYfVNtYPVjpGC9updkPPZFahR0F+aRydwMvQE2Ku
	xwrMxqI0NBPvY+4dTT4hN1WlG3kdw6u9ehVXBi1Uk8tH+D3rmoc7N7gXzoKaEUPe86y2zR1R7yx
	yvgpIJWkifzJqYiDFpA1YmDaFhsOjiPbmKURiq+uX3m5gVZReKd1DSSOhqz9c2h1ri2U7crKoKz
	l2l2MKssKDat39LvdH80cxM+q9tcb9wuGleczBndmasqiUBaHbth/7rxmzd+ByUvBICeEuynslk
	hlxD5k5LC5zTUh8X4cqAEiw1inJ6Ghxq46N+j/Ln9EVy7J1EiS+opGrKfRfQ9Fp9yyCXe/r4t/M
	f/kA26CxGQk3urA5S1INtMm0L9RMbvLKHYKEr7c50N7rVdID2qF9mvKtyR7KHs9QxQEtxeDV3LY
	S4cdg73xiudbPN6jHF7x5iDFKkOnNdcpNW76g6mQU2UCyJlE4lvu4ghFdYkIMWrhQlBlRsBEtcF
	x9Sr8lLLlUKm8ncf1tQ9QyeiHZ/ePFQjf7P3D/4/BhVSle9MPHjNWdXyqZiIQQQonTKPLpDdnn8
	t8hX7qfzSXlAuBfuBahba9tIEiKcKK+hA5FRhXtRnL4tbkGQ6Z/f9
X-Received: by 2002:a05:622a:5e16:b0:55c:216f:38bb with SMTP id d75a77b69052e-55d76a5af75mr78983591cf.36.1795207339712;
        Fri, 20 Nov 2026 12:42:19 -0800 (PST)
Received: from localhost ([199.170.132.196])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d78812968sm32377681cf.9.2026.11.20.12.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:42:19 -0800 (PST)
From: Tamir Duberstein <tamird@kernel.org>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Andrea Righi <arighi@nvidia.com>,
 Xu Kuohai <xukuohai@huawei.com>, Andrea Righi <andrea.righi@canonical.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Andrew Werner <awerner32@gmail.com>,
 Zvi Effron <zeffron@riotgames.com>, Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH bpf 5/6] libbpf: ringbuf: Prevent missed wakeups
Date: Fri, 20 Nov 2026 17:51:54 -0000
Message-ID: <179519711429.18576.6433271673673285138@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <DJBYY5JF4YBQ.2QJVU2QKJ16N2@etsalapatis.com>
References: <20260613-bpf-ringbuf-fixes-v1-0-e623481cb724@kernel.org> <20260613-bpf-ringbuf-fixes-v1-5-e623481cb724@kernel.org> <DJBYY5JF4YBQ.2QJVU2QKJ16N2@etsalapatis.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> let's use regular kernel style

Fixed in v3.

> [...]

> The extra new variable feels overly complicated.

The final iterator uses one loop without got_new_data. It retains one
fenced BUSY retry to avoid missing a commit without spinning indefinitely.

> [...]

> We just add an smp_mb() here.

The tools generic mb() fallback can be only a compiler barrier.
__atomic_thread_fence() supplies the required StoreLoad ordering.

> [...]

> Why __ATOMIC_RELAXED here?

The stop flag publishes no other state. Relaxed atomics suffice;
volatile would leave a C data race.

> [...]

> Label is unnecessary

Removed in v3.
