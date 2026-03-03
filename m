Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22313CF675
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 15:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772550521; cv=none; b=Q8Ivjs2Z28Jq7liZlG27Sd0VqJPRtlQM/gko0X0t2m+iloQg31nCV+cJcBXvFfikdu/OfDUKtRBrcUjJHQCm6u1Qh6eKFAL+hbRg4FQWsMjLMt1SjiYKcUxo0aCdIeP+WhXX/GmInGXJ440VtDQTcNZ2JrXLhRKOjyY2okt58ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772550521; c=relaxed/simple;
	bh=88APkzXUzBcpoVEx98UHhYf9o9mQ6vHOmCCUG2YOy04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gkMSJAj6CL6SWbD/YS+PuejoTFMwAPxkv3ATAvRmqY9mNjwYWUmgZBDUTKRz9n63tpvnn/DRm3jzSwhPDU/gkFJTbjDblG+p3fuSwGCmQFd4Cgj2frpOv66kR31WJHuW/mEQpxYZS+fOoVoJRBtGlyAWhmxQWH7zwdAn0ECT6TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g7G5UORV; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g7G5UORV"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772550512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bO/NxYW34GTHpn0u4+qdiD5ZslwztyQKNBkv7gNCLAY=;
	b=g7G5UORVnCOplR+p7RrK+cLcer0LEZPRJIpQpFnhMS4fP/5yvyI9bYjlflxwaMa1lOUJNx
	zT+v+fXRSWpF8AQcUYeckEoOkquY2xqO/jQZZlWob7xyfTbyAYM+z1gUskXiNq96kZWqvG
	ToHSgHLNQtLLywCkqXblBMxAplE1qH4=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Feng Yang <yangfeng@kylinos.cn>,
	Leon Hwang <leon.hwang@linux.dev>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v3 4/6] bpf: Disallow !call_get_func_ip progs tail-calling call_get_func_ip progs
Date: Tue,  3 Mar 2026 23:06:37 +0800
Message-ID: <20260303150639.85007-5-leon.hwang@linux.dev>
In-Reply-To: <20260303150639.85007-1-leon.hwang@linux.dev>
References: <20260303150639.85007-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Trampoline-based tracing programs that call bpf_get_func_ip() rely on
the func IP stored on the stack. Mixing !call_get_func_ip progs with
call_get_func_ip progs via tail calls could break this assumption.

To address this, reject the combination of !call_get_func_ip progs with
call_get_func_ip progs in bpf_map_owner_matches(), which prevents the
tail callee from getting a bogus func IP.

Also reject call_get_func_ip mismatches during initialization to
prevent bypassing the above restriction.

Without this check, the above restriction can be bypassed as follows.

struct {
	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
	__uint(max_entries, 1);
	__uint(key_size, sizeof(__u32));
	__uint(value_size, sizeof(__u32));
} jmp_table SEC(".maps");

SEC("?fentry")
int BPF_PROG(prog_a)
{
	bpf_printk("FUNC IP: 0x%llx\n", bpf_get_func_ip());
	bpf_tail_call_static(ctx, &jmp_table, 0);
	return 0;
}

SEC("?fentry")
int BPF_PROG(prog_b)
{
	bpf_tail_call_static(ctx, &jmp_table, 0);
	return 0;
}

The jmp_table is shared between prog_a and prog_b.

* Load prog_a first.
  At this point, owner->call_get_func_ip=true.
* Load prog_b next.
  At this point, prog_b passes the compatibility check.
* Add prog_a to jmp_table.
* Attach prog_b to a kernel function.

When the kernel function runs, prog_a will get a bogus func IP because
no func IP is prepared on the trampoline stack.

Fixes: 1e37392cccde ("bpf: Enable BPF_TRAMP_F_IP_ARG for trampolines with call_get_func_ip")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h |  1 +
 kernel/bpf/core.c   | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index dbafed52b2ba..fb978650b169 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -289,6 +289,7 @@ struct bpf_map_owner {
 	u32 xdp_has_frags:1;
 	u32 sleepable:1;
 	u32 kprobe_write_ctx:1;
+	u32 call_get_func_ip:1;
 	u64 storage_cookie[MAX_BPF_CGROUP_STORAGE_TYPE];
 	const struct btf_type *attach_func_proto;
 	enum bpf_attach_type expected_attach_type;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 121a697d4da5..d20a90bd1d2b 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2391,6 +2391,7 @@ static void bpf_map_owner_init(struct bpf_map_owner *owner, const struct bpf_pro
 	owner->xdp_has_frags = aux->xdp_has_frags;
 	owner->sleepable = fp->sleepable;
 	owner->kprobe_write_ctx = aux->kprobe_write_ctx;
+	owner->call_get_func_ip = fp->call_get_func_ip;
 	owner->expected_attach_type = fp->expected_attach_type;
 	owner->attach_func_proto = aux->attach_func_proto;
 	for_each_cgroup_storage_type(i)
@@ -2407,6 +2408,7 @@ static bool bpf_map_owner_matches(const struct bpf_map *map, const struct bpf_pr
 				  enum bpf_prog_type prog_type,
 				  enum bpf_map_owner_match_type match)
 {
+	bool has_trampoline = bpf_prog_has_trampoline(fp);
 	struct bpf_map_owner *owner = map->owner;
 	struct bpf_prog_aux *aux = fp->aux;
 	enum bpf_cgroup_storage_type i;
@@ -2422,11 +2424,19 @@ static bool bpf_map_owner_matches(const struct bpf_map *map, const struct bpf_pr
 	case BPF_MAP_OWNER_MATCH_FOR_INIT:
 		if (owner->kprobe_write_ctx != aux->kprobe_write_ctx)
 			return false;
+		if (has_trampoline) {
+			if (owner->call_get_func_ip != fp->call_get_func_ip)
+				return false;
+		}
 		break;
 
 	case BPF_MAP_OWNER_MATCH_FOR_UPDATE:
 		if (!owner->kprobe_write_ctx && aux->kprobe_write_ctx)
 			return false;
+		if (has_trampoline) {
+			if (!owner->call_get_func_ip && fp->call_get_func_ip)
+				return false;
+		}
 		break;
 	}
 
-- 
2.52.0

