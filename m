Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792540957;
	b=UWApFB3ayAH2xEHFkrDSd6jn7nrMqxTmNTHTGCKCXnKlTHP+tWhMd83ISEkOd/pfYV2n
	 Oaypah+QfptT6innbPk7EjkFMGRT626NhtMIVXBb8X9lEXQYAY6nz0AUcL5zUoNGD2v4H
	 TJ8B98KF0MpSylsudqGNPfZsR43dIyIYk3ngwzewSk7FXjpTpWmq5aHTWLDbV6AmARihz
	 0CJkrnbdJ04LqfZasYeR3LTkOljCkInUzDWhsawr5KGX4awYdbJeT0QSF+wqj+dctCd61
	 w0rsxsh91bw4+2wCvgQ50hFXAeSbI6/d/HtL7MYgR18pyxVOnbe+oynUeAFnMOZnKmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792540957;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:From:To:Cc:Subject:In-Reply-To:References:X-Mailer:
	 Content-Transfer-Encoding:MIME-Version;
	bh=hZI2ljhmwoJ1V0BWfNbx3ZiTpuPjJL0odwQu02UU2Cg=;
	b=YUh4fwtleiscZ0IjKwb7k3bV3dR1pdC20J7gfuCD2LeXSv/UlQmWzNwSbDmV5ZDen3Tw
	 yCKyQa91qI1O1EullwX0E3Ga9GUYBZmOasuXGYZNWGjSUy5K3q0pxzLCbYLwq58HuK2nF
	 5+2lwoSHAYE5t3TSHuTqlcqtQtWJnEGfg0Bw5U6Vl2YgLfYq9qblTIvhoZQa1sedGDMzu
	 sJEdmMd5BCb0tDi2yD/IHKtKh/VLrUQ4XkZOTR1eH5eGMIHsv4H5aPoENPrA939bSbl7d
	 pRN9wlU1naSeVZormfenn3rMG500G2Xdfz2Nw/fWe2005s1Jv67X1kKIJXIlWRkoXoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s6j2cGoj;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0320606A322
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 00:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0320606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s6j2cGoj
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ad787e0593so104028a91.3
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 17:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792540956; x=1793145756; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hZI2ljhmwoJ1V0BWfNbx3ZiTpuPjJL0odwQu02UU2Cg=;
        b=s6j2cGojYGSaduWgRZnY74y1Mj7EaQAS2MUqAPbrCO81gc8UTnFk6EjOfGEN3H7r3Z
         4TwnXQqIrX4MlWzuOxgktI19j8uLAvX5Uxrww16C44hZHTkikR81UVcRGXtjjYUf71/l
         CMigxG0Rx0SlEjMYji7Ka/Iu3IKAzLsXV6YHrXZ0oGnl2mm+pMELJr8ENEIKM1TpEquJ
         1Ug4O3bKF5amZKyggPnan6da/B7WSHi+GpXzLLZL6dHTOSCf7llHmJXrcKlfHZsOpLrS
         IUA1yQqWtE5Vz+w5FvQhPq2oVS9DK1rI3IEZyOp8tIUbPc9bYvkW7uSvJ29zHKfE/NG9
         cidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792540956; x=1793145756;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hZI2ljhmwoJ1V0BWfNbx3ZiTpuPjJL0odwQu02UU2Cg=;
        b=MGLbbPDuTgxPvpaEQcDxiKn7MNeQymBiYLvmCe1MoOWiaDc9c5l+SgHPSbfGjnkSCu
         A7DAZlRx+XIxl+Hwuhigb8DKirWan/JtbwSFVngpE8DkFQ5SoJTmnTAw8QDhDx5/TT4K
         I2Mj7i2MZd/HCfPyHb4jiG1KUuvQPveqxWgvJl6de8agaPKtQGZeq+8vrpsctTuwAreT
         oqrSpz/pWk9N12snhiGajj6cT2e/K2RQOSozVpdINXG2i8H9L8+mRKGXTcBGtR1t6AIy
         NP8X3gl0SKbxZnlb1gd7oMDkZ0+K3f6PACTsXSBccivbsYAHy39UVQFsKHSPl4dfjUul
         6JxQ==
X-Gm-Message-State: AFq9FYJw1E44PirM/qvVhqHaSzJqSu+0sOExY0IangleP1Pd107Yb3uI
	g4GKGKTi5k6ajgG4mV1GLIIYbfre51b7shB+mNoWQQ4FOhm1uWcf25ph+ZHXVw==
X-Gm-Gg: AYBFou1XZZ3nxg1fVCUNI52SHI7CLrGMqlaBC/CS5HiHdhqupoHhnjKEThccZZ0Ixtw
	iUpc55InsmiLvzeZVRmXMQAdiUWpmIFlV0Ydv0l+BByIaf2jzge3JoGURGWoCVoqHMgCzbl6je7
	RhBeHK0JoPZGjg4k3M2ucZWw8ALuizHz6L+VSh5ph1EomkuAl5NfZXm4ZgPbAkvSSjcyphBEMha
	EGid9UQiUdnkxe/S3rABiM24VTxxwJ7ZJqzNGEBYsV+x0YvGJ7Y2/YhMYaMN1Y13xy3aP9bvA6R
	7de7PVPZ7GzM65yH/kD+I1J8ZCzyNBSOtDg/c0OW0KcNdo+ax/Ou1thwr0C7UMqkuTBY5Zhdh9i
	1xYeDalE/QfU3UREbIoOMpcyrGZ8lUZOP7Ki4gpeToKsvt37CgO2OdZvD2yk21IjioNfuIgUFTU
	GfmYS1dKFOImopWg/X3T7uLvo5jXh6TKZLNtut00Td07EtuU3LNrbDbAzkvvrGffh0AS+XjxC4p
	6/ka0K89PQuovjedaL+xlg4ftZWzuPgPLbv4M8rCdKO8f1rCHlU7Yje296Se2k2snljGu+uAYY+
	Tw+w
X-Received: by 2002:a17:90b:4b03:b0:3ab:be66:ddb6 with SMTP id 98e67ed59e1d1-3ad86e97e7cmr305334a91.20.1792540956165;
        Tue, 20 Oct 2026 17:02:36 -0700 (PDT)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad813eb9casm1388667a91.15.2026.10.20.17.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 17:02:31 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 00:02:27 +0000
Message-Id: <DMA2QEUR2QCK.TYMC6ONTPOZB@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Qiliang Yuan" <odys.yuan@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan" <shuah@kernel.org>
Cc: <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: Drop the on_enter recursion
 check of task_local_storage
In-Reply-To: <20261009-selftests-bpf-task-ls-recursion-v1-1-c3a3e3c41f8c@gmail.com>
References: <20261009-selftests-bpf-task-ls-recursion-v1-1-c3a3e3c41f8c@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
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

On Thu, Oct 08, 2026 at 06:49 PM Qiliang Yuan <odys.yuan@gmail.com> wrote:
> other tasks. On a preemptible kernel, a task can be preempted while it
> runs on_enter, and a task entering a syscall on the same CPU then misses
> the program. With other tests running in parallel, on_enter ends up
> with recursion misses that have nothing to do with the test task, and
> the check expecting none fails.

Show the log of the failed run.
How many workers and how often does it fail?

> Drop the check. map_a holding 200, which only on_enter of the test task
> writes, already shows that on_enter ran for it.

The race works the other way too.
When another task is preempted inside on_enter and the test task calls
sys_gettid() on that cpu it's the test task that misses on_enter.
Nothing is created and "lookup map_a" fails with ENOENT.
enter_cnt == 2 in test_sys_enter_exit() has the same problem.

sys_enter is only a trigger here.
Make on_enter SEC("raw_tp") and run it with bpf_prog_test_run_opts()
like you did in enable_stats ?
Then no other task runs it and the check can stay.

> Fixes: 387b532138ee ("selftests/bpf: Tracing prog can still do lookup under busy lock")

Wrong tag. In 2022 the check was fine.
Progs attached to sys_enter were running with preemption disabled until
commit 439ebd5b5708 ("bpf: Add sleepable support for raw tracepoint programs").
Say that in the commit log.

pw-bot: cr
