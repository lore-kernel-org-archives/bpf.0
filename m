Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795582297;
	b=rUritTBagB4uHE3BaQ7uphypDsSMgQqFZGtz/Sst+v1+AMqFHKKviBoGWYxMyuqQq/s7
	 j9Q0YcvmYPAVkt2yiP/lwpzhAI9C6YxkMpSPgdqLyFr1SNW5lfIhfqOcIP/7+8HtDj6JZ
	 bc64WZUmHZEAPuPK3/3iSPbhhlS0i2QWZUR1d6TWezxhDsgihDsMaQMF3iLwkvw2KRp6c
	 ECnaWS6lnCxLh14CFvXJj6yxw9FIs73y5C+oiT8A5gRJKdSuM5Y6PZja9mQn/FURZEbD7
	 ElmIpJOBhnGf41EfeTInogzv6t5Gx6u6P8HYAJBEh7Dm0FWMvwV+BXvlYXJz80ZaWEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795582297;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XO4TrpK9P96uCfE9RUiQZD2WOyvv7UkLXAlskXveiYg=;
	b=N4BawotvQb7b0BU3Bb9mevRmwmWFveX7v8H/r7NsMBHgUSMbhxDccpck1EDk/uGj85Me
	 ZjNG49YSRxXCdQpugXJ+w0L0BJ2XMnLF7f+F250Rb4zDN9VufN2342Bxay2yIk8aJP3tK
	 36JR/dCCmv4mOnkXMVJ4nJa1Edj1lyof4GlzZTNCCVHoL3SpuyZIeq2O7/ydfNvR2vE28
	 hQC/WMbulmo4s0EppIffNR6roIO/piIXFPlFlBCZjOR9EllGGRVH8lmaJYpEenq/+Y44M
	 rHxTDvqE6lbGv6d5zs/kNSra5PY+43Mm4ZNHT4QGhlu0bgOWqvXpBeKLUiLATYSqMqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=McoupJE6;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8496606A326
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 04:51:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8496606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=McoupJE6
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b4a93d0814so1492823a91.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 20:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795582296; x=1796187096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XO4TrpK9P96uCfE9RUiQZD2WOyvv7UkLXAlskXveiYg=;
        b=McoupJE6wFfgw5zfTpObm4Yqn1QNI/cTFKc6lB8T6YoB0iuTcnCCjvOMj3Ch8puAnA
         DyUDOkRXRv95zl1I73oN+tePX2MBItkbp6/x2/RhD70SiwnW2UZBU3rlFkqmDIKkfmvH
         fxMHfYQ79v23fyyi1XvIHiN+uXteKV5jCoURlmhFsvXxRAfIr2cdchzTYPUgEdNjf40F
         7lsKXVSVgrvWTkiRDIInkGPU3Ap9hglh5xTrgOxmBnXQTzRaIyw/bSpO1NK+F/BIu5zX
         YBCX7iMYxRv9R+k3Tatp1CGyXzzc/0OkiIg7AnZZ/8U+gtwnIkEONyabaf2owP4oP2yr
         +Edw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795582296; x=1796187096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XO4TrpK9P96uCfE9RUiQZD2WOyvv7UkLXAlskXveiYg=;
        b=t7IrWZxvB8sUxBfACZCsYjg9fdfWD7E7mwZ03guIBv/nQY8WsvBiF2nz0pjN1bq8Vb
         qJgWyYKQjyBsH3CJlff5TUx7PLDjAyTARmMaDXzlZ3sZx165fCTTrF+Tg7fC/j79RCoD
         HOXNlYc3LvDDO3+51sDl7t/Y+4cGlE00xZm2fgHPsnCVbMgDcdS9FsghK46TUdwr4/hl
         fOOyAFhozQ+97aY9grDMksHiLIJU5F5UJ5iqrr92ij0KcVv++ITUv9qt5fQtRtcxhqzx
         TnDEJarF2hFRb3N7QrFJYf34HdfQ5QSDs0pn3MtePzauIi7UQIb3ia9wsuzNr8G26gqP
         uG6Q==
X-Forwarded-Encrypted: i=1; AL+hErFM01miD7NyWKXVVCjJAbsybVrgWYEh723SYDOJ77aB/w9oGHZzWHkT2+KSMe/yZ9p2Ge8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9C7Wr86z+xI4NBlopZhHrw1/C0+cCZPfbsXB5Ul1S3ZDyPptG0
	+VxiPERw1cDyGyboGJJ0kGc1zHqAwb+1OgIZ8kG+ka+G6YmX0puZa9CN
X-Gm-Gg: AZFdTZeeSvD8nl7m9K7J68ohIHk4x+CGVTZF9K8mm1npzYPV9BaJx7oTmEcVEIJIGS7
	Ig/47ZJScSSghQ7GxfFkcxDOR+AFkzOpzy3r+wvJz2wKFN/klzHX9g7qDogddCSowdtG6velRr6
	j3+DXhy3o84AlT35s/2XpAERnHCsWgcYenP2D4OliMZlBnhBwmz/83dTZUSc3S5Xv4Ozqer/z6C
	c4BiKNCb3cJvhoHLpkTN8oo1BMmzgx1wzpTI2odRPUlHUspFi/xwDkIAgG0FNzNKWyPaMOfqYb1
	MM/OGZk4FbfqbAyY0jU6s+vCvQDa2TVkZJ6dh6BpLj0MyuW6QkeQ4e2uUuBJPwvvjSjMkyE8LIF
	a+PEUdIuhqw+xczK/1EIHkzqwxDYJL7mPygn6tuB0hTjyrcqMNbbUFXouco/kRh4mcp4Id9UfR7
	nbwsK9NXUNvLIAxOd2yPsXFBhFFeX3PjULnoSk9+4EgkPl8AEtr26GqKc0sLyjh/fe28W1RhtNp
	sZHaTQgcvKkzOSnWvZCgKsFNquusxd9292oBaRSNgoAZUTsQHS1ATg5x+1wGD+EK7eEkvt0RtS2
	f5kKNlsujJCFJiHyWYcCITZS5PGvWWyfuxA8oq95/UsrpjuxBvnaTlvwUuJr9R5m
X-Received: by 2002:a17:90b:4ccb:b0:3b0:9183:23ef with SMTP id 98e67ed59e1d1-3b41c7b67femr15911910a91.3.1795582295961;
        Tue, 24 Nov 2026 20:51:35 -0800 (PST)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4b3c71192sm9457209a91.5.2026.11.24.20.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 20:51:35 -0800 (PST)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Amery Hung <ameryhung@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	David Vernet <void@manifault.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: [PATCH bpf-next v2] bpf: Reject sleepable struct_ops programs without check_member
Date: Wed, 25 Nov 2026 04:50:52 +0000
Message-ID: <20261125045105.2326120-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.56.1
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

Any struct_ops program can be loaded as sleepable, and it is up to each
struct_ops to reject that in check_member. tcp_congestion_ops, Qdisc_ops
and smc_hs_ctrl have no check_member, although the kernel calls most of
their members in softirq, under a spinlock or under rcu_read_lock(). A
sleepable program attached there is entered through
__bpf_prog_enter_sleepable(), and lockdep reports "BUG: Invalid wait
context".

Reject sleepable programs in the verifier when the struct_ops has no
check_member, and drop the check in bpf_tcp_ops that is now the
default. Qdisc_ops init and destroy run under rtnl and can sleep, so
give bpf qdisc a check_member that still allows sleepable programs
there.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
v2:
- Fix the default in check_struct_ops_btf_id() (Alexei)
- Keep sleepable Qdisc_ops init and destroy (Alexei)
- Target bpf-next

v1: https://lore.kernel.org/bpf/20261124143123.1182108-1-rhkrqnwk98@gmail.com/

 include/linux/bpf.h    |  3 ++-
 kernel/bpf/verifier.c  |  4 ++++
 net/ipv4/bpf_tcp_ops.c | 11 -----------
 net/sched/bpf_qdisc.c  | 19 +++++++++++++++++++
 4 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4e9a4d15af0e..95835534b065 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2253,7 +2253,8 @@ struct btf_member;
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
index e7013ed8cadd..8c7e43220df3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23934,6 +23934,10 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
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
index 2ba73dd6c52c..4e54165a3928 100644
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
index 5691c13781a8..61a19713c5ec 100644
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
-- 
2.56.1

