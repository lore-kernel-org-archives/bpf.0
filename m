Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACE83DAAB7;
	Mon, 27 Jul 2026 07:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785136242; cv=none; b=A3X7Ep0Eb/Ax33QdZMxkneNJ+UuGMJCgd3EWlUnnEPPGz2oVHdfui2OmTpVTj0okwrHTFq/gDbYkrpnF6t1FWbIujKWv8OOAlU6QOP3JPu2HBBh3Z0jpkKB9cAGC8Bbz1g9Uc6GYW56ZI9ZzhWSYZEjLdZbAMB4CYRTo6OyzIHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785136242; c=relaxed/simple;
	bh=iMXvijyU4ZOT0FLE3oXO2jTcavufFEr1j+sMn4IZPK4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=s4zucu0r8vZFiaY1DVMqbQpCv2FvE4Vu716mdDrPa4NNs1wkRZwVVdJ/8ZSTWU4STv488uwBWh/WEKwZRc/QRn570yHpHuE24JrteGb7r+EN8SYPR6wHSSON+XyK7d2FI+UpF5DG7POk8ysPuZI2s+9YVns5gZUXheflbP3I0Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwR/fPX7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwR/fPX7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B531F000E9;
	Mon, 27 Jul 2026 07:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785136240;
	bh=QE1nhcz7QL2ZAIIYHgj8S7/C9JtQLRsLFH+uEUyscw4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=nwR/fPX7QLkLBoZSao8D+LOlMLvHOZV6dnrEVe0OiXQqWzkHnntVXiEe0rglyHTdx
	 +rkVsSNDaOeiQpHtSKmv73zgfyQhd+7D29EqKB+HiJMoz2bIuAvlkQxc4ni4k+We6t
	 VXKsxsXyof6pKB5M+tew6d5DpFrmdXtedb/g/tMIlCQVILAm1OFoPtCKsrTBGsanI5
	 TpUW/Daiidqf0rjh0jEK/m+Cfi04AkWMqMn+DR3L3eRuN02x1Ji+YuBn3eA+uWh4c5
	 5H3PcyLw3LgktG6GerdqdjE0YO7bNXEpv0u0VqsyFq/Yp1Q19vuW8iweZ3IuRgKEDN
	 AoGe9dS7ax1+A==
Content-Type: multipart/mixed; boundary="===============2056660838945013230=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <040c342a22c856b323f1d2c67d2a582f31432ed464121cc73fd60de55f043c93@mail.kernel.org>
In-Reply-To: <20260727062521.376231-3-jiayuan.chen@linux.dev>
References: <20260727062521.376231-3-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf-next 2/3] bpf: arena: allocate the fault-in page outside the lock
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org
Cc: jiayuan.chen@linux.dev,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,bigeasy@linutronix.de,clrkwllms@kernel.org,rostedt@goodmis.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-rt-devel@lists.linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 27 Jul 2026 07:10:38 +0000 (UTC)

--===============2056660838945013230==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: arena: allocate the fault-in page outside the lock
>
> arena_vm_fault() allocated the page while holding arena->spinlock, so it
> could only use the non-blocking allocator. Once the memcg is at
> memory.max that allocation just fails, the fault turns into
> VM_FAULT_SIGSEGV, and the process gets a SIGSEGV on a perfectly valid
> arena address. Hitting memory.max is routine (e.g. page cache from
> reading a big file), so this kills innocent processes.
>
> Preallocate the page before taking the lock, like do_anonymous_page()
> does, so the allocation can sleep and go through reclaim and the OOM
> path, and return VM_FAULT_OOM on failure so the memcg OOM handler runs
> instead of a fake segfault. Also tidy up the error labels.
>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

This looks like a fix for a real bug that could send a SIGSEGV to a
process on a valid arena address once the memcg hits memory.max.

The allocation was moved under arena->spinlock, and the error path
switched to VM_FAULT_SIGSEGV, when arena_vm_fault() replaced its
guard(mutex)(&arena->lock) with raw_res_spin_lock_irqsave(&arena->spinlock,
flags). Should this carry a Fixes: tag pointing at that change?

  Fixes: b8467290edab ("bpf: arena: make arena kfuncs any context safe")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30243398938
--===============2056660838945013230==--
