Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795601808;
	b=YEa7KLKNqalNm9zwGK2mqni1jz/YbLDICagcWgmjSW+0cMbUBTqvqCKdQhhmdEhjal53
	 6hat053kOZ0oil8Ws7pIStA6yTv1zCjbXTgdCSSBoSKgW8vjfqcvNluCXcVkww0c0HOzH
	 /GNW90xV0SStK741glOyLEJn60FrKXqPDTH8FMZnSbUiScPcnNGsQgvfcK6mQxXfLxeWs
	 651tC5+EQvTzoXsCy7mw/NOFBm/CwBv7LUsFPkIAv5QfEp0gHawKrrQWwVRRYB5SXQxc+
	 ggiOSwUYulxW1qhsI4IBh9xlw/uFqa3RC78MdX2tsFnHlOYf0PA7c5+M6FQEucCQ8sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601808;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=TnDICsmgwZjC+PJQm0HTC/tn313FcG+LI6UOYiMU9ys=;
	b=1LfQPF+dGKGPHYCrzNUl6aDUWLlJYsCgoIrieZ+75rm5wyrWylJGhXCiqrKRGCDXAcpl
	 pDzLMUNxGNddiYzSAnvHSoRlCCFbVLgJaXgLuA4Owfzo+eEplZmcelPBthhFzgEmXSdZl
	 YgLN4t37Z0D5LXFzHhRTWFtN9750hp4LHL3BD+xhXLcrVqVvMVhfqd1X5T/Kryw/hBYp8
	 o3f/Rlrjq8Xi/CqohSYGc4y2wypevd75gfK5K5fIXwONeghxlzQ5zXvikFOAwVesfMRlw
	 lP4oT2HQ/aaz5uluDEKbS1LKD+dmxbWP2to1o70giyp5KQIVjmQCnOADOUonIS41Y+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AbJ4ywHP;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEC9606A323
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 10:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BEC9606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AbJ4ywHP
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-490d59c3edaso3780266f8f.1
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 02:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795601807; x=1796206607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TnDICsmgwZjC+PJQm0HTC/tn313FcG+LI6UOYiMU9ys=;
        b=AbJ4ywHPWohU/lkbwyj3xGQYd4Nb+NWnEjMPfwxWME5NBJp3bvPJeLFqr0B+fgSTKQ
         TFaM8w7/270wPkZ0QNzgYBnoaR/FRkuf9Lab9OW8QTGT+4qQiM584Hak6sl2jClcJjo7
         xNtxIwhCG8qIABDIXhFA7DQNL1m2r8m7Ikb7pSe29F+6Piu0P48P+XW5WKw+92SYivO0
         ofvPzlwDm364hPOgwoVHEFEPIEtIhGfi9SHkJXPQGwL3rw4IK8G6uiQGpZ3t0fgvqr+H
         hs9Bhrr2pd1G4OCe82ilNcReIwmOe/zCQptrq+W5QMjPSUk+SkifkyzCYgWOeXA+fX9W
         wRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795601807; x=1796206607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TnDICsmgwZjC+PJQm0HTC/tn313FcG+LI6UOYiMU9ys=;
        b=I5NpE+kowC+ZGJ2ge41QOdyGnb/6KBlrdz2P2DqN68IlIlQjuNweKmFw6iEYxGerho
         6hrLVFORZI/KFTQASqJLW3gpfWZ6slgUM+m3OeC7itfXU01F8z/xH2TJKVeWJB4R5a8Q
         faQNEc0IHDgi5prnJOuFcsTasqvI5JJ9W2Ds7QR0AFM1BOZaKhW8CHTKcivNPGRQcyo9
         wbKZWuG6t2A0OPl4ehHW5EZCLek7KpBmaLklbUtJDmjzqujRFzKFi+ZTImasfYYwE7Al
         W6hKugFpZC07O7ORKcd2OupMDxYTns6JFvps2thMDGBwOPq2qr13zH1FFpMBlO45Aes8
         j1gg==
X-Forwarded-Encrypted: i=1; AL+hErEHEV3pDXM5ANi5Z8QVFUvJfIXC3Q7K1cCJCnb25mqXCYuoQljoq3tbNTuiBEfkDyn+N6E=@vger.kernel.org
X-Gm-Message-State: APuU4Z+taE+dcP+X/T4OH9IEk7iGB2DtYldDwMv2XJljVbGIDnWcV+xR
	d6elqjW1IKUhmAsR75c71uqgS+fCaDnSp0eN3rPUdrz5Plnf8s3s8amf
X-Gm-Gg: AZFdTZeNriSYG98IMQg74X9GiU1rmEX9rLg5Vl5L7NKxXNYm17SFffAqV42JuvAssDZ
	hYYqSzpNSos+ND+YN6TYM5kXMCaz+21jC8KeUwCN26tIkOjE+X6rLrJ8eVegj3sCupmFSGIhoQR
	wNc8OjEvLL9zGXt+8zBAYYTMOkUQksq8bEp9CX6FRYqRoH8MgPUvCl6B7elV2WFC+c0KY7qXSkr
	7/vvtJvrfnemXQU/eygpYRmmI9dLK12AjN1q2Bx0T3i4eNn60UZHLs4wA5lGTX0Doh/ywR9aUPs
	SCDKwXfj8GDOG1E3a4/VxTcBd/e/ZiW2TNVYf/UTJawegdmnCtt0CjbbBA72sPLi7mRWia8ShgU
	vD1GEHW3WXf2RGmrgxfAym//Jl1ljuddLToWJISyamKHFhI/SeTbcx2BZdoa7WrwSCOzGdVn63c
	4wsru051Mq4lBOgQfa06BxKm4o5mlFzo2qKijV5iHhjUVSBg8VLCtEuG1bc+KM+q90iGwohI50k
	7aAxwnQWVSJ35haUhuaglVGIws41kHn3scSJdOEGN/Xl74SDFnoopydMBirv4EZS66a50uNujZt
	zQrumWw1fEs5L62bK06YhXyCq3YMm2dgfoBr+5duQODwJiI=
X-Received: by 2002:a05:6000:2288:b0:4ab:1d39:92cb with SMTP id ffacd0b85a97d-4abab6de737mr32039474f8f.2.1795601806593;
        Wed, 25 Nov 2026 02:16:46 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a68048esm34765938f8f.29.2026.11.25.02.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 02:16:46 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alan Maguire <almagui@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v1 bpf-next 3/7] bpf: Allow only NULL or ERR_PTR() from fmod_ret on pointer functions
Date: Wed, 25 Nov 2026 10:28:00 +0000
Message-ID: <20261125102810.699464-4-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125102810.699464-1-a.s.protopopov@gmail.com>
References: <20261125102810.699464-1-a.s.protopopov@gmail.com>
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

The caller of such a function dereferences what an fmod_ret program
returns. Functions on the error injection list like xe_device_create()
return a pointer. Let the program return only NULL or an error pointer.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 kernel/bpf/verifier.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 18c7b9a6f456..d2475edeecd9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19710,6 +19710,8 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 static bool return_retval_range(struct bpf_verifier_env *env, struct bpf_retval_range *range)
 {
 	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
+	const struct bpf_prog_aux *aux = env->prog->aux;
+	const struct btf_type *t;
 
 	/* Default return value range. */
 	*range = retval_range(0, 1);
@@ -19762,8 +19764,19 @@ static bool return_retval_range(struct bpf_verifier_env *env, struct bpf_retval_
 			*range = retval_range(0, 0);
 			break;
 		case BPF_TRACE_RAW_TP:
-		case BPF_MODIFY_RETURN:
 			return false;
+		case BPF_MODIFY_RETURN:
+			/* An extension replaces a global function of the program */
+			if (!aux->attach_btf)
+				return false;
+
+			/* Allow only NULL or an error pointer for functions returning pointers */
+			t = btf_type_skip_modifiers(aux->attach_btf,
+						    aux->attach_func_proto->type, NULL);
+			if (!btf_type_is_ptr(t))
+				return false;
+			*range = retval_range(-MAX_ERRNO, 0);
+			break;
 		case BPF_TRACE_ITER:
 		default:
 			break;
-- 
2.43.0

