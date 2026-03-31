Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC501D5CC9
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 01:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774918843; cv=none; b=KmKgqzAzBJMuAvpXS7zINavE6lmx1hjpXelaGshIEFok5aHtxiLeXjXA2l48V4OlKvP7J8DLVrKhEnGkOlU6cN9o3k8XAPjyn+5WsAN+LgNGU3fQRPETy4PiVOUQH+KIbD9/st9FqCsr2LWPl24l4yiry33y+ym68pTmVhF8Hrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774918843; c=relaxed/simple;
	bh=i3BfvzRNVkvpbWTsxgp3Tl7pJgq8M0APnQmVnhjYlzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tlQFTbhTnU+9e9chjcb0ZSxEeRJmpHPkSTGAJqincvWskU4b35pobQGwRtR/l0sAgwXdh9TQcv2IF2EINQuKk0Pl2cksSxWddgLaPKaaMqKFSqC9Dz7/uQKFonCe1oJGGn/Z8fkN6RMfFMLwVK/unebWkYH6BMcOTE09mZ9CtK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHDVhZ8t; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHDVhZ8t"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b24fdac394so18076265ad.3
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 18:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774918840; x=1775523640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QdbtQQsKMGsN+ZWMq+NXKuYb/NN+U0WVpsgdheglh1Q=;
        b=eHDVhZ8t0CwXer0+w56uCkNebAKw5HRIykmqJ6HpyE7BN3J/e6W/ZUzI4iUZ3lKs1k
         8D+VTZh/V77y4BpT7/yPKd813ML/V7SSsvpAEY+7ZrfW4fTR+GGWzV+2aV3N657qyIXl
         VrzWirCAlFx7EDRRhXzAUCapCBjKaNPzHv1PujgZBnykULUNKTVipr5DRKlelhkI2Em4
         5CPKkSLcr7bbjA4EZbysp4EmKK3qDdnvdvg/P5CZu18ox9VJyySC2YfIA17OgBNGWVP0
         7JsyaejZbjVQZm6s4pf5PvOiJAlop4FSSF9hacqsJ1gw8fSzx8hObqaSf2ymOHuaZW96
         UcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774918840; x=1775523640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QdbtQQsKMGsN+ZWMq+NXKuYb/NN+U0WVpsgdheglh1Q=;
        b=lLa6VTuvfjJg2/4LED3j95/Y3yYtABlowhy/erBZ1TXsMZajkZv5l8eKlGZisnOjGt
         uDbHQUyU5KbU7bOuQ2pNvpoNYBSxbSNfDzTWWEZQLnVxd+gVxFSJ//YPXURQAioTud+d
         czvkTdvca5c7Z1EzYCtx+SFfCBzZxh5TwMvC4cTady6aPp/C/N/2NxcvTY8sDCeB67OJ
         TgKTppOwL5husOHA4+uhSyEuC/2sT8KpcsV++bx6d53xK1Z2u1kL+5vHeUCDxTjZdtzl
         uoi+2feNW+9K3shKkZcXYGuyQU9mxBj1aKVZIrhutJAo8dOIz9Rb+VogU3iEFJxvLoD8
         bQkw==
X-Gm-Message-State: AOJu0Yyy56Ksr4NhPCjH57al1YiUG6RDVk7L1xFnUTaikJahdatk1rGQ
	1cutsa2mwvGqleQ961XB9YF9YRY4bcnQ/63dFhrewwXSS5SRnQxny3MWskm3WQ==
X-Gm-Gg: ATEYQzwGMkJfrMJZl6Maw4kl1qtNKVB1yjScC9OdXIshLtkGjpqM8qlBn95NhNMLpL4
	xFCb7wOvaaq7Yr2iKk5cirXBkD/C9f1CDYzT0AxBUhbl73JobDcBxeYFDHmvkbW1t/7v0bxPyeV
	3M+UQ9t+lRlewf9MsF3pI//CopQlLaQjfWXgm+G7aZIx7ZTyYjvQpoEjbtOIFdry+caxSW0jAPH
	UdCysfMDj0FzX4PTYrsBAaiMLlJMiZ4wMHgw9D4DP4fHUzM+94cHH9VwV55ToLSxKzZ0/HthMKi
	nwBiLNjRToft/E8bwUPc++y9tH55rHaFP+McYiNyUgeF5cJKpbw/mNxgMOT38OBcqj16MCg8Jwz
	9uMc6a3lGm1Bq1NhX88eVr/eNb9oKTvb5Os12uirQmB1Gp/FNPFaYl6v+qJqS1qrb2AN+l8vM8W
	8de+abrpm3BFq9CWqtJS8igJDzJXBtPjp33Ab0MutGB4ESz9Nn
X-Received: by 2002:a17:903:3c30:b0:2b0:bebb:1081 with SMTP id d9443c01a7336-2b0cdcbb4d5mr154257205ad.28.1774918839788;
        Mon, 30 Mar 2026 18:00:39 -0700 (PDT)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427a27f2sm125226405ad.67.2026.03.30.18.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 18:00:39 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>
Subject: [PATCH bpf-next v2 1/4] selftests/bpf: fix __jited_unpriv tag name
Date: Mon, 30 Mar 2026 17:59:24 -0700
Message-ID: <20260330-selftests-global-tags-ordering-v2-1-c0ac61e81098@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330-selftests-global-tags-ordering-v2-0-c0ac61e81098@gmail.com>
References: <20260330-selftests-global-tags-ordering-v2-0-c0ac61e81098@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

__jited_unpriv was using "test_jited=" as its tag name, same as the
priv variant __jited. Fix by using "test_jited_unpriv=".

Fixes: 7d743e4c759c ("selftests/bpf: __jited test tag to check disassembly after jit")
Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 0904fe14ad1d45aba2f2c8a9a12881a0d248685e..52cf9f3cccd0ccd8034b9786d787e53992a4a6d8 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -140,7 +140,7 @@
 #define __msg_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_msg_unpriv=" XSTR(__COUNTER__) "=" msg)))
 #define __not_msg_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_not_msg_unpriv=" XSTR(__COUNTER__) "=" msg)))
 #define __xlated_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_xlated_unpriv=" XSTR(__COUNTER__) "=" msg)))
-#define __jited_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_jited=" XSTR(__COUNTER__) "=" msg)))
+#define __jited_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_jited_unpriv=" XSTR(__COUNTER__) "=" msg)))
 #define __failure_unpriv	__attribute__((btf_decl_tag("comment:test_expect_failure_unpriv")))
 #define __success_unpriv	__attribute__((btf_decl_tag("comment:test_expect_success_unpriv")))
 #define __log_level(lvl)	__attribute__((btf_decl_tag("comment:test_log_level="#lvl)))

-- 
2.53.0
