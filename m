Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757423BBFAC
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 10:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792233762; cv=none; b=HBgGSOc6wWCVK6rm/7DQK/AXdwrMxmzrUTB+Aj7kSdJZjaPHID0fs60JU6MzUsN9m2PEe12ksIMRDRIQgh4cIIMMhaS/6Zlo/EabvmuYaYP9YcVOtJuhX6HTBm3X5Fa9qyNtj9IZtTFIx9REI/QvQCKIrJKJP34Bfz3X2jr/cj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792233762; c=relaxed/simple;
	bh=luoXeTg/DwvulkFlzn/Qv4L0LOqhemmdtqaKBtyvDd8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=urvgakZLq8jZE649clPPy2Aqw96ATsRqzgdFFCANK5yVpnxY77MNBW+yPGBGkPULrKQk2z1vZMDUvFTK9NRBMHC+udIYWOImh1Ts6rcqcbYCe/BFsPIB3PpEOs+Ao53nWiweRaEQNzIIH6z7enJorFJrEFe3g2zGM/OGExvW7/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bNfCDJ1H; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FhYcJmNP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bNfCDJ1H";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FhYcJmNP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792233760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=luoXeTg/DwvulkFlzn/Qv4L0LOqhemmdtqaKBtyvDd8=;
	b=bNfCDJ1HfMjvB6Um+jOjLFls4ZBmnEBcg6fYtxVgvxvuHEuixeveS0X8EzoVwFH2VILaYe
	B2Qrce7w2ZCJnJa26t2UdOYX9k07klI/DtpM9wah8kMYaKcq46J0HaIuQe211hzaBFvPlr
	VAOY7AUIhYF7qtLJ0K1qRqHEnH4IIwo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-yHioWTURPJiY7YXWYvLB0A-1; Sat, 17 Oct 2026 10:42:34 +0000
X-MC-Unique: yHioWTURPJiY7YXWYvLB0A-1
X-Mimecast-MFC-AGG-ID: yHioWTURPJiY7YXWYvLB0A_1792233753
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48c415561aaso386182f8f.1
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 03:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792233753; x=1792838553; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=luoXeTg/DwvulkFlzn/Qv4L0LOqhemmdtqaKBtyvDd8=;
        b=FhYcJmNPzD+Lql2+KVKFNI9Q6fhnA7LxV7sDZSbtiSV/TjDMCNurb2Wn3/n3+P9A4o
         23apgradFnC2PJOu1KDvGcK0pD4cUsWGiU1Wy2pF0wNJPaCT06+LDtHPvEEq205CR1xY
         83OfBvfgfziEXezL4DxjSjGferhzxymOZueHn6TPzTLt89S0pp9h1IFxIhyCbf8zjlcJ
         JiJaDseb9UgZrVNnn+Mgd/8tArc9/oNaeq23AwetjWyDMk5Uf4RJkZ9RsLW3tPFGD8AK
         EIzJBEPhbB75W1qI8NVh5rSIkeNlMuwwicF9cus7mZmoMw3GMu3Gy6EYL7e4/uvzS6zq
         QV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792233753; x=1792838553;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=luoXeTg/DwvulkFlzn/Qv4L0LOqhemmdtqaKBtyvDd8=;
        b=ey5hXltK3ZOJ5cRlctpIGx7FXecIZjXL6u3m4vfeepEBrXQEgWaoRZ/CrASvxgsGkN
         IAAxUJzdsJgONoswoRGsdE9m9H69rUgWMsioLyqN7LsMBSj7huzKBxkwJc9Zr4vjZoFY
         DKf+H27zaj9/IM9Ufy4g/96Fbp2a9kw7YTMBax6kGrcEO0NQxxKRlenG2yIXUPFlIX6j
         xYZcHo9vty3/okltnC/OgDksCB6fnMFAB2WSokVdGDB4RZqwoAKUvLfCbXMbIZ/JO6RK
         twSa/lg891UnSYtabhAk5gNd6qNK6Zy3hlrr72aKVVL1gtoHBI5iZdn9Aw5rY4uDLYsJ
         PGgg==
X-Forwarded-Encrypted: i=1; AKwUvBykT0DHzgdmCdN5fx2RkzGJemefEDbmBjsXoh7BnI9HYgeRAw1OgN0QPtz8U8KzqUi0V2E=@vger.kernel.org
X-Gm-Message-State: AFq9FYKexqZ+/ySuYd86HaCMDglx9zzT5HbrrkpvlWdnhIX/v5vn1wFX
	U3yoWeqU8PRRF190bYUqrPVYARND2jrhdzygwCfBMovf1sd/2TQ2B36rWERbJyBxpZQTeq4/ZLb
	2N9aYqhac/jcsAYXk0CJnEseUQaJx4Mr6kz6UQ7qa9+x3IbrJcqbRrQ==
X-Gm-Gg: AYBFou3VdGj0ZFcpGaBH383a4EctcsGZqZIfe0aUwUdAATO9hW6FGVKIqtmQs35GHNi
	Lirc3erj5bGO/s9X3lWNpviBwkxEXOgqeaEsHhyeJ/9jSVzZJCPxetBs5ixP+55WVzRI1SmEbqm
	q2/VjwXnN9oM8ZPhPdbZR3pdmTJUz3wQuLdKwFacNgV64wgWew3V8YPGUEvyPi/SL7akOAIKQx+
	ItSRwUu2txNvLPLIOVDdLGwuAs8GZ7uMBURaQ/x6WNjhYNXc6YgshJjq3ksrkM7bNRjIsxdzFbu
	Y5ItwpCMnP35QVEDHdTvi6zMtl2ybglAC9sQDAsvUcuK1HLrbCcYYNIkxfhwqKpAbyO7MSbHian
	oH5093zLD
X-Received: by 2002:a05:600c:4e11:b0:4a1:acaa:c355 with SMTP id 5b1f17b1804b1-4a1d75f252fmr47251915e9.10.1792233752740;
        Sat, 17 Oct 2026 03:42:32 -0700 (PDT)
X-Received: by 2002:a05:600c:4e11:b0:4a1:acaa:c355 with SMTP id 5b1f17b1804b1-4a1d75f252fmr47251675e9.10.1792233752336;
        Sat, 17 Oct 2026 03:42:32 -0700 (PDT)
Received: from ehlo.thunderbird.net ([195.174.135.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd503862sm10597809f8f.46.2026.10.17.03.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Oct 2026 03:42:31 -0700 (PDT)
Date: Sat, 17 Oct 2026 10:42:30 +0000
From: Gabriele Monaco <gmonaco@redhat.com>
To: John Ogness <john.ogness@linutronix.de>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
CC: Nam Cao <namcao@linutronix.de>, Wen Yang <wen.yang@linux.dev>,
 Tobias Schaffner <tobias.schaffner@siemens.com>,
 Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
In-Reply-To: <878q3xtptq.fsf@jogness.linutronix.de>
References: <20261001152042.124445-1-gmonaco@redhat.com> <20261001152042.124445-11-gmonaco@redhat.com> <DLXSI4BSRE5F.1TLKCBUAGNDFQ@gmail.com> <b1fb01e1c58893795dd4be346f233d39fe653aaa.camel@redhat.com> <DM6H7SK4YZ7A.F0MM6C0I77OR@gmail.com> <878q3xtptq.fsf@jogness.linutronix.de>
Message-ID: <8B3FF026-6159-48CF-8FEA-AF2FACD2E4EB@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



Il 16 ottobre 2026 19:20:33 UTC, John Ogness <john=2Eogness@linutronix=2Ed=
e> ha scritto:
>
>I am still not clear how the rv tool will replace the existing in-kernel
>implementation=2E Right now violations call printk(), which conveniently
>show up in kernel logs and consoles=2E More importantly, there are the
>rtapp violation events, which makes it very easy to use ftrace and perf
>features to record traces, take actions, generate statistics, and dump
>backtraces on violations=2E

The plan is to keep everything you'd now do with perf/ftrace as plain stdo=
ut of the RV tool=2E Right now you can see the same ftrace output using rv =
mon <monitor> -t for in-kernel monitors (only deterministic automata)=2E

We are missing stack traces (which I'd optionally add only on errors) and =
perhaps other events (e=2Eg=2E the -e in either tool if you aren't only int=
erested in errors/events of the monitor)=2E

Anything else you may want to do passes through reactors (e=2Eg=2E printk/=
panic or others)=2E See more later=2E

>Is it planned to pull all this out of the kernel but then somehow the rv
>tool allows ftrace, perf, and console to continue to work with
>violations? (For example, by somehow defining kprobes for violations and
>writing violation information to /dev/kmsg?) Or is the rv tool supposed
>to provide its own DIY variant of these features?

My plan isn't particularly strict right now=2E I'm aiming to allow BPF mon=
itors in the user space tool as an exploratory effort=2E
I don't think you would easily interact with ftrace/perf from those though=
=2E

If that's a requirement, you could probably call a kfunc from BPF and atta=
ch a kprobe there=2E I would implement that from a reactor (violations only=
)=2E

For a pure printk reactor, I drafted an implementation that calls directly=
 printk_deferred(), Alexei is suggesting to write to /dev/kmsg from user sp=
ace what BPF passes=2E
Since you were the one suggesting having a real printk, would your use-cas=
e favour either solution? I'd expect some different latency if the log pass=
es from BPF to /dev/kmsg , but I'm not sure that's an issue for you=2E

Gabriele

