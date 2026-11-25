Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577454;
	b=Clm8KzCFLv1pCkB5c/Z6ufVUKbdWHgRemq8hdRb3wYgezoz1lFHm+WaHOhq0JV6gcNEv
	 k5A6OFNTPDHZaWCuSihZUGuluZk7fqFnxCUfJOBMbxGVHPa9Q7dWhOXlUmWwEt1IugwIM
	 0Mu6Y4tjxkb/SXfX6isXL3XwfJY1aclZMAQkX8s6Rxh44hE7JhXGilKDYiLf94Z5SOmXx
	 LI+ASPpeI6K/JgXiriS2644fzdXusHPsl359sctTcG2MBE9t7qO3RkDBMcgQrxFClA83R
	 ILuwL8lSng0B68nd/WmzkH+U23As8sKQaKhIAo+B0qVrUkjW008KKhkqngCTvTNhGvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577454;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Gi3nAP5S9cUUD4uvUufAsZ4GCs7hvUo9XzPnxaWoezI=;
	b=CUhJfbsdO81USLzxNVFiHPaR4L3m4gSj25nXsUUBOcFEyjf0ympmcsEoYPn9a/q2bBAH
	 jy1QL4aqsCBWi3hukCFqZWwNHcG6Q3CM/eHCetpJqMNzdRZRBeWQjbFYQCNtIvNVv5j/d
	 jWMygwXUir7ZlGFTC93OEqRhO+0M8/SIvsHIpsgCAq/wyU3dphDRgmC4i6w083ebQ0f7I
	 MUfJmXPm1E9a/EplSYLbtSjkBR/IMrnb+I4h88Y5pUG7Pb63kdaSRbRRyLRi0zPamGuoy
	 qZLw8DnKbs3tS5BtTrvNhI6PEHx25XjEMw10GhdEEvedhTpOH+Tjus3oerQN7CmwuRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YlTnc7Xe;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC24606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DC24606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YlTnc7Xe
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2f020d0169eso25462505ad.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577453; x=1796182253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gi3nAP5S9cUUD4uvUufAsZ4GCs7hvUo9XzPnxaWoezI=;
        b=YlTnc7Xer87VEKR6HL0KvUJzrHCeZlZ0Tc8qR5vQ5Yuz0uj9Lx91hfEofbZag0p+MS
         Bbbx2NjlzwSIlhpujRwSxT9bapnWUMLOBKX1O/T5xj461rS9XTI9A0uVGu0FTGYLiQYj
         7KZVa39O0DoQXx52G182AhSCfSlAMyrFm8fA+kD5mIibI3+PS1BznXZVOSxalpjWIYk9
         c4zsVILlplqUR6sGpe5sHS8mSobm6YlCuGxzXpLkojq2hQojZ3xz4RCiRWAwkS29S7pc
         2VcBzL2aQuDg8dy67sSIWsVpeLQmq/mhiKyTIHSSDs0JwezKNFU0PWStdRFBR4Z25N8x
         Y9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577453; x=1796182253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gi3nAP5S9cUUD4uvUufAsZ4GCs7hvUo9XzPnxaWoezI=;
        b=1rrM9oWnWSJa727TyP7hUjUxlOLnOibNc3uxkiROd3zcqVeVEisCwfjw3HmSFcwRI3
         5bA4/Hs1DXb+IgRqRMQWrQzt0kURoGQ+UQIHcEz87bQrTimSEej9msoI/bYr2ymNfXvB
         3mn55Ju2z7G8FWooGX4RHBS9oIEwNVUSRRZdEcPTQc1y/EOLKmzNF5+I1iEVQALuphpv
         lEYzqW6Cr/iTF3BoxXu+7HAOaPEqZtRA6i+lyqQIy2k7C0ntQ06Xtxvbef29RdhQMVi7
         MYfcxL2mwMWBKEU+gAT7tMwL8wD5ZQuScxDJjTNI7olPCV4Ho/kfBfXvaQhn8LNaPDAl
         W9Xw==
X-Gm-Message-State: APuU4Z/dUFU9BERlHSpyT73mvIrM4FMXbzo+JNipM42jl1rvY+ipI1YC
	8Unkkcp16wcFtOmGhT5YiGMd7eMAsxpWLduQ7RRhQYijS1KTV2gF76LnSFOgy+jn
X-Gm-Gg: AZFdTZfpUo0LFJjaD5hCOBAgIJqwf83+T55/+fD5gIyiddYUc3EIsHZqPy3t/HLvd6X
	3gmbM8OepTAw0cypBZMyyvFOb/j318TqzL6pCTVtLcj/+bzL/aB0KsIDlizr+67BpXfdqJF/dft
	aiUGSjbxtLKDJOgubg4Fz8fdDHbzChuX0BqypTFCx+Zi3Q5DtchAFW5Xz2nlyRoHGX+2X+rHkIs
	x+TMqdRiuaGr+fQpI9ZJBIUJjNcKL5tJA7bTlOcq3FWRu1AcRaN0Rv8+rC85mydO/TIRmxo/aEL
	2XYKJu6ytj8NYGSxWok7d6i8ooJD8s617ksRHVu+ILIAGnQR5sq0hRRSGYUaFBfG6mQsNDxRxqe
	CZFvSltA5sF0G6zwrwf5nzn5+LikQ6oGFnJ2/Jnb49HdcXfPiX2KovNNhkI3laMVUpwlJ8u4wbV
	bMau+ISngixyL8Y/+KqQFKFdbaemSkmrv+1+h5x00x9f3hoDf1Pl7jhOp9o4uJgDTlf2Am2gqqH
	NaCVUEiZ2jJh/0Ic3rvN7vEx31vOgCje2V72gjNWTNCcts8wGDQE6gYW8H1i7vAKQ4UO0n3fXTj
	/foYCNC1QY4dXa7YmBpGpYte24Pp72aWWCPfMB5xDB8dFEXga4zBFuU3lELD+iRXEE8OD44T9yT
	MQaRhKi3d1+SBHhrElIkpCeQlnpq3y22QyEOK2LJIlnjNWUYLVvQrraSc9A5h+IXRcp+4fSmPqw
	==
X-Received: by 2002:a17:903:b0e:b0:2eb:1bba:abbd with SMTP id d9443c01a7336-2f03f2069c2mr151346465ad.60.1795577453335;
        Tue, 24 Nov 2026 19:30:53 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f0bc695f31sm20269115ad.49.2026.11.24.19.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:30:53 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 12/47] bpf: Check for NULL in helpers that take a kernel pointer
Date: Wed, 25 Nov 2026 03:29:03 +0000
Message-ID: <20261125032938.670542-13-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

Helpers take a plain PTR_TO_BTF_ID, which can be NULL: an argument of
a traced function, or a member of a struct. Some do not check it:

  KASAN: null-ptr-deref in range [0x0000000000000048-0x000000000000004f]
  RIP: 0010:sock_from_file+0x22/0x70

bpf_task_pt_regs(), bpf_get_task_stack(), bpf_copy_from_user_task(),
bpf_xdp_get_buff_len(), bpf_getsockopt() and bpf_setsockopt() oops the
same way. So does bpf_d_path() on the path of a unix socket that is not
bound, it has no dentry.

Check for NULL, as bpf_find_vma() and bpf_skc_to_*() do.

Fixes: fa28dcb82a38 ("bpf: Introduce helper bpf_get_task_stack()")
Fixes: 6e22ab9da793 ("bpf: Add d_path helper")
Fixes: 4f19cab76136 ("bpf: Add a bpf_sock_from_file helper")
Fixes: 3cee6fb8e69e ("bpf: tcp: Support bpf_(get|set)sockopt in bpf tcp iter")
Fixes: dd6e10fbd9fb ("bpf: Add bpf_task_pt_regs() helper")
Fixes: d99173027d68 ("bpf: add frags support to xdp copy helpers")
Fixes: 376040e47334 ("bpf: Add bpf_copy_from_user_task() helper")
Fixes: 9113d7e48e91 ("bpf: expose bpf_{g,s}etsockopt to lsm cgroup")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/helpers.c     |  2 +-
 kernel/bpf/stackmap.c    |  2 +-
 kernel/trace/bpf_trace.c |  4 +++-
 net/core/filter.c        | 17 +++++++++++------
 4 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index bc0dd36a2799..749169a0b157 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -726,7 +726,7 @@ BPF_CALL_5(bpf_copy_from_user_task, void *, dst, u32, size,
 	if (unlikely(!size))
 		return 0;
 
-	mm = get_task_mm(tsk);
+	mm = tsk ? get_task_mm(tsk) : NULL;
 	if (!mm) {
 		memset(dst, 0, size);
 		return -EFAULT;
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index a19126f5db02..f25f5585e578 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -897,7 +897,7 @@ static long __bpf_get_task_stack(struct task_struct *task, void *buf, u32 size,
 	struct pt_regs *regs;
 	long res = -EINVAL;
 
-	if (!try_get_task_stack(task)) {
+	if (!task || !try_get_task_stack(task)) {
 		memset(buf, 0, size);
 		return -EFAULT;
 	}
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index bb79669d1cf4..19e6b51bb2f0 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -807,7 +807,7 @@ const struct bpf_func_proto bpf_get_current_task_btf_proto = {
 
 BPF_CALL_1(bpf_task_pt_regs, struct task_struct *, task)
 {
-	return (unsigned long) task_pt_regs(task);
+	return task ? (unsigned long)task_pt_regs(task) : 0;
 }
 
 BTF_ID_LIST_SINGLE(bpf_task_pt_regs_ids, struct, pt_regs)
@@ -946,6 +946,8 @@ BPF_CALL_3(bpf_d_path, const struct path *, path, char *, buf, u32, sz)
 	len = copy_from_kernel_nofault(&copy, path, sizeof(*path));
 	if (len < 0)
 		return len;
+	if (!copy.mnt || !copy.dentry)
+		return -EFAULT;
 
 	p = d_path(&copy, buf, sz);
 	if (IS_ERR(p)) {
diff --git a/net/core/filter.c b/net/core/filter.c
index 53c042b267ab..49eb26d016a1 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4215,10 +4215,15 @@ static const struct bpf_func_proto bpf_xdp_get_buff_len_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 };
 
+BPF_CALL_1(bpf_xdp_get_buff_len_trace, struct xdp_buff *, xdp)
+{
+	return xdp ? xdp_get_buff_len(xdp) : 0;
+}
+
 BTF_ID_LIST_SINGLE(bpf_xdp_get_buff_len_bpf_ids, struct, xdp_buff)
 
 const struct bpf_func_proto bpf_xdp_get_buff_len_trace_proto = {
-	.func		= bpf_xdp_get_buff_len,
+	.func		= bpf_xdp_get_buff_len_trace,
 	.gpl_only	= false,
 	.arg1_type	= ARG_PTR_TO_BTF_ID,
 	.arg1_btf_id	= &bpf_xdp_get_buff_len_bpf_ids[0],
@@ -5856,7 +5861,7 @@ static int sol_ipv6_sockopt(struct sock *sk, int optname,
 static int __bpf_setsockopt(struct sock *sk, int level, int optname,
 			    char *optval, int optlen)
 {
-	if (!sk_fullsock(sk))
+	if (!sk || !sk_fullsock(sk))
 		return -EINVAL;
 
 	if (level == SOL_SOCKET)
@@ -5879,7 +5884,7 @@ static bool is_locked_tcp_sock_ops(struct bpf_sock_ops_kern *bpf_sock)
 static int _bpf_setsockopt(struct sock *sk, int level, int optname,
 			   char *optval, int optlen)
 {
-	if (sk_fullsock(sk))
+	if (sk && sk_fullsock(sk))
 		sock_owned_by_me(sk);
 	return __bpf_setsockopt(sk, level, optname, optval, optlen);
 }
@@ -5889,7 +5894,7 @@ static int __bpf_getsockopt(struct sock *sk, int level, int optname,
 {
 	int err, saved_optlen = optlen;
 
-	if (!sk_fullsock(sk)) {
+	if (!sk || !sk_fullsock(sk)) {
 		err = -EINVAL;
 		goto done;
 	}
@@ -5916,7 +5921,7 @@ static int __bpf_getsockopt(struct sock *sk, int level, int optname,
 static int _bpf_getsockopt(struct sock *sk, int level, int optname,
 			   char *optval, int optlen)
 {
-	if (sk_fullsock(sk))
+	if (sk && sk_fullsock(sk))
 		sock_owned_by_me(sk);
 	return __bpf_getsockopt(sk, level, optname, optval, optlen);
 }
@@ -12469,7 +12474,7 @@ const struct bpf_func_proto bpf_skc_to_mptcp_sock_proto = {
 
 BPF_CALL_1(bpf_sock_from_file, struct file *, file)
 {
-	return (unsigned long)sock_from_file(file);
+	return file ? (unsigned long)sock_from_file(file) : 0;
 }
 
 BTF_ID_LIST(bpf_sock_from_file_btf_ids)
-- 
2.55.0

