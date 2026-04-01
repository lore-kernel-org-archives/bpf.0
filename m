Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068593F8DE5
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 13:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775051070; cv=none; b=DKwa5NKTnY8oR4QDJl5AeKqjEzovyt5wbUfOnDXAEWQ1J38D2xseWtVdl8t6UqGMTdQEwqbQS6MmoNjRGrGQLWQZNYZI+9leyIkyZ2IOB+C9jrE+fUQKz9KXf6hmyW0v9+78aUwPs7Snbxj5l6uyTO50fRSO3d6JyYjv04rAn+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775051070; c=relaxed/simple;
	bh=h2s8O28EcrY+1RSxqAEZnVYi429hS+7J6DOa2rif8Sw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QOFdpWBbM9m/EPC+ir+Hjifk2MAZFaF9gQ6C6quS7OQI719onl86yWSPvJPwYzruN4q8VdPFAQx9zFnzAy0bM4J921YpZDfO8IjiL0kPrgPrtswKLBZ8lbJje64wZiOIL+ngTuxHwQMIpRshme56pl/1rMBQy987m89RfatKnsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nt+M0dh9; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nt+M0dh9"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c06cb8004e8so2777225a12.0
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 06:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775051068; x=1775655868; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5w6DoKofcUymqGz5unmMX3ysJ5+8CgZ32mudZsWBu6U=;
        b=nt+M0dh9oROWkLqgGBTrGImD/wvqyPC5WrClIxvF8Qe2tiq0Aq+NWHeZdB5dOf+Yi7
         e4sCIRUEADcHvh9Srpw9mIdrhVlZcUTiPSbGiNfBFVJ3bixYGXDG/3bRsunQy3FIIy7i
         6P9VpVhW8riz7Z4iLH0BUteK8lDrflMun3kRfhheecVRBEVNIsOWB3WFSn73y5kAS0Qk
         p0SrzvOy9hOUgRNTqK+PzdLqZZRGFk41dPSwxD3bJ+1mAoqHRifchD5Ylwg75GQjTBYx
         UfwapeBsH1Uit9c4QVCvj8N/8ayY5L0oMON2a9hk0OkBaEEBrfYAVBhObmtc3TuajVf9
         qUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775051068; x=1775655868;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5w6DoKofcUymqGz5unmMX3ysJ5+8CgZ32mudZsWBu6U=;
        b=nTatlvDc2tqxWie4dusMpDCPCjrTy3ZHSQ/5etH+0Ly1i0zhjk96Wpd62ZITn0aaio
         0MDumteCn657fjhvp1GxzXugSKuGG+nGJGvcdOEx0AquRod83b7DxA+ipP7oeqb9LxkR
         QCH+7Kz4meLxKwvDyh/rDVjZXJlCoVBb00uuAupR+Z5BMPCdyYiRjorKlZ5q3Kpx1Hwr
         6l+GjhcGRvHkChW7U+lBw6c2zxc5HT5JFbNYNdYatA9Y3pWqdkCTwQ7CZHIlaeMOzEhC
         ohczEoxIq4BOGFZSevvap30v+eGAn/bLa8u6lZDC31NjfsOSWyHJTt114tnU27Gb0pnv
         FQkQ==
X-Gm-Message-State: AOJu0Ywswb9urYLPanQ7TANUiXLWnnDQGGtl3BMFoNpYqHdDWJtohKXr
	FLoH5zTLMq/9KHp79DrBRUV8p9W1Q3nptswN+OpR1+43NF2IREOoDyT05BwcxigsKgo=
X-Gm-Gg: ATEYQzwwlbcHpGp8skp380QOOGCOpabiRIboXzDRfyWOayvuj3gWK9ymd60RMSqgzqP
	A5fFS6WjDyeTPK/g2UXFCLjdAgMLjnCctynUzoW6JMrTXTA308CCLGGURRJod51kDJKMRnoHdRL
	gcDb2JOaFlVTdU6uHzMVZPlriVyVVJ6CUfBrcoPcxA5OUqBqgmkQunsr3lsiHV8DhFfg8Io4TrH
	lOsIuJBbBbEAfFBCq3XziCoY3To0QUIOaz2K10l+O+wlWvtiAGmfNZsyQQDAFxIoG6BuV/PIwvk
	yb6kv8+u3JHoR0CbfL8mc88gEuiq2w6rsDNUNT8G+JCgPwqgkXX6ioP0Cg8pzGu39pvsWiBrCKT
	CxDLsGxa6aS+CSSAh9rUQWQW4Bei7+Bnq4GTs8mYENoTRvlFPcE1slsZE8zI0CEq4PxCQHE28Xa
	M0esPyK0Ww/etKdO7qQ1urxuGDxS56yFa6dBK4EjTt
X-Received: by 2002:a05:6a20:3c8e:b0:398:9923:7492 with SMTP id adf61e73a8af0-39ef769cea2mr3798024637.39.1775051067806;
        Wed, 01 Apr 2026 06:44:27 -0700 (PDT)
Received: from computer ([2a09:bac5:40b2:a82::10c:35])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76917d843esm13795063a12.29.2026.04.01.06.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 06:44:27 -0700 (PDT)
Date: Wed, 1 Apr 2026 19:14:15 +0530
From: Varun R Mallya <varunrmallya@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kpsingh@kernel.org,
	mattbobrowski@google.com, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	jolsa@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org
Subject: [BUG] bpf: kprobe_multi allows BPF_F_SLEEPABLE programs, causing
 sleeping-in-atomic splat
Message-ID: <ac0hLyMuPHiZfnVc@computer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I found a bug in the kprobe_multi BPF link creation path where the kernel
fails to reject programs with BPF_F_SLEEPABLE set.

kprobe.multi programs run in an atomic/RCU context and cannot sleep.
However, bpf_link_create() with BPF_TRACE_KPROBE_MULTI does not validate
whether the program being attached has BPF_F_SLEEPABLE set. This allows
sleepable helpers such as bpf_copy_from_user() to be invoked from a
non-sleepable context, triggering a "sleeping function called from invalid
context" splat.

Reproducer:

  /* crash.bpf.c */
  SEC("kprobe.multi")
  int handle_kprobe_multi_crash(struct pt_regs *ctx)
  {
      char buf[16];
      int ret;
      ret = bpf_copy_from_user(buf, sizeof(buf), (void *)ctx->sp);
      bpf_printk("bpf_copy_from_user ret: %d\n", ret);
      return 0;
  }

  /* loader: manually set BPF_F_SLEEPABLE before load, then attach via
     bpf_link_create() with BPF_TRACE_KPROBE_MULTI */
  bpf_program__set_flags(prog, BPF_F_SLEEPABLE);

Kernel output (bpf-next 7.0.0-rc5+):

[  483.577248] BUG: sleeping function called from invalid context at ./include/linux/uaccess.h:
169
[  483.577364] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1787, name: sudo
[  483.577420] preempt_count: 1, expected: 0
[  483.577453] RCU nest depth: 2, expected: 0
[  483.577486] INFO: lockdep is turned off.
Attachment successful! The bug is confirmed.
Check 'sudo dmesg -w' for BPF prints and warnings.
Triggering v[  483.577569] CfsPU: 7 UID: 0 PID: 1787 Comm: sudo Tainted: G        W           _
rea7.0.0-rc5+ #4 PREEMPT(full) 
d[  483.577571] T.ainted: [W]=WARN..

Su[  483.577572] Hrvardware name: Bochs Bochs, BIOS iBochs 01/01/2011v
[  483.577573] Call Trace:
[  483.577575]  e<TASK>
[  483.577578]  d!dump_stack_lvl+0x54/0x70
 [  483.577582]  If __might_resched+b0x200/0x220
p[  483.577585]  f__might_fault+0x_c2c/0x80
o[  483.577587]  p_copy_from_user+y0x23/0x80
_[  483.577591]  bpf_copy_from_user+0x27/0x50
[  483.577594]  fbpf_prog_1906cf6roa66546b5e_handlem__kprobe_multi_crash+0x33/0x4d
u[  483.577596]  skprobe_multi_linek_handler+0x15d/r re0x260
[  483.577599]  t? kprobe_multi_lurink_handler+0x99n/0x260
[  483.577602]  e? __pfx_vfs_readd +0x10/0x10
0[  483.577604]   in? ksys_read+0x7c/0x100
 [  483.577605]  dm? vfs_read+0x4/0esg, x360
t[  483.577607]  fprobe_ftrace_entry+0x3b8/0x480
[  483.577609]  h? ksys_read+0x7ce /0x100
e[  483.577610]  x? fprobe_ftrace_pentry+0x93/0x480l
o[  483.577612]  it? lock_release+0x42/0x330
 [  483.577615]  ? vfs_read+0x9/0wx360
o[  483.577616]  r? __x64_sys_rt_sigaction+0xde/0xke120
[  483.577619]  ? vfs_read+0x9/0x360
[  483.577620]  d? ksys_read+0x7c./0x100
[  483.577622]  
? do_syscall_64+0x143/0xf80
[  483.577624]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  483.577625]  ? trace_irq_disable+0x1d/0xc0
[  483.577627]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  483.577631]  </TASK>

I am sending in a patch that fixes this.

Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
