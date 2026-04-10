Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054F932FA18;
	Fri, 10 Apr 2026 08:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775808511; cv=none; b=GTplemEKphBLFR8mPrk6aKiZ6p+9jQtp5mH3cKQP1pjD/Hq35XUMFfgv2Ku7iG2HEpNf8LJiRtM3B3CgJLvauU+HHiYaiMWwXN4C/WrEgkPeM6UdozqUdPQKg34/r+oimQUr7XAgOIJ7NjEpqw6o8rtKxxDZLHHi4r/jauXPpuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775808511; c=relaxed/simple;
	bh=h1oXMcs1CK5zwUzytZu0xcqg8SHVijzx15iLz4dANmY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=egMQG7q6513dK55X1fHWnOkoHvHJSUyfc7F1TcQO2KhEEgFXsWQOgT3pGgfn4sptM959tju4keXtmTviUgLYP+XBydSXNUv9Vs8VhAEc+cCgoYkSqMw6dYKL+mz6R3rWYtBdQRNwoYnItjhUU7qw2gyVfkXRSbyjvrz7rdvwQzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TvrZEaD9; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TvrZEaD9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=G2
	l3ukdpVpShjOhp1L8RvNWAeO8PsphRq0XYpI3vJhs=; b=TvrZEaD9eezB0pZFzU
	DcVBaVJR9I0/dOOdX2T3+67Zr8V8R+4Q4pWtxbqAMspnkabZG5CYHkeMCBoGm94o
	XnC43an6r/vHrIRGH5Q+CqzjA/fF/JmcUryPzifdVCer4aaDtJvcm97IhdQwx37T
	a9B02trkEoIpMOj7rQFNCHwVA=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDHLrLbr9hprDa2EA--.59603S2;
	Fri, 10 Apr 2026 16:07:56 +0800 (CST)
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
Subject: [PATCH v2 bpf-next 1/2] bpf: Fix Null-Pointer Dereference in kernel_clone() via BPF fmod_ret on security_task_alloc
Date: Fri, 10 Apr 2026 16:07:55 +0800
Message-Id: <20260410080755.197991-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <8fd076d2-af88-4e35-8009-797132511063@linux.dev>
References: <8fd076d2-af88-4e35-8009-797132511063@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHLrLbr9hprDa2EA--.59603S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFWftFy3Zry8Xr1UtFWxCrg_yoW8GrW8pr
	W0g3WqyF48JFy7tr9aq3Z5Gr9ayr18JF12qw15GF9rAFnIvrW3GryrGr1j9a4xWryxCa1I
	vFW8XFZxAr45AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi1SodUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC8RyzLGnYr9zRvQAA3c

On Fri, 10 Apr 2026 15:49:15 +0800, Leon Hwang wrote:
> On 10/4/26 15:40, Feng Yang wrote:
> > On Fri, 10 Apr 2026 15:21:26 +0800 Leon Hwang wrote:
> >> On 10/4/26 14:10, Feng Yang wrote:
> >>> From: Feng Yang <yangfeng@kylinos.cn>
> >>>
> >>
> >> [...]
> >>
> >>> +
> >>> +static int check_attach_sleepable(u32 btf_id, unsigned long addr, const char *func_name)
> >>> +{
> >>> +	/* fentry/fexit/fmod_ret progs can be sleepable if they are
> >>> +	 * attached to ALLOW_ERROR_INJECTION and are not in denylist.
> >>> +	 */
> >>> +	if (!check_non_sleepable_error_inject(btf_id) &&
> >>> +	    within_error_injection_list(addr))
> >>> +		return 0;
> >>> +
> >>> +	return -EINVAL;
> >>> +}
> >>> +
> >>> +static int check_attach_modify_return(unsigned long addr, const char *func_name)
> >>> +{
> >>> +	if (within_error_injection_list(addr) ||
> >>> +	    !strncmp(SECURITY_PREFIX, func_name, sizeof(SECURITY_PREFIX) - 1))
> >>> +		return 0;
> >>> +
> >>> +	return -EINVAL;
> >>> +}
> >>
> >> Why did you move them here? Seems that you didn't use them.
> > 
> > Because CONFIG_FUNCTION_ERROR_INJECTION is directly reused here,
> > and the function has_arch_syscall_prefix is intended to be used.
> > 
> 
> You can declare the function instead. No?
> 
> But, the function has_arch_syscall_prefix was not used in your new code?

Indeed, I will fix it in the next version. Thank you.

> Thanks,
> Leon


