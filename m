Received: from mail-pz2-f27.google.com (mail-pz2-f27.google.com [74.125.228.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2982C0F7F
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 18:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789841880; cv=none; b=pZLY8UoFDEDPxmn5co8cIt4xpQnKab5TFRjs3fou62+p1jLDeSab+i+H56C/HQ0KGaLR84/tBstxP9yzCAwBps2eUwjySLiXVeajhH7EPe96PLqRjHzFZytxi53TmYunbSFyxCAWDaHHz+5xFAdchq99blST9FSu6Sk/hSBmsho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789841880; c=relaxed/simple;
	bh=v4JRsy1mMVczYpzTwrH27tSAPaBf/jRMAT3/DYT7xLo=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=l1+SwEl7dKK3bIbtpNA4IU5Lzk7HQLbUoigGONv4ZFLBpcC/L9HnrsZHj55iFP92p2F6jyPz7xZ5Zy8FXUMIm2QIR80YsihIC+QiZGfaQGoMjTL/er2GhOZZS+pR6+wIoYLe4tHnDcpQn/wgpRkhppVSOqXgLPB3ChNQp1LgPb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOI45xex; arc=none smtp.client-ip=74.125.228.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOI45xex"
Received: by mail-pz2-f27.google.com with SMTP id 41be03b00d2f7-cc1cea50dc3so1215376a12.3
        for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 11:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789841878; x=1790446678; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v4JRsy1mMVczYpzTwrH27tSAPaBf/jRMAT3/DYT7xLo=;
        b=NOI45xexohXzRKzSRY/O1lbVfzlQqgKMppiz6IO2OqdJtbXVLxM0fbr3hTiOmPUwza
         Z5igedgprnno84m6NdJgSrOMywp3DyybZNUWqQdpPbbS8PuBqAuaeUiK9JHvinfKeSUa
         RJT1oNXCaSJ0Q2ekPlShOe4DQQsLe0KAKLHoQE0dBeYhKi36N8y8mlF7Y/eq6pKU4jXG
         2xPcRjF3SmnFUrAPi386qdqLkD4G2dVSVWwhelX7QnEa2wKa11pF5zshvTJ+5mwQBcDS
         49fWubzu+wR9yE4qtD2dCEWj474IayQiJ4nb9hqpYmy5Bt8T3kSIqZPC5GqHIKMbxA2s
         grfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789841878; x=1790446678;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v4JRsy1mMVczYpzTwrH27tSAPaBf/jRMAT3/DYT7xLo=;
        b=RKfQ98AcD3HFntWHgnIrL74Gnak67JF/5U2C9NRynnZo4rpFnD43tJdY6g5cI1YpiE
         Q3yrw7CmEdI/owkXVe42waXiNnTdOc3MBx5A7zZ9FRXm8f67FvlkUR3KIz0rl54O/yL4
         fKnXFfg1jj/h2p8XGuUZeOxypZJHKAFBvRwq4N1F5GKTJFXHJBaqvn8tkOHmTQD5wKKB
         wlZeL/JQTMcWn5YWsDBtvdaA4XvBt823y2hWtXbvUkgRdB/aL5YxVs3LmLdY4gVUyIj1
         +l2Xq88v/285QsrbnupqmgJ4hcrVkY7prAj80BfTkAjg3z+qD92yzeQVkkFYyc2/l+qW
         9qOQ==
X-Forwarded-Encrypted: i=1; AKwUvByVKdSwikbIdzG6Od9ZsHswr50dB5dwnQ50mqoKdBQ9CRzcFUNtNqUhHsTtiBascyB0css=@vger.kernel.org
X-Gm-Message-State: AFuF++mNPOf2jLFkN8L0nZ0V8LGmo97/VXHCmil1HHpUZH7TTfie/Ri4
	7ww6wAeTIR1d0calDGELzbLBUBeuLShvCXVtAmQ5Lvd7sEEt1DM/sB17
X-Gm-Gg: AYBFou0OdTotno3spvIkeaePN329M5DhQhDbqt0/WT0jy6nol/Ny1PAbYjS0M9YxzB+
	cEfmmgka8S/R7gZX1rZX0GFrEABeiERqkwxNxEpRPam9e4aGsVXT+TlNoIbQ9f1DNjQXlzSM8fk
	TXYeD3fV0wV3lEH6fli8yy+HzmQHstDXbhNaI6c7uQH2Gmo1/Hs0GhZ+EcP0jzpCUnJIhqfbVax
	vz5OSRtnE2OUmqYwYCPWqHYWxJt5i/cDikIGP++vXmKMYbuk4zBx5q646R46ymWtwEUk54lwzL0
	9Axvwzo91jBRRz0ul16jT9SK//Mx4R4ccndwhodWajZpZ8EqqKo/U/Dlt3fZFXAZ1F8q2hPrFhU
	1u+0eU/tggVvICcwaCbQuHhAg2HhuwZZJzOD/v+21UyVpc24hRRxYYS0yGGlZGOGrNJ1QljukMo
	LK5zafolfGLFTfdT5WjZXhN19tCQ/NJd3SbNGmBmBHVaKptPOmR0Yz4ifa+3q9GT12NPTQc6XFM
	D9rPGAE56ijp8bfbwQEnDR0Jhf9/HYpjCcBb/ZZGDsBlndJUNN6VzNTwNoMFTaUGMzWDv76rkdk
	bbuOp2Eqt7wPow==
X-Received: by 2002:a05:6a20:918d:b0:3dd:a008:dc3a with SMTP id adf61e73a8af0-3dda008e123mr4789863637.40.1789841878321;
        Sat, 19 Sep 2026 11:17:58 -0700 (PDT)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc72ae70637sm1200788a12.6.2026.09.19.11.17.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2026 11:17:57 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 19 Sep 2026 18:17:57 +0000
Message-Id: <DLJHZR9N1C0I.JZ6KOM8H5DPG@gmail.com>
Cc: "Vadim Fedorenko" <vadim.fedorenko@linux.dev>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, <stable@vger.kernel.org>, "Vega"
 <vega@nebusec.ai>, "Ren Wei" <weir@nebusec.ai>, <xuyq21@lenovo.com>
Subject: Re: [PATCH bpf 1/1] bpf: crypto: check params size before reading
 reserved fields
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yuqi Xu" <xuyuqiabc@gmail.com>, <bpf@vger.kernel.org>
In-Reply-To: <4f3ab4b03e79017e215521743996555439bf0bb3.1789802413.git.xuyuqiabc@gmail.com>
References: <cover.1789802413.git.xuyuqiabc@gmail.com> <4f3ab4b03e79017e215521743996555439bf0bb3.1789802413.git.xuyuqiabc@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, Sep 19, 2026 at 04:45 PM Yuqi Xu <xuyuqiabc@gmail.com> wrote:
> Fixes: 3e1c6f35409f ("bpf: make common crypto API for TC/XDP programs")
> Cc: stable@vger.kernel.org

bpf_crypto_ctx_create() is only available to syscall progs, so it's
CAP_BPF, and with a short params__sz both outcomes are -EINVAL.
The two bytes don't go anywhere. Fixes tag is enough.
No need to cc stable.
