Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401867;
	b=QjRBUHCJW1dcBoC7qvS0JeT2+dXN3ZvALsy9cWGXh2MdcFWmaTdVzNiDB6z80lkmHSyT
	 ttCwCrgGWDpkdDPd3bmkMwlQyrkd8Kj8APMrMi6N5mvoUmYTS8ue6tmuPpnlForcp2ceZ
	 /a5SVtOFLnHCWW/GK+t+x2RO6puoVB2w9UMF//jYZF+XLDnAbhFwHSY0AfCpKL/zl1WUg
	 j2hQEiWaLH89Ol7yBiIrc6apHnWQDkwcMH5avwBPJJFu4XvZl19etQ2VhBO0NnJdln2oS
	 jqCfVCZNVu8W/B6UUIT4GmkkSynmjjacnFLrzKo4EWEFcwU42Jq12DOQXSoKctBfEOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401867;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=GA7vhvxB7BrM238lnXPeLHxoMQc8StVQgpotm7rAFYg=;
	b=gm9oJCgjaQjTF41pjikbyxvjg78EN8iqztlSEysGXrtfpT5O1L8k9U7usvn1YmUQXWRf
	 92Zng0aaqk8zerPguP4RYry7uxzbJUnZ5IrGlEbJtUMRuhPl0XCCAR826tDzz49Sx7OVK
	 VVHNsRKLrUWrk7/1cP6bUPJ3Krmws4z4rhjBhFf5kx+iWBOQws//NKyUWUAoSW75JJE6f
	 QVOFFg2pBQw8o9Zj0yUrMwZQ5Svh4VfND3imELX3vXdFJ8gAQQlIIfqIjYzF4TNQk4zyR
	 okE+6p9d8Px1LdyUVx+rdSJGv/23qFZKbhwRMb/YUt4sGoFbIAgmFfDC64rKig3KZmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w3GUtuGV;
	arc=none smtp.remote-ip=74.125.225.134
Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B644F606A321
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 12:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B644F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w3GUtuGV
Received: by mail-wm2-f6.google.com with SMTP id 5b1f17b1804b1-4a35d5b19baso5741665e9.0
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 04:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794401865; x=1795006665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GA7vhvxB7BrM238lnXPeLHxoMQc8StVQgpotm7rAFYg=;
        b=w3GUtuGVPn5B4Vpv3cmBIswqZloxHqOaqhrtg4r5yb9gpN2dJFZDyrF3B19c/cvZ5C
         tiYbsaDOERoMZtlHvRnsoYL1O3Ok8h4v6wxu2u9/rfhJdDi/8x44lYLT10Ete2A2yiKr
         ty20ndNAZRBj8AbyyUNrzNBgsVGvNPNix8uX+fY8rNkLDm/CLO7JATWB3F4gdFrq1pQC
         kC6g3xx5vFlCfHcDXlTmywn91o24pu3vhBPXKSJhbiFzHuAqmsympetjoM18FEGCFx97
         w7sc88PMXlP+UrBfO4nr57Qa5lBDFH8vtZ+ZvocVCwgdSWHoTsWMqb1kr3db99eoR/fP
         RaLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794401865; x=1795006665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GA7vhvxB7BrM238lnXPeLHxoMQc8StVQgpotm7rAFYg=;
        b=2viWWc7dTTWYte0vnA3tfy7T40rhZZqkOQ5sCEAvi0F1dQQTGOq3OfogtgalQ3mMVW
         JMSe5Y2R6VUcxeK6jMwG3nw+Lvsw8/AP0RxOQHZDkYm/ZfjXvfEgVHmGRBZ9ut59NmkA
         lXPp0soXhu4lC1AsPW+oFCKYc/v0dpxvN67NsXToYldvhQw2eoeyghgYFJCtDcwIN54d
         zUM/8wOBCNtDVj7zCxLdUQ0hcKywqkAuX2AtpaoPCFI5G6++jXZiq8Tthb1+15GwqQ4d
         JY+e8tbykG21B0zkboo3FLFfqJyXnFsL0l6y6gvUEBDJkB/2Pt8Q7aE5wV+jbpFicqNI
         0GKA==
X-Gm-Message-State: APuU4Z+xrSazXcdar/cjSNps8H2cL398oAQXKUbAXblJL6owXS15vPlw
	4rRZKBuNN18qofIaB6XSLbce42a3GbnYWitTKctvnGlt/CUMdLEDL3aISV3eA5By65U=
X-Gm-Gg: AYBFou0R6dh2nOSwW2IQeaW+QNnUn1jOv6Txg8VOaroBg9w97YirU/lNhnS3Vkyclxl
	01pkGT+hGwMRoC9GqkaO5vQvnALySJpZM48baL+LA6HqVZEWn70/i08tbSDjLZ7CU8AjN7/3fDt
	qGECpxb4AhmY8jHXw2GDXel7q3sGhuJZ2oaYmKgEUvR9+FQ0S0XP+mhqqE9zbKcrBMQTM5Q1D+l
	4h6KEtNuAO2rqzuAo91YNjlycb3olmY13UJeR8s5j++MuyzFUGiU4En9P/GCu1pTk1UMM18Cwgn
	mk4LZdBjTqrWJ4Ab2QiXTEIP5EprmFO6qzQtmWaEbfd0arSSiVviyfIyedAqcIB9e1hJ+t3aT/I
	NaiYhPFFz4asr/f62ZVPnKuoDrrKAaRWfJc34ZtCGjjObmw1foUwcagjc9yKnv2KD8HiV1dMUs4
	zFJKB3gv3sb+eJHbpyQ7lejzPKxsY9TPSNxbDl/WEohR1HsixK/gWxZOZEKLQypKWo2d51S7bt+
	9SdRn3zICfhk3al4XsWFDOgrPTjwcKchJE9kGdoIryVx3wHdNe7/TSM2D5RoprzjkKrq8FtFzDp
	XwYiSTErrVYGe5zR6RbK70Zv/Ctambgst9FHWm7g/FrCgTIXFBknx2UwukMG1+6P8YLCe5kx7hO
	gnhdgH8MNcN5g3CwvU+kBZVXawAJkMwRqKVthykbxhDNtz+uFYAu2SF7ApTSi/5ZrMiHm
X-Received: by 2002:a05:600c:8708:b0:4a4:f48e:78fa with SMTP id 5b1f17b1804b1-4ba09382e1cmr47853835e9.12.1794401864859;
        Wed, 11 Nov 2026 04:57:44 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fe2c5asm212505805e9.5.2026.11.11.04.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:57:44 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 09/29] bpf: Register cleanup destructors for more types
Date: Wed, 11 Nov 2026 13:57:07 +0100
Message-ID: <552b16f22843843822ccf014138e390ac72909ab.1794399387.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794399387.git.memxor@gmail.com>
References: <cover.1794399387.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=28451; i=memxor@gmail.com; h=from:subject:message-id; bh=9mwRvGT5EoNB4N8mgUeQARh74z68sYgXrdBK+fNFv60=; b=kA0DAAoWRy03e2NUL4MByyZiAGr0XJ6jLBmWqdesE/zmx/Ymez0VG1vr1JHCeyf5roCRjvATN Yh1BAAWCgAdFiEEdP++AjPIeftRPaYLRy03e2NUL4MFAmr0XJ4ACgkQRy03e2NUL4PgVAEA1zqT y2hmdEazFxCp+6bEncnTqXdfsqu377I/RhSf8y4A/0HZ4lkL/YpOCeXjA5r/PnJ1XPiuKz+W34j Ujw6370kM
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Register a BPF_DTOR_CLEANUP entry for every referenced type that a
program can hold but that has no kptr destructor, so that an unwinder can
release the references a program holds when it throws. For an open-coded
iterator, the type is the iterator struct and the release kfunc is its
KF_ITER_DESTROY kfunc.

The release kfuncs take a typed pointer, and calling one through a
void (*)(void *) pointer is a kCFI violation. Each entry therefore uses a
void (*)(void *) wrapper next to the kfunc, as the kptr destructors do.

In kernel/bpf, these are the num, task, task_vma, css, css_task, bits,
kmem_cache and dmabuf iterators, and bpf_key. They are registered from
kfunc_init() with one list of ids per entry: the groups under
CONFIG_CGROUPS, CONFIG_KEYS and CONFIG_DMA_SHARED_BUFFER would otherwise
shift the indices of a single list. The common kfunc set contains the
iterator destroy kfuncs, so it is now registered before the destructors.

Outside kernel/bpf, these are:

 - xfrm_state and hid_bpf_ctx;
 - nf_conn, released by bpf_ct_release();
 - nf_conn___init, an entry that was allocated but not inserted. Its
   destructor frees the entry, as bpf_ct_insert_entry() does when the
   insert fails. bpf_ct_insert_entry() is the only kfunc that takes such
   an entry, so it is the release kfunc;
 - mem_cgroup, released by bpf_put_mem_cgroup();
 - file, released by bpf_put_file();
 - bpf_ws_lock, the wakeup sources read lock. Its handle is the SRCU
   index plus one, never a pointer;
 - the DSQ iterator of sched_ext;
 - cpumask, for the masks that sched_ext hands out.
   scx_bpf_put_cpumask() and scx_bpf_put_idle_cpumask() both do nothing,
   so one entry covers both.

bpf_testmod gets entries for its two iterators.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 drivers/base/power/wakeup.c                   | 25 +++++-
 drivers/hid/bpf/hid_bpf_dispatch.c            | 23 +++++
 drivers/hid/bpf/hid_bpf_dispatch.h            |  1 +
 fs/bpf_fs_kfuncs.c                            | 27 +++++-
 include/linux/bpf.h                           | 14 ++++
 include/net/netfilter/nf_conntrack_bpf.h      |  1 +
 include/net/xfrm.h                            |  1 +
 kernel/bpf/bpf_iter.c                         |  6 ++
 kernel/bpf/cgroup_iter.c                      |  6 ++
 kernel/bpf/dmabuf_iter.c                      |  6 ++
 kernel/bpf/helpers.c                          | 83 ++++++++++++++-----
 kernel/bpf/kmem_cache_iter.c                  |  6 ++
 kernel/bpf/task_iter.c                        | 18 ++++
 kernel/sched/ext/ext.c                        | 41 +++++++++
 mm/bpf_memcontrol.c                           | 28 ++++++-
 net/netfilter/nf_conntrack_bpf.c              | 38 +++++++++
 net/xfrm/xfrm_state_bpf.c                     | 26 +++++-
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 30 +++++++
 18 files changed, 350 insertions(+), 30 deletions(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 80b497de2deb..16ccafbfcd6b 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -1170,6 +1170,7 @@ static const struct file_operations wakeup_sources_stats_fops = {
 
 #ifdef CONFIG_BPF_SYSCALL
 #include <linux/btf.h>
+#include <linux/btf_ids.h>
 
 __bpf_kfunc_start_defs();
 
@@ -1202,6 +1203,12 @@ __bpf_kfunc void bpf_wakeup_sources_read_unlock(struct bpf_ws_lock *lock)
 	wakeup_sources_read_unlock((int)(long)lock - 1);
 }
 
+__bpf_kfunc void bpf_wakeup_sources_read_unlock_dtor(void *lock)
+{
+	bpf_wakeup_sources_read_unlock(lock);
+}
+CFI_NOSEAL(bpf_wakeup_sources_read_unlock_dtor);
+
 /**
  * bpf_wakeup_sources_get_head - Get the head of the wakeup sources list
  *
@@ -1224,9 +1231,25 @@ static const struct btf_kfunc_id_set wakeup_source_kfunc_set = {
 	.set   = &wakeup_source_kfunc_ids,
 };
 
+BTF_ID_LIST(wakeup_source_dtor_ids)
+BTF_ID(struct, bpf_ws_lock)
+BTF_ID(func, bpf_wakeup_sources_read_unlock_dtor)
+BTF_ID(func, bpf_wakeup_sources_read_unlock)
+
 static void __init wakeup_sources_bpf_init(void)
 {
-	if (register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &wakeup_source_kfunc_set))
+	const struct btf_id_dtor_kfunc wakeup_source_dtors[] = {
+		{
+			.btf_id         = wakeup_source_dtor_ids[0],
+			.kfunc_btf_id   = wakeup_source_dtor_ids[1],
+			.release_btf_id = wakeup_source_dtor_ids[2],
+			.flags          = BPF_DTOR_CLEANUP,
+		},
+	};
+
+	if (register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &wakeup_source_kfunc_set) ||
+	    register_btf_id_dtor_kfuncs(wakeup_source_dtors, ARRAY_SIZE(wakeup_source_dtors),
+					THIS_MODULE))
 		pm_pr_dbg("Wakeup: failed to register BTF kfuncs\n");
 }
 #else
diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index 6b467c74601c..897bae3f8c1b 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -357,6 +357,12 @@ hid_bpf_release_context(struct hid_bpf_ctx *ctx)
 	hid_put_device(hid);
 }
 
+__bpf_kfunc void hid_bpf_release_context_dtor(void *ctx)
+{
+	hid_bpf_release_context(ctx);
+}
+CFI_NOSEAL(hid_bpf_release_context_dtor);
+
 static int
 __hid_bpf_hw_check_params(struct hid_bpf_ctx *ctx, __u8 *buf, size_t *buf__sz,
 			  enum hid_report_type rtype, bool hw_request)
@@ -659,8 +665,21 @@ int hid_bpf_device_init(struct hid_device *hdev)
 }
 EXPORT_SYMBOL_GPL(hid_bpf_device_init);
 
+BTF_ID_LIST(hid_bpf_dtor_ids)
+BTF_ID(struct, hid_bpf_ctx)
+BTF_ID(func, hid_bpf_release_context_dtor)
+BTF_ID(func, hid_bpf_release_context)
+
 static int __init hid_bpf_init(void)
 {
+	const struct btf_id_dtor_kfunc hid_bpf_dtors[] = {
+		{
+			.btf_id         = hid_bpf_dtor_ids[0],
+			.kfunc_btf_id   = hid_bpf_dtor_ids[1],
+			.release_btf_id = hid_bpf_dtor_ids[2],
+			.flags          = BPF_DTOR_CLEANUP,
+		},
+	};
 	int err;
 
 	/* Note: if we exit with an error any time here, we would entirely break HID, which
@@ -681,6 +700,10 @@ static int __init hid_bpf_init(void)
 		return 0;
 	}
 
+	err = register_btf_id_dtor_kfuncs(hid_bpf_dtors, ARRAY_SIZE(hid_bpf_dtors), THIS_MODULE);
+	if (err)
+		pr_warn("error while registering HID BPF destructors: %d\n", err);
+
 	return 0;
 }
 
diff --git a/drivers/hid/bpf/hid_bpf_dispatch.h b/drivers/hid/bpf/hid_bpf_dispatch.h
index 44c6ea22233f..a198700a4394 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.h
+++ b/drivers/hid/bpf/hid_bpf_dispatch.h
@@ -16,6 +16,7 @@ void hid_put_device(struct hid_device *hid);
 int hid_bpf_allocate_event_data(struct hid_device *hdev);
 void __hid_bpf_ops_destroy_device(struct hid_device *hdev);
 int hid_bpf_reconnect(struct hid_device *hdev);
+void hid_bpf_release_context_dtor(void *ctx);
 
 struct bpf_prog;
 
diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 35ccd98a4de6..0c8e1d16a1ef 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -63,6 +63,12 @@ __bpf_kfunc void bpf_put_file(struct file *file)
 	fput(file);
 }
 
+__bpf_kfunc void bpf_put_file_dtor(void *file)
+{
+	bpf_put_file(file);
+}
+CFI_NOSEAL(bpf_put_file_dtor);
+
 /**
  * bpf_path_d_path - resolve the pathname for the supplied path
  * @path: path to resolve the pathname for
@@ -584,15 +590,28 @@ static const struct btf_kfunc_id_set bpf_fs_kfunc_set = {
 	.filter = bpf_fs_kfuncs_filter,
 };
 
+BTF_ID_LIST(bpf_fs_dtor_ids)
+BTF_ID(struct, file)
+BTF_ID(func, bpf_put_file_dtor)
+BTF_ID(func, bpf_put_file)
+
 static int __init bpf_fs_kfuncs_init(void)
 {
+	const struct btf_id_dtor_kfunc bpf_fs_dtors[] = {
+		{
+			.btf_id         = bpf_fs_dtor_ids[0],
+			.kfunc_btf_id   = bpf_fs_dtor_ids[1],
+			.release_btf_id = bpf_fs_dtor_ids[2],
+			.flags          = BPF_DTOR_CLEANUP,
+		},
+	};
 	int ret;
 
 	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_fs_kfunc_set);
-	if (ret || !IS_ENABLED(CONFIG_BINFMT_MISC_BPF))
-		return ret;
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
-					 &bpf_fs_kfunc_set);
+	if (!ret && IS_ENABLED(CONFIG_BINFMT_MISC_BPF))
+		ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &bpf_fs_kfunc_set);
+	return ret ?: register_btf_id_dtor_kfuncs(bpf_fs_dtors, ARRAY_SIZE(bpf_fs_dtors),
+						  THIS_MODULE);
 }
 
 late_initcall(bpf_fs_kfuncs_init);
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2b9adc4866bc..7f2db4e9afe0 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3301,6 +3301,19 @@ int bpf_iter_map_fill_link_info(const struct bpf_iter_aux_info *aux,
 int bpf_iter_map_check_value_write(const struct bpf_prog *prog,
 				   const struct bpf_map *map);
 
+/*
+ * void (*)(void *) wrappers of the open-coded iterator destroy kfuncs, which the BTF
+ * destructor registry refers to.
+ */
+void bpf_iter_num_destroy_dtor(void *it);
+void bpf_iter_task_destroy_dtor(void *it);
+void bpf_iter_task_vma_destroy_dtor(void *it);
+void bpf_iter_css_destroy_dtor(void *it);
+void bpf_iter_css_task_destroy_dtor(void *it);
+void bpf_iter_bits_destroy_dtor(void *it);
+void bpf_iter_kmem_cache_destroy_dtor(void *it);
+void bpf_iter_dmabuf_destroy_dtor(void *it);
+
 int map_set_for_each_callback_args(struct bpf_verifier_env *env,
 				   struct bpf_func_state *caller,
 				   struct bpf_func_state *callee);
@@ -4105,6 +4118,7 @@ struct bpf_key *bpf_lookup_system_key(u64 id);
 struct bpf_key *bpf_lookup_keyring(void);
 bool bpf_keyring_enforced(void);
 void bpf_key_put(struct bpf_key *bkey);
+void bpf_key_put_dtor(void *bkey);
 int bpf_verify_pkcs7_signature(const struct bpf_dynptr *data_p,
 			       const struct bpf_dynptr *sig_p,
 			       struct bpf_key *trusted_keyring);
diff --git a/include/net/netfilter/nf_conntrack_bpf.h b/include/net/netfilter/nf_conntrack_bpf.h
index 2d0da478c8e0..60ab309452c5 100644
--- a/include/net/netfilter/nf_conntrack_bpf.h
+++ b/include/net/netfilter/nf_conntrack_bpf.h
@@ -15,6 +15,7 @@ struct nf_conn___init {
 
 extern int register_nf_conntrack_bpf(void);
 extern void cleanup_nf_conntrack_bpf(void);
+void bpf_ct_release_dtor(void *nfct);
 
 #else
 
diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 298ca9bb0083..561418052d33 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -2378,6 +2378,7 @@ static inline int register_xfrm_interface_bpf(void)
 
 #if IS_ENABLED(CONFIG_DEBUG_INFO_BTF)
 int register_xfrm_state_bpf(void);
+void bpf_xdp_xfrm_state_release_dtor(void *x);
 #else
 static inline int register_xfrm_state_bpf(void)
 {
diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index f0b29a170935..c5cc7ed1b918 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -846,4 +846,10 @@ __bpf_kfunc void bpf_iter_num_destroy(struct bpf_iter_num *it)
 	/* no-op */
 }
 
+__bpf_kfunc void bpf_iter_num_destroy_dtor(void *it)
+{
+	bpf_iter_num_destroy(it);
+}
+CFI_NOSEAL(bpf_iter_num_destroy_dtor);
+
 __bpf_kfunc_end_defs();
diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
index fd51fe3d92cc..d1298d0d2404 100644
--- a/kernel/bpf/cgroup_iter.c
+++ b/kernel/bpf/cgroup_iter.c
@@ -372,4 +372,10 @@ __bpf_kfunc void bpf_iter_css_destroy(struct bpf_iter_css *it)
 {
 }
 
+__bpf_kfunc void bpf_iter_css_destroy_dtor(void *it)
+{
+	bpf_iter_css_destroy(it);
+}
+CFI_NOSEAL(bpf_iter_css_destroy_dtor);
+
 __bpf_kfunc_end_defs();
diff --git a/kernel/bpf/dmabuf_iter.c b/kernel/bpf/dmabuf_iter.c
index cd500248abd9..ac140a6cb570 100644
--- a/kernel/bpf/dmabuf_iter.c
+++ b/kernel/bpf/dmabuf_iter.c
@@ -189,4 +189,10 @@ __bpf_kfunc void bpf_iter_dmabuf_destroy(struct bpf_iter_dmabuf *it)
 		dma_buf_put(kit->dmabuf);
 }
 
+__bpf_kfunc void bpf_iter_dmabuf_destroy_dtor(void *it)
+{
+	bpf_iter_dmabuf_destroy(it);
+}
+CFI_NOSEAL(bpf_iter_dmabuf_destroy_dtor);
+
 __bpf_kfunc_end_defs();
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index cbed0c8952a7..cc6d3a6a4de0 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3725,6 +3725,12 @@ __bpf_kfunc void bpf_iter_bits_destroy(struct bpf_iter_bits *it)
 	bpf_mem_free(&bpf_global_ma, kit->bits);
 }
 
+__bpf_kfunc void bpf_iter_bits_destroy_dtor(void *it)
+{
+	bpf_iter_bits_destroy(it);
+}
+CFI_NOSEAL(bpf_iter_bits_destroy_dtor);
+
 /**
  * bpf_copy_from_user_str() - Copy a string from an unsafe user address
  * @dst:             Destination address, in kernel space.  This buffer must be
@@ -4584,6 +4590,12 @@ __bpf_kfunc void bpf_key_put(struct bpf_key *bkey)
 	kfree(bkey);
 }
 
+__bpf_kfunc void bpf_key_put_dtor(void *bkey)
+{
+	bpf_key_put(bkey);
+}
+CFI_NOSEAL(bpf_key_put_dtor);
+
 /**
  * bpf_verify_pkcs7_signature - verify a PKCS#7 signature
  * @data_p: data to verify
@@ -5314,16 +5326,40 @@ static const struct btf_kfunc_id_set user_mem_kfunc_set = {
 	.filter = user_mem_kfunc_filter,
 };
 
-BTF_ID_LIST(generic_dtor_ids)
-BTF_ID(struct, task_struct)
-BTF_ID(func, bpf_task_release_dtor)
-BTF_ID(func, bpf_task_release)
+/* A type, its void (*)(void *) destructor, and the kfunc a program calls to release it */
+#define BPF_DTOR_ID_LIST(name, type, dtor, release)	\
+BTF_ID_LIST(name)					\
+BTF_ID(struct, type)					\
+BTF_ID(func, dtor)					\
+BTF_ID(func, release)
+
+BPF_DTOR_ID_LIST(task_dtor_ids, task_struct, bpf_task_release_dtor, bpf_task_release)
+BPF_DTOR_ID_LIST(iter_num_dtor_ids, bpf_iter_num, bpf_iter_num_destroy_dtor, bpf_iter_num_destroy)
+BPF_DTOR_ID_LIST(iter_task_dtor_ids, bpf_iter_task, bpf_iter_task_destroy_dtor,
+		 bpf_iter_task_destroy)
+BPF_DTOR_ID_LIST(iter_task_vma_dtor_ids, bpf_iter_task_vma, bpf_iter_task_vma_destroy_dtor,
+		 bpf_iter_task_vma_destroy)
+BPF_DTOR_ID_LIST(iter_bits_dtor_ids, bpf_iter_bits, bpf_iter_bits_destroy_dtor,
+		 bpf_iter_bits_destroy)
+BPF_DTOR_ID_LIST(iter_kmem_cache_dtor_ids, bpf_iter_kmem_cache, bpf_iter_kmem_cache_destroy_dtor,
+		 bpf_iter_kmem_cache_destroy)
 #ifdef CONFIG_CGROUPS
-BTF_ID(struct, cgroup)
-BTF_ID(func, bpf_cgroup_release_dtor)
-BTF_ID(func, bpf_cgroup_release)
+BPF_DTOR_ID_LIST(cgroup_dtor_ids, cgroup, bpf_cgroup_release_dtor, bpf_cgroup_release)
+BPF_DTOR_ID_LIST(iter_css_dtor_ids, bpf_iter_css, bpf_iter_css_destroy_dtor, bpf_iter_css_destroy)
+BPF_DTOR_ID_LIST(iter_css_task_dtor_ids, bpf_iter_css_task, bpf_iter_css_task_destroy_dtor,
+		 bpf_iter_css_task_destroy)
+#endif
+#ifdef CONFIG_KEYS
+BPF_DTOR_ID_LIST(key_dtor_ids, bpf_key, bpf_key_put_dtor, bpf_key_put)
+#endif
+#ifdef CONFIG_DMA_SHARED_BUFFER
+BPF_DTOR_ID_LIST(iter_dmabuf_dtor_ids, bpf_iter_dmabuf, bpf_iter_dmabuf_destroy_dtor,
+		 bpf_iter_dmabuf_destroy)
 #endif
 
+#define BPF_DTOR_ENTRY(ids, dtor_flags)							\
+	{ .btf_id = ids[0], .kfunc_btf_id = ids[1], .release_btf_id = ids[2], .flags = dtor_flags }
+
 BTF_KFUNCS_START(common_btf_ids)
 BTF_ID_FLAGS(func, bpf_cast_to_kern_ctx, KF_FASTCALL)
 BTF_ID_FLAGS(func, bpf_rdonly_cast, KF_FASTCALL | KF_PERFMON)
@@ -5430,19 +5466,22 @@ static int __init kfunc_init(void)
 {
 	int ret;
 	const struct btf_id_dtor_kfunc generic_dtors[] = {
-		{
-			.btf_id         = generic_dtor_ids[0],
-			.kfunc_btf_id   = generic_dtor_ids[1],
-			.release_btf_id = generic_dtor_ids[2],
-			.flags          = BPF_DTOR_KPTR | BPF_DTOR_CLEANUP,
-		},
+		BPF_DTOR_ENTRY(task_dtor_ids, BPF_DTOR_KPTR | BPF_DTOR_CLEANUP),
+		BPF_DTOR_ENTRY(iter_num_dtor_ids, BPF_DTOR_CLEANUP),
+		BPF_DTOR_ENTRY(iter_task_dtor_ids, BPF_DTOR_CLEANUP),
+		BPF_DTOR_ENTRY(iter_task_vma_dtor_ids, BPF_DTOR_CLEANUP),
+		BPF_DTOR_ENTRY(iter_bits_dtor_ids, BPF_DTOR_CLEANUP),
+		BPF_DTOR_ENTRY(iter_kmem_cache_dtor_ids, BPF_DTOR_CLEANUP),
 #ifdef CONFIG_CGROUPS
-		{
-			.btf_id         = generic_dtor_ids[3],
-			.kfunc_btf_id   = generic_dtor_ids[4],
-			.release_btf_id = generic_dtor_ids[5],
-			.flags          = BPF_DTOR_KPTR | BPF_DTOR_CLEANUP,
-		},
+		BPF_DTOR_ENTRY(cgroup_dtor_ids, BPF_DTOR_KPTR | BPF_DTOR_CLEANUP),
+		BPF_DTOR_ENTRY(iter_css_dtor_ids, BPF_DTOR_CLEANUP),
+		BPF_DTOR_ENTRY(iter_css_task_dtor_ids, BPF_DTOR_CLEANUP),
+#endif
+#ifdef CONFIG_KEYS
+		BPF_DTOR_ENTRY(key_dtor_ids, BPF_DTOR_CLEANUP),
+#endif
+#ifdef CONFIG_DMA_SHARED_BUFFER
+		BPF_DTOR_ENTRY(iter_dmabuf_dtor_ids, BPF_DTOR_CLEANUP),
 #endif
 	};
 
@@ -5453,10 +5492,10 @@ static int __init kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &generic_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &generic_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SKB, &generic_kfunc_set);
-	ret = ret ?: register_btf_id_dtor_kfuncs(generic_dtors,
-						  ARRAY_SIZE(generic_dtors),
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &common_kfunc_set);
+	/* The destructors refer to release kfuncs of both sets, so they come last */
+	return ret ?: register_btf_id_dtor_kfuncs(generic_dtors, ARRAY_SIZE(generic_dtors),
 						  THIS_MODULE);
-	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &common_kfunc_set);
 }
 
 late_initcall(kfunc_init);
diff --git a/kernel/bpf/kmem_cache_iter.c b/kernel/bpf/kmem_cache_iter.c
index 3ae2158d767f..c629473a35ee 100644
--- a/kernel/bpf/kmem_cache_iter.c
+++ b/kernel/bpf/kmem_cache_iter.c
@@ -100,6 +100,12 @@ __bpf_kfunc void bpf_iter_kmem_cache_destroy(struct bpf_iter_kmem_cache *it)
 		kmem_cache_destroy(s);
 }
 
+__bpf_kfunc void bpf_iter_kmem_cache_destroy_dtor(void *it)
+{
+	bpf_iter_kmem_cache_destroy(it);
+}
+CFI_NOSEAL(bpf_iter_kmem_cache_destroy_dtor);
+
 __bpf_kfunc_end_defs();
 
 struct bpf_iter__kmem_cache {
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 2ee7b3b3c10b..df7c89fb61d0 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -1044,6 +1044,12 @@ __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
 	}
 }
 
+__bpf_kfunc void bpf_iter_task_vma_destroy_dtor(void *it)
+{
+	bpf_iter_task_vma_destroy(it);
+}
+CFI_NOSEAL(bpf_iter_task_vma_destroy_dtor);
+
 __bpf_kfunc_end_defs();
 
 #ifdef CONFIG_CGROUPS
@@ -1102,6 +1108,12 @@ __bpf_kfunc void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it)
 	bpf_mem_free(&bpf_global_ma, kit->css_it);
 }
 
+__bpf_kfunc void bpf_iter_css_task_destroy_dtor(void *it)
+{
+	bpf_iter_css_task_destroy(it);
+}
+CFI_NOSEAL(bpf_iter_css_task_destroy_dtor);
+
 __bpf_kfunc_end_defs();
 
 #endif /* CONFIG_CGROUPS */
@@ -1192,6 +1204,12 @@ __bpf_kfunc void bpf_iter_task_destroy(struct bpf_iter_task *it)
 {
 }
 
+__bpf_kfunc void bpf_iter_task_destroy_dtor(void *it)
+{
+	bpf_iter_task_destroy(it);
+}
+CFI_NOSEAL(bpf_iter_task_destroy_dtor);
+
 __bpf_kfunc_end_defs();
 
 DEFINE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index f74ffb3b1aca..0b75cdbf1b23 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -11068,6 +11068,12 @@ __bpf_kfunc void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it)
 	kit->dsq = NULL;
 }
 
+__bpf_kfunc void bpf_iter_scx_dsq_destroy_dtor(void *it)
+{
+	bpf_iter_scx_dsq_destroy(it);
+}
+CFI_NOSEAL(bpf_iter_scx_dsq_destroy_dtor);
+
 /**
  * scx_bpf_dsq_peek - Lockless peek at the first element.
  * @dsq_id: DSQ to examine.
@@ -11753,6 +11759,13 @@ __bpf_kfunc void scx_bpf_put_cpumask(const struct cpumask *cpumask)
 	 */
 }
 
+/* Releases what scx_bpf_put_idle_cpumask() does as well: neither holds a reference. */
+__bpf_kfunc void scx_bpf_put_cpumask_dtor(void *cpumask)
+{
+	scx_bpf_put_cpumask(cpumask);
+}
+CFI_NOSEAL(scx_bpf_put_cpumask_dtor);
+
 /**
  * scx_bpf_task_running - Is task the current scheduling context?
  * @p: task of interest
@@ -12328,8 +12341,30 @@ int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id)
 	return -EACCES;
 }
 
+BTF_ID_LIST(scx_dtor_ids)
+BTF_ID(struct, cpumask)
+BTF_ID(func, scx_bpf_put_cpumask_dtor)
+BTF_ID(func, scx_bpf_put_cpumask)
+BTF_ID(struct, bpf_iter_scx_dsq)
+BTF_ID(func, bpf_iter_scx_dsq_destroy_dtor)
+BTF_ID(func, bpf_iter_scx_dsq_destroy)
+
 static int __init scx_init(void)
 {
+	const struct btf_id_dtor_kfunc scx_dtors[] = {
+		{
+			.btf_id         = scx_dtor_ids[0],
+			.kfunc_btf_id   = scx_dtor_ids[1],
+			.release_btf_id = scx_dtor_ids[2],
+			.flags          = BPF_DTOR_CLEANUP,
+		},
+		{
+			.btf_id         = scx_dtor_ids[3],
+			.kfunc_btf_id   = scx_dtor_ids[4],
+			.release_btf_id = scx_dtor_ids[5],
+			.flags          = BPF_DTOR_CLEANUP,
+		},
+	};
 	int ret;
 
 	/*
@@ -12439,6 +12474,12 @@ static int __init scx_init(void)
 		return ret;
 	}
 
+	ret = register_btf_id_dtor_kfuncs(scx_dtors, ARRAY_SIZE(scx_dtors), THIS_MODULE);
+	if (ret) {
+		pr_err("sched_ext: Failed to register destructors (%d)\n", ret);
+		return ret;
+	}
+
 	ret = scx_idle_init();
 	if (ret) {
 		pr_err("sched_ext: Failed to initialize idle tracking (%d)\n", ret);
diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
index d8f579c28560..4cd37301df23 100644
--- a/mm/bpf_memcontrol.c
+++ b/mm/bpf_memcontrol.c
@@ -82,6 +82,12 @@ __bpf_kfunc void bpf_put_mem_cgroup(struct mem_cgroup *memcg)
 	css_put(&memcg->css);
 }
 
+__bpf_kfunc void bpf_put_mem_cgroup_dtor(void *memcg)
+{
+	bpf_put_mem_cgroup(memcg);
+}
+CFI_NOSEAL(bpf_put_mem_cgroup_dtor);
+
 /**
  * bpf_mem_cgroup_vm_events - Read memory cgroup's vm event counter
  * @memcg: memory cgroup
@@ -235,8 +241,21 @@ static const struct btf_kfunc_id_set bpf_memcontrol_reclaim_kfunc_set = {
 	.set            = &bpf_memcontrol_reclaim_kfuncs,
 };
 
+BTF_ID_LIST(bpf_memcontrol_dtor_ids)
+BTF_ID(struct, mem_cgroup)
+BTF_ID(func, bpf_put_mem_cgroup_dtor)
+BTF_ID(func, bpf_put_mem_cgroup)
+
 static int __init bpf_memcontrol_init(void)
 {
+	const struct btf_id_dtor_kfunc bpf_memcontrol_dtors[] = {
+		{
+			.btf_id         = bpf_memcontrol_dtor_ids[0],
+			.kfunc_btf_id   = bpf_memcontrol_dtor_ids[1],
+			.release_btf_id = bpf_memcontrol_dtor_ids[2],
+			.flags          = BPF_DTOR_CLEANUP,
+		},
+	};
 	int err;
 
 	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
@@ -248,8 +267,15 @@ static int __init bpf_memcontrol_init(void)
 
 	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
 					&bpf_memcontrol_reclaim_kfunc_set);
-	if (err)
+	if (err) {
 		pr_warn("error registering bpf reclaim kfuncs: %d\n", err);
+		return err;
+	}
+
+	err = register_btf_id_dtor_kfuncs(bpf_memcontrol_dtors, ARRAY_SIZE(bpf_memcontrol_dtors),
+					  THIS_MODULE);
+	if (err)
+		pr_warn("error registering bpf memcontrol destructors: %d\n", err);
 
 	return err;
 }
diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrack_bpf.c
index c2df7c948281..9d9d4e97ca4e 100644
--- a/net/netfilter/nf_conntrack_bpf.c
+++ b/net/netfilter/nf_conntrack_bpf.c
@@ -457,6 +457,22 @@ __bpf_kfunc void bpf_ct_release(struct nf_conn *nfct)
 	nf_ct_put(nfct);
 }
 
+__bpf_kfunc void bpf_ct_release_dtor(void *nfct)
+{
+	bpf_ct_release(nfct);
+}
+CFI_NOSEAL(bpf_ct_release_dtor);
+
+/*
+ * An entry that was allocated and not inserted has no reference to put: it is
+ * freed, as bpf_ct_insert_entry() does with one it cannot insert.
+ */
+__bpf_kfunc void bpf_ct_free_dtor(void *nfct)
+{
+	nf_conntrack_free(nfct);
+}
+CFI_NOSEAL(bpf_ct_free_dtor);
+
 /* bpf_ct_set_timeout - Set timeout of allocated nf_conn
  *
  * Sets the default timeout of newly allocated nf_conn before insertion.
@@ -537,12 +553,34 @@ static const struct btf_kfunc_id_set nf_conntrack_kfunc_set = {
 	.set   = &nf_ct_kfunc_set,
 };
 
+BTF_ID_LIST(nf_ct_dtor_ids)
+BTF_ID(func, bpf_ct_release_dtor)
+BTF_ID(func, bpf_ct_release)
+BTF_ID(func, bpf_ct_free_dtor)
+BTF_ID(func, bpf_ct_insert_entry)
+
 int register_nf_conntrack_bpf(void)
 {
+	/* The only kfunc that takes an allocated entry off a program is bpf_ct_insert_entry() */
+	const struct btf_id_dtor_kfunc nf_ct_dtors[] = {
+		{
+			.btf_id         = btf_nf_conn_ids[0],
+			.kfunc_btf_id   = nf_ct_dtor_ids[0],
+			.release_btf_id = nf_ct_dtor_ids[1],
+			.flags          = BPF_DTOR_CLEANUP,
+		},
+		{
+			.btf_id         = btf_nf_conn_ids[1],
+			.kfunc_btf_id   = nf_ct_dtor_ids[2],
+			.release_btf_id = nf_ct_dtor_ids[3],
+			.flags          = BPF_DTOR_CLEANUP,
+		},
+	};
 	int ret;
 
 	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &nf_conntrack_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &nf_conntrack_kfunc_set);
+	ret = ret ?: register_btf_id_dtor_kfuncs(nf_ct_dtors, ARRAY_SIZE(nf_ct_dtors), THIS_MODULE);
 	if (!ret) {
 		mutex_lock(&nf_conn_btf_access_lock);
 		nfct_btf_struct_access = _nf_conntrack_btf_struct_access;
diff --git a/net/xfrm/xfrm_state_bpf.c b/net/xfrm/xfrm_state_bpf.c
index 4180c317f9bc..560b444aee80 100644
--- a/net/xfrm/xfrm_state_bpf.c
+++ b/net/xfrm/xfrm_state_bpf.c
@@ -115,6 +115,12 @@ __bpf_kfunc void bpf_xdp_xfrm_state_release(struct xfrm_state *x)
 	xfrm_state_put(x);
 }
 
+__bpf_kfunc void bpf_xdp_xfrm_state_release_dtor(void *x)
+{
+	bpf_xdp_xfrm_state_release(x);
+}
+CFI_NOSEAL(bpf_xdp_xfrm_state_release_dtor);
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(xfrm_state_kfunc_set)
@@ -127,8 +133,24 @@ static const struct btf_kfunc_id_set xfrm_state_xdp_kfunc_set = {
 	.set   = &xfrm_state_kfunc_set,
 };
 
+BTF_ID_LIST(xfrm_state_dtor_ids)
+BTF_ID(struct, xfrm_state)
+BTF_ID(func, bpf_xdp_xfrm_state_release_dtor)
+BTF_ID(func, bpf_xdp_xfrm_state_release)
+
 int __init register_xfrm_state_bpf(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP,
-					 &xfrm_state_xdp_kfunc_set);
+	const struct btf_id_dtor_kfunc xfrm_state_dtors[] = {
+		{
+			.btf_id         = xfrm_state_dtor_ids[0],
+			.kfunc_btf_id   = xfrm_state_dtor_ids[1],
+			.release_btf_id = xfrm_state_dtor_ids[2],
+			.flags          = BPF_DTOR_CLEANUP,
+		},
+	};
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &xfrm_state_xdp_kfunc_set);
+	return ret ?: register_btf_id_dtor_kfuncs(xfrm_state_dtors, ARRAY_SIZE(xfrm_state_dtors),
+						  THIS_MODULE);
 }
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 891f777a265a..db1a7073aee3 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -281,6 +281,12 @@ __bpf_kfunc void bpf_iter_testmod_seq_destroy(struct bpf_iter_testmod_seq *it)
 	it->cnt = 0;
 }
 
+__bpf_kfunc void bpf_iter_testmod_seq_destroy_dtor(void *it)
+{
+	bpf_iter_testmod_seq_destroy(it);
+}
+CFI_NOSEAL(bpf_iter_testmod_seq_destroy_dtor);
+
 __bpf_kfunc int bpf_iter_testmod_current_new(struct bpf_iter_testmod_current *it)
 {
 	it->remaining = 2;
@@ -302,6 +308,12 @@ __bpf_kfunc void bpf_iter_testmod_current_destroy(struct bpf_iter_testmod_curren
 	it->remaining = 0;
 }
 
+__bpf_kfunc void bpf_iter_testmod_current_destroy_dtor(void *it)
+{
+	bpf_iter_testmod_current_destroy(it);
+}
+CFI_NOSEAL(bpf_iter_testmod_current_destroy_dtor);
+
 __bpf_kfunc void bpf_kfunc_common_test(void)
 {
 }
@@ -1085,6 +1097,12 @@ BTF_ID_LIST(bpf_testmod_dtor_ids)
 BTF_ID(struct, bpf_testmod_ctx)
 BTF_ID(func, bpf_testmod_ctx_release_dtor)
 BTF_ID(func, bpf_testmod_ctx_release)
+BTF_ID(struct, bpf_iter_testmod_seq)
+BTF_ID(func, bpf_iter_testmod_seq_destroy_dtor)
+BTF_ID(func, bpf_iter_testmod_seq_destroy)
+BTF_ID(struct, bpf_iter_testmod_current)
+BTF_ID(func, bpf_iter_testmod_current_destroy_dtor)
+BTF_ID(func, bpf_iter_testmod_current_destroy)
 
 static const struct btf_kfunc_id_set bpf_testmod_common_kfunc_set = {
 	.owner = THIS_MODULE,
@@ -2627,6 +2645,18 @@ static int bpf_testmod_init(void)
 			.release_btf_id	= bpf_testmod_dtor_ids[2],
 			.flags		= BPF_DTOR_KPTR | BPF_DTOR_CLEANUP,
 		},
+		{
+			.btf_id		= bpf_testmod_dtor_ids[3],
+			.kfunc_btf_id	= bpf_testmod_dtor_ids[4],
+			.release_btf_id	= bpf_testmod_dtor_ids[5],
+			.flags		= BPF_DTOR_CLEANUP,
+		},
+		{
+			.btf_id		= bpf_testmod_dtor_ids[6],
+			.kfunc_btf_id	= bpf_testmod_dtor_ids[7],
+			.release_btf_id	= bpf_testmod_dtor_ids[8],
+			.flags		= BPF_DTOR_CLEANUP,
+		},
 	};
 	void **tramp;
 	int ret;
-- 
2.53.0

