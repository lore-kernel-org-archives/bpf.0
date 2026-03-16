Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E30E363C4F
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 21:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773695771; cv=none; b=D5GJXeeonpuZseWc6j9GZNhPOJhNrhwSM/cYiyda+dB0zUi1Wdl/R+ME0d0Z1kiI+7eex/PKZuzSGDUXpf9/lwDzIL99wMfuD/ray8s7od/K1KFzUEviP+b1SLd6Q27w1+4n1pK2THKRZ8/a2H8mqmSS51+kHYN0jtzIMPTrnI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773695771; c=relaxed/simple;
	bh=W2AnyyzaVV5LaX7Nb+qLh90OipqRJZE0wUkUehV2F+Q=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0AF7j8h609dlL5BgMOlTDfuWHzGt+vlBcUtgs5rdXZwpy2q/PYpuBoywbZj+Ya52/RkJlLiGq/wvFmd+FMyndlwBS/jt5T+CKX5fwWOkONazv8uJ+nGj3lT9TA5Fs7lgQznK1FJUS2o5trNiLthclYj0UnMOpZTsAoIJaorOGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RquvFETH; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RquvFETH"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4852f8ac7e9so60626435e9.1
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 14:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773695769; x=1774300569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UySVxzfXOl+RhbhkqosIKwS0W/gUxRLNLq3WDoJufTY=;
        b=RquvFETHNMngD0t+wniVYoiQZ6Cuz7a5U2t5DdpvtTQexrp7X+PB57u0iGs9xWynlb
         supVO9eaB+k8jxVD5b4QkdOHrezpGWc5SHPvs9oDZSDUTEAKqU6JbP8W63e59arJupG4
         C4JSaSSYkI5MqMtxqzg7xdic519P8JRt4hs3FMZLWTwmaUzBKhNuRIU4NNBVkdYRxXiM
         LmhZsdbkHsm5J0uZFQDVs+HKxf4C51InxY1x9iCn9MkYPZ5WdPmbkRRvuEv2rciX1l3H
         pwLkmlqEbsPwkUulELyHOHXYpiMIm61mkY0xbc/nJE9aijs6zUf5uigxr5lVoe8Zr2wB
         gITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773695769; x=1774300569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UySVxzfXOl+RhbhkqosIKwS0W/gUxRLNLq3WDoJufTY=;
        b=BeW7ixLzmyTtH72N0KKcGbTo8zDCoemPQUmNcyvMqM4vuIsCZn4lYCe+V7rY630mnG
         Tpl5WJooE96M0qb+0lJTXPfX1Do9+ubThbuBnvUmSDjJZ2ls3CdKn3HMqNJxYXj52Hw+
         9Mku07HS0Wkyl6mMXKAtR3F1qDNC/MKPcKqrlVsVGRNXak7TzaWbq4ZyqOJRThPVBAdo
         oWueKdUQ8YVdaG7dRajg/CYe+exryha/pd0k5rEEwgEuMn2n9DCNY/3LhgHPTzwBDKUJ
         ii7evi4dxxWWbsDe7LELxRkWF1v8VpO7lGo0T+kR8njrtr9e+TXMOFu5tc2UgHG/wSf3
         dtTw==
X-Forwarded-Encrypted: i=1; AJvYcCXWUGm6F+H0Auk8AmLDHodKTmnTTMu1JCtCKiKD48xSvx1x1H7Fi93tTDjVoR6uUy1DS1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0dz7k4qHLcugvQ7ITLQKsPodGjkilyjfervjsdY7F0rhS8yke
	wOsTh3MJTnuvWopyskNAsBZHLVR6tkwL34HqNp1PETRb4LULjnyln79DrBJGGW7G
X-Gm-Gg: ATEYQzwvlLp7RS8+8FETmCVeihj+OhfXH1GGDVG2nQH7rdONpDn1K1UcNWC5JC3dDha
	bhR503lHJLkeKYn3t+NIxe6vVvJtiGvt2FZiSSsMmiRkbepGC1KJG0GvK8N+UACORSQA3WyMZ8L
	MHl7Jnzx50nVnlyHtHE4a1/5yk14f3nYI3bjDrlcDiLD/Y8AToLYT7GqibMTQq69/N15Na7BMUP
	JTvV+/KZwUT9Ak3xbK21YOEOPoxPnTCLUmPnb2Hy1XzEtzRVU6Graqao75TBO5BL+vB4OvMjtz0
	UgUbE6sSJLGhTw1YyXEwTs4NdOiyAkwaskhMOQNWkeUPsVWKwU3KCWsY+pp4uRRtKsBoAHejV+a
	DiMHx6em/0yJZpsKC8VDuWrtpdrab6KmJxMv3JE9TpWOZOy8QyVh8Aq8bgXoprybtoivBuDYnhk
	auaMXkaIr0V+w=
X-Received: by 2002:a05:600c:3b14:b0:485:3f1c:d8a4 with SMTP id 5b1f17b1804b1-485566d6e54mr258332965e9.9.1773695768633;
        Mon, 16 Mar 2026 14:16:08 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48557a73a75sm98824365e9.15.2026.03.16.14.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 14:16:08 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 16 Mar 2026 22:16:05 +0100
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv3 bpf-next 16/24] libbpf: Add support to create tracing
 multi link
Message-ID: <abhzFaNiuTJJhPqA@krava>
References: <20260316075138.465430-17-jolsa@kernel.org>
 <46d7ff451871969354eeff0215fec41d41f1587deb6b0944f8f38184b715e2f3@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46d7ff451871969354eeff0215fec41d41f1587deb6b0944f8f38184b715e2f3@mail.kernel.org>

On Mon, Mar 16, 2026 at 08:35:12AM +0000, bot+bpf-ci@kernel.org wrote:
> > The provided <pattern> is used as 'pattern' argument in
> > bpf_program__attach_kprobe_multi_opts function.
> 
> Should this say bpf_program__attach_tracing_multi instead of
> bpf_program__attach_kprobe_multi_opts?  The auto-attach path in
> attach_tracing_multi() calls bpf_program__attach_tracing_multi(),
> not the kprobe variant.

no, it's a refference to similar kprobe function

jirka

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23133791558

