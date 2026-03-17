Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9774C1EEA31
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 01:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773709345; cv=none; b=VnQoRhJGem9fuh91R70B480KbDABt7KVHzdVLduQ+I9rqSfrWnIH3onuadrpToTzLf3IV/cAJ1jjXskUop0vnBOuzdYrTrSq6C/VokwQK1AbvMdC8PYLY5ZG5GBKP4utnGN0agOXuxcBbzxwBQ1gTTjnKB0CGlUUrDieX7VWKhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773709345; c=relaxed/simple;
	bh=w43A32ElWzUFHVnnYSmGYUdM4Z3ZT7EHYE2wZgx0qf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WEFtT0fkM7DR+YnOLRPz7GquKkOhbsnuLZzYVlp/DI7KkpWhqfwNxtf5UhrJIKrw+ROqMNUfSm1R2cYDpqBWH9WvXv0qaX10t5PZVg4ngO/A9iQEYTk4GD3iXVm6vCgRxsGXtfp+tUP7F+/bNS+Zq3xjRz4YksVNfPB8AFDcAv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPy8v28/; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPy8v28/"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64c9ebd1369so5122647d50.1
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 18:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773709343; x=1774314143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KbolAMX4QbaXf52snOUv/EVQt0h5F1GAcLobkdxUR8=;
        b=NPy8v28/Mx4iyzHi1X7oeZh7A1HfHM20aINasF0hgEdtKE0jXuMEPmtvbTpQuCeVvm
         GqZ+kLmolmAXWRAyT8k5O/5yO7vrqESMQbqUgRKPHQRD7wL6dV3B3l2MCT+Rpfgga8Fq
         e8R+ibIUKrE1nb0at0aSo+4TR4JYmEDUiUH96ypRY/rXNq/r6/bqO1mS87TASy4Cs0vz
         Ipdm8rTsZDCeEN4aSid89a0vrs3d18SJRZ+DybFOEYFkIPA36H157nDbDom3seTheaMM
         /W10tRp4CPtRG2+1YqY2k26GWWx9O9ad0P81yInnSKqxRtEW5/sqo2z7LZOArOs+ysVP
         DzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773709344; x=1774314144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7KbolAMX4QbaXf52snOUv/EVQt0h5F1GAcLobkdxUR8=;
        b=R7loThnNxiPS39VGqgv8gXJeO2FbGteYBsqUWmpigMFbdl0NJK/cSPiMtt1tbmLSuj
         NDdJAvKoEbHbyLRFsRLMGAuCEYS67bwzOJGIAmn222D4pRaFIqDtAGxe3gCJSg6b2SqD
         H0Rq7dcFcdUuTKvNz2mI2lTofywWIlZlHfIYVXeGoKlYbmGiIu/2fWWXVxKWTB+qZNJT
         kXCHITzz/prXvCC81PUp+ottbbc2BOhxIpBKD5hxihIsZklEb8KNJwPAbGp7z8BvMgD8
         PPmHeNGl/KFZF5w8rb4u5IuIV+AxXEW+sN37l8rhQV+MlsHEqQo1xWkNvViuEgCRaO2p
         ybpg==
X-Gm-Message-State: AOJu0YzBd5dLzNq6mc316sUHvFaNN8kL/83Oozeo1EYhpnJ4jwf1l4sO
	n1zS7iF/e6fj3wvald6dGSto9Qg/B/HGjsnc4GgOTO5ivp1/yBLTcPtcFhgaIgSBp1w=
X-Gm-Gg: ATEYQzw32rDVFJXtd820VBA/oZ1Z82rRDLJUQKCwK3RSzkdLAolcQapQdhzXRmXp9QB
	JwZqlwY/Pabwq0lS9lddW3KWJD+w7PziX2wR2dE2wgTlZG3Nn5HmTQ5WOon+vjHjJObG7fyTfcv
	smzIzR1eHBo193jjO72k4LS6bpealTcoGUh+YPgLF/9090CIQPO87TtaxRBTqj/TvutZqXrF3qv
	nyXJHbR88ajAJoRMigeqvbiveCb425eAp7jGyr4F66o2rtNisLHF191DA68WjLOYj+zZ5HcURTi
	ODHyD6vfbGfNQI/9ZB0sPfR5zzRBJP6D8iPVqw263qcVbSB9fllR9PimfRugm6b8cb3/0NtBXsq
	LxXPbwNngtjiOKzrvmD680ofJ1Pb1QLx5FvlZw6jrxVR2uwntlTvjgeaHr4TAk3sGYTEQ3iKt5K
	uo0ebFy+keK7qKwgPMws5cA2T1HzA9LjeSjJKBM92jq8fWth6dtuVrnq6MCHi/Mg9Y1HCMZ54Mi
	yhNbIqbg+FhNBUg6rHr//E=
X-Received: by 2002:a05:690c:260c:b0:799:266:83e3 with SMTP id 00721157ae682-79a1c1d2627mr148456747b3.50.1773709343410;
        Mon, 16 Mar 2026 18:02:23 -0700 (PDT)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917f1df91sm99596507b3.44.2026.03.16.18.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 18:02:23 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
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
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	paul.chaignon@gmail.com,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH v2] selftests/bpf: trampoline_count: use dedicated target function
Date: Tue, 17 Mar 2026 09:02:09 +0800
Message-ID: <20260317010209.8779-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260315054227.118344-1-sun.jian.kdev@gmail.com>
References: <20260315054227.118344-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

trampoline_count fills all trampoline attachment slots for a single
target function and verifies that one extra attach fails with -E2BIG.

It currently targets bpf_modify_return_test, which is also used by
modify_return and get_func_ip_test. When those tests run in parallel,
they can contend for the same per-function trampoline quota and
cause unexpected attach failures. This issue is currently masked by
harness serialization.

Add a dedicated bpf_trampoline_count_test target and switch
trampoline_count to use it. This keeps the test semantics unchanged
while isolating it from other modify_return-based selftests, so it no
longer needs to run in serial mode. Remove the TODO comment as
well.

Tested:
  ./test_progs -t trampoline_count -vv
  ./test_progs -t modify_return -vv
  ./test_progs -t get_func_ip_test -vv
  ./test_progs -j$(nproc) -t trampoline_count -vv
  ./test_progs -j$(nproc) -t
    trampoline_count,modify_return,get_func_ip_test -vv

Tested-by: Paul Chaignon <paul.chaignon@gmail.com>
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---

v2:
- add Paul's Tested-by

 net/bpf/test_run.c                                        | 7 +++++++
 tools/testing/selftests/bpf/prog_tests/trampoline_count.c | 3 +--
 tools/testing/selftests/bpf/progs/test_trampoline_count.c | 6 +++---
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 178c4738e63b..b41147a29f16 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -580,6 +580,12 @@ __bpf_kfunc int bpf_modify_return_test2(int a, int *b, short c, int d,
 	return a + *b + c + d + (long)e + f + g;
 }
 
+__bpf_kfunc int bpf_trampoline_count_test(int a, int *b)
+{
+	*b += 1;
+	return a + *b;
+}
+
 __bpf_kfunc int bpf_modify_return_test_tp(int nonce)
 {
 	trace_bpf_trigger_tp(nonce);
@@ -635,6 +641,7 @@ BTF_KFUNCS_START(bpf_test_modify_return_ids)
 BTF_ID_FLAGS(func, bpf_modify_return_test)
 BTF_ID_FLAGS(func, bpf_modify_return_test2)
 BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
+BTF_ID_FLAGS(func, bpf_trampoline_count_test)
 BTF_ID_FLAGS(func, bpf_fentry_test1, KF_SLEEPABLE)
 BTF_KFUNCS_END(bpf_test_modify_return_ids)
 
diff --git a/tools/testing/selftests/bpf/prog_tests/trampoline_count.c b/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
index 6cd7349d4a2b..b19358aed126 100644
--- a/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
+++ b/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
@@ -30,8 +30,7 @@ static struct bpf_program *load_prog(char *file, char *name, struct inst *inst)
 	return prog;
 }
 
-/* TODO: use different target function to run in concurrent mode */
-void serial_test_trampoline_count(void)
+void test_trampoline_count(void)
 {
 	char *file = "test_trampoline_count.bpf.o";
 	char *const progs[] = { "fentry_test", "fmod_ret_test", "fexit_test" };
diff --git a/tools/testing/selftests/bpf/progs/test_trampoline_count.c b/tools/testing/selftests/bpf/progs/test_trampoline_count.c
index 7765720da7d5..911d282fd423 100644
--- a/tools/testing/selftests/bpf/progs/test_trampoline_count.c
+++ b/tools/testing/selftests/bpf/progs/test_trampoline_count.c
@@ -3,19 +3,19 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
-SEC("fentry/bpf_modify_return_test")
+SEC("fentry/bpf_trampoline_count_test")
 int BPF_PROG(fentry_test, int a, int *b)
 {
 	return 0;
 }
 
-SEC("fmod_ret/bpf_modify_return_test")
+SEC("fmod_ret/bpf_trampoline_count_test")
 int BPF_PROG(fmod_ret_test, int a, int *b, int ret)
 {
 	return 0;
 }
 
-SEC("fexit/bpf_modify_return_test")
+SEC("fexit/bpf_trampoline_count_test")
 int BPF_PROG(fexit_test, int a, int *b, int ret)
 {
 	return 0;

base-commit: 267594792a71018788af69e836c52e34bb8054af
-- 
2.43.0

