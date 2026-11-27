Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795802599;
	b=fSgR92UnL3574qANw35hEsh6Yo/CeN8b1cyeE1x0aHUlRM7TOE1HHIu80dg9ACnro+dL
	 rQ13A8AIRr18KlevH1O6MBpLbYCqUlfLniHDWXzzpeIzWXvdi4hWIN3liRG9h53MBl8Ma
	 VUXyROAl/X2Qzq9gepW7VSWN+Yy0SaUp3IYVxMVUzYvMpeTSIhaw6fFdk91SU4EBCoaDc
	 a5CAh6ZbQHDBvc46KN/5m9N/6OLBBBXyzBvqxpxCmYxOyXQbTnEwvM02BwN0PTH08sXOS
	 mgysy0sq77LCifJzOeCiztGFK6m9t67JhhSwQZng9dA6EBjLDmbuZLWQSfEVZiNn9HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795802599;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Last-TLS-Session-Version;
	bh=rD90LW/g1uRft8V8loea8ddnC8E+29zzF3dbDqD0xKk=;
	b=XCmE8FAWZWOYe5RV/wlZRVJmXyKvGWMDeXU1+/ZyGZ1pGpwqMRp/ifpMAR9P7vMflXVU
	 1AErTlSEp0WSSMISHO7hoJJdX9v58+RDy+/0itnPjZychKGUO+ROnLz5MN605SXejSG8N
	 xSGuPDHbm8jtrSbRHbEoIdJtDxZBEx/E+dXZCVvOWLSP6V8dat/E+XV5pT5CyO7y1HruC
	 lGYwJ/3K1eUiSoOxWHKZj25bs41HLoJD6/fAfxkGVGEwBHDozqAyCiHXGCqcxqnVYhj1N
	 3O6trbtgLqMhrbXvcm+xOh72YUIfrmLUQQWidUobZH8oZM0nDJeCgqQiBW5YMXznNgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=marliere.net;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=marliere.net header.i=@marliere.net header.a=rsa-sha256 header.s=dkim header.b=MGtSOfyM;
	arc=none smtp.remote-ip=209.85.161.43
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E255606A683
	for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 18:03:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E255606A683
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=marliere.net header.i=@marliere.net header.a=rsa-sha256 header.s=dkim header.b=MGtSOfyM
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-71b945cc4a6so707276eaf.2
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 10:03:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795802597; x=1796407397;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rD90LW/g1uRft8V8loea8ddnC8E+29zzF3dbDqD0xKk=;
        b=Y9VGHS6Y6rmlYs3XNdw1geO0ABPo8h1OzS6IJgnit4CaqB2nE9CjSyeqtBR8zWbkCg
         sxiDRdfxEzbHlX0/IyWiHnCBn23+T2kMByzbz6utevfkNwqH1vKVZ18IVQu7iO14CBYu
         cvVY73qqfNBvwpdJutGuqXnw8V2fWm108ojSHuZPTMOaT1kHqneRzXg7I1XjRrYetXVV
         QFBFHMlDcjhaiPtsg6tGpcd1L3oJzZXf/9QfjLAbR+BDKPm5pVlOt1m+lBABrfK9/d+q
         8JWHKcmZwVQheO3C0eTLFw68swxmn6g3+wql+1MLZhBAhLXvOoSekUR5R5eLvJpAgXJJ
         nRZA==
X-Gm-Message-State: APuU4Z8WCr9qyiX/bJsVmNVqfBZy0SpGBohBkLwufleXnJnX3Pr2t2fW
	zN4TBIhHZf8wLMJCeOEmbNeFr7hNVUZShqnv0arhXA57Iw371Sg3SiQs
X-Gm-Gg: AZFdTZd3UIadfkEQKA8ObUk1WYr6szKzb+ai7sS/WZpe31LYkQUKDJvGwLrYaM0S4tA
	w9A/df22Pt2yywikCzplKKlzEGG4m3OtV0WNusOpk3Zo1kWZgri+5hjFrG3btOqH3qtKdxKc//V
	71gA5Pu9Y1YpLeHL0RUBP+DVYSGJiUbAcGASxulfO5AhAZPzr69t4xSJFmPteT6bYeKYVrSjD/X
	/33Vi0vK7qDsY9YpkoNmcoRmGIUqa3KRVEJyrx2GE/pKJMEkRcTU/o63NHtyMOD9deBmoOPlZgZ
	VImJPSVQqEZZuHsPwsTubQsmmZUdWLwJQfUHRIj84RrQdmX7/v97Wk6h4CHotD9I9P56t2sifw1
	NJmOU92A4LMUralIxzj9lSgdvuq9YN851Hr5ybRZAqeyYb8mEg5umet6eAE8bmOWmgu2xhEmc2h
	TCs5A+7EfplEihpr655LUgkY6GM75IZMaliKSKJkXmfW5wxtHWzDIBLojQNNiH8NNgJcHcJwY9D
	cZP3TzaiL5uEenAwMKgmYwIHSlsY3zAlNpAM1vNFZdlxxN63ibSqFD9tCPEFC0VeGtX7XESguFn
	w9MntfkEDp44ThOQLqX+76UuZLX9TqcaW0WJcF10f6hibBHLKFWPhclqkUVwNg+EFebRmWtRRA5
	subL+nsV4/yNWMyBvhO0sblhbOWfktiI=
X-Received: by 2002:a05:6820:a09a:b0:713:e3f5:251e with SMTP id 006d021491bc7-71b395332f2mr16781524eaf.48.1795802596855;
        Fri, 27 Nov 2026 10:03:16 -0800 (PST)
Received: from mail.marliere.net (137.65.66.34.bc.googleusercontent.com. [34.66.65.137])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b38015c51sm16467798eaf.3.2026.11.27.10.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 10:03:16 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A773460CC6;
	Fri, 27 Nov 2026 18:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=dkim; t=1795802594;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=rD90LW/g1uRft8V8loea8ddnC8E+29zzF3dbDqD0xKk=;
	b=MGtSOfyM8oJW5jlLXp7eOcqbLPbtiuEIRY0w2wqGyeaeznIxFEc3QplzfjVgF+EaR4EuLZ
	eIRS1n+BVPs8QTopjoGtJBLsEVGyaAyYuNplo4hcE9wKP2/QC16lzPkLaVOLZJMU8/Zb+k
	9S2OTfLhIHxLtTuMEbaTTujEYEWQblqbhJYt9My7w2GPGXKDAzAUH2RLwqag21nbjIO/M/
	0pR1eNpl/rarqA3NkklBShAipie9HkodgL6QGvrCJWPHySuBmR+Dt11Porm4/zXNzBlKBq
	v3YZYsfSMc7QnvB1OoLRg63p3Gyd1xEzK4bL06u4XzkFzjzJ+gZHHUl+V0MxWw==
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_=28SUSE=29?= <ricardo@marliere.net>
Date: Fri, 27 Nov 2026 15:03:05 -0300
Subject: [PATCH] selftests/bpf: Drop conflicting DWARF choice from
 config.x86_64
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261127-selftests-bpf-config_dwarf-v1-1-46ef5b492f41@marliere.net>
X-B4-Tracking: v=1; b=H4sIANjFCWsC/yXMWwrCMBCF4a2UeTZoIrTqVkQkl0k6ommZiRco3
 buJPv6Hw7eAIBMKnLoFGF8kNOUaetOBH21OqCjUBrMzvdZmUIL3WFCKKDdH5accKV3D23JUAfc
 Hr49uCLaHCsyMkT4//Hz5tzzdDX1pYns4K6gc2+zHNk1MifL2YaUgw7p+AQgkhICeAAAA
X-Change-ID: 20261127-selftests-bpf-config_dwarf-de38c19b7da6
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_=28SUSE=29?= <ricardo@marliere.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1795802589; l=1327;
 i=ricardo@marliere.net; h=from:subject:message-id;
 bh=8+DByMWjm7cAR3ST0nITHLU/9D//o+2zpqhJ2WzQCZ4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMneMjENWel3PSbA6CREt8noMWhcuLiVoPYrbs0oq5hnNm0VwORDPKzsIB7inPgbIaBZNvuzWbo
 OzKWv0PhzswA=
X-Developer-Key: i=ricardo@marliere.net; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g
X-Last-TLS-Session-Version: TLSv1.3

config sets CONFIG_DEBUG_INFO_DWARF4=y and config.x86_64 sets
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y. Both are members of the same
"Debug information" choice, so on x86_64 the fragments contradict each
other and which one survives depends on the order they are merged.

Neither needs a specific DWARF version; CONFIG_DEBUG_INFO_BTF does not
depend on DWARF4. They only need any member other than DEBUG_INFO_NONE,
which the generic fragment already provides for every architecture.

Signed-off-by: Ricardo B. Marlière (SUSE) <ricardo@marliere.net>
---
 tools/testing/selftests/bpf/config.x86_64 | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/config.x86_64 b/tools/testing/selftests/bpf/config.x86_64
index 523e0d29bbd4..a6e9766b6b7e 100644
--- a/tools/testing/selftests/bpf/config.x86_64
+++ b/tools/testing/selftests/bpf/config.x86_64
@@ -44,7 +44,6 @@ CONFIG_CRYPTO_SEQIV=y
 CONFIG_CRYPTO_XXHASH=y
 CONFIG_DCB=y
 CONFIG_DEBUG_ATOMIC_SLEEP=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_DEBUG_MEMORY_INIT=y
 CONFIG_DEFAULT_FQ_CODEL=y
 CONFIG_DEFAULT_RENO=y

---
base-commit: 9437ee8b6cf607e883b36e44bd755968daaebd48
change-id: 20261127-selftests-bpf-config_dwarf-de38c19b7da6

Best regards,
--  
Ricardo B. Marlière (SUSE) <ricardo@marliere.net>

