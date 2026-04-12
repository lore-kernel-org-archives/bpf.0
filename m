Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D768C1F;
	Sun, 12 Apr 2026 02:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775961702; cv=none; b=jsJ3r985dALd7NdGiyHT3qJmy+WI35CmTDaKpMwCCKVkYSogirwh6dnqhUi5d53VUy3Z6b+zXJWb8K9xh1Xn2ZuQ8P1nTCEeKfNt8ng0GAML2Jw3jMFQcZ0Rm5bqlhYA+Mx9/OxZk+405N29BsviuV/VMHh2pfbkwqTHEbhMwrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775961702; c=relaxed/simple;
	bh=rh86J0V7XCtQzeMNiZmNje45Qp/78y6N4ay3bpsyyOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=RKGBxhpDQDrn5GmulbMUQSPfmRPsTMzPhQbjhW9R+QKBc/oRViXGNwoM03DIuD7ZapePpiPtm+wx+krUHBjH0qj8uSsBpzWhliHLxwCdGMaY7/GvtxWl4rmr7ZRqUMqAKqgeJ/ImqbPKMv4DUiLtCBpqYujrtDHJAhydn4WZjQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fPpTrnqF; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fPpTrnqF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id; bh=tbFatfZEmDtU6vo
	TvQ/yWWYClcE0wTDaBkcferPe03Q=; b=fPpTrnqF8eYA9920bS050EYY7dH3cHw
	uNO/zEDz+NVbKBlK96UB5h8/zPbTSaHmXsC6Hk6a5hewSNEtXU84UHTmy985omdL
	7DFDl/LqgZtOEZMEjXvz8McMYIxL+DXc8KkodYViLsy2VG2lAuHyKqOESyE0Qbl1
	QFbcPoyhmAQA=
Received: from yang-Virtual-Machine.mshome.net (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCncbARBttp5ByXAg--.57S2;
	Sun, 12 Apr 2026 10:40:25 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: alexei.starovoitov@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	jiayuan.chen@linux.dev,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	leon.hwang@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	martin.lau@linux.dev,
	mattbobrowski@google.com,
	memxor@gmail.com,
	menglong.dong@linux.dev,
	song@kernel.org,
	yangfeng59949@163.com,
	yangfeng@kylinos.cn,
	yonghong.song@linux.dev
Subject: Re: [PATCH v3 bpf-next 1/2] bpf: Fix Null-Pointer Dereference in kernel_clone() via BPF fmod_ret on security_task_alloc
Date: Sun, 12 Apr 2026 10:40:17 +0800
Message-Id: <20260412024017.6671-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAADnVQ+PE9t0XPM=k=mqpRd=efJ0KYFGbaadwfL5e9iS-pWWVQ@mail.gmail.com>
References: <CAADnVQ+PE9t0XPM=k=mqpRd=efJ0KYFGbaadwfL5e9iS-pWWVQ@mail.gmail.com>
X-CM-TRANSID:PigvCgCncbARBttp5ByXAg--.57S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFWUWF1xXr1xtr4fKw13CFg_yoW8XFyfpF
	43GFyjyr18AFWqvrWxta17uFWSv390gFWfXrZ8Kr9ruF9IvFs8J3W8Gryj9rW3CryDCry0
	qw42vw4fA3WDZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUY2NZUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC0BnYUWnbBhlRdQAA3J
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Sun, 12 Apr 2026 00:35:55 +0800 Alexei Starovoitov wrote:

> > +/* The system call return value is allowed to be an arbitrary value. */
> > +static int modify_return_get_retval_range(const struct bpf_prog *prog,
> > +                                         struct bpf_retval_range *range)
> > +{
> > +       return -EINVAL;
> > +}
> > +
> > +#endif /* CONFIG_FUNCTION_ERROR_INJECTION */

> I recall people already explained that this is no go.
> We cannot break all fmod_ret because error injection is disabled.

When error injection is disabled, the returned -EINVAL will result in a false return.
This shouldn't change the previous logic.

 		case BPF_TRACE_RAW_TP:
-		case BPF_MODIFY_RETURN:
 			return false;
+		case BPF_MODIFY_RETURN:
+			if (!bpf_security_get_retval_range(env->prog, range))
+				break;
+			if (modify_return_get_retval_range(env->prog, range))
+				return false;
+			break;

> Also see sashiko reports.
>

Okay.
Thansks.

> let's copy paste bpf_lsm_get_retval_range() for no good reason?!

So should we modify this part according to Jiayuan Chen's logic?

Jiayuan's previous reply:
Also, I think a whitelist approach would be better here.
The known danger is specifically those security hooks whose return 
values get fed into ERR_PTR() by callers, such as:
- security_task_alloc
- security_inode_readlink
- security_task_movememory
- security_inode_follow_link
- security_fs_context_submount
- security_dentry_create_files_as
- security_perf_event_alloc
- security_inode_get_acl

> please don't send such poor quality patches.

