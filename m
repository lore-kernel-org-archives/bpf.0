Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795662245;
	b=DNhwSnJrEplMBkizEGwsBtRwAS334gw0sPFdydV/NY5pXBa6qsQju7Jfdn1F0tk3LmbJ
	 m8MUa/gMcaNSIaAscqjumg0x2w+ysCFFPVv/Vk1J879WbZ97fZQjhKdHJQ/4HUD5PKqo/
	 YFa28frc7i34reEUozr71yAGorOxg/Di0MUI9f0IZgz0687MZ6Rm/3xePrFXGmQ63O7/5
	 cv8POtNDuiMj/53hB3IzkZ6mFaSkBx+CeYa/kroBCX6wsSwUOW3iwjhI2Q4vgthr0KktD
	 vdAVC4CWN3sfsagTUvIqSpuQNSVJagwgmTIROeD7ncYAVidmpVKFFlosEsNwc9DJS4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795662245;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ddb0OSRQRnS1FFdnfeKAnfjkoKDhcY1dPdlnR5d0YrE=;
	b=qUy5SCeu7gUDKpGUQ4irMiHJyfN6P8AaYt13zFOMzticDw0ZQ1lzuFbbJrm79kvMqu12
	 1z5UXzlmSuZh//FejzmsiN79SVgWVEmvPAVUK/gD+4cKUOQeBy4TAe6Mq7JOL6z7beEZy
	 uQPzqVUtLk2L/jJQ49aXjQWQhIhTzk3Fo4FLpgWPPRdfji0Si3MWb19yOGcC0Fnx4df0G
	 iAVP1poJTZhacsbDldLAVe0sk6fhCRhSe1KmuiyP+i3RqhSvmdsa82smsMS+Etr+md3/Q
	 7OCD2rRcmp4oRECDhBwnUg8wwZTKPklkZceV8x3vDNSMe4PbhBjYdEYzydEJqmFcJNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="YCD/8fbl";
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025CE606A31E
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 03:04:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 025CE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YCD/8fbl
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso3125403a91.1
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 19:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795662244; x=1796267044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ddb0OSRQRnS1FFdnfeKAnfjkoKDhcY1dPdlnR5d0YrE=;
        b=YCD/8fblarfEs9y/3p5Q6FX/a3VLRaQ1xcrboOC7/m84oPqsfjEfuytXnJwRfzH8Ga
         4FHEtkOw07ij2NZXbRIkMQaP33jyIuLnnSGbCF0G5KJck5iRsO8qg4a4y0gX3j2t4+NM
         yMDFI/hCOkO+PToW82t+NCSGHK1Ei6u7Pri3e9D0iQmlKl9BLHq4smNeTsFZR3oi5v33
         Mi8vCcWLnxzdS8MVquR98LNBmOvJYVhWQ+wdWnqvnCw4HPaf6jn0pmO7s+hnVke72ApH
         jytdH3kq5NTN9yARf8xzCSrmNHnBvXuNVbuIIz7bFT9zNk1j7b3r32uj3vbT4cGxXJ/1
         qCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795662244; x=1796267044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ddb0OSRQRnS1FFdnfeKAnfjkoKDhcY1dPdlnR5d0YrE=;
        b=plVZ04vhNynn1VsmZp9SKqOgf630lsyeU9e3ZEg6M1TMdWGGZJvu1/bfV5Q+MuBTF2
         jAM7sZJqpFZCPQEx2B4ltwYkVLAdotG6EaKFKUsO3F//3bgvnRNAERS2feKzhkA1enJu
         6EMZZxGp28cVzpKJ2doTlmlXhU9TW2C0Vq+Yv+l/Zl9b2R9XCpnmmU6A/2wZg4WgNy2U
         mvpg7h2rPMxb9VFwRO9TMg9edeEuphkfrYISheWW1pKR3Y3eh5nGap0mH1a2yQawaNgf
         c6oZ+PElufzKmXghA7jg0j6Z3GvobfKUrM/gNRtv0rRHXFYfDUHsi3kgD5DoFJyvtNTN
         NreA==
X-Gm-Message-State: APuU4Z94o5ebTCfrRtoxgH9xKBPh6ZTMODhTl+NDvZvZGrJg+Ek/pS1j
	zTCRTUuv994qTHshwygiTv8lJhj82GXf5JXAmcvd+xqfF/dIBFXnbDbyLc1Qxg==
X-Gm-Gg: AZFdTZd6iyj5BuuX2o7o/TuEcX2cyGUPjb+KsrMsy5txiHxJgwAgEHpeKfhIwq/QjO4
	H91kBY2yLPCEqHtrZGAlHj6VjhhZp6jcoWU7jbKYujut66r4DY7JTJQKEuIgWcd1oyXpf3HHsHc
	VLebgtnU5kHOvq4denSd94aZOzq73d6j3e9T/miI1K6ZCGL988FvoPYOr5n/ZALuWekRZpCh87t
	B6J2dGQuMg0mrUCcqQ1qAVlHIaJ9ZABInEK3pRaONj+bUyZYCF1E+OE9HkY5ogdX4wH+CjOaGTx
	JJy1Zn8UUGsJWFKWiGTZ59oxxV7LaoOGc+v7HAy5b5AzCoGwFj8qmvNk8JOy3n3AlXESkgEMjar
	6H2MrmOYMACXky3EzUuUcXj/GY9CJOSGW59VnuYV+qpcJ4GzrBkNB1gN27fCuHfPUCQ5Vhf563B
	fT4Nak6ukAcLxi/9NdIXVS5lCOPpr2Q5+ciY/tMrumGfczDRWzdHbi5WbRyTxVtZEJxlIwHoySs
	PDiUnjsfZZb5z2B0yKikOM9GniRtPOPMq8m2v1QAIlxFswFkTpXi7vglEPbKnUZH+GX32bQO+rQ
	/ZC0THbceZjcJ7Aj6a97jXQEzxJHl0YC4VUnr6rg0MqDbpvDJg5klaP5GJ+PKJKCBmnv/lzVg5F
	sTo9+f9q5Bs8munMNdeRXzJhtR4PexlCZMmnUi84tk8H7hOnwT60IDbupQhzUl7skRQ1rNb//aQ
	==
X-Received: by 2002:a17:90b:4a4f:b0:3ac:8af9:4a6a with SMTP id 98e67ed59e1d1-3b41c93c3b7mr19771875a91.42.1795662244085;
        Wed, 25 Nov 2026 19:04:04 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0b52dsm32680381a91.5.2026.11.25.19.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 19:04:03 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 3/4] bpf: Fix reference leaks in struct_ops programs
Date: Thu, 26 Nov 2026 03:03:41 +0000
Message-ID: <20261126030342.4013902-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126030342.4013902-1-alexei.starovoitov@gmail.com>
References: <20261126030342.4013902-1-alexei.starovoitov@gmail.com>
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

check_reference_leak() lets a struct_ops program keep a reference in r0.
It leaves the rest to check_return_code(), which looks at r0 only for an
operator that returns a pointer. The reference is lost at the exit of
other operators, of void global functions and of async callbacks, and at
a tail call. The target of a tail call in a subprog returns its
reference to the caller of the subprog, which takes r0 for a scalar.

Skip the reference only at an exit that returns to the caller of an
operator that returns a pointer. Reject a tail call in a subprog of such
an operator.

Fixes: 8d9f547f74c7 ("bpf: Allow struct_ops prog to return referenced kptr")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f41f0998f9cd..b5c812bea918 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12708,10 +12708,26 @@ record_func_key(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 	return 0;
 }
 
+static bool st_ops_returns_ptr(const struct bpf_prog *prog)
+{
+	const struct bpf_prog_aux *aux = prog->aux;
+
+	return prog->type == BPF_PROG_TYPE_STRUCT_OPS &&
+	       btf_type_resolve_ptr(aux->attach_btf, aux->attach_func_proto->type, NULL);
+}
+
+/* What leaves frame 0 gets to the caller of the program */
+static bool returns_to_kernel(const struct bpf_verifier_state *state)
+{
+	const struct bpf_func_state *frame = state->frame[0];
+
+	return !frame->in_async_callback_fn &&
+	       (!state->callers_unknown || frame->in_exception_callback_fn);
+}
+
 static int check_reference_leak(struct bpf_verifier_env *env, bool exception_exit)
 {
 	struct bpf_verifier_state *state = env->cur_state;
-	enum bpf_prog_type type = resolve_prog_type(env->prog);
 	struct bpf_reg_state *reg = reg_state(env, BPF_REG_0);
 	bool refs_lingering = false;
 	int i;
@@ -12725,8 +12741,9 @@ static int check_reference_leak(struct bpf_verifier_env *env, bool exception_exi
 		/* Allow struct_ops programs to return a referenced kptr back to
 		 * kernel. Type checks are performed later in check_return_code.
 		 */
-		if (type == BPF_PROG_TYPE_STRUCT_OPS && !exception_exit &&
-		    reg->id == state->refs[i].id)
+		if (!exception_exit && reg->id == state->refs[i].id &&
+		    env->prog->insnsi[env->insn_idx].code == (BPF_JMP | BPF_EXIT) &&
+		    st_ops_returns_ptr(env->prog) && returns_to_kernel(state))
 			continue;
 		verbose(env, "Unreleased reference id=%d alloc_insn=%d\n",
 			state->refs[i].id, state->refs[i].insn_idx);
@@ -13465,6 +13482,12 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			verbose(env, "tail calls are not allowed in fmod_ret programs with restricted return values\n");
 			return -EINVAL;
 		}
+		/* It can return a reference. The caller of a subprog takes r0 for a scalar. */
+		if (st_ops_returns_ptr(env->prog) &&
+		    (env->cur_state->curframe || !returns_to_kernel(env->cur_state))) {
+			verbose(env, "tail_call in a subprog would lead to reference leak\n");
+			return -EINVAL;
+		}
 		if (env->cur_state->curframe) {
 			struct bpf_verifier_state *branch;
 
-- 
2.55.0

