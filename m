Received: from mail-m2411.xmail.ntesmail.com (mail-m2411.xmail.ntesmail.com [45.195.24.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCBC383985;
	Wed,  3 Jun 2026 10:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.195.24.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780482848; cv=none; b=EbnQuLDuh/lFI5v7vF4ppntgMx480p+rn4k8yKePqg9Na53Zn0uTLJuB9WyEf7ySA6BlZy/WsCQdNRfjkt9e2yPXqDiBHizSGPOmy3XDwgWQwKXn/nxyK8NFLgHoAvCKzdwY5rTI7j8JyXqjYkig2Gwhh8yZwc+IIGN2X+3p6rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780482848; c=relaxed/simple;
	bh=FAsGlLDuXIjd03kTiyI5Qfa8qmiuNaTCHebWLKhY5Zk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iYTYhNrQYMcPX4C3SRvmS8V8DaFRV1RPsGfNq8/f+U78Su6Q+KKPpXu9gm1tAkk6+Q/JW+1o97cgs3TtVCNZuBkz6ENqBhyWBAGhnZtOsTh1sRwRcF97jz5c7dfbvM8xnzajzIQ5jcALPYf6E+opzJDWTG/Cj5YEPxsOxjsrPQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=ln7UZ2wR; arc=none smtp.client-ip=45.195.24.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="ln7UZ2wR"
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 40ea2c53f;
	Wed, 3 Jun 2026 18:33:56 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: yonghong.song@linux.dev
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	dawei.feng@seu.edu.cn,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	jianhao.xu@seu.edu.cn,
	joel.granados@kernel.org,
	jolsa@kernel.org,
	kees@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	song@kernel.org,
	zilin@seu.edu.cn
Subject: Re: [PATCH v2 2/3] bpf: cgroup: NUL-terminate replaced sysctl value
Date: Wed,  3 Jun 2026 18:33:58 +0800
Message-Id: <20260603103358.938480-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <bf25d653-d856-4ad7-a751-b97d38f38892@linux.dev>
References: <bf25d653-d856-4ad7-a751-b97d38f38892@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e8d0c09a903a2kunm6d7b34da1ec68e
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaS05PVk9PGR9NShhITh9DTVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktJSE
	5DQ1VKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
	b=ln7UZ2wRLZCxyD5Q1F2DgoFgzuNzFO12tGBbbISBDaJWkw9oLLu32E6DN7Z2O8Saoy2R74+WXfw6UvWo5XCPHhTPDbHpbEZAFeiKkl6JuBlYLSxw4rIQpP0cv8O301x45vEsg3zHbMNomYFOiuNu+rPKibmwNNgaOUKEfZWwF5E=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=QxJ3iMW7Ldgrry4/8NsVUJkmYGX1x+BwOPrSC6DrZt0=;
	h=date:mime-version:subject:message-id:from;

Hi Yonghong,

On Mon, 1 Jun 2026 14:22:07 -0700, Yonghong Song wrote:
>The above log can be simplied.

Thanks. I will simplify the KASAN log in v3.

>>   	memcpy(ctx->new_val, buf, buf_len);
>> +	((char *)ctx->new_val)[buf_len] = '\0';
>
>Does memcpy(ctx->new_val, buf, buf_len + 1) work?

I do not think memcpy(ctx->new_val, buf, buf_len + 1) would be a good
fit here.

The helper interface only guarantees that buf is valid for buf_len
bytes, so reading one more byte would go past the declared input range.
Even if some callers happen to have a trailing '\0' right after the
payload, that is not part of the contract.

Appending the terminator on the destination side keeps the source read
strictly within buf_len, while still restoring the NUL-terminated
buffer semantics expected by downstream proc handlers. It is also safe
for the destination, since the helper already rejects
buf_len > PAGE_SIZE - 1.

Therefore, I would prefer to keep it as:

	memcpy(ctx->new_val, buf, buf_len);
	((char *)ctx->new_val)[buf_len] = '\0';

Best regards,
Dawei
