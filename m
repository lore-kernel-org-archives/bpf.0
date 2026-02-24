Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843333A1E71
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771946642; cv=none; b=GNoB8WQxnSaWXEyI7CmbrCHwsXCfUz34axaE94gNhNr65V7l4e73Tm3AHdizVv2kHLy8chA53UtoziUsIX97J4W+IlmIFXECotAn+w73jPZ8uM61MsKTCIxoQ8HqfeZOBzaVh4pKOYncp7DFISXGswSgJSNIdI+oCwkoFWi7N6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771946642; c=relaxed/simple;
	bh=UrTaP6oGvX5uJJoKd5IjdgYHjmOEKQFLa1uREBRJhuE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ECLTfXO4r0i6zQpQd/iUuAcbyWpktusA3HQ/ANgq/Jpy/+fsVEv8zIThrPSBj4K9gNOEgBjhrN5PihpPGb9/DcdQMd656WrT5EWNqxjyo1qZK5sDNxga7kTOwqGMxH8nu1CCykPInjG0H8e+5onG9/7fFGqNV8cHL+A6JuaeddU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtTdvVFK; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtTdvVFK"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-483703e4b08so45244915e9.1
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 07:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771946639; x=1772551439; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZP4AMy1sqSeWM2NP0BWkcgG45AN7Tm9+i3BZPKHn4+0=;
        b=EtTdvVFKvDs2GXW4GBI2lbMD7VwAc5rxPBC10PDkJf4Yz8n1rmrIsmG6Ovd1k36Gn8
         41ekeAo48fwZgEv9vAtoanQzY5DaFrXzqcXb4TFe2n3E7635tX36PVsO1asvOMtb4lBq
         GX11t6nVz+YchofsLVhkU8IMv4fL2gZWs7S0Gup0rUtX2WSgsYOVyTMND9vBmptVNXS3
         /UEnS65T13ZM/CALh4L9NxceoVSG8zoDXf7lCMsklOLyZZcTKO+c1vkkxQAVUIAMXZad
         CHUkVvR8BvbzuT1qbKiBimK+BycMzOHhUI1y1qF0lR9BvBI07Hnr162e1tUwVFRvrSk8
         eNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771946639; x=1772551439;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZP4AMy1sqSeWM2NP0BWkcgG45AN7Tm9+i3BZPKHn4+0=;
        b=tqnI5OCX/J6Ya3XqVrZBuBXYTyM5r0ieJjYqryFz6csJqlDlU1Tx/tz5AgPQnRN5zD
         Iy+47BffTBYUJPKttgGehF7JlI3nKxmILdJZ1mEicJ+K17kKimDba6Kb66ZJMEEfbu8a
         VDRBYbP8402KSu/qGJXEi4tY1/xWdtOtVhqy8WLXAF9Dd3JTblY4kmZfCbSLskLuclCY
         8aaJKdTm86zjwX7acmBb5PfJGia2cN78ahOj9d5wDRT0GDonyZFOWxsXaGLU98YhlCnZ
         JHq6S0it5m6GB6OfIPBa6fQOHJyJlS4qIjJXytfLLaFhSGqGgHlWQ1itkQtbnbwjwjCb
         BUvQ==
X-Gm-Message-State: AOJu0YxhMyjtZ3RQoTBaciO2Me+/cnBlaq53tudApklNdM8MXS8YdXKN
	MtUysybR6i/2QkmjiYiUg+s14yKpMs349UVfZcmStmwLF042F2yksKRH
X-Gm-Gg: AZuq6aJEvysHucFvAmHpGUMJoujxfwwABushQQeZQ+ZbHODrRZV3IHUMt9kdmzO15qv
	Dfem90B6mm89aSqhuPj2SsQe2qs4qAncldjxjkA1bxgfCLa4EBaOAekf5Zzh2woNINYuS8ijVJ5
	FVEbBH0wfQWQBT8GVv6xV8I+ht7hVHtbx62PR8QlBHPq1EiF8dJnmpXH9RGr1f2Cl8iVKzJZVjc
	Qzukj9hYbRk9bgQYneMRbqlJ3bQdn7o8WTLBfg/CGTve2VTdqjQGFuVsjvTcT3e9YvdCcd1p07q
	cL6FF/iVNlhmxgRASCDHqukBoukTk2DeuDDvhaJx+JYprJIUOcFH5IWOKz9PKMZd6Tp9JNsi4C8
	nOyJiF+VDQHa1WdAWtVY3VwSta5bBmhulMDinTUXuQnnf/V/64XK0Vl3hnibI7Mj1yke6dBs5ZI
	T+aM/R6HO/O2jtm4WQB2o=
X-Received: by 2002:a05:600c:630d:b0:483:7ea3:3de3 with SMTP id 5b1f17b1804b1-483bd7245ffmr5740345e9.2.1771946638621;
        Tue, 24 Feb 2026 07:23:58 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::7:95aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd6854c7sm18059045e9.0.2026.02.24.07.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 07:23:58 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, Amery Hung
 <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Fix flakiness of
 task_local_storage/sys_enter_exit
In-Reply-To: <20260224015855.1481707-1-ihor.solodrai@linux.dev>
References: <20260224015855.1481707-1-ihor.solodrai@linux.dev>
Date: Tue, 24 Feb 2026 15:23:57 +0000
Message-ID: <87v7fmb1wy.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ihor Solodrai <ihor.solodrai@linux.dev> writes:

> The test_sys_enter_exit test was setting target_pid before attaching
> the BPF programs, which causes syscalls made during the attach phase
> to be counted. This is flaky because, apparently, there is no
> guarantee that both on_enter and on_exit will trigger during the
> attachment.
>
> Move the target_pid assignment to after task_local_storage__attach()
> so that only explicit sys_gettid() calls are counted.
>
> Reported-by: BPF CI Bot (Claude Opus 4.6) <bot+bpf-ci@kernel.org>
> Closes: https://github.com/kernel-patches/vmtest/issues/448
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>
> ---
>
> I've been experimenting with running AI on BPF CI to investigate test
> failures. This is an example of a thing it may come up with.
>
> I don't want to spam the list with these, so for starters I'll be
> relaying only patches that I evaluated and/or tested.
>
> The AI generated reports will be posted with "[bpf-ci-bot]" prefix
> here: https://github.com/kernel-patches/vmtest/issues
>
> The goal of this particular application of AI is to make BPF CI more
> stable, less noisy/flaky, and potentially find and fix more kernel
> bugs. We'll see how it goes.
>
> ---
>  .../selftests/bpf/prog_tests/task_local_storage.c  | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
> index 7bee33797c71..2820a604aaa6 100644
> --- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
> +++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
> @@ -25,24 +25,28 @@
>  static void test_sys_enter_exit(void)
>  {
>  	struct task_local_storage *skel;
> +	pid_t pid = sys_gettid();
>  	int err;
>  
>  	skel = task_local_storage__open_and_load();
>  	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
>  		return;
>  
> -	skel->bss->target_pid = sys_gettid();
> -
>  	err = task_local_storage__attach(skel);
>  	if (!ASSERT_OK(err, "skel_attach"))
>  		goto out;
>  
> +	/* Set target_pid after attach so that syscalls made during
> +	 * attach are not counted.
> +	 */
> +	skel->bss->target_pid = pid;
> +
>  	sys_gettid();
>  	sys_gettid();
Maybe a simpler and less fragile fix would be to add syscall number
filter in the BPF program, so that we don't count those unexpected
syscalls.
>  
> -	/* 3x syscalls: 1x attach and 2x gettid */
> -	ASSERT_EQ(skel->bss->enter_cnt, 3, "enter_cnt");
> -	ASSERT_EQ(skel->bss->exit_cnt, 3, "exit_cnt");
> +	/* 2x gettid syscalls */
> +	ASSERT_EQ(skel->bss->enter_cnt, 2, "enter_cnt");
> +	ASSERT_EQ(skel->bss->exit_cnt, 2, "exit_cnt");
>  	ASSERT_EQ(skel->bss->mismatch_cnt, 0, "mismatch_cnt");
>  out:
>  	task_local_storage__destroy(skel);
> -- 
> 2.53.0
