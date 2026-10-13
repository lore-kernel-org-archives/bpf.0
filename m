Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B6A5221CB
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 17:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791913255; cv=none; b=jfb/EfoKJr+ipf7+kd6TokLSCdHeV+HocnT+NXT/ftAqZJVw5XwKc2m27KEoHx/DucAfHz5hbBnGQQa7sza2QmMXxcCuCJWQOthz4AJ1NDThOl8DAoRlzqVJq9tabCs06KQkXgFuZuE1SKV9rYVPSPOHFFYq9huBiSX1EZKFIlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791913255; c=relaxed/simple;
	bh=WEe2afOElSlJL6Bh7KsT32n6volKogdu/5pO0Q14IQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgN43Wf1L6aT65WuT3VS4dGz6P0J+y+GSYKb/NzkG3ZQDBlFdRsZ2wbVnIDj18XiF1Ri2XDg/qbfTxbm8ochK7g6sU4hAcEeb6dUV8392NhqMdlJwHrLD1WKwBZ6pBIvSxk9fBwRymG0g8B3fk+7ukgvlEavhnMFwp7XbvMiAlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=BSNqqkvE; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="BSNqqkvE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=cnvU0r/W+46ImQMvz8mQLjLVP3uUx1IwKcOnBe5Vy00=; b=BSNqqkvEjQY1rUB/HTfXW5UUAO
	ZaiI0uJt1ImTq27BP+Yif82X+tXBr66EqtmShH65zYoF/ae5uKVf+N3NgPX36ieFrjZq1yog1KBcY
	D8R0lsE0joiCJwGsn8WARBQy+ZJHWFn1kvPXSMWMYn0nr0+CB/lC09wxxkkWEa+fV4wTRKFF+au11
	XUU51VXmGOz48jpEQl1nhONvlNTbhOi9cgklvIZruqRZUErWXf8DsC9H56/kbE+OoXxYMBS1wZF/E
	JYFm3Sd0umrUuna3cXLU84Tk3W1sQbiaKhaPHmuI0eKE+xk5E0E763d40FHC9Zjwux4S9iCYbUMDj
	lSlbFGJQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xGg3L-000PRw-1v;
	Tue, 13 Oct 2026 19:12:39 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: memxor@gmail.com,
	yonghong.song@linux.dev,
	puranjay@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 15/18] bpf, x86: Use emit_sub_rsp() for the trampoline stack
Date: Tue, 13 Oct 2026 19:12:27 +0200
Message-ID: <20261013171230.523677-16-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013171230.523677-1-daniel@iogearbox.net>
References: <20261013171230.523677-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28152/Tue Oct 13 08:26:14 2026)

The trampoline prologue open codes the choice between the imm8 and the
imm32 form of sub rsp which emit_sub_rsp() already makes. Use it.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/x86/net/bpf_jit_comp.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index d1c22ae90fcc..c2fe72fa0bed 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -4325,13 +4325,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	if (im)
 		im->ksym.fp_start = prog - (u8 *)rw_image;
 
-	if (!is_imm8(stack_size)) {
-		/* sub rsp, stack_size */
-		EMIT3_off32(0x48, 0x81, 0xEC, stack_size);
-	} else {
-		/* sub rsp, stack_size */
-		EMIT4(0x48, 0x83, 0xEC, stack_size);
-	}
+	/* sub rsp, stack_size */
+	emit_sub_rsp(&prog, stack_size);
 	if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
 		EMIT1(0x50);		/* push rax */
 	/* mov QWORD PTR [rbp - rbx_off], rbx */
-- 
2.43.0

