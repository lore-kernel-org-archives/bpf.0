Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3011DA26
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 18:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710528550; cv=none; b=d6HD6I3J3Ww0XKRGHouZEcopT2b14XMzbodO0h7HuA3sBH2GfUH2AgAUHfnzu2JkoKtscwNVwblCeEJOMjc4qEx8fnOxOHBIwJ34H6EBCCvFvuRnpuHN0c6Ln7Q3EObJgFE5TYESIcD6R+PpE5/rAtgkOOQoOLo2dBnhcoDyUb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710528550; c=relaxed/simple;
	bh=uiZF4MEQM1xZU1C3ZBsHlhA2jP/kdEyxNArmYwOquOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=elr9ka5n7Mwmv5Tv5c1rInc5Z9+rSyu90ijGDVuEJ/fyZqJaxE9TdKlzPub4FwJXZGu8YIdjAdxrt4MHjkGJXP3wHdXWBSgxuNP25A3gUtZ46tc5ljhDGBhauUsO9ySAT0xlSxU+xRSSLW+D5enNfq6RLRsK3VgbFx4p62OGPhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id B5D501D1E5AD; Fri, 15 Mar 2024 11:48:54 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Yury Namgung <ynamgung@meta.com>
Subject: [PATCH bpf-next v2 1/5] bpf: Allow helper bpf_get_[ns_]current_pid_tgid() for all prog types
Date: Fri, 15 Mar 2024 11:48:54 -0700
Message-ID: <20240315184854.2975190-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240315184849.2974556-1-yonghong.song@linux.dev>
References: <20240315184849.2974556-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently bpf_get_current_pid_tgid() is allowed in tracing, cgroup
and sk_msg progs while bpf_get_ns_current_pid_tgid() is only allowed
in tracing progs.

We have an internal use case where for an application running
in a container (with pid namespace), user wants to get
the pid associated with the pid namespace in a cgroup bpf
program. Currently, cgroup bpf progs already allow
bpf_get_current_pid_tgid(). Let us allow bpf_get_ns_current_pid_tgid()
as well.

With auditing the code, bpf_get_current_pid_tgid() is also used
by sk_msg prog. But there are no side effect to expose these two
helpers to all prog types since they do not reveal any kernel specific
data. The detailed discussion is in [1].

So with this patch, both bpf_get_current_pid_tgid() and bpf_get_ns_curren=
t_pid_tgid()
are put in bpf_base_func_proto(), making them available to all
program types.

  [1] https://lore.kernel.org/bpf/20240307232659.1115872-1-yonghong.song@=
linux.dev/

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/cgroup.c      | 2 --
 kernel/bpf/helpers.c     | 4 ++++
 kernel/trace/bpf_trace.c | 4 ----
 net/core/filter.c        | 2 --
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 82243cb6c54d..8ba73042a239 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2575,8 +2575,6 @@ cgroup_current_func_proto(enum bpf_func_id func_id,=
 const struct bpf_prog *prog)
 	switch (func_id) {
 	case BPF_FUNC_get_current_uid_gid:
 		return &bpf_get_current_uid_gid_proto;
-	case BPF_FUNC_get_current_pid_tgid:
-		return &bpf_get_current_pid_tgid_proto;
 	case BPF_FUNC_get_current_comm:
 		return &bpf_get_current_comm_proto;
 #ifdef CONFIG_CGROUP_NET_CLASSID
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index a89587859571..9234174ccb21 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1730,6 +1730,10 @@ bpf_base_func_proto(enum bpf_func_id func_id, cons=
t struct bpf_prog *prog)
 		return &bpf_strtol_proto;
 	case BPF_FUNC_strtoul:
 		return &bpf_strtoul_proto;
+	case BPF_FUNC_get_current_pid_tgid:
+		return &bpf_get_current_pid_tgid_proto;
+	case BPF_FUNC_get_ns_current_pid_tgid:
+		return &bpf_get_ns_current_pid_tgid_proto;
 	default:
 		break;
 	}
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 0a5c4efc73c3..1b041911b1d8 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1525,8 +1525,6 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, co=
nst struct bpf_prog *prog)
 		return &bpf_ktime_get_boot_ns_proto;
 	case BPF_FUNC_tail_call:
 		return &bpf_tail_call_proto;
-	case BPF_FUNC_get_current_pid_tgid:
-		return &bpf_get_current_pid_tgid_proto;
 	case BPF_FUNC_get_current_task:
 		return &bpf_get_current_task_proto;
 	case BPF_FUNC_get_current_task_btf:
@@ -1582,8 +1580,6 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, co=
nst struct bpf_prog *prog)
 		return &bpf_send_signal_thread_proto;
 	case BPF_FUNC_perf_event_read_value:
 		return &bpf_perf_event_read_value_proto;
-	case BPF_FUNC_get_ns_current_pid_tgid:
-		return &bpf_get_ns_current_pid_tgid_proto;
 	case BPF_FUNC_ringbuf_output:
 		return &bpf_ringbuf_output_proto;
 	case BPF_FUNC_ringbuf_reserve:
diff --git a/net/core/filter.c b/net/core/filter.c
index 8adf95765cdd..0c66e4a3fc5b 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8342,8 +8342,6 @@ sk_msg_func_proto(enum bpf_func_id func_id, const s=
truct bpf_prog *prog)
 		return &bpf_event_output_data_proto;
 	case BPF_FUNC_get_current_uid_gid:
 		return &bpf_get_current_uid_gid_proto;
-	case BPF_FUNC_get_current_pid_tgid:
-		return &bpf_get_current_pid_tgid_proto;
 	case BPF_FUNC_sk_storage_get:
 		return &bpf_sk_storage_get_proto;
 	case BPF_FUNC_sk_storage_delete:
--=20
2.43.0

