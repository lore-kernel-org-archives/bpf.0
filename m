Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DF616CD33
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 12:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773317872; cv=pass; b=s4mtSQgklW0KbtzVTO5GlLNEJBt/YBav/qgxgU6seiKswB154kjk3N7GxivLbtkZ1rwhjHx25hX4r7MqN8GU2g2iRlNM7kpkHU/2NgcrhtOLK/nkWT1PG9HOim/5H/FOFBSkip2uNNkuN8xKnm68c/L5qpbfStD51FOD8Vfq9ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773317872; c=relaxed/simple;
	bh=Y8GxjVRD8Apu88bVk/HKLVl5r2+YOiziAVk1c0j/lTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aRuWb7Pf1nRp/LD9M6DH4hQfkGfoa0Cv9XH8G085UeHhdZuvcSAqIy++IVeDS/62SKbEOK89Uimp4bkcu2eUnljsIE4MTvtcqKdieGVGy3d0RlymYaesH6kDgtbP3diPC89mDAagfHlwa7aVTSccF5eX12lMXL+YJHJB+6tOq6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sa+eGfNw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SesaDdOO; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sa+eGfNw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SesaDdOO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773317870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fv/IdyPPMjitQJ9Y48M00/0r4huM0cWU48LQ2/sF1BQ=;
	b=Sa+eGfNwpHaNewKAPTsI7IgWc/89UHn32G2eEQdM2s35qvoJkb9V/QmvydLmv+HkB3GZE3
	zrPp/KRTAfsDSFY+sdyJe9lylhR1yC9ZI1tVWcra2X9cAWDi2MLOAv5FJXv5sn8se+1ZWN
	QR9IWGqbtajKXB33HK6KdWUOE6r4B00=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-WEP-IxqvM8OlO307ojGHtg-1; Thu, 12 Mar 2026 08:17:49 -0400
X-MC-Unique: WEP-IxqvM8OlO307ojGHtg-1
X-Mimecast-MFC-AGG-ID: WEP-IxqvM8OlO307ojGHtg_1773317868
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b96eed52862so159866966b.1
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 05:17:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773317868; cv=none;
        d=google.com; s=arc-20240605;
        b=kpxnq3lip+GdK16I32kyhHCjXMqMwCI0sOpOAUhg3nwhYqRr0lHpIz9W4vyvMoTqct
         3NivAcBBzuKgfV++qrLNfuOco8NoSSzM6MmW/YpzDSszXi/yrxh5GJ7cUjd1PZ7GxbhE
         dd350U3iVAFAXCm/65bbq8Yr8/3DXIzGiIrPZfw3n3IHVesJpzMwGkalZxeEIQPIE1Q+
         1pcsgUcMAymLq2510TSiKyAyWpo8utISbecezrRMytNHCULftACVShJW6QHCytQzSGby
         cr/nD7NRODkYZODgAoYNqR4U8oDZ9F+LJ2hCpFI6Maf1qS1Fm8VQuZLEPczbm9xd9ccE
         YR1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fv/IdyPPMjitQJ9Y48M00/0r4huM0cWU48LQ2/sF1BQ=;
        fh=kgQuPOrPxz3nyJlwdVIm8CKShvy6SCo/ef5G2V7GAvM=;
        b=lgfCAj5P6mC+Q4CjEQ/mVqF394EQXMZnKKrFTt3j7+p8+YxyBIQIWZT9ih7JKzaYCU
         jz2UBgmOcWVM0ERVXkIREmBolAaPOmVpufa38XEEad72O+Yvg3bOS9WUepFZYHo96bnG
         h9vFXaIu2ivcetfEWLKhWQVlg4WjyiHrKQZuuT3rcM4/MtZYn+3pW1b7Yy41so3PHvwm
         DMgQicRazbgaS+hjs5O9R5MSEsLeTnf8a9xsO5N755bTxh3TImMzdaXpPIEGfgdHhz2S
         /TW/y3TzCA+N5lj3LBjunRsWyYHjGLxfJEyb/XaSckE8RI1AwMKvNZwVvGgenJWYNgwo
         YdwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773317868; x=1773922668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fv/IdyPPMjitQJ9Y48M00/0r4huM0cWU48LQ2/sF1BQ=;
        b=SesaDdOOrrCr2kBYEwjEoI5nmO0qOggNbqHLfyZjSqqz4qaxlHQ3ceyzfMLJxPdrV/
         /Z/cZCZNPiV8O/XRDGf0grLNIb/4Xk4QuiEcIxmICxuJgC81x95Yf3I3GZjyQc6/g2Qn
         hjpUInNOqcsMg0IFS1/EGM50bF5mi3JhJCkDWXgdp0Pp7mpm87D3v+ESdaeD8aLycicT
         OtxsbdbON5dKzRA7crlymYJAsmrVmvsbPRslQS3hms2bM590I2k0IbwS+JFHAMAZNOEV
         6uQTLC5kU7tXQyGcov6YSbfrNqXMYxIiVLFXIHMmE5LpBBfxBpryJY9EX/Keun8n6Fxv
         uyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773317868; x=1773922668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fv/IdyPPMjitQJ9Y48M00/0r4huM0cWU48LQ2/sF1BQ=;
        b=UrWdiJRsSsZ16NQmq9K4wc115Y3/EwN3Y59cnLtiMjwGJFQ12K2XYPAEoFfGXu8e7g
         iEboruZkeeR98HeRLZIXcK2yiWadmFnZETFkhNZXYdD1tTkmZtSKBNRd2R3o/WRDQkZx
         Umjx3e+ZYTdT7BDTt9jxykWCZNNt3DRgu0Z6wA5dFaHhBzTYg8gzSakRIf6LDXoVvUMf
         MeEnAiRBH6oTzSzvEUci6lUQylfx5WRMDjlebm9Y4ecZOTcw/ZPCVFIS0Xt5xLFFuDZl
         C9bamLDen9QMBWge+EEfy0aMABNvTYnRjgK9xihXsNx5mWYm3ocnVj7RFrN6JmD5oyky
         0gHA==
X-Forwarded-Encrypted: i=1; AJvYcCUpltip+TvgqKN+FUzjJBtX5lA6sBG9ZrgrgcsLmZAQ4l1oNfQD872WrRghnumhw0hPGec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8DMhmSYiU3tVuuz5vGfeWknnt9NtoVr31kO/zLpffPgAd4MqH
	ZUdj4nxi96tQxfDkg5pEak+5cO7ibGewvl89b1qjWeyFIJonhY6cdlll3ob/J9sdheULIoeukgo
	pzE0NXzKdgUxVHU/mgaodVXRcYEIVi/ZW0ms3JUkTyPMzWQZYV2BvD47uzpIKOyLj61H304enDV
	qPuTzGa2q0DJj3kHY0xLqGA/vSEtyZ
X-Gm-Gg: ATEYQzzKYfHp7BegAfv8U/ryCyIKt4ozPJBZdbdlMrntFR9bqc3Oa+6g5IvhbYUFkjd
	wOVWHPgICGJb0fmPhNJi8yGTNyAs5jItsg1mwZW8kqZKslqxSVFopodYADHuJhuDVY9J0wiYbnI
	YndnITbBwalPxvVj9l3jxWdHGm8ZJTodtQu9X7OtviT5LR8V+QHA54ag6JsODUMdZiR5GsWzKkZ
	GJaYw==
X-Received: by 2002:a17:907:d0e:b0:b96:fbeb:f791 with SMTP id a640c23a62f3a-b972e52dbf3mr344031066b.47.1773317867655;
        Thu, 12 Mar 2026 05:17:47 -0700 (PDT)
X-Received: by 2002:a17:907:d0e:b0:b96:fbeb:f791 with SMTP id
 a640c23a62f3a-b972e52dbf3mr344024766b.47.1773317865935; Thu, 12 Mar 2026
 05:17:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309195040.1019085-1-wander@redhat.com> <20260309195040.1019085-13-wander@redhat.com>
In-Reply-To: <20260309195040.1019085-13-wander@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 12 Mar 2026 13:17:33 +0100
X-Gm-Features: AaiRm506rAH-yhuxCZ_tSpZIAy51Q5ko5bRzudg2PNgMFtqu0BW3sF-mgEVupVk
Message-ID: <CAP4=nvRJXseK41UKN_=r-1LtSF_pMJbPTQ0xuznp9MSMcxx37A@mail.gmail.com>
Subject: Re: [PATCH v4 12/18] rtla: Enforce exact match for time unit suffixes
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Daniel Bristot de Oliveira <bristot@kernel.org>, Daniel Wagner <dwagner@suse.de>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

po 9. 3. 2026 v 20:58 odes=C3=ADlatel Wander Lairson Costa
<wander@redhat.com> napsal:
>
> The parse_ns_duration() function currently uses prefix matching for
> detecting time units. This approach is problematic as it silently
> accepts malformed strings such as "100nsx" or "100us_invalid" by
> ignoring the trailing characters, leading to potential configuration
> errors.
>
> Introduce a match_time_unit() helper that checks the suffix matches
> exactly and is followed by either end-of-string or a ':' delimiter.
> The ':' is needed because parse_ns_duration() is also called from
> get_long_ns_after_colon() when parsing SCHED_DEADLINE priority
> specifications in the format "d:runtime:period" (e.g., "d:10ms:100ms").
>
> A plain strcmp() would reject valid deadline strings because the suffix
> "ms" is followed by ":100ms", not end-of-string. Similarly,
> strncmp_static() would fail because ARRAY_SIZE() includes the NUL
> terminator, making it equivalent to strcmp() for this comparison.
>

This fixes both the command and the corresponding unit test, thanks!

> The match_time_unit() helper solves both problems: it rejects malformed
> input like "100msx" while correctly handling the colon-delimited
> deadline format.
>

It now fails to reject this kind of input:

$  rtla timerlat -P d:10ms:100ms:somethingsomething
// this is also parsed as valid

But that can be fixed in a future patchset, perhaps together with also migr=
ating
parse_seconds_duration() from prefix matching to match_time_unit() as well.

That would prevent the same imprecise parsing issue for -d:

$ rtla timerlat -d 1somethingsomething
// this is also parsed as valid

Tomas

