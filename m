Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA89E54B;
	Fri, 28 Aug 2026 08:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787906438; cv=none; b=Be6vGWEDTI9eIHYxiE3DIHqGwKjj0Za7sGp0S8L2juZ/ZLPXYDstT796IL1obLePvoXXbI3iemsePvrfhUZvrA/1Yd29s6AY6FT2yN9lUs1xHe0k9oDsqKV1xM18lNVAT+HOfoym/M1nwzUTCTl3YmXekhpm1R1zFiersOe+MaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787906438; c=relaxed/simple;
	bh=RYt9CD0bNuwrJEjTzWptarntoMZiZMxev4LZozd3enw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ufRDnvki5za4LKG24vwETJvB3j4KeeL6Muwia+TzGvTm8UxrEY+pyqmzQq7xXy2tJjnb2ukcN2MhuJ0M6Gw0cQd7oDX/UdoDnf+PROe6kjtrJ4kJESNzELLE60K3dS9CedXC72sK/BjTh/aeKVtXWEfQREX3Nmf+aKAhKxxN59U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6HuyzJk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6HuyzJk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9730C1F000E9;
	Fri, 28 Aug 2026 08:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787906436;
	bh=RYt9CD0bNuwrJEjTzWptarntoMZiZMxev4LZozd3enw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=b6HuyzJkC9FOOj911f6lk5unLlKgNOr+tUgxRsWAIK+0LIIUj4r/tZuJ2CZGlUydH
	 BJ8dmJvC0H2PF5hCFUae6IYLjOiPED321OlmljtGYL2FQ/qXf4NGLFbOeeIp6hmaaO
	 /LqDALQwAUazgnEe4N7xmobbTl93pRbzF1O4xNqDRg5om9bzyKy1wFerhCmAA5gM1f
	 6zZgNo5YWVrEMs0uRYmSiTjU8g0obtuXoa0wb58JaHGVELUB7ZzocucmwO7knIl6ZP
	 h138ZoD9CLP7qnBaZbyyMsRJrc8JJLT4YPyctcKcYZkOpwGIdHU5GxJoebLSUk3Amf
	 ToGOOXJ9IuBcw==
Content-Type: multipart/mixed; boundary="===============7184032113322305347=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <18fb7827c1b98f6edeb6d702eba20dded3bb0168fb5939a69ed0eb9a1eade968@mail.kernel.org>
In-Reply-To: <20260828075100.24776-1-yangtiezhu@loongson.cn>
References: <20260828075100.24776-1-yangtiezhu@loongson.cn>
Subject: Re: [PATCH v1] LoongArch: BPF: Fix off-by-one error for insn_is_cast_user
From: bot+bpf-ci@kernel.org
To: yangtiezhu@loongson.cn,chenhuacai@kernel.org,memxor@gmail.com
Cc: loongarch@lists.linux.dev,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 28 Aug 2026 08:40:36 +0000 (UTC)

--===============7184032113322305347==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> LoongArch: BPF: Fix off-by-one error for insn_is_cast_user
>
> Fix a severe off-by-one error in the branch offset calculation for the
> user pointer cast helper insn_is_cast_user() inside build_insn().
>
> In the current code, an offset of 1 causes the "beq" to target the next
> "or" instruction, which means the "or" instruction is always executed,
> even if the pointer is NULL. Thus, a native NULL pointer is incorrectly
> combined with the arena base address and turns into a non-zero address,
> breaking nullable safety guards and causing silent memory corruption.
>
> Fix this by changing the branch offset from 1 to 2, which properly skips
> the "or" instruction and jumps directly to the "move_reg" instruction if
> the pointer is NULL, ensuring the destination register is safely cleared
> to 0.
>
> Fixes: 4fdb5dd8aeba ("LoongArch: BPF: Implement bpf_addr_space_cast instruction")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

This isn't a bug, but would it read more precisely to say the cast_user
JIT arm in build_insn() rather than "the user pointer cast helper
insn_is_cast_user()"?

insn_is_cast_user() in include/linux/filter.h is only the predicate that
recognises BPF_ALU64|BPF_MOV|BPF_X with off == BPF_ADDR_SPACE_CAST and
imm == 1U << 16; the cast itself is emitted by the JIT arm in build_insn().

Also, would describing the effect as "a zero arena offset no longer casts
to NULL" capture the same facts more concisely than "breaking nullable
safety guards and causing silent memory corruption"?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33153668098
--===============7184032113322305347==--
