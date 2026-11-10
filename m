Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794270474;
	b=tyCeEzLcflwEburUd4WjIMbeqXkU/BTzBQZ5pWc1N6ZtJYFGdOY/hBzc4NOrm23sdnU9
	 DLUGE5b2N+aSNkb/j7eFBO8A9jEEJ9Pr8XGume8JVUJkie8I750EPdS+9gFdVTeAAewUC
	 deZLHIEcbpSG9CoC6AZ3CpbZGjkepAxBgxqdGhXWjt82/Uag1fRDqbs7sLOvzSKdSmOp1
	 mGHSQDEqXX7Vmm1yrHhIGbDc7FYss2lYjU3WzeK3OBlmdnyvQn2OI7YwvZctDIDagNz7H
	 beOJZAATUfTGB9hEbEo56l3rXv+EStZIcUv7k+347L80vQmXF0axwuLfnPe3gGPoVew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794270474;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=5Q/hdmTdYA6wF2W+UgC4zl71tt4/Sso8sab2ZkHMxAM=;
	b=HYVXiL4/coDEBBGl1Y7oCdl9zMtybvaQj1Dv7vHwRiCLTve/UX3oNP5Y6/QlK9pORQVA
	 bzvBQ2u9YuNHMSCYkoO7NOQw2zd13k9wPm5zpyr/Hgdreyrh02VDcMMEIQDpMY71sLHnb
	 /2VdKTVXevUag77jny43bbunQo5OkAGN/SmqwYfzN8RJ8gOf7ZGtzdaxBknDwnl4P/loq
	 A2BQ5R3lAPiTFl6AqD2o6tHUvz+PMhXxnlXk4lrk36TL8JoSD99d+vwsWvaCi6xJipGtK
	 1ar0ezYDCXGQ2bbWdCCLhZevLcCEuZTwikQx/nwBdTvygweSx72acJ0nyR0aLT7u19w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m+0JInoh;
	arc=none smtp.remote-ip=74.125.225.138
Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB145606A31C
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 00:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB145606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m+0JInoh
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49ff9833fedso4328455e9.0
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 16:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794270472; x=1794875272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Q/hdmTdYA6wF2W+UgC4zl71tt4/Sso8sab2ZkHMxAM=;
        b=m+0JInohRLCw3NZvlc/g5gkhPuxZwQeeHgfMUYP1j26Fxo5S+DF64mPMcbPfZRynbG
         ZUD92suV0oqevrtJvSR4Nba7e8bXY8Wjeyd/zU7xRCPrqf1nHFIv7s/BssDiqfpDOyd3
         M6JSDIEIgYof1062dkEpuA0iNuM/C42TWm1Smk6ZbenJ2bWP7TPTabZFVuwQXibPM8wE
         EgL6zjr7NkksZ15Nf5z39qwl6lKIyabVA0GswpWQi2e5S3g8bQR3zZH3GkVmlM2SIk04
         GUk5Siw8Rw9vtGXKAwR+TyUSVoERdyy8eMnEVgTy+QZZfJYBwoQGzNoaMgEJxOKOre1I
         ccpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794270472; x=1794875272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5Q/hdmTdYA6wF2W+UgC4zl71tt4/Sso8sab2ZkHMxAM=;
        b=W3keEE+mPwFSyXRe5xFdvnnWSaBUVlQP3lbsn6BKooDnLS0R4sROEKtAW0BITREE4D
         YBzbJppdX/Lok36VHsVxyt57L1kxe6k5KhUk6DfwXjNnC+Dhp/uSvgawWsofuHESXLmx
         FI0owx2JMC+XOVqgHP4DAcs+/ScXYR+TZTqzBq2bL42GiHAXOrTBsh8DWFTM4gwCZ3F1
         lHJ+SMj+jFd78lRKLKkHXBzrrNo80SUtKc5If1OslIp0xc1/EHwX+a/FUv5KZXbZHTu7
         kz/omj7vxkpzFmBE+nlW5BPpCeeABu1pWNallklW0ld8jJVQ+LrJaTdC78c8BD8XyIry
         r9cQ==
X-Gm-Message-State: APuU4Z+ATfhuOHgqHO4MbOC7QWTAat1g88eMBtBUcvcfL/t9wZPrIUkU
	ITAb9eAMzApSGC5g8sFt1Rchk5yWRh9uScP6M69PRg6QBuaQAPSPAn8jic9S/gKH
X-Gm-Gg: AYBFou22Cd52PG2Hdp7kV8tKynT7NUYuthZZcdlAlzdoyIGM8ZUti8Dxus4M2EIXYNT
	uxdoZRTECfRecvGtGNL+4pEp9FwYtodgJSZ5NlZwpzpe/xI0jaMLjz56mg+6XEqwvFUUN5u6SJu
	WMppK5LvtMGdxKwU0+uIWEx088T2GVsA4DRt0JCbO4VxwRmV4BbdEJTNzRra4hd2ycWE9Vc7OSN
	kRifGzjH6uLYj//IdoOjUd8z/Tm+GUVPuH6jvgJYpBRp+QyaPA1501bEgfmHvRYsRdghiR4lex0
	Zn5I3Ss+huYrDLpM02MPFatXi+9QMPDwVM5pDej7Zb27LlrsBilu6BMLrWRlUXP6Kz5XQfzGmnW
	kvcBpeTDkEKPdvPA3JEfohNtYH8Ar4fB2KSj00Vgw+V1uANitCul6zJx9q7GgXGQCY4H2DsZlr8
	aJYnUjFgsPITnPWD/CctNcWchAe3GYSGFMgf1LDXptoStkM1+Kp1OVTJGzvX0Ezk1siwOOLi/+p
	L2oGn8fEHeALRMqvGE3CsdGAOC2RA+CnZ/wt/BcIyccWNj27kFlbbryyTHE9yk0uTUm/TgjfXDc
	eUtYpVKE5hkwy8eRVOy8KNKeu8i0jxswexMwe8WKGErKX7QVea5YGwXmY9fHG7VuX7WZS8Nsfms
	qjWn8Vy/hBCZbvZliswfH6vdHi/3hU4H6f3BIJqBTpSEeW3iz12V7kUfdwN0Hopokh7D2
X-Received: by 2002:a05:600c:3143:b0:4a1:78c5:79f5 with SMTP id 5b1f17b1804b1-4ba02355f49mr11060035e9.33.1794270472166;
        Mon, 09 Nov 2026 16:27:52 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fef675sm23405435e9.14.2026.11.09.16.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 16:27:51 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 03/20] bpf: Refuse bpf_task_park() in callbacks
Date: Tue, 10 Nov 2026 01:27:25 +0100
Message-ID: <d7e8470a75a3ff4b2e65066f6ba6edb4e5bc14ef.1794269506.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794269506.git.memxor@gmail.com>
References: <cover.1794269506.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4654; i=memxor@gmail.com; h=from:subject:message-id; bh=7WWfPMW5x47sqCBB26VfpuvqPTCbXWDkhSBpoxjkWYk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetTokvDPd3OkJvrG/Z4Cvhl3Fp0kmnSoSVlN3d89r9xJ DxOXnBCRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACZy4BXDP+sgN9GHcfcSubpY FlmYql3tPSZQc+Tx+7BEI9FFdSsnfWJkaL0ov/Vl5Lyk6293H66eMbv/WK67XGWkyduNwszipyN LOAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Confine bpf_task_park() to the main body of the program and the
functions it calls directly, at any depth, and refuse it in every
callback frame: the synchronous callbacks of bpf_loop(),
bpf_for_each_map_elem(), bpf_find_vma(), bpf_user_ringbuf_drain() and
the graph helpers, the asynchronous callbacks of bpf_timer, bpf_wq,
bpf_task_work and bpf_call_rcu(), and the exception callback.

The park is sound where the only thing around the program is its
runner, which holds the program, its maps and its context for the whole
invocation. A callback has more around it. Kernel code called by the
program, or a worker acting on its behalf, holds state across the
callback that was not written with a sleep that drops the program's
protection in mind, and each case would need its own audit:

 - bpf_for_each_map_elem() keeps an iteration position into the map
   across the callback. The verifier already refuses sleeping in the
   hash map variant; nothing would refuse it in the array variant.
 - A bpf_wq callback runs from a kworker, and bpf_wq_work() holds the
   program through nothing but a Tasks Trace RCU read section, the very
   section the park drops. Today the free path survives only because
   bpf_async_cb_rcu_tasks_trace_free() notices work_busy() and waits for
   another grace period, which a park of unbounded length turns into an
   endless chain of grace periods after the element is deleted, and the
   comment there assumes the callback stays inside the section.
 - A bpf_task_work callback also runs from exit_task_work() for an
   exiting task, after exit_signals() has set PF_EXITING; from then on
   wants_signal() refuses every signal for it, so a park without a
   timeout in that callback could not be interrupted.
 - The exception callback runs while the program is being unwound after
   bpf_throw(); nothing in it should block.

Rather than audit and special-case each, the rule is that the park may
only appear where the program is the only thing running: the main body,
or a frame reached from it through plain calls. The check walks every
frame of the current state and refuses the call if any is a callback
frame. Asynchronous callbacks are verified as their own state with the
callback as frame 0, so the walk sees them too. A static function that
parks and is also used as a callback is rejected on the callback path,
which is the right outcome: it cannot be made safe on that path.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e90cc127aedb..b42782c7f209 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11222,6 +11222,31 @@ static void invalidate_non_owning_refs(struct bpf_verifier_env *env)
 	}));
 }
 
+/*
+ * bpf_task_park() is confined to the main body of the program and the
+ * functions it calls directly. A callback runs from kernel code that holds
+ * state of its own around the call, an iteration position, a work item or
+ * timer that owns the program only through Tasks Trace RCU, an exiting task,
+ * none of it audited against a sleep that drops the program's protection.
+ * Refuse the park in any callback frame, synchronous, asynchronous or
+ * exception. Asynchronous callbacks are verified as a state of their own
+ * with the callback as frame 0, so the walk over the frames sees them too.
+ */
+static bool in_callback_frames(struct bpf_verifier_env *env)
+{
+	struct bpf_verifier_state *vstate = env->cur_state;
+	int i;
+
+	for (i = 0; i <= vstate->curframe; i++) {
+		struct bpf_func_state *frame = vstate->frame[i];
+
+		if (frame->in_callback_fn || frame->in_async_callback_fn ||
+		    frame->in_exception_callback_fn)
+			return true;
+	}
+	return false;
+}
+
 /*
  * bpf_task_park() sleeps without the Tasks Trace RCU read section and the
  * disabled migration that a sleepable program otherwise runs under. A dynptr
@@ -16366,6 +16391,12 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	}
 
 	if (is_bpf_task_park_kfunc(meta.func_id)) {
+		if (in_callback_frames(env)) {
+			verbose(env, "bpf_task_park() is not allowed in a callback\n");
+			bpf_diag_policy(env, insn_idx, "kfunc bpf_task_park", "the call is in a callback",
+					"Call bpf_task_park() from the main program or from a function it calls directly, not from a callback.");
+			return -EINVAL;
+		}
 		err = check_park_stack_objects(env, insn_idx);
 		if (err)
 			return err;
-- 
2.53.0

