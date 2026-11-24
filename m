Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795550056;
	b=HHW0tbuLUD4UivcChELW+GrjoOWqMvL/bx28zZtVozPCrgW5RyuXNs4/mmrnbe9l32so
	 v27SfnN9htThBBpNZlE0iEDzUnHil/KOoNnxDItv/r10bHQFtI/kRyopLEv2BnwapP+ZN
	 29JyQYBCmcf9Ld6pk7n+irIS9WYXtkyBAAwRaq80uYmJ+Sll5yvmXeEV808YXoqYfSu1e
	 Gr2aeJJwfHtBF5lkwPecgQwylBWUy7XKcimbtAKajDw0Tv1ql/Zq+eDduxYZ514HswgB0
	 0jqdNFtgcp4N//vp7tf1dVlDIibfbzWFmj0adWHrNoZHj5lHPVLRiCCcZd0sDIkWsMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795550056;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding;
	bh=ZX4eTwiD1UEIBjQCO3I1MMRG9i8niEq0sJPsAp/WjbE=;
	b=2LivM1FXaN6VBvry5hWTSKDLgW9SqSUmgaXgy5DOjI5OZE86JKrKCmbIU8UEM6qVXoUp
	 p/MLLG7h8OMV3UiSBw91/aU5AsxAPPFZ2378qxVc/ozQPP3YHAI2GPdZKAKBIlq5sHfnS
	 YuqcklZ/T1X02s3sfS4FCedFagn7Egf41gCTbIeX04onUMNwUWhjKqV+ZhEYinLiJuXl3
	 alrWwetT2IvfAwFTodUXcahDVkfWyBZFhwXZ6AUfqg7wBpzoZSzeO5wB2os1p37dOWoPt
	 EzFtIJ7NBrWB6zFPX+J47KbpquE34GRNmF492CvdwvhU6ROQX6rnAcJWW2sBXmPwxVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o6D9jS9S;
	arc=none smtp.remote-ip=74.125.225.74
Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B64F606A323
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:54:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B64F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o6D9jS9S
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-4b5a3bb6f93so396878f8f.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 11:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795550055; x=1796154855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZX4eTwiD1UEIBjQCO3I1MMRG9i8niEq0sJPsAp/WjbE=;
        b=o6D9jS9SBMe7kRmw8SLSJuzzemgak+lSlnWb5fVw19W4nbS3z/JZ/xHJ4rE4jtLjmh
         MKx7ol4zOojg8YXTHKiPixExR+TTBsSCbZEa1eZdJpRG9i49EwgPYBt6dH1qyRA9LI0Z
         n9lEzqr2nNYxN6MYeBFZDSc1Cx5QkVu0MUjhjGY2ir7l6XsBhp09uC6Wn66lY/NAh4UG
         gOQ5GBwvLAXD989pAqn9yWv7wlv8CLtfkGvK8/RsvZJsbr1GcqN1CK54JgXMuudcly44
         vvkZYFlclkyJz0s1bajb2YkGExmCSJsuCmVb8yTNPeOjWYnh3/80de88HB4cDU5jACCP
         dXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795550055; x=1796154855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZX4eTwiD1UEIBjQCO3I1MMRG9i8niEq0sJPsAp/WjbE=;
        b=lH8VfHTVZ3MMPT7wDMPHEp4o0eKBsTNZ+SakEoXPF6BqLDxM6OM5LUy40yEbp8JW8/
         326k7+Km7DqtjTV/UDrUyUm6XmHRD/2SEzp/NiNT/r8E2gdbKo3sQfft1jTAttYyGaHM
         fPgeOwFi5TZJQOeX/4hN7sRVvaqX4NYC9XmTJKAnRKsr9JIRdIAhdfqmPJ0c1PPM+tyz
         UzpnHMRO1il+qVLsGtM13DjS11CE4hegcaUjT/05snGJ3pSWcPzkrWqx3eqzDFfdSMrO
         wqyWEI9ZQ5HVt+sDKVTyz+gs0NaawJzUZmgaknu8fcRYLkVSnzyxPN/aWMveqMRNCCDy
         kE/Q==
X-Gm-Message-State: APuU4Z9eWBkWvSERCPwbVTYKNiuydhBlvK5OqNlIYWS0pPtoNJS2X7We
	AR1ohFxnvnqjapepSaJ2HHQUCHcmMBP+4H8bwuRFIDn2S494iLbh7hMbVPLgnyPtZsE=
X-Gm-Gg: AZFdTZccvFeC7DERvmYkJmHNWxFrmnMETj5+VkIIerRK9MRqYk8iNK43KVZXHP1q6oX
	FlPqdX9P6N7mstVNY/D5GUj+VYmHeZL47N7wsciIN9TMl46CCI0U2g3zsyygHcE02TUK5ra5vUS
	BcxsJUXFAry5uey0AhpTqetTSVc4du+XDb9yJqv6lOVAFdc6OIa1dHfj98O6KeWt73Pq3Rla+tq
	rdby4/z4hHN8I+QMGcki68P97saZC5BSnfPF1P6UD7+NuoHRhFt4skJTWK09uTYc4QN+KLBm4GO
	zhp6Tn5qREQuWeoghyyya6v4X34qZzLj3cu13KwRV7tQFGnlqyxLubfyiJaKYgH7yEziIRa02d4
	4qKvkFY7SnoHJyC32TX9lMoGyoJ1DiNtU9C2DbOx0LHJ+kzmeiTQeimYugnLKLX7N43znrzylka
	Cg/vXBpUaz7ObGJG5cfSobwNpukL52vEJdylxokfjQm6tqVdO8F5X32JTXqVXV0KEWepb2twfwu
	bsjZYbP59aESgnxwVZvQ2qeeTfPCRhVFHfbRv4n/JWLt9iwDbECoeIY0/S+IybSKuxrUol8Y+nq
	BaMH8nTL8cv+U+KaiS4Gaz4q9ublJvrRpt9lvnyGK92mFRb9myjRnhp1t1R4/XfWmzyzbKQs3z3
	rryfSYFNC4xMyIGLI/DQhmHEBHdeSkqJey4iUzQ9QJFXArJc7YzK/wev4hpo1bihgxw8c/4qxag
	EGxvnDc+KdbZvFIg==
X-Received: by 2002:a05:6000:2f89:b0:485:8cc8:1f5f with SMTP id ffacd0b85a97d-4ae0a0b0809mr25118374f8f.42.1795550054407;
        Tue, 24 Nov 2026 11:54:14 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a680483sm30252865f8f.28.2026.11.24.11.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 11:54:13 -0800 (PST)
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
Subject: [PATCH bpf v3] bpf: net_sched: Defer bpf_kfree_skb() to irq_work with irqs off
Date: Tue, 24 Nov 2026 20:54:12 +0100
Message-ID: <7a28c63f6b3d61442dbee1950f9a76d278a0f5be.1795550039.git.memxor@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5565; i=memxor@gmail.com; h=from:subject:message-id; bh=8X5pz7hCRjRSnLRYKnk1IellYCLooyZMgdHsXTE36fA=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIZv1dTjLki9G/a87rbbriNZujo8XrNt8SmrJTgMHF1vFB X9/i2h0lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCLX3RkZumy19j1NFb+lq2bM OCM5/pOhwp0XP85riqocLOeYHrMhh+F/3u0rXRmLj++4+y7TyObG5cy5CWcTTyyZLvD+zupM3xd 7mAE=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

bpf_kfree_skb() is also the destructor of an skb kptr. A destructor runs
wherever an object or a map value with such a field is freed. That can be
with irqs off, for example:

 - bpf_list_add() drops the new node when @prev is not in the list, while
   the program holds the bpf_spin_lock of the list, which keeps irqs off.
   The drop frees a node that has no other reference, with its fields.

 - bpf_local_storage_map_free() frees the fields of each value under the
   lock of its bucket, which bpf_selem_unlink_nofail() takes with
   raw_res_spin_lock_irqsave(). A qdisc program can keep an skb in task
   storage.

The rq lock can be held as well. A program that shares a list with the
qdisc program gets there:

  prog                    drops the node with
  ----------------------  ----------------------------------------
  sched_ext ops.dispatch  bpf_obj_drop()
  tp_btf/sched_switch     bpf_list_add(), @prev is not in the list

The check from commit 94c8d1c21be4 ("bpf: Reject bpf_obj_drop() from
tracing progs") catches neither.

Currently bpf_kfree_skb() calls kfree_skb(), which is not made for that.
The destructor of the skb may enable softirqs, take a lock that sleeps on
PREEMPT_RT, or wake a task. sock_wfree() wakes the task that waits for
the socket to become writable, and under the rq lock that deadlocks:

  __schedule()                        holds rq lock, irqs are off
    bpf_kfree_skb_dtor(skb)
      kfree_skb(skb)
        sock_wfree(skb)               a task polls the socket for write
          __wake_up_common_lock()
            try_to_wake_up()          the task belongs on this cpu
              rq_lock(rq)             <- same rq

dev_kfree_skb_any() does not solve it. With irqs off it leaves the skb to
NET_TX_SOFTIRQ, and raising a softirq outside of an interrupt wakes
ksoftirqd:

  __schedule()                        holds rq lock, irqs are off
    bpf_kfree_skb_dtor(skb)
      dev_kfree_skb_irq_reason(skb)
        raise_softirq_irqoff()        in_interrupt() == 0
          wake_up_process(ksoftirqd)
            ttwu_queue()              cpu == this_cpu
              rq_lock(rq)             <- same rq

With irqs on it is kfree_skb(), which on PREEMPT_RT must not run with
preemption off either, as after bpf_preempt_disable():

  bpf_kfree_skb(skb)                  preempt_count() == 1
    sock_wfree(skb)                   a writer sleeps in sk_wq
      __wake_up_common_lock()
        spin_lock_irqsave(&wq_head->lock)

Free the skb from an irq_work in these contexts, like
bpf_async_refcount_put() does: with irqs off, and on PREEMPT_RT whenever
the caller is not preemptible. The skb waits on a lock-less list, linked
through skb->ll_node. A shared skb only loses the reference of the caller:
as in dev_kfree_skb_irq_reason(), the last reference is the one that may
link the skb.

The irq_work frees the list with dev_kfree_skb_any(). Without PREEMPT_RT
it runs in hard irq context, where dev_kfree_skb_any() leaves the skb to
NET_TX_SOFTIRQ and wakes nobody. With PREEMPT_RT it runs in the irq_work
thread, where dev_kfree_skb_any() is kfree_skb() and may sleep.

Everywhere else bpf_kfree_skb() remains kfree_skb(). Qdisc_ops::enqueue
and Qdisc_ops::dequeue run with irqs on, so a qdisc pays for the test of
the irq flag and no more. NET_SCH_BPF cannot be a module, so no exit path
has to wait for the irq_work.

Fixes: 870c28588afa ("bpf: net_sched: Add basic bpf qdisc kfuncs")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 net/sched/bpf_qdisc.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index 5691c13781a8..de0c3869e403 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -5,6 +5,7 @@
 #include <linux/bpf.h>
 #include <linux/btf.h>
 #include <linux/filter.h>
+#include <linux/irq_work.h>
 #include <net/pkt_sched.h>
 #include <net/pkt_cls.h>
 
@@ -184,6 +185,19 @@ static int bpf_qdisc_gen_epilogue(struct bpf_insn *insn_buf, const struct bpf_pr
 	return insn - insn_buf;
 }
 
+static LLIST_HEAD(bpf_skb_free_list);
+
+static void bpf_skb_free_irq_work(struct irq_work *work)
+{
+	struct llist_node *list = llist_del_all(&bpf_skb_free_list);
+	struct sk_buff *skb, *next;
+
+	llist_for_each_entry_safe(skb, next, list, ll_node)
+		dev_kfree_skb_any(skb);
+}
+
+static DEFINE_IRQ_WORK(bpf_skb_free_work, bpf_skb_free_irq_work);
+
 __bpf_kfunc_start_defs();
 
 /* bpf_skb_get_hash - Get the flow hash of an skb.
@@ -196,9 +210,22 @@ __bpf_kfunc u32 bpf_skb_get_hash(struct sk_buff *skb)
 
 /* bpf_kfree_skb - Release an skb's reference and drop it immediately.
  * @skb: The skb whose reference to be released and dropped.
+ *
+ * Also the destructor of an skb kptr, which runs wherever an object or a map
+ * value with such a field is freed: under a bpf_spin_lock too, with irqs off.
+ * rq lock can be held as well, so don't wake up ksoftirqd from here.
  */
 __bpf_kfunc void bpf_kfree_skb(struct sk_buff *skb)
 {
+	if (irqs_disabled() ||
+	    (IS_ENABLED(CONFIG_PREEMPT_RT) && !preemptible())) {
+		/* Only the last reference may link the skb. */
+		if (refcount_dec_not_one(&skb->users))
+			return;
+		llist_add(&skb->ll_node, &bpf_skb_free_list);
+		irq_work_queue(&bpf_skb_free_work);
+		return;
+	}
 	kfree_skb(skb);
 }
 

base-commit: cbaaeff649b7aa09170cb31db001e5468c2726c0
-- 
2.53.0

