Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C3C37C91B
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 20:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775592149; cv=none; b=UHJcV4ao5vcw1eNH+R2YIwy23ykMlo4TSDDtVuwVKauaDvwh0hn8SFvlVr8O0IYKmK1U1rjr39CpdHCGuZHCXQc+R8q7fZ8hgTRf3U7joTlCXpJ3ZHa+2EY2+l/j+YR12gvjQXkjmYAPyQiw/tZI2/jrl6yV+bBJt0EhQnhkOaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775592149; c=relaxed/simple;
	bh=2CMcW2gq2LmD6OBr8KShORwyqyftbdR5TuaGADyZZ7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oTGoY8mQe94ScvPwgs6sAs8gbczM40YtntUi389lZZCFQ/H+jEThBnKqIWmshMrqO1N9auXA5dbCS2L7p9socIyS00Yen/vBW81GkIrVOHDsUqP3/k7ORObtDRxRyacAb+YAPEkfU+BN6bwCP0Hmz/Y3HhmhwW5a80PYcop3nB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enO869OX; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enO869OX"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6507a9303fbso1373979d50.1
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 13:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775592145; x=1776196945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+Kz9KQLBOk2gZAk6F760LWdEiRy/BzHmk2mLo+ys2U=;
        b=enO869OX6+lKrCmPv3YMb9cY5TbheaTdV1u7lyE15BBCMX6+/kAW7K9mixbvUXkDOk
         Mosep08MeJflR2syvhe+4O/2FLii7ORtdQxHAafrfgnnGcly2EBeLZ+Za6bth08mGIBJ
         u7hT40BbJ5hnnkMsz7pBBCRmcP5a+//tdvHNZtznHKMKPqWXzOPl6qWDZQ0MmH0y+AnD
         Fp+xamww3eMWMeZ/mPXIkGkLoKupbX3ad3AwuUe2TBzWhQQ2GbraTTZjXkhwQrJB2FdO
         I1WMDga0aCrUD5X6hM4FnP6EE6kpUC7GYL6Ex7Ab6uO8qWAMmYI9Cdn1cGz3DSEiiKJP
         V7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775592145; x=1776196945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V+Kz9KQLBOk2gZAk6F760LWdEiRy/BzHmk2mLo+ys2U=;
        b=hUG9IDZ4DB0DghCBr7/Oyp59yc5/xeHn6W+mGl8W9fyMBLVdqA9iMk6KOOoIn1kNUu
         TSAe9NvJciFyQTplKRDCzy+FPUiLv+qUUTCA3KAYwAgXpB/48dZAfu0NlZEeone2zF1J
         tgJSu3m6APEuVKLlghGYE0+OjlAHmoUbW5cQmDZGDFEtkae/+e+cynkOdwCX8Aw6ALwV
         cOCogboxCldH+UWf+pwdCL5qx66vJtyxYP3V1zGdp4FFRuXx0rXzhsDjGfHn2GmREmYS
         PdrYnFHC44KmGNzcwXcolJhxEyqW8/gZ0APAhAe5Kt0veyHV4l0uNzJFs0fg0Moz6F9r
         dCxw==
X-Forwarded-Encrypted: i=1; AJvYcCWC2gCLMxMPLq8vd9B9xP2+9rxsgaZTlTntLQIUcWbt1q1YxKY28+hhLKvmHvFEFvRFYy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKtRK7Zpd9LCHaOr+RPJP1j/DHue/ikpLa3TLcF3uv87zA+hmq
	+QYDMiGs9z+O30EG1RDYQP7S3EPnNHzi+nOfIr0FWqyPD0Lg6lcixsWRvze2M5II
X-Gm-Gg: AeBDietrgsZaV528ngoqDEMlygGhJOoaJ64MZex15RBxJoy4xnF44YuJSTzxZaecw47
	K/8+WgP8+1/314iNHj88YNScB6cQxgtnuwLMNstgzBZjxPqR5g3PLJ3cPrwbxJNAeV7LocxyEKc
	Ie1A/CyQmIaLqo+K0jZBy4MCcxoW4QI5g9HdLbLt/am5SmvOsRAK1s5597T806iT1naT2l/n0XP
	GiO5bGQZGSVKim2GOxOKVYYDmnkSEFbAoJp2PYUY1JQndihWUgoR7t5N8+MWqUQjzHWc5kQ8ADK
	ImfHgbSvHpMhtTSNtzFYWpkSTlLG60yeaG3tGckCQkfbB5PO9P1aWm2tzulPAlRkLEWzIXoKiE7
	FNWrWa358LUsWvBvWK6Y9Emx9XX/1uWwOdA7zRjex0Lnx/Qs3SNl7XP+7YtiyhL1lqIGX0O9NXL
	bY4hZtrnOK4Wwrkt8HtVXxbB25Lsf5PRrgao13bEVxf1oghI2E0Hfixpn4wc+Osf+TMZEGKOTv
X-Received: by 2002:a05:690e:ee3:b0:649:b31e:8f48 with SMTP id 956f58d0204a3-6504871787bmr13350525d50.22.1775592145445;
        Tue, 07 Apr 2026 13:02:25 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:92f8:8594:e84e:1d9a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a828f3csm8354078d50.3.2026.04.07.13.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 13:02:25 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	paul@paul-moore.com,
	mic@digikod.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	kees@kernel.org
Cc: gnoack@google.com,
	jack@suse.cz,
	jmorris@namei.org,
	serge@hallyn.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	m@maowtm.org,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	skhan@linuxfoundation.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [RFC PATCH 07/20] bpf: arraymap: Implement Landlock ruleset map
Date: Tue,  7 Apr 2026 16:01:29 -0400
Message-ID: <20260407200157.3874806-8-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407200157.3874806-1-utilityemal77@gmail.com>
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement a new BPF map BPF_MAP_LANDLOCK_RULESET. This specialized map type
is designed to store ruleset file descriptors, and uses the exposed
Landlock helper functions to ensure that the ruleset isn't freed
unexpectedly. This map type may only be inserted into from userspace,
and only with a file descriptor referring to a valid Landlock ruleset.
Updating a Landlock ruleset directly through a map is not supported,
as there are no fields that can be changed, but you may add rules from
userspace as long as the file descriptor is open, or replace the fd with
another. Elements in a Landlock ruleset map may be deleted from
BPF or userspace. Looking up an element is supported only in BPF, this
is enforced with the map_lookup_elem_sys_only field in the map ops.

Reuse the existing fd_array_map operations for inserting and deleting to
avoid code duplication with existing FD maps.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 kernel/bpf/arraymap.c | 67 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 33de68c95ad8..f0da17e0e23e 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -8,6 +8,7 @@
 #include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/filter.h>
+#include <linux/landlock.h>
 #include <linux/perf_event.h>
 #include <uapi/linux/btf.h>
 #include <linux/rcupdate_trace.h>
@@ -1458,3 +1459,69 @@ const struct bpf_map_ops array_of_maps_map_ops = {
 	.map_mem_usage = array_map_mem_usage,
 	.map_btf_id = &array_map_btf_ids[0],
 };
+
+static int landlock_ruleset_map_alloc_check(union bpf_attr *attr)
+{
+	if (!IS_ENABLED(CONFIG_SECURITY_LANDLOCK))
+		return -EOPNOTSUPP;
+
+	return fd_array_map_alloc_check(attr);
+}
+
+static void landlock_ruleset_map_put_ptr(struct bpf_map *map, void *ptr,
+					 bool need_defer)
+{
+	if (!ptr)
+		return;
+
+	if (need_defer)
+		landlock_put_ruleset_deferred(ptr);
+	else
+		landlock_put_ruleset(ptr);
+}
+
+static void *landlock_ruleset_map_get_ptr(struct bpf_map *map,
+					  struct file *map_file, int fd)
+{
+	return landlock_get_ruleset_from_fd(fd, FMODE_CAN_READ);
+}
+
+static void *landlock_ruleset_map_lookup_elem(struct bpf_map *map, void *key)
+{
+	struct landlock_ruleset **elem, *ruleset;
+
+	rcu_read_lock();
+
+	elem = array_map_lookup_elem(map, key);
+	if (!elem) {
+		rcu_read_unlock();
+		return NULL;
+	}
+	ruleset = READ_ONCE(*elem);
+	if (!landlock_try_get_ruleset(ruleset))
+		ruleset = NULL;
+
+	rcu_read_unlock();
+
+	return ruleset;
+}
+
+static void landlock_ruleset_array_free(struct bpf_map *map)
+{
+	bpf_fd_array_map_clear(map, false);
+	fd_array_map_free(map);
+}
+
+const struct bpf_map_ops landlock_ruleset_map_ops = {
+	.map_alloc_check = landlock_ruleset_map_alloc_check,
+	.map_alloc = array_map_alloc,
+	.map_free = landlock_ruleset_array_free,
+	.map_get_next_key = bpf_array_get_next_key,
+	.map_lookup_elem_sys_only = fd_array_map_lookup_elem,
+	.map_lookup_elem = landlock_ruleset_map_lookup_elem,
+	.map_delete_elem = fd_array_map_delete_elem,
+	.map_fd_get_ptr = landlock_ruleset_map_get_ptr,
+	.map_fd_put_ptr = landlock_ruleset_map_put_ptr,
+	.map_mem_usage = array_map_mem_usage,
+	.map_btf_id = &array_map_btf_ids[0],
+};
-- 
2.53.0

