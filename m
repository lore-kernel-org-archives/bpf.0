Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793698457;
	b=yAXvZj4poeYo6h92jc2PMRwH77BuKqAOJCZPxNR7kJrcz7i5yzChf5QNAXYseHQiz3IX
	 q1KSRiWJ2bLkQeS1HBMF2bZV055bXCH7jQ3f3toG/Qe7XLj278isM9fGZbqX5S4oOYS8g
	 A7yIrUPbW79QzittOxHydfH11C3lWpaBgZxQbV33sjXik7eYwMBCDPI24Jblpj89IbZku
	 veLXDPDM7dg6LBgmkz1HmXXLN1E8HjRmewRVfelL+3GZrSrZ775CcER1QivrMlzGHra1j
	 HrS7lAc5ymW/rVXtPLHrjZIK/mE2UoVl6IYh5LXUKfXDTp8okqrF04Kh5hAuVgymkSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793698457;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=dTixCFL7oHg9FZJ3F174zZixbrjrHdpUl6IrOls/OiA=;
	b=us7tFn8UTxf/Hchkw7VHctRAPEm6/pnouzy0kK+z5wC2ld4ayLNubIcL6q+txPgPT3jl
	 1D371AQfuSbWBJCHtiqX4JcugCI49PEgTDKE4gLAlxDO/OElgnJaD4hMvxcb92jqQULae
	 G+unmrDuHO/FgEhciTYcHJ10lwusIoEZUcc9JR+Li5h+TyvJB7dASrRx0gNVRH3zlrDfP
	 iXcJS+4gD0oQtH095lO/uxmYgbP7707Qpvey9bN4C/JnOVj6OGM3m2UT8O5j5+zQ138W6
	 MFPPtPREK92RVYmCwS9E5Xj+/h8PuNZiVgTFhfMLiuJloZbeVTupxV4kCueP6AHGcvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AsGRcMKh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297EF606A324
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 09:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AsGRcMKh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 375771F000C1;
	Tue,  3 Nov 2026 09:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793698456;
	bh=dTixCFL7oHg9FZJ3F174zZixbrjrHdpUl6IrOls/OiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AsGRcMKhixjKIwoBwXRUyaAX4nJ9JVeWvuWTWSqJW12g7ZDl8SGlKRunKwY4R+3GW
	 9tbfbIpQsf/Zpt91KULxYUB81UB3DO+9ZvCpEfhzANxvI/VojnWnG0SbPBd3VD//9C
	 qZbCiqW51/QRQIvdw4ae7EH2EQKz2C6uCMRMPlVqr1qkZam0Wfo+b6z3DrodHnd3qA
	 7PI4QF6gfjkBx8akLp1vFLIYQVeHtxFdY/KWbEXliWc8g5hwvCQI5txb28kxFGqaAV
	 QOdRcz2IxRWSXe6IFM30K7cJl761zF8LuafClKxWNVScL1ivzY3hilc+S06XO76aiE
	 wDbiUKAI73l3w==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	HyeongJun An <sammiee5311@gmail.com>,
	Christian Simon <simon@swine.de>
Subject: [PATCH bpf-next 1/4] bpf: Disable private stack for uprobe programs
Date: Tue,  3 Nov 2026 10:33:57 +0100
Message-ID: <20261103093400.112178-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103093400.112178-1-jolsa@kernel.org>
References: <20261103093400.112178-1-jolsa@kernel.org>
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

Uprobe programs can be preempted, allowing another task to run the same
program on the same CPU. Since the private stack is per program and CPU,
the new invocation can reuse and overwrite the preempted invocation's
stack.

Disable private stacks for uprobe multi programs. Fixing the issue for
standard uprobes requires additional changes and will be handled separately.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/verifier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 935b163f81e4..a9c6a4b8eecc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5706,6 +5706,11 @@ static enum priv_stack_mode bpf_enable_priv_stack(struct bpf_prog *prog)
 	 */
 	switch (prog->type) {
 	case BPF_PROG_TYPE_KPROBE:
+		/* Disable private stack for uprobe programs. */
+		if (prog->expected_attach_type == BPF_TRACE_UPROBE_MULTI ||
+		    prog->expected_attach_type == BPF_TRACE_UPROBE_SESSION)
+			return NO_PRIV_STACK;
+		fallthrough;
 	case BPF_PROG_TYPE_TRACEPOINT:
 	case BPF_PROG_TYPE_PERF_EVENT:
 	case BPF_PROG_TYPE_RAW_TRACEPOINT:
-- 
2.43.0

