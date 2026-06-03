Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BE41B4138;
	Wed,  3 Jun 2026 10:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481184; cv=none; b=edhqEolAPR6vZQk+bBc01A7H+ohOd9SZrWo1vJeQmF+h01WGPptFXLY40me612/g2x4Krukg0Jucfj/TVIwzPcGRY63i/Kkfx783oSf0aqLng4II8/+FWQNfFQBeJ2Cf/CP4Z2NRBKGywdaabX/Cg/dbKB8zeOtdiYfrO+dnxXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481184; c=relaxed/simple;
	bh=FAsGlLDuXIjd03kTiyI5Qfa8qmiuNaTCHebWLKhY5Zk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XeNtGDDOAYa1W9yP6Zt1O1t8Ezq5kbJg+Y35+bY059FjrwHD6eI1pZfA4LRLNKCh60iJ9QF33dM6JP3Eum+tDr2RWhud9Yk73rwhd2iEOEDFG8IuurKoec4aCg1AoOq2/+BtfWbtJwCLkLHd6LadvdGCqFOGnrivZURfl25Ks4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=gjl6BGc8; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="gjl6BGc8"
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 40e8f5dd0;
	Wed, 3 Jun 2026 18:01:06 +0800 (GMT+08:00)
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
Date: Wed,  3 Jun 2026 18:01:09 +0800
Message-Id: <20260603100109.923857-1-dawei.feng@seu.edu.cn>
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
X-HM-Tid: 0a9e8cedf9e303a2kunm2704c9301eb228
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaHkIfVkMYTk4aQkMYHxpLSlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0
	NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=gjl6BGc8JGQltC43GX+N8WP7kKCceUUMVLuW/JHWvyvipVQ2qG74X8tjgfSn6BfpnRDEGqqIZrXx/2VBp60f+hQ//egU/+WvllvDCULkJcxL2sN3KnA8Yjp/LBf0nqgbLmhrGDBJ0aIFFNIeZQEHaMBtnHmfD67TEnhS01mwcEI=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
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
