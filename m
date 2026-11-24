Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795554400;
	b=ymmhINvcor26JfeEZ1HIKkGZ3UWNvU3n+tasiuPFTW3p7HgELono1jbf9exn5ufKXlVd
	 JmghrvvlCvuYZHLyIRTEpGNAvvaYmOK9oxsWoumEConmVDdLALGxMvLTzaqA9rlA0g/dJ
	 4cRp5PXYFVqzPCw3pX1BaBKERPKPIhTCffa2/fIbuzuntN2LqbUw2N0fAehQybtyz2IqO
	 uifPs4REUw1jRq1PoCvvJ4aqS43NamySVAjsDAQhjsUVH4VcJSbSiECE0e60jzhUsPuxz
	 LkEX6wC6mZjqxQZLwhFsdBnxeSjj1bGoJD6sAv6bZ7/BosCqVme7hlgQSbU+/ubYjvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795554400;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=H+UnSX/PqY8z8gSxSr8JwMySn7nrmtRIZfAK3roY4J8=;
	b=ImSr8CVNzp7rS4p4pLtReFNfGjgCwB+2YXr0rd2SFOPAZFssMyIG0Odr/iE8c8hKWoz1
	 SyC/896alZJrvqp1MkRwfI5sFScq9sJJhssf6Sp1p9N4/LzZN8iDzfRMC6DKHJ47xNuP+
	 2RLxg/BxR1LL3fK6iZX7KDbtNDCAURzi7l64g2PYP6CvSa5uXw96N5gZpX4stANU0oO1t
	 QE7ZWDzD62/MSCAhiiOjQv61tu+soJVb+BYB08t9QAN4QFRzl40Ji5wREqCdDBaHWvHy5
	 lr9zwXtlGI4sc8ccKAP56QsMjuiYW8k25dHmJ7Ef4MFdKoZJoG28Ek3a3Cmfu2rg+5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sfOV8cdi;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8D5606A31E
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 21:06:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C8D5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sfOV8cdi
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3b10ca4e3f9so2604811a91.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 13:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795554398; x=1796159198; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H+UnSX/PqY8z8gSxSr8JwMySn7nrmtRIZfAK3roY4J8=;
        b=sfOV8cdi5VcmHLGRH5NTHwYZRQT9RsIrKksMA7txdbiosbMCbAQYV26IZcKiFHrh78
         OByVPKUKC2iks63XrrC/Vob67keyfOpbI6AbSWcYctfLseA5aUgfWDbB0gH+cP57XeoA
         HvYK8D4gxMFmG/IbCgHoizXNsJHuIc0uS90lHnWUYkQTFKsY0cqGvWtkcp/we4+H9Dml
         ZqZ8Icv5JY3kGArOdcvJEGfXB8rVyNRzUQF6m2c+ikoo0q7uSSctQ9gNmyyWp1FzBX/n
         5Q/n/05PPX0eFxw0iPGlyFxRtWQQ4HKHXIw1X56qMeyAeIZyUluqHvCCAf18OM8Wonzf
         4H9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795554398; x=1796159198;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H+UnSX/PqY8z8gSxSr8JwMySn7nrmtRIZfAK3roY4J8=;
        b=Hsg1WOCHDaDAhRlPFKx+kNaEPq0iyVbSNvpRtu6AvHSTYCQn1hjOoGydDUGftw2Dq6
         2IhCRv0QP+C0g7kmW99QDv6PSWPDEEaWK0lvvuyyiMaVZ6jjk7lXW1SQDrDbgJk/+n5M
         nGZ/OGndu0rjocpRDGBSAgYAkoC3MoYHoMc2TZxvCnvy+fte5S72CyA1LCjFSFL4B3he
         /pMhmJO6jmHd5jiI8vRbHkWUTR1L5+8jcvz4dQaT20R4bhQrfvrEEDlrzYnv25rA8FV1
         Cyi1ZoPHC7vMFLheD8SP67iFKZ5hmf04JD1FGOsInwP20CB4VULYsTMMICuJYhlYRCeV
         FTVQ==
X-Forwarded-Encrypted: i=1; AL+hErHmAOWiK/O9TQ0E2iGiaZSjHxk8BzeKHC+EDHQ+2O6qdXRR7oAvZQXMRJh0eAZmA5NKotQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8+WHCtd9W5GtuwTfyUtzmocFYoeOHesBtlWu9fKkdZizmScABJ
	lDD6FBslESh4SNGccR/z3kLOI4YC0S4o7OAMb2mVWU6EJ0azwG7ZQYy8
X-Gm-Gg: AZFdTZftbKXLIW6H0R/Dntqw025qSJNi2+Pm6Cf8n0mTuz6lhSYilQOG8NtzKsmiVaw
	U0xVvH/Qd6JKOrEjE7ytsmmormXUYulBWJE+PjIBR3SotP9NXMQP2htpSyQLL7QPDEggdJoynkU
	qouxQ3UqY3gQuYZ2TtvA2mBGMdHmrs1eHzDkJtF76jSJSPe7X5lDJKE1std74hc8B1A2uX80taa
	5mnwtV3R7QS+VWMiRHsUBRWV6pLcmqBYyKWYXXxU7vXMN56MIHN8IG1s9P/9BtFqBlkRkoGsLMM
	oy8qvTJ2o+Xx1ZG0mCZV2P+u5mLRD1x2ymuaKT/AQSCaHLyf5pkfuxEmrpZE9CL6MWyKeuNa9k8
	dRSI+8czSzE8jacCsDAv8E4XzVQuoBv8rR6yNXrfWUarpZNDSmUhq2lillTjIwuN6eG3+aTuGym
	Dbnvz4N1d+igQxofxG1SrRruSlyHX8ymcX08Ogq7BXmzHsgdzFO/01maOCjoHzmAI07jcCgVjQC
	Q9SmdO6F4W9+4Q13eXgwXkVLh9wxJMT8bDc8mHmdn5ZFePschL0CPWWR1lMZ4RYM/DbWuPgevlI
	q6LS4h0tsqFIgSFn6cZgRGFkSf0JtuRQZcAhd3g7gJi7IWxhjrj3emrLlwaEQcm6EM1NoNIxK4J
	owsxWA5BzRl6XO4bZTMi6QMfcqGbA48H03w==
X-Received: by 2002:a17:90b:4d0a:b0:3ac:ea3b:f28b with SMTP id 98e67ed59e1d1-3b41c9cd21fmr13382679a91.24.1795554398193;
        Tue, 24 Nov 2026 13:06:38 -0800 (PST)
Received: from localhost ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad46ef5sm24095661a91.8.2026.11.24.13.06.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 13:06:37 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 21:06:37 +0000
Message-Id: <DN3QWUNLDYAP.1RWBZ8RJH1QSY@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Jamal Hadi Salim"
 <jhs@mojatatu.com>, "Jiri Pirko" <jiri@resnulli.us>, "Amery Hung"
 <ameryhung@gmail.com>, "Cong Wang" <xiyou.wangcong@gmail.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, "D . Wythe"
 <alibuda@linux.alibaba.com>, "Dust Li" <dust.li@linux.alibaba.com>,
 "Sidraya Jayagond" <sidraya@linux.ibm.com>, "Mahanta Jambigi"
 <mjambigi@linux.ibm.com>, "Tony Lu" <tonylu@linux.alibaba.com>, "Wen Gu"
 <guwen@linux.alibaba.com>, "David Vernet" <void@manifault.com>,
 <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <linux-s390@vger.kernel.org>
Subject: Re: [PATCH bpf 0/3] bpf: Reject sleepable struct_ops programs in
 atomic context
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Sechang Lim" <rhkrqnwk98@gmail.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>
In-Reply-To: <20261124143123.1182108-1-rhkrqnwk98@gmail.com>
References: <20261124143123.1182108-1-rhkrqnwk98@gmail.com>
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

On Tue, Nov 24, 2026 at 06:31 AM Sechang Lim <rhkrqnwk98@gmail.com> wrote:
> atomic context. tcp_congestion_ops, Qdisc_ops and smc_hs_ctrl have no
> check_member, although the kernel calls their members in softirq, under
> a spinlock or under rcu_read_lock(). A sleepable program attached there

Not all of them. Qdisc_ops init and destroy run under rtnl and can sleep:

  qdisc_create_dflt()
    qdisc_alloc()                 kzalloc_node() with GFP_KERNEL
    ops->init(sch, NULL, extack)  no lock taken in between
  __qdisc_destroy()
    ops->destroy(qdisc)           fq_codel_destroy() takes a mutex here

A sleepable init is valid today. bpf_arena_alloc_pages() uses GFP_KERNEL
there instead of alloc_pages_nolock(). Patch 2 rejects such progs.

> This series adds a check_member that rejects sleepable programs to each
> of them, like bpf_tcp_ops does.

That makes four copies of one function. The default is the bug.
bpf_tcp_ops v2 and blk-iocost v1 missed the same check:
https://lore.kernel.org/bpf/20260623175006.3136053-12-ameryhung@gmail.com/
https://lore.kernel.org/bpf/178889947167.2.9168058946538747939@kernel.org/

Fix it once in check_struct_ops_btf_id(). Patches 1 and 3 go away.
sched_ext, hid, io_uring, binfmt_misc and bpf_dummy_ops have
check_member already, so they keep their sleepable progs.
A struct_ops with check_member still has to test prog->sleepable itself.

In place of the series.

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1dd9db1..f7c7380 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2209,7 +2209,8 @@ struct btf_member;
  * @check_member: When defined, a callback invoked by the verifier to allow
  *		  the subsystem to determine if an entry in the struct_ops map
  *		  is valid. A nonzero return value means that the map is
- *		  invalid and should be rejected by the verifier.
+ *		  invalid and should be rejected by the verifier. When not
+ *		  defined, the verifier rejects sleepable progs.
  * @init_member: A callback that is invoked for each member of the struct_ops
  *		 map to allow the subsystem to initialize the member. A nonzero
  *		 value means the member could not be initialized. This callback
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 01a74e1..42a90c7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22244,6 +22244,10 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 				mname, st_ops->name);
 			return err;
 		}
+	} else if (prog->sleepable) {
+		verbose(env, "member %s of struct %s cannot be sleepable\n",
+			mname, st_ops->name);
+		return -EINVAL;
 	}
 
 	if (prog->aux->priv_stack_requested && !bpf_jit_supports_private_stack()) {
diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
index 2ba73dd..4e54165 100644
--- a/net/ipv4/bpf_tcp_ops.c
+++ b/net/ipv4/bpf_tcp_ops.c
@@ -301,16 +301,6 @@ static int bpf_tcp_ops_init_member(const struct btf_type *t,
 	return 0;
 }
 
-static int bpf_tcp_ops_check_member(const struct btf_type *t,
-				    const struct btf_member *member,
-				    const struct bpf_prog *prog)
-{
-	if (prog->sleepable)
-		return -EINVAL;
-
-	return 0;
-}
-
 static int bpf_tcp_ops_init(struct btf *btf)
 {
 	return 0;
@@ -329,7 +319,6 @@ static const struct bpf_verifier_ops bpf_tcp_ops_verifier = {
 static struct bpf_struct_ops bpf_tcp_ops = {
 	.verifier_ops = &bpf_tcp_ops_verifier,
 	.init_member = bpf_tcp_ops_init_member,
-	.check_member = bpf_tcp_ops_check_member,
 	.init = bpf_tcp_ops_init,
 	.validate = bpf_tcp_ops_validate,
 	.name = "bpf_tcp_ops",
diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index 5691c13..61a1971 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -356,6 +356,24 @@ static const struct bpf_verifier_ops bpf_qdisc_verifier_ops = {
 	.gen_epilogue		= bpf_qdisc_gen_epilogue,
 };
 
+static int bpf_qdisc_check_member(const struct btf_type *t,
+				  const struct btf_member *member,
+				  const struct bpf_prog *prog)
+{
+	u32 moff = __btf_member_bit_offset(t, member) / 8;
+
+	switch (moff) {
+	case offsetof(struct Qdisc_ops, init):
+	case offsetof(struct Qdisc_ops, destroy):
+		break;
+	default:
+		if (prog->sleepable)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int bpf_qdisc_init_member(const struct btf_type *t,
 				 const struct btf_member *member,
 				 void *kdata, const void *udata)
@@ -446,6 +464,7 @@ static struct bpf_struct_ops bpf_Qdisc_ops = {
 	.reg = bpf_qdisc_reg,
 	.unreg = bpf_qdisc_unreg,
 	.validate = bpf_qdisc_validate,
+	.check_member = bpf_qdisc_check_member,
 	.init_member = bpf_qdisc_init_member,
 	.init = bpf_qdisc_init,
 	.name = "Qdisc_ops",

Pls target bpf-next.

pw-bot: cr
