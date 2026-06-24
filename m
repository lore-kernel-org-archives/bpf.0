Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5163016FB;
	Wed, 24 Jun 2026 02:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782269494; cv=none; b=nL9jEkgFL4fpwCQu/PthCtYGW3KlZBNQznQjUxGNUQDH0h9HLvbKvX+J83LIqKsr2EqWmE2nGcAM7gv4igq+RcYIoGs4W9virq74KRelU4DP0ERJOdgRZ0vKYcHGf7OUkARb93YgqPHwv2RKNrUYNtj/ZJis+PeHQUPcqx+E2x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782269494; c=relaxed/simple;
	bh=fPIVqSJCcsQScP7TwUl9phR8iELY/moKdlQw1aH1uJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SfajpxD8b4WIzt87vUtX1eOElwvGGUaFhFZuNxnLjQCBgAmrz5YfzyWwZv6y1Ms8p3ADwYiaXF11ew9VKxzc7coiYPBxbsvvTd12r50LdIhakbwizhtVre4jOYBZaV08szuHxO0d/i7ry89C52kfK9g2rQigjNzxZQIq4JQHMns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=nNI1FJRE; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="nNI1FJRE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782269483;
	bh=5yxN/1IvKThw1JjCQd/IZSHv2Hia7xyKRgYH0O7xbk8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=nNI1FJRE3iFmmiWMDiWyKirR3WvrgHoc7WaTRrLfWqKfYRLnN0s/8zCrMMXiHZO+9
	 hlROGqDeNKryLvSrAMLOqj0p1FKrQDXYYs81aTeSNvyoGdmlDnV1GWCr7mPa3j3HZR
	 dXRM1NXQd0bSYPG4A5vFCBDYB4HobXvb97UA6VD8=
X-QQ-mid: zesmtpsz7t1782269466tb05932f9
X-QQ-Originating-IP: g+DCklIsC0piJMh3ka51JXJyT44tBqh6xQ1mjjnfyT4=
Received: from Shurima ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 24 Jun 2026 10:51:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3230630873348648636
EX-QQ-RecipientCnt: 15
From: Yichong Chen <chenyichong@uniontech.com>
To: emil@etsalapatis.com,
	qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: chenyichong@uniontech.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	jiayuan.chen@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] tools/bpf/bpftool: Reset vmlinux BTF after map commands
Date: Wed, 24 Jun 2026 10:50:54 +0800
Message-ID: <9072F43B3F74DF91+20260624025055.1574875-2-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260624025055.1574875-1-chenyichong@uniontech.com>
References: <20260624025055.1574875-1-chenyichong@uniontech.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MSyoPQEuxKCufXIAQmOtfcb0ubui4IBKhnp7POCzjyEGqgLBioo/QjrR
	5ewTDviRy15qivWEh9HDnEst6Yq9f2B9OjjweA48OfiYv9Jm39UI+zxM21nlU+yUT9wZzOm
	3Na/4ZZpbBaVXRnvCffA61szCkGjrWTuSSw0yIefY9dK+gajdH1sFbnxNLNLAh4nG+tZKSu
	2KAhJ9W30nE7usZzZ3F2tyvF6jfYOaT5gJxgMxcU611eTTX2+q/m6FJfnieHPvrYysrd/Dt
	D38DXgoSF/t3LBSzIsJ7O0beqrAcmg43h+15b5hzNCdqcdANrjAfOfylaE2gBRm6/wfHGQ/
	PD0kDkuLFoSAb6tDlWawiJ4REvmA1OJRfYigLSvpSG9IbWWMr7BGXVcX+ai/xCoBq/rqLZb
	rH8rP3OCNrax6hiHGVnzpx99UPRInQxyWIlqBu/TiTlPnGf4+MtQ76afcV1qG7MhO+5EMC9
	m0vJjt8LbpIm1n7cKUUnCbrtxFxw1VdbeGZdAOn3NWaQBhgyJHy6viOldXDqoEAiypBe/LP
	WAyHbekRq34nORpKIvqeRh39urc8XZdzTVsV3Wez/TF86jCRShAL/dEkhPoUUnbyQryLv44
	+AHa6JLAErjRjhgBcfRN2Leipxj7iNVvXQHbMegScEsCyNFhsCEXJ7GJQfBXbkSVkeAYhXP
	MCZsKOb5utFBH1ZuYdZ0ZpVWpHlojmIPTinFJFNqY/37iTW6+7bL1+w5m0sTIPGZYuftybF
	9OgLqipmt2n1WCxXG7MfXVnBLUkqXWFE9oWYV/Cww7Dpfliz0oFC8ylpipFkm5o/W8xcAW7
	/j3qAcNCeZueFVLGuVaUCq/3HDS+Jy3dl66PI6vjd7NpEt06DkGe10hl8cbr2Exof2xnE9Q
	LViiQaRQazlvTY++51K2/xLCuNQq8Bk6UN8KyCOn8qK7JNLHmC66OFk8hjBIU6sbhRGNMKD
	e7nznI8GTlqgS1kwVtuXb7EZ5up3MVzyAJMsojQW0kVEr7H3ulm7554dHSdLQ7BVyiR5tSx
	sLY8way8CYsyncbG8qPuHFSJL2Mb7eJdoJNdXVeqV3lwdAVDpocgoJIFTVB1sQISbX0NWrR
	hRsOGFtM2SMmpHG6C1m/3E=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

get_map_kv_btf() caches the vmlinux BTF object when a map uses
btf_vmlinux_value_type_id. map dump released that object when the
command completed, but left the global pointer stale.

The same cached object can also be returned to print_key_value(), which
freed it directly. That leaves btf_vmlinux dangling before the command
cleanup path runs.

Use free_map_kv_btf() for per-entry cleanup, and reset the cached
btf_vmlinux pointer when the map command releases the object. This keeps
batch mode from reusing a freed BTF object.

Fixes: 4e1ea33292ff ("bpftool: Support dumping a map with btf_vmlinux_value_type_id")
Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/bpf/bpftool/map.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 7ebf7dbcfba4..a265ad3afbb0 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -790,6 +790,12 @@ static int maps_have_btf(int *fds, int nb_fds)
 
 static struct btf *btf_vmlinux;
 
+static void free_btf_vmlinux(void)
+{
+	btf__free(btf_vmlinux);
+	btf_vmlinux = NULL;
+}
+
 static int get_map_kv_btf(const struct bpf_map_info *info, struct btf **btf)
 {
 	int err = 0;
@@ -958,7 +964,7 @@ static int do_dump(int argc, char **argv)
 		close(fds[i]);
 exit_free:
 	free(fds);
-	btf__free(btf_vmlinux);
+	free_btf_vmlinux();
 	return err;
 }
 
@@ -1049,7 +1055,7 @@ static void print_key_value(struct bpf_map_info *info, void *key,
 		btf_wtr = get_btf_writer();
 		if (!btf_wtr) {
 			p_info("failed to create json writer for btf. falling back to plain output");
-			btf__free(btf);
+			free_map_kv_btf(btf);
 			btf = NULL;
 			print_entry_plain(info, key, value);
 		} else {
@@ -1065,7 +1071,7 @@ static void print_key_value(struct bpf_map_info *info, void *key,
 	} else {
 		print_entry_plain(info, key, value);
 	}
-	btf__free(btf);
+	free_map_kv_btf(btf);
 }
 
 static int do_lookup(int argc, char **argv)
-- 
2.51.0

