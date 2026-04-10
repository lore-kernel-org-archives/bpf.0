Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47E7322A;
	Fri, 10 Apr 2026 07:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775806886; cv=none; b=FXrupVbtTIo/qMIEsxMAzwjrSntxBPPenv2zy5IzYYEN+n667mUne9volk1DzMP2QRImd5XEQ5aHQ0tslcfySL7Lk8CTMFHySOMKV/Sv2YaVg6ozOzoh7U0LyZGaJTLbbujDYecDu/ILrljPnWz9rxF5TLwrUb+xLaICdlErF2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775806886; c=relaxed/simple;
	bh=jhgLEVPKu+458UiJOdN9DpJeh5xnKaDxNtaN3F3LQYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WgvKxM993KUKLcRo0po1Rbqr0L5PUNMWx9HfdBZu1awEJN64+h7bOvYubdkh69VxPmXPo28sr+zacVzKmH5PmJbQKX9SUea8imV3/v17FioemwRmKKzautknK6kqg9Fc8J9HiMleI13GoAoVTxw4espz6dJEy2fNXJ9VJeCr9Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oRrAoSIp; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oRrAoSIp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=WD
	P5j7UlGQOUgIzGp4zWxgoNc4rx7K8AHQxA7ZZ8aMo=; b=oRrAoSIpbzlLJUIq0u
	5JdsZgY36PUUPLM2LDvSr3M+pOywVUOEBW+ZayR0AaRkcVWe3Md2viX/xIYof5ks
	Qf2ZHMlFBpvXDJ4cd9GYKPxVOnwyiPtAfqLSZfhEgCGQMMko7gExiVvJyTw7b7VS
	liP9FIHq7XOMhj4R2W8FtRNFc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBHG853qdhpUZZMEQ--.33211S2;
	Fri, 10 Apr 2026 15:40:41 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: leon.hwang@linux.dev
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	jiayuan.chen@linux.dev,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	martin.lau@linux.dev,
	mattbobrowski@google.com,
	memxor@gmail.com,
	song@kernel.org,
	yangfeng59949@163.com
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Fix Null-Pointer Dereference in kernel_clone() via BPF fmod_ret on security_task_alloc
Date: Fri, 10 Apr 2026 15:40:39 +0800
Message-Id: <20260410074039.187816-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <4e8460e6-94f6-4741-8f6c-4526684e3e72@linux.dev>
References: <4e8460e6-94f6-4741-8f6c-4526684e3e72@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHG853qdhpUZZMEQ--.33211S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruFW5Zr4fGrW8WrWUAr47Jwb_yoWkKwc_ur
	sYqwn7CryDZFn8Z3Z8A34xXwsrGr45GF1kXrykZ3W7JasIgay0qF48XrnYvrWrXr1IyFs3
	ur45Wa43Grn29jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUUdHU3UUUUU==
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC8RkZkWnYqXkv3wAA3x

On Fri, 10 Apr 2026 15:21:26 +0800 Leon Hwang wrote:
> On 10/4/26 14:10, Feng Yang wrote:
> > From: Feng Yang <yangfeng@kylinos.cn>
> > 
> 
> [...]
> 
> > +
> > +static int check_attach_sleepable(u32 btf_id, unsigned long addr, const char *func_name)
> > +{
> > +	/* fentry/fexit/fmod_ret progs can be sleepable if they are
> > +	 * attached to ALLOW_ERROR_INJECTION and are not in denylist.
> > +	 */
> > +	if (!check_non_sleepable_error_inject(btf_id) &&
> > +	    within_error_injection_list(addr))
> > +		return 0;
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static int check_attach_modify_return(unsigned long addr, const char *func_name)
> > +{
> > +	if (within_error_injection_list(addr) ||
> > +	    !strncmp(SECURITY_PREFIX, func_name, sizeof(SECURITY_PREFIX) - 1))
> > +		return 0;
> > +
> > +	return -EINVAL;
> > +}
> 
> Why did you move them here? Seems that you didn't use them.

Because CONFIG_FUNCTION_ERROR_INJECTION is directly reused here,
and the function has_arch_syscall_prefix is intended to be used.

> > +
> > +static int modify_return_get_retval_range(const struct bpf_prog *prog,
> > +					  struct bpf_retval_range *retval_range)
> 
> NIT: code format issue here.

Thanks.

> Thanks,
> Leon
> 
> > +{
> [...]

