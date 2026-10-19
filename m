Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7A04BEE2E
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 10:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792406891; cv=none; b=LuxwnCUrqDUSl7Tn8wnFDrTl43fQ2FwOOnWGkC3t6ABHr8yaGpSQt6J+zDzKZ0VO617O+IiRY4AmTzWgOWzm3468vKHSb7R0wT+mjpLZ5fmCyUbLhaE7GEMKq6BoNx2MDl61KCsDxBHCI9875kASQsMdHYXvzeEzTTAyC+NMBeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792406891; c=relaxed/simple;
	bh=aZBen/HPpNzUGM60bhACqHAzMZBSSHSkr37vTjV9TWY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=arsL+Ixo+3f5wzh0vxpmeeU0BYe08P9XASXjp9BrnVMkkdtKELAonXg2OUBfhnX7Hd5cqQTg2aytGYu0F5DahvMMuH/kf1apngevbjNVLlIv2eoldZhJ3RJNKJEi9CWkEzbJKrLwJv1QhfEBGQqcA3TVY+05i56itkBbw13PMqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JZIV5gEb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aeNsLbww; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JZIV5gEb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aeNsLbww"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792406887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aZBen/HPpNzUGM60bhACqHAzMZBSSHSkr37vTjV9TWY=;
	b=JZIV5gEbrSy0tcWbAFD3DufNgXrQFr0ytTCSn96vND2lScSZGpkyMYBd8ETTYf/hAuzpdw
	zvYHGXxbeTrzSeR7uveqHRd2lCiVzqS3dZcYZGmYBPzaGnDRxvGth4Km7c5N5uVn+nmQAi
	6sYiRXjvFjRdLGM/lex3Lse9qWXuMug=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-5TP_trBdNOu54VwAM-BkjQ-1; Mon, 19 Oct 2026 10:48:05 +0000
X-MC-Unique: 5TP_trBdNOu54VwAM-BkjQ-1
X-Mimecast-MFC-AGG-ID: 5TP_trBdNOu54VwAM-BkjQ_1792406885
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a1d1f26a63so12645555e9.1
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 03:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792406884; x=1793011684; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aZBen/HPpNzUGM60bhACqHAzMZBSSHSkr37vTjV9TWY=;
        b=aeNsLbwwBoIeDLvd1OeyWBae1aNbApaz7t2h62qfJkCSmaUC7mE7CVQCc5G87Bn6ep
         NsVCP6jy5Xe8v595/YeuyuMCbEvh/CS4s/wVRiXVE8XwhOv/Aw1YdkwxVqU9vlf0IS0K
         n8huoKWE+9kqTMseW9/zX4eRGbpOYVX1AwMgSOaPdI3eHzZO7E7dbDAsiG1vw75MJ/jH
         ABI+sgJkvDXYE6kWU+foCmAp5K3+GJf9scsgbRBxcBMzBa4g6UJrX61seHLhOG6wPy77
         OBE0poLvKhQmCA1k1ycbEAoxSkGze7TOq7q4uDxzetDq2jZuo0pLMv19rkLEzOZrfSfy
         ezBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792406884; x=1793011684;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aZBen/HPpNzUGM60bhACqHAzMZBSSHSkr37vTjV9TWY=;
        b=pOgzZm8eoqFC7jC5JbBLuD3j2pbIOvHFD+QaRtSlgwjMiVINCGEnK1VZDqIzl6npM3
         A/Xg0DObhflRpspsWB3vDNUya0xWCrSZLI1kLRRua5wvJabplGuC0gvVdvMPz8LIW2uB
         gJkRbgLYc0G+gLenRjEhdb/gbCree1q5EnBkmQFWzIIU80GC52msDJ0IG1+jXekEkiLw
         5tusAC/+zO3hWtxrSLKlz54K8T7Rmak9As49Z9dqZlKeJnj6BYyouhcWRP50tWew7zxW
         jhamo8fDu74Jf0ZqqxAchJXWv02EX58yW0Pz3N8HC+1huL7KQy9SgEHY+Z+R0JTv4tv8
         VHiA==
X-Forwarded-Encrypted: i=1; AKwUvBxJWGwJtmybkvZPoq2UF0PPLr2a6cdcKzoFe26vHMHVCDgtqg6tU5wQ57sjJXvLfoPiWiY=@vger.kernel.org
X-Gm-Message-State: AFq9FYL2R/I1PYF9pwNxhlwJrko+KyWStFtoOL4I1nGFaPZ/TDVZ02Aq
	i6nnpjZSWHi8kyJJY0mMNBlLPZLFPix4CFvzY4bbyCYOyrvlI4dQ+2CLBM7+/vUaOEchLH3LoP8
	bfNhN960FlvraAFR+OGUwW8C4OMQWyb+EpN2m+ldw6v454oAAuLCVEQ==
X-Gm-Gg: AYBFou3UXhLC0NTgCl8HYGXA20cgc7+MVPBd5+7MybtoBGKCEWV8AEbMz93fsw42F8j
	zrD9NjO/SUw7xgSTuNELUm1wPBvxa1R/pL8Eko8qAfEPxzwwOEbewVj9cFl+H9odMtZXMNOSdso
	IMf22X0wMgw823riaCbUCQHyBi8sp5AmGa2YaNJMkuj9sUoQ6ZyVLmiokYjN5yq0G90uhDTnypO
	pfq7nTn/8YZpFPUvsxitcUE1NNBY63ozigXWVlvQ726yGAw42e9aiYbZidr7C/Fu5DrKRGk+ZkI
	k2bIPfPWZ9VU4XAN9j8OYrLnUpkiDw6XjFh4nwue3IUgkwQO/0zaUHHlOiquCuLoRIjElVY3IR0
	VkBforEvKV5V86n5QIIm/bBk0RQ==
X-Received: by 2002:a05:600c:1f86:b0:4a1:93fd:8f8 with SMTP id 5b1f17b1804b1-4a1d75ab363mr162834495e9.4.1792406884557;
        Mon, 19 Oct 2026 03:48:04 -0700 (PDT)
X-Received: by 2002:a05:600c:1f86:b0:4a1:93fd:8f8 with SMTP id 5b1f17b1804b1-4a1d75ab363mr162834105e9.4.1792406884163;
        Mon, 19 Oct 2026 03:48:04 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.134.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd9b8b5fsm397495935e9.9.2026.10.19.03.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 03:48:03 -0700 (PDT)
Message-ID: <d13e57e312e24b389cb366ede5b3c535ef8f7071.camel@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: John Ogness <john.ogness@linutronix.de>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Steven Rostedt
	 <rostedt@goodmis.org>
Cc: Nam Cao <namcao@linutronix.de>, Wen Yang <wen.yang@linux.dev>, Tobias
 Schaffner <tobias.schaffner@siemens.com>, Viktor Malik <vmalik@redhat.com>
Date: Mon, 19 Oct 2026 12:48:02 +0200
In-Reply-To: <871p9mqcn2.fsf@jogness.linutronix.de>
References: <20261001152042.124445-1-gmonaco@redhat.com>
	 <20261001152042.124445-11-gmonaco@redhat.com>
	 <DLXSI4BSRE5F.1TLKCBUAGNDFQ@gmail.com>
	 <b1fb01e1c58893795dd4be346f233d39fe653aaa.camel@redhat.com>
	 <DM6H7SK4YZ7A.F0MM6C0I77OR@gmail.com>
	 <878q3xtptq.fsf@jogness.linutronix.de>
	 <8B3FF026-6159-48CF-8FEA-AF2FACD2E4EB@redhat.com>
	 <87bj8s8ih9.fsf@jogness.linutronix.de>
	 <b76dfd3e5a118e30ab25910f243db1cbcedc1c00.camel@redhat.com>
	 <871p9mqcn2.fsf@jogness.linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-10-19 at 11:16 +0206, John Ogness wrote:
> On 2026-10-19, Gabriele Monaco <gmonaco@redhat.com> wrote:
> > > > We are missing stack traces (which I'd optionally add only on error=
s)
> > > > and perhaps other events (e.g. the -e in either tool if you aren't
> > > > only interested in errors/events of the monitor).
> > >=20
> > > I don't see the point of reinventing tools that already do the job
> > > well. I do not mind if developers want to create their own tools that
> > > provide some small subset of existing features. But I am concerned
> > > about removing the in-kernel RV support for ftrace and perf.
> >=20
> > That's valid too. We'd need at least the rv tool to start/stop
> > monitors in addition to ftrace/perf. Kind of what you already do now
> > with sysfs.
>=20
> I do not expect the rv tool to start/stop ftrace/perf. Nor would I
> consider that useful. When I am using ftrace/perf, I am interested in
> additionally related events. The rv tool can not know what what else I
> need and I do not want the rv tool to become a wrapper for ftrace/perf.

Yeah of course, I meant more that you need to call both tools (start the mo=
nitor
/and/ the tracing).

At most I'd have a -e flag in rv (just like rtla has, mirroring trace-cmd
functionality).
But you're right, it's best if the other tools can do that first.

>=20
> I would use the rv tool only to start the monitor. It would be enough if
> the tool would report the bpf_trace:bpf_trace_printk globs that are
> needed for the various possible violations. Then, with the monitor
> started, I would start ftrace/perf for my own investigations (also
> capturing any violation events).
>=20

That's an interesting idea actually.

Thanks,
Gabriele

