Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3888D47F2F8
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 15:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772550525; cv=none; b=cZDMU3nBIySpVkrNc92YK6LoD63PLQCBXdyFkOaxCyJ5FrTuAywKh65oZ+q9CAXWCxcG/po1UQEkW9iu2sHdnZT2WUUopryvp1tpM5tuEq/U0LmTQvZLrv2tmL4DoEJNPf06DLbGY7pdLFXydVi4s5aFD1snt19xqXuUciFozhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772550525; c=relaxed/simple;
	bh=L2Qr5aAsgygODzuECKeOy83yrIyy1pX5bOXrf2pkTFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZ1Qc9AozguFGaZvRsmp2JRlGMJAWzRnqeNvWw5/UVoy9Ez+CvVbl1HxVqNR0chu3ABn0jBe8K/6TZ2lZlI8REskJO5LRD4lLCWixbJtdKRx/THLaifpMU9NNrlN1vlNmI9uMq77l+q5THucpTVMyJkcZ1Qb1bv52BmDTuO6Kho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c60CHyuJ; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c60CHyuJ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772550522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=To4DK5qCEnIcL4mbKSZPBkRD+y6r23+cgxWeg9hvTJ8=;
	b=c60CHyuJ+i4Mmd4UnShODEixRvSpLZDuNZn4FBK4c6Zuy5DgFpzQa6zV7pogm2VUNc9wek
	GPW+iqMkzYEQdJSzzP0YapdHyQkHsgNG+dIJJa0GMwPwOVRk0keAyd3zOUoJFKkbjF03Nd
	CMVG0ZBqeUdcwL+g6vBEwVDdCwyO+kk=
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
Subject: [PATCH bpf-next v3 5/6] bpf: Disallow !call_session_cookie progs tail-calling call_session_cookie progs
Date: Tue,  3 Mar 2026 23:06:38 +0800
Message-ID: <20260303150639.85007-6-leon.hwang@linux.dev>
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

Fsession progs that call bpf_session_cookie() kfunc depend on
consistent session metadata stored on the stack. Mixing
!call_session_cookie progs with call_session_cookie progs via tail
calls could break this assumption.

To address this, reject the combination of !call_session_cookie progs
with call_session_cookie progs in bpf_map_owner_matches(), which
prevents the tail callee from accessing a bogus session cookie.

Also reject call_session_cookie mismatches during initialization to
prevent bypassing the above restriction.

Without this check, the above restriction can be bypassed as follows.

struct {
	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
	__uint(max_entries, 1);
	__uint(key_size, sizeof(__u32));
	__uint(value_size, sizeof(__u32));
} jmp_table SEC(".maps");

SEC("?fsession")
int BPF_PROG(prog_a)
{
	u64 *cookie = bpf_session_cookie(ctx);

        *cookie = 42;
	bpf_tail_call_static(ctx, &jmp_table, 0);
	return 0;
}

SEC("?fsession")
int BPF_PROG(prog_b)
{
	bpf_tail_call_static(ctx, &jmp_table, 0);
	return 0;
}

The jmp_table is shared between prog_a and prog_b.

* Load prog_a first.
  At this point, owner->call_session_cookie=true.
* Load prog_b next.
  At this point, prog_b passes the compatibility check.
* Add prog_a to jmp_table.
* Attach prog_b to a kernel function.

When the kernel function runs, prog_a will get a u64 pointer to the
first arg slot on the trampoline stack, and will modify the arg via this
pointer.

Fixes: eeee4239dbb1 ("bpf: support fsession for bpf_session_cookie")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h | 1 +
 kernel/bpf/core.c   | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index fb978650b169..3931fdbca3a7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -290,6 +290,7 @@ struct bpf_map_owner {
 	u32 sleepable:1;
 	u32 kprobe_write_ctx:1;
 	u32 call_get_func_ip:1;
+	u32 call_session_cookie:1;
 	u64 storage_cookie[MAX_BPF_CGROUP_STORAGE_TYPE];
 	const struct btf_type *attach_func_proto;
 	enum bpf_attach_type expected_attach_type;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index d20a90bd1d2b..5f46ac2c869b 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2392,6 +2392,7 @@ static void bpf_map_owner_init(struct bpf_map_owner *owner, const struct bpf_pro
 	owner->sleepable = fp->sleepable;
 	owner->kprobe_write_ctx = aux->kprobe_write_ctx;
 	owner->call_get_func_ip = fp->call_get_func_ip;
+	owner->call_session_cookie = fp->call_session_cookie;
 	owner->expected_attach_type = fp->expected_attach_type;
 	owner->attach_func_proto = aux->attach_func_proto;
 	for_each_cgroup_storage_type(i)
@@ -2427,6 +2428,8 @@ static bool bpf_map_owner_matches(const struct bpf_map *map, const struct bpf_pr
 		if (has_trampoline) {
 			if (owner->call_get_func_ip != fp->call_get_func_ip)
 				return false;
+			if (owner->call_session_cookie != fp->call_session_cookie)
+				return false;
 		}
 		break;
 
@@ -2436,6 +2439,8 @@ static bool bpf_map_owner_matches(const struct bpf_map *map, const struct bpf_pr
 		if (has_trampoline) {
 			if (!owner->call_get_func_ip && fp->call_get_func_ip)
 				return false;
+			if (!owner->call_session_cookie && fp->call_session_cookie)
+				return false;
 		}
 		break;
 	}
-- 
2.52.0

