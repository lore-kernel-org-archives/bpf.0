Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF7F403AF0;
	Mon, 24 Aug 2026 10:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787565806; cv=none; b=oJRRlUFEunM5kwxUMay4rjls+V5K1aSI8PorUkQtRxaLuKF9B5UrDdMBAxmdzME9qrGONo7xJ0/iKcBMRB9rL79GlzrJ4Ty6KLv2PYHb1JU0kqZYfeOUOQL+DxTMqM1l3wMOGyQywLNscMiyk1+IpB7tyI9aY4GetfZ/w+Qf15k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787565806; c=relaxed/simple;
	bh=bl2/JDyUIY2cKbFiZIUMIP2PnlIXZxF++39iwVc5ROo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=PmtTSXY0Y8v9Cr4XY87IacWGidnAT4xmb8Ut9w0Z94h916o54m66ZKhJWAzoVshA3iVJzLNFLuzGRhOZUAENkbgVzM13WewXRx9n5Kw1Z/VlDTeVGPB0kL/GNYe11oOED9AS9cQ7sEKkF4CBMq8Tbi8ULuY30gLNgiLuFwvWMGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yi15t1mn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yi15t1mn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E787C1F000E9;
	Mon, 24 Aug 2026 10:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787565805;
	bh=xKn8qTxqzS158Z3ICLOg/hDCwSDwh4Gg+J8H5lfa/2U=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Yi15t1mn+QZPbqHGqwEVHzXoi+lJ3uj7thbJ+k3XI7+FPwFR0B1PXsag03yBuAOl0
	 FS8KXLq+xwGP1yvlrZ8mS/LbhPPVzD1L6xfymzOUMb8AzCZLgsEj0i/U7gaxCLnU+l
	 y8spFYPvF9kmBl06ZClkFla1KXrtYSmCcYP4J2E0zkUSYhpsEne4IW0TFkcNahf9ya
	 NAwpcxCtiv3rKjOMxxjO31ThKeN/LUu0CPYv1uuB1HSG/tgKsRUF4mWyNH1INGp/7K
	 1pj/98AqEDydhTj4YPKiEMA6zsJsklSRYQC8o4kQ4oFw3zTF7ESO97pa9Ih5DJMntS
	 enNXoyYhM0YxA==
Content-Type: multipart/mixed; boundary="===============0730891725083695924=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3cbe827e0809b8f8e521cac3f904986e6d885780838a4118da311f40e70b1c2b@mail.kernel.org>
In-Reply-To: <20260824092847.361683-1-jiayuan.chen@linux.dev>
References: <20260824092847.361683-1-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf 1/2] libbpf: Fix usdt attach failure when nop10 crosses page boundary
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org
Cc: jiayuan.chen@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,jakub@cloudflare.com,peterz@infradead.org,phoenix500526@163.com,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 24 Aug 2026 10:03:24 +0000 (UTC)

--===============0730891725083695924==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Fixes: 41a5c7df4466 ("libbpf: Add support to detect nop,nop5 instructions combo for usdt probe")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Does the Fixes tag point at the right commit? The -ENOTSUPP attach
failure could not happen at 41a5c7df4466.

At 41a5c7df4466 the uprobe was shifted onto a nop5 (0f 1f 44 00 00), and
arch_uprobe_analyze_insn() ran uprobe_init_insn() unconditionally:

    ret = uprobe_init_insn(auprobe, &insn, is_64bit_mm(mm));
    if (ret)
        return ret;
    if (can_optimize(&insn, addr))
        set_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags);

uprobe_init_insn() accepts nop5: is_prefix_bad() finds no prefix, and
test_bit(OPCODE1 == 0x0f, good_insns_64) is set. So a nop5 that crossed
a page boundary simply produced a normal, working int3 uprobe. The attach
succeeded.

The failure was introduced by the nop10 switch:

554ba38456da ("uprobes/x86: Move optimized uprobe from nop5 to nop10")
made can_optimize() failure fall through to uprobe_init_insn(), and the
nop10's 0x2e byte is a CS prefix that is_prefix_bad() rejects:

    if (can_optimize(&insn, addr)) {
        set_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags);
    } else {
        ret = uprobe_init_insn(auprobe, &insn);
        if (ret)
            return ret;
    }

ee2862439e5c ("libbpf: Change has_nop_combo to work on top of nop10")
made libbpf shift the uprobe onto that nop10.

Should the tag be:

    Fixes: ee2862439e5c ("libbpf: Change has_nop_combo to work on top of nop10")

This also matters for backport scope: a tree that has 41a5c7df4466 but
not ee2862439e5c still matches the 6-byte nop,nop5 pattern, where the
new hardcoded +10 in nop10_within_page() would be over-strict by 5 bytes
while the bug being fixed does not exist there.



---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32712703327
--===============0730891725083695924==--
