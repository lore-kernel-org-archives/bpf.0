Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795136921;
	b=O9u+I9X/NefmwUCP9JBp9qF1LP1BZsWXxfwT54VOPGlg8f+WPI8ftYK0o0Tyt8ZvhhI5
	 9zDM51RX5aVyWHXLKX73CcGh+ix7PSE9Yyw8vYlWn0AnJ4H26u5mE1/91S52fhVY2tCpi
	 2zECp/RA2LsPOGzllve5IeKbC27yCKpi0MQDgqErKKkdSzLVY4wg9gpC8FmGKy2Kjl5ck
	 yT9KZy44tY2jPTpBzXMqi0US+0wk0DO4jA8hSeq+xqVrUBuhba0iPuh+iPZutvXph3/B/
	 H5QeZ3gvohbeRutobgfg/t4/SH5Jpuba1PXHe0z+aeMbfbVhLWXDXIulpw6EL+LIzzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795136921;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=eretBnITB6vR9c+pjlNoT5wot4ipeaWEYdkoD9FXiOY=;
	b=Wq4Nds936my8h9NHaWvapRm1NnjzSJGDUgFZS/tIDz5lictMu48MgtPf+2Gdp2UHL26s
	 c7kK9K2f3Hco6Wxj/xcGJr2CauW/CnrT9nUo2t5mebKA2f+xUNdghxXmOG+L8x8ZxhtbE
	 DpgMmYJyFY11nCACVMK7UwykGYQaPj/kwLqj0PK8FqajNHunjJa9wPh1Y57+eFwAEW2Sd
	 02bVPuzbJiYz7Kla9ojaIfwi5uxz8KJXB/v0Nt7x36TK10bog2uFFI6Pl5kL+AbQsQCp6
	 BpOMUthFZ8LkW46r2/d2PdKvNdyAFizWz1S6dSBMPzg1+RDrNyxpxN2g2Lq7M/7a4iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zv2tPubG;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EC4606A320
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 01:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87EC4606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zv2tPubG
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2f0464dd6b6so208055ad.1
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 17:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795136920; x=1795741720; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eretBnITB6vR9c+pjlNoT5wot4ipeaWEYdkoD9FXiOY=;
        b=zv2tPubGZQUVZlU14gcYvRYJFSgkeZOX5Ccg9jvkxVA+wHGnL5K9L6LPNWGK3z31aj
         MkaN8o1K1Vwu+xxlxTX9MQjCYrrHhLE+kicoZ9ZBU6ecc9JZTetAryyshiDIVD4MAlaM
         t9vPKuEaPoTkKDrzYobbWP634m61ZuUXCMHJJTeBqIYQJ1Aek8/eyPayQsqcCSCPs+GA
         BxIC072hizkK9xT75+USvmVvNcddyJXFy2wkfgtT/uxfef1enXRunV4N+tgd8psd0B9h
         Ot1W1bFzhuqs4RjSaQ5aDcxBBWzsstK/A6wDjmBCGlN98NS9XmD5+4IGdxtsdgHqIgMC
         odug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795136920; x=1795741720;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eretBnITB6vR9c+pjlNoT5wot4ipeaWEYdkoD9FXiOY=;
        b=20WK09iQZ/Wgu7zjhmT2a4p9savZt6lD66+lG2g3DT8Ph2ckiH93MzWmzRW0fETXj4
         C3TuaKTfRC9bxpDkGlPaAfTcxCm6kQkO8c99ttWXpxbCwDIY4kMfYL49n87gbJpuyROm
         fy0stVnV6+4d1v2fI8G4GT0EhZxQGWF0Z5tE0UDLU3acBHGMG1DeOKBBaHjkdyQFbNtE
         ni7V3CXE0pzFiMp7+fJWL56BSLhJ9DkEgWQkYM7V0ytAQIEzTdv1HldFgnyfdWFfAc0n
         5vsiFfe/x9ZDaKxnXK2RJdAhLN94Ex+rp8v7dCpn7gTQGvuLYy6OZa5TeQxTxyvhkveb
         elsw==
X-Gm-Message-State: APuU4Z/idYi53tuxWrHMA86dvMhnfIChBQRmvyaH9SgjoTy9hOYVUp8F
	IEMEpdgzdMeTShgnqKKdTQUfmrhcyo3T1KvQ4ZD171i5MLzHUpAvYkCW
X-Gm-Gg: AZFdTZfbkWJFJvcV+v59HaKfb5WMMKVcB4UB/NYz1Nd8421ENIQBxzotYszq2mhsckw
	K5xrp7X3xVvGhiFCAQ0L37nPjw7ABve7LCupJcbD4viCOvh/0i1Le97qoq3YzKTdoMhTCjkUX9H
	L+LO3s+yH4SnYkEtNJi+hU8LHEi38SNsQBPG8jM9rnRJGwFwIFi7VU+srGcTnAp8n9OBPdxbLS0
	Ij/uXb92blZjxVvdlk6miFi2yWGsklKN3HNIYW7Ww1SaK+5cPuNpS5Hi4n/VIMADLoFhd1a7oKI
	Y/flrS28kdpD1ne4r3GotschEIulFTktbYuqD6X8Y2kkQ2JsNuo6wRrSFP4o+gswhsJ+cLeTtqF
	hBm8HranQ0J0fFWnsMpGaqokIXAbjHyvD7U97Jd50xOjt1zFnvSIJcYep1GIrgYYU6Ub3OItxkc
	XRfUpNmx5ei84O3uD4utVfUEtAA0mV0vkCvN9tI6FWQu/Nnqbcjpo+yBavqc2BRMuSG5waN/CYt
	uqZcV5xv9NgVVyxtB1iLSthhB7Vhvosogs8umA0kW3v6rfe+bkCTt4R0APqg/LgYhRV8Zp8cCAn
	bJNBGqYTQJAoTityxWmXrzKh08F6AKforTlClwTcoI1X0Uwe8XhUOF6eRfvebrDzK1UMXmLgA5K
	9CwXpNO9JxrXg1s33KiJZ4f9pfacZ+m1DOg==
X-Received: by 2002:a17:903:2441:b0:2f0:3d6d:a089 with SMTP id d9443c01a7336-2f03ef870d3mr15115475ad.1.1795136919620;
        Thu, 19 Nov 2026 17:08:39 -0800 (PST)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0ea6a8sm6302305ad.36.2026.11.19.17.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 17:08:39 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Nov 2026 01:08:38 +0000
Message-Id: <DMZMXFOOKT03.2D4M33BG6WTRP@gmail.com>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2] bpf: Use an on-stack pt_regs in the raw
 tracepoint helpers
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <mike.bazov@gmail.com>, "Mike Bazov via B4 Relay"
 <devnull+mike.bazov.gmail.com@kernel.org>, "Song Liu" <song@kernel.org>,
 "Jiri Olsa" <jolsa@kernel.org>, "Ihor Solodrai" <ihor.solodrai@linux.dev>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Yonghong Song" <yonghong.song@linux.dev>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "KP Singh" <kpsingh@kernel.org>, "Matt
 Bobrowski" <matt@bobrowski.net>, "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>
In-Reply-To: <20261119-bpf-raw-tp-regs-preempt-v2-1-e1e1b90857d6@gmail.com>
References: <20261119-bpf-raw-tp-regs-preempt-v2-1-e1e1b90857d6@gmail.com>
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

On Thu, Nov 19, 2026 at 02:37 AM Mike Bazov via B4 Relay <devnull+mike.bazov.gmail.com@kernel.org> wrote:
> Each caller then has its own registers, however it nests or gets
> preempted, and the helpers no longer fail with -EBUSY when nested more
> than three deep.

bpf-ci is correct.
let's remove that warn_on as part of the series.

we have another hole:

  prog 1 on mmap_lock_acquire_returned
    bpf_get_stack(BPF_F_USER_STACK | BPF_F_USER_BUILD_ID)
      mmap_read_trylock()
        prog 2 on mmap_lock_acquire_returned

stack colection with build_id's will disappear.

Let's fix all together with somethign like:

diff --git a/kernel/bpf/mmap_unlock_work.h b/kernel/bpf/mmap_unlock_work.h
index 1834db2..65673d1 100644
--- a/kernel/bpf/mmap_unlock_work.h
+++ b/kernel/bpf/mmap_unlock_work.h
@@ -13,6 +13,7 @@ struct mmap_unlock_irq_work {
 	struct irq_work irq_work;
 	struct mm_struct *mm;
 	atomic_t active;
+	int nest_level;
 };
 
 DECLARE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
@@ -28,8 +29,13 @@ static inline struct mmap_unlock_irq_work *bpf_mmap_unlock_guard_get(void)
 {
 	struct mmap_unlock_irq_work *work;
 
-	if (!irqs_disabled())
-		return NULL;
+	if (!irqs_disabled()) {
+		/* progs on mmap_lock tracepoints can get here again */
+		if (this_cpu_inc_return(mmap_unlock_work.nest_level) <= 3)
+			return NULL;
+		this_cpu_dec(mmap_unlock_work.nest_level);
+		return ERR_PTR(-EBUSY);
+	}
 
 	/*
 	 * PREEMPT_RT does not allow to trylock mmap sem in interrupt
@@ -51,12 +57,15 @@ bpf_mmap_unlock_guard_put(struct mmap_unlock_irq_work *work)
 {
 	if (work)
 		atomic_set_release(&work->active, 0);
+	else
+		this_cpu_dec(mmap_unlock_work.nest_level);
 }
 
 static inline void bpf_mmap_unlock_mm(struct mmap_unlock_irq_work *work, struct mm_struct *mm)
 {
 	if (!work) {
 		mmap_read_unlock(mm);
+		bpf_mmap_unlock_guard_put(NULL);
 	} else {
 		work->mm = mm;
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 3f1901a..5c49c13 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -702,7 +702,7 @@ BPF_CALL_5(bpf_perf_event_output, struct pt_regs *, regs, struct bpf_map *, map,
 	sds = this_cpu_ptr(&bpf_trace_sds);
 	nest_level = this_cpu_inc_return(bpf_trace_nest_level);
 
-	if (WARN_ON_ONCE(nest_level > ARRAY_SIZE(sds->sds))) {
+	if (nest_level > ARRAY_SIZE(sds->sds)) {
 		err = -EBUSY;
 		goto out;
 	}

pw-bot: cr
