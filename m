Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795601806;
	b=KQ7fgS+wfH56L6Fr92j0k6F3TXz916dw+leAO2sPChV/nAn5H5J7i/cIzL00dSih09Je
	 HgSVqz9YBZI9sJu6tDejRzMPqsj9fp8bSscK/Ig4hjUyBm+gYsooIaKt9t1PUAlA0zjA9
	 rV7pBLNZERve25VEJsmhPn2c6E/IWN0DPzzPKKC+Fgfg34JXpZRptX3uk/7NjrXRVs4Zy
	 UHhBz16c3DvsqOAWsP5y2UOkIbprEdYOlFLw8KKCEckwOWkicfbIlscsgriMquQJQUqvG
	 L942SEYJHW1DEfNbpFnuPt/jjmG7y2iLbdPu+kogVm+8tAbAR5EoRPfhdqef3TN4kwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601806;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=awPRpVpElLgNcQFi8ibrp+TM/eEPpmcQRW1l1vbx0/0=;
	b=kjDZ32qF/uIC8JpO5mUjJ2iwlnY/U3PuSiiydMhnLTrTwqD5BaNtVzCooyuPiVpnutJN
	 PA5uD/6C1KvYjNyOZOasSrSXWXGtE6im44yZ4B6z5yYNqmPRhdY3Wlsomthc7ZBYQPMta
	 StOBzxbPuAG3dxu/xXT+K0fRRV7YTTuo2o7zQQQj3TEsyv32pM+ENoekWCXOX8ktQDVWD
	 IC5axQvNv/YIwJ1gJZZpZVodwj5f1HCVHXZkH4Qg6fegJY4eKSUz7M8dOeII6JAk3xumi
	 Ofe5A+IP7rJ0FgYP4vYlepijKe867evgiREzL2Rh/w3vMZGvey0keocXkLDjYBNIzRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ovgrgPQO;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E83606A323
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 10:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66E83606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ovgrgPQO
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-49465892f7bso4025082f8f.1
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 02:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795601805; x=1796206605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=awPRpVpElLgNcQFi8ibrp+TM/eEPpmcQRW1l1vbx0/0=;
        b=ovgrgPQOfess5DlW7142801Zw1xbgiqdmpUq9V48GYGb4IOKO1gBisXbq1kOAezRvg
         WEE2w58lT0a2c7bQE8h3iqVCo/qIQgugn3gvmfb8HncZiWJdBjNdK79a3M57kb+eLF8J
         dWXbeaCx3Z67aUHgrQgxHySrekYfndJMPkmPdnW2cfrMdWJnV+n7cZEQ4iQVaN4+UbFB
         0M+YDChi0gGuPjdB2pHEJvo8vXh66G5U37RdezFqcumB1J/MyJeD6EkHcCBQlJlWAdUx
         RN5mEEOXsGc1UZX7CO+iZci019ewQ3eT77j5AqBVV0pWeZT7QKHoLKMJtEni9I4EXthM
         maVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795601805; x=1796206605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=awPRpVpElLgNcQFi8ibrp+TM/eEPpmcQRW1l1vbx0/0=;
        b=c4BAScFSjZcxt19Ev87EanCl64s3wa0sa0PoLdtPM5tT1MZQy+8ub7oFtNCyP3KIHT
         PSFg4LAYVrDrq3+Y7xopwVAgceU1JcxRMUcysFZItqWs3D1vRjTWYq70zKiwKmwVhLzM
         UtdYSFcibOZ6UjF1741vhBo04VBgnk/mT7DkyAZHiP9WlLl2fHCC4VFaHvSWhbn9gBUf
         7bcb/MAqnRVDxHEgUriWqdgZyRxChKlyRqWphvu5TXd/mjjy7/R3t2rA5WsaJhIbESWR
         sZYeg09zRsbCy52ybcmHnfQeDwDh9pHB7/0qwMDbqfq7iWTtUgXRpYv6wl+wjbG/lKB/
         zbJA==
X-Forwarded-Encrypted: i=1; AL+hErHmrNnpd1bpUZTadkkE/DhmRGug99YUaeEUYxOpZ9QDnj8T8Hf3RZ+saS8EB3PFsgnPN4U=@vger.kernel.org
X-Gm-Message-State: APuU4Z/bNMMUrCQzLcRLidBmmT8Gmd6AXDOci4beW7MireGSv/CMUdL3
	A3udShLxtfHD0T1b/STSo1Wor9tHKUnXPnH9imFL6nnd7xT7son26XCJ
X-Gm-Gg: AZFdTZfcB64u90xv2hSwC2AYTo4aKY0CEuJFDuC+jiRq5DYmIql/IM+ucOUC0amukpq
	5m2rUEVqXDt4DMMqg3qRKVib0NYxmQ9vRdlUf1V4VNtTPa9Yai+0GQOSvKU5gVDBW5Lyum2v1lL
	wmU4QxfBO8eJz3peGArLaiX5nkABdamK9FdcLn25N27kqo79l6DO5QYjgSFyEwK21R6RK1zLtLI
	pWi+u7JX/DixwwgMrtBkcaThspP+WAS2hS3JJS7fAH8sKF6hhtNMYfolhDg2HlvCO4wnBmnaTgp
	5SZ/XcYf8J8e2XtzXwsEQwwM6+hIHN6f8/HVJ2C/eOx5n9KoVoVkUVbf20DHzmAxUBC/YcVc2gK
	tK5l3g7OFUq1ocC9w2ygUjGPaHM5IWEw25p7OiKbmf2aPFiLppq4h63RyoqxIQbX7Dvp3MZe1/2
	SKmmLaDIRqb//x/HO7XA+e8VIBgf/UESFGWQlepwVwykSaGNK6L4O9SHZFmeeEqwrPXzEA0gRbr
	3+SFIE5JnWZB3seGAx5zBbxEvltGsMfylbkQjezOdVsXjdAEiF01SeYfDrfO6zeaaOYcgfz0mf8
	ita/r8K1tAmFYi4smvcn9riQ+mhx/rKlyQ9Y1ZhaVgqX00I=
X-Received: by 2002:a05:6000:310c:b0:487:27f9:844 with SMTP id ffacd0b85a97d-4abb627ed47mr41470186f8f.57.1795601804534;
        Wed, 25 Nov 2026 02:16:44 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a68048esm34765938f8f.29.2026.11.25.02.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 02:16:44 -0800 (PST)
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
Subject: [PATCH v1 bpf-next 2/7] bpf: Remove a wrong comment about fmod_ret targets
Date: Wed, 25 Nov 2026 10:27:59 +0000
Message-ID: <20261125102810.699464-3-a.s.protopopov@gmail.com>
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

Commit 6ba43b761c41 ("bpf: Attachment verification for
BPF_MODIFY_RETURN") stated that only functions returning int are
attachable. However, the check was done only when a program actually
accessed ret, so a program could attach to a function which returns
a pointer if it didn't touch ret.

Instead of letting programs attached to functions returning pointers
read ret, just delete the comment. The reason is that a trampoline
runs an fmod_ret program only if all the earlier ones returned 0, so
ret is always 0. (Another option is to let any prog read it and mark
it as known zero, but not letting it doesn't break any old prog, as
reading ret of functions returning pointers was never allowed.)

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 kernel/bpf/btf.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index c4386a9a1ad4..3c57e66bbb36 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7553,9 +7553,6 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 			t = btf_type_by_id(btf, t->type);
 			break;
 		case BPF_MODIFY_RETURN:
-			/* For now the BPF_MODIFY_RETURN can only be attached to
-			 * functions that return an int.
-			 */
 			if (!t)
 				return false;
 
-- 
2.43.0

