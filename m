Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676C540F8F9
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 16:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774543192; cv=pass; b=vDdhIBFQro33ySkDQ2cc7BHq+s/tU5H7neSpU0gWNR2gRGauD5ACznJKTfR6+rpkVpcJ7WsG/cdBP6RX6kvlVeQOcTrCo7EhS674xrRr4grkex2paWwLhZpn8cU7lg4A/7ecj6fLeAhBIA7MPBi00FEDGB4D6uUcm6xe02XGHts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774543192; c=relaxed/simple;
	bh=pVssTTakTrlXQ09lOmP3Bxklsk3fDuJxODocEdaPHos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ImA5MwLoVtIYzr1/T5ArRwkFgnvWoWRKj0Ze1XExsPZ14rrhQX+zpWdM6hMKRgF1xX9d225PidzhShtCDfxNAIwE67AlZCoJNMqiTmpbOckM/NiDf7lrctTLCjKFI/w99N8bmmw5gOhUmxl4NGG2TCH4RU26FldMwx+qWJEHhXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/QUZgQl; arc=pass smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/QUZgQl"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-48540d21f7dso13210905e9.0
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 09:39:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774543190; cv=none;
        d=google.com; s=arc-20240605;
        b=VfgEa1UWRJzCFw9Os5pcqABQYRa+3T5/ofLRt5cYYJhKgmU/8kvTlwFyquvGQdi4p4
         8ha4tM49wjWOE8Nsowbo5DkmaEdteUWbRDDvgnZJvtUhE+lRDwSLdcxaXwzpNrqg45o7
         7N5VgMJHjSKLMZxmgJrL8XervsBgIubkAmiIIKbr80Ow/NCqX0HWtfV5o4WR8n+4osnx
         K5sewDafnAehoEL/O5A7NWQK6QXEoHi6L95Pz7D5DnwW9bzrRrT6UP2GyR7jpQ5wY/zU
         ElPTKPqrkr7m2KvoJg/4yjDVL2uvknK1to3wfV/C5cBdsRxNqgHGVXVwVrUMOVmbCain
         mVFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pVssTTakTrlXQ09lOmP3Bxklsk3fDuJxODocEdaPHos=;
        fh=mV8Uwy03aTQpEc71kkKqimIDFbwq2oIhKiU5zAUO9K0=;
        b=IuqxQPPsyBk+F1C4sj/csS2DJmIB9rS5AQQDeKLBouDSgPe4GjEQRSoSRpC5ejcqzE
         Lx1AxUO1f/PVsVAnh471yCunjwjxW0cmAC4WIUiuvsEDiInNPwCtIVqVfP4roGJbhj2k
         mazLlf9c0xU/frp2znnGnozpbZ+immeCIQ0L+Ihlmwkxzfj61METCjLtbrzH90+Xpw5O
         TFffi8/Ol4qRO7LOI5vNtvG8LRRlSZkRlQ2A4rQX5tIwdA0Q8/P10kD8ANdHtaATUWyE
         jTjFtGgzx75hjXCjNFSuHSy7Tf1FLHgf0hci1+tXl7oYnMkthfXSPEdSP0utynso+Dd5
         c2DA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774543190; x=1775147990; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pVssTTakTrlXQ09lOmP3Bxklsk3fDuJxODocEdaPHos=;
        b=C/QUZgQll8hDgh23b/1HVBfvZNvH46fxRsEdKIYBmcXE+4uqr9bSGgUeG0O3H3hxNu
         bu5Hb9niSdazj5rfQBqHMqH5YHWwarWCIumgfGxltp28Be0IzuHXmSnoEL3k2T8wTOET
         W7MuXzZBUdSPEUrYpNL0MRHhz/lMOCszYxaN6vnCCQH81k0IxmNjTB+mpVxjVRyfYu88
         xhREYsitAkxduAhglAvtzBwExu5DMuKFLGJJDkLq+pMekxOpgapkV0OCppVmEpaYfJrl
         qpilkI8lvPGUH1NtyNVP2hpRUbA/dvvJaqphl4VbwvR5u6UuUBP4IwQvG/yj14UvpJdz
         13RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774543190; x=1775147990;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pVssTTakTrlXQ09lOmP3Bxklsk3fDuJxODocEdaPHos=;
        b=lAV+3QcTlYYuYmsaexQsCieA1qP0QC5yEKj2HuEphZ6rA6aTM4SOMWLJDEPiQs4H6i
         GmhpYk2UEkoXQZ3bU0aY7hnfdwyoRCfx4OP9ilMJX/peXAWzb5NkxhBAflW+26toTJbn
         zvkgcrqoPGqx6v9LRzDytbXXLnAjPzniBTYnCsfBSKTGxCvW840Dp0h5VKRzlJBH0q/W
         KYnQsggEQIpcNK1Bfq8RBWDwrjotOClFUSZDYoF/JYzg0cTeyGtj6ImvRm3LUA5GJg74
         FVOZ7SvBadBhbfcjinxGoEWfqdMoZpXYHuh6b/JBIAV9nf9L8h/ShMWZ9rZSWbVAdtL1
         oZ6A==
X-Gm-Message-State: AOJu0Yz+/vIxCuIYdpOYeSnx628bKaRdvc9W+Tv8V0UaJAy0iEz+JDMD
	4yq42RJv9xF7YfXdWeBPz4f46qRjqaOLZ+B+S3RBSPG+7PmdjJGKrShIvdIDU/pueCwJbe4MtmG
	UgGKNSGM95GfNWEAoSx0VHY9zSfGO88A=
X-Gm-Gg: ATEYQzyBBzhIKWdUdKbnjcCllmQ0dfYC/iLJXPdu8zAlJ/8sgePZ/VtEXLEZECWeYQA
	KUPadyzwF0SuegXeozu+HyoFGXhzTS9ovxWgUey+JobZyqN5lHnPFcTS6AdtsqA1ezhY9aOqMXo
	O93hQsZGxcNMtK8xKdsHPmLZ98p+HZBtPV2gpKhjLM+pq4ik074f2z4aNXa2HCsoVoBywdyYJCp
	JkBjFaQ/pb111LgOvmcnvTj9NKX4lySoVfhHW6dBpl+EjWSN2N/r5aiy6OmaGP3euShREpjBBqp
	neihb9J9gVAmGNQ+j7oQ83cuj5TEJZoW+nr1hDQ7d+taSn3bBbT5eATOzV4W
X-Received: by 2002:a05:600c:6088:b0:485:7f02:afd5 with SMTP id
 5b1f17b1804b1-48715fff77amr123768885e9.13.1774543189404; Thu, 26 Mar 2026
 09:39:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325-sleepable_tracepoints-v6-0-2b182dacea13@meta.com> <20260325-sleepable_tracepoints-v6-2-2b182dacea13@meta.com>
In-Reply-To: <20260325-sleepable_tracepoints-v6-2-2b182dacea13@meta.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 26 Mar 2026 17:39:12 +0100
X-Gm-Features: AQROBzAn1GOvCQ8tN2B2E11FI-cfkaK4BI0eXJoUul4A_t3ejR1zlPrXcXYJfEg
Message-ID: <CAP01T77s3mTYqKsZwUCZ7pidhcJ0+_3D4=G7T7qZHLi9SLd4Yw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 2/6] bpf: Rename bpf_prog_run_array_uprobe()
 to bpf_prog_run_array_sleepable()
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Mar 2026 at 19:55, Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> bpf_prog_run_array_uprobe() will be used by both uprobes and faultable
> classic tracepoints. Rename it to bpf_prog_run_array_sleepable()
> to reflect its general purpose:
> per-program RCU flavor selection for sleepable program support.
>
> Add a bool is_uprobe parameter instead of hardcoding
> run_ctx.is_uprobe = true. This flag controls bpf_get_func_ip_kprobe()
> address resolution and should only be set for actual uprobe callers.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]
