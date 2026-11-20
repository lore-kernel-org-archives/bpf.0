Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795172379;
	b=rmgSr6RbeKfAy01QiOv+5zXqZiafq4hlm1kDUgXa6olUdPIwkvQ97O6rdwVeeavFao0Z
	 ImUh9EUaU2jTmwB6FBO5ZUJ+krfyLmXSeDuIeGDfsxSf9wnNH3X6Iutzvq9+YQfX+t3bg
	 rVCNmNyWey8PuQ6MNBHWRWyIo6I06mJGe83PG4Dfmo9kWxKqf4WHkbw0mhIzOc7zL3Xhi
	 v/OCaSYSUNlp1tmr4TVmvHsr+1L4MGmlCEOSELq7g90Nj7SjLVyIJ26g3n7/5zvOdgs0y
	 +JPhTFejaoI1LP8v/JGQKUtq+l0/HpEtWFdpv/yuqxyHyBgJkRdFLv1hkgpPGGeZvyw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172379;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=4/6xxOEEjLax1kP083eUMhZz9SlPR8r7YB1+NHHopI0=;
	b=ofgbh5Z2dH3T26bC4P3YwyEQH7nAsaK9aGIlvJ2deB1bMeu+6z3hUOCQ/QL0QA3sZAVU
	 3Hn6uxB7seJLNNBFuFtT+Pr4fOZuRChupHgrSonK8I+6p9xcEo0sYWPhTKJagUQIagZ6D
	 O7q9RDyI8KvXLh3/11KhRsIdNtFB71lD00o1RKGSLhnr9Vko/Gskv3igVEyv4Ur6bKjLz
	 CMotpu1i1oUW7Daum79tT2Q7j7hEDHo+kOPvD69GsTYT7nsM3kQrP3k4kaTZxvHlUol03
	 EEa9WD119GPs1+2p10Lz+efccGW9M/FnaE84Rtl44stkcC2PMyc4Pq5jttl8lzNOcrA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oaSoja8R;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C1F60A2602;
	Fri, 20 Nov 2026 10:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oaSoja8R
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795172379;
	b=faqCVy61E2+qW9JNgv5j26n+wtw42YY0gQnKCKGkSA0fRdzubAOQPUwaUr15dT3Vu6OF
	 nnNyARHd5gefTT6tjcJOzZE8zcZC3fWOgJunzIfWd9Mq3+YeLDlec0nwruk6g7gSB7GmM
	 YD7B8G8lfgIlfQth7/iaHTUJbqbZKip+fRJtl4uZevfkI7TLylb8GdNUzr8nYtj8kzmXp
	 Vm2+5Ycg1WhglvFf3C7czs8VMMRN/ZHftAF4101xGXGAvEcQGhOTsgk043AsOrcgbX4DM
	 9PfD/Xj9kfnwyOkrYjbXisjwyEKkvtv6RJTyaAmOGTpmRvnUQfhiWnNWqPLm+YEcF0A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795172379;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=4/6xxOEEjLax1kP083eUMhZz9SlPR8r7YB1+NHHopI0=;
	b=xNhXsC62crNIcRCi30XtZkPNN12eSJA5bdeqXKGQr+dpqlih/VEhNapW2NcAvGnCuVig
	 7P3+b0z3YR3FfWV/C6BKJ0RTplggGWb/Tshae/lPne91YGGJ73Ctfl+PSc9/BIQsFIL7w
	 GVbntsG3Tahw6KYqv8PyCryXfSK0MOaDyWzEV+iueLq4AMpkAivM0mLCK1X6LtjLXQX2C
	 EjMePt3wtHyy0tI9Yq+che5v3KVEUb2XRTa5O27lC3ByfCSfxQDx9vZopKUB8eZy69cmo
	 GbtheVupasVRdkOBLdBdkCCo1N8r1oEKZmviLm0/zodQ+xmaFDyBNyTW7u8vhardojA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 769251F000D1;
	Fri, 20 Nov 2026 10:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795172379;
	bh=4/6xxOEEjLax1kP083eUMhZz9SlPR8r7YB1+NHHopI0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=oaSoja8R3FUSnwq/QoBfbvTJmnMDv6gdu2WCetWv1pcXXgyGte4xwW4+/R8cKVvaY
	 rCPY39QVKdzVh4aqNGNAO8yzGf5WP1rMGDB/ecKnyk+fPLk9f8XrsWBNMKRICLVVNJ
	 EdtbP2IVSxP9fSbUGq0ySYfFErK+ZkVCI58fptX7+kyqSatvcDb4flPFJ4KWWEUPco
	 6m45zBngR7F4wnAJp99q3htObEGuHUYi0eSYiNZiGn+ywO5EJGBNRdl6cnaGRzaWy/
	 YWt/E2q7KiSM9blKpRJn16jbLSmbQ+Uj9k+EEE6SbkFPdCR7AmSgLHbLKkX6Yxr1Yn
	 BQcNXcX/E0Zpw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 029EC49820;
	Fri, 20 Nov 2026 10:59:25 +0000 (UTC)
From: Mike Bazov via B4 Relay <devnull+mike.bazov.gmail.com@kernel.org>
Date: Fri, 20 Nov 2026 12:59:11 +0200
Subject: [PATCH bpf-next v3 1/3] bpf: Don't WARN when
 bpf_perf_event_output() nests too deep
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261120-bpf-raw-tp-regs-preempt-v3-1-ec109009a5d2@gmail.com>
References: <20261120-bpf-raw-tp-regs-preempt-v3-0-ec109009a5d2@gmail.com>
In-Reply-To: <20261120-bpf-raw-tp-regs-preempt-v3-0-ec109009a5d2@gmail.com>
To: Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 Emil Tsalapatis <emil@etsalapatis.com>, KP Singh <kpsingh@kernel.org>, 
 Matt Bobrowski <matt@bobrowski.net>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Mike Bazov <mike.bazov@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795172363; l=1271;
 i=mike.bazov@gmail.com; s=gmail-20261116; h=from:subject:message-id;
 bh=OpB06pONNtl7It9Z2DjXFTZ1zpUQ2HlWqwhm6FIcX8I=;
 b=s9wlWDij4BjhO5fW4WXa1A/ivy4hTpJ6a65d6bJNrGAR/Q69mdw7oBUzAmIcIm5747HDAYOE9
 X3RyHFm/97oAzMnDMyEzE3TdCbafBYCFz2PhWnfpq9/Otqpjg8fGT8c
X-Developer-Key: i=mike.bazov@gmail.com; a=ed25519;
 pk=Rr9fagn0pNA+bs8tgc6DXZpRAhl/maU6BeqkttIR7DA=
X-Endpoint-Received: by B4 Relay for mike.bazov@gmail.com/gmail-20261116
 with auth_id=1544
X-Original-From: Mike Bazov <mike.bazov@gmail.com>
Reply-To: mike.bazov@gmail.com
Content-Transfer-Encoding: 7bit

From: Mike Bazov <mike.bazov@gmail.com>

bpf_perf_event_output() takes one of three per-CPU perf_sample_data
slots per nesting level, and fails with -EBUSY and a WARN_ON_ONCE() when
it is entered a fourth time on a CPU. Programs get there without any
bug: a kprobe program calls it, and fentry programs on
perf_event_output() call it again from inside. Each program's own
recursion check lets it in once, so three of them reach the fourth
level. With panic_on_warn, that takes the machine down.

Keep the -EBUSY and drop the warning, as commit 3880cdbed1c4 ("bpf: Fix
WARN() in get_bpf_raw_tp_regs") did for the raw tracepoint regs slots.

Signed-off-by: Mike Bazov <mike.bazov@gmail.com>
---
 kernel/trace/bpf_trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index b4ff9d4e8..8910d5d05 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -702,7 +702,7 @@ BPF_CALL_5(bpf_perf_event_output, struct pt_regs *, regs, struct bpf_map *, map,
 	sds = this_cpu_ptr(&bpf_trace_sds);
 	nest_level = this_cpu_inc_return(bpf_trace_nest_level);
 
-	if (WARN_ON_ONCE(nest_level > ARRAY_SIZE(sds->sds))) {
+	if (nest_level > ARRAY_SIZE(sds->sds)) {
 		err = -EBUSY;
 		goto out;
 	}

-- 
2.43.0


