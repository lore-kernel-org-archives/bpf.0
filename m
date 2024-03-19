Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB63365190
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 09:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710839954; cv=none; b=rfGJg5GGOwtHLlz5eXZXoaJLU8k+m0+aPedKfGha4e5Tv0B0uCnwLQLu1MgeokoJFAlvooUIchaVZaj0a3UpcRoCYDt3Av/wbdfNIIQkyFIkKmpmfrAE9CSR+B/FbGNIXh/mySURTwWypLbrVpa9liRuU2OAWtvQ8pmiRmS9hzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710839954; c=relaxed/simple;
	bh=YCXnw3bY1tklN/JiRMa7L8wz3VNXz2DhfRaJ2IUlod8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tjvhzZeDL4jWazR81wfk4VXJqE0u54A7F+wCV1tthrZG3SR8FsFCqREKMLM0rKs/C+hVfPBRqUUtYJ3oxKEdogP7nmylMkhoa/h7hpL/uG+Mj9LLTSpK0uwhjbCHjJbsTyHuo+Un1mn8AVzt5HwF12/2rDDpNJqvn/TblW9tOJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkKJpYYI; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkKJpYYI"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56b92a8f222so635706a12.2
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 02:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710839951; x=1711444751; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oUgjPSX/JKZvMfZ5Ha27YIDlpuiaBBYINf3or/IFbs4=;
        b=lkKJpYYIbAxd0AoS03jiZ3yDfAjy90caHCd4J05mlQqYInap8fBrIegS5mbVPCa+xV
         6tPgswqSmhLO8ciDdON1J4kwJahx7Ok3ggMAd0MxXM8XfnXfDLaQIkY53GkNctdXcNCh
         hzsjXeX2J+Tl+46LxCMRAVBamleewRvd8rCY2fvVHpjaaDArREE2THZ3KFcnNSOzZ3KP
         8+DTAtRqeDlE7xVNXJnBKBv2BojIi0X8n/9YK7mEyeuY1zNCJUgVfq/W7CjK8Zwe6LXy
         01DOL+dV88Ln6nzNTN+Z3iGab1+iVMAlokXGnhuPhfAIDhASp4RCa2rIgIeUma8Xlz3n
         Qsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710839951; x=1711444751;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oUgjPSX/JKZvMfZ5Ha27YIDlpuiaBBYINf3or/IFbs4=;
        b=NkYAaxvWA1vugFhnxD8PpDqnaoXGD2zeymmwzAzuGHqDpLvRfbiLPU5UsCntnpjhfk
         ah3bF7tgH3nbCUmxZWPYL3LBIJtHjAY+CC5RkRtDP+wJ2UxH1ifvBnZdwAXKI9Hal5S9
         7kBkBV4zM3W9Hepe/Dk9q6O2dE9syGcIb3PVKHMgDD6bFWtkgeys1Z9qSavwpbnQkG0F
         Z2QyfPNp/nO3OUMmNAEiae2lNYiJLDLUtIZJJ2wuFw4j8blMkFcHRplheqOBChCo04PO
         M+/MAd6fbOgRVAQWVCdzvBIMojYsr2BVbQGY0hB4Kd81DGvShRTdfj9z+Sl2t0Xp1Gyy
         Cggw==
X-Forwarded-Encrypted: i=1; AJvYcCWpjSJHh3AnKVX5rmlK+gZNovX6C0ZuBjdcWdo2hPjXwQr19hjDMttsAgUr9fj8J2nCdLSeVHnqlwIrF1Jp/vKlfGJn
X-Gm-Message-State: AOJu0Yw2obvIojv+r4UvNYEE3ZjyPagqpAQmQzDQPgbdu226ZzRYbcNV
	ODXNytiEqBxd34mL/5mMflyqTgWV5lMTrbBOZSuBCoWuNIrNZHRY
X-Google-Smtp-Source: AGHT+IEql5NLV/zP/XGdDgFyfplytQw8/p2KihI9VlL5EWZ9YFHT56WBRTXMKbylv4yeady2C0IMOg==
X-Received: by 2002:a05:6402:3895:b0:568:24dd:3ec6 with SMTP id fd21-20020a056402389500b0056824dd3ec6mr9073170edb.19.1710839950818;
        Tue, 19 Mar 2024 02:19:10 -0700 (PDT)
Received: from [192.168.6.255] ([5.1.5.0])
        by smtp.gmail.com with ESMTPSA id g13-20020a056402428d00b005689f3d6936sm5608023edc.53.2024.03.19.02.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 02:19:10 -0700 (PDT)
Message-ID: <43eaaada2757048eed490ef2bc74d5d310889410.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/5] bpf: support BPF cookie in raw
 tracepoint (raw_tp, tp_btf) programs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com, Stanislav Fomichev <sdf@google.com>
Date: Tue, 19 Mar 2024 11:19:08 +0200
In-Reply-To: <20240318184037.3209242-4-andrii@kernel.org>
References: <20240318184037.3209242-1-andrii@kernel.org>
	 <20240318184037.3209242-4-andrii@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-03-18 at 11:40 -0700, Andrii Nakryiko wrote:

[...]

> @@ -2373,15 +2378,23 @@ static __always_inline
>  void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
>  {
>  	struct bpf_prog *prog =3D link->link.prog;
> +	struct bpf_run_ctx *old_run_ctx;
> +	struct bpf_trace_run_ctx run_ctx;

The struct bpf_trace_run_ctx has two fields: bpf_cookie, is_uprobe
(there is also run_ctx but it's size is zero).
The is_uprobe field is not set by the code below.
Is it necessary to zero-init `run_ctx` variable?
