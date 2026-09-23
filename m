Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768F547F77C
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 23:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790204646; cv=none; b=bnyAkON8U3CXTTFfq5mh54AiWMG8JydxRn7u74rQKZnYK/zXVc/FyXGsDSPW1OdvIp4js8pRVDuhPaXUP5pPbbWiKAkFnrSzIdqzNHXTO/GAfqKk6w1hwJDCDdKG8x+6NT+brGjVsLLOltR94zBKSmj66KcL22G0HIrVQ84aebE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790204646; c=relaxed/simple;
	bh=p+jVyMeUEQUL09ifX1F8LQwxzyHKOSVwtkvnb98dS6s=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:MIME-Version; b=qBU2nyw6nM5J7zyQ1kL1eFo4C7YA3qfh8jCp2CaCXtivO6K7AcqOY3PECwYo2UJgyanGrpBwW3SHPPWGWgzblPC9Wyh/O9if6coGih582LD/KG5e6WTL6BlbghUbo9ujN9nu3hr4mJz7nxbNfm11U3DnZnRPJ3/6zuHV6OAAmmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BvfNOaQt; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvfNOaQt"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469d249c6so989058b3a.1
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 16:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790204645; x=1790809445; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u3OBrGaW5JSQye02Yg0C4tyMSPz/cwRqY9o094bfJF0=;
        b=BvfNOaQtASyLr3gLSGXMq0DVIujAkdH2IweQRXXC3gS9zdBk/rf3QEehhK36k9sW7P
         jWT0kPR9AED1i9Hg83o5xeQCUedF1fOKDUGhHXz5jPuED4qXMdKWbW/S8f13jCam7liK
         oso4ovZvLCTqXIhoQrLOwNwIBnfPYhq18f8P6mpjarZH69Ljsja5YiqF3TFkoHFhSkfY
         YY2KNnnQvDOulBnl7Fe72DrmuEcRjfjZsyfNAS+s8fzzsNfRZsLvRU1CD/w7XYHSjc68
         V7D5klujugyluwQM040m5Yl5xIZZ2Qkyhp8UT/PPE2QjmMg5i+9jJCG1o2Az+ZJPfD3Q
         i8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790204645; x=1790809445;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u3OBrGaW5JSQye02Yg0C4tyMSPz/cwRqY9o094bfJF0=;
        b=M0uunNmQMFfMS9ChSW5xcvfZVHZGMxY73E7kPRn4G+ztHTrojqVPuEzCo/QF5y80Cc
         8glz9mfsf7vgFsGq3HVKIMyn91TYtfVpD1rytF/43/Ix0mu/wsD5x3HpgeD94Ydvdoyu
         ntUQc9QskalxuquBCLGUJY5EpDDMQQIavnuHHbds+pzExNau50Ui5YdKKCEsU1N3XcLi
         NX/5J9jgp/xucJdTMMP/Jd/1bcvQfVrKLKYDexkH0P57yKksii6aS6zBLU/7BZRuFjpS
         rZdkxAV9u0C5x1O0Tam3f7ckXJI7THFx9GAT9zdxYkBemAgpiLtvF3U44aPtt/x0i4cx
         or0w==
X-Forwarded-Encrypted: i=1; AKwUvBwTUvsdk4pmFJyPFEBw5rnThsk8XHVwoVrHKIe6dcAagMGotjT4Wlb6qNwKh/xo1+fACLc=@vger.kernel.org
X-Gm-Message-State: AFuF++mKJHfxpue+VvvX2kCOC8XqOE4UNI9u7PN6zHbRGU1ILpYU9+Ll
	6bPsRQHnT4fZ7ghLpW9lTnk1qeb32kmxQYCVPTgtH9LuIe5TkKuhoy8c
X-Gm-Gg: AYBFou3UfceT8YvwaIMg6A8RnQcoCl+lj064xylafKj8X/YrjJBhsL1guUvpwdRM7WH
	BeBiMf935y4E9va9TgBMoe30HABT8Y+XsbewgUXCMMGIbF0A03Jw3IPzJBXvm56ZCt/8DAkAj+J
	ChOfh79XKa/+JSNoCLrYXDLec6/aMDbtHJLflP+bXvYNn+43mWApYyDyk22lLPhXs8TXGQnNtvm
	9D77MsvqhNpj4iiwNXOzWr78TYdqn2g6a01fu7AsgIoIsQTInPm38LYCBn02BiTaew/198SAc9u
	2n5t9hY1+CbhgrK+YXzwUn07eFRDgojk7DL1LVq9gGMBWyWUyrXn8QxZUkhAPCUh5G4Hxg9ZmvM
	c46BQjfKTa3sUYGI18N9IBrqTa2VQf9b7bkNU3BD9BPieR/KN44d02ACGws7fk8shrg5cTEjdv8
	1oP8IQpDoB7VUXzciRtqxlfYAWleGsH1vpFQ1kkVls50iJOLFHWkhiUXNsPeyJPKZiy+qWD4Yzo
	VqEaVpbzolAPMrtHkLiu+5Ri/HLkpMcA/CxAXO+DyVhb4Wsd861zkyCb6zb0Rkq0Yx8FR57ANhe
	9m0=
X-Received: by 2002:a05:6a00:4c18:b0:878:34d7:6a28 with SMTP id d2e1a72fcca58-87e9bb85c53mr455578b3a.42.1790204644616;
        Wed, 23 Sep 2026 16:04:04 -0700 (PDT)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d3894211asm1759781b3a.36.2026.09.23.16.04.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 16:04:04 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 23:04:03 +0000
Message-Id: <DLN2KZR6RHH5.2OO4ZIR0XA36T@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yun Lu" <luyun_611@163.com>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <emil@etsalapatis.com>, <ihor.solodrai@linux.dev>
Cc: <yatsenko@meta.com>, <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Fix task work scheduling and
 callback race
In-Reply-To: <20260922100042.136818-2-luyun_611@163.com>
References: <20260922100042.136818-1-luyun_611@163.com> <20260922100042.136818-2-luyun_611@163.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, Sep 22, 2026 at 06:00 PM Yun Lu <luyun_611@163.com> wrote:
> -	err = task_work_add(ctx->task, &ctx->work, ctx->mode);
> +	task = get_task_struct(ctx->task);
> +	err = task_work_add(task, &ctx->work, ctx->mode);

Why?
There should be no need for get_task_struct().
rcu_read_lock() keeps task_struct around.
bpf_task_release() is put_task_struct_rcu_user(), so the task is
freed after rcu gp and guard(rcu)() covers the whole handler.
  task = ctx->task;
is enough.
The commit log still says that rcu_read_lock() "does not retain
ctx->task". why?

[...]

> +	if (unlikely(irq_work_is_busy(&ctx->irq_work))) {
> +		(void)cmpxchg(&ctx->state, BPF_TW_PENDING, BPF_TW_STANDBY);
> +		bpf_task_work_ctx_put(ctx);
> +		return ERR_PTR(-EBUSY);
> +	}

This is a fix for a different bug.
Pls split it into a separate patch and describe the sequence in
its commit log the way it's done for the first one.
"publishing a false SCHEDULED state" doesn't say what breaks.

pw-bot: cr
