Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795394838;
	b=1tIBWM+7U9zDCKtUkCcbAydxJQXSjcgk4OyOnPxkTDh3FMSDmfSXVS1l6sZ7E8CQ/+LS
	 U4Da9XNgw9gWnaLGJkc3pG1QcMRi2P2W3rqxB8Ll37GBRAEl0JoVBhaLsleZnZrldfOpe
	 jaaNvIfBlOgz6q7wKZk7R6WSXR/X8YyNGVyiIAppaxX6IYKwALwJbGPbLVxGVsYzTQpSI
	 gBVt2VHidSHGICc9FrxOa6J0ADK4S3bQ+H25dL0KoXkGLA7PCNnFLW7D1p0XUfae3fl2g
	 P50U9Kc9H9RhpSCM9Oy3lvIJwg5dDR/4yxsvoYqGOJLeGlD/0qVImbuKDR11X6UqRRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795394838;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=p7B3c6D/X11fLUAKKmi13BRTcfCArxOmxqQgFnPzAxg=;
	b=tnLydVQojLaymt5MQnM+ZS1B02ep0L1ZuaCbjXoBa6adstTpMvVSYJtfVfv65p6CJRXu
	 8OJwN4TzaLCumCVSLyVqhOmcATNhkvsl3b3aq9jUdqvjamruQpZoOfNsbcQcMbMZr3wHs
	 dqX/5uYCIP5ay4zbjkV45orh9soyTQAvKAMBmKSc3Na7NrCiZk8sb97OXnpGyzU7/ASNw
	 eCjfk/ZXFyVTrKOF/k70QfX2as7g0kT+A+yiObqdcKfLBIoP5lZ2o+y5OkiK4zfM1m1xs
	 oX0YBeHISHOJ/ABQ1GF0qcywqtYxQBf3Z0+C5ALNCN3J9JacrewVhuCbnrPs7XkzGfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wfmQXoun;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CFF606A32A
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 00:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5CFF606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wfmQXoun
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2f04244c3d0so22908015ad.3
        for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 16:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795394837; x=1795999637; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p7B3c6D/X11fLUAKKmi13BRTcfCArxOmxqQgFnPzAxg=;
        b=wfmQXounwgi2H0Qxd61oGE737FXdx3pXDGCOw5wqSvHmhLwHbMYTvLOPgZ1H4nzjgD
         9xZkG+9qJCwNtxDlgINthLE2KrlkMUMLdkTfkRrxDnHg2/rRF6WcXNrtFZn/qVjya7pj
         GmPnzJlTLY18Bw6jiB9/PWzaufJ/EuY1zR/bDY4BNg5qVHJ4zAEf5u4OYbZwir3oJJ5z
         bWrI5gRmMuSG8UZAQ3EXEX981myLRid+1mc7xa3vIvUo30DDFi2XIQe6l+1+d/QDmIr1
         g8buEHoa1fy3Al0T/O3pbPGiy5AkuwlrIPoraLH1Sm1u/V9h97CJmibvWCcdVsbF+KQD
         Rxiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795394837; x=1795999637;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p7B3c6D/X11fLUAKKmi13BRTcfCArxOmxqQgFnPzAxg=;
        b=nkPptu2zCbH1GUrF+5OpESR0UGe0EkYxGrs63v0UVjIWzZ9OziNxuQALCyvSB9HKV8
         qyaXUD6uvsX/81MhYzWDE2WZWZutPeRqRteDxLdmGCKiKLbKbC19ZU2pfaR/PhClXGTc
         5/9kp6EaXXPdOpjp6kvx2zgRmGXC8NGUsNVoYW/tXebH5YyzX9SWaHk6nM3eE+wNSUve
         LrZ+nnIkWPt7kaOhMgGS8M5+ew9lqtOuQ+MMvobqogLLEhUQf5TLhdbyreLlloAXr+S1
         Ks7uuJMXlKVLfwsSOS6K1zjoSpvZ9RPh+X5bSBG0oGjigNW0gGCQV+6JjS3WEZpHmiYE
         udWQ==
X-Forwarded-Encrypted: i=1; AL+hErET20F28GliVFhwD7ysxtIwsS4R6r2XnZEG8XeMuoIKinRZgVPOfFpriT4RGR/d+pxA+p8=@vger.kernel.org
X-Gm-Message-State: APuU4Z87H9RUJLbUbsEscV413ejnU7BZr0F/IFuiqMNrrFdABMVbia25
	hPXB/rhjpaa/qP9gYjJ+5ekKixsNYw5AyNOmIuiqI23m6JemPDj+11Or
X-Gm-Gg: AZFdTZcs0m5++dCVdbeJ0hhu6VN8O+PpUa3w8pO7YH/P+zj9LW8oJxECrKzTXboBeob
	zLC9lxFbKbRSAu7BYpSWhe1Rk0J9agzb+Jm0V2kLEaRaVKPLOV3tEvRJlccIqQAWlLrT0Q4WZVq
	iqYIZ2AlS0GZ9QCCh5ZcxtuSaNkcnlolsSJ5NcJzhb01zYRE0APvlL33QI9QCW0EatL7tifOF4b
	HqnWZUXu4d4RCtqJ8iao/RSGgfYWSZwzg3QEhNd0ejyz0FNxRXTrykH6DrYYAD5gByEL3LBTWog
	+TwJWDFwh2SoU4e5SJ+Ja9yK8Zug7v7pxZQHampy5hYJPRYomXzi9qtjZP36qtVSbU/lcHleXnJ
	NIngbuXcNm1gFlv6481RRsRlPGb0SLAsq1w66bN4PSeXX5CNg0h/X4HTYdiX6lK64wwx9+2mds/
	H2hx7kXkHCaODxWUFiHltPa7w8q1WQL+JeUp6VlTMZw4RVArHWjh8zVHkMpm7yXlnvaZh/rbb6s
	KqIEYwe1tQc444bCePh8RI60RC0hQNtCBpy+g09tTHkOLO7V0wHHH+d2kwh0mCyRmwHdaiXlRT8
	qqQDPSIwYFhCjqKFFXwmjzcn9G0g69qZHiHj0WI4raYssw3UI7R1kdjslIcmpQmRtl6s2uiJwyO
	rkKW+HZtSZAHgacsnYGqOH1xs+RJ8J7OF3Q==
X-Received: by 2002:a17:90b:288e:b0:3b3:ec88:72a6 with SMTP id 98e67ed59e1d1-3b41c85284amr8792429a91.3.1795394836739;
        Sun, 22 Nov 2026 16:47:16 -0800 (PST)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41abb1b66sm15471631a91.1.2026.11.22.16.47.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 16:47:16 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Nov 2026 00:47:15 +0000
Message-Id: <DN26CP5BB6O7.23ALW6CZUBYSD@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Karl Mehltretter" <kmehltretter@gmail.com>, <bpf@vger.kernel.org>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Shuah Khan" <shuah@kernel.org>, "Tejun Heo"
 <tj@kernel.org>, "Johannes Weiner" <hannes@cmpxchg.org>,
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, "Shakeel Butt"
 <shakeel.butt@linux.dev>, "Waiman Long" <longman@redhat.com>, "Jiayuan
 Chen" <jiayuan.chen@linux.dev>, "Puranjay Mohan" <puranjay@kernel.org>,
 <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH bpf-next] selftests/bpf: Disable preemption around
 css_rstat_updated()
In-Reply-To: <20261121082843.44614-1-kmehltretter@gmail.com>
References: <20261121082843.44614-1-kmehltretter@gmail.com>
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

On Sat, Nov 21, 2026 at 12:28 AM Karl Mehltretter <kmehltretter@gmail.com> wrote:
> trace_cgroup_path_lock. On PREEMPT_RT this leaves preemption and
> interrupts enabled. On non-RT it masks interrupts, satisfying the
> assertion.

let's fix the kfunc instead

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index de816a4..d72fe72 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -131,6 +131,7 @@ __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 	if (unlikely(cpu < 0 || cpu >= nr_cpu_ids || !cpu_possible(cpu)))
 		return;
 
+	guard(preempt)();
 	__css_rstat_updated(css, cpu);
 }
 

pw-bot: cr
