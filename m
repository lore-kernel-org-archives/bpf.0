Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538A33C1F2B
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 17:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784655756; cv=none; b=ZUCGcgRyVf4w4YIwi5xAAXlsDuL7K0i4F3b5lY++FW5flKT3HVOePFjwgcN2NfPNNAIP4pn0ZDZWmbLcb8PjmNbMoTFGmFzZ9jUk08CybixPoUy07i9/sdYSIxqk/ZkwjQCAfLifRcxb9ZKDtHBzpCcZGJWtZr+SvNtgfhk+O1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784655756; c=relaxed/simple;
	bh=6xFKwekECWUA0X47pSCwxKCiYB6mh0Ro1gs7w5BfjQY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Miu3fvnpdLBZK7CpnP1pNOg5m7mX4StzcjMJZQeCWoDXMwWLEf320mHPxqKjSTMSqvIdOF6Lu5saxlPinRYq0lq1SGwRStwenrf6bFqob/kXvEPKtZSsNh8vfMo7ub68MVaGYW/bHQsgM0ta3Rb6QGDRLBZVjjCv52BMxUiO4Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=hQLPTr2b; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="hQLPTr2b"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ca12086c06eso9678849a12.0
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 10:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1784655754; x=1785260554; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7NxyykXPpGi3o6qz0JzAnoShwcagUkmE6BiBsUAJTJg=;
        b=hQLPTr2bD1ADi0LhOnXmHudYpaQ7xnUoRMQlQTqCb+jXzZcGyuzyrT8/Gr17Z6Z74o
         EpYlafozzq1MqG6T+QCEVwBUX+ahe0XSl8bLoxStqqteIw7ydngMvyPPc5Llg+XYlfZY
         dj+o3xSWm57NwWI0q2YZFe21uSse91GYXb8dQkpaALS0tDPvsWgIKMFaZRlu1QsMxJbg
         4JTiRwZkzCbQ3etz1WHwcSVO78EOPGVO7KSSJsNjrpRq/LLxdAkhQkfqnCttjFCa19Bm
         kzYPmjmN2tw0MUaHcZAFIoXnZ0w468dTrlVzTwqgvABAhv7noFgb7zRXOWNIz78FaBzv
         IxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784655754; x=1785260554;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7NxyykXPpGi3o6qz0JzAnoShwcagUkmE6BiBsUAJTJg=;
        b=fkghwYZMdbXqJxN1ziBm+taL1dlWWn/xSESBnTEVO1zsVeI2vt+pEQ5M8/4WLON1eo
         29M3NFb1RK497T988cXJZIaZGeeP70TDnopUP2q3v7k91TfpRY0s5lqtGjxzdutY1NdP
         h0HkxUUG2xTgg4LfukWUiobcB1q2AU9p6o4X62Sb2T/ECEX8BQaAigfabqRNkmy1et0b
         1MsRmV4qGZnBOmvfSMX54bwgtKoxCQutBfQ3cvEPU92XWBmITrJbTtQFLrSSYS975fD6
         HCxH8aICfqiVKJboIl5eZX2kecZwE4SOaq2eRRbdJCsp2a1GhQ1E9gIJ08ryLoNkHlia
         UaRw==
X-Gm-Message-State: AOJu0Yy/xlPIq/ekfVu3baQ96bc3mO9bJe56l4q3Rb9KVYgN8a/XLE0D
	k7K44nHskMBjotzuudbxXcMBBaIBPPFLpiOzTwVpVaAkes/LyRkqCKHjSnWk014tWf4=
X-Gm-Gg: AR+sD101vueiBeMbpVT3Tv8l83Q8cNTgS47B2bfkwICHzsGnvvG/sDP8zYYnBXcSGNe
	OCrFIwGnMke4Fy3fj1xMVLQAKk2cYNL0l5GgePj4XV+13murYrUvY0wP3tEAsIsGA5xT8598xxa
	19wHKSI5dyilHYXH2nSo00o35cR3is+NTzMuMj0Op5gZs22384r80TwyIh4WPrmqaBoT3rauc18
	/hqEuGj0KH9n0oDH8iUuxPNMWbBnUVw1gBil6engoIB2aDvb0yvnonyakGMo7hPRZ2BniRXCXuT
	bHnHjGcpouxmUli8GexZt2VRaXk6WS2kPA/UfSNaaOiVG87HhPHgxWjRK4nC67j0CqhLq9rr0jV
	20KcXLSR7DP4rvugBzBXdW0Gp+cvPH+T+qEEbnNP2ytfE67yiRl1ai9bDJUiedLKJF+GwaEcSm+
	vNWA==
X-Received: by 2002:a05:6a20:b786:b0:3bf:6237:4d3f with SMTP id adf61e73a8af0-3c3ad7cfc5cmr19531762637.18.1784655754383;
        Tue, 21 Jul 2026 10:42:34 -0700 (PDT)
Received: from localhost ([163.114.132.129])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc9d932sm872448eec.12.2026.07.21.10.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 10:42:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Jul 2026 13:42:32 -0400
Message-Id: <DK4FNY8VB0QR.ZO90B07ZCTJS@etsalapatis.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next] MAINTAINERS: BPF: Add self as reviewer
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260721172104.3689982-1-ihor.solodrai@linux.dev>
In-Reply-To: <20260721172104.3689982-1-ihor.solodrai@linux.dev>

On Tue Jul 21, 2026 at 1:21 PM EDT, Ihor Solodrai wrote:
> Add myself as a reviewer for the BPF areas where I've been active.
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  MAINTAINERS | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a674e36529f7..e45807bf019e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4916,6 +4916,7 @@ R:	Song Liu <song@kernel.org>
>  R:	Yonghong Song <yonghong.song@linux.dev>
>  R:	Jiri Olsa <jolsa@kernel.org>
>  R:	Emil Tsalapatis <emil@etsalapatis.com>
> +R:	Ihor Solodrai <ihor.solodrai@linux.dev>
>  L:	bpf@vger.kernel.org
>  S:	Supported
>  W:	https://bpf.io/
> @@ -4976,6 +4977,7 @@ F:	net/unix/unix_bpf.c
>  BPF [LIBRARY] (libbpf)
>  M:	Andrii Nakryiko <andrii@kernel.org>
>  M:	Eduard Zingerman <eddyz87@gmail.com>
> +R:	Ihor Solodrai <ihor.solodrai@linux.dev>
>  L:	bpf@vger.kernel.org
>  S:	Maintained
>  F:	tools/lib/bpf/
> @@ -5041,6 +5043,7 @@ F:	security/bpf/
>  BPF [SELFTESTS] (Test Runners & Infrastructure)
>  M:	Andrii Nakryiko <andrii@kernel.org>
>  M:	Eduard Zingerman <eddyz87@gmail.com>
> +R:	Ihor Solodrai <ihor.solodrai@linux.dev>
>  L:	bpf@vger.kernel.org
>  S:	Maintained
>  F:	tools/testing/selftests/bpf/
> @@ -5055,6 +5058,7 @@ F:	tools/bpf/bpftool/
>  BPF [TRACING]
>  M:	Song Liu <song@kernel.org>
>  R:	Jiri Olsa <jolsa@kernel.org>
> +R:	Ihor Solodrai <ihor.solodrai@linux.dev>
>  L:	bpf@vger.kernel.org
>  S:	Maintained
>  F:	kernel/bpf/stackmap.c

