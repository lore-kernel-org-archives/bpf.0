Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793724958;
	b=nrCFXiQZG3lSIHTYtWO5Qa+PHqXWHATy+41ryy5wqfxw/FE+bN3/mC+PAaYVah99yOo/
	 Jr5TxwVZRQ13hzmouquDDFmzj5JeNcSRJNi4Vlpjb25aXcC0/SUT2TotXIDTC6oIP8T8T
	 Fuoq68N3OvR0wiz4tl7c/Rq9LfS3E3W1i7/cMV9o4a9zfLypssFWoAF4p1JsTj+hCbRv2
	 zSISJ0dYLTVcKE2p6Zg1WNyFlsqXUU/93lffJ82UfF2DPIGL06BfcmoTAOvOBihWs57Cz
	 laBlfFhF2C7BNl3qb5cEpYvKIN0xZ73xJo3gIM6b0KuvzhIQJpa8gr0xUU4+zxHAFIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793724958;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Dx0fQ9jWsbJGGEfFlztRkY1SCts3dYp3DMV0/n4sk/0=;
	b=vyLdFkKz2ixEXS+kNUaed3E/nyrjLHV8Pyo9STICgrfe+W26GXlCTcNuTp+jwcfDhoNU
	 tP3eAc2cAeWsG3QmLY+sTJRcqcsJNoNEdNvF9Hm1MGwaie8pGcxjZhdR/gF8xaCoGdkto
	 7LeMpVVy20bsL8i/KluKBAINyFnHniQYBpYFscGKdnpdOpfCHS7tI7IQQd6Q29HlFKZAA
	 PZzYaRFEBV3evg26/ucDDnXnqRAq/uwB0fMrjqRvy/2xujnww/FVgyWuyi6OArXVLLz/2
	 sBD0XYOxbXMYhbLBLIH9Q8DNqcrElS3phqW80N5tANLrSuJa5GSxOJQIYTJhqGWXtGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z920EnPC;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD132606A334
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 16:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD132606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z920EnPC
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso44376785e9.3
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 08:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793724956; x=1794329756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dx0fQ9jWsbJGGEfFlztRkY1SCts3dYp3DMV0/n4sk/0=;
        b=z920EnPCDnXnUS73ipITtZNX/YHqpZa0drLuvN0rSPm7+jJyQ2fp1Ei404814Vumuv
         o9lM1qdTr5rQc5+7Y/BApDoQZo0Nn2/tFgCV8cIqGBoEZl1PoHMX2m6xz1puawvkpFID
         /fOjaKp4rz2UehtNfnd5s++vuhjZX8RO0PBLrfU811mWZZZlsqy+QmWUmoasOTeJEskF
         d4lujM9f8yNwUYU4kDWcYHqiXn7hH5XhHk2KBL7D0oh2FGRBJaw389zcIjy3a/bgKL2g
         Mje31JrrxgfnG8VzL/WfyhYSiPL42fOUMLzes8zT5r3ct07qSCKg4lWrlOZyozQpaRuZ
         a84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793724956; x=1794329756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dx0fQ9jWsbJGGEfFlztRkY1SCts3dYp3DMV0/n4sk/0=;
        b=x+doXNqxGibOFUoRep7DYPeRSKZeFeVEHgxTof0qFlOSLwRVe4+0HF6dEx72OZ5yXp
         VqulDuLfOs+lQzr/KFYQAnn4shDLsbYeuFmDx9JXfFSzWCLMZ7Lzg4xR7lO+ltB9inxb
         qUxO/oow8+HYHQtghoYA9pCeQerz/EcVDoe0yWcdXhnRjW+XiozIRdAL9Uv7Mmwob896
         K/Fm7UHnkIL/0e7+cwpIeASUrvEMdbxaCyyzZYFscKSqeixBTAIUvle3I+ZpRniUCxFJ
         hLXSrxai9XADTulqcIqt7apTKxEoTkCNw9UMvxfCl3O7YoTmYOs5v/Ce3vxRDAk3NYtG
         ZSEQ==
X-Forwarded-Encrypted: i=1; AKwUvBxlJ+3K2Lv0UV7T+E/BHuCGa5XLJ8ebZIQLLZ/LxsqbSPLnFBghdR6WkD9KjchgBJGvBsM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Bifh82IwWM62KazsfrGUpL724YhwA4hFNS9enN3YiOU7AI8aZ
	4OLvLTeSkXB/GI83od8tTTa05IjyZOoXVMWkiXM+Ip49KiRJJWcgqNYY
X-Gm-Gg: AYBFou3I7/iFKzP5U9Nia6/l9KBvqeaGmmJgyS3omxYSP0w15orzFGyq5XeNtKKxcT1
	/aX4xZpiagqYEyDZtmKEWcs3PZQgIH/NZeoSBC7Oc0NtDxvqWQfG8XYDhi3BcgyzieJ9myfGA7C
	xeDVobdv8A/t9iKc492VD1iiJWnW925qmk3sGBAvN26xPiOLiBhm/6xtmAdgfdW6e2ncLfDqUCC
	+nYQoT+22vuScwMgv3ku96bsGL3EdoYI3hnw4z8I1Y6XgdZTHXEdKknORg1+Mc1Vr21Q6AiJjHa
	ZUeKnI6Lf6avDoi5BJMph2PxiJwdnPYzSDd4I5SXOlJV1kzWDUWsnzBqrMwM7Xck86WH5EzzTs9
	Zs4sYy2qU+SJsviie1GWArdyHzxprqt8EfHaulCSZF8oDduYP+V+A0YNsus4XfRvxDWJ5xa3UpK
	hu8A+RWpNSvQdfs4w9k4laUkhc2U+G3dnX2AzVLSJz8owSqCnxbHDLWiIK+vkF5IOL+gM41QW6b
	Oh7NsnHsi2g52WyVwpYfhzeienr95kZoPlDBW7cstJH3M5+Wh4jsHsH/9JW78R2UsZcde8Z944i
	CunzzioGeqUVHOlvdmxh1Vk1RoYb7oSfBrHIoTPsPQj3K1tvFO6dD0E5fdVcpbDwbcMa9rS5Th5
	/efRKj+Ef/S4/SKDIsBZvzyg=
X-Received: by 2002:a05:600c:870f:b0:4a2:1196:db0e with SMTP id 5b1f17b1804b1-4ac1899348bmr289523635e9.30.1793724956048;
        Tue, 03 Nov 2026 08:55:56 -0800 (PST)
Received: from andreayoga.wind3.hub ([31.189.68.219])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abea533a1esm239726215e9.1.2026.11.03.08.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 08:55:55 -0800 (PST)
From: Andrea Parri <parri.andrea@gmail.com>
To: kpsingh@kernel.org,
	matt@bobrowski.net,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: Andrea Parri <parri.andrea@gmail.com>,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	sdf@fomichev.me,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2] bpf, lsm: Fix cgroup shim selection for socket hooks
Date: Tue,  3 Nov 2026 17:55:40 +0100
Message-ID: <20261103165541.291744-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
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

bpf_lsm_find_cgroup_shim() picks the shim that runs a BPF_LSM_CGROUP
program from the first argument of the attached hook. It compares
args[0].type, the BTF id of the argument's pointer type, against
btf_sock_ids[], which holds the struct ids of struct socket and struct
sock. A pointer id is never equal to a struct id, so neither branch is
taken and every cgroup LSM program runs through
__cgroup_bpf_run_lsm_current().

Socket and sock hooks therefore run against task_dfl_cgroup(current)
instead of the socket's cgroup. When a socket is used from a cgroup other
than the one that created it, the caller's cgroup policy is applied instead
of the socket's, and __cgroup_bpf_run_lsm_socket() and
__cgroup_bpf_run_lsm_sock() are dead code.

Resolve the argument's pointee with btf_type_resolve_ptr() and compare that
id against btf_sock_ids[].

Two socket hooks are not always called with a usable socket:
ip_cmsg_recv_security() passes a NULL socket to socket_getpeersec_dgram,
and sock_create_lite() calls socket_post_create before sock->sk is set.
Add both to bpf_lsm_current_hooks, so that their cgroup does not depend on
the caller.

socket_post_create is unchanged when called from __sock_create(), where
the current task allocates the sk and gives it its cgroup.
socket_getpeersec_dgram keeps the current cgroup, as today. The other
socket hooks always get a socket with an sk, and the sock hooks a non-NULL
sk.

Existing BPF_LSM_CGROUP users will see a behavior change. The other socket
and sock hooks now run the socket's cgroup programs, as described in
commit 69fd337a975c ("bpf: per-cgroup lsm flavor"). Hooks that can run in
softirq, such as socket_sock_rcv_skb, inet_conn_request and sk_getsecid,
no longer depend on which task was interrupted.

The bug was found with the help of an LLM.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
v2:
- Add socket_post_create and socket_getpeersec_dgram to
  bpf_lsm_current_hooks instead of falling back to the current cgroup in
  __cgroup_bpf_run_lsm_socket() (Alexei)
- Drop Fixes: and Cc: stable, target bpf-next (Alexei)

v1: https://lore.kernel.org/bpf/20261102152913.366237-1-parri.andrea@gmail.com/

 kernel/bpf/bpf_lsm.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index f58dce888ff4a..485e8fe8524c8 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -66,6 +66,10 @@ BTF_SET_START(bpf_lsm_current_hooks)
 #ifdef CONFIG_SECURITY_NETWORK
 BTF_ID(func, bpf_lsm_sk_alloc_security)
 BTF_ID(func, bpf_lsm_sk_free_security)
+/* sock->sk is NULL in sock_create_lite() */
+BTF_ID(func, bpf_lsm_socket_post_create)
+/* sock is NULL in ip_cmsg_recv_security() */
+BTF_ID(func, bpf_lsm_socket_getpeersec_dgram)
 #endif
 BTF_SET_END(bpf_lsm_current_hooks)
 
@@ -95,6 +99,7 @@ void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog,
 			     bpf_func_t *bpf_func)
 {
 	const struct btf_param *args __maybe_unused;
+	u32 id __maybe_unused = 0;
 
 	if (btf_type_vlen(prog->aux->attach_func_proto) < 1 ||
 	    btf_id_set_contains(&bpf_lsm_current_hooks,
@@ -105,10 +110,12 @@ void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog,
 
 #ifdef CONFIG_NET
 	args = btf_params(prog->aux->attach_func_proto);
+	/* args[0].type is the id of the pointer. btf_sock_ids[] has structs. */
+	btf_type_resolve_ptr(prog->aux->attach_btf, args[0].type, &id);
 
-	if (args[0].type == btf_sock_ids[BTF_SOCK_TYPE_SOCKET])
+	if (id == btf_sock_ids[BTF_SOCK_TYPE_SOCKET])
 		*bpf_func = __cgroup_bpf_run_lsm_socket;
-	else if (args[0].type == btf_sock_ids[BTF_SOCK_TYPE_SOCK])
+	else if (id == btf_sock_ids[BTF_SOCK_TYPE_SOCK])
 		*bpf_func = __cgroup_bpf_run_lsm_sock;
 	else
 #endif
-- 
2.53.0

