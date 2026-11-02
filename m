Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793658979;
	b=voxiL5n5FknVKC6h68H9/6FW72WWB7dR2ixmWAjGgVtZt3+MdhRbC2Vevir72sC0sXdr
	 JT4FiXBsbv/rWVvGcQvTjl9crJenDW0RMNgjRz1mWTxJEk4ygOaepojjTEOP+B2k4H+aT
	 r9c1d0rfdeETT92G1Govia2KS1VNU6APQqncTQz1vSIt3bvfiDtUZq/sUyGidtUUlUwB0
	 kFgQXCZ3Eu2BiAncV2UzueNlqfPzZgyqEVsL4kb1kSxSZKdQsQJFYN/x9OaedXTTBGxqz
	 Q0mGWmIHGeCqYF0Jpa/oeT/iPpcN+85wEC+AZI/Q6Kp0GGcAO67VT8esHYqPr08H2BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793658979;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=+2B62P6pygpI8xDXVCsGnEznvKzC8xpzSm47oWeOBg4=;
	b=c+vaV6hJSN08qZiS42Ce56/sPz46KMpevXdGZdDa5KFpHHmucdfmh0ry9UlNmPB5eB6k
	 YX87D3krLNSh66QVfPEBPKlUkMGTnkiofVhzM3qDjN9Go7kqUuDn6bWcT7VZ7UeEYawdV
	 w0WyMs+ZOL9ZDgecApJyImiya9ZAASy2RwxhvGkKlcdE5gcPnyIYS8sLuboUgB2Cmie7W
	 z+J8r45g+JztJhcABRQp99oG3CwxWzYja8lsqY3TLifR3+9sxYiDEk3ogNX10H2NG18fi
	 hGG9KM5i5mxuUIhzTWSbUSpK3HW4+WqEG4YCBqa3kBll95BBT2BZ87s/Ylc+4xLCZIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PRSdtq08;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9E9606A324
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 22:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B9E9606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PRSdtq08
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a052aff9e9so2568862b3a.0
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 14:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793658979; x=1794263779; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+2B62P6pygpI8xDXVCsGnEznvKzC8xpzSm47oWeOBg4=;
        b=PRSdtq08wl5FtZ7YS71F2pJ+fvUKNonuRqIl/3w069O+LydfKKf3y1lbdaULR1O9y4
         Ref/0pdN127yUikWeo1tveFpvSxg3gJV6hhnV7pgUse7yY4f3BxnTSGvSgW9UKVsugFu
         V4t3N9gHX51MYQ3e2qkaG0ai9zUmEckq4VxxtW2ItS+pIbA1aP8kvdqLrCyvjk8csSPL
         KfDs0FO4R0jDEDbcmYBIHPG3BnjfSuq7BQnGTem7bEam2MREX0VaMcLK7pYU4fjyjnHq
         nuHokar16KkJJhXoitdL9rkBIbfqr93oTFjFwTDtugRESc0n9V0OgKK6VwYfjgx3VPXw
         yWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793658979; x=1794263779;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+2B62P6pygpI8xDXVCsGnEznvKzC8xpzSm47oWeOBg4=;
        b=JhaXbHueWTrJHVCJfkQQljzThSMp9x3cyc0ZMXLKueSzGF+QoEko1I7Rck0TVpHX1J
         F3gwcI/EcSgrhrPtyWvQfXgkkqVnxa5KRShDnnLBhczKOfz1Lwjw1muy59JOvEN0ymOb
         9zlEy4c8YPkZ6YVWqqiuq9zUdPwdLxW8s73eWUfnTtnGfcFou7LNIM1ag3xzkqykzvd3
         +qC5f6AjsGvtgvjluyGXuaQOxBlLE0vwLzxeZOlxdkA55jLkBznNJisAjHZy2S8wxJ0G
         jAgB3eVR/xKkHM2CyegAah0TUndmLzGKEHFgzndgJ06ZIMILg7bnp7ihFeWJSOQzNgfv
         CRqw==
X-Forwarded-Encrypted: i=1; AKwUvBxq0xpXVugEnMX/2nuE0B5dM3hgRWWqzJi7XBxg07TWYLdUGfvO0nJjGiYeAzPUSAW+Iow=@vger.kernel.org
X-Gm-Message-State: AFq9FYK/mYnRK3d38Uoo7QG899zYaYsmGolEbe1GgBnIb2x2Z9IiwuGl
	hgWuldP1oxES2gAFMz02IQrqyWkVpezWd6sIHytu2gdwN5Evw6lzPPRh
X-Gm-Gg: AYBFou19+T4pntMCM6Zwh41lClD5UWvdCSErwaQqGjJ7MSY+ic976DF9vLj/xEBZY9l
	VlZ2xhRwUjEASU8WkOp70N44qjKLYX1jwvovTSZtLNBioX4JRcxO/mG1JJHFqQlgp6U6r6s4aCV
	7WsaouyxuqgKibWBMHaiWP/4l7whOrRGbJq4WFFCYI7jxGmXh0rTQQfcXVb4YMdEhD7wCn8afV2
	LmvBQFGPxilGJfpC3Fb6s1I/8qKvkMirh+PibAyhmG9AGv6AOh9aGP9EJl+yILKvD/K7XKFmOJb
	d0Cv5k8JZ0Y68fBGxo3KGUKRDG8FM6jLazR99OXjWYLCUfafxGp0FmIOKw/DedX/tt8xswqxNT+
	6O0RAsVrOhoaLLFMHq8T5f/USRQLkTgUa553h+viArFMe3bjaOc/pWKCtBw4RNR+QLahtFtTnsC
	SAzf8c0Ky7IQzWeeWHTOAlomhCP1WmsAHWOv3Dmgpt3P2gTfeN8hh4XqM5ezTyNMOv2TWEDDAoK
	Pg7jFvn7nQUs5OiumBd0AmnEldXgPCSZroEZ+wTc5PV7gMtCX0SZU97yw/vYXYL6xNr1dE2b1nF
	hsd1QQg1Szeq5oFHllKwN9wfoJxxLYvL+RMZRrHlHmbnStSBkAGlTQQx8qGQE57431tudRz+UjE
	PbPpxW31K9AyjeMF47ge2qPF2CuQ5atuo4Q==
X-Received: by 2002:a05:6a00:288c:b0:89e:9c7e:fd5e with SMTP id d2e1a72fcca58-8a9bd1facdbmr9633354b3a.9.1793658978321;
        Mon, 02 Nov 2026 14:36:18 -0800 (PST)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aada3d479dsm2513387b3a.39.2026.11.02.14.36.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 14:36:17 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 22:36:17 +0000
Message-Id: <DML31IUICB7B.2FO0J06WCREC8@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
 <ihor.solodrai@linux.dev>, <john.fastabend@gmail.com>, <shuah@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <jose.marchesi@oracle.com>, <david.faust@oss.qualcomm.com>
Subject: Re: [PATCH bpf-next v3 3/8] selftests/bpf: report SKIP for arena
 tests a compiler cannot build
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Vineet Gupta" <vineet.gupta@linux.dev>, <bpf@vger.kernel.org>
In-Reply-To: <20261102220717.4079739-4-vineet.gupta@linux.dev>
References: <20261102220717.4079739-1-vineet.gupta@linux.dev> <20261102220717.4079739-4-vineet.gupta@linux.dev>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, Nov 02, 2026 at 02:07 PM Vineet Gupta <vineet.gupta@linux.dev> wrote:
> Give each guard an #else with a dummy marked __skip(), so the skip gap is
> reported rather than invisible.  Add __skip_without_arena for it, which
> expands to __skip() with a fixed reason when the compiler cannot do arena.

How about the following approach instead...
looks much simpler to me...

pw-bot: cr

diff --git a/tools/testing/selftests/bpf/progs/arena_kfunc_jit.c b/tools/testing/selftests/bpf/progs/arena_kfunc_jit.c
index b5a01cb..16c3dd9 100644
--- a/tools/testing/selftests/bpf/progs/arena_kfunc_jit.c
+++ b/tools/testing/selftests/bpf/progs/arena_kfunc_jit.c
@@ -23,8 +23,6 @@ struct {
 /* volatile to force the scalar reloads below */
 volatile u64 stash;

-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
-
 SEC("syscall")
 __arch_x86_64
 __jited("...")
@@ -93,6 +91,7 @@ __jited("	cbz	w4, L0")
 __jited("	add	x4, x28, w4, uxtw")
 __jited("L0:	{{.*}}")
 __success
+__skip_without_arena
 int arena_arg_jit_args5(void *ctx)
 {
 	u64 __arena *val;
@@ -113,6 +112,4 @@ int arena_arg_jit_args5(void *ctx)
 	return 0;
 }

-#endif /* __BPF_FEATURE_ADDR_SPACE_CAST */
-
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index d7f706c..4ec840b 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -116,6 +116,10 @@
  *                   feature the toolchain or JIT cannot provide, so a run does
  *                   not report OK for coverage it never executed.
  *
+ * __skip_without_arena
+ *                   __skip() when the compiler does not support the arena
+ *                   address space, nothing otherwise.
+ *
  * __log_level       Log level to use for the program, numeric value expected.
  *
  * __flag            Adds one flag use for the program, the following values are valid:
@@ -156,6 +160,11 @@
 #define __success		__test_tag("test_expect_success")
 #define __description(desc)	__test_tag("test_description=" desc)
 #define __skip(reason)		__test_tag("test_skip=" reason)
+#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
+#define __skip_without_arena
+#else
+#define __skip_without_arena	__skip("compiler does not support the arena address space")
+#endif
 #define __msg_unpriv(msg)	__test_tag("test_expect_msg_unpriv=" msg)
 #define __not_msg_unpriv(msg)	__test_tag("test_expect_not_msg_unpriv=" msg)
 #define __msg_next_unpriv(msg)	__test_tag("test_expect_msg_next_unpriv=" msg)
diff --git a/tools/testing/selftests/bpf/progs/jit_insns_arena.c b/tools/testing/selftests/bpf/progs/jit_insns_arena.c
index 95736ea..77d135a 100644
--- a/tools/testing/selftests/bpf/progs/jit_insns_arena.c
+++ b/tools/testing/selftests/bpf/progs/jit_insns_arena.c
@@ -106,6 +106,14 @@ int cast_to_user(void *ctx)
 	: "r1", "r2", "r7", "r9");
 	return res != 0;
 }
+#else
+SEC("socket")
+__skip_without_arena
+__success
+int arena_unsupported(void)
+{
+	return 0;
+}
 #endif

 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large.c b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
index dbdea14..428b984 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
@@ -181,7 +181,6 @@ int free_reserved(void *ctx)
 	return 0;
 }

-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 #define PAGE_CNT 100
 __u8 __arena * __arena page[PAGE_CNT]; /* occupies the first page */
 __u8 __arena *base;
@@ -220,6 +219,7 @@ __noinline int alloc_pages(int page_cnt, int pages_atonce, bool first_pass,

 SEC("syscall")
 __success __retval(0)
+__skip_without_arena
 int big_alloc2(void *ctx)
 {
 	__u8 __arena *pg;
@@ -290,9 +290,9 @@ int big_alloc2(void *ctx)
 /* Nonsleepable because it binds to a socket program. */
 SEC("socket")
 __success __retval(0)
+__skip_without_arena
 int big_alloc3(void *ctx)
 {
-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	char __arena *pages;
 	u64 i;
 	int err = 0;
@@ -314,16 +314,14 @@ int big_alloc3(void *ctx)

 	bpf_arena_free_pages(&arena, pages, LARGE_PAGE_CNT);
 	return err;
-#endif
-	return 0;
 }

 /* SYSCALL programs are always sleepable. */
 SEC("syscall")
 __success __retval(0)
+__skip_without_arena
 int big_alloc4(void *ctx)
 {
-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	char __arena *pages;
 	u64 i;
 	int err = 0;
@@ -345,8 +343,6 @@ int big_alloc4(void *ctx)

 	bpf_arena_free_pages(&arena, pages, LARGE_PAGE_CNT);
 	return err;
-#endif
-	return 0;
 }
-#endif
+
 char _license[] SEC("license") = "GPL";
