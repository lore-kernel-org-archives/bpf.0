Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED52A2E282B;
	Fri, 10 Apr 2026 08:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775809550; cv=none; b=gSEF4vvekkgppvfeawiu5+gHQF8mlxfeQ3NyvK15V7pJj3U93nqOa9MzOb7V4HTRjO8qRNYvF2MwE/FXeKlhDXHJGEUkbE/r4qGfbjJVEB/TTrXgc0JnaNrHTsCk5cy3f2g36/WaqSc/OtfLsI2xfnGhhqlJ6Q5FZHBOIUNIvKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775809550; c=relaxed/simple;
	bh=CW8N8p0JKHV9D9/nrKZqEPaGSLfd/n/BDZsHmKuDqmE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tk9f0u1zh5D2cx6oPhoPatcu61zReLJVA6SAjPSlL786GN6WSRkxcEMMzqF6JcmpRDef+NoT7QGrSXqCGiSCQL3Ur3q4zOqpMlBROfaZ6IYHRl440djES/mdn6sf7PvmDvweuyqzlhu2MgVOKNsleSD1lGkQ3kGOrTakFUzZ0/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IUHaWmvF; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IUHaWmvF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=nK
	hts2FvWXRxxGntylpOhvJ0txu8iZSqcSWRzUoElMw=; b=IUHaWmvFKwTWwmKcPd
	Wxc5qPxAOraCKTvnaDkBXTQsBF76H/zvsk0WQqpJQncX9zvpEl+uiJKxo+VSOMxn
	nGAw5WHcxp4XQLKo//DmffiWQ84fPKDePyaKb4rzMwOdeCFcqwzOqcT63CAzmw7e
	oqoPkRqT23B/EDoQRdQxzux64=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wA36MnQs9hpLu5dEQ--.57056S2;
	Fri, 10 Apr 2026 16:24:49 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: bot+bpf-ci@kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	clm@meta.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	jiayuan.chen@linux.dev,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	martin.lau@kernel.org,
	martin.lau@linux.dev,
	mattbobrowski@google.com,
	memxor@gmail.com,
	song@kernel.org,
	yangfeng59949@163.com,
	yonghong.song@linux.dev
Subject: [PATCH v2 bpf-next 1/2] bpf: Fix Null-Pointer Dereference in kernel_clone() via BPF fmod_ret on security_task_alloc
Date: Fri, 10 Apr 2026 16:24:47 +0800
Message-Id: <20260410082447.205139-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <60e1c3bebe4eefa53d73bdfa1f016af7abedb294634614119aab1380b9d46eaa@mail.kernel.org>
References: <60e1c3bebe4eefa53d73bdfa1f016af7abedb294634614119aab1380b9d46eaa@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA36MnQs9hpLu5dEQ--.57056S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCFyDCF4DGw1fAry8Kw4DJwb_yoW5Wr4kpr
	W5tFWjkr1rAFyUGryIyF48uF4Sk3yFgrW3CFs8AryxZFn5Jr18Wr15tryj9343Wr1UXr92
	q340vrZIvwn8Z37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi0JP_UUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC8hGxKmnYs9E1oQAA3-

On Fri, 10 Apr 2026 07:00:25, bot+bpf-ci@kernel.org wrote:

> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 9c1135d373e2..37975e9a291c 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> 
> [ ... ]
> 
> > +/* hooks return 0 or 1 */
> > +BTF_SET_START(bool_security_hooks)
> > +BTF_ID(func, security_xfrm_state_pol_flow_match)
> > +BTF_ID(func, security_audit_rule_known)
> > +BTF_ID(func, security_inode_xattr_skipcap)
> > +BTF_SET_END(bool_security_hooks)
> 
> There are two issues with this BTF set.
> 
> First, security_inode_xattr_skipcap does not exist as a kernel function.
> The LSM hook inode_xattr_skipcap is only invoked via call_int_hook()
> inside security_inode_setxattr() and security_inode_removexattr().
> There is no standalone security_inode_xattr_skipcap() wrapper. The
> equivalent entry in bool_lsm_hooks in kernel/bpf/bpf_lsm.c correctly
> references bpf_lsm_inode_xattr_skipcap instead.
> 

Yes, and in fact, the return values of `security_inode_removexattr` and `security_inode_setxattr` 
can be those of `inode_removexattr` and `inode_setxattr` respectively, so the 0-1 restriction is not necessary here.

> Second, the v1 of this patch had #ifdef guards matching those in
> bool_lsm_hooks:
> 
>     #ifdef CONFIG_SECURITY_NETWORK_XFRM
>     BTF_ID(func, security_xfrm_state_pol_flow_match)
>     #endif
>     #ifdef CONFIG_AUDIT
>     BTF_ID(func, security_audit_rule_known)
>     #endif
> 
> These guards were dropped in v2. security_xfrm_state_pol_flow_match
> is defined under CONFIG_SECURITY_NETWORK_XFRM in security/security.c,
> and security_audit_rule_known is defined under CONFIG_AUDIT. Without
> the guards, BTF_IDs will be unresolvable when those configs are
> disabled.

I saw there was a default return prototype even without the corresponding config,
and assumed that hooking would still work without it, so I removed the config guards.
However, I didn't notice that these are inline functions and cannot be hooked.
I will revert this change in the next version.

> > +
> > +/* Similar to bpf_lsm_get_retval_range,
> > + * ensure that the return values of fmod_ret are valid.
> > + */
> 
> This isn't a bug, but the BPF subsystem uses the kernel multi-line
> comment style where the opening /* goes on its own line:
> 
>     /*
>      * Similar to bpf_lsm_get_retval_range,
>      * ensure that the return values of fmod_ret are valid.
>      */
> 
> [ ... ]
> 
> This commit appears to be a major bug fix addressing a kernel NULL
> pointer dereference but is missing a Fixes: tag. The bug was
> introduced when fmod_ret was first allowed on security_* functions
> without return value validation:
> 
>     Fixes: 6ba43b761c41 ("bpf: Attachment verification for BPF_MODIFY_RETURN")
> 
Thanks.

