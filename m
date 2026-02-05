Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA6232B9AA
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 20:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770323237; cv=none; b=uYssZsvymIhxvxS6DyADF7kybKdF/AGCvRe+7edaS05W7avmHZotyHHuuaoGhMr5NII2VhuKr8rdNF4NYIg7XOEoJZWKVhjwvgJr6xV93kBM6y6eupMbX3tRHPBvzozJsp3uDV8gJqFJBdT6eBB5ZZQH8cjKdAPDP64w1noBQZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770323237; c=relaxed/simple;
	bh=Gw6v2KSmKGNLAqR+bH2uKM4erbcEIkzzqhOjxX83iXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EAz7boMgxvD3HYRkut1I5ULm2s6szee8I0JL2o1a5IrssDcp9Y40163YlDCdbvLREvXSmaYEjZLJmtD9txS1DPG+g1PTHwzMMf7xXuEJuLTF90f+LjoKzUrrXrHmKzb07UQU7C6sbLcOaD3x3Ouv7KSPYY3lwANF4muYY0dmrCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQ3NqIq/; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQ3NqIq/"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4805ef35864so12203785e9.0
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 12:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770323236; x=1770928036; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lBhLYVGTqFjXukaAaL4A1adIXxm7iX7vbQw8ckkpp2s=;
        b=YQ3NqIq/GCxhwIKHV1WEtjbD7AT36mwiV7upPtqka2xMGdqy5UO4FYmSE3Qmydf9hW
         bH1RzzkZlrcTyWyNVD1+bUGdjGkkMIFT33lMBgjXsVsUitCwRC3Wrpc00FoYHzQP31tZ
         RULHoeLT4uC74agZ4NeEFySPHgVkM/risgxGgPaxhsCB38nlPA2UDwacZ646V0tJTsKn
         aFAskVeyh1C6VyHLCI912bGAu3bATvONPp/Aphetg4aQHpwB6AMjKn8lLqGhHs5DmyW9
         sZ1a4PLqjaroJ0hP+HPH1x0LCPKjnnoNixUwFpQTLBv6UYlAZirunN2oCoiMZObsfCpS
         +FyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770323236; x=1770928036;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lBhLYVGTqFjXukaAaL4A1adIXxm7iX7vbQw8ckkpp2s=;
        b=utz9FWk/Pe0ZqtJ484p2vxtt3kr5r8d28XBEozIMOXzIzNb90JR6MvRHnc1yOrj3H9
         Pvv27ZDwc7hPwjDXBfmii8AyXbFn3nxw6jN+UuOXLQwLwBhONrgXbnmhdVKO+XUJ//Ja
         f3UfTb4eWHhwuMdRo1LcFIm/9deO1Ku9KvIcrGO/gTwDED0xBkNNYe+Eb898WYhX57/h
         aRV3z8n5uoQsPl4WwExslfGL2gIHc12KoTj0Jo7Vd/Y/PsPocEPEIYl+r5BngjntTCkE
         BMWmFyOKEjfhu7V21ykHnVE3V0jlHk9ckbbHvG2b+V/PErdW5ulf8giyWMvjrGvY9nqp
         oEGQ==
X-Gm-Message-State: AOJu0Yz0EYIsODHG6WWYnUPZFnQGLr9zn7kDa8rlwkv1x1z+lX2/79rF
	IkqcBOPR9M6UeqhQZgXqY2HybtCot4ysX71KcBFtHx9hQuFoecQgJilh
X-Gm-Gg: AZuq6aLoLLG7Kcwa9fknKnsmdYgPPPzpgwrS669WOuQFT8pQ4bu29ukFX2eNzHbNJq/
	G/bdmrZPiXHGUR0KaV0zjMxFVFjd8ELzr+jidfIit+ogIKN0nABnIvUg33vFZJ1IWo3cuc0SX8P
	Oxlq2jFeTGoBf+R3eTbG8L0P/XttVEhUQksIuCniAjH8HUIP9e+MSug+GUVgMUXMWNHGBP7CTw0
	nmiuNwSx76q5l3X/ezSOREY7eaH4fIneFncLEJjHiWbGillleqbic3EiEko823NJkSDEzZe69S6
	t6dJvd8tLNX3dPP7w7li//Etb3b9Gdcxd1JUHx7VX6Ct48xOV6CHPicwfzJxuAxnYYI5u8cI62x
	SFYxbCduPtmGmqmv13gaFua+ciy8R1b6xuvtWl+LA1150whMGou5g3gWyH14Z4QxuE73D1wc=
X-Received: by 2002:a05:600c:4f8a:b0:480:5678:1fdd with SMTP id 5b1f17b1804b1-483201dd265mr9118025e9.12.1770323235517;
        Thu, 05 Feb 2026 12:27:15 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::6:1325])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43629756ff1sm574143f8f.43.2026.02.05.12.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 12:27:15 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 05 Feb 2026 20:24:39 +0000
Subject: [PATCH RFC bpf-next 09/12] selftests/bpf: Add stress tests for
 resizable hash get_next_key
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-rhash-v1-9-30dd6d63c462@meta.com>
References: <20260205-rhash-v1-0-30dd6d63c462@meta.com>
In-Reply-To: <20260205-rhash-v1-0-30dd6d63c462@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, ameryhung@gmail.com, memxor@gmail.com, 
 puranjay@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770323224; l=5452;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=a2UC/WYp2CyoSH6ywPLqTDPmYw/yjplf8x4WFlOzSPQ=;
 b=DBylU5Vbv/Hjtje150LKzRwN5u5nRKnXr3VzJQc2asQt8qigl1blT2majCd+M1PbMazNd/9JN
 FvWlKyZA3p+BkuGEfg4IoUSF2i0M5VFzf5rr5tQQFflg9zUZ53gUFni
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Test get_next_key behavior under concurrent modification:
 * Resize test: verify all elements visited after resize trigger
 * Stress test: concurrent iterators and modifiers to detect races

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/prog_tests/rhash.c | 156 +++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/rhash.c      |   8 ++
 2 files changed, 164 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/rhash.c b/tools/testing/selftests/bpf/prog_tests/rhash.c
index d1557405e062851ba2ad3d7378049c93395e7943..689ba6d73a724e94c3845acaeca3c0a7b45a8c6d 100644
--- a/tools/testing/selftests/bpf/prog_tests/rhash.c
+++ b/tools/testing/selftests/bpf/prog_tests/rhash.c
@@ -132,6 +132,156 @@ static void rhash_spin_lock_test(void)
 	rhash__destroy(skel);
 }
 
+struct iter_thread_args {
+	int map_fd;
+	int stop;
+	int error;
+};
+
+static void *get_next_key_thread(void *arg)
+{
+	struct iter_thread_args *args = arg;
+	int key, next_key;
+	int i = 0;
+
+	for (i = 0; i < 1000; i++) {
+		if (READ_ONCE(args->stop))
+			break;
+
+		if (bpf_map_get_next_key(args->map_fd, NULL, &next_key) != 0) {
+			WRITE_ONCE(args->error, 1);
+			continue;
+		}
+
+		key = next_key;
+		while (bpf_map_get_next_key(args->map_fd, &key, &next_key) == 0)
+			key = next_key;
+	}
+
+	return (void *)0;
+}
+
+static void *modifier_thread(void *arg)
+{
+	struct iter_thread_args *args = arg;
+	int key, value;
+	int i;
+
+	for (i = 0; i < 10000; i++) {
+		if (READ_ONCE(args->stop))
+			break;
+
+		key = i;
+		value = i;
+		if (bpf_map_update_elem(args->map_fd, &key, &value, BPF_ANY))
+			WRITE_ONCE(args->error, 1);
+	}
+
+	return (void *)0;
+}
+
+static void rhash_get_next_key_stress_test(void)
+{
+	struct iter_thread_args args = {};
+	struct rhash *skel;
+	pthread_t iter_threads[2];
+	pthread_t mod_threads[2];
+	int key, value;
+	int err, i;
+	void *ret;
+
+	skel = rhash__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "rhash__open_and_load"))
+		return;
+
+	args.map_fd = bpf_map__fd(skel->maps.rhmap_iter);
+	args.stop = 0;
+	args.error = 0;
+
+	/* Pre-populate map */
+	for (i = 0; i < 50; i++) {
+		key = i;
+		value = i;
+		err = bpf_map_update_elem(args.map_fd, &key, &value, BPF_NOEXIST);
+		if (!ASSERT_OK(err, "initial insert"))
+			goto cleanup;
+	}
+
+	/* Iterator threads */
+	for (i = 0; i < 2; i++)
+		if (!ASSERT_OK(pthread_create(&iter_threads[i], NULL,
+					      &get_next_key_thread, &args),
+			       "pthread_create iter"))
+			goto cleanup;
+
+	/* Modifier threads */
+	for (i = 0; i < 2; i++)
+		if (!ASSERT_OK(pthread_create(&mod_threads[i], NULL,
+					      &modifier_thread, &args),
+			       "pthread_create mod"))
+			goto cleanup;
+
+	/* Wait for modifier threads to finish */
+	for (i = 0; i < 2; i++)
+		pthread_join(mod_threads[i], &ret);
+
+	/* Signal iterator threads to stop */
+	WRITE_ONCE(args.stop, 1);
+
+	/* Wait for iterator threads */
+	for (i = 0; i < 2; i++)
+		if (!ASSERT_OK(pthread_join(iter_threads[i], &ret), "pthread_join iter") ||
+		    !ASSERT_OK((long)ret, "iter thread ret"))
+			goto cleanup;
+
+	ASSERT_EQ(args.error, 0, "no infinite loop");
+
+cleanup:
+	rhash__destroy(skel);
+}
+
+static void rhash_get_next_key_resize_test(void)
+{
+	struct rhash *skel;
+	int key, next_key, value;
+	int visited[128] = {0};
+	int map_fd;
+	int err, i;
+
+	skel = rhash__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "rhash__open_and_load"))
+		return;
+
+	map_fd = bpf_map__fd(skel->maps.rhmap_iter);
+
+	/* Insert 100 elements - triggers resize */
+	for (i = 0; i < 100; i++) {
+		key = i;
+		value = i;
+		err = bpf_map_update_elem(map_fd, &key, &value, BPF_NOEXIST);
+		if (!ASSERT_OK(err, "insert elem"))
+			goto cleanup;
+	}
+
+	/* Iterate all elements */
+	err = bpf_map_get_next_key(map_fd, NULL, &next_key);
+	if (!ASSERT_OK(err, "get first key"))
+		goto cleanup;
+
+	do {
+		key = next_key;
+		ASSERT_NEQ(visited[key], 1, "unique keys");
+		visited[key] = 1;
+	} while (bpf_map_get_next_key(map_fd, &key, &next_key) == 0);
+
+	/* Verify all elements visited */
+	for (i = 0; i < 100; i++)
+		ASSERT_TRUE(visited[i], "element visited");
+
+cleanup:
+	rhash__destroy(skel);
+}
+
 void test_rhash(void)
 {
 	if (test__start_subtest("test_rhash_lookup_update"))
@@ -157,5 +307,11 @@ void test_rhash(void)
 
 	if (test__start_subtest("test_rhash_spin_lock"))
 		rhash_spin_lock_test();
+
+	if (test__start_subtest("test_rhash_get_next_key_resize"))
+		rhash_get_next_key_resize_test();
+
+	if (test__start_subtest("test_rhash_get_next_key_stress"))
+		rhash_get_next_key_stress_test();
 }
 
diff --git a/tools/testing/selftests/bpf/progs/rhash.c b/tools/testing/selftests/bpf/progs/rhash.c
index fba55b5d9ed2575a1a31c4d2247c1d76f10d6bb1..61eda618cf55dfd4938c818eb4db41a842869599 100644
--- a/tools/testing/selftests/bpf/progs/rhash.c
+++ b/tools/testing/selftests/bpf/progs/rhash.c
@@ -262,6 +262,14 @@ struct {
 	__type(value, struct lock_elem);
 } rhmap_lock SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_RHASH);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__uint(max_entries, 65536);
+	__type(key, int);
+	__type(value, int);
+} rhmap_iter SEC(".maps");
+
 SEC("cgroup/skb")
 int test_rhash_spin_lock(struct __sk_buff *skb)
 {

-- 
2.53.0

