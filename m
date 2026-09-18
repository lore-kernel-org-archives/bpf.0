Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2980A43E488
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 17:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789753871; cv=none; b=Zja9GKMY4hN3vuj+WsLJcZ99Ckx3/deJFHN/k1VSZfFooXn8MuxGY8/GYzQb2TiB1YiA/ihMdjaEEpaLBgaKDfHNADTZfQGn5ROjTtfkNiaTUxAwTDd0R/pAEpRsJi7cB2QVGLdmU3r+vfCT3eKDQrfcd/8SS2I3mIx4NBoDXGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789753871; c=relaxed/simple;
	bh=AGC23GphtnXjMJTjuZKvIzgHBrkaAvob99EdJZgn52k=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=t3iPkeRV0k9+FY91MJd7HHKPWXoAEa8pfrHffgCB7YP/qigvTao5bRH2JL46W/ARw82FdGxK5RPGxE8Zo1fBs+ZDhnDfOAIhlYguQ15f22C2Cl5kL7o5d3+MTBQCFD7r/XzQSk7PwMmWMlQ9B+qijkgKsTPnsQhKzgbYdYvtbvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3KUVXPY; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3KUVXPY"
Received: by mail-pj2-f42.google.com with SMTP id d9443c01a7336-2ddb44ad1c1so10965675ad.3
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 10:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789753862; x=1790358662; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AGC23GphtnXjMJTjuZKvIzgHBrkaAvob99EdJZgn52k=;
        b=i3KUVXPYLIZpzT+21K9/Hq6wcnP49yNOkGgWwXXwIl0JkdDPRDudjBXqR/jvmZPalG
         oKXnZRsxGwH6kztgjV4qGANk8YALBTta3ZWTJ0/mI/6izHp24mBNlEGTpqmH+AlIGdUh
         U+1UMeE6GAbHC60YPU5nwK/XPl6wctyTHXml7lZLKd71dmrJsqE7rk56RKxKL+VyHUy3
         APDAXBwr8VxxUNXAgiJ8jtzvETC+ud8Bj4pF+l6T8PWPzdq4PXQTsPCA/R//e6lyNOcM
         DnGMRHIYnCQOQGvZlyuQfUh1fMXfHNmfdhIvgLUTJpkeddntSkXZ/qrpv0SIDGLXzsGW
         nNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789753862; x=1790358662;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AGC23GphtnXjMJTjuZKvIzgHBrkaAvob99EdJZgn52k=;
        b=wq/dBoe/sxLmZUycBXG71bZ7aUoavtFftl2mmYovhdhOpyTIl2Ph2aPdcXqEP7USUs
         SlpbpKdc2m08G8MCeN+UJ0ABGq9SAQ93xRRGaKSR2v2uzSpGlP38GynH6eNLAnRyeKgX
         OFvynevmMBmMr8BPu66HoTKv/7AiCst/KvejLAYvKXU7styywf2NNQFjCUJfH5dZWOkv
         +RdTnxGeCp3yGR1hURm8vhCqZhWJOeCZgmzc2uHKg8kWpY57EhNZX/9TE1au6ZX2yOZt
         /CDPmAyqwjfB3ZLH/mjN5pjyEMawHxpvopFw5/pHcu02cmCNDVGw+rkOmLf/K7E13ZvI
         2OOw==
X-Forwarded-Encrypted: i=1; AKwUvBwoioFPXb9/CueDqcXJRzTKTTX/tnJLZ+keP1SAR/5e6b0gbxfwuFYx8dGKwBQ0XNheL+A=@vger.kernel.org
X-Gm-Message-State: AFuF++kzSOMj03JWxM5oeeRXQshAIY6AvZNff9zzaN1IQ0gT2TjC5TM0
	UDKwO17CAltH9dw93VprUk8J65QbMB5zI5qg16hnF2Go1jVxIEVmHkC6
X-Gm-Gg: AYBFou0wEblVJb+pdJFEyuTVMkQ0Lpm/SNsFQ6pinI4dk51Xj4/710RglhL8xiquaz1
	GN2L7lCPCbK3PDt+COWGUZxKpstMKYhm1XK2VqFZ/MbIHnMme45Z9DxnJy2Qb5cnNpUP04xgAyq
	BZjrPcZM+NJ3gHgIAazt2ysZG3gNgBIlPQE7mYMqTe8Bchn8R2weHkt5zjN4T9Jdchz5J4IZaTK
	oKoxwmM1RZuxQA43bc99w5Hsjb0wtPld1oSyWR/zViENyO/ULWHxa+FbJC2PbN5ujK+V+NemVPa
	K3QxxTjKQv3TzyCRREFakhN7ayPVZTs2qTzxzYIwaKEB/KuCiSXrRwlxGRqKtdTTVCYj4ViyoXA
	b+iUUMCxtl37jiCNJRyY2U0LE3w3ujiJpVwMaWvIKj084kFdHvjLj2CEIk3Q+kl9K5aVh1BScmJ
	c75T2CBhns0XxasVQo7jC0KXlR4Snq7CDUYH3slMv1w83ATUID+0y5MRwwWh/sc3kWuQsSU16qt
	vzMDbwaK8xxGg+GOFAApgRUFbkBTQ203B/cGKw6XbI23zlR6EP+NU9PinlYmMDLvFiAScUFUs3k
	NGSE
X-Received: by 2002:a17:903:2990:b0:2dd:c053:82f5 with SMTP id d9443c01a7336-2ddc0538431mr8558415ad.44.1789753862316;
        Fri, 18 Sep 2026 10:51:02 -0700 (PDT)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc17ba719sm421205ad.56.2026.09.18.10.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 10:51:01 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 18 Sep 2026 17:51:01 +0000
Message-Id: <DLIMSLBJKPTP.30HFFHKGPF2R@gmail.com>
Cc: "Yonghong Song" <yonghong.song@linux.dev>, "Quentin Monnet"
 <qmo@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Jiri Olsa" <jolsa@kernel.org>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Shuah
 Khan" <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf 1/3] bpf: Report BPF_F_PREORDER in cgroup program
 queries
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Hui Su" <sh_def@163.com>, <bpf@vger.kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
In-Reply-To: <20260918172407.3459188-2-sh_def@163.com>
References: <20260918172407.3459188-1-sh_def@163.com> <20260918172407.3459188-2-sh_def@163.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, Sep 19, 2026 at 02:24 AM Hui Su <sh_def@163.com> wrote:
> As a result, user space tools and query callers cannot distinguish
> pre-ordered programs from standard multi-prog attachments via
> BPF_PROG_QUERY.

[...]

> Fixes: 4b82b181a26c ("bpf: Allow pre-ordering for bpf cgroup progs")

That's not a fix. Nothing is broken.
The patch changes what BPF_PROG_QUERY returns to user space and
existing bpftool will start printing "unknown(42)" for such progs.
That shouldn't go to stable.
Drop the Fixes tag and resend the series for bpf-next.

pw-bot: cr
