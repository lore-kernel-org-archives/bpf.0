Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243309;
	b=H8y30i0RCnsJKhETsiZ+zH8o7EGq6bQ646r74WX6c4qcxp3Ex/oSig+QF9pv/hH3+2X6
	 DbzWVbLi+fhxc0dSDU4bJXRZN0p460Vk5NZY/j0GU/L1oJ9PuSGPc46nvyWM78LY9U/iO
	 eaOoo2KPhYWm2azWTVUlW68yTx093gVMjnyH2bt0aLzDtBML5z1wYz52CyqpLGDh1fgSh
	 IGtniQb0CrfBoteSQfReYiI7SV4IN70WO0lkM8TVGPuxSLWmwApcUszgi0YeBH6OeZXsG
	 nzBcE+sZaIiDnhfHfuRM9rCi0MJukSc0lNkQbz2HCbAVxn1XpArCtJkfVULWz1Q/qMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243309;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=glLlGfgYJChD8Lffm3hFkjvGlOWchXmtpUUAyQ5pkCg=;
	b=jLG8QghREnP0Yh/G8uEA/euxIfJvrUf1fkBlmRnJGKcHXpTwHISunfEG8uCnVBZ/HmgO
	 tkjAL5yo8fJE3bvirB89ALr9L1vx81j4dDgRfT+Jidq8/Gy6Nu/avgNobKfJ0Pb7YdibB
	 lXmOwe4Kxz7cTJTHnI7T+4fMdyG+Sp+fzmr/X55iFOXzdiPToMkN/AH3btgZktTc1ZSLO
	 gUjAyYGXZlIQBjX0bN/WUUKFyyCTrRstKUvbU+WfK+RgdAuDf3ZoyNaxxwY0VqBP+g6rM
	 kmCfQAfMI+gLZmvVpw5hASdkAO8jwup5UN4+fZlb+nk6tM/PQK57NjgKYeAqytFMclQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X00UxUbw;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7ED606B6A2
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 16:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C7ED606B6A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X00UxUbw
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-492f6b7f70dso731611f8f.0
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 08:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794243307; x=1794848107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=glLlGfgYJChD8Lffm3hFkjvGlOWchXmtpUUAyQ5pkCg=;
        b=X00UxUbw+i45A+METVu7qbNmn99LG09FQ1uycXpRq4gPRPcAwguyi15Guwikis9GNL
         FCb8U88s9CQOrRoqzTr569hCuMWqWQBZbFlkLUdQhxNwkFhTyy8w21aHG69C2IsEGx4w
         LpVQCt14mfYoapuJ9dc8gWyNojMKMQb7U6/7Jq6jmOKhBuckQZi/ek3iC6E2Lgvpx5Jf
         Uh2mQHMA8sHQFGD9O4rJpiXwZ/LLIzoJCUv2aGDB68A/IM1TJQwvs2q98ZdegPe4X87g
         tTGdz8euQK8eFfoyKHwqI2nlkb0Qou1qa0pRNjtLs4LCZ6ZrFkvDQn+5/oHog3X23rPB
         WMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243307; x=1794848107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=glLlGfgYJChD8Lffm3hFkjvGlOWchXmtpUUAyQ5pkCg=;
        b=oF3eflyANxOXFXYR5zpuOPWPmGQ96Kkq3+Fbm299V7vORKTSHSKxkdI7YYD6HHx8jW
         c/rJMg05c9JQ0wz6DbAl0FdvNLpwGTRySEJheQbYZIa60+Zwegx4lv0JynbwbwVaULzI
         SK5iqoSmRJKX0XiX8J++XqmNfcVtihYQhdNiQULEAOq+JDMr/NtKHoUpBU5YarUVm09i
         KHG+2MGEtpRcwShmuTJ3ziTWodMiTiB4o3ZENO8bl+psuqFcev9u7G+XgIYzlcuXGEga
         n9zxQLKruXQwoK9+llrPhz7k2N4Jcx/IRSPuKtQN+8GT0thvMnbZJR+CYvwYqWnRuQhh
         OO0w==
X-Forwarded-Encrypted: i=1; AL+hErGkXUoVvruKhScX+H8reoDB5kc6yulIhsYFHbUlwD+RWrvbfLHi0h/KpVBGa63kmEjC/TQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9QxdL2Gvd7eESNp8nd4/pwAOpoPVyrh1VKXAUyZr1cW2RbVfqv
	NogXKmj/mU2yL2dgxyc+75vEOwAnVRjQvYFSGD76ud1Pxvy+wf1aOp6e
X-Gm-Gg: AYBFou2Nu/aO1rRtKuM2vaSW6Bs4/KKfbYOj5/gxpL4HpUyIMNa4okYEjqASoZnFQbh
	T1xwoDlvZhnZVwpN7Y/5WNjP3Hp5kfRRLGyTZEVsHdI0AMnce1UWLHd3cyho4PJjU8Tlk0LtzeO
	wGqO+RepL7ZdwaFA8ljJuEbgYazpXCfInJVHDENzEyAmdCbypfYe+pBkGZtJbQviMKJk5nFyjkY
	WW+IjrQkqs1wX4Q5tymb2isSiZlKADBFGTTXiXP9BZcospCdt11vbNuhtAjuDbTZVRQEWwd92Lv
	YAsnk9OoQHfA7OuJRFFcOJAiMEon9om5jsOCdxsus4XPpmS7phEsy0mfAGVEEP/WKPiFppUxGpy
	ALJcl79uekeR7pyoW0mKLEJupE8j4GwQiBkiipL4NjawbsBW31lqVeWTVVMP2D7MBaDgma79MAf
	4v901zLI56PekjssnNlnnbWoYqr4RGcBdW/lHyyx1AdgKHmjPskcz/cYoFWvnzjRnaujvLIrxz2
	uPk+W8Q+SD9aRSsxgMZ4Al2Vex9cJuW+IxWlgtSMZJQQJWnKi08NpIgoO0rTA7TjAs2T7sAfzZs
	fkVyODPvQ+Avv3U2sfdHJpc5oE/kr+HAHyMo6R5tB3Qpm8Vut2pt1lMtr2SQufmr0OKw
X-Received: by 2002:a5d:5d87:0:b0:497:bd30:8df5 with SMTP id ffacd0b85a97d-4982b28ab00mr190380f8f.2.1794243307284;
        Mon, 09 Nov 2026 08:55:07 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4959783fd04sm11392369f8f.47.2026.11.09.08.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:55:06 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alan Maguire <almagui@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Sasha Levin <sashal@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v2 bpf-next 14/18] bpf: Require the JIT for fmod_ret programs on found 64-bit targets
Date: Mon,  9 Nov 2026 17:05:34 +0000
Message-ID: <20261109170550.141443-15-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109170550.141443-1-a.s.protopopov@gmail.com>
References: <20261109170550.141443-1-a.s.protopopov@gmail.com>
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

The interpreter returns only the low 32 bits of the return value of a
program, while the trampoline passes all 64 bits to the caller of the
function. If an fmod_ret program on a found target which returns long
is interpreted, then a valid return value like -14 reaches the caller
as 4294967282. This value is not 0, so the function is skipped, and it
is not an error either.

Require the JIT for such programs, as for other features which the
interpreter does not support. The caller of a function which returns int
reads only the low 32 bits, so nothing changes for it.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 kernel/bpf/verifier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f3476b12c58a..5045d9fa68b9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23875,6 +23875,9 @@ static int fmodret_retval_init(struct bpf_verifier_env *env, u32 btf_id,
 
 	aux->fmodret_retvals = retvals;
 	aux->fmodret_retval_cnt = cnt;
+	/* The interpreter returns only 32 bits */
+	if (size == 8)
+		env->prog->jit_required = 1;
 	return 0;
 
 invalid:
-- 
2.43.0

