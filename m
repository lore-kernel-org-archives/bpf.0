Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795500052;
	b=csXQ7T+FxSj6MDa5xm+Bb30v5O7YiZ1fCpzlpZvTSwyW0z2iKl3xH2QxYsuclC4C59Jd
	 mZLUCqDeh7WzB7SUYWmZML0APFM2rksHdrY5D5VKFqIkEnKTHsMtBKf4Bd7Ioi2Kk/vOq
	 Ycbb9s2ZHRFrgDV8Ag0Mv7T6IjtPFd7lBrNuFvEz6JFEhQFFUcrDWNtL9sQIKdtMrKM0f
	 IzsQb9LVmThYGVf5FQi/dsLc0OXwkKcaNDm6dHqkK/A0vTo/aF4yRoedJKjS4J7dQdAMt
	 vaB2B/1WZeDqoqakDGCKVE1r/FRgUy9wfh4OHEBCiHgeso+E8YlfDk2z5whJRpdUAsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795500052;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:From:To:Subject:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=/SLHfkNsrCjSRx5Wz9p+DTV861mq73QFj5nkNZKg5lU=;
	b=4SG7t9U45IvvPlBmFjmNoKYaS/7hTaKujAAyGkv1wFoihVSubA9vqxBHEza8uIabLYfp
	 WmE1rJbQ7WOfhNqJNXbL7abVlGxv0pXhoU5fG002/tIfYQiQqlwAk6CojFIczF1QSTHHD
	 Qs8wIzOpjZFfCBrx4B9Q5KgUYKRJrOHkOfMePjI1M9yHGJC/k5N47Qc/W7Q6Xv+3Gpi2V
	 RCLEqejE5zlinwZsznL4pmBoJ6xkPOhx4rMZObarzk0rP9q/LifbrpM9JmcqfU3m5vylF
	 yf6klD5fQpibpEZiFH7uMImZ3eZZ1FiOwAzUcj78qpxY5QbkmKjnmaryRjowVkW9yew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q1+Zpv7v;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0421606A321
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 06:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0421606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q1+Zpv7v
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc751eddf25so2762130a12.3
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 22:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795500050; x=1796104850; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/SLHfkNsrCjSRx5Wz9p+DTV861mq73QFj5nkNZKg5lU=;
        b=q1+Zpv7vRdLuNryjubIcK9p1C6hYtJyM8s4Ya+V8PgQONvpdTC7Ua853SGJTsIUcXQ
         M0pFVL8Do2Ry2wiXUj3cxeKtoqtmO0eJBjUj9twM08oj3aaj/1mWJSU3N4CXDAYxBpCK
         on+bdLfyiTexuyK1b6zmgwGoqKXFL4GeCN4DTr+jWK4djxI0BL1/DadGxeBp6DK7jASk
         tRKgLLfGrF8S9KN1UlG+krPmugZz0AWnplxbg1kncJbcJLBXntvKA8UjrUbEBTdBxIUf
         JruoLYhZMGVzT+PZrzx9sT1rk+fc369T12hC6PaBt2ez90GghipDT83vmsUcG8y9Od5P
         M7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795500050; x=1796104850;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/SLHfkNsrCjSRx5Wz9p+DTV861mq73QFj5nkNZKg5lU=;
        b=CLHbL2/cV3WjwxqsZ6RDYnnTnGLZuots6kaTPfFLAOKMVd2+48ch0KdDB+ZJv9OHHg
         hSAo16sZkURF/ua99AIhz5NLVYPQ8MYmsKPhKIEP1hBz/poKRGxwt5OhqcRip98br3DP
         39BKg/I1M/S/b0AfHz8WbrQ/UrT/EC9glqFi26T1/DCV/Ep/UMVnsAKVqeotPRynegaN
         eec9P4M7yXVkWT3ABIRuIvTtchNHk9Vjt/4KGEElLxfV/yPbNST8x/7ESlEnvOZlqdy7
         Rqb0NfL7cy4lOb2w+5FJbib4CG0dqM1HDTdNBdifLl4OLVYstyRAda1pXfgPox3oer4D
         WtcQ==
X-Forwarded-Encrypted: i=1; AL+hErEKH3wxKIvSs5f1fbJJ2KzlAeZMDjcojDqBCsWyu8f0uVl0hHBDcaRLvv7rybQ7tVJ8tgA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Tir2DasM8HF6PJGcZvDBq9vpJlL6erw3TcxrhLAjDaD95ne62
	fYeLiuycH9UqBdsQsCKl4WLFcvkvL7J8LRq1/wZ3B9ezLmnz8EMNgLtb
X-Gm-Gg: AZFdTZcEZ5v9lA8WJOnuip+ocqUIG6QitweM8fNXiLUJquLqyi6rdaPFid+g4zDoNK6
	c2h5u77aQvm3rCE9d0hRvFRjdfpVOpUV51omzJ5bGYg5LTQZMfr3iRwZsiobTCH7BZLCkgMVZ0Y
	AeB6EJ5Xt/98Uae0SfK3eEUOgy+bAAZRMBHoGqS7PFVPrpnzRD6itViLf1FVbMqpPEadKn74QGC
	qBQDLVfwa9Ddm+U+T0L1JBAqCkv/XavptIfMHzfPLfhPLVYzB7esV27ZONqtolEQ6tuw7sFOpYn
	yNYJi8v20X7ehIf4AkDdgzFkIgamT9mjEY9O/5PMvNDWZEf/f33zsMzrG/cb2TQ3GXcpMqUERSr
	p+bBsxcrjcMdZ11fGKv87Jxj9TX8I4m1QR2aCHitWloZVSvmCcqA4TrNJq6je5pfG3uY91WfINn
	pr6eTGwLW5RK1ujFUILqXOPkorcBG3su17B3pCLlxSFiCUIgckB5oyMleDXslnwJwxrdsQMxAkR
	YLqsiJeQWpsyOBr4g40G69/XCahmVtFIrMJpJe4Rc0Ika4BWjOFxDSiyqRblCfLtJ0otCuCFM7z
	XhJIvdgePsv4yr6lr8Jp5XqL9OQIdsuUGxqeDekTpKtEqIybUruRQKxV7Qb39/d/GEFxM1y3bUF
	NkvShgB7z14M5+AXtd6TO43HwySBtAbkWtrI=
X-Received: by 2002:a05:6a21:780a:b0:3e2:8b64:2ca0 with SMTP id adf61e73a8af0-4014d35f1bamr11982201637.49.1795500050075;
        Mon, 23 Nov 2026 22:00:50 -0800 (PST)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6d03adafsm6596544a12.23.2026.11.23.22.00.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 22:00:49 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 06:00:49 +0000
Message-Id: <DN37NBGPJJG9.2DSVDCKS3UYTV@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "syzbot" <syzbot+b6f8640465bdf47ca708@syzkaller.appspotmail.com>,
 <akpm@linux-foundation.org>, <andrii@kernel.org>, <bpf@vger.kernel.org>,
 <brauner@kernel.org>, <daniel@iogearbox.net>, <jack@suse.cz>,
 <jmorris@namei.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-security-module@vger.kernel.org>, <netdev@vger.kernel.org>,
 <paul@paul-moore.com>, <penguin-kernel@I-love.SAKURA.ne.jp>,
 <serge@hallyn.com>, <syzkaller-bugs@googlegroups.com>,
 <takedakn@nttdata.co.jp>, <jhs@mojatatu.com>, <netdev@vger.kernel.org>,
 <tomoyo-users_en@lists.sourceforge.net>, <viro@zeniv.linux.org.uk>
Subject: net: act_gate bug. was: [syzbot] [tomoyo?] [mm?] INFO: rcu detected
 stall in security_file_ioctl (9)
In-Reply-To: <6b051681.58b41460.7037.0590.GAE@google.com>
References: <6b051681.58b41460.7037.0590.GAE@google.com>
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

On Mon, Nov 23, 2026 at 08:45 PM syzbot <syzbot+b6f8640465bdf47ca708@syzkaller.appspotmail.com> wrote:
> rcu: 	         hardirqs   softirqs   csw/system
> rcu: 	 number:     5264          0            0
> rcu: 	cputime:      138      52351           25   ==> 52490(ms)

It's not tomoyo, mm or bpf. Looks like act_gate.
Zero new softirqs in 52 sec, so one hrtimer_run_softirq() doesn't return.

> RBP: ffff88807ed35538 R08: ffffffff91be1bbf R09: 1ffffffff237c377
> R10: dffffc0000000000 R11: fffffbfff237c378 R12: ffff8880b8228600
> R13: ffffffff89fd0480 R14: ffff8880b8228600 R15: 1ffff1101704514a

The registers with lockdep struct sizes:

  reg       value             points to
  --------  ----------------  --------------------------------------
  R14       ffff8880b8228600  cpu_base
  R15 << 3  ffff8880b8228a50  clock_base[HRTIMER_BASE_TAI_SOFT].seq
  RBP       ffff88807ed35538  kmalloc-512 + 0x138, tcf_gate->hitimer

act_gate has the only soft hrtimer that can be on CLOCK_TAI.
bpf_timer_init() rejects that clock.

TCA_GATE_CYCLE_TIME is an unchecked u64. In gate_timer_func():

  n = div64_u64(ktime_sub_ns(now, base), cycle);
  close_time = ktime_add_ns(base, (n + 1) * cycle);

With base = 0 and cycle = U64_MAX, n is 0 and close_time is -1.
The timer restarts in the past and __hrtimer_run_queues() runs it again.
It's there since
commit a51c328df310 ("net: qos: introduce a gate control flow action").

Jamal,
taprio's INT_MAX limit doesn't fit. tdc uses cycle-time of 600 sec.
The diff saturates the sum instead.
Here is a potential fix:

diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
index 711cf24..5422d60 100644
--- a/net/sched/act_gate.c
+++ b/net/sched/act_gate.c
@@ -45,8 +45,9 @@ static void gate_get_start_time(struct tcf_gate *gact,
 				const struct tcf_gate_params *param,
 				ktime_t *start)
 {
-	ktime_t now, base, cycle;
-	u64 n;
+	u64 cycle = param->tcfg_cycletime;
+	ktime_t now, base;
+	u64 rem;
 
 	base = ns_to_ktime(param->tcfg_basetime);
 	now = gate_get_time(gact);
@@ -56,10 +57,9 @@ static void gate_get_start_time(struct tcf_gate *gact,
 		return;
 	}
 
-	cycle = param->tcfg_cycletime;
-
-	n = div64_u64(ktime_sub_ns(now, base), cycle);
-	*start = ktime_add_ns(base, (n + 1) * cycle);
+	/* cycle is an unchecked u64, the sum must not wrap into the past */
+	div64_u64_rem(ktime_sub(now, base), cycle, &rem);
+	*start = ktime_add_safe(now, cycle - rem);
 }
 
 static void gate_start_timer(struct tcf_gate *gact, ktime_t start)
@@ -107,15 +107,8 @@ static enum hrtimer_restart gate_timer_func(struct hrtimer *timer)
 
 	now = gate_get_time(gact);
 
-	if (ktime_after(now, close_time)) {
-		ktime_t cycle, base;
-		u64 n;
-
-		cycle = p->tcfg_cycletime;
-		base = ns_to_ktime(p->tcfg_basetime);
-		n = div64_u64(ktime_sub_ns(now, base), cycle);
-		close_time = ktime_add_ns(base, (n + 1) * cycle);
-	}
+	if (ktime_after(now, close_time))
+		gate_get_start_time(gact, p, &close_time);
 
 	gact->next_entry = next;
 
