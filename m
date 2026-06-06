Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6288D328243
	for <bpf@vger.kernel.org>; Sat,  6 Jun 2026 09:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780738266; cv=none; b=dy+3Mi4g19GO2LlDIfuAn7Z9Ex55iOX4h/1IiEfJxr2wENM2Lq9L3+31ZbVgmTUe6lzHONa/BzK5yejEuPTI0hahdev5mrW6puAquTcNp9rKCb4UHeDcvTQJzPl62176rk/hI0tTAU7ieG2L5vnVp3YCPJpyZVlyiFmR/ygAmUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780738266; c=relaxed/simple;
	bh=mveKHfHs+351h/uVx8j/sQRt5INZ1QR5WEsJmIGE0TE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S3SSJxhP1n86sWPYDdhOBs2qf65cmCox5f/RKO2uvIR4deDzajpNoaMPmN8VuLqQ7oXrhqBOIFJrpCHNHCWLTAWEDcvY2ZIwGjf08eXkI7WmMLVXg/usbkc7sPp54tZfgrrdHdGfnGcF2jAbRnQImek4V4QhIELnEfAnvsgRxEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PhQtAVe/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhQtAVe/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CDF1F00893;
	Sat,  6 Jun 2026 09:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780738260;
	bh=Mj+ltaL+NZWWlTJOXm9FJ9D1vOT7fIVGbD3Oh541bho=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PhQtAVe/gdRdh0JYZ8ng41tvKWTQZFdEwe8HwxF5tSdJSBLutxqRVwoaIwo1JpKDu
	 7BSoA8jMGH+XIdG2G3csvaG0xM1073krzjqRnK17rYoEcgedSbzTPvspNdT1+Ep3Fl
	 XzhUqSdpPs0l3Fj/NvPwSWiEFMBSDkF114mKFtk9h6cc2BH/aZPeCZtOoacZIMRUTt
	 ApJDr8rfDQZHfzwMJqyd6FCePCwVoIkbYZE/MjhZvtp/ANUrxKLQJlAl2H0QvHmcT0
	 1vfiyyvY7HNJ/NBzp75y2sjlKjziz7VAz7m4TsXZzbnYJJBcmXki3mU/XumJ9c5bTS
	 IemXkO5eTlqmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v3] bpf: fix NULL pointer dereference in
 bpf_task_from_vpid()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sechang Lim" <rhkrqnwk98@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260606091941.1803115-1-rhkrqnwk98@gmail.com>
References: <20260606091941.1803115-1-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 09:31:00 +0000
Message-Id: <20260606093100.B6CDF1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The use of the deprecated `in_interrupt()` macro causes `bpf_tas=
k_from_vpid()` to incorrectly fail and return `NULL` in valid task contexts=
 when Bottom Halves (BH) are disabled.
--

commit 17040face7147d85a8cf3090be3539991c26df30
Author: Sechang Lim <rhkrqnwk98@gmail.com>

bpf: fix NULL pointer dereference in bpf_task_from_vpid()

This commit addresses a NULL pointer dereference in bpf_task_from_vpid()
by adding checks to return NULL when running in interrupt context or when
the current task has no active pid namespace.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index b5314c9fed3cf..226c31ccb5d61 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2912,7 +2912,14 @@ __bpf_kfunc struct task_struct *bpf_task_from_vpid=
(s32 vpid)
>  {
>  	struct task_struct *p;
> =20
> +	if (in_interrupt())
> +		return NULL;

[Severity: Medium]
Does the use of in_interrupt() here incorrectly reject valid task contexts
where bottom halves (BH) are disabled?

Since in_interrupt() evaluates to irq_count(), it evaluates to true not only
in hardware and softirq contexts, but also in normal process contexts if
local_bh_disable() or spin_lock_bh() is active. This might cause valid BPF
programs running in BH-disabled task contexts to unexpectedly receive NULL
from bpf_task_from_vpid().

Would it be better to use !in_task() here to accurately filter out non-task
asynchronous contexts without penalizing BH-disabled task contexts?

> +
>  	rcu_read_lock();
> +	if (!task_active_pid_ns(current)) {
> +		rcu_read_unlock();
> +		return NULL;
> +	}
>  	p =3D find_task_by_vpid(vpid);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606091941.1803=
115-1-rhkrqnwk98@gmail.com?part=3D1
