Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794233315;
	b=qNKyJFTXwOydcDihNtc9iBGC/H6e1a+oIuZT3DHEKS9nnMe1t5pNMBohft/J2mOLXNfe
	 m9eHugqEnXJhiK7tjXtD0DMiC6l646WHsAyD6J7cobhqRIL3ZGzgsj8mpzfa5m7mobUzF
	 RbwytrUqt10kqheSZ9lt2fEHrDcgSuMkYijMG/5kNxAcmRxEARTyhDqJvlTtf4u2JPkHf
	 UK26aP+KKwtLyYKFLlLgYnstKvYYWT1Vr5XizaCySh80UqzbCpxl6HFRT155JGk7RChrQ
	 GD4e6QmNLNe3cUE0BgNkyO6OBRqvq9JRt64ERkmkLHDQVBjHAbLp+Qve3JhyRZIubuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794233315;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4ctbnQijEDADeE+VeOyBE3qsRBaizRl+Lj+tpaXR/Lw=;
	b=D8gS2Y9VB0mphPzjGNDA3R7eIoUH2SsJmAhWjm+jxAG54by8qUP803rhCYaKXutFKpkA
	 iLI4wV4O1zuw65W1r53nre/2r+4dOwy7hngYo/NcMMamFokfW5QJMb+2o5xmnIohoIMBH
	 4YdeQWSg2MSTJkLp5rwXK+sBv1BIPitv5gt0xJX452ak9V3w/0A3lUT72oz6rLgAhZcRe
	 ZTxUuh1Ybbj9f1fQPTVYE3/V0hZMC1vofvLN655e1oNSjIeKG9SpLxeuCOM5TA4j3dmwy
	 o69sc68meMuH0ZqMDcBvHRTm3r9GoinkiCQV44Le1LyLMqeGMbhsFXXpj7C+hK+sn3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SET7DTm+;
	arc=none smtp.remote-ip=95.215.58.43
Received: from mta1.migadu.com (out-43.mta1.migadu.com [95.215.58.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2654606A33E
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 14:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2654606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SET7DTm+
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=A5eN9JlEGsLm98Wb+lpZGaqPPk4WtO9xxuhn4MtM0Do=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794233312; v=1; x=1794838112;
 b=SET7DTm+wKerpYU0Pcez6IpcKmnlu3Mibq9xPkl30SNC2ZLwIIohPzLwyP/qR9wskypKXQaF
 p5u9IT7nwKe+RIp3ep2SBDrC7hD5X5tQxF383UKzHSa2yYGnvaUicGI1qQYVmBDHXdj7CGn9t/F
 2gXPoyZ+u+twFQDwW8Ik/vRI=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d9e2c428578da33f;
	Mon, 09 Nov 2026 14:08:32 +0000
X-Mizu-Trace-ID: d9e2c428578da33f
X-Migadu-Flow: FLOW_OUT
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <matt@bobrowski.net>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next 1/9] bpf: Add log support for tracing link_create
Date: Mon,  9 Nov 2026 22:08:08 +0800
Message-ID: <20261109140816.5196-2-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261109140816.5196-1-leon.hwang@linux.dev>
References: <20261109140816.5196-1-leon.hwang@linux.dev>
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

Tracing BPF_LINK_CREATE returns an error without explaining why attachment
failed.

Pass the BPF_LINK_CREATE log to the tracing attach path and report invalid
attach parameters. Also pass it to bpf_check_attach_target() so freplace
attachment to a new target can report target-check failures.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/syscall.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 9004f2673ccf..6147d386b777 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3674,7 +3674,8 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 				   int tgt_prog_fd,
 				   u32 btf_id,
 				   u64 bpf_cookie,
-				   enum bpf_attach_type attach_type)
+				   enum bpf_attach_type attach_type,
+				   struct bpf_verifier_log *log)
 {
 	struct bpf_link_primer link_primer;
 	struct bpf_prog *tgt_prog = NULL;
@@ -3711,6 +3712,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 	}
 
 	if (!!tgt_prog_fd != !!btf_id) {
+		bpf_log(log, "tgt_prog_fd and btf_id must be both set or both unset.\n");
 		err = -EINVAL;
 		goto out_put_prog;
 	}
@@ -3723,12 +3725,14 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		 * attach_tracing_prog flag is set.
 		 */
 		if (prog->type != BPF_PROG_TYPE_EXT) {
+			bpf_log(log, "tgt_prog_fd is only allowed for freplace prog.\n");
 			err = -EINVAL;
 			goto out_put_prog;
 		}
 
 		tgt_prog = bpf_prog_get(tgt_prog_fd);
 		if (IS_ERR(tgt_prog)) {
+			bpf_log(log, "Invalid tgt_prog_fd.\n");
 			err = PTR_ERR(tgt_prog);
 			tgt_prog = NULL;
 			goto out_put_prog;
@@ -3783,11 +3787,13 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		 */
 		if (prog->type != BPF_PROG_TYPE_TRACING &&
 		    prog->type != BPF_PROG_TYPE_LSM) {
+			bpf_log(log, "Only allow re-attach for tracing and lsm progs.\n");
 			err = -EINVAL;
 			goto out_unlock;
 		}
 		/* We can allow re-attach only if we have valid attach_btf. */
 		if (!prog->aux->attach_btf) {
+			bpf_log(log, "Invalid attach_btf.\n");
 			err = -EINVAL;
 			goto out_unlock;
 		}
@@ -3803,7 +3809,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		 */
 		struct bpf_attach_target_info tgt_info = {};
 
-		err = bpf_check_attach_target(NULL, prog, tgt_prog, btf_id,
+		err = bpf_check_attach_target(log, prog, tgt_prog, btf_id,
 					      &tgt_info);
 		if (err)
 			goto out_unlock;
@@ -3843,6 +3849,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 	 */
 	if (prog->type == BPF_PROG_TYPE_EXT &&
 	    prog->aux->kprobe_write_ctx != tgt_prog->aux->kprobe_write_ctx) {
+		bpf_log(log, "Invalid kprobe_write_ctx.\n");
 		err = -EINVAL;
 		goto out_unlock;
 	}
@@ -4374,7 +4381,7 @@ static int bpf_raw_tp_link_attach(struct bpf_prog *prog,
 			tp_name = prog->aux->attach_func_name;
 			break;
 		}
-		return bpf_tracing_prog_attach(prog, 0, 0, 0, attach_type);
+		return bpf_tracing_prog_attach(prog, 0, 0, 0, attach_type, NULL);
 	case BPF_PROG_TYPE_RAW_TRACEPOINT:
 	case BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE:
 		if (strncpy_from_user(buf, user_tp_name, sizeof(buf) - 1) < 0)
@@ -5907,11 +5914,13 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_common_a
 					      attr->link_create.target_fd,
 					      attr->link_create.target_btf_id,
 					      attr->link_create.tracing.cookie,
-					      attr->link_create.attach_type);
+					      attr->link_create.attach_type,
+					      log);
 		break;
 	case BPF_PROG_TYPE_LSM:
 	case BPF_PROG_TYPE_TRACING:
 		if (attr->link_create.attach_type != prog->expected_attach_type) {
+			bpf_log(log, "Invalid attach_type.\n");
 			ret = -EINVAL;
 			goto out;
 		}
@@ -5929,7 +5938,8 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_common_a
 						      attr->link_create.target_fd,
 						      attr->link_create.target_btf_id,
 						      attr->link_create.tracing.cookie,
-						      attr->link_create.attach_type);
+						      attr->link_create.attach_type,
+						      log);
 		break;
 	case BPF_PROG_TYPE_FLOW_DISSECTOR:
 	case BPF_PROG_TYPE_SK_LOOKUP:
-- 
2.55.0

