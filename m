Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795528923;
	b=dNaQrcHo3hinURJ/QAZETQrS20TxxWYxvregtGHKLM+CqA3vkFYS804pIfUs69S/LIp4
	 tDfw5Bmw5Ti6gc3eFASalvWyjb6TXlhkdBX40Sakg3HMUv0kFanfbbbe5EZQn37nPNJxM
	 3K/9a2LUF7RprPX/gzPiZTPV5KD39NB/R5OKhlh+4d+nPvhJ2dwW6Q6eXaqXbg1AWqguA
	 Ykozw5dpI+4AWP5adZCXtRyd9a8wUFKhvAwzBJYsi1p5+GEJBGdg/k04kf0PHyYX4PjFu
	 HVW81ZOIxqwlcUJh9Z3YUGRHGjP0Wze0G4iymTfCvNyWCI63gDGHYO8Q9NXzm/m7PZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528923;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=feCOYd8+x4PVA+AHwX80BGKSh28R272sC3C3ntOK21o=;
	b=TE6f5WSBsyBM/M92zjshUWrH45MYl+vBrbC37wn9RNJmA1BhE1MxQT+MS2VJiI/Q8Zh0
	 6L/u6QWBfetWy+MWVDe4vLTaSz87YKR6k57lopcQc3OtBOYv5PsYojT6lKdznJOsjiwkH
	 W9V4IqJtiZXcuUGzHZIG6NqIM4Dw9XHIgpLVJe1YLkFEm3Hwx4Ii+rrM4CraLBal+48yM
	 aWpcJs6D58D10est4nTAGaYeOq/OpeCV6B0YjREWfHDt36qXHNT/Mo4mPOmkCgc+t5K3f
	 y5BcyKC/bsM8dnXormP9JV1aCaHX5pSMPy2xPVggOO7GuOa0vmcbl4DBe+zSPl7BO5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j299vuz6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380C5606A330
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 14:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j299vuz6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C391F000C6;
	Tue, 24 Nov 2026 14:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795528922;
	bh=feCOYd8+x4PVA+AHwX80BGKSh28R272sC3C3ntOK21o=;
	h=From:To:Cc:Subject:Date;
	b=j299vuz6vFC6hUUH3muT0AMz49fRCfWYruZwInSX1I7GZlGZRmKgN9kF3tvPFr5vZ
	 DQk9EXytG0LbBNJXQjEBjpOkEEZ8QjIFp6nFwrqacZNBAUmekuve06A4nI3MwQ2Y+J
	 sEnKuBYVeMw77iUAZM4LV+A7IRsTa31EbaMr8qP3cXH7GApcuWCK2+hmA731X+Isd4
	 NJZ9Y+7CcKF7Rb6DG44bYyI7YgO0fV81LINnYqj9MV/riPUfvVCjYcmkraVEN0S8Wi
	 fY2GlszLNifypBci4+TOUm7cdmt+VNd99U1eCHwMxhVFAt5sslp+cVTedldUYwDXSl
	 /Xk+U5+4Qsk2g==
From: Arnd Bergmann <arnd@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	bpf@vger.kernel.org
Subject: [PATCH] bpf: reduce kernel stack usage in bpf_guess_first_trips()
Date: Tue, 24 Nov 2026 15:01:31 +0100
Message-ID: <20261124140155.1555535-1-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The large 'bpf_verifier_state' structure causes the newly added
bpf_guess_first_trips() function to have one of the largest stack frames
in the kernel. With CONFIG_KASAN_STACK this exceeds the warning limit
I have set on arm64:

kernel/bpf/equation_join.c: In function 'bpf_guess_first_trips':
kernel/bpf/equation_join.c:1502:1: error: the frame size of 1552 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]

There are already some dynamic allocations in this code path, so
do the same here and use kzalloc_obj() as well here.

Fixes: 97f92b0c1df6 ("bpf: Check the body of a counted loop once")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/bpf/equation_join.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/equation_join.c b/kernel/bpf/equation_join.c
index d7ad7fb52ed6..4123a8448237 100644
--- a/kernel/bpf/equation_join.c
+++ b/kernel/bpf/equation_join.c
@@ -1455,7 +1455,7 @@ int bpf_guess_first_trips(struct bpf_verifier_env *env, struct bpf_verifier_stat
 			  struct bpf_loop *loop)
 {
 	struct loop_stack_entry *e = bpf_top_loop(st->frame[st->curframe]);
-	struct bpf_verifier_state next = {};
+	struct bpf_verifier_state *next;
 	struct bpf_loop_steps *steps;
 	u64 trips = U64_MAX, xreg;
 	struct scalar *s;
@@ -1488,15 +1488,18 @@ int bpf_guess_first_trips(struct bpf_verifier_env *env, struct bpf_verifier_stat
 		return 0;
 	e->exit_threshold = e->trip_index.r64.base + trips;
 	add_iv_threshold(env, loop, e->exit_threshold, 1, THRESHOLD_EXIT_JUMP, U32_MAX);
+	next = kzalloc_obj(*next);
+	if (!next)
+		return -ENOMEM;
 	for (i = 0; i < min(trips, 2) && !err; i++) {
-		err = bpf_copy_verifier_state(env, &next, st);
-		if (err || !move_by_steps(env, &next, steps))
+		err = bpf_copy_verifier_state(env, next, st);
+		if (err || !move_by_steps(env, next, steps))
 			break;
-		err = bpf_states_join(env, st, &next, loop, true);
+		err = bpf_states_join(env, st, next, loop, true);
 		env->extra_values = true;
 		bitmap_or(loop->nonlinear_xregs, loop->nonlinear_xregs, steps->nonlinear_xregs,
 			  MAX_BPF_XREG);
 	}
-	bpf_free_verifier_state(env, &next, false);
+	bpf_free_verifier_state(env, next, true);
 	return err ?: i > 0;
 }
-- 
2.53.0

