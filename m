Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793983263;
	b=GL7cxC+hL6sf/aAkRsxcGiAYAlGFjRZumzolLmBJDFg3G85XZoSXNK2XqOR6EjyLiFgU
	 K6jmyExlgOT0f6MVzwEmzvSib78YayVCPyc+ioVwr7jZHlNroxT3RashpixRHp2DB8S8v
	 j6CASJk/4aqwHwznOpHtBr/++VkoS7ZwLX4qJ19e6hIQ3X7LvGgwV2nxjl4PpQXyoylY6
	 8V+CpVyqZ5LkhQICM5tA3hda5ycSI/cleLQ5BITP7fv74CNtxt5cCTeruKgTWFkAmUz8M
	 lvh/TUeab88kYcyyvw/BniUDmgYTq1YRfd2A/y5h6amYWC/9Ikjm/nI/ghCwDo60i5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793983263;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=B5s+xEa+l5XBQhp2x1G0zMPbHIDwO/b9xJzQCiLFwZs=;
	b=WOY39cr5Bc8Ulv87omeqr8Dnmjjs0G/qSMWl8n4XJGCUKoQ/Wq+6oZjVWqhbR0neQ+8w
	 /qepTHAAGjnVNKGsXWvg4Hw96f/c7IxEALQGeX6luLq/KAM7npF0vIoJVnLNVu4p5tm6Z
	 wtGv2Kl62ve9A99sCkhVXu4PzaVcRqY4FhLlhvUCf03jn1RJQ9z5fCEVX5NIWwud3/Yjs
	 wpsiZGkLTu4Ovc5J/ayxuBJRZwU/ld5thT2JW5QuQqj/ydmFkMtM3gzvdTm162f0U7sZ6
	 APpQGrjiK3qf2nHuqnn9DNQjaHSgmvAu2clLbPSJaCW4F+0BVbuz7WZ7/XYFXRnIbrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jJSFzShZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AEE606A32C
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 16:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jJSFzShZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5401F0089F;
	Fri,  6 Nov 2026 16:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793983262;
	bh=B5s+xEa+l5XBQhp2x1G0zMPbHIDwO/b9xJzQCiLFwZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jJSFzShZ4zi13TL8l0R1XDF5Ae9R3PMW13kvuQMTVwrQEkvgVGaQERo4SmFy8W8e6
	 kHe89MRlVt4uROpTXa3FLo9AmStxHDmBvyIigbmGltXxoE16O5OZZFglOonc+2Figh
	 DdzOHlMopShAjF32PqEQAQWZhWN1BkvYeG4TThIK8r0j5fV2daBz+dB7ghcAvlIH2W
	 +0i8pdwHuTIdqqG+p0xQGGG2fAtZ/VP6r038OVbCIx+H091xae6fBfDKeLByuX9na9
	 /hKXbBtdUrzwyyRiirqVd+WvtUYpKukM79NP1hFo4EYIU3etOHpJhzZBTb+jMpRDoA
	 IPlARCSm4hC9Q==
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
Subject: [PATCHv2 bpf-next 1/2] bpf: Reject multi kprobe programs in perf event attach
Date: Fri,  6 Nov 2026 17:40:42 +0100
Message-ID: <20261106164043.546879-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106164043.546879-1-jolsa@kernel.org>
References: <20261106164043.546879-1-jolsa@kernel.org>
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

PERF_EVENT_IOC_SET_BPF allows attaching multi and session kprobe or
uprobe programs through the standard perf event path. These programs
require attach-specific run context, which this path does not provide.
Attaching them can also let a uprobe reach a private-stack program
through a tail call.

Reject multi and session programs in __perf_event_set_bpf_prog().
Keep the existing sleepable-program check for standard kprobe and
uprobe programs.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/events/core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 457d75ea7142..919f43cdb473 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11835,9 +11835,18 @@ static int __perf_event_set_bpf_prog(struct perf_event *event,
 	    (is_syscall_tp && prog->type != BPF_PROG_TYPE_TRACEPOINT))
 		return -EINVAL;
 
-	if (prog->type == BPF_PROG_TYPE_KPROBE && prog->sleepable && !is_uprobe)
+	if (prog->type == BPF_PROG_TYPE_KPROBE) {
 		/* only uprobe programs are allowed to be sleepable */
-		return -EINVAL;
+		if (prog->sleepable && !is_uprobe)
+			return -EINVAL;
+
+		/* only standard kprobe/uprobe programs are allowed to attach */
+		if (prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI ||
+		    prog->expected_attach_type == BPF_TRACE_KPROBE_SESSION ||
+		    prog->expected_attach_type == BPF_TRACE_UPROBE_MULTI ||
+		    prog->expected_attach_type == BPF_TRACE_UPROBE_SESSION)
+			return -EINVAL;
+	}
 
 	if (prog->type == BPF_PROG_TYPE_TRACEPOINT && prog->sleepable) {
 		/*
-- 
2.43.0

