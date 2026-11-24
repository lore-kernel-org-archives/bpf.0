Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795490215;
	b=3M48g9yuwnsmZQnIKKr4G/xZg/mqcjNJ/10Sym6SRgClqriiI0Pos+EI7AyQAS68818t
	 EOwJissJoFK6IvOkx0p7JblYf/pKQ/fH5McTeIk2DFwr4XyQQ+SO7vhqH1k/otd/TLJQg
	 hLoFg2KoWZpsGSscUP2sRtDOnXGDCjWBZbaashsSpifs45W+Y1p7G35eahfCUGg1kB//r
	 slda+gOj2JRclRm6m5N1Bw3EIryzkPKM0H7i/8oYQlc/lczSUrYjBCb1OCW+lSIeKDXmn
	 zl+SkX6PuPrDq64qD1pGK1Unm9ZamZlIcbQZQ18+k1PFXYhP9020voHyjoBV03DJNZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795490215;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=EKCwUBMZXEgwJsoK8+iw5jP9TfBZ6zy/Sv767cpvROI=;
	b=FV/XhfsjmX6zq0oyZlr0RWDzulAnkV3Cylp250G+1FHnxzWwtHMpRFwEPEdd5YGwijuM
	 cZdGJ8OMJqths/3+/nMGouEgmQl8QtfU4QuSVPH3D4qwK1oAW2MrKQy8C2eWgZNUebU/C
	 1tPmKvftjEkZAJF1giWgj4l0I07JAbA11P4fFUCyCbTQeAKs78Nyw6WDikE1Hp8g6IuLm
	 XofRF4kSNBuIEW5jC9RHG2fHVzibns8PFQAjT68TTAx1/j7eazzLkXRgEZCriNVm7Xk9d
	 bcg0cQc8B+bFInkDGieOL5Fhadymaf/QnmnHcMKZvX42FHlJl2gl4UClj6fPZkNQGuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WFpGA4KB;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A00606A322
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 03:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5A00606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WFpGA4KB
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so31538515e9.3
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 19:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795490213; x=1796095013; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EKCwUBMZXEgwJsoK8+iw5jP9TfBZ6zy/Sv767cpvROI=;
        b=WFpGA4KB996Tu7hKVOnRNmXinER0wbZZXQoxSH7+GXHZ8IoVoxqX7VnyceUOGOqCNs
         WkwohfjDJenHbBSN+VDFxM2jVYwJ8IsOMdUJ2yz+783MhZ1kpbN8C2aVQkAx5KJFz/6O
         VoHrdCqbgxoKlKyvZ+U9LVvXgz7LODsr+/gzoTyfTFZ2ObuAaHFNkRR3uThSRrIGEf6T
         kVDFjPQO3n6MC8I6N7LGXTU/ajuZq9bf060LgWVpNeeuXGSKK++WWXIx9uxb5q8duH+A
         qSAZeckM2cwFAL6//k1WNoopWbqqksKVmOE8m2sd0JcbqjW1nI6dj3XaA604/Jvf2A5C
         94+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795490213; x=1796095013;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EKCwUBMZXEgwJsoK8+iw5jP9TfBZ6zy/Sv767cpvROI=;
        b=Qf87+quc6aoG8nFGsGiO0pYWpP5YzzZD44lGC8mFNZPVhxvcLE+Re63x56RhPNj3sw
         AFTtIJ1s5tUILOuWKtEnRFla4rr+oFC7aXHc9uYkUbTmCNh3bxopLHojYbAY/jMttZjh
         k8Zhn9zfpTN4DAhVeesWMKpaGM7K7ZTWaNv2IUPw3i8ytbDUh0oZ+SjF9ejE/1xUR/SQ
         NaSPTSQuR+0D5hdHpcmSsJjdTxYqCRkaa/Wzq2BRv8jpPkGDrYnLkPJupJhVQhX1if6Y
         Z7cYDN7HWN1Hlb9ql1iCY9vZeKnJ1qhCDB2mqVUSFGl2sGOVjdEHVOaPiSULsteRgj6L
         aJ3Q==
X-Gm-Message-State: APuU4Z8Fy1x7szaSR/sFdl7v/MQTln71F6t6OcmM48nwHc9WWxV6C7IE
	OHUDkwQlnRKzunAiOFgSX6KcB412sZYGs7V3qNl4Ap/QA43dfw4ZFEswHrrKzyeB
X-Gm-Gg: AZFdTZdXQ+ZKfUBq8Rxvr/4L1fNrSnErAbv+W6gKvc/t78+yC8MHdHsKR4JEOe06QYR
	ZbCtCfygk2gUB12DIokND5q1hOUrLuUekOOVvtX21c20QUUtLWUJoY//MFGQQs9Gkiy3ZF+VLdX
	zcZN69emW652QwCAZTXIU24gL52HKTOMHHBctxLqzgKc8aTqvh3DWeWUrEszFPoWEPlrs2Ms4Ff
	RYbipdwGTY4+vIahY5Lr6n+b91ifnBvauAaUmBvwXCXG7k2RHrLuaTy8JkYpV5Thu9LdeVWLUFS
	O/5LF1mclpqgMNGiUthnNHIgCInaeGh8/nqCckbEjT9lTcEeh+59tIJekxoyhdWbQMzN5sKYYf6
	JMy91ijHvasFwy/xmqWC86FnHBFRb+/qWZvK9fXPSvhcnBkeae00E5Ua2Q3GEjUmjLkw9Gjjpdg
	a0p0A+AOpmuiD/i8mpBvjPj1dAc9sxEDRbtgApTbQahzs6O5Mj+SEAn9NEDLQm31vmWFgv/VbjN
	4fqLsYbn8RH/oAdqIkTS0wqHOh/HnkaMcNM9Blt9aD2w5LdjXz4GNRrm6q1zvIZ7urAkx9QDBic
	5hYmtJGntDz6kbNHaGmERF+V+YdCVKeEm22aDR3nupMaHG/QJEkoIjHxY68Yd4I5UkGRxZlg36/
	LAS1CApQb0AcQ/s7PCYWMBjzDn9EGlIqr5fX/AvModYkCi51ScVNld0M4CkKtIWbKHcADCfn9h5
	vLLqdnBMVowwliF5aonPsUqMe1NfSivO6w
X-Received: by 2002:a05:600c:1389:b0:4bb:6519:477e with SMTP id 5b1f17b1804b1-4bb88813b35mr273527695e9.17.1795490212815;
        Mon, 23 Nov 2026 19:16:52 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-ad33-0d01-f099-1558-bc26-fd06.310.pool.telefonica.de. [2a02:3100:ad33:d01:f099:1558:bc26:fd06])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884911e3sm473350865e9.6.2026.11.23.19.16.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 19:16:52 -0800 (PST)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: bpf@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH bpf-next v2] cgroup/rstat: disable preemption in css_rstat_updated()
Date: Tue, 24 Nov 2026 04:16:42 +0100
Message-Id: <20261124031642.40616-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

BPF programs can call css_rstat_updated() with preemption enabled.
The kfunc calls __css_rstat_updated(), which requires preemption to
be disabled while it queues an rstat update. A cgroup iterator can
hit the lockdep assertion on both RT and non-RT kernels. The
cgroup_hierarchical_stats selftest can also hit it on PREEMPT_RT:
spin_lock_irqsave() on trace_cgroup_path_lock leaves preemption and
interrupts enabled there.

Disable preemption in the BPF wrapper after validating the CPU and
before calling __css_rstat_updated().

Fixes: 36df6e3dbd7e ("cgroup: make css_rstat_updated nmi safe")
Reported-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Closes: https://lore.kernel.org/r/20251119111402.153727-1-jiayuan.chen@linux.dev/
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Assisted by an LLM.

v2 places the preemption guard in the kfunc as Alexei requested:
https://lore.kernel.org/r/DN26CP5BB6O7.23ALW6CZUBYSD@gmail.com/
Since 8817005efbdf split out the BPF-only wrapper, v2 does not add
preemption operations to the in-kernel callers discussed when Jiayuan
proposed the earlier kernel-side version in November 2025:
https://lore.kernel.org/r/20251121040655.89584-1-jiayuan.chen@linux.dev/
v1: https://lore.kernel.org/r/20261121082843.44614-1-kmehltretter@gmail.com/

Tested in x86-64 KVM guests with lockdep on bpf-next 9867c61abbd4
(base and v2) and 2bf3351c5f89 (v2). Both tests passed on all 24 boots.

  Boots with an rstat warning               base     v2   rebased v2
  PREEMPT_RT, cgroup_hierarchical_stats      2/2    0/2          0/2
  PREEMPT_RT, iter/cgroup                    2/2    0/2          0/2
  PREEMPT (!RT), cgroup_hierarchical_stats   0/2    0/2          0/2
  PREEMPT (!RT), iter/cgroup                 2/2    0/2          0/2

 kernel/cgroup/rstat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index de816a43db9f..d72fe721cea0 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -131,6 +131,7 @@ __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 	if (unlikely(cpu < 0 || cpu >= nr_cpu_ids || !cpu_possible(cpu)))
 		return;
 
+	guard(preempt)();
 	__css_rstat_updated(css, cpu);
 }
 

base-commit: 2bf3351c5f894697e8443eeef5333d4c4ce90cab
