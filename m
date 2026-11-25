Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795579711;
	b=4Tp5wnKjNDlXs9FKeYTrV/UWFGAzdvo0v0lYl8uZGw9dWuz4ZBXQEdi+GVsUqZZIal9J
	 XbueUh+Zb3qVmW5vCoQ2PIg5PbKB8cF8wqAOp+TiH/Hmzehgk6hO5udxi7Sg+zlFPYHTJ
	 wjSdbJ4hy54BR3tUl2fWX4Zu7ApuEXWOC0shd0Opcf/jNophQ5koOH765d8b21qJYHLqS
	 3orjQDqcbCegESzYECv7hi0545w9tsy43IIBsoWP45iSbxmzl/Lf87GDT64wP0/FTSAcb
	 FxhNSCTNNrgkS+hYnqCa6c1fPQ29HJWNjeA5WV8Rznt6j5gbMKElIwhEKRV6qdCD7NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795579711;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mkqG7Asnb3qHT9XvvWrmrrUTvHM4YuYoF5AWv0HH1RM=;
	b=LsIn5pCXfKaXReDGZECK5PbepzaeNkwsbcE7tkPQnuwAVi/ihlN+o52LYqWoNyAC/0fI
	 wyOV0DknN7V5PPBKpuXiGYRoeT4QLB1GoWSl+K2joMMDR1n6xBcMoNlH7DyebkW7XvpKL
	 CiFlQeJdSoCZmBw0uSZzgZAN/2CPkKp6u0HN9MqzjwFCOTYG2AMJZoIw/L9oOQ5E8DwoV
	 lICMnoQpefT4L/B7HVc+jUmfzGRukHeKv7SQ/+mwULSM4sRLyIwd93Uism4Q2tnRCUkmi
	 qMmlGzzdKdgDoEzip5kaHhn9YAJ/YgQpfTtpS5P5rMygwr/gXYFVumadzpy7tV/vgkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sMoMhiWl;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79BC606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 04:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C79BC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sMoMhiWl
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a05b210703so2481590b3a.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 20:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795579710; x=1796184510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mkqG7Asnb3qHT9XvvWrmrrUTvHM4YuYoF5AWv0HH1RM=;
        b=sMoMhiWlii//uB+jxrBWB6anqMclNPUerGGM/jBQkCfm0hHcwWV1qNbcZS4iLzomtA
         qTl9jEPjk4tl4vU9a46nus3JTPdM+m9B7r75vBrOfI3SwUwczJz8BJOcqwM7YeM5tbc9
         /kYqqc0/zm38imDjoonAM3FcMioryVIakh1sSOJ3Q+UkU/sl2FckCnOihL4M0nS0+XCf
         m0uJ4S1MC97e83awhAOFHMNau+sf3T8GEJWjcuBmJAMkdxiGWS2FrsENwKh+2EEU1mq1
         8rwCx6xbRDV4M28sY7NLvhDq37kct4uDqdCl3WpuI729BFwaxGe5jGTtKgsnKjnR0aAq
         1fQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795579710; x=1796184510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mkqG7Asnb3qHT9XvvWrmrrUTvHM4YuYoF5AWv0HH1RM=;
        b=GMluswRWjYRpRqlYD8cL8mDK3RU7dqp2Uidewou8lDV4JXRbybfFvK0OJAZVxYpNru
         TBkt9HPyRV2YwppvNAhNXkeMfhVjd9uvjjI5qxV7XYwX+4XDkYOl+hwYo66LcxRRe9Vc
         Z2rsImFvAHzH1OyiDKwWlhh0GzhAaYJOdQgI2sFVwC6ixJP15a7D1stfHX01Qjh8kCyl
         DCLw4lbhxuxyK3Ugc7YAJw0TvYj+S3Qm8XxYyhRW1SPceFZdkGXrgjBEWqYdSf3mJjoL
         adbm0FwIknbVaay/zxx3oDGi44K3RhKKl19mR/ZCXpwSntopl7B/LZRNcpPg82TppWzw
         gNzg==
X-Gm-Message-State: APuU4Z/VRH/vAotsOuM07E7/M6q1lLo2gPCk8uZEDRGXiaHJErympMWU
	9eNH1ZrpZdQryZWS/me6Y/uZ21TWLzfj9nUjL9Ta3G/LSvd6I/sSPoH/hO9sF78Y
X-Gm-Gg: AZFdTZcN30Xbyzgmw4vmziSzQrd3R4vSaYjeChodV9IGBCMntYBKpyDFAEPpHrULqlU
	7uyEDxHcTxJRwipf75/ny4hBGpDznXiCEp3zbTLy8BTVvldKqvGZkcx3JzYW3ccgqCA4F0+4V/7
	TwVeqbX5G3treeBzpd8JISTswlNDDUbpF4lK2OIgKMgZvFvEgX+dXgCckZVbtxpiTqUokBORflC
	FzTDD3aIFjJi8y66Vlupq772h/s4Ph8qYIYKKkJ5dlvmoWt3UL9cuPU3xodS4Tinx818orw1Tx+
	/n4iTQcdKHJkq88gIyy4CRXf83P4BP1xMmuF5k7SPH9EuQEYDbXLdofP6NysWGmdYCjxHUroN2U
	7aqTA+ZzBiRFDEFZ+gFSFjTCuyfzqO0eyVB8I6ATEvVRPLcwLFClCW21/eW6Sudpf8LxbZEFjGe
	BYNYuQ9tBGJqinviilVwfUGZZr7BcVQzvaCAc0R4AVULZXU0l5W2Txe6C+BG52Y3rQpbc4iX70X
	lcZY+I/E3p6xhCPakdiJ65W8NURz+bYVt8OoMpF0hWjNt9QG3/vuw5XhnHb7aVoVQdXCBWmEuol
	IZ+EBms3QlrTo74JeAMVtUTT8ap/h3QnvIQGNGrGyFlDgLa0GbwUAhO62O62i0DG7GGjjmnC8LU
	nsEvgPM+F37CcwHj1X28l6rLI0otX5sZLTDa6VKILfrmK3/FYVos+wOcBpKSCAhb48ZVL/1MA/w
	==
X-Received: by 2002:a05:6a00:10c4:b0:886:3bd6:fe65 with SMTP id d2e1a72fcca58-8c87b9d0526mr17256487b3a.19.1795579710002;
        Tue, 24 Nov 2026 20:08:30 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285c263sm8132794b3a.11.2026.11.24.20.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 20:08:29 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	luis.gerhorst@fau.de
Subject: [PATCH bpf 1/5] bpf: Undo insn aux changes of a failed speculative path
Date: Wed, 25 Nov 2026 04:08:16 +0000
Message-ID: <20261125040820.947816-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125040820.947816-1-alexei.starovoitov@gmail.com>
References: <20261125040820.947816-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

If a check fails on a speculative path, do_check() adds a nospec before
the insn and ends the path. The check can have written nospec_result
and ctx_field_size of the insn already. The other paths can use the
insn with another type of pointer, so these values do not apply to them.

Save both fields before the check and restore them.

Fixes: d6f1c85f2253 ("bpf: Fall back to nospec for Spectre v1")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 01a74e166e89..dbd9a21977fb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20629,7 +20629,8 @@ static int do_check(struct bpf_verifier_env *env)
 	for (;;) {
 		struct bpf_insn *insn;
 		struct bpf_insn_aux_data *insn_aux;
-		int err;
+		int err, ctx_field_size;
+		bool nospec_result;
 
 		if (signal_pending(current))
 			return -EAGAIN;
@@ -20782,6 +20783,8 @@ static int do_check(struct bpf_verifier_env *env)
 		if (state->speculative && insn_aux->nospec)
 			goto process_bpf_exit;
 
+		nospec_result = insn_aux->nospec_result;
+		ctx_field_size = insn_aux->ctx_field_size;
 		err = do_check_insn(env, &do_print_state);
 		if (error_recoverable_with_nospec(err) && state->speculative) {
 			/* Prevent this speculative path from ever reaching the
@@ -20792,6 +20795,8 @@ static int do_check(struct bpf_verifier_env *env)
 			 * markings for alu sanitization.
 			 */
 			insn_aux->alu_state = 0;
+			insn_aux->nospec_result = nospec_result;
+			insn_aux->ctx_field_size = ctx_field_size;
 			goto process_bpf_exit;
 		} else if (err < 0) {
 			return err;
-- 
2.55.0

