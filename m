Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328169;
	b=ukDfXzquFxFjttGZ0fNettkrUiOt7cUaRcd8f/iy3T0O+o4uAwu4M63hzrz6JGTrmb/N
	 dpfVlhx/Xzx76vP0FjEuPUQUEaEtCR+lP2J/5RU5erAEP2NNYFLcT/fZ2LfLvnsubcXeo
	 xR38ecN6Evai0f2i0VpvIbCFfHIaIm6ye2Q2uRyIoZTOW6uYWoBXC2Wd92ZLUMapXWjx7
	 y2cejGirlA3fa0RRy5L7JLTaKETmgeKeM5MVYSkw+I6ld8aTsyU8+Q97WadasEe8M37Ns
	 QyOiOB5GgJ6EBI2YW1YRbe7/AhlI3/0P5pN7xU+iO9+qk8BrPged09djNk8cR5CMfgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328169;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KaefMEvrOf3+jRRd3Xy+fUqgL7q625BAckIaBev8onI=;
	b=Boo1Oj5Sw1K5iQNJ8QfYIlEVxB9NP/POvOcVOsgdnVrhmvNHnMu0xaEVUsl/2iQy+4Yd
	 gOqj9BlAfRm4E0xX8DhFZVVwWIkwUBicCD3txHP5JUGF/HmynQoL6/Rp+PaL2LYcS25oA
	 zSiA3oJURNeg6yNL8l9gJyOjcxs44UYyvSqNNNIKXDzuBgAC0q8Q6XEKszrClUz/UUqJe
	 MMG+249Am4d0X5mykvDBT6c0jRvrvgrLBpqhoCk8JW007Znw8dKerSuInUJkyhKd6cz9l
	 vEIsC/Z7zajSIUZgLtHrZctqfb4LFYtDBEvc6T8AZn/3V2PzcoJhCq8NSQ2bibBRFOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wQn8Cv9W;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBAD60A2605
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 16:29:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BBAD60A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wQn8Cv9W
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso17557415e9.0
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 08:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794328167; x=1794932967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KaefMEvrOf3+jRRd3Xy+fUqgL7q625BAckIaBev8onI=;
        b=wQn8Cv9WSp8U9YmHH/WaVO+Yh8opCBDHMrG7mbqFO0KSG8qcL7ClK35vD7ExCJUYix
         j7lDDCbiYyVmUIrPtE5ZFfOzUBzStbqUCviLyMTdlObIC68y2kBTVgD0zbY3Hoegl+8K
         l7hekknz/FU6TADqpXc2Il7aP4UHbd1IAGFvaS8BmfousMh9B/tAzS2bir2Tg6lJX5O6
         TewvPyC6qtdhJRoygEqCEZXTta9IeslvX0Y+JVCKwe1VYkHzCDmeR1zza29V81SDJRXB
         a6+sKuBActhbjIGqhCBH9HubuIS9O/nn0mIeE/OA0i8hlxXmE3+WONnjY9pSA4VZFf5k
         9JDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794328167; x=1794932967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KaefMEvrOf3+jRRd3Xy+fUqgL7q625BAckIaBev8onI=;
        b=aYgkRgwQFJRL6m5l2Pa171ZJB1TRAZ8BOfjc2Er+PpH/dL/YbAjhF6ylRIiKn7+WU/
         k0jOGOvv8CHF6Xnuw5/JJ0cFkkVUV2YLktRcaszCCHadvMwOI//zptm3bXbLVL9KY91/
         HkJATx2omm5h5wb8ESJrXSunw+RFshB3vnMfqQzz0BB58rjfmPWBRwOEsusc89RRjR6r
         Gb+Z0Ir261rHuW6AjRhBt9Q9gpO9R8d4K5u/2zOxmZ2pYfi3TB3dOuZ2PCL8M1xkCDpv
         PFFmitpOeVwFdpWQ8AkION5Kq2F78Fa+HyLVJMlM/6fdfm2//h+C2B3GSEM35p/sLyVH
         AVbg==
X-Forwarded-Encrypted: i=1; AL+hErFh/dYUWqx1DBtmBnsity/lp1Ep6NM6TUpPEpP6p0TaccAFt1nggPaIEm0LDRlDXbyGezU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8n92lZtCZWBIWwlImGV4clEN36Szfle3ZGEGHFxpj1o3crxStB
	0x7noNOlkhL+boS8T1OH3mAnQNxQwSGYWemihgF3ScUCPA2pDGzc6Mvg
X-Gm-Gg: AYBFou0NBAnOMJieRHnGxSxnQ2aXNmsfLK9zbx9wzVtHAtKWNJdN5jLB1FxvESzNQbW
	7U5uEqQ3w7h8XWOB+82+nUmGp7YxIRqdrNq+5cVWGQgTMENJbU87t6GB2WjxdFfcxqVkMZIPbYh
	XkV78J85uTOtC3M5leniagFPVbYtyB+tZkZ+qLIQ17MRVZUVrUFrLAAHO0ZQm+HhMtb3i+lvxg5
	eyfC08bKehazs81zckg0QajHbUHPMHMBqJfme16U3qZN0nyh03E/PVzku9pwNMg4O/2wEK277jl
	xcIGwxlLIjTRsudvXvGBgVw5dSkryQ7BC0/HPoGHhtjZYZg8mvHtAYbsExDNBI0AqC1I2xbfCOB
	/lHH9V8uloYHKWdkRVKESDvXA7V7J/5LXG5sy89GdN0MTvl24kVN1AIMw3h286ko3pelipbVfwD
	t3uQU66CUg7OMznSifhu7P4LqpE4BgXO01QAuAWWIFvcvY7oz1hd14+aVhNfbah0OasHZlbc+fZ
	dJmeTS6eU7X+nzvpT/kva71iFNwKB2DelxU60Mg+UezROQjcgvl3o+FOuqVLTEqirvCfw7xelaN
	c8KMPKajDGeWJmx4A9Niv93tkoPqLnc9c8iXB/RhUJdoZlE=
X-Received: by 2002:a05:600c:4fce:b0:4a2:267:25b3 with SMTP id 5b1f17b1804b1-4ba0235bc8dmr57241955e9.35.1794328167339;
        Tue, 10 Nov 2026 08:29:27 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fea745sm71287485e9.10.2026.11.10.08.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:29:25 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alan Maguire <almagui@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Sasha Levin <sashal@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v3 bpf-next 04/18] selftests/bpf: Declare bpf_fentry_test1 in tracing tests
Date: Tue, 10 Nov 2026 16:40:24 +0000
Message-ID: <20261110164046.454431-5-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110164046.454431-1-a.s.protopopov@gmail.com>
References: <20261110164046.454431-1-a.s.protopopov@gmail.com>
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

bpftool puts bpf_fentry_test1 into vmlinux.h only because the function
is in a kfunc set, which exists to let fmod_ret programs attach to it.
A later patch moves it to an fmod_ret set, which does not make a
function a kfunc, and the declaration disappears.

The tests only compare its address. Declare it explicitly, as
get_func_ip_test.c does. The declaration matches the one in vmlinux.h,
so it builds both before and after.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 tools/testing/selftests/bpf/progs/fsession_test.c             | 2 ++
 tools/testing/selftests/bpf/progs/get_func_ip_fsession_test.c | 2 ++
 tools/testing/selftests/bpf/progs/tracing_multi_check.c       | 2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/fsession_test.c b/tools/testing/selftests/bpf/progs/fsession_test.c
index 86e8a2fe467e..4295f6a78dd1 100644
--- a/tools/testing/selftests/bpf/progs/fsession_test.c
+++ b/tools/testing/selftests/bpf/progs/fsession_test.c
@@ -4,6 +4,8 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
+extern int bpf_fentry_test1(int a) __ksym;
+
 char _license[] SEC("license") = "GPL";
 
 __u64 test1_entry_result = 0;
diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_fsession_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_fsession_test.c
index bbeea0d512e3..51a7f605f9c5 100644
--- a/tools/testing/selftests/bpf/progs/get_func_ip_fsession_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_ip_fsession_test.c
@@ -3,6 +3,8 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
+extern int bpf_fentry_test1(int a) __ksym;
+
 char _license[] SEC("license") = "GPL";
 
 __u64 test1_entry_result = 0;
diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_check.c b/tools/testing/selftests/bpf/progs/tracing_multi_check.c
index b2959ba71179..9b008ecd6565 100644
--- a/tools/testing/selftests/bpf/progs/tracing_multi_check.c
+++ b/tools/testing/selftests/bpf/progs/tracing_multi_check.c
@@ -8,7 +8,7 @@ char _license[] SEC("license") = "GPL";
 int pid = 0;
 bool test_cookies = false;
 
-/* bpf_fentry_test1 is exported as kfunc via vmlinux.h */
+extern int bpf_fentry_test1(int a) __ksym;
 extern const void bpf_fentry_test2 __ksym;
 extern const void bpf_fentry_test3 __ksym;
 extern const void bpf_fentry_test4 __ksym;
-- 
2.43.0

