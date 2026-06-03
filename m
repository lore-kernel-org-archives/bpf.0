Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8E92E285C;
	Wed,  3 Jun 2026 09:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780480391; cv=none; b=bdJrQew03owpATuFU3FHXPzUHk2DDWhAoPDmqF3YFEZXEqWPNq5hN8o0m8LlVK23CRT6OFBdaeyyHD/BwVCpt6EIupu9Y3qplcqPit7EmJQEz4xe5sKD2NBByhOyh1nYGs+JWyWTf9jhTlqYtWSIEgO1XyMTiMM5SrgcW9E4dMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780480391; c=relaxed/simple;
	bh=FAsGlLDuXIjd03kTiyI5Qfa8qmiuNaTCHebWLKhY5Zk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CqSK0dbc2UrXzLmr4AhRWCRqvB9rBywKSnNIkzpygHKdJ7sb7df4t08LE9AsUdKdx43ZNP6bpAcj1g2FKonLXyeqI5pWoBxFihEad3b1gscSb/WpDz3RIc4cZbIBISZPFB9/lar8pERVF7rdrxe0OFH1BqHaJPoslIx8ClXi0ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=SfsWVIOM; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="SfsWVIOM"
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 40e8f5c1f;
	Wed, 3 Jun 2026 17:47:50 +0800 (GMT+08:00)
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
Date: Wed,  3 Jun 2026 17:47:50 +0800
Message-Id: <20260603094750.910831-1-dawei.feng@seu.edu.cn>
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
X-HM-Tid: 0a9e8ce1d3a503a2kunm15434df91ea908
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCHR5CVk4eQ0lPSEofGUpDTFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0
	NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=SfsWVIOMatkarDlbKa9LogioXvgXLe+3utDFV6oPmEj0teKeXVDKATWS76Or4EffzN6DW5gFVXk/1aGv/CEPl31LDRqIuW2tg/q41TE6yh8MNyZ5ZoF7t66bV2zDQjqcp7S0SqVCQjOvm6a3oFWWQrvv95ExvAklX4rX9c69ptY=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
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
