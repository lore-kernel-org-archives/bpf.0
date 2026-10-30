Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793361140;
	b=FjqBx3Crx/EbeS6aRYuCm1dREp1NPyZIdDob/jyPgtayvMv6g/lNWJ83iUV7LwBFh3H1
	 J3Mi39d+fLaZOjlzUzv6kDzDIeUQnnLQnDW5E+hNldfQlVh6IzBs/+3djGziI6VGTBjFr
	 mZfuHwCbKMV27MSu+p6EEmCovHJExfr20yobK3mOtIO05byNMrtZZ2986oreSHTN8gDcO
	 eoXN0UQyhV2P60zp/peXgDtJS7k5aRZqoI4fAJXPQ0GI9zBAhLkUUrmtTGmbIcdaKy/KB
	 Y9TZIsKaEX9K59g4YgNO/ojj6dM/16RN7pSXacAmGLGPlbP/bg66uCnqUELsLjx/63Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361140;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=XQ0a+7u9U1RFs/mmsVQHoY0XRft/b4eo3p4kUeyDfL8=;
	b=4997QoPjoUm91aBwmdEKcX0DlBtYZr+bJRepixgmB07DXZ77nVU7YtCJm8mGZI1+Lq3m
	 7lRQiK0BnGJCXp341lo5WQ0UyRM48mNMbYKkS6aMP8yqyJbXSpXYSKaM0nYsIV5Hn2+sX
	 6EArL/vRQcfmLo2FK2Rp4Q3XuA8IfIzoXtph3AfopjmfwQDcYZ4Wn5cCvyluiEiTq0BBF
	 ZeVS3isV8y/GLmOZVsM5OlZmvfCQgEp5Jq1wlD7l8yQbD6VCQqhiDtmQwZ+XQzi52MiQZ
	 rKU8ke6x5eQyMQkW6Zmfup+QJELwc+yBXZ8iInsxboeH+IHG6/CZXEolLF8e2bdAmXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=phrPGDVz;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715CF606A325
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 11:52:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 715CF606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=phrPGDVz
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-14394530ec6so781194c88.1
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 04:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793361139; x=1793965939; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XQ0a+7u9U1RFs/mmsVQHoY0XRft/b4eo3p4kUeyDfL8=;
        b=phrPGDVz3zTHsi28oL2AlGzlQyQVf81b9hEZRxqp9GmsLbXIU+fIvkO55hYJjEw9LM
         Z7PXMnFrDDzZe65XHUuc/pC6ZHafNvLxyY7mWfXlzIHTxnSwDVppkUdAJ6queJuxKKCu
         jnh5Lzfn+eJtewx3TtepulRHpxMKWMYHegnAVMnwR1S4COdeDWKALheKq5+HFGiwN+8M
         uui0T+7rUUwNzDmjHg0vODwdF5zyWvv2AZnw7N1jkkbtf86oR5ugFB2rWUT6/YTHxfNW
         95Dx+zBbhqQ/StFgFWDma8EXRN/64g0HCvDiKDd9Tu1yBMnjEhi2xwhb8hCRx37cXamf
         IF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793361139; x=1793965939;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XQ0a+7u9U1RFs/mmsVQHoY0XRft/b4eo3p4kUeyDfL8=;
        b=VA3MyHfJTfbTsDEOUqwzBb8SQDcic+cw0+hnfm82Mcrm5F619P617HsJhWz67AAIEa
         zWc4qfEuejj9srju/Q3/WFFAqlJWDQ7SsFmGx2lBWe9T53mkWTj2IlBDY4a6I3r9WN1m
         Z5ggCQgMT60Bmz5lghxIBpwLOIf8s7oMTR7mDVaXi5ycAjLWTmaE5HjuJSBq3t19Vg4x
         3/vc5rMg9FznijTXVC4EIg4E+pPMvHr5bgB5yXu/vxBBOFbjxLRBakz9+GNc97W6h8KF
         BWYro09+Vcq74URXntb8J8y8sVUjZTS72/XbPcAqoAhH1OA/6D2DrCCHdrXQp9lG4L1b
         mnlQ==
X-Gm-Message-State: AFq9FYIN9F+rASGoj62r1KFBBM9hhogp21Ax9wlBYTtj3uAM5DVZPS95
	00OkrFe8py9LcpDm0CjA+H+6GZ8fngmC9EllCi4Fm+bOgc1+fz/3aswg
X-Gm-Gg: AYBFou2i4K/dM6ZhwAeYBoJb739Ibqs0N2Du8oR7/bjWGNBfxjKKRr86TtsZOmKVjAW
	9nBpaQy8fGpjnSdJF0RZLAoVng8FiK+OWD5F7emeOn7+uRyctMQCeXIE+vBYc9Lgb7ruUaEz7O7
	pZeV5n8PbOQgeOqnM8SIE2XlNdvlrmNiwWwaIhEuF9gvcD6joi8b6DtQnIaw8TyXfUAJatnaoRo
	wmWMuQUYQQgEtF/k8cxiz3x6rWATmSL5++MP2GdeVVoTSa7q5j6WWNpmDqZmrIfpv/j/IAtuThR
	ZqfuOB+d5AtSUFdc4YDAhqGBAAFUdbUEBT70vNrIglV244zFbFJhkoba3QXP5TqkHW7UeshPDPX
	Zk/myKC0/tLsgMAKGX60K7TPpZg50E2jDJQNTOaZq5jCYYqH8b9600ZG9ZBSAhxY9T3f+sVFPuk
	pLKFjTmwmWkngkKqKwOJI00EJc8H7hhv5sqayykQEyPXs6nn6leKF6oWrPVT2CMP0DR/6Fy5jlP
	xGPHntkMMnPyLa61GXLo9zv6lzHbGMdGN46NjxP360RTNgv/x623itV7t9hCW3a3VNp1NB7oMrG
	kRJy/+QWXWma0SahOzYdbdkj
X-Received: by 2002:a05:7022:b048:10b0:165:55e2:2d69 with SMTP id a92af1059eb24-1ac605a6ef1mr3124392c88.46.1793361139399;
        Fri, 30 Oct 2026 04:52:19 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1abcd6f1sm6437304c88.20.2026.10.30.04.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 04:52:19 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Fri, 30 Oct 2026 07:51:49 -0400
Subject: [PATCH bpf-next v2 04/22] bpf: Queue the rewrites of
 bpf_do_misc_fixups()
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-bpf-verifier-patch-batch-v2-4-55cd43439f7c@gmail.com>
References: <20261030-bpf-verifier-patch-batch-v2-0-55cd43439f7c@gmail.com>
In-Reply-To: <20261030-bpf-verifier-patch-batch-v2-0-55cd43439f7c@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

Each rewrite in the main loop of bpf_do_misc_fixups() patches the
program right away with bpf_patch_insn_data().

Every rewrite moves the tail of the program and walks all of it, which
costs O(prog->len) each time.

Queue the rewrites with bpf_patch_list_add() and commit them once the
loop is done, before the stack of subprogs is initialized for may_goto.
Walk the unpatched program, so that delta stays 0, and derive insn
from the index at the end of each iteration, so that a rewrite that
fixes up a helper call after queueing it can go on to patch_call_imm
with insn pointing to the queued copy.

perf stat -r30 -- veristat -q <obj>, average of two runs, x86_64 VM
with 32 vCPUs, before and after this patch:

              before     after
  pyperf180   0.507 s    0.348 s
  pyperf600   1.406 s    0.887 s

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 kernel/bpf/fixups.c | 239 +++++++++++++++++-----------------------------------
 1 file changed, 75 insertions(+), 164 deletions(-)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index a0dd582312d86..c9963d8d81356 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -2042,14 +2042,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 		if (env->insn_aux_data[i + delta].arena_scalar) {
 			cnt = arena_scalar_access(insn, insn_buf);
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta += cnt - 1;
-			prog = new_prog;
-			env->prog = prog;
-			insn = prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i + delta, insn_buf, cnt);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			goto next_insn;
 		}
 
@@ -2072,13 +2067,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 
 			cnt = patch - insn_buf;
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i + delta, insn_buf, cnt);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			goto next_insn;
 		}
 
@@ -2163,13 +2154,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 				cnt = patch - insn_buf;
 			}
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i + delta, insn_buf, cnt);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			goto next_insn;
 		}
 
@@ -2193,13 +2180,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			*patch++ = BPF_MOV64_IMM(insn->dst_reg, 0);
 
 			cnt = patch - insn_buf;
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i + delta, insn_buf, cnt);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			goto next_insn;
 		}
 
@@ -2213,13 +2196,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 				return -EFAULT;
 			}
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i + delta, insn_buf, cnt);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			goto next_insn;
 		}
 
@@ -2266,13 +2245,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 				*patch++ = BPF_ALU64_IMM(BPF_MUL, off_reg, -1);
 			cnt = patch - insn_buf;
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i + delta, insn_buf, cnt);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			goto next_insn;
 		}
 
@@ -2309,13 +2284,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			cnt = may_goto_expand(insn_buf, insn->off, stack_off_cnt,
 					      tail, ARRAY_SIZE(tail));
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta += cnt - 1;
-			env->prog = prog = new_prog;
-			insn = new_prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i + delta, insn_buf, cnt);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			goto next_insn;
 		} else if (bpf_is_may_goto_insn(insn)) {
 			int stack_off = -stack_depth - 8;
@@ -2328,13 +2299,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			cnt = may_goto_expand(insn_buf, insn->off, stack_off,
 					      tail, ARRAY_SIZE(tail));
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta += cnt - 1;
-			env->prog = prog = new_prog;
-			insn = new_prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i + delta, insn_buf, cnt);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			goto next_insn;
 		}
 
@@ -2365,13 +2332,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			cnt = 2;
 
 			i++;
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i + delta, insn_buf, cnt);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			goto next_insn;
 		}
 
@@ -2386,13 +2349,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			if (cnt == 0)
 				goto next_insn;
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta	 += cnt - 1;
-			env->prog = prog = new_prog;
-			insn	  = new_prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i + delta, insn_buf, cnt);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			goto next_insn;
 		}
 
@@ -2477,13 +2436,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 								 map)->index_mask);
 			insn_buf[2] = *insn;
 			cnt = 3;
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i + delta, insn_buf, cnt);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			goto next_insn;
 		}
 
@@ -2511,13 +2466,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			insn_buf[2] = *insn;
 			cnt = 3;
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i + delta, insn_buf, cnt);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			goto patch_call_imm;
 		}
 
@@ -2530,13 +2481,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			insn_buf[1] = *insn;
 			cnt = 2;
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta += cnt - 1;
-			env->prog = prog = new_prog;
-			insn = new_prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i + delta, insn_buf, cnt);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			goto patch_call_imm;
 		}
 
@@ -2573,14 +2520,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 				if (bpf_map_is_percpu_map(map_ptr->map_type))
 					prog->jit_required = true;
 
-				new_prog = bpf_patch_insn_data(env, i + delta,
-							       insn_buf, cnt);
-				if (!new_prog)
-					return -ENOMEM;
-
-				delta    += cnt - 1;
-				env->prog = prog = new_prog;
-				insn      = new_prog->insnsi + i + delta;
+				insn = bpf_patch_list_add(env, i + delta, insn_buf, cnt);
+				if (IS_ERR(insn))
+					return PTR_ERR(insn);
 				goto next_insn;
 			}
 
@@ -2656,14 +2598,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 						  BPF_REG_0, 0);
 			cnt = 3;
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
-						       cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i + delta, insn_buf, cnt);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			goto next_insn;
 		}
 
@@ -2686,13 +2623,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			insn_buf[0] = BPF_ALU32_REG(BPF_XOR, BPF_REG_0, BPF_REG_0);
 			cnt = 1;
 #endif
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i + delta, insn_buf, cnt);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			goto next_insn;
 		}
 
@@ -2705,13 +2638,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			insn_buf[2] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0);
 			cnt = 3;
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i + delta, insn_buf, cnt);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			goto next_insn;
 		}
 #endif
@@ -2739,13 +2668,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			insn_buf[cnt++] = BPF_JMP_A(1);
 			insn_buf[cnt++] = BPF_MOV64_IMM(BPF_REG_0, -EINVAL);
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i + delta, insn_buf, cnt);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			goto next_insn;
 		}
 
@@ -2771,13 +2696,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 				cnt = 1;
 			}
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i + delta, insn_buf, cnt);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			goto next_insn;
 		}
 
@@ -2797,13 +2718,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 				cnt = 2;
 			}
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i + delta, insn_buf, cnt);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			goto next_insn;
 		}
 
@@ -2813,12 +2730,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			/* Load IP address from ctx - 16 */
 			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -16);
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, 1);
-			if (!new_prog)
-				return -ENOMEM;
-
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i + delta, insn_buf, 1);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			goto next_insn;
 		}
 
@@ -2868,13 +2782,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			insn_buf[10] = BPF_MOV64_IMM(BPF_REG_0, -ENOENT);
 			cnt = 11;
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i + delta, insn_buf, cnt);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			goto next_insn;
 		}
 
@@ -2886,13 +2796,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			insn_buf[1] = BPF_ATOMIC_OP(BPF_DW, BPF_XCHG, BPF_REG_1, BPF_REG_0, 0);
 			cnt = 2;
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
+			insn = bpf_patch_list_add(env, i + delta, insn_buf, cnt);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
 			goto next_insn;
 		}
 patch_call_imm:
@@ -2923,9 +2829,14 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			stack_depth_extra = 0;
 		}
 		i++;
-		insn++;
+		insn = &prog->insnsi[i + delta];
 	}
 
+	ret = bpf_patch_list_commit(env);
+	if (ret)
+		return ret;
+	prog = env->prog;
+
 	env->prog->aux->stack_depth = subprogs[0].stack_depth;
 	for (i = 0; i < env->subprog_cnt; i++) {
 		int delta = bpf_jit_supports_timed_may_goto() ? 2 : 1;

-- 
2.43.0

