Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D2A328626
	for <bpf@vger.kernel.org>; Sun,  8 Feb 2026 05:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770528844; cv=none; b=XjR4aPokyTNj0N7JsTf25CaCVO9MxADx/NeGX7Z5NHChlB7VhS+vRJzKrkYA4KXjYD8soYP07qVzEeGLnZBPKXuoVPmIU9vhGk/jAvxbc+cTolfSItz48wZhb7UIXJBOEFQvtuVzeD64FI6Kgn3iW/NlSI7fKgChDLSU+3Dkdyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770528844; c=relaxed/simple;
	bh=WNVhyOL7okSH5jtf5uSAFPq08ifRlHDbQ+0d6p9ancM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oivl8YoxhcDxNKYUt5ywMnfGAgFxVC/UH6f4d80D7BLDb/8WOy58wsjy1+rqtyMStCcpG4psPvTZIq6162v0vyDuvzLLoLYpmm63UXCZ1dqZqlZ1k3/B1cZsaymlgNG4JbI8XzJpx7WkH0+CVwi9FJH8WCRaociGFg15uF8gBFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mP2is8cB; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mP2is8cB"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-8230c33f477so1511289b3a.2
        for <bpf@vger.kernel.org>; Sat, 07 Feb 2026 21:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770528843; x=1771133643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOZtDu7jSNri6wkbo2wj70FyVnPCcpHXFtiLHwbu29Y=;
        b=mP2is8cB482Fi8ookoOfYRTB3jFGSxz2q58KDrH3YdLXEykyps0DZrEcuTrK3T8Bd/
         I32h5CafwCda5zSKD5MDjyO/fp3i7Mwp4V0CWmOeITFCTIHEYsrvQ7e7MqhzsKfX3PM4
         xgdGC44y7/MnfZtAwwQkeLLB6+I15uCl+FooGQO9mGOFtXuBT+bcpBQ9gFnRl3DbealL
         p7xRzxdxJVKqSl+fE/0JwTrCjEle8cKauQBG2uDGWuy3hw815wntoEUyAHsw2hGX4/n/
         ECaEFW5w3S0CY1243TIxGptrgG8X3e+UGYh/w39iN3tIG5ryS27zZ9Hb/qcvTPWXgPka
         Q/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770528843; x=1771133643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GOZtDu7jSNri6wkbo2wj70FyVnPCcpHXFtiLHwbu29Y=;
        b=P7f7kiPorLmDlY/Te5sFHBP3u1E3Dk+MoQCt8NkzbLvw1MtBvbugoB8DLNdX6wbXDN
         O2aeH36O21sjvVogzboEg+yseqKahZX6kzlBTQbAN0+I41U71oozKigDlr3f8eeq4qAj
         6H3EQkpkx9DrYyoa5ivpmyD5dH/iMrGYdZqZ+RC9hd7RKJ7Tygz6epGIijGitNHek4vK
         aO+WiU8lBCtDtfq8/BSkszPBDZjlNAOJ9BwVeMLOqm6pr0vQXf/1h0JMcrOxEc1vouCz
         I/uQknbPhJe3th610RoEiqCXGIYE0FBnwzIVXHLtux6gaUSrBQLAdMrVwdE7rxejJ4y+
         96Gw==
X-Forwarded-Encrypted: i=1; AJvYcCXXOBHdmlsYMUY8Jo/zEmM75m4FaRu2zrC6bWWt4SVfUvpOEeszuJeHtXYcjQX7M+UyxwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRLgRYxPkZGw1K8++XsBT6+4mEkrrXLVJFtA9ZggFZ/42fKrw5
	1hKpOsj8DLlQn0djuzTIUHgG0Lfg1MuZCcQ7zp0ZwFY+VmLlL8QZ4ag4
X-Gm-Gg: AZuq6aJ9PORo35jjPRRt3o8YJUd11WDKf8+TiHIV6BnfkpT/JUindyr3l7W1EnAE19U
	5RzT0KoY5972lYSFpNy2beR5iAVNRpa6P0BV5Zrih9vk+9DlW31Bq8K5pL5cqbpjJYlKmUdN/1j
	UEw5x9NFkGvvc3pPSsoMvj3zLoB6Zu4vB8NtwlvR6wxGkxzVnB6FKT9nHcy3/Cd9v3jen2c0Ygl
	ApIYFhAoaBwzEbmI+xj1iM5YyuqzW0VPf0vBXL2RQNvI2kmY1OyJLlwEJicy3QGGSczSPVTJffg
	S7ZC4BzMYjCifZd7I7gupYa0Z1hrBNsTB0SCTBoDcxbBxTLyYM6j2J9cQ+p8hlq+9Y4H0WH7fWD
	XKAb6of4RQQ7g1OJIoNplyyHl70OnWTTQF/Kj/kI2Y3SWA32MwSAW7DnKJpDtZllkUR6TeuGWaN
	4WgVqDyAT+TZU/tvHAMZM=
X-Received: by 2002:a05:6a00:4b01:b0:824:3cae:54b5 with SMTP id d2e1a72fcca58-824416002fbmr6625757b3a.14.1770528843309;
        Sat, 07 Feb 2026 21:34:03 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824418de80dsm6067700b3a.62.2026.02.07.21.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 21:34:03 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	bjorn@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	pulehui@huawei.com,
	puranjay@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jiang.biao@linux.dev
Subject: [PATCH bpf-next v4 3/3] selftests/bpf: enable fsession_test on riscv64
Date: Sun,  8 Feb 2026 13:33:11 +0800
Message-ID: <20260208053311.698352-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260208053311.698352-1-dongml2@chinatelecom.cn>
References: <20260208053311.698352-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Now that the RISC-V trampoline JIT supports BPF_TRACE_FSESSION, run
the fsession selftest on riscv64 as well as x86_64.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Tested-by: Björn Töpel <bjorn@kernel.org>
Acked-by: Björn Töpel <bjorn@kernel.org>
---
 tools/testing/selftests/bpf/progs/get_func_args_test.c | 2 +-
 tools/testing/selftests/bpf/progs/get_func_ip_test.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/get_func_args_test.c b/tools/testing/selftests/bpf/progs/get_func_args_test.c
index 180ba5098ca1..075a1180ec26 100644
--- a/tools/testing/selftests/bpf/progs/get_func_args_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_args_test.c
@@ -167,7 +167,7 @@ int BPF_PROG(tp_test2)
 }
 
 __u64 test7_result = 0;
-#if defined(bpf_target_x86) || defined(bpf_target_arm64)
+#if defined(bpf_target_x86) || defined(bpf_target_arm64) || defined(bpf_target_riscv)
 SEC("fsession/bpf_fentry_test1")
 int BPF_PROG(test7)
 {
diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
index 43ff836a8ed8..45eaa54d1ac7 100644
--- a/tools/testing/selftests/bpf/progs/get_func_ip_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
@@ -106,7 +106,7 @@ int BPF_URETPROBE(test8, int ret)
 
 __u64 test9_entry_result = 0;
 __u64 test9_exit_result = 0;
-#if defined(bpf_target_x86) || defined(bpf_target_arm64)
+#if defined(bpf_target_x86) || defined(bpf_target_arm64) || defined(bpf_target_riscv)
 SEC("fsession/bpf_fentry_test1")
 int BPF_PROG(test9, int a)
 {
-- 
2.53.0

