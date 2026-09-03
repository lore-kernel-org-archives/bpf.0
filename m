Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26634B8DFC
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 14:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446687; cv=none; b=iDqR/KFqV7g5MlasNL2PhRjk2JzX0IR0cjxyMfO+I2fyYOkKUJ2kOmT//LxfzSqP+paXA7KVPEBZL1bRjYHBjQNxGxSb34tXZtI1l9iUtQ+ErTcU7zM9U+H6+Gz8ezwn/nK4rnpWzL7pmH7003RHGByaay2eemHb8qo+Pq3vJX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446687; c=relaxed/simple;
	bh=bQHt4QtoEadXauCPkqY7Jql2TN0QTIzjvjlvKDvc79M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tzhFcFc6eiJ4moksjiWHPvoP/aHR1WJuKpvZiEFNfk2KMnym6dnmKBwXii/tbG4NOYlgJma9SGwccWfxDTWhxojry5PuG0ouZfzKDFUgxzw3C4ClkjAEpg1eBIgmMD5kiXu0gQege4/kc8kg4aGEg8GFiCrlUfzSdKoHlWO0u3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKVeXiKs; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKVeXiKs"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49b46dc430fso4530475e9.0
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 07:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788446684; x=1789051484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4YOEfWusSHlmnaRLW14DWZgIw/+cvHQc7VhowO8y7s4=;
        b=IKVeXiKsUs6S0YjJknWiCFjnoNJSh6bY5MHScv3/laqtDonie6cuNUULD1uy83kgJ0
         GO1r6LJV6bArPm0fD5jTtPwmnuuAW2DyFwQvIdWYE4N5zdWwCj935Y0dOG+tK/fePy99
         cjsCU114WV9NnvPF0hH7OhYMQ3oPYCDXfuXbFlPW/dLUId7TcJVx9T5SzxHJuHK1phF7
         aAw/l+e7mD4Z/OwLbrImofbO5X3tx+qPfhUbmPZyrj+v4F7pWeQDn3U6/QYzqGXhyZfc
         me7GQSE5CbQ2LvwSfixSE0VeOrqkARvQNrAIqH4TEvIEzTvsWGkmf8hwhB9k0wObOPdP
         c8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788446684; x=1789051484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4YOEfWusSHlmnaRLW14DWZgIw/+cvHQc7VhowO8y7s4=;
        b=bPOysWKbO8li9BzuyHIkfJcXpzMfwI6DTvAh1Nop1wE022SKhMjcxgPQyI6gp2DBKb
         veomkdJibmJh1Xouo2irOMEPxsPBBkD9dpGWzF+++/wpiRuOUiGMSe5z/6UmonPS+QP7
         32btMRlg+phDIsuawvk7uvzMXxBINnICjZGprKeG4kXdif0SO/TafUV69mc6FI1Ero1d
         acXGNemWWGkWTzcHtNctwE6FDChpj1t9kGi7HHPbo/oy4Vm13jgFLGrWj3MEliZScN+N
         rAlW8EVdZA6iDbeghwH4yD56QipERYjELQfsmtTcH2Wm9qCssjNReGoynp901gSfb6FF
         5QeQ==
X-Gm-Message-State: AFuF++nOcjXwaww11hruyglvHMULal3yw0qaSq8+3UWE9Gl0IQVTO2GL
	T7Q9R+2McxqEAEs9vHB1ORq8ZDwCHpIVFVKhMaxX632usMqv6bv2BA58Y2HqSrf5
X-Gm-Gg: AYBFou0iLmsHegiqIXYp5WWdyc0VZJ06TewKeqSvPNIKE8S9qq47w6lakEHNZ8/qjMb
	qJBa8w+yz813HRs17EcU/chh3nOjBtGeN/RuXhUpd/6mL7FJ3+Yr9TNYkfyPTKQxdn9RcrD9CoR
	hfIZhkYMZZXtDyRkGt9jvccXUxSx6h3TswFGPfK6+LImnGeLyE5lzT9rP0gXUxrS92RDdol+Zs0
	J2f4qy+twf7o4CdiFrxnxuL7FK+sWW4+QbV0k4Y6O4vv2cfrNFrTnVN0A0aMnl4+uCAImVItUSW
	HI+vgzp5gXhzqRtb2QtG90Ks1HNdfeDMcXDdpR667rHiH2soCxkHjtUrcJXxou4HdautdoonC7R
	dPp1Cyz/rWB/XSt0Q5h2zQQoT5jIyekv2B+dWwmkbl77g3nKf2fSyPJ/clJ/JXjtOadkFr9A+wf
	0Ci9Cz9n2faZGU2PFdfLmSy0JWG7TKglCNIrQSOy4xSmLcupcNYA752DTBw0durmyn0+9zia8pE
	YBBkphLlSGtWgwSdf/Lm1ZVUcn52GTvGE64aAFVMiv+6U0G8XZV1lo7a9js9RAq34XYr4MJ2uSp
	SXCt2PKXhTNr/Kk4fqGTl+qtD1s=
X-Received: by 2002:a05:600c:c48f:b0:499:8aff:59b6 with SMTP id 5b1f17b1804b1-49ce582276dmr208336695e9.14.1788446683902;
        Thu, 03 Sep 2026 07:44:43 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e6f604sm14210409f8f.2.2026.09.03.07.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:44:43 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Nicholas Carlini <npc@anthropic.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 05/10] bpf: Reject resilient lock operations in rbtree callbacks
Date: Thu,  3 Sep 2026 16:44:23 +0200
Message-ID: <20260903144433.1716731-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903144433.1716731-1-memxor@gmail.com>
References: <20260903144433.1716731-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1756; i=memxor@gmail.com; h=from:subject; bh=bQHt4QtoEadXauCPkqY7Jql2TN0QTIzjvjlvKDvc79M=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtm88Qe8xVfL/sESRRXnk79zRocq/CucVL6q8+Oxsd86 jYwdjt3lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCKnJjAynJTMLT+RYx25yn9e YE3JC+Hta+acffLS1Jn3uWR59mtPdYa/Av1yvkdeKkjVCJvFBvtNuHac4cRH17+5ZvmJab8cn/U wAwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

__bpf_rbtree_add() keeps parent and link pointers live across calls to the
program-supplied comparison callback. The verifier therefore requires the
root's lock to remain held throughout the callback.

The helper path enforces this rule for bpf_spin_lock() and
bpf_spin_unlock(), but the resilient lock kfunc argument path does not.
Since resilient locks may protect BPF rbtree roots, a callback can release
the root lock and let another CPU remove and free the node referenced by
the in-progress tree walk. The walk then resumes using freed pointers.

Reject resilient lock kfuncs in an rbtree comparison callback, matching
the existing policy for the spin lock helpers. Resilient-lock-protected
trees remain valid when their comparison callbacks leave lock state alone.

Fixes: 0de2046137f9 ("bpf: Implement verifier support for rqspinlock")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f540279ff4ab..32d31fa67036 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13241,6 +13241,11 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		{
 			int flags = PROCESS_RES_LOCK;
 
+			if (in_rbtree_lock_required_cb(env)) {
+				verbose(env, "can't res_spin_{lock,unlock} in rbtree cb\n");
+				return -EACCES;
+			}
+
 			if (reg->type != PTR_TO_MAP_VALUE && reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
 				verbose(env, "%s doesn't point to map value or allocated object\n",
 					reg_arg_name(env, argno));
-- 
2.53.0

