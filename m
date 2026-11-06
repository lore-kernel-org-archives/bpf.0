Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793998338;
	b=zPBjmbfFlqNAUbABogM866KjfErGIT+OuabBiOdBfP7FBfKevjI0SjcKNsOltSdDI7CJ
	 nmID6LgS57SvkyAzWibmjUZim8sEwBJL8hG8zYkSKE8Yl7X23bcUWqNUm6GVflkukzYrD
	 bMwfbfR9E9CsGkYCohXaxJjGWLOXynDdBrYUx0QOnYGEogAlMdeyTXff5BOY4kRVstwQf
	 IFa8PY76P11l7yz+oLmEpsKgKGUABbqee+gI2Q743vJ6W06REKyvDMyH009APEC6lB9NN
	 t+8z9xPDQGhL3FEccacVs2qzqP2WmB7RIsYTeeq7Xr5i3KPUrrrVyFPuBkj1eNdBz/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793998338;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Vv1IExS2I935n9pBlgYspHhjFGtUkBZ9r8CEJg3UIms=;
	b=fwnt97Om3po6VIh7a6jTETXgy+lLYEHirf7fK7Qgdkw9ulheVPirTNCeqtQjprunKztW
	 7lapHwQTef1R9iRal1z3xwY8SrfITB6k9CkGmk3q5RDFMlNyhXraAAxxCZZfOo8Qmm63U
	 J1IRvWkUozL28C26IDykH3YrtQaeBcOh9XtWzeEBpNq5puCN9MfX93cyCJfcyHEzviphW
	 r33lWEtoPSo2qY7tvRH+Ubii7MLZtdSGIR/HOIgrJ+3v4dXZ1ciQSDeFSgf7kv3Hq+2Af
	 xxDBPwepI0XpWroNT5Dak/QU/fUbvAxW82WYQfixE9+7A3xDJ7RKIp4H1KmDTRwbA8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fgUIY9+B;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BC16082BC6
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 20:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3BC16082BC6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fgUIY9+B
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a549cd7fd2so509095e9.0
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 12:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793998336; x=1794603136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vv1IExS2I935n9pBlgYspHhjFGtUkBZ9r8CEJg3UIms=;
        b=fgUIY9+B5lAK57Op/dDKd1d7PVapAOA9K2gT2X5qVUVOEWAuXLXE5vsCiVVuroFUs+
         d27F7fic9fg9HuB3kdy/dyCTUuUfB4N7+03mLGO6LVTU2uSE1zoBdGBamxedYvCPGmbc
         GTNeUqYnorfV2x6AqlFAX//dcg6+fnkARXptcSxaKgxVARtQ7Ejl06y4AuemZOcQSyH1
         zETBgn4HpjH0ck3mRMYaMhOKkVF6ce3LHXh6IMTCv8WRwGqTqDQvyP62DMnniwYzlN3N
         kcyudc9A0BeSgGDeg9mbawPfJ0S8xohAQgG3m/pVRZTJ/M2+8k3qeIxpGhd+EKf+Lnow
         iWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793998336; x=1794603136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vv1IExS2I935n9pBlgYspHhjFGtUkBZ9r8CEJg3UIms=;
        b=qaIvkyuiDxiXQOvnYpOl6HsJm6R+nB8JgnXGX1QqfeTuBwkUnp//88qz1roRyPx0dI
         3B+BallNWlAVJRJz+NWLzyt67yqFwcDkLSIweLjfUrwIESYbsNvZ5Nyt0SHTT4FE1To2
         BUK/Pt6I8zbJbkCccjLQ9ZR4/1LmQ3s4JefYVmhqx3pWjwKCWL8Ph3Sf+Tzs/37mltpD
         8Oij4Ir7BADWJHs6+URa69td7O+Rv6kwSc8Cb2CtyR4gnsokkaznWIhij++/KLvzLBCH
         o11Sikj/DueMWh4HKFw6ZYx6raZDka7eyjJUzXOrzPehHvTJONDgHcXCZrdtDiYa8txv
         ggRw==
X-Forwarded-Encrypted: i=1; AKwUvBxmjHR41PIH03MCjncMQvcAbgxkMRc84FLWO0ofzQvjhF8Vc3OhB6b1AiMQ9juHdv5RLG8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9XoXeBUmlFH4ufr+0/17RjsnJOibcOYkUBz66IKtfDuospzeSD
	jSyG/IHaPiBSUDeZFlkPgswmQ56muetQikvpOlA1BG5SsRI3S8nZ4ema
X-Gm-Gg: AYBFou2WnRKnL5ai9T7ChB0OxirdgP1TkBTJhiquMceK/8afVdOWZmTyNCBjdqaiYnT
	nRUpAtXVvcp6YdQmezC4k3AqlZ0EIy/ijYlRUzfkMSLhgbfLUdRPQ5gzN1PePKSOVkz01tSzHfb
	1+3LEzTVW54tbbYmroxA7r04yDpE9I80JbF0uAhpi15J5OEfRjVWJsjEw+R3danJlotW8vQgc+y
	uk30BZOiatsF5PApW2SGtQ7xv80oLLGBOGq5kg2F0HW2tabU+TzN9dCR8Zx1yGCrMfCovutuv4o
	D8ZJXYQcVjqX2o6HfR9XzZHXV2i72/ZfNRl1m/QqXKdnOW+Ze95ZAC9XEUcpn7VU1mTlXBsTSPd
	sDyagUy1CXDPLWifmAB8s0daGunbfgeToweaBX8faoqVnRPEZE22iYfZiK4d/lpvs/2XIPFk+iK
	1RLHE1AJru3pbTs2GGJzoqpVv/CP12RXmxLI4L7GyXBzgoOSoJ3D/T4uBpHcNcw+WcvLjFwNwrk
	aGAAuBTcddbR9bwffTUURnXP+ax3nc/HD+UAqf4/1UhHMf7GDEV7ciKk8oRL1m9C/8lGFdzR8oH
	r3726MoqJvHZ8+76akJFxUJlBSL5vjKjtZ441Z6Cy9ytjxs=
X-Received: by 2002:a05:600c:8b8c:b0:4b2:4b5e:8141 with SMTP id 5b1f17b1804b1-4b8190faf23mr2512415e9.9.1793998336255;
        Fri, 06 Nov 2026 12:52:16 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7da62edb4sm9075425e9.1.2026.11.06.12.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 12:52:15 -0800 (PST)
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
Subject: [PATCH v1 bpf-next 14/18] bpf: Require the JIT for fmod_ret programs on found 64-bit targets
Date: Fri,  6 Nov 2026 21:03:03 +0000
Message-ID: <20261106210314.1767267-14-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: 20261106205523.1765622-1-a.s.protopopov@gmail.com
References: <20261106210314.1767267-1-a.s.protopopov@gmail.com>
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
index a9da29a11963..0448a33085fb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22996,6 +22996,9 @@ static int fmodret_retval_init(struct bpf_verifier_env *env, u32 btf_id,
 
 	aux->fmodret_retvals = retvals;
 	aux->fmodret_retval_cnt = cnt;
+	/* The interpreter returns only 32 bits */
+	if (size == 8)
+		env->prog->jit_required = 1;
 	return 0;
 
 invalid:
-- 
2.43.0

