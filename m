Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955092D5C7A;
	Tue,  1 Sep 2026 13:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269514; cv=none; b=auVUzeXwGSc5EGmmIS1b+d4fvN6ZdgGe5SmdnHGDga4yEjVnjxuyEjxm+6sPxWD7NhA0QPmT5m43izR3GUNLVCLYuDIprdmXcyI0DhkspjisaT9XobSntwHTiUV8JEi7srtZo29iwism3w1RYc8WEOl60bk5vWPs4RNL+DrBPAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269514; c=relaxed/simple;
	bh=YEEfDWcVQSOt8i+UkQ9KrXw4s9RdNf6QPRcsBXOUzRg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=vGm4jmYwwClDkSI/JoZuQBgJHLjlcRTAzUd6RhfTWoOZJS3KG9NruLJIv+hjF8ZQ/dhrDPKEttRG1v3jF66jVD+VdY62g3PjRlgGRi9TOUr/axKkkOfQ5kZ/vAZLWFI0rguJ/gdL06DbhUbHoBkar+31inKGFR28MBQOgYwW4vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=locj2gEd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="locj2gEd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4786B1F000E9;
	Tue,  1 Sep 2026 13:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788269513;
	bh=9G3JvIjUOuywtO0FoKWwJSNlg8jMIMjHfgK7s4gduAQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=locj2gEdIeJlVn8Cf5Ksncp1iv4q6IbuGIaLHEKXHRYE/RuLK2HsJ1vd0Dj4m5SZ9
	 qG3teN4/n5BYnGkugnLX5N558umJMX+GNoGZWhXAAVgo4PTiSZxJnlBG91EIrw6jMj
	 bb247KfWNPPuw6Z7qDOgGHuzUTzQgIhxlWHT0e3Qa/NbZC+pS+RAQtHS8cX1VhSHRo
	 RGJ4/BF870L4uwyRmpcIC85J1fUzaBmZjHnwkJkg6K44llz9nwvnbAYAip8YvoIQC8
	 AD+KNdomhMwlCIwdC2/AqjMejMPA5gxOdUp7LTIb7V4IH9X/cRfBX1uI8IgvHjMx4k
	 SkL8as1956xXQ==
Content-Type: multipart/mixed; boundary="===============5494999732548298953=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <46b7038550e5d5ed680c36ee4e9bd96429b9bd85b600c257a254fe73b17d6e19@mail.kernel.org>
In-Reply-To: <20260901120013.16104-1-cp0613@linux.alibaba.com>
References: <20260901120013.16104-1-cp0613@linux.alibaba.com>
Subject: Re: [PATCH bpf-next] bpf, riscv: Register extable entries at probe insn call sites
From: bot+bpf-ci@kernel.org
To: cp0613@linux.alibaba.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,memxor@gmail.com,bjorn@kernel.org,puranjay@kernel.org
Cc: ihor.solodrai@linux.dev,eddyz87@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,pulehui@huawei.com,pjw@kernel.org,palmer@dabbelt.com,shuah@kernel.org,guoren@kernel.org,bpf@vger.kernel.org,linux-riscv@lists.infradead.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  1 Sep 2026 13:31:52 +0000 (UTC)

--===============5494999732548298953==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf, riscv: Register extable entries at probe insn call sites
>
> add_exception_handler() filters insns by matching BPF_MODE() against
> the probe mode values. These values occupy unused opcode slots and
> collide with legitimate encodings: BPF_PROBE_MEM32SX (0xc0) shares
> its mode value with BPF_ATOMIC. Relying on the mode alone therefore
> risks registering exception table entries for the wrong instructions,
> as would happen for plain atomics without the LDX class check.
>
> Make the decision explicit at the call sites instead: register an
> entry only when emitting a probe load, a PROBE_MEM32 store, or a
> PROBE_ATOMIC atomic, and drop the fragile mode gate from
> add_exception_handler() along with the now unused insn argument. No
> functional change intended.
>
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

This looks like a bug fix for the fragile mode-based filtering in
add_exception_handler(). Should this include:

  Fixes: b4757714cc63 ("bpf, riscv: Add support for signed arena loads")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33510775602
--===============5494999732548298953==--
