Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D07382F25
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792253390; cv=none; b=VkI7rW+oFS22etww5R/kvBT/HClNo8k/TNT4bLzLQreq8WXaRH41K12UHBVhkFm0ZDm2HrWQbDUbVvQUwFHbgrjPVgorrYXmSwLEs51CAsyYaa0/XYkroPiKCznEwhYpIWLl6tu5EzRYAqbrNXHY0lsgM+wt8kkzxr2/4kxZeHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792253390; c=relaxed/simple;
	bh=tTcHuoJMWoopIonlj/PQ5Xr+4usFlCPYEylDr8x6qXE=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=QHCujk44+59BGNjmafr8IBZogtnVJUFJ0Md1Dt2Hqef4GLMPnp0eNT6joToR8rDCuSq1IAfqID+RttMw/xBumULrT2AsHKSMtA3rnHwS8DMaAxAIE7NtgNnhU6tw8hPCSPqbtUdCEfeFeEb5f8ACJSP4BXxwRK3IrL9L47qwhhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MshgmktA; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MshgmktA"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ab752f6244so765182a91.2
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 09:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792253389; x=1792858189; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tTcHuoJMWoopIonlj/PQ5Xr+4usFlCPYEylDr8x6qXE=;
        b=MshgmktAoLfM462RRv1ND19tzkgxx12vdbc9tF24wLiw0XOsUVOqg+LKIus9fj28f0
         wbO1Dlo0NH/s8jcUGgnuOotjZBWTmeC4KIKMRsprGZmmy25xHgd31dLAVCRVsOAyyuZs
         SPN7NYPOYHLT3ALJkoOFCYdjMLPPkdZ5z3WofbCAX0geANyqpO5/R2wi2GJJXA3MX0NN
         Bkk4VwORnubi4FTUjT78QolyxERk+ZSSx1KQPYUQS9SdiU1MVj+G5Yb1wta6unNnM+Ba
         SHYmW5psFFJ0ooaeHDc086nyNmIstIQ5gB3aMVVlN2T7v25YBIKSGPdxykC3NivVa51I
         j3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792253389; x=1792858189;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tTcHuoJMWoopIonlj/PQ5Xr+4usFlCPYEylDr8x6qXE=;
        b=RYsyAT2L96B77MB9VwvJrwA1EoTKbbCLtbCbiL5PEgWeBW0fKxwmcp4LgrfVTmCE23
         TR6qySOrwY1sTqUPVcsXwyqtRy1D4okP0t5VJNYbC99ywh9x8qmEuqW2ExucllSw5I/X
         846LZIghJEmAzSOg5GaE/cb1YjkXiBXaSdc+JYJBLCkljB/2/+ikYrhB0WjpHXP6PDRb
         eaV+2rvQjQJCQieYp7i7Sbz89GKcXyVeNbCjgGMwlIut5kH9gh1FZXxCKP17u7R4Unv4
         rQXrtNBDTir4iyzuQ3wfhuLVHHhW4hRqgsTmyQGW18Cq4AcdBNcWospKr3XBy/r5Z/BV
         oCKw==
X-Forwarded-Encrypted: i=1; AKwUvBzn2B0G38FJSvTdnreZFdCip5uHMqDzCTrg4ifUgR4XByixdq0cWnJ5Srx+QzzdV73Sm+Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYJFhl6pgjPCR1pJisbQsdJlvPUILGrg9XVj79qgXTOPk22xxIYc
	MST6S5ImBukKAMlb+pVGXmXdAL8ZVqujc7E4jbk8rIiDwl82ji0Jb8Ho
X-Gm-Gg: AYBFou1W8stnec5o6/AjSQ/LasmHaomy3MevoUAygi2WU8W3x6r7YRlJ8gXZmy2FVdL
	KLMeDBXtXf/ZHzMUBMrehvf4bE4pQ2GnrBpjo4xmaL2/FigvSHaW6kb4eK62w2BUWnXgnTqQDNE
	HkT2bg+tncem81PByEwLCLdWSCfqlZmyaVXQKWPs88gw/hUTDDWzKwssoLCB4lNCyxu98QEYIwe
	9FUVqQla35tNiBKluAi149R1+tTPRDsUU0DNksejc8idOeo9ojruzsWFBTtCGqo4SJF5i9HOCKQ
	Y8/DrGBSDZ+PXlQyPyR6OXAtsFlfjrEvxQg8+N/ZYOI4pCY3l6ZZNzTlzgD7gsKkSvmFT2qoLiV
	mT8YDV8gCDQenhlJNOsGgqhENqpG6jk6okUUzKNo9SxepGCDqosT9/Zbr7x7KHF00YPxwHmJwTx
	pXNHHGcpWcL1R+sLiE6GV7+qOTvuU+a551yqCE6mimrC3VuRPOv6dzTo1WeUv2syNSV2KXfKKo1
	A4nDcOg0G5yJAw3u6hYSdTzFDtLEvlrer2vvZSl1px9eVfI+QFb+qPjkvJZtty/1q/9lbkC+zYG
	FUc=
X-Received: by 2002:a17:90b:2e90:b0:3a8:2c7e:8986 with SMTP id 98e67ed59e1d1-3aceec73203mr2871670a91.17.1792253388700;
        Sat, 17 Oct 2026 09:09:48 -0700 (PDT)
Received: from localhost ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc48f19d9sm8625486a91.11.2026.10.17.09.09.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Oct 2026 09:09:47 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 17 Oct 2026 16:09:47 +0000
Message-Id: <DM78SVMBI2XW.2XHVC67VON48A@gmail.com>
Cc: "Nam Cao" <namcao@linutronix.de>, "Wen Yang" <wen.yang@linux.dev>,
 "Tobias Schaffner" <tobias.schaffner@siemens.com>, "Viktor Malik"
 <vmalik@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "John Ogness" <john.ogness@linutronix.de>, "Gabriele Monaco"
 <gmonaco@redhat.com>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>
In-Reply-To: <87bj8s8ih9.fsf@jogness.linutronix.de>
References: <20261001152042.124445-1-gmonaco@redhat.com> <20261001152042.124445-11-gmonaco@redhat.com> <DLXSI4BSRE5F.1TLKCBUAGNDFQ@gmail.com> <b1fb01e1c58893795dd4be346f233d39fe653aaa.camel@redhat.com> <DM6H7SK4YZ7A.F0MM6C0I77OR@gmail.com> <878q3xtptq.fsf@jogness.linutronix.de> <8B3FF026-6159-48CF-8FEA-AF2FACD2E4EB@redhat.com> <87bj8s8ih9.fsf@jogness.linutronix.de>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, Oct 17, 2026 at 05:23 PM John Ogness <john.ogness@linutronix.de> wrote:
> That sounds like it could work. As long as there are kprobes in the call
> stack of violations, I am happy.

No need for a kfunc to get that.
bpf_printk() in the reactor is a regular bpf_trace:bpf_trace_printk
event, fired from the prog where the violation is detected.
ftrace triggers and perf can attach to it.

> A delayed kernel record is better than none. Although I really do not
> see why it cannot simply call printk_deferred() directly. It is safe and
> lockless. And it has the advantage of appropriate timestamping when
> compared to any other printk's that may be happening at that time.
>
> If we are already adding kfuncs for panics and violations, why the
> resistance to printks?

printk kfunc wouldn't be limited to rv. Any tracing prog would
be able to write to dmesg with no rate limit and then you, Petr
and others will start yelling that bpf is abusing printk
and dos-ing the rest of the kernel.
Hence let's avoid this can of worms.
