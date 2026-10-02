Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C3947F2FA
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 11:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790940986; cv=none; b=Cfy/DHiWHu7tiui7LMEVXIS8pnbt9KgPdHqdn7kZBJhEF3CmG7t/c79Xqa9Emaal2uvRue2M1Ow4pSvGZ0YJ4DNjm/DOfIFApYY1tLm1JAQUih8rEfkt7mqNiWjKkz6bGBnxLVTrYDcfSjZy8ZYki4C2YhAIooEXtIhkoctXLe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790940986; c=relaxed/simple;
	bh=BteOxFPOpp0nkSMNOZeK1hi8GF2MqFIOUNnjEamFGEc=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:MIME-Version; b=t6S/Y+4Fp5wQyvbUeWuYYqS49R9y786AgFjJSixen7r1UHs3LneX7ziT38WFJEefDF9aLxatRax3AlyqSp/Lbsv6fyzbSuxXVWtEQVeWUKsxdJ49CPGdbp5c/KIVBDDaAJvTkDfhpWP8DRZf8X1KGeWUkbhkscKc7GmvSla0Dj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rMdUlf2u; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rMdUlf2u"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc78d59bb02so3045207a12.1
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 04:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790940984; x=1791545784; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6y1TJ6fPi3bQSRuuKZMOyZtR4mOZNb78Ee6wIn/nAq0=;
        b=rMdUlf2uQr5j6WKmO9xB+NSj9jq078Ng+C3GTNpomdFrzBHcFwSfuPhPu5tWnlXCJn
         UuyCC2x/gxzBkHEk4HA+GhQkBxpFiEHPqxoiyN0ay/rq3veym47Hk2K8m+jTrpWG7oOU
         Qbz3PpHqPdO4VOZma/yFTy9EK9qSyMkMSdbfa16CVOqnsApaOM0Qc0FILbAxfqQ9x18T
         SYMfO/KB/JbK8vNl/7SMYSSxgNHZWEovXjbcTRTzDZd4auDazGJeoTN0ofX016XmxURf
         H9eZM3v/W0+1OiVNrN4s1eD2pGKVI8hOojZAU2RpD6L5k5ZzDPx9NHqD7vTALdViPA7Y
         4nVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790940984; x=1791545784;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6y1TJ6fPi3bQSRuuKZMOyZtR4mOZNb78Ee6wIn/nAq0=;
        b=YPoilVGTzgo7V8YVWB523/maQRSET+zBpn24U1/oaw1ca81hbuSLjTwJ4BJlQfvu8I
         /qDILJ5yXqet2DfFoNYGlMUI7wkgKiRQ0j+gnH2LjsMJPb1k4GR85RXyG38eIqQ/4zWN
         V6kBFetfLqKKwhOdvFycKvHRi9a/ji8tytiG+nhLsOH3/Jk/NAi1GwdPRfILdWQaIMy2
         2p9Ct2DPyG6XBH1kigZi7NrwLBNMY8Fx2/ubHYv8CeIGihADUWNaz8yjKV48XL/gZgcG
         cz9gfos9XDYe0htsyCYnivif9xYbrZYatrz0sNRQOoX+6Zaepepvv24HsiK1mVVXvY6K
         GE3Q==
X-Forwarded-Encrypted: i=1; AKwUvByPUqfgeTem5QWy4jeHDvxIyVBSUfzZE6k+uLb7XXUHyci+rx3gCUlV+sVSNDZL7s0+/gk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIhLH+Kza15jujoYY2FttBj4B1hl0/adGbCs03ZmlpyVIRZroK5
	DmrhUmaglEMhDOsKERDIpewhKNmea/Wtjhtnbiicyl0zbn08sQg2YfEL
X-Gm-Gg: AYBFou0r3EwvddMdu8u8S+v8x/FcOdxbDLBQpP4KFOfa6fBfM///+jO+l6TIXidAYMl
	wjefbr2jAhTzb39QDh/M52AfeiJz7rsDDFRlpeQolLNnyrfyJQSX+SEusxvPAUhcYUs5tVvf09T
	Ie8SlXpB9aJBFtI2oxk47KE8ojodpc/gyuFctQ6yNqr1UtXMHTdX3YriDc/Ym9H+tZP/R9tfY/p
	NvmyRV9eckxLeQ3Kp7q8vduZ8F3g5/qJMMd5vA2G4PkXC0CoLbKgTHvxYST6jsOZ7yTzvxfxVU+
	Jpj/Zdi20cqrn/wUaf1OcEEoir215EeNe1MngfmE/lQ5efC3Cd+iEbgf3cJje0FeGOwEWcqErbH
	NR6m1sz0JtQGr1uYY20OwyyVpwE/4od89vhORmGAKRZoc2J+wM9HhfjG+twFHprHrt6ABBvXzGp
	VWkcb9+XwkAPzsjLJuMg6SQ/SibJEWoin+xobNva8Hm+otp7wcD02a2/+vpH1Lwnb+HKkDmOI/g
	wTO6irWAJx/B9qQ9bB1YSSnPx+npj6NxywW/Zc+KKcvp6pP/vO8c4PfJ/uJvr7I7ErWVCap676Q
	JY04Xxjdy01W0g==
X-Received: by 2002:a17:90b:3ec4:b0:39e:3713:c2e4 with SMTP id 98e67ed59e1d1-3a6ce6e7c05mr2068658a91.14.1790940984484;
        Fri, 02 Oct 2026 04:36:24 -0700 (PDT)
Received: from localhost ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f47454cfsm8410667a91.10.2026.10.02.04.36.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 04:36:24 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Oct 2026 11:36:23 +0000
Message-Id: <DLUBLDLVFYLU.393R1ZG12F4W9@gmail.com>
To: "Yun Lu" <luyun_611@163.com>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <emil@etsalapatis.com>, <ihor.solodrai@linux.dev>
Cc: <yatsenko@meta.com>, <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v5 3/3] selftests/bpf: Add task work scheduling
 race test
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20260930085417.186729-4-luyun_611@163.com>
References: <20260930085417.186729-1-luyun_611@163.com> <20260930085417.186729-4-luyun_611@163.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

# DECIDE: optional, log accuracy only. 1/3 and 2/3 are unchanged from v4 and fine. Drop pw-bot if you apply 1-2. Delete this line.
On Wed, Sep 30, 2026 at 04:54 PM Yun Lu <luyun_611@163.com> wrote:
> Add cross-CPU stress coverage for the captured-task cancellation and
> irq_work context-reuse fixes in this series.  Run scheduling and the
> target callback on different CPUs, rotating through three map-value
> lifetime patterns for 1500 rounds.

This test cannot hit the bug from patch 2.
race_sched_work() is the only caller of bpf_task_work_schedule_signal()
and it runs in the trigger thread only, which is pinned to one cpu.
irq_work_queue() queues on the local cpu, so bpf_task_work_irq()
returns before that thread gets to the next getppid().
irq_work_is_busy() in bpf_task_work_acquire_ctx() is never true here.
The target thread doesn't exit, so task_work_add() never fails either.

Either make the test cover patch 2 or say that it's for patch 1 only.

pw-bot: cr
