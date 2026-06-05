Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD653E6DED
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 14:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780671435; cv=none; b=kTcIm99ZetWaIZI8z8DZZaQEBxPBzdgRr7H+xjFsvfBiBCscEswTao3lpERmlGopd60ifn6ynfUsJM61XFtZMDZYjoodmBbcPBhWmYxNefGOm1fXNF8zYYsAlaMHpFRAk88Q6YBsZreVohu9q5QUAP7OfZuDXIbAnM7zkFc4ojY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780671435; c=relaxed/simple;
	bh=Mz8IzpA+mE1lCCJhfegzw1OtF+FGE+EqPAuT2hpR5RA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SRqSdP7/ckKGCxPPdOOCE10RNJ3YygJFKdqzG513461JBKWTpYvf7K93cbh6RzejOVbNw7g0pDpnQChkxRh+O5YPa1H7m+BYPOPFTVQcjU2EpG3MEdl92jfX+2luYQdkY96kIHgLimt4ZHchxZfa/iqIwj0TqyWCvtdQXnQkrFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Si1Yh1sb; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Si1Yh1sb"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8ccdf8d4ac5so22254876d6.1
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 07:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780671433; x=1781276233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AUsTZdpMdXg+RyQBEedVH+xsX7MRbssqaPr3VOFVT94=;
        b=Si1Yh1sbQQqwUhBK6PGzmvSWwRBxhiTGRNlscZYWnGjUquNfEWXn5iRef1hC0ciShB
         qALB/a55UFl0Ka/hxH0T000HIGDgnbIGaIS1jBk6+xGYuX1i4aI9s2YOBs9B/Wmjd73s
         XOjfk/yovamwb0SSKqQROCW9pJhCa47/B5DWrZ/e4ORoLKmSjcKzY4jUuz968KMgSm3q
         gzjGwZkq+aifzRQcdrUBrcMD5feC8rKknrl1P6NhMW6brllqQ/l53VPiOm/KGLHLHq2g
         o4rYDzsTTY2QV0sgyCH7FbVLzmMsM3Jx3dyAtX2gC5fFzkouRXVRSsYrnPZrvJCpSqU3
         S6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780671433; x=1781276233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUsTZdpMdXg+RyQBEedVH+xsX7MRbssqaPr3VOFVT94=;
        b=OvVMcjNU79fiXzcucvOt+2m+prK9sfio+CX2nvTyy4uSlRu5IMzMtFyHL5SCoCEr8t
         NwtzG3nAAun0xMByN9ZGwdjQFzMbLJNntJwbV+mMMr+m2LeGpfBJksUXL8HlNB73srba
         WorYovX/l/z0/d729BhS/jlT5O15/Cprlu5Tqc6KkjdYHOMkGwArBFZu2bp0mirr0xl8
         GzrJ+Le70gMsTZhMQuiD92WXBcUpIgGZ+O4Ch9ecG4n7Jhog5vojnZE33O3kXpcSR+X9
         YSRt04LBJQpCFoiJkXsy99xsEJ91ZGJcAU0siCE5hE8l1VzEEHYGR3ECEiio+qEFdNrU
         9XOQ==
X-Gm-Message-State: AOJu0YzbKcWopBiydH2dKORsqsZOACTW3f+y+9rOdYDBrokVsPak22Vh
	KU7ZnkqQswE2Rbj2fod8+UrMys/a3CAZlWaZz+PT7JyBboGfb0106dcLS7F52enEeMY=
X-Gm-Gg: Acq92OE4WcJrZQaHwOq9v66h+smImMCrVik8RKd4zuZDCJVAPSsu5B3UX2Tg/aUfQjI
	1DdQund5MSqKF05n3mBxKDoTYvGk4M+zokZMBsSgRc4XMXQ1NAoz9bExtIGcbaeJJSTFiaO3u8b
	nDs7H44dU2LQg79m8SDGdW+2R0tmfV8Q1eQrsFfmv7CikQiVYh5eB1B84GMb+7Xco0ijIMCyfju
	2WWFxNqv96pjpapoPPGglVWhT2GD3VIzaYjA9LFtKbRJ1MQhKOMBB3qrIPS7KcI/dCrOqL2eQ6i
	tSf/W8O3rCttbzOjhgVQ0OqcckURSVgFWOmspMNffUHwZtHNEdec5eUH4Ti+NOqu3W9XkeZQ82O
	ZsbBL3zeVKYhSLSC50f49xUtH9jMfdBrlNGd4oXuoiw8RCMltkbqSsmyl4+tIZ9+kyPH2O7xhx7
	XRdFQmoaL9w0UUSpo5DJu8IUQXytMvHzOSqrT2UPeFts+kVG3SIHLf35rGhi7rOM+n5xqtGtbMJ
	uivBiiiCD27th1XZYosvs4AQAz8qiBc0dMr
X-Received: by 2002:a05:622a:a08:b0:516:d943:175f with SMTP id d75a77b69052e-51795c3dea1mr54279761cf.52.1780671432688;
        Fri, 05 Jun 2026 07:57:12 -0700 (PDT)
Received: from battery.lan (pool-138-88-31-60.washdc.fios.verizon.net. [138.88.31.60])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccdca075sm85746046d6.20.2026.06.05.07.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 07:57:11 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-kernel@vger.kernel.org,
	David Windsor <dwindsor@gmail.com>
Subject: [PATCH bpf-next] bpf: reject sleepable BPF_LSM_CGROUP programs at load time
Date: Fri,  5 Jun 2026 10:57:07 -0400
Message-ID: <20260605145707.608579-1-dwindsor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cgroup shim runs under rcu_read_lock_dont_migrate(), so we should
not attach any sleepable BPF programs there. Add support to the verifier
to explicitly reject attempts to load sleepable BPF programs destined
for LSM cgroup attachment.

Without this, we get the following splat from a BPF_LSM_CGROUP
program marked BPF_F_SLEEPABLE attached to file_open when it calls
bpf_get_dentry_xattr():

  BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1567
  in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 34317, name: load
  preempt_count: 0, expected: 0
  RCU nest depth: 2, expected: 0
  Call Trace:
   down_read+0x76/0x480
   ext4_xattr_get+0x11f/0x700
   __vfs_getxattr+0xf0/0x150
   bpf_get_dentry_xattr+0xbb/0xf0
   bpf_prog_e76a298dac9218c6_test_open+0x6a/0x85
   __cgroup_bpf_run_lsm_current+0x326/0x840
   bpf_trampoline_6442534646+0x62/0x14d
   security_file_open+0x34/0x60
   do_dentry_open+0x340/0x1260
   vfs_open+0x7a/0x440
   path_openat+0x1bac/0x30a0

libbpf provides a .s named section variant for every sleepable
program type except lsm_cgroup, reflecting that per-cgroup LSM programs
are intended to only run in a non-sleepable context.

The above splat was obtained by bypassing libbpf by using bpf(2)
directly.

Fixes: 69fd337a975c ("bpf: per-cgroup lsm flavor")
Signed-off-by: David Windsor <dwindsor@gmail.com>
---
 kernel/bpf/verifier.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8ed484cb1a8a..821654bcbaa7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19099,8 +19099,10 @@ static bool can_be_sleepable(struct bpf_prog *prog)
 			return false;
 		}
 	}
-	return prog->type == BPF_PROG_TYPE_LSM ||
-	       prog->type == BPF_PROG_TYPE_KPROBE /* only for uprobes */ ||
+	if (prog->type == BPF_PROG_TYPE_LSM)
+		return prog->expected_attach_type != BPF_LSM_CGROUP;
+
+	return prog->type == BPF_PROG_TYPE_KPROBE /* only for uprobes */ ||
 	       prog->type == BPF_PROG_TYPE_STRUCT_OPS ||
 	       prog->type == BPF_PROG_TYPE_RAW_TRACEPOINT ||
 	       prog->type == BPF_PROG_TYPE_TRACEPOINT;
-- 
2.53.0

