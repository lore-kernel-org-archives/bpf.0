Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795501282;
	b=O8FqwI3f5iDvIKWxDH6N2CXUFWclP4hH4XKB8hFO05FZlpRyeeMQO/GoW93qYW3I+xJS
	 CjDfcgNNPKuInNiSK/6NnWNSN3NCyHHF8pVm2keN8A+ColkjyHLJDNAWyqYuXmRRLk81R
	 mTYM/tNTDLiXc0YZwtGZzf9A6zl2GwzF23KmjHC6mL6CWk8Mosca8/eokaZwcO2VeXvN7
	 aT6HR8jJ5e2FjwKPYlFJZTAVUGrjtEkm8dInWrXMFsLiRwLbkbKAFLRJO82p1sSUD64u7
	 6yS/5RQj4QCwgRswLq8QL9OKdEIA0Pqi7KmHzBtCB+sP6pJ0pPkp1LyZsxFboeb9e5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795501282;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=ABoE89s/WFkMcjQ3bulfL2OvrXI3uR+DaKdUMWt3+Do=;
	b=F5paybzcJtZwNJyVfoSIdn32p6DbeZaDWCMaHzmeE3a3vUntBS9MKsJ31HHeKVPDCsyI
	 r78AuVhl3Bga8/ZpaH9S1g2bVfLzf7mcw4lM93RHXU3BoiAZaJlcDcJd9ySpZMUvR4rfO
	 iRsf5PVzASZQWxQryZ/+LHaed4Ku1r0rf6Z0RgmubMXNd6mjog7FCej8SAjKEh56MUC1I
	 MZizr41BKAUUGmxHFlBJQnIM27BkAB/8gycfS9etnPaBfsvzDluv+msJ3cLjsOMuc6EZC
	 ygN56g+8SoctxC6FCIgb15bAD8gImGVNwuqNU8s/lswMPBCoRS37GJPgDEGl/XSPBpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V0gKFROj;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14196606A321
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 06:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14196606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V0gKFROj
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2efddf749e5so20543515ad.1
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 22:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795501281; x=1796106081; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ABoE89s/WFkMcjQ3bulfL2OvrXI3uR+DaKdUMWt3+Do=;
        b=V0gKFROj2Bzf4HhEsltf1mgTZkhGBlbfiUtJQ7Qwszx5jk+BDR6xEe6Mxx85AgxRLu
         cfljBUaPpgAehgbMImm3c4AerftNLXGITO784IcCNvkvVwOEkCMyH8XbAV8Ho1WX+sBc
         eXkb7nl8gPC7q+CsCtlDBQz0Gk7v6l/HGBZc5m8uVIekFtPf1PdGXFlEdXAPQIaP1hHV
         +zQdKrcvzWEfaMVPDqnBRo/a7VOGirFpIbMx+d63TFlzJhJkezC8jiht6aYgbEyLBpiR
         DohSf6IX1o9dRCcc4/3DPcqENbEfF9m7IeyA4TIsGUDdl9mf22xJHeqfMfQWFgacLtwM
         QKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795501281; x=1796106081;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ABoE89s/WFkMcjQ3bulfL2OvrXI3uR+DaKdUMWt3+Do=;
        b=Nq5tJekL2XcrujhI+aqvloBRnY4mO5XLwrOKNTw96f3M0Q4HbYPUsXmWtWWYk57gew
         jFWyHw0kkMyJOmdHOuEMfAwGCtSJJqECTzh5AnXk0jum1KQ/M7kVQcUPqRKZ4zXwZqnJ
         kWQyiWyc57d15HED2rVlWfel9ETC31jQaFILjvqL0GF+ilpy1m4QSnOGwwWwfxuUWNRE
         wx4ivv4NuNI5aQWp5EKZM8k+OwwaFXTU+BA9g9ZIVdreo49XiW5intylsAeus31Zgzda
         Mf9ASn+ygOpLvIylESWsMSi7tEa0WLs7mMdycUpO4GHF90dLXZarhgoc6USIodh3y8rG
         ve1g==
X-Forwarded-Encrypted: i=1; AL+hErEYNBVvIjcGINh3YZiev09CSfBbDvDhL9869kYeBM1+tqJ0Nm1MbHMtKBKhE/a41pC8S9E=@vger.kernel.org
X-Gm-Message-State: APuU4Z/xBQrBDsdQEhLC2V49K4v6w5CBT9NyNVQ6OURLHZ8xMnUDgjyU
	HxG+WVSVtufoJcVjsEMB/ey1KK/Doqmo3S7JcJQezfOWicHTVB7UnG4I
X-Gm-Gg: AZFdTZd5bA4abbZP8f8vqyFqocnK3wOVOEpNWikbekcWJ227oGDvOqyUQhlMm1TAnwM
	L/CaSINLqf55b8XkdVBHgwSOlNftnvvX6vl+DhnaC3WeEKt68tMMHN8bqHLSmw10oHTnqL48SOR
	aIX2NEG5ixZiX7nL5iNpwVCERGKTWA2brBtW1x4VZvI/6718aUfxc/hCfk+lsKW3VXwJeAz7tbT
	y24OvvmFsXrDAcWGgqV353TOy0nOFL+nTPlZueQ+kY58xzNy4HXaGx+UJSIGA9+6f8AjX+3rogs
	wEJyxpkVc3DamWwUCWaYmft79Ay3CAu8QnNARQgJsqd3zhdv/x+ERyW6lhBOKKymhn3dUwOi8jQ
	Qyuyq6RMwJEVlKLJcROCqkQrp4e0RYTSaFzH45/XDY9eDXX7I6Oqf00NoIdRJOJCLbceQTns4kh
	5W1wXoX32ki+3eTX30kjGbbilcN4etJOTlnjmFtCeDbYUzSIz1/u1OqRNzEmYZnULNrIIM/HLfU
	tLsXrWmG2LNHt4hVdSNgv5GnEv+OjM6dMaI/HV1Rxv2TlyVe5/hqohAM/9RBZox+jMrTxQDqpeu
	Vrv/ZG9+1fOnY7XV0mdeNp3bzg1FkO1rDzvl+teGQmP8E8dGy3i+YaXU1DzD7UB7sQsU3r62trU
	dk0JHNMOuh3ukg35e4srct+O2JmG0KPF1hg==
X-Received: by 2002:a17:902:f54c:b0:2e3:643:279b with SMTP id d9443c01a7336-2f03f1ed636mr98397505ad.31.1795501281131;
        Mon, 23 Nov 2026 22:21:21 -0800 (PST)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f118c7dsm64174325ad.55.2026.11.23.22.21.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 22:21:20 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 06:21:20 +0000
Message-Id: <DN38312WXPDJ.2KLUTCWSDFL3P@gmail.com>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri
 Olsa" <jolsa@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Steven Rostedt" <rostedt@goodmis.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "JP Kobryn" <jp.kobryn@linux.dev>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 0/4] bpf: Check recursion per task for
 preemptible programs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <mikeba@sentinelone.com>, <bpf@vger.kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>
In-Reply-To: <20261117-bpf-preempt-v2-r2-v3-0-586376ec3672@sentinelone.com>
References: <20261117-bpf-preempt-v2-r2-v3-0-586376ec3672@sentinelone.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Nov 17, 2026 at 03:29 AM Mike Bazov via B4 Relay <devnull+mikeba.sentinelone.com@kernel.org> wrote:
> - Marked programs are not fixed. A program with a per-CPU map or a
>   tail call loses runs to preemption as it does today.

I suspect users will hate the behavior introdcued by patch 2+3,
since adding a per-cpu map will suddenly make the prog to miss events.
But the idea has legs.

Earlier I proposed to insert bpf_preempt_disable() by the verifier.
No need for that. bpf_prog_exit_run_ctx() can do it when per-cpu access
is detected. Like below:

> One question: the marking is automatic. A flag that the program's
> author sets would avoid the second trade-off, but existing programs
> would keep losing runs until they are rebuilt. Which do you prefer?

No new uapi.

>   series #2    42.34 [42.12-42.78]  39.87 [39.46-41.38]  41.53 [40.79-41.75]

Good enough. let's keep the walk. No need for the array.

+static __always_inline bool bpf_prog_enter_run_ctx(struct bpf_prog *prog,
+						   struct bpf_run_ctx *run_ctx)
+{
+	struct bpf_run_ctx *ctx, *old_ctx = NULL;
+
+#ifdef CONFIG_BPF_SYSCALL
+	old_ctx = READ_ONCE(current->bpf_ctx);
 #endif
+	run_ctx->saved_run_ctx = old_ctx;
+	run_ctx->prog = prog;
+	if (prog->percpu_state) {
+		if (!prog->sleepable)
+			preempt_disable_notrace();
+		/* sleepable prog should be using explicit bpf_preempt_disable() */
+	}
+	for (ctx = old_ctx; ctx; ctx = ctx->saved_run_ctx) {
+		if (ctx->prog == prog)
+			return false;
+	}
+#ifdef CONFIG_BPF_SYSCALL
+	/* Initialize the frame before interrupts and NMIs on this CPU see it. */
+	barrier();
+	WRITE_ONCE(current->bpf_ctx, run_ctx);
+#endif
+	return true;
+}
+
+/* After an enter that returned false the frame is not linked, and the reset changes nothing */
+static __always_inline void bpf_prog_exit_run_ctx(struct bpf_prog *prog,
+						  struct bpf_run_ctx *run_ctx)
+{
+	bpf_reset_run_ctx(run_ctx->saved_run_ctx);
+	if (!prog->percpu_state)
+		return;
+	if (!prog->sleepable)
+		preempt_enable_notrace();
 }

I think this should minimize the breakage and fix the issue.

pw-bot: cr
