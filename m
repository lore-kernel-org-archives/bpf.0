Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9011D342503
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 16:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771430500; cv=none; b=jvkS4Cj4891mIxG2QDG5rJmTWycToPSWmIYyQ3hM1VdscDSXpCHK7APpYdDqNo1IbAzXdSHE82GH8UHmF3199/ayWJG7OqirPN/WoQvf8BQv1r+W0L8YI1V7QxPsxvCILjxi+ZMNSFOsK2PCzgifmW5LUZu1leHWmbrWv655zlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771430500; c=relaxed/simple;
	bh=q9QnuoF4LkY36jbKp3YigAkyzO1SEI3MoUnm2NI0IBY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NcoHBOeytIx+0chHnODibsGuNxgYBuyAOz1Be7s9bkOOp1ehFoxInbXacnI1tqQo2vmdrSqt3GlP3FO3vbmlvfvlvbu3iKhk3CK5ZiU+7HTz42iO7HsYY4Y/zcJPR0izFPl2+Boa/GqV8sK7JA2MwlHGkVVBZaK8KtkG3XczadA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vg+fdJRl; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vg+fdJRl"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48378136adcso30013575e9.1
        for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 08:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771430498; x=1772035298; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QAvlBVdGFmd/TqXOSzAB8VFo9fuyW7B/rEKK0yHjLIo=;
        b=Vg+fdJRletGjPzLO2JOOAP/IcIT5Lb1ekMgOrXuekp0grQ0IiUYsktURTFRbqlrNwp
         2sElqkycXEXIjsKttuceIisCcjoZlKtkZvykD0QiUHfCmvxAwZ4oORMtyFiHFC3xVTEZ
         ETuxN+qoVBNPFyG9O6NTRYlxkMhwToZi7JzdoLB2yh8F54nNhhTriFiqOUtkzMMRMAYZ
         grcK9pYQRuCdlopOUkusrlra3JWnIM4UUsetILMfFcUz+XQUvAqsA6notOtlNmgcqcTu
         tV4TplP0H8mLzggPPACYbIu0Gy43wGCorA6Pd4vzH9NzK3l6wYudFhQfGVEVvq3f/BJ0
         GROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771430498; x=1772035298;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QAvlBVdGFmd/TqXOSzAB8VFo9fuyW7B/rEKK0yHjLIo=;
        b=EUFevY9TFC2hd6nD9SOPFNhUGSRIbjGWP74uNw+ow2tVB04lYlrNBayaQkdXP7FxAr
         HFoEcSTWXxUdmHvrNfmK8mIKaTmDAgzkR5oFrNanx7jW7s34xnbBxx6NJ+vuNJAoDQF3
         +dtgQ25xCtFoECcObiO4h/sU3VBUb2FXysWoTjHaR7A6VRZKH2Vwnxrwc8MiL/k5e372
         0NJalNjuDMPLgfHSv7yYPsgQznvjxqmjv2HUKOKjCVpph02nyxeld3+WOEXIGMJtuy8S
         jTW6tVr2mogWGsMnIl0kQAAh6FPAR503SHXTC6qHB901+6iYLfLj4X5wQBaL+KAFJFZb
         ODBg==
X-Gm-Message-State: AOJu0Yx9lLNBJN4FoJwJ/TpJTDCWx2V1YyIp1aXwzyZLldSkpxWDhpDB
	M53hn0fuCufjT7eakgyDOaQWp8e1wEfHwqUiE/dNhqm66MzNW1lgo2BayXcJog==
X-Gm-Gg: AZuq6aL76k9kG5GDII1Y5keW/pvmDklrrcqo5U81bi2MdPNPV2ZrD1fLKPN1PdGCKyj
	86ho5VSN0GDiYj7U4mrHt5ErpaQ80HaNEUXGg3ptE6OeZdrfpnCu3RpYixpXoDi6Lq99zBsWXMh
	aori6kBs2MnZe+zk+OBw4on1kqBS/SwpTZcPbC8sUQjIwdcNCYTHdEfnPFPV8/7N+LjgJl7xYRN
	rCVqZwzb75hqfPE82lapVzCBEbuUh6yWt7LUxQN64kENlVCwe4l76JHIkrBa26qlyXh0nHu0Z0h
	NITSqR3TGXqB0Bn4T/wUK8wNWBlt3OiyOwG52C/S0Cf6Xsiyxx7Z2lybKR2I/D68B3FsRC6P5Vb
	1M1asdLU/KOKxzvNk/kiqBLaJwOTdphFAtbfxC9gYuK++WGmCwTVKY4gWy1pzB5G9aBrCsDzYbi
	EvHt3iaNWwlLhVHIlIgg==
X-Received: by 2002:a05:600c:8189:b0:483:6f37:1b61 with SMTP id 5b1f17b1804b1-48379bac876mr241036845e9.4.1771430497593;
        Wed, 18 Feb 2026 08:01:37 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::6:66e8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483983e8e3dsm20218655e9.20.2026.02.18.08.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 08:01:37 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 18 Feb 2026 16:01:18 +0000
Subject: [PATCH RFC bpf-next 1/6] bpf: Allow sleepable programs for
 BPF_TRACE_RAW_TP attach type
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-sleepable_tracepoints-v1-1-ec2705497208@meta.com>
References: <20260218-sleepable_tracepoints-v1-0-ec2705497208@meta.com>
In-Reply-To: <20260218-sleepable_tracepoints-v1-0-ec2705497208@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, ameryhung@gmail.com, puranjay@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771430494; l=1328;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=nvAGcO8sY4Dks9mmeZZ4wY9hnOV5tEp0vfLEcMJ6GxU=;
 b=8dbYE7qRY+uCALKZZUm3koAUjZGXWh+rE+kyba74lHyCwFymePXAKMe7E40NkFv3KkYs4UlcR
 XxrLW2kRmVcBbdYcxIcVEdQlEws8R1XH2OGKsVFjYkyrmm+NHHke+KJ
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Add BPF_TRACE_RAW_TP to the set of tracing program attach types
that can be loaded as sleepable in can_be_sleepable(). The actual
enforcement that the target tracepoint supports sleepable execution
(i.e., is faultable) is deferred to attach time, since the target
tracepoint is not known at program load time.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/verifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0162f946032fe317ce1e5cf4a82e86a9357eca2b..1973184306e41d1279bafe7b2870cc9f5772c40e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -25186,6 +25186,7 @@ static bool can_be_sleepable(struct bpf_prog *prog)
 		case BPF_MODIFY_RETURN:
 		case BPF_TRACE_ITER:
 		case BPF_TRACE_FSESSION:
+		case BPF_TRACE_RAW_TP:
 			return true;
 		default:
 			return false;
@@ -25215,7 +25216,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	}
 
 	if (prog->sleepable && !can_be_sleepable(prog)) {
-		verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable\n");
+		verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, struct_ops, and raw_tp programs can be sleepable\n");
 		return -EINVAL;
 	}
 

-- 
2.53.0

