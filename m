Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83333A5447;
	Thu,  9 Apr 2026 10:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775730371; cv=none; b=cmvENhWuUtYXivAZ5iVVeY0/Wmk0ThzhmDigP8yVzZc1QQqBucLLFDMHGuzcHBTB8VdZ2GK6JgyscQ2Z5g7eieNHP02gbfRR6wPNDk6BB1GahMmvuKgGMp4ywUnIYo3l5zKvAnwJ3MvagwdUW+Hp6FpSX1TOnZA2y7t3Pf7KdB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775730371; c=relaxed/simple;
	bh=7py9+jmGAJ42gklg146TwBoQ25+pE+fdXjulq709fJc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U0kHVDJTTQ77w6lZdUnW03fUvhdJYI0QwApqWMHDZSG6/wN/a+sdEm1IVPC1Hm8x88gMo2LfwAfLleMiFddGsFR7m6fhsaOgEStsp2SeD5cUyfJwnMmK66tD8a9bCn7Np2j+6RYUqNDr4M3WCIWtJcfQFzg84XqqBN5vyCk2/xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PNN0hgq2; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PNN0hgq2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=oX
	ak1Wf+tJCIBtTfH/i2OKO0EooehvNI969H+oz08rc=; b=PNN0hgq2zZ/JWVvQHB
	wakqazxGzzbOiJZmpJ+BGhwF3nSh3uvjD8Fp0nJbpcpYu7H/+owzBXh90+WZc+Dd
	63CSCfO7//XCKhgbr/gK7d5R6yX7bwwBeNMEA8Ro/Xwc8yM7nmcL4sjIn85f2vtg
	9KowFUKUg13GOOTaGsf+SjU/Y=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3H_WOftdpMHcLEA--.37469S2;
	Thu, 09 Apr 2026 18:25:19 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: jiayuan.chen@linux.dev
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	mattbobrowski@google.com,
	memxor@gmail.com,
	song@kernel.org,
	yangfeng59949@163.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf] bpf: Fix Null-Pointer Dereference in kernel_clone() via BPF fmod_ret on security_task_alloc
Date: Thu,  9 Apr 2026 18:25:18 +0800
Message-Id: <20260409102518.258752-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <409f3694-a054-4288-acd9-7900cc8f8620@linux.dev>
References: <409f3694-a054-4288-acd9-7900cc8f8620@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H_WOftdpMHcLEA--.37469S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF18CFWxGF4kGr45Cr17Wrg_yoW8XF1rpF
	4fKF9rJF1vyFW29ryIyF47uayFqa4Dtay3WFZYk347AFsYqrn5JF4UGFyj9rW3CrWDAr18
	ta12vanIya1DZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JjjKZXUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC0A8Ti2nXfo-7uQAA3K

On Wed, 8 Apr 2026 20:16:45 +0800 Jiayuan Chen wrote:

[...]

> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 594260c1f382..3bfc67983e12 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -18413,8 +18413,10 @@ static bool return_retval_range(struct bpf_verifier_env *env, struct bpf_retval_
> >   			*range = retval_range(0, 0);
> >   			break;
> >   		case BPF_TRACE_RAW_TP:
> > -		case BPF_MODIFY_RETURN:
> >   			return false;
> > +		case BPF_MODIFY_RETURN:
> > +			bpf_security_get_retval_range(env->prog, range);
> > +			break;
> 
> This is a breaking change. The verifier rejection log should be more 
> descriptive
> so users can understand why their program is being rejected.

It should be easy to see from the existing error log that the return value does not meet the requirements:

At program exit the register R0 has smin=1 smax=1 should have been in [-4095, 0]
processed 2 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0

> 
> >   		case BPF_TRACE_ITER:
> >   		default:
> >   			break;
> 
> Also, I think a whitelist approach would be better here.
> The known danger is specifically those security hooks whose return 
> values get fed into ERR_PTR() by callers, such as:
> - security_task_alloc
> - security_inode_readlink
> - security_task_movememory
> - security_inode_follow_link
> - security_fs_context_submount
> - security_dentry_create_files_as
> - security_perf_event_alloc
> - security_inode_get_acl

