Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D19EAC7
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 00:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772755258; cv=pass; b=o/dRIuWZ4/WbzdUFPP9kyJpWgePoT66sx+5XpJBPsJdFJFQAm2g00C1TpBS+XlspPDV33b4rft390eXtnibXe9Cag1xDGjVu5S5Pap3+5dKg+RB3XRRXNv0d9W93niJQgggYA4I9qn0jjIyHgYMGdNSfBcaFIwKETsbUi7bcFSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772755258; c=relaxed/simple;
	bh=jRsauYAb/O8R1mJxxt+mtRx4RCCMNAsS80SQg73kaeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eOspE96LlXLzoD3uZW81DHl5YPJGD+5vEwVFDEFX+f9f0Hx4HPro+rfTXt2s05Z5ShbIZuX+e17qKkfN++OlgviLENovMtsM2n4EcSSI68kRdWWgY/CG3ymvHL3izF9/tZVZtWyHFHn0C739HFHGZ65VupO6gzZY4GZ2ZblxHfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUZRq7BO; arc=pass smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUZRq7BO"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-439c6fc2910so1814922f8f.0
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 16:00:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772755255; cv=none;
        d=google.com; s=arc-20240605;
        b=d1XkeeHInuhCNjsYPuGfzs0yMk2aF6BxuR786uUL833liVi3atw/iXUnYSiq6sj4EI
         RbpGnx5DacvU5DF7mP8AuJg4gmS6MiypVOPgQH2fEBG5qmhGiYt/KgQS7c08GBL//9Sk
         EBt/2m614mO0ZwAvRiiad5pH1sAjCH7bijPTjuEZmTZygy+ZefmyGYVkW6lMDZvVdGjl
         T/3dhA1bgGmcJYgIdqGZRR9SFf1TfjPt1vl1zXBncoYc1BUtDC81MPXLz6ToTMYrZUIx
         zGLsUwKFI4zshnV/YTJfcI/qkI3Dse5QCk3gj77818sP6tjVDAKUjvj39oBDq7Bck6bC
         TF3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jRsauYAb/O8R1mJxxt+mtRx4RCCMNAsS80SQg73kaeM=;
        fh=Ce0ibqXoVcrtpgJDCrQH13f4WUWtWrkMkYTRvRqlv+U=;
        b=K0HKFW1YsF9sBAKmv/atd7LXNSV4BKs0i7F58jp/Smc2YbH4JL3AgV6grgre6enbXf
         zoYU2T39EjWSuf2SId/URKBsBq+A7MzpHB7I9CSrubHiYxtF2CCZv7Lh9VkKnU2v9HZ+
         NHKu2TMcZ+XcWookMIxfIiapW4WIIazqptIoom3QH760P59W58KVFJN7lDGa8cDBmNer
         rjNpXlD4SMFH2xuLrntO1yuL8kj1+JGdQtuhMXoUaA639ZvGkbhH1LAX8f/CXn1sotCh
         SonZssyAP4Mwuuq9wIqsJ6Mb3eAJVP0JHydqVCqE0inGld4GnvYqafrD2AOTkKp0b3F6
         /fKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772755255; x=1773360055; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jRsauYAb/O8R1mJxxt+mtRx4RCCMNAsS80SQg73kaeM=;
        b=UUZRq7BOubLQZOXobh3MkiGkZOhSt8DRWM9mJq7Uk+DXfnh4UKW+sG96ykcuvuoJ+b
         +Jjq7H1kW5JThwi61BwO/h1sMbAyOmoClqfyF8SDbe88o5Xg4Z28KCN2P610dXJ/lXPY
         bawo6lgFNPGa1v3mYbs9Isj10mVBjLeozj0BCU6kL4yyxxaQqWOR9yZTqN7Ub54W7O3J
         sRPc74lXZrnAin3+K3Ee2XfDBEr3JvplbAHTxmdWpxXgzih10KfkW7sX2PsG+97snNYJ
         3WcuYhLSMiJBbQDSDPS8CwjGdRpO1s3oFxomAkEu0BD3I7iEfZHrsRzFBBbRMeogyX9S
         wtxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772755255; x=1773360055;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRsauYAb/O8R1mJxxt+mtRx4RCCMNAsS80SQg73kaeM=;
        b=EHUJILHaFfoeBXDzXWUIPIs+u4TtOPhFZ0ncsmpNvzVITdxDy6thvnyFirzus/FKfF
         VHgqOQ3e509jU0ueOL4EMR0KIoiMB6luuIfsdaLCldQMeq+4Sp2bz/qzk3yb/5spu1O2
         ihLwdoOlVp4SdfmaPNtPE1SWkMmYxdx5VPve2o59eYw9LFhHFEiLRmF6grxr795Vgxey
         SIwCMqsG0afrHngnG6euvW9hihypS0IIpmtPY/aLEAHudt0NqX4RcaG1N4MS62Bytp+s
         XRODCpUxBX1QAPWOA7CQCYxmSKF6cjY+ttY+Q818E3ywUbDVTcVPYBUfmPvvtPf6EQH1
         L8Dw==
X-Forwarded-Encrypted: i=1; AJvYcCVVZxmZio3JyoIJ4B/QqL0Q/yFl5zo7tCPzzc0Lt99AivdwrOfGZBznooKG1QVfHczjtHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4x9Z79onqCBBoyrHxpWFeguaOl9nnwWXqLtqIZI1U1RDn6r7l
	8fGgLNxWFDGLAj9AqqrHUhanE8ydG3G3aO/5e4ZnEeL6SuOt7SuwwU1vWh0p+TYDb0Yx1ocNc8j
	QGtyWnl+AUvpbn54a+bJB+GjoNgkyV8c=
X-Gm-Gg: ATEYQzyPoBarURWJcUaeB+858/L24hMSye7nzwya6JQ70ZYTQOosokeknyoxZh4CAH6
	hRV3o2ay7//Fx2Owvl3hNVDyGzAIxiAd2npQXfHs95W/V/BN3+8fk4KSfhXipmVe/5z26oKn9N4
	0x15EM/SkgR8OTjzeEtUBhgzBYUJHwmfEM9/b8HI0opF0bgiYxKPUpdW9t8q1l66yN2ZgTPIGGh
	mvretG9Xos7iWec/TMYMvglHg0oIhr3lH5bOv1GQiU4rfvzC+Ta2Pt7x2UK9eG2OjtLrNYwtwhO
	aYDvQxUKz7/agT4ayW4gj5cdRmw8wOCPQ/KpXwr/3cLs7S8SBCWvNWT39Fs=
X-Received: by 2002:a5d:5c89:0:b0:439:c42f:10d3 with SMTP id
 ffacd0b85a97d-439da67c522mr251928f8f.46.1772755254397; Thu, 05 Mar 2026
 16:00:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304143459.78059-1-pilgrimtao@gmail.com> <20260304143459.78059-2-pilgrimtao@gmail.com>
In-Reply-To: <20260304143459.78059-2-pilgrimtao@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 6 Mar 2026 01:00:17 +0100
X-Gm-Features: AaiRm503-nblu_Zv4HuBZcLkUaQYpUNSpcsO_swTkvFKxfix8qqgo7AO5qFDAns
Message-ID: <CAP01T77RgXhG_Pc6qhxdksMSpm07YhEvtcooEzz4boYv3+6GqQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] bpf: Introduce the bpf_list_del kfunc.
To: Chengkaitao <pilgrimtao@gmail.com>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, 
	chengkaitao@kylinos.cn, linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Mar 2026 at 15:50, Chengkaitao <pilgrimtao@gmail.com> wrote:
>
> From: Kaitao Cheng <chengkaitao@kylinos.cn>
>
> If a user holds ownership of a node in the middle of a list, they
> can directly remove it from the list without strictly adhering to
> deletion rules from the head or tail.
>
> We have added an additional parameter bpf_list_head *head to
> bpf_list_del, as the verifier requires the head parameter to
> check whether the lock is being held.
>
> This is typically paired with bpf_refcount. After calling
> bpf_list_del, it is generally necessary to drop the reference to
> the list node twice to prevent reference count leaks.
>
> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]
