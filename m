Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794683215;
	b=vBvlGoxn0VsAhKJFSWBSSToahjEHT4tdLMNd/6r70CPbgzBZL+ip8f33VWFRoahDNneQ
	 fzBo2eIi+IYzVliskSnM+6cCrfXleagpTa67sOHRWZt7pmAazUG2TUa5ZznwWPq5kxQvT
	 czs2zORfZg4uBAXcxD+RwRkDJJvMCkoWR4wpasf51V+QdfLLnjYYoU1qc0EdK4xfSCcuh
	 jvU3TwcuvqYr4IUj5Nf66Ucdg2g7+7tQ6sa7L/kcvH5yh6F0Owwi7DGf0qKi0L8efciaV
	 0Hz9b0FP8qZ5X5h/z3zdHWQbdawTc/EJQbAzKgV1tob+15xhF0686V3goqtyOpvD5RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794683215;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=GXnJ7EqkeurbEfzLsmAnsY6oVJKbWZqTiWPnVwATPj8=;
	b=U6pVaDibWlNR023WR4Kz5JivtsXhBalDp5sM1zOMKqj5t2iXBxQduPUiBeox0tgGxhT0
	 146p0/fQHTeobeHewGO0t1nT0rjqLaicpwzn+4mfKKm5jv9rID6xtoYRbLtSGGoln2d6k
	 TjGkEqxfLSxXtT4mzTKKhpkbKmoLx1s8WJNv5kFz9fK6Y5W6vPjnnCVoZ0upL+1r7gjHO
	 Aw97ZZXGG8xIpkgFKs2agiI7qj0gast1RO+wDYKgBufJ+sDYzrlSBnJKBnEJRYnvq6X97
	 m9zh3lRJ7tycqJAfLfVKMn2xNzXyD+6AbaEm2aZt5RIFV5oL1Kb11pcMJNHIHoI3ygg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V4GVwOrm;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F29606A323
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 19:06:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42F29606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V4GVwOrm
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3b179528d56so986723a91.3
        for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 11:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794683214; x=1795288014; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GXnJ7EqkeurbEfzLsmAnsY6oVJKbWZqTiWPnVwATPj8=;
        b=V4GVwOrms2+fzVnpV/iw5bpRwU+scd7Yf5pD18/YFy2oTqf0gWxkJLNHhadzJtY/PT
         9Osxm1tNSJi5+jkFgDR8U6u2WJwNbJrDf+XC0SEbVlDHiO5boZ433BAZzu7Eu9T38Msp
         2FvzhN/BgIxldcL0VeXXcrtsmheCfV8EsBrB0O18aHJu6RwZ5vDo/FbJ4bNZah/IyIwl
         yht61N3RvnINOf4WD3vmFZoAKOXPvEi1luSqfcD2HyZJMkOFm+Lxx14l5X01GkEuFkcg
         CSM5sAJpl9D3r5kZzG6j8L7vCRyH438S6ZxEGx1f9YEy235H/akRh2aMTHFJnO24vmmO
         tMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794683214; x=1795288014;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GXnJ7EqkeurbEfzLsmAnsY6oVJKbWZqTiWPnVwATPj8=;
        b=JV3gHkkP8SqfxtUdpusk63nh02N3oS5oqu+KT+IMI3CzO6PRRFhkqVwGs3jTkq1Tar
         vgDfnPNQvKgowQZBS0EOHZUkAOkk3PjhqFY7APy6aBUVdnm3RL0UUJxS9VnJfLf9MNWu
         I76DXKvWqEl1ya6I5Dky2cT+xygLx7H86AavcIr6A91VbR2l0kDcmLwE9bCv8e5sF9d7
         lEqVUrcAkUeECMbVsHh3tkJFCLO6HUkRynxm3tVLc7f5IW+MR/SzuwwXNjggij6YzYoO
         xuGjahmwda8TroK73zbDq1VQU7xzSIhpWiytPyRkoD8NmrQrprUdAMrbL8VHC6Vkx8Tx
         E4Yg==
X-Forwarded-Encrypted: i=1; AL+hErERnZncT44SCSQsLUFEzo0Y6JL+Fv6lc1o+zU2b6nPxYYLPjK7guUZIqwr4r9XBEuZO4+0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9T1TawlOmpw/rOP6TB/tn45on/E85Ez70gTnxfUgh6k9SP+ela
	NVn2Wf7nVT9z8M+77XKy2ihJrf4kU+vHkzhtnPYQX0LQ8H3LkBbTmolD
X-Gm-Gg: AYBFou2QBIrS6HjKFatK90YyKJWi0IL6sIsNyXk3CImjJo1PUHv/DntNgCvKP4FTAc9
	vnwiz2AvWocBdIqMgM1Z1+dYrsh13EYnCkJlquolVQWwtc7lMMZHlVZVkvMaouL0Im0XYmi0Zan
	7DVDlye77tDqpIJrRDgqg8LJIc3FEOvquFnL0vL9dzYNpVmvNgdqYuUgHZX46bdYB+kl9C8c8cL
	s2JxsvCuuwvJsn+OLMdsjSYyYZ3EjbQrLLqcZLU5qFH6mOZqxJnYaJcTxT9CY3Ohe2uPlv/z1Wz
	V5AsfNvLTuiMxoabcz1RWe4h1RsCJVJ7hwPdzw/Kov6FV6V7vmK3UZrj6ZkeWYtHTSl/Gs40gSl
	rzq8P6owFHQZ1bDyd2a4pRCNKmrnCDkuO3ToSqtjPstPrZzx3bY+kS1PpOspI59cwjYEfB4Doi0
	zxulxM91iRMyJmtQQb3K8DS9T2TR5yMSRTIiEl38jgC9kU5w3NOE7B9DTWhddP72vKlbBXpyA5x
	u+dSFnPCYWvDHAIS0XOOWJVdCVEbu4RKQFsnNU3UAhjpz16/73wpLuIfBlLbL1T2km0OuWp8G/T
	d0rv5K3lbNm1r4iAwQm58/iP3f8bJ/rGxDN89wxoMzOUn2QpG1tZvrQVRfBi3OTza9gKKYTXfIY
	++UVe2DjbujEdHwi+ufvda+WmgVO7G3eaNw==
X-Received: by 2002:a17:90a:f947:b0:3b0:bd53:8e5d with SMTP id 98e67ed59e1d1-3b1b0b67c7emr5335875a91.58.1794683214515;
        Sat, 14 Nov 2026 11:06:54 -0800 (PST)
Received: from localhost ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c6c9c5sm14736486a91.1.2026.11.14.11.06.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2026 11:06:54 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 14 Nov 2026 19:06:53 +0000
Message-Id: <DMV63QDBPR8M.OQPRTU7QTUUC@gmail.com>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "John Fastabend" <john.fastabend@gmail.com>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri
 Olsa" <jolsa@kernel.org>
Subject: Re: [PATCH bpf-next] bpf, tcx: Skip RCU synchronization when the
 entry was newly created
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Qi Wu" <shijing.wuqi@linux.alibaba.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
In-Reply-To: <20261114124039.111360-1-shijing.wuqi@linux.alibaba.com>
References: <20261114124039.111360-1-shijing.wuqi@linux.alibaba.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sat, Nov 14, 2026 at 04:40 AM Qi Wu <shijing.wuqi@linux.alibaba.com> wrote:
> Both preconditions for the grace period are therefore absent and the
> synchronize_rcu() is pure overhead. It runs inside the rtnl_lock()
> critical section, so it also serializes the whole machine's network
> control plane. This is visible when creating containers or sandboxes
> in bulk: each new netdev needs one first attach per direction, i.e.
> 2N grace periods for N devices, all serialized under RTNL.

No attach has to wait after the swap. Not only the first one.
Attach releases nothing. The old entry has to stay intact only until
the next attach or detach overwrites it as the peer.

mini_qdisc_pair_swap() has the same a/b scheme in the same hook.
It stores start_poll_synchronize_rcu() after the swap and waits
before it writes to the old buffer again. See
commit 267463823adb ("net: sch: eliminate unnecessary RCU waits in mini_qdisc_pair_swap()")

Lets do the same in bpf_mprog.
A new bundle starts with get_completed_synchronize_rcu().
Then there is no need for the 'created' check.
netkit needs no special case either.

  attach                     this patch   poll in bpf_mprog
  -------------------------  -----------  ----------------------------
  tcx, first on the device   no wait      no wait
  tcx, clsact came first     waits        no wait
  tcx, prog #2..N            waits        waits only when the previous
                                          change is younger than a
                                          grace period
  netkit                     waits        same as tcx

The diff is at the end.

> Detach, replace, multi-program chains and the error rollback path are
> unchanged.

Bulk removal has the same 2N problem.
unregister_netdevice_many_notify() calls tcx_uninstall() for both
directions of every device. Each call that finds an entry waits for
a grace period under RTNL.
synchronize_net() is expedited under RTNL.
Should tcx_entry_sync() and netkit_entry_sync() use it?

> The numbers below come from an A/B pair built from the same bpf-next
> base (2e14a351662d) with identical configs apart from LOCALVERSION, and
> all lock/RCU debugging disabled. 64 vCPU KVM guest, CONFIG_HZ=1000,

Way too long. That's 100+ lines of commit log for a two line change.
Keep the problem, the idea and one table of numbers.

> -			tcx_entry_sync();
> +			/* A newly created entry was never published, so
> +			 * there are no inflight RCU users to wait for.
> +			 */
> +			if (!created)
> +				tcx_entry_sync();

bpf_mprog_commit() records the state after detach and replace too.
They don't need it, but the next attach is never slower than today.
This is what I have in mind. The x86-64 build passes, no test was run:

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 82e608e..aa15fed 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -770,10 +770,8 @@ int netkit_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 			       attr->attach_flags, attr->relative_fd,
 			       attr->expected_revision);
 	if (!ret) {
-		if (entry != entry_new) {
+		if (entry != entry_new)
 			netkit_entry_update(dev, entry_new);
-			netkit_entry_sync();
-		}
 		bpf_mprog_commit(entry);
 	}
 out:
@@ -852,10 +850,8 @@ static int netkit_link_prog_attach(struct bpf_link *link, u32 flags,
 	ret = bpf_mprog_attach(entry, &entry_new, link->prog, link, NULL, flags,
 			       id_or_fd, revision);
 	if (!ret) {
-		if (entry != entry_new) {
+		if (entry != entry_new)
 			netkit_entry_update(dev, entry_new);
-			netkit_entry_sync();
-		}
 		bpf_mprog_commit(entry);
 	}
 	return ret;
diff --git a/include/linux/bpf_mprog.h b/include/linux/bpf_mprog.h
index 0b9f4ca..e74430a 100644
--- a/include/linux/bpf_mprog.h
+++ b/include/linux/bpf_mprog.h
@@ -28,11 +28,8 @@
  *   [...]
  *   ret = bpf_mprog_attach(entry, &entry_new, [...]);
  *   if (!ret) {
- *       if (entry != entry_new) {
+ *       if (entry != entry_new)
  *           // swap @entry to @entry_new at attach location
- *           // ensure there are no inflight users of @entry:
- *           synchronize_rcu();
- *       }
  *       bpf_mprog_commit(entry);
  *   } else {
  *       // error path, bail out, propagate @ret
@@ -104,9 +101,12 @@
  *
  * Fast path accesses the active bpf_mprog_entry within RCU critical section
  * (in case of tcx it runs in NAPI which provides RCU protection there,
- * other users might need explicit rcu_read_lock()). The bpf_mprog_commit()
- * assumes that for the old bpf_mprog_entry there are no inflight users
- * anymore.
+ * other users might need explicit rcu_read_lock()). In the detach case the
+ * bpf_mprog_commit() assumes that for the old bpf_mprog_entry there are no
+ * inflight users anymore. In the attach case nothing is released, and the
+ * old bpf_mprog_entry only has to stay intact until its users are gone:
+ * bpf_mprog_commit() records the RCU state after the swap, bpf_mprog_peer()
+ * waits for it before the old bpf_mprog_entry is written again.
  *
  * The READ_ONCE()/WRITE_ONCE() pairing for bpf_mprog_fp's prog access is for
  * the replacement case where we don't swap the bpf_mprog_entry.
@@ -147,6 +147,7 @@ struct bpf_mprog_bundle {
 	struct bpf_mprog_cp cp_items[BPF_MPROG_MAX];
 	struct bpf_prog *ref;
 	atomic64_t revision;
+	unsigned long rcu_state;
 	u32 count;
 };

@@ -158,6 +159,11 @@ struct bpf_tuple {
 static inline struct bpf_mprog_entry *
 bpf_mprog_peer(const struct bpf_mprog_entry *entry)
 {
+	/* The peer was active until the last swap and the caller is going
+	 * to overwrite it, therefore ensure that there are no inflight
+	 * users on it anymore.
+	 */
+	cond_synchronize_rcu(entry->parent->rcu_state);
 	if (entry == &entry->parent->a)
 		return &entry->parent->b;
 	else
@@ -172,6 +178,7 @@ static inline void bpf_mprog_bundle_init(struct bpf_mprog_bundle *bundle)

 	memset(bundle, 0, sizeof(*bundle));
 	atomic64_set(&bundle->revision, 1);
+	bundle->rcu_state = get_completed_synchronize_rcu();
 	bundle->a.parent = bundle;
 	bundle->b.parent = bundle;
 }
@@ -243,6 +250,7 @@ static inline void bpf_mprog_commit(struct bpf_mprog_entry *entry)
 {
 	bpf_mprog_complete_release(entry);
 	bpf_mprog_revision_new(entry);
+	entry->parent->rcu_state = start_poll_synchronize_rcu();
 }

 static inline u64 bpf_mprog_revision(struct bpf_mprog_entry *entry)
diff --git a/kernel/bpf/tcx.c b/kernel/bpf/tcx.c
index 02db011..0079be0 100644
--- a/kernel/bpf/tcx.c
+++ b/kernel/bpf/tcx.c
@@ -42,7 +42,6 @@ int tcx_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	if (!ret) {
 		if (entry != entry_new) {
 			tcx_entry_update(dev, entry_new, ingress);
-			tcx_entry_sync();
 			tcx_skeys_inc(ingress);
 		}
 		bpf_mprog_commit(entry);
@@ -156,7 +155,6 @@ static int tcx_link_prog_attach(struct bpf_link *link, u32 flags, u32 id_or_fd,
 	if (!ret) {
 		if (entry != entry_new) {
 			tcx_entry_update(dev, entry_new, ingress);
-			tcx_entry_sync();
 			tcx_skeys_inc(ingress);
 		}
 		bpf_mprog_commit(entry);

pw-bot: cr
