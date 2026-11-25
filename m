Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577413;
	b=bO92wCgiloGkEBXZRxkbGosHBH8TJa0eB8zsWQIKrOEyCRpIHI9aLff1+XgVSJq9+W/+
	 XtwjCQ23iBDLuC/2dUHwyun2EfcWiGgprCLZyBPQ8K5Vep0ipRsQCkvKHvx1mBKkokFoC
	 q8a69eRfRcXP56yG8Uy8xxGJr+ARuo2A/T9EATFmDrg1azYF4+qsjDixnwwCHmw79PFbF
	 6YHGyzqwvv8QgsuZ/OnIVyTGidyuzKoOa0kpaKJS2h3i5dcSUg/kHTgWiOLO5PoD+7eUS
	 OJ1RXno3V88/cd+119MqgQ24GCIywTh+gzmCibGSvQH3WyBFJG2VlHlPmc4X+q1Ml+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577413;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ghMIExylkE1cDWv7u9uhdjDVP9G28CeK7U4nSfJjQj4=;
	b=SoRyg+dHK2sy7Fw+kcxvnetIUG3I3fZI8QvEjpGakhpDCZzQe2TtISEoVbSkAkX/jBvi
	 fZzn4dS4LJuq/LQW6+j/t07esZjIpmULX3um5w2kritiF0HZRsNaUHZ5Op+/5A2dvU5Il
	 26oAY9nmMtx/kZggwPw0oW8dywo3PM3CsyOKtpbBs9FzoK6DbWubiOdxErTnS6dvbMMt+
	 HQCJIrTqMcLOx82IIzca3eHx25PbbsZhNrfEZylKg1BSp5RkSjadjRaiIQw/f4otL0jBq
	 Bso6s2Uci3TpdbFp1BTi6zc+lymShHqE+PnfbEZlPVEecmQGAPPOiZ7L5D75F1fFnaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zC4Djt3+;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303A5606A321
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:30:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 303A5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zC4Djt3+
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b3a914e4c8so2817187a91.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577412; x=1796182212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ghMIExylkE1cDWv7u9uhdjDVP9G28CeK7U4nSfJjQj4=;
        b=zC4Djt3+fov8Yr5IcBdKXPie0PkmtSD6W6gYUp7O5yLAAySrMysOSyxxwwpRJ6VvVl
         kXe/ERsoOTPKkxJz3r8kNxsC+6BTP/qYajgfamqQGehceamMGCcsj6jUr4DFbKWatJfE
         FCbIg7V9Fv9gOQS3EzlQgUR1gZhShati+YgxE2wIajoRxRfk9LstluSdwV4K1pcWe6Lu
         ncEADfr+07+7T4Q9Qa6fFmslG8GpIKl53GsI/02C2qyCmgmR0KDNEIEFS3zGFFgV0dKv
         KsFxtpKhgYN42mXEYlqLcoEcFQCfhUnlLf7n95txmQxTOt+iqViy7+rlOWYoRyL6MUPq
         DxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577412; x=1796182212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ghMIExylkE1cDWv7u9uhdjDVP9G28CeK7U4nSfJjQj4=;
        b=B7iH/CMdh6uHU67sLq7tyzVMtOEcUEQkCpF8QyYyYtGvgocV4O3cSg1OndFFSX/XqX
         EHH0oeey1yoEQIs9YtkdTdnegVGS8oKbD0Dyrjo4/5oH2HzvtcqR9o3W1LAdA/KgXYsB
         ACQDNzZhg/MH3RTAZQ5g64vwtX5Ub8WWTfVkyX2PBVmA58BW1sBoUnBvZt5+VxgxcHva
         mP1RLynFCrY6QZGlhohRonOnnEj45SwUpXa7vgCCFIOY8d+LgMavCjEYJIlRmqdx2FzX
         X81fUPtaKCYoKFaruAtUK85NdRSRmmsYRonLWpxdxhXBABWGBzvLqzHkREuZd3Dci6Lh
         YnXg==
X-Gm-Message-State: APuU4Z/qGy71di3aK6A3ykbH7WitSW/SNuu2Ta8TL6eDVrkGBzyMWy0O
	Kx3u6ooNhJu14JbJfp41u0gfXdeHT75W479CtH2gmVb8IBYdLzhc65O3ew3BXrIQ
X-Gm-Gg: AZFdTZc/I+puG3MXJKWTZsxjo4vhVtgOk8EbG/An0v76GVsbd9rhRNYUStIVsGbGo+Q
	vomgjPbC25sMWmUK1PFNY08qIElqouLNKiZatrEDhJHexRkGuiFvaNyRftBPfaL3YJXTQZwih2i
	9FXrPl4lfwxRjghN6qOxBRHWkb4vViTfqCvjPUz5QJMPGL9H/w5IXNkjdoe8vOVRPyGbJmERXUM
	mgHKNuHZyw9SM5Yx0EyWk4Kj7V+6XbfOHL/nOwqYCZ2CFhg3uLJUz3k/oKNBLrvpD29KwrnR30X
	fFreNRK8KB+UCym/yo+4qMgz+Obyx2laa6c8TWy4pNpJrGaRffFI3b+xKa44J1cZoFPtaqw+vhN
	OJqp1j7EF/+Vut8LQGTQ784pvbBxhmzC9PnUZrMTNv6ffWAVIMQf1rxiFjh+5sYjLrSph8C0xh1
	x0KDTiAhGonsuNiCal07BPR82PfNS5F32E5B0yBGK5695qQytiRgWWS6PD7pn4kdmQQHsMASoJ8
	FcT+sZ1c2JQ0KFD5P04aH2QNXjT2XLj0yz/h4p1KhUBkbA0jmXGJpf7tbVWzJGtXX2fc0MFEEQt
	3dFMWKGOZROA+2c8guUO92Zu4a6VHtIdkGkwPBphlAfiLyjQXcFB8FTbWEPyT4oo7lWXnVRr19u
	JMvBmUBqI75DeKAMDfHiwqE+RgYixy2rYsBxc5+1JBRXL2Owd4ne5ZPDcMLTrwi0trR8F40vNUg
	==
X-Received: by 2002:a17:90b:4a48:b0:3b3:b5b4:e4a9 with SMTP id 98e67ed59e1d1-3b41c7ac07amr15544140a91.3.1795577411978;
        Tue, 24 Nov 2026 19:30:11 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b495035339sm12515213a91.0.2026.11.24.19.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:30:11 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 05/47] bpf: Check that an extension fits the hook of its target
Date: Wed, 25 Nov 2026 03:28:56 +0000
Message-ID: <20261125032938.670542-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
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

An extension runs in the hook of its target, and the checks for the hook
do not see it.

Tracing, LSM and struct_ops programs are checked against the BTF of
their hook. An extension takes the type of its target, but it has no
attach_btf and no st_ops, and attach_btf_id and the prototype are those
of the function that it replaces:

- tp_btf: it can read more arguments than the tracepoint has.
- LSM: the range of bpf_get_retval() and bpf_set_retval(), and the
  helpers that only some hooks have, are looked up by a wrong id.
- tp_btf and struct_ops: the load can oops.

fentry, fexit, fsession and iterators cannot be extended already. Refuse
the rest. freplace of global functions of tp_btf, fmod_ret and LSM
programs goes away. Targets of other types load with any
expected_attach_type. Do not take their extension for tp_btf or for an
iterator.

Some properties of a program are looked at when it is attached or run.
Nobody looks at those of an extension:

- bpf_get_local_storage() returns the storage of the attached program,
  the extension is verified against its own map.
- bpf_override_return() needs a function that allows error injection.
- skb->cb is saved, cleared and restored only for programs that access
  it.

Ask for the storage map of the target, at load and at attach. Refuse the
attach when the target does not call bpf_override_return() itself, or
does not access skb->cb. A tail call counts as an access to skb->cb.

Fixes: be8704ff07d2 ("bpf: Introduce dynamic program extensions")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/syscall.c  | 18 ++++++++++++++++++
 kernel/bpf/verifier.c | 38 +++++++++++++++++++++++++-------------
 2 files changed, 43 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 48ed0944f31d..3f2bc772e297 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3847,6 +3847,24 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		err = -EINVAL;
 		goto out_unlock;
 	}
+	/* Where the return can be overridden is checked for the target only */
+	if (prog->type == BPF_PROG_TYPE_EXT &&
+	    prog->kprobe_override && !tgt_prog->kprobe_override) {
+		err = -EINVAL;
+		goto out_unlock;
+	}
+	/* bpf_prog_run_save_cb() and bpf_prog_run_clear_cb() look at the target only */
+	if (prog->type == BPF_PROG_TYPE_EXT &&
+	    (tgt_prog->type == BPF_PROG_TYPE_SOCKET_FILTER ||
+	     tgt_prog->type == BPF_PROG_TYPE_CGROUP_SKB ||
+	     tgt_prog->type == BPF_PROG_TYPE_LWT_IN ||
+	     tgt_prog->type == BPF_PROG_TYPE_LWT_OUT ||
+	     tgt_prog->type == BPF_PROG_TYPE_LWT_XMIT ||
+	     tgt_prog->type == BPF_PROG_TYPE_LWT_SEG6LOCAL) &&
+	    prog->cb_access && !tgt_prog->cb_access) {
+		err = -EINVAL;
+		goto out_unlock;
+	}
 	/*
 	 * The size of these contexts depends on what the program is attached
 	 * to, or run with. That is compared with max_ctx_offset of the program,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 311c9f19b781..4cc9a210cb25 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22675,6 +22675,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 	}
 	if (tgt_prog) {
 		struct bpf_prog_aux *aux = tgt_prog->aux;
+		enum bpf_cgroup_storage_type stype;
 		bool tgt_changes_pkt_data;
 		bool tgt_might_sleep;
 		bool tgt_can_unwind;
@@ -22729,6 +22730,16 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 					"Extension programs should be JITed\n");
 				return -EINVAL;
 			}
+			/* bpf_get_local_storage() returns the storage of the target */
+			for_each_cgroup_storage_type(stype) {
+				struct bpf_map *storage = prog->aux->cgroup_storage[stype];
+
+				if (storage && storage != aux->cgroup_storage[stype]) {
+					bpf_log(log,
+						"Extension program has another cgroup storage than original\n");
+					return -EINVAL;
+				}
+			}
 			/*
 			 * How much of the buffer of the tracepoint is used
 			 * is checked for the program that is attached to it.
@@ -22793,16 +22804,14 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			bpf_log(log, "Cannot recursively attach\n");
 			return -EINVAL;
 		}
-		if (tgt_prog->type == BPF_PROG_TYPE_TRACING &&
-		    prog_extension &&
-		    (tgt_prog->expected_attach_type == BPF_TRACE_FENTRY ||
-		     tgt_prog->expected_attach_type == BPF_TRACE_FEXIT ||
-		     tgt_prog->expected_attach_type == BPF_TRACE_FENTRY_MULTI ||
-		     tgt_prog->expected_attach_type == BPF_TRACE_FEXIT_MULTI ||
-		     tgt_prog->expected_attach_type == BPF_TRACE_FSESSION ||
-		     tgt_prog->expected_attach_type == BPF_TRACE_FSESSION_MULTI)) {
-			/* Program extensions can extend all program types
-			 * except fentry/fexit. The reason is the following.
+		if (prog_extension &&
+		    (tgt_prog->type == BPF_PROG_TYPE_TRACING ||
+		     tgt_prog->type == BPF_PROG_TYPE_LSM ||
+		     tgt_prog->type == BPF_PROG_TYPE_STRUCT_OPS)) {
+			/*
+			 * These types are checked against the BTF of their hook,
+			 * and an extension has the BTF of its target instead.
+			 * There is one more reason for fentry/fexit.
 			 * The fentry/fexit programs are used for performance
 			 * analysis, stats and can be attached to any program
 			 * type. When extension program is replacing XDP function
@@ -22815,7 +22824,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			 * beyond reasonable stack size. Hence extending fentry
 			 * is not allowed.
 			 */
-			bpf_log(log, "Cannot extend fentry/fexit/fsession\n");
+			bpf_log(log, "Cannot extend tracing, LSM and struct_ops programs\n");
 			return -EINVAL;
 		}
 	} else {
@@ -23163,10 +23172,13 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 		prog->aux->saved_dst_attach_type = tgt_prog->expected_attach_type;
 	}
 
-	if (prog->expected_attach_type == BPF_TRACE_RAW_TP) {
+	/* An extension has expected_attach_type of its target, it can be any value */
+	if (prog->type != BPF_PROG_TYPE_EXT &&
+	    prog->expected_attach_type == BPF_TRACE_RAW_TP) {
 		prog->aux->attach_btf_trace = true;
 		return 0;
-	} else if (prog->expected_attach_type == BPF_TRACE_ITER) {
+	} else if (prog->type != BPF_PROG_TYPE_EXT &&
+		   prog->expected_attach_type == BPF_TRACE_ITER) {
 		return bpf_iter_prog_supported(prog);
 	}
 
-- 
2.55.0

