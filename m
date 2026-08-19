Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AFB37CD59;
	Wed, 19 Aug 2026 12:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787141218; cv=none; b=n/5wI0oCpdor3YXM+Ia3NnX3TfFtN5ASn2W8iEw+3C5JLU5DSpfWkg1KWGs4gNZ4p0pJ+KLzfZHrKIET0ZGlX8Kz1fmpfbieNBHxOpH9ulV+EtwKNsxpH7GySKnBpz4E8+DPP4XBADaaOW65OYpCP62MuIJ/uu24dlnhWoj9DDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787141218; c=relaxed/simple;
	bh=Bj4+f80MBTGMeKIeOTR52zlbi67BTHCweRWXUdnKZxA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rXOn59fXau3oMa8QhpFcyzmSJZgoNJLr1e6dxfyzJ/REOvz2vL+iUsuJPz1/lt+LAcoitIGQs5K4lxLXrjamJ/+rVBZeRFnCN2bUBy+mO+xEOdqOL2idlCClt5E8cNxPeJGbOZ6r1A1ZSlwmyqAHIZ7GmGaSF0af7uVjPlnKMhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IbGKK1HB; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IbGKK1HB"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787141205; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=GUkYR9rTFV9fXstshGxCSzOaJRhNZLVndr7rGImjuSU=;
	b=IbGKK1HBmzhuo7iKniPBVbcTmtxFH9F5ziMtEnmiGuJtXfW61lIhSDqvRDQVxZG0sfvgP7aSxn6suh0q1Xmq5EY7cPLrjYX3GFBp8ObJgCLIkBtIsZjErUkEJuH1jzvjI4FYRAT0f93+mEIl4ZK3dPqLMPhloMNkyZT5VMhED6Y=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X9Ga8Y-_1787141199;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X9Ga8Y-_1787141199 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Aug 2026 20:06:45 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: bot+bpf-ci@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/2] bpf, riscv: Add support for signed arena loads
Date: Wed, 19 Aug 2026 20:06:29 +0800
Message-ID: <reply-bpf-ci-arena-ldsx-comment-20260819@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f6d031ece454ad8a2a3e09bbdf48d9030c74cb6741f76aabf58bf7af1931abfd@mail.kernel.org>
References: <a78cd29b238aa1aba87efeb2fc09d25a56c22f69.1787128322.git.cp0613@linux.alibaba.com> <f6d031ece454ad8a2a3e09bbdf48d9030c74cb6741f76aabf58bf7af1931abfd@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 2026/8/19 17:37, bot+bpf-ci@kernel.org wrote:
> This isn't a bug, but would the comment fit the surrounding style
> better as an expression? The neighbouring case-group comments all
> spell the access out in pseudo-code form:
> 
>     /* LDX: dst = *(unsigned size *)(src + off) */
>     /* LDSX: dst = *(signed size *)(src + off) */
>     /* LDX | PROBE_MEM32: dst = *(unsigned size *)(src + RV_REG_ARENA + off) */
>     /* ST | PROBE_MEM32: *(size *)(dst + RV_REG_ARENA + off) = imm */
>     /* STX | PROBE_MEM32: *(size *)(dst + RV_REG_ARENA + off) = src */
> 
> Something like this would match the pattern:
> 
>     /* LDX | PROBE_MEM32SX: dst = *(signed size *)(src + RV_REG_ARENA + off) */

Agreed, consistency with the neighbouring comments is more valuable
here. The pseudo-code form will be restored in v3.

Best regards,
Pei
